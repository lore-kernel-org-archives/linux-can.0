From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 4/6] can: janz-ican3: fix support for CAN_RAW_RECV_OWN_MSGS
Date: Thu, 19 Jul 2012 10:33:47 +0200
Message-ID: <5007C66B.2020404@pengutronix.de>
References: <1342650798-2991-1-git-send-email-iws@ovro.caltech.edu> <1342650798-2991-5-git-send-email-iws@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1260B4FF03BFA6E9CDAE27D9"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54456 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471Ab2GSIdz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 19 Jul 2012 04:33:55 -0400
In-Reply-To: <1342650798-2991-5-git-send-email-iws@ovro.caltech.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1260B4FF03BFA6E9CDAE27D9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/19/2012 12:33 AM, Ira W. Snyder wrote:
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
> Due to a lack of TX-error interrupts, bus errors are permanently
> enabled, and are used as a TX-error notification. This is used to drop
> an echo skb when transmission fails. Bus error packets are not generate=
d
> if the user has not enabled bus error reporting.
>=20
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>

Nitpicks inline, otherwise looks good.

Marc

> ---
>  drivers/net/can/janz-ican3.c |  199 ++++++++++++++++++++++++++++++++--=
--------
>  1 files changed, 154 insertions(+), 45 deletions(-)
>=20
> diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.=
c
> index d9d4ed1..1304712 100644
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
> @@ -924,7 +927,7 @@ static int ican3_handle_cevtind(struct ican3_dev *m=
od, struct ican3_msg *msg)
>  	struct net_device *dev =3D mod->ndev;
>  	struct net_device_stats *stats =3D &dev->stats;
>  	enum can_state state =3D mod->can.state;
> -	u8 status, isrc, rxerr, txerr;
> +	u8 isrc, ecc, status, rxerr, txerr;
>  	struct can_frame *cf;
>  	struct sk_buff *skb;
> =20
> @@ -940,15 +943,42 @@ static int ican3_handle_cevtind(struct ican3_dev =
*mod, struct ican3_msg *msg)
>  		return -EINVAL;
>  	}
> =20
> -	skb =3D alloc_can_err_skb(dev, &cf);
> -	if (skb =3D=3D NULL)
> -		return -ENOMEM;
> -
>  	isrc =3D msg->data[0];
> +	ecc =3D msg->data[2];
>  	status =3D msg->data[3];
>  	rxerr =3D msg->data[4];
>  	txerr =3D msg->data[5];
> =20
> +	/*
> +	 * This hardware lacks any support other than bus error messages to
> +	 * determine if packet transmission has failed.
> +	 *
> +	 * When TX errors happen, one echo skb needs to be dropped from the
> +	 * front of the queue.
> +	 *
> +	 * A small bit of code is duplicated here and below, to avoid error
> +	 * skb allocation when it will just be freed immediately.
> +	 */
> +	if (isrc =3D=3D CEVTIND_BEI) {
> +		dev_dbg(mod->dev, "bus error interrupt, part 1\n");

nitpick: I would drop the ", part 1".

> +
> +		/* TX error */
> +		if (!(ecc & ECC_DIR)) {
> +			kfree_skb(skb_dequeue(&mod->echoq));
> +			stats->tx_errors++;
> +		} else {
> +			stats->rx_errors++;
> +		}
> +
> +		/* bus error reporting is off, return immediately */
> +		if (!(mod->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
> +			return 0;
> +	}
> +
> +	skb =3D alloc_can_err_skb(dev, &cf);
> +	if (skb =3D=3D NULL)
> +		return -ENOMEM;
> +
>  	/* data overrun interrupt */
>  	if (isrc =3D=3D CEVTIND_DOI || isrc =3D=3D CEVTIND_LOST) {
>  		dev_dbg(mod->dev, "data overrun interrupt\n");
> @@ -976,9 +1006,8 @@ static int ican3_handle_cevtind(struct ican3_dev *=
mod, struct ican3_msg *msg)
> =20
>  	/* bus error interrupt */
>  	if (isrc =3D=3D CEVTIND_BEI) {
> -		u8 ecc =3D msg->data[2];
> +		dev_dbg(mod->dev, "bus error interrupt, part 2\n");
> =20
> -		dev_dbg(mod->dev, "bus error interrupt\n");

I would remove the debug message here completely.

>  		mod->can.can_stats.bus_error++;
>  		cf->can_id |=3D CAN_ERR_PROT | CAN_ERR_BUSERROR;
> =20
> @@ -998,12 +1027,8 @@ static int ican3_handle_cevtind(struct ican3_dev =
*mod, struct ican3_msg *msg)
>  			break;
>  		}
> =20
> -		if (!(ecc & ECC_DIR)) {
> +		if (!(ecc & ECC_DIR))
>  			cf->data[2] |=3D CAN_ERR_PROT_TX;
> -			stats->tx_errors++;
> -		} else {
> -			stats->rx_errors++;
> -		}
> =20
>  		cf->data[6] =3D txerr;
>  		cf->data[7] =3D rxerr;
> @@ -1088,6 +1113,85 @@ static void ican3_handle_message(struct ican3_de=
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
> +	} else {
> +		skb_orphan(skb);
> +	}
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

Have you tested if this happens? It should now. Maybe add a netdev_err
or a pr_err_once here?

> +
> +	cf =3D (struct can_frame *)skb->data;
> +	dlc =3D cf->can_dlc;
> +
> +	/* check flag whether this packet has to be looped back */
> +	if (skb->pkt_type !=3D PACKET_LOOPBACK) {
> +		kfree_skb(skb);
> +		return dlc;
> +	}
> +
> +	skb->protocol =3D htons(ETH_P_CAN);
> +	skb->pkt_type =3D PACKET_BROADCAST;
> +	skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> +	skb->dev =3D mod->ndev;
> +	netif_receive_skb(skb);
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
> +static bool ican3_echo_skb_matches(struct ican3_dev *mod, struct sk_bu=
ff *skb)
> +{
> +	struct can_frame *cf =3D (struct can_frame *)skb->data;
> +	struct sk_buff *echo_skb =3D skb_peek(&mod->echoq);
> +	struct can_frame *echo_cf;
> +
> +	if (!echo_skb)
> +		return false;
> +
> +	echo_cf =3D (struct can_frame *)echo_skb->data;
> +	if (cf->can_id !=3D echo_cf->can_id)
> +		return false;
> +
> +	if (cf->can_dlc !=3D echo_cf->can_dlc)
> +		return false;
> +
> +	return memcmp(cf->data, echo_cf->data, cf->can_dlc) =3D=3D 0;
> +}
> +
> +/*
>   * Check that there is room in the TX ring to transmit another skb
>   *
>   * LOCKING: must hold mod->lock
> @@ -1097,6 +1201,10 @@ static bool ican3_txok(struct ican3_dev *mod)
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
> @@ -1147,10 +1255,27 @@ static int ican3_recv_skb(struct ican3_dev *mod=
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
> +	if (ican3_echo_skb_matches(mod, skb)) {
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
> @@ -1173,13 +1298,13 @@ err_noalloc:
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
> @@ -1351,7 +1476,6 @@ static int __devinit ican3_startup_module(struct =
ican3_dev *mod)
>  static int ican3_open(struct net_device *ndev)
>  {
>  	struct ican3_dev *mod =3D netdev_priv(ndev);
> -	u8 quota;
>  	int ret;
> =20
>  	/* open the CAN layer */
> @@ -1361,19 +1485,6 @@ static int ican3_open(struct net_device *ndev)
>  		return ret;
>  	}
> =20
> -	/* set the bus error generation state appropriately */
> -	if (mod->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
> -		quota =3D ICAN3_BUSERR_QUOTA_MAX;
> -	else
> -		quota =3D 0;
> -
> -	ret =3D ican3_set_buserror(mod, quota);
> -	if (ret) {
> -		dev_err(mod->dev, "unable to set bus-error\n");
> -		close_candev(ndev);
> -		return ret;
> -	}
> -
>  	/* bring the bus online */
>  	ret =3D ican3_set_bus_state(mod, true);
>  	if (ret) {
> @@ -1405,6 +1516,9 @@ static int ican3_stop(struct net_device *ndev)
>  		return ret;
>  	}
> =20
> +	/* drop all outstanding echo skbs */
> +	skb_queue_purge(&mod->echoq);
> +
>  	/* close the CAN layer */
>  	close_candev(ndev);
>  	return 0;
> @@ -1413,7 +1527,6 @@ static int ican3_stop(struct net_device *ndev)
>  static int ican3_xmit(struct sk_buff *skb, struct net_device *ndev)
>  {
>  	struct ican3_dev *mod =3D netdev_priv(ndev);
> -	struct net_device_stats *stats =3D &ndev->stats;
>  	struct can_frame *cf =3D (struct can_frame *)skb->data;
>  	struct ican3_fast_desc desc;
>  	void __iomem *desc_addr;
> @@ -1426,8 +1539,7 @@ static int ican3_xmit(struct sk_buff *skb, struct=
 net_device *ndev)
> =20
>  	/* check that we can actually transmit */
>  	if (!ican3_txok(mod)) {
> -		dev_err(mod->dev, "no free descriptors, stopping queue\n");
> -		netif_stop_queue(ndev);
> +		dev_err(mod->dev, "BUG: no free descriptors\n");
>  		spin_unlock_irqrestore(&mod->lock, flags);
>  		return NETDEV_TX_BUSY;
>  	}
> @@ -1442,6 +1554,14 @@ static int ican3_xmit(struct sk_buff *skb, struc=
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
> @@ -1459,19 +1579,7 @@ static int ican3_xmit(struct sk_buff *skb, struc=
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
> @@ -1667,6 +1775,7 @@ static int __devinit ican3_probe(struct platform_=
device *pdev)
>  	mod->dev =3D &pdev->dev;
>  	mod->num =3D pdata->modno;
>  	netif_napi_add(ndev, &mod->napi, ican3_napi, ICAN3_RX_BUFFERS);
> +	skb_queue_head_init(&mod->echoq);
>  	spin_lock_init(&mod->lock);
>  	init_completion(&mod->termination_comp);
>  	init_completion(&mod->buserror_comp);


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig1260B4FF03BFA6E9CDAE27D9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAHxm8ACgkQjTAFq1RaXHMlKgCgjMdH0Eb1N25+/sUDYSU7YHaM
azoAn0B2bMJ0aZoHNOtOzNDBVAIt+8Q3
=/NuR
-----END PGP SIGNATURE-----

--------------enig1260B4FF03BFA6E9CDAE27D9--
