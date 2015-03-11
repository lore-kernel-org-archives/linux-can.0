From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 1/3] can: kvaser_usb: Fix tx queue start/stop
 race conditions
Date: Wed, 11 Mar 2015 22:43:07 +0100
Message-ID: <5500B6EB.8050905@pengutronix.de>
References: <20150226152011.GA6075@linux> <20150311173744.GA13095@linux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="4eWjI61xhgXXlbAQBSfixRsVGtfkp9gRc"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44451 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbbCKVnS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Mar 2015 17:43:18 -0400
In-Reply-To: <20150311173744.GA13095@linux>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ahmed S. Darwish" <darwish.07@gmail.com>, Olivier Sobrie <olivier@sobrie.be>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, Andri Yngvason <andri.yngvason@marel.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4eWjI61xhgXXlbAQBSfixRsVGtfkp9gRc
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/11/2015 06:37 PM, Ahmed S. Darwish wrote:
> From: Ahmed S. Darwish <ahmed.darwish@valeo.com>
>=20
> A number of tx queue wake-up events went missing due to the
> outlined scenario below. Start state is a pool of 16 tx URBs,
> active tx_urbs count =3D 15, with the netdev tx queue open.
>=20
> start_xmit()                             tx_acknowledge()
> ............                             ................
> atomic_inc(&tx_urbs);
> if (atomic_read(&tx_urbs) >=3D 16) {
>                         URB completion IRQ!
>                         -->
>                                          atomic_dec(&tx_urbs);
>                                          netif_wake_queue();
>                                          return;
>                         <--
>                         end of IRQ!
>     netif_stop_queue();
> }
>=20
> At the end, the correct state expected is a 15 tx_urbs count
> value with the tx queue state _open_. Due to the race, we get
> the same tx_urbs value but with the tx queue state _stopped_.
> The wake-up event is completely lost.
>=20
> Thus avoid hand-rolled concurrency mechanisms and use a proper
> lock for contexts protection.
>=20
> Signed-off-by: Ahmed S. Darwish <ahmed.darwish@valeo.com>
> ---
>  drivers/net/can/usb/kvaser_usb.c | 83 ++++++++++++++++++++++++--------=
--------
>  1 file changed, 51 insertions(+), 32 deletions(-)
>=20
> changelog-v3: Added missing spin_lock_init(). With all kernel
> lock debugging options set, I've been running my test suite
> for an hour now without apparent problems in dmesg so far.
>=20
> changelog-v2: Put bugfix patch at the start of the series.
>=20
> diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kva=
ser_usb.c
> index a316fa4..e97a08c 100644
> --- a/drivers/net/can/usb/kvaser_usb.c
> +++ b/drivers/net/can/usb/kvaser_usb.c
> @@ -14,6 +14,7 @@
>   * Copyright (C) 2015 Valeo S.A.
>   */
> =20
> +#include <linux/spinlock.h>
>  #include <linux/kernel.h>
>  #include <linux/completion.h>
>  #include <linux/module.h>
> @@ -467,10 +468,11 @@ struct kvaser_usb {
>  struct kvaser_usb_net_priv {
>  	struct can_priv can;
> =20
> -	atomic_t active_tx_urbs;
> -	struct usb_anchor tx_submitted;
> +	spinlock_t tx_contexts_lock;
> +	int active_tx_contexts;
>  	struct kvaser_usb_tx_urb_context tx_contexts[MAX_TX_URBS];
> =20
> +	struct usb_anchor tx_submitted;
>  	struct completion start_comp, stop_comp;
> =20
>  	struct kvaser_usb *dev;
> @@ -694,6 +696,7 @@ static void kvaser_usb_tx_acknowledge(const struct =
kvaser_usb *dev,
>  	struct kvaser_usb_net_priv *priv;
>  	struct sk_buff *skb;
>  	struct can_frame *cf;
> +	unsigned long flags;
>  	u8 channel, tid;
> =20
>  	channel =3D msg->u.tx_acknowledge_header.channel;
> @@ -737,12 +740,15 @@ static void kvaser_usb_tx_acknowledge(const struc=
t kvaser_usb *dev,
> =20
>  	stats->tx_packets++;
>  	stats->tx_bytes +=3D context->dlc;
> -	can_get_echo_skb(priv->netdev, context->echo_index);
> =20
> -	context->echo_index =3D MAX_TX_URBS;
> -	atomic_dec(&priv->active_tx_urbs);
> +	spin_lock_irqsave(&priv->tx_contexts_lock, flags);
> =20
> +	can_get_echo_skb(priv->netdev, context->echo_index);
> +	context->echo_index =3D MAX_TX_URBS;
> +	--priv->active_tx_contexts;
>  	netif_wake_queue(priv->netdev);
> +
> +	spin_unlock_irqrestore(&priv->tx_contexts_lock, flags);

I think it should be possible to move tun unlock before waking up the que=
ue?

>  }
> =20
>  static void kvaser_usb_simple_msg_callback(struct urb *urb)
> @@ -803,17 +809,6 @@ static int kvaser_usb_simple_msg_async(struct kvas=
er_usb_net_priv *priv,
>  	return 0;
>  }
> =20
> -static void kvaser_usb_unlink_tx_urbs(struct kvaser_usb_net_priv *priv=
)
> -{
> -	int i;
> -
> -	usb_kill_anchored_urbs(&priv->tx_submitted);
> -	atomic_set(&priv->active_tx_urbs, 0);
> -
> -	for (i =3D 0; i < MAX_TX_URBS; i++)
> -		priv->tx_contexts[i].echo_index =3D MAX_TX_URBS;
> -}
> -
>  static void kvaser_usb_rx_error_update_can_state(struct kvaser_usb_net=
_priv *priv,
>  						 const struct kvaser_usb_error_summary *es,
>  						 struct can_frame *cf)
> @@ -1515,6 +1510,24 @@ error:
>  	return err;
>  }
> =20
> +static void kvaser_usb_reset_tx_urb_contexts(struct kvaser_usb_net_pri=
v *priv)
> +{
> +	int i;
> +
> +	priv->active_tx_contexts =3D 0;
> +	for (i =3D 0; i < MAX_TX_URBS; i++)
> +		priv->tx_contexts[i].echo_index =3D MAX_TX_URBS;
> +}
> +
> +/* This method might sleep. Do not call it in the atomic context
> + * of URB completions.
> + */
> +static void kvaser_usb_unlink_tx_urbs(struct kvaser_usb_net_priv *priv=
)
> +{
> +	usb_kill_anchored_urbs(&priv->tx_submitted);
> +	kvaser_usb_reset_tx_urb_contexts(priv);
> +}
> +
>  static void kvaser_usb_unlink_all_urbs(struct kvaser_usb *dev)
>  {
>  	int i;
> @@ -1634,6 +1647,7 @@ static netdev_tx_t kvaser_usb_start_xmit(struct s=
k_buff *skb,
>  	struct kvaser_msg *msg;
>  	int i, err, ret =3D NETDEV_TX_OK;
>  	u8 *msg_tx_can_flags =3D NULL;		/* GCC */
> +	unsigned long flags;
> =20
>  	if (can_dropped_invalid_skb(netdev, skb))
>  		return NETDEV_TX_OK;
> @@ -1687,12 +1701,21 @@ static netdev_tx_t kvaser_usb_start_xmit(struct=
 sk_buff *skb,
>  	if (cf->can_id & CAN_RTR_FLAG)
>  		*msg_tx_can_flags |=3D MSG_FLAG_REMOTE_FRAME;
> =20
> +	spin_lock_irqsave(&priv->tx_contexts_lock, flags);
>  	for (i =3D 0; i < ARRAY_SIZE(priv->tx_contexts); i++) {
>  		if (priv->tx_contexts[i].echo_index =3D=3D MAX_TX_URBS) {
>  			context =3D &priv->tx_contexts[i];
> +
> +			context->echo_index =3D i;
> +			can_put_echo_skb(skb, netdev, context->echo_index);
> +			++priv->active_tx_contexts;
> +			if (priv->active_tx_contexts >=3D MAX_TX_URBS)
> +				netif_stop_queue(netdev);
> +
>  			break;
>  		}
>  	}
> +	spin_unlock_irqrestore(&priv->tx_contexts_lock, flags);
> =20
>  	/* This should never happen; it implies a flow control bug */
>  	if (!context) {
> @@ -1704,7 +1727,6 @@ static netdev_tx_t kvaser_usb_start_xmit(struct s=
k_buff *skb,
>  	}
> =20
>  	context->priv =3D priv;
> -	context->echo_index =3D i;
>  	context->dlc =3D cf->can_dlc;
> =20
>  	msg->u.tx_can.tid =3D context->echo_index;
> @@ -1716,18 +1738,17 @@ static netdev_tx_t kvaser_usb_start_xmit(struct=
 sk_buff *skb,
>  			  kvaser_usb_write_bulk_callback, context);
>  	usb_anchor_urb(urb, &priv->tx_submitted);
> =20
> -	can_put_echo_skb(skb, netdev, context->echo_index);
> -
> -	atomic_inc(&priv->active_tx_urbs);
> -
> -	if (atomic_read(&priv->active_tx_urbs) >=3D MAX_TX_URBS)
> -		netif_stop_queue(netdev);
> -
>  	err =3D usb_submit_urb(urb, GFP_ATOMIC);
>  	if (unlikely(err)) {
> +		spin_lock_irqsave(&priv->tx_contexts_lock, flags);
> +
>  		can_free_echo_skb(netdev, context->echo_index);
> +		context->echo_index =3D MAX_TX_URBS;
> +		--priv->active_tx_contexts;
> +		netif_wake_queue(netdev);
> +
> +		spin_unlock_irqrestore(&priv->tx_contexts_lock, flags);

Same here?

> =20
> -		atomic_dec(&priv->active_tx_urbs);
>  		usb_unanchor_urb(urb);
> =20
>  		stats->tx_dropped++;
> @@ -1854,7 +1875,7 @@ static int kvaser_usb_init_one(struct usb_interfa=
ce *intf,
>  	struct kvaser_usb *dev =3D usb_get_intfdata(intf);
>  	struct net_device *netdev;
>  	struct kvaser_usb_net_priv *priv;
> -	int i, err;
> +	int err;
> =20
>  	err =3D kvaser_usb_send_simple_msg(dev, CMD_RESET_CHIP, channel);
>  	if (err)
> @@ -1868,19 +1889,17 @@ static int kvaser_usb_init_one(struct usb_inter=
face *intf,
> =20
>  	priv =3D netdev_priv(netdev);
> =20
> +	init_usb_anchor(&priv->tx_submitted);
>  	init_completion(&priv->start_comp);
>  	init_completion(&priv->stop_comp);
> =20
> -	init_usb_anchor(&priv->tx_submitted);
> -	atomic_set(&priv->active_tx_urbs, 0);
> -
> -	for (i =3D 0; i < ARRAY_SIZE(priv->tx_contexts); i++)
> -		priv->tx_contexts[i].echo_index =3D MAX_TX_URBS;
> -
>  	priv->dev =3D dev;
>  	priv->netdev =3D netdev;
>  	priv->channel =3D channel;
> =20
> +	spin_lock_init(&priv->tx_contexts_lock);
> +	kvaser_usb_reset_tx_urb_contexts(priv);
> +
>  	priv->can.state =3D CAN_STATE_STOPPED;
>  	priv->can.clock.freq =3D CAN_USB_CLOCK;
>  	priv->can.bittiming_const =3D &kvaser_usb_bittiming_const;
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--4eWjI61xhgXXlbAQBSfixRsVGtfkp9gRc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVALbuAAoJECte4hHFiupUhUcP/3jLN9eUGck4bqsrZpr/EI8B
n0l0KyS4FtabaGIpZWnRrkNNOfSSeyE+bIhDpTZBNchtrKJncohEGhhmfhDr2ZDQ
880fudByd2O7uQBbnrG37HdzOwL+QgQZpRZi9UPF2ChVO/JHJ9K89CZnuAfkMrkG
GpVtfRP5EEMuG2v95l71Yj/WEeD96j82527xlJP/Gk73+J5cP0FeAWtiNspAQkE9
oMFzKbusyFTw4Fz/E8/XsfAdMBgJDBKOHjxTxAG9FjSyscBC0LSNDjxiVegZzHaC
xPdV8diMLG8JhjqyD+2QSRLt73QYDHtz0Q+JczrwQMXLufSspuhxAzRmVGKmFcnT
wTX4BcQ6iALeBZjA3W1g/35eTEWPTtiQZOsZxz/9AtPMGtn/sqTpFUdATksYFGTQ
GjweyjR5b/LLfLGDJLSIPL/dhXRDa8hKOZHolmgmIyWcr9z+Vm6qyKD5mW8NrIEK
0vJcIzC9BfLao/bh5VLsywJ5XmDa4Z1vCLwf5bs60Smc7Nk9Y8mvXP/SGLquc+fQ
hSl+U4/QkMg/CMsaDkTXsWYsYjxanW1Vul9sUWpRYPzSA1I3hkKZyLCMLLaoVSFF
9orWcdjX4mzYc3RVO/ZbPQrT9kAXid1L/OGojcCuloDIyxZLAHB42n2ZAAqtygKn
/SpY5wZHBBDThVovwocJ
=pY8D
-----END PGP SIGNATURE-----

--4eWjI61xhgXXlbAQBSfixRsVGtfkp9gRc--
