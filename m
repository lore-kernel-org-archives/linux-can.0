From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: janz-ican3: fix support for CAN_RAW_RECV_OWN_MSGS
Date: Wed, 18 Jul 2012 01:09:57 +0200
Message-ID: <5005F0C5.7010109@pengutronix.de>
References: <4FFFE3AF.4020907@pengutronix.de> <1342192830-31538-1-git-send-email-iws@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2278EA3BBFC8D78CE67C02CE"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51984 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962Ab2GQXKH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Jul 2012 19:10:07 -0400
In-Reply-To: <1342192830-31538-1-git-send-email-iws@ovro.caltech.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2278EA3BBFC8D78CE67C02CE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/13/2012 05:20 PM, Ira W. Snyder wrote:
> From: "Ira W. Snyder" <iws@ovro.caltech.edu>
>=20
> The Janz VMOD-ICAN3 firmware does not support any sort of TX-done
> notification or interrupt. The driver previously used the hardware
> loopback to attempt to work around this deficiency, but this caused all=

> sockets to receive all messages, even if CAN_RAW_RECV_OWN_MSGS is off.
>=20
> Using the new function ican3_cmp_echo_skb(), we can drop the loopback
> messages and return the original skbs. This fixes the issues with
> CAN_RAW_RECV_OWN_MSGS.
>=20
> A private skb queue is used to store the echo skbs. This avoids the nee=
d
> for any index management.
>=20
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> ---
>=20
> This is a squashed together version of the first two patches in the ser=
ies.
>=20
>  drivers/net/can/janz-ican3.c |  156 ++++++++++++++++++++++++++++++++++=
+-------
>  1 files changed, 130 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.=
c
> index 08c893c..5fff829 100644
> --- a/drivers/net/can/janz-ican3.c
> +++ b/drivers/net/can/janz-ican3.c
> @@ -220,6 +220,9 @@ struct ican3_dev {
>  	/* old and new style host interface */
>  	unsigned int iftype;
> =20
> +	/* queue for echo packets */
> +	struct sk_buff_head echoq;
> +
>  	/*
>  	 * Any function which changes the current DPM page must hold this
>  	 * lock while it is performing data accesses. This ensures that the
> @@ -235,7 +238,6 @@ struct ican3_dev {
> =20
>  	/* fast host interface */
>  	unsigned int fastrx_start;
> -	unsigned int fastrx_int;
>  	unsigned int fastrx_num;
>  	unsigned int fasttx_start;
>  	unsigned int fasttx_num;
> @@ -454,7 +456,6 @@ static void __devinit ican3_init_fast_host_interfac=
e(struct ican3_dev *mod)
>  	/* save the start recv page */
>  	mod->fastrx_start =3D mod->free_page;
>  	mod->fastrx_num =3D 0;
> -	mod->fastrx_int =3D 0;
> =20
>  	/* build a single fast tohost queue descriptor */
>  	memset(&desc, 0, sizeof(desc));
> @@ -1091,6 +1092,87 @@ static void ican3_handle_message(struct ican3_de=
v *mod, struct ican3_msg *msg)
>  }
> =20
>  /*
> + * The ican3 needs to store all echo skbs, and therefore cannot
> + * use the generic infrastructure for this.
> + */
> +static void ican3_put_echo_skb(struct ican3_dev *mod, struct sk_buff *=
skb)
> +{
> +	struct sock *srcsk =3D skb->sk;
> +
> +	if (atomic_read(&skb->users) !=3D 1) {
> +		struct sk_buff *old_skb =3D skb;
> +
> +		skb =3D skb_clone(old_skb, GFP_ATOMIC);
> +		kfree_skb(old_skb);
> +		if (!skb)
> +			return;
> +	} else
> +		skb_orphan(skb);

Please use { } on else, too

> +
> +	skb->sk =3D srcsk;
> +
> +	/* save this skb for tx interrupt echo handling */
> +	skb_queue_tail(&mod->echoq, skb);
> +}
> +
> +static unsigned int ican3_get_echo_skb(struct ican3_dev *mod)
> +{
> +	struct sk_buff *skb =3D skb_dequeue(&mod->echoq);
> +	struct can_frame *cf;
> +	u8 dlc;
> +
> +	if (!skb)
> +		return 0;
> +
> +	/* check flag whether this packet has to be looped back */
> +	if (!(mod->ndev->flags & IFF_ECHO) || skb->pkt_type !=3D PACKET_LOOPB=
ACK) {
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^

Your flags have a IFF_ECHO, don't they?

> +		kfree_skb(skb);
> +		return 0;

please return here the dlc here, too.

> +	}
> +
> +	/* make settings for echo to reduce code in irq context */
> +	skb->protocol =3D htons(ETH_P_CAN);
> +	skb->pkt_type =3D PACKET_BROADCAST;
> +	skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> +	skb->dev =3D mod->ndev;
> +
> +	cf =3D (struct can_frame *)skb->data;
> +	dlc =3D cf->can_dlc;
> +	netif_receive_skb(skb);
> +
> +	return dlc;
> +}
> +
> +/*
> + * Compare an skb with an existing echo skb
> + *
> + * This function will be used on devices which have a hardware loopbac=
k.
> + * On these devices, this function can be used to compare a received s=
kb
> + * with the saved echo skbs so that the hardware echo skb can be dropp=
ed.
> + *
> + * Returns true if the skb's are identical, false otherwise.
> + */
> +static bool ican3_cmp_echo_skb(struct ican3_dev *mod, struct sk_buff *=
skb)
> +{
> +	struct can_frame *cf =3D (struct can_frame *)skb->data;
> +	struct sk_buff *echo_skb =3D skb_peek(&mod->echoq);
> +
> +	if (echo_skb) {
> +		struct can_frame *echo_cf =3D (struct can_frame *)echo_skb->data;
> +
> +		if (cf->can_id !=3D echo_cf->can_id)
> +			return false;
> +
> +		if (cf->can_dlc !=3D echo_cf->can_dlc)
> +			return false;
> +
> +		return memcmp(cf->data, echo_cf->data, cf->can_dlc) =3D=3D 0;
> +	}

Please restructure like this (more common coding style):

	if (!echo_skb)
		return false

	...
> +
> +	return false;
> +}
> +
> +/*
>   * Check that there is room in the TX ring to transmit another skb
>   *
>   * LOCKING: must hold mod->lock
> @@ -1100,6 +1182,10 @@ static bool ican3_txok(struct ican3_dev *mod)
>  	struct ican3_fast_desc __iomem *desc;
>  	u8 control;
> =20
> +	/* check that we have echo queue space */
> +	if (skb_queue_len(&mod->echoq) >=3D ICAN3_TX_BUFFERS)
> +		return false;
> +
>  	/* copy the control bits of the descriptor */
>  	ican3_set_page(mod, mod->fasttx_start + (mod->fasttx_num / 16));
>  	desc =3D mod->dpm + ((mod->fasttx_num % 16) * sizeof(*desc));
> @@ -1150,10 +1236,27 @@ static int ican3_recv_skb(struct ican3_dev *mod=
)
>  	/* convert the ICAN3 frame into Linux CAN format */
>  	ican3_to_can_frame(mod, &desc, cf);
> =20
> -	/* receive the skb, update statistics */
> -	netif_receive_skb(skb);
> +	/*
> +	 * If this is an ECHO frame received from the hardware loopback
> +	 * feature, use the skb saved in the ECHO stack instead. This allows
> +	 * the Linux CAN core to support CAN_RAW_RECV_OWN_MSGS correctly.
> +	 *
> +	 * Since this is a confirmation of a successfully transmitted packet
> +	 * sent from this host, update the transmit statistics.
> +	 *
> +	 * Also, the netdevice queue needs to be allowed to send packets agai=
n.
> +	 */
> +	if (ican3_cmp_echo_skb(mod, skb)) {
> +		stats->tx_packets++;
> +		stats->tx_bytes +=3D ican3_get_echo_skb(mod);
> +		kfree_skb(skb);
> +		goto err_noalloc;
> +	}
> +
> +	/* update statistics, receive the skb */
>  	stats->rx_packets++;
>  	stats->rx_bytes +=3D cf->can_dlc;
> +	netif_receive_skb(skb);
> =20
>  err_noalloc:
>  	/* toggle the valid bit and return the descriptor to the ring */
> @@ -1176,13 +1279,13 @@ err_noalloc:
>  static int ican3_napi(struct napi_struct *napi, int budget)
>  {
>  	struct ican3_dev *mod =3D container_of(napi, struct ican3_dev, napi);=

> -	struct ican3_msg msg;
>  	unsigned long flags;
>  	int received =3D 0;
>  	int ret;
> =20
>  	/* process all communication messages */
>  	while (true) {
> +		struct ican3_msg msg;
>  		ret =3D ican3_recv_msg(mod, &msg);
>  		if (ret)
>  			break;
> @@ -1199,11 +1302,6 @@ static int ican3_napi(struct napi_struct *napi, =
int budget)
>  		received++;
>  	}
> =20
> -	/* We have processed all packets that the adapter had, but it
> -	 * was less than our budget, stop polling */
> -	if (received < budget)
> -		napi_complete(napi);
> -
>  	spin_lock_irqsave(&mod->lock, flags);
> =20
>  	/* Wake up the transmit queue if necessary */
> @@ -1212,6 +1310,11 @@ static int ican3_napi(struct napi_struct *napi, =
int budget)
> =20
>  	spin_unlock_irqrestore(&mod->lock, flags);
> =20
> +	/* We have processed all packets that the adapter had, but it
> +	 * was less than our budget, stop polling */

Nitpick: preferred multi line commenting style is:

/*
 * comments...
 * ..more
 */
> +	if (received < budget)
> +		napi_complete(napi);
> +

Why are you moving the napi_complete?

>  	/* re-enable interrupt generation */
>  	iowrite8(1 << mod->num, &mod->ctrl->int_enable);
>  	return received;
> @@ -1408,6 +1511,9 @@ static int ican3_stop(struct net_device *ndev)
>  		return ret;
>  	}
> =20
> +	/* drop all outstanding echo skbs */
> +	skb_queue_purge(&mod->echoq);
> +
>  	/* close the CAN layer */
>  	close_candev(ndev);
>  	return 0;
> @@ -1416,18 +1522,19 @@ static int ican3_stop(struct net_device *ndev)
>  static int ican3_xmit(struct sk_buff *skb, struct net_device *ndev)
>  {
>  	struct ican3_dev *mod =3D netdev_priv(ndev);
> -	struct net_device_stats *stats =3D &ndev->stats;
>  	struct can_frame *cf =3D (struct can_frame *)skb->data;
>  	struct ican3_fast_desc desc;
>  	void __iomem *desc_addr;
>  	unsigned long flags;
> =20
> +	if (can_dropped_invalid_skb(ndev, skb))
> +		return NETDEV_TX_OK;
> +
>  	spin_lock_irqsave(&mod->lock, flags);
> =20
>  	/* check that we can actually transmit */
>  	if (!ican3_txok(mod)) {
> -		dev_err(mod->dev, "no free descriptors, stopping queue\n");
> -		netif_stop_queue(ndev);
> +		dev_err(mod->dev, "BUG: no free descriptors\n");
>  		spin_unlock_irqrestore(&mod->lock, flags);
>  		return NETDEV_TX_BUSY;
>  	}
> @@ -1442,6 +1549,14 @@ static int ican3_xmit(struct sk_buff *skb, struc=
t net_device *ndev)
>  	can_frame_to_ican3(mod, cf, &desc);
> =20
>  	/*
> +	 * This hardware doesn't have TX-done notifications, so we'll try and=

> +	 * emulate it the best we can using ECHO skbs. Add the skb to the ECH=
O
> +	 * stack. Upon packet reception, check if the ECHO skb and received
> +	 * skb match, and use that to wake the queue.
> +	 */
> +	ican3_put_echo_skb(mod, skb);
> +
> +	/*
>  	 * the programming manual says that you must set the IVALID bit, then=

>  	 * interrupt, then set the valid bit. Quite weird, but it seems to be=

>  	 * required for this to work
> @@ -1459,19 +1574,7 @@ static int ican3_xmit(struct sk_buff *skb, struc=
t net_device *ndev)
>  	mod->fasttx_num =3D (desc.control & DESC_WRAP) ? 0
>  						     : (mod->fasttx_num + 1);
> =20
> -	/* update statistics */
> -	stats->tx_packets++;
> -	stats->tx_bytes +=3D cf->can_dlc;
> -	kfree_skb(skb);
> -
> -	/*
> -	 * This hardware doesn't have TX-done notifications, so we'll try and=

> -	 * emulate it the best we can using ECHO skbs. Get the next TX
> -	 * descriptor, and see if we have room to send. If not, stop the queu=
e.
> -	 * It will be woken when the ECHO skb for the current packet is recv'=
d.
> -	 */
> -
> -	/* copy the control bits of the descriptor */
> +	/* if there is no free descriptor space, stop the transmit queue */
>  	if (!ican3_txok(mod))
>  		netif_stop_queue(ndev);
> =20
> @@ -1667,6 +1770,7 @@ static int __devinit ican3_probe(struct platform_=
device *pdev)
>  	mod->dev =3D &pdev->dev;
>  	mod->num =3D pdata->modno;
>  	netif_napi_add(ndev, &mod->napi, ican3_napi, ICAN3_RX_BUFFERS);
> +	skb_queue_head_init(&mod->echoq);
>  	spin_lock_init(&mod->lock);
>  	init_completion(&mod->termination_comp);
>  	init_completion(&mod->buserror_comp);

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig2278EA3BBFC8D78CE67C02CE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAF8MoACgkQjTAFq1RaXHO9ZQCcC+Uk9H1Jqwj3ww5+OVS4Vx94
w0MAoJX0Ax4xB6BujZpmT6vezLvoe9gT
=chEX
-----END PGP SIGNATURE-----

--------------enig2278EA3BBFC8D78CE67C02CE--
