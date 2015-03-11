From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 2/3] can: kvaser_usb: Utilize all possible tx URBs
Date: Wed, 11 Mar 2015 22:53:28 +0100
Message-ID: <5500B958.2020101@pengutronix.de>
References: <20150226152011.GA6075@linux> <20150311173744.GA13095@linux> <20150311173902.GB13095@linux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="4t0unP89CPTvTUIC9gFah9tcMPJT3fqRQ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60604 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbbCKVxi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Mar 2015 17:53:38 -0400
In-Reply-To: <20150311173902.GB13095@linux>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ahmed S. Darwish" <darwish.07@gmail.com>, Olivier Sobrie <olivier@sobrie.be>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, Andri Yngvason <andri.yngvason@marel.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4t0unP89CPTvTUIC9gFah9tcMPJT3fqRQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/11/2015 06:39 PM, Ahmed S. Darwish wrote:
> From: Ahmed S. Darwish <ahmed.darwish@valeo.com>
>=20
> The driver currently limits the number of outstanding, not yet
> ACKed, transfers to 16 URBs. Meanwhile, the Kvaser firmware
> provides its actual max supported number of outstanding
> transmissions in its reply to the CMD_GET_SOFTWARE_INFO message.
>=20
> One example is the UsbCan-II HS/LS device which reports support
> of up to 48 tx URBs instead of just 16, increasing the driver
> throughput by two-fold and reducing the possibility of -ENOBUFs.
>=20
> Dynamically set the max tx URBs value according to firmware
> replies.
>=20
> Signed-off-by: Ahmed S. Darwish <ahmed.darwish@valeo.com>
> ---
>  drivers/net/can/usb/kvaser_usb.c | 55 +++++++++++++++++++++++++++-----=
--------
>  1 file changed, 37 insertions(+), 18 deletions(-)
>=20
> changelog-v3: No changes
>=20
> diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kva=
ser_usb.c
> index e97a08c..30b4d47 100644
> --- a/drivers/net/can/usb/kvaser_usb.c
> +++ b/drivers/net/can/usb/kvaser_usb.c
> @@ -25,7 +25,6 @@
>  #include <linux/can/dev.h>
>  #include <linux/can/error.h>
> =20
> -#define MAX_TX_URBS			16
>  #define MAX_RX_URBS			4
>  #define START_TIMEOUT			1000 /* msecs */
>  #define STOP_TIMEOUT			1000 /* msecs */
> @@ -456,8 +455,13 @@ struct kvaser_usb {
>  	struct usb_endpoint_descriptor *bulk_in, *bulk_out;
>  	struct usb_anchor rx_submitted;
> =20
> +	/* @max_tx_urbs: Firmware-reported maximum number of possible
> +	 * outstanding transmissions on this specific Kvaser hardware. The
> +	 * value is also used as a sentinel for marking free URB contexts.
> +	 */
>  	u32 fw_version;
>  	unsigned int nchannels;
> +	unsigned int max_tx_urbs;
>  	enum kvaser_usb_family family;
> =20
>  	bool rxinitdone;
> @@ -470,7 +474,7 @@ struct kvaser_usb_net_priv {
> =20
>  	spinlock_t tx_contexts_lock;
>  	int active_tx_contexts;
> -	struct kvaser_usb_tx_urb_context tx_contexts[MAX_TX_URBS];
> +	struct kvaser_usb_tx_urb_context *tx_contexts;
> =20
>  	struct usb_anchor tx_submitted;
>  	struct completion start_comp, stop_comp;
> @@ -657,9 +661,13 @@ static int kvaser_usb_get_software_info(struct kva=
ser_usb *dev)
>  	switch (dev->family) {
>  	case KVASER_LEAF:
>  		dev->fw_version =3D le32_to_cpu(msg.u.leaf.softinfo.fw_version);
> +		dev->max_tx_urbs =3D
> +			le16_to_cpu(msg.u.leaf.softinfo.max_outstanding_tx);
>  		break;
>  	case KVASER_USBCAN:
>  		dev->fw_version =3D le32_to_cpu(msg.u.usbcan.softinfo.fw_version);
> +		dev->max_tx_urbs =3D
> +			le16_to_cpu(msg.u.usbcan.softinfo.max_outstanding_tx);
>  		break;
>  	}
> =20
> @@ -715,7 +723,7 @@ static void kvaser_usb_tx_acknowledge(const struct =
kvaser_usb *dev,
> =20
>  	stats =3D &priv->netdev->stats;
> =20
> -	context =3D &priv->tx_contexts[tid % MAX_TX_URBS];
> +	context =3D &priv->tx_contexts[tid % dev->max_tx_urbs];
> =20
>  	/* Sometimes the state change doesn't come after a bus-off event */
>  	if (priv->can.restart_ms &&
> @@ -744,7 +752,7 @@ static void kvaser_usb_tx_acknowledge(const struct =
kvaser_usb *dev,
>  	spin_lock_irqsave(&priv->tx_contexts_lock, flags);
> =20
>  	can_get_echo_skb(priv->netdev, context->echo_index);
> -	context->echo_index =3D MAX_TX_URBS;
> +	context->echo_index =3D dev->max_tx_urbs;
>  	--priv->active_tx_contexts;
>  	netif_wake_queue(priv->netdev);
> =20
> @@ -1512,11 +1520,13 @@ error:
> =20
>  static void kvaser_usb_reset_tx_urb_contexts(struct kvaser_usb_net_pri=
v *priv)
>  {
> -	int i;
> +	int i, max_tx_urbs;
> +
> +	max_tx_urbs =3D priv->dev->max_tx_urbs;
> =20
>  	priv->active_tx_contexts =3D 0;
> -	for (i =3D 0; i < MAX_TX_URBS; i++)
> -		priv->tx_contexts[i].echo_index =3D MAX_TX_URBS;
> +	for (i =3D 0; i < max_tx_urbs; i++)
> +		priv->tx_contexts[i].echo_index =3D max_tx_urbs;
>  }
> =20
>  /* This method might sleep. Do not call it in the atomic context
> @@ -1702,14 +1712,14 @@ static netdev_tx_t kvaser_usb_start_xmit(struct=
 sk_buff *skb,
>  		*msg_tx_can_flags |=3D MSG_FLAG_REMOTE_FRAME;
> =20
>  	spin_lock_irqsave(&priv->tx_contexts_lock, flags);
> -	for (i =3D 0; i < ARRAY_SIZE(priv->tx_contexts); i++) {
> -		if (priv->tx_contexts[i].echo_index =3D=3D MAX_TX_URBS) {
> +	for (i =3D 0; i < dev->max_tx_urbs; i++) {
> +		if (priv->tx_contexts[i].echo_index =3D=3D dev->max_tx_urbs) {
>  			context =3D &priv->tx_contexts[i];
> =20
>  			context->echo_index =3D i;
>  			can_put_echo_skb(skb, netdev, context->echo_index);
>  			++priv->active_tx_contexts;
> -			if (priv->active_tx_contexts >=3D MAX_TX_URBS)
> +			if (priv->active_tx_contexts >=3D dev->max_tx_urbs)
>  				netif_stop_queue(netdev);
> =20
>  			break;
> @@ -1743,7 +1753,7 @@ static netdev_tx_t kvaser_usb_start_xmit(struct s=
k_buff *skb,
>  		spin_lock_irqsave(&priv->tx_contexts_lock, flags);
> =20
>  		can_free_echo_skb(netdev, context->echo_index);
> -		context->echo_index =3D MAX_TX_URBS;
> +		context->echo_index =3D dev->max_tx_urbs;
>  		--priv->active_tx_contexts;
>  		netif_wake_queue(netdev);
> =20
> @@ -1881,7 +1891,7 @@ static int kvaser_usb_init_one(struct usb_interfa=
ce *intf,
>  	if (err)
>  		return err;
> =20
> -	netdev =3D alloc_candev(sizeof(*priv), MAX_TX_URBS);
> +	netdev =3D alloc_candev(sizeof(*priv), dev->max_tx_urbs);
>  	if (!netdev) {
>  		dev_err(&intf->dev, "Cannot alloc candev\n");
>  		return -ENOMEM;
> @@ -1889,6 +1899,13 @@ static int kvaser_usb_init_one(struct usb_interf=
ace *intf,
> =20
>  	priv =3D netdev_priv(netdev);
> =20
> +	priv->tx_contexts =3D kzalloc(dev->max_tx_urbs *
> +				    sizeof(*priv->tx_contexts), GFP_KERNEL);
> +	if (!priv->tx_contexts) {
> +		free_candev(netdev);
> +		return -ENOMEM;
> +	}

I'm missing a free for the priv->tx_contexts. I see two options:

1) use devm_kzalloc(), or
2) move struct kvaser_usb_tx_urb_context tx_contexts[]; to the end of
   struct kvaser_usb_net_priv, see [1] for an example.

   Without further testing, I think the correct alloc for that case
   would be:
       alloc_candev(sizeof(*priv + dev->max_tx_urbs *
               sizeof(struct kvaser_usb_tx_urb_context))

Marc

[1] http://stackoverflow.com/questions/2060974/dynamic-array-in-struct-c

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--4t0unP89CPTvTUIC9gFah9tcMPJT3fqRQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVALlbAAoJECte4hHFiupU5CQQAIZalz/TcS7x5qmJ0Zpai+aC
f2oEy8PmzSSDt5FPyo0s1STI8jvD3gC5x/OBIYbPnzoKXOM7GReaaoebMQZZ7Rjj
hQb4pYiaH2Yw8Ld17Y48gL0/xn3meWIjxrd+XUnxJ5BklKkXc+bRDc8kEQ9kSiYE
D8GEVRr+hWOEjGNhEFSwx5hkwEWNCxUBC9RIOj7LwjurhdIMo26izS762W+7IP/m
O2H/08s4zTrC67EkExFOhpj4NOcZ8AcLAi5PKb2H8LwMK2s/DTh2na6DieNI/Pkk
YK1hOm9f8oqYRUQRhsiGa3hpUc3sFEjaWnkp8nMSnH2KSsJkZALkvqetmEapWxeH
K1hOfGwDnCmbSA0PMYA54im2f8VUs456DEhvfO44ZduUPES45U5JrqIQwRosw+yE
KV4cqHX+2yvutjX4b8DyJorURvsYRns9/wguu8MsMnBIlcRW7KiK18/64XwUnHIH
c4YzWwG9z3E624sm1rpnIxlibV0o9QLdxkPgtc9gghgx4GxTrc92IZlSXYneHnhf
KklsjYtS2jUrOzcJO99NvSxvA5kYcvA9+87ya1RfkHVV1oXxFwfEWUd75T3CKwKu
R7351u6+jdYLuWAzoAp29dIJQJRvKDvcwwI7K2IsvO7heTYZgUR/hFgH46F4OV0F
GT1Qq41c6oDmN96NISlj
=MzeL
-----END PGP SIGNATURE-----

--4t0unP89CPTvTUIC9gFah9tcMPJT3fqRQ--
