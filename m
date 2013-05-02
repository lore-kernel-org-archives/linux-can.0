From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: kvaser_usb: handle rx msg correctly
Date: Thu, 02 May 2013 12:35:53 +0200
Message-ID: <51824189.8090402@pengutronix.de>
References: <CAJW3KNWxa_a727sgi_EO7nMBVbyVrCz0V3wCJBfvhz0ubbqCfA@mail.gmail.com> <517A968D.20508@pengutronix.de> <20130430214044.GA22921@thinkoso.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2QMDBPQHEAWATDGMUDSRE"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35127 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757284Ab3EBKgD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 2 May 2013 06:36:03 -0400
In-Reply-To: <20130430214044.GA22921@thinkoso.home>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Olivier Sobrie <olivier@sobrie.be>
Cc: Jonas Peterson <jonas.peterson@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2QMDBPQHEAWATDGMUDSRE
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04/30/2013 11:40 PM, Olivier Sobrie wrote:
> From: Jonas Peterson <jonas.peterson@gmail.com>
>=20
> Unlike Kvaser Leaf light devices, some other Kvaser devices (like USBca=
n
> Pro, USBcan R) receive CAN messages in CMD_LOG_MESSAGE frames. This
> patch adds support for it.
>=20
> Signed-off-by: Jonas Peterson <jonas.peterson@gmail.com>
> Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
> ---
> Hi Jonas and Marc,
>=20
> I tested Jonas' patch with my devices and it looks to be good.
> The Kvaser UsbCAN R had the same problem. When I wrote the driver I
> didn't had this device and I never tested it... This patch was a good
> reason for that :-)
> However I modified the patch of Jonas in order to not duplicate
> functions.
>=20
> Thanks again to Jonas for the fix!

Thanks for testing and cleaning up, few comments inline.

Marc

>=20
> Olivier
>=20
>  drivers/net/can/usb/kvaser_usb.c | 53 +++++++++++++++++++++++++++++---=
--------
>  1 file changed, 39 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kva=
ser_usb.c
> index 45cb9f3..0870529 100644
> --- a/drivers/net/can/usb/kvaser_usb.c
> +++ b/drivers/net/can/usb/kvaser_usb.c
> @@ -834,22 +834,51 @@ static void kvaser_usb_rx_can_msg(const struct kv=
aser_usb *dev,
>  		return;
>  	}
> =20
> -	cf->can_id =3D ((msg->u.rx_can.msg[0] & 0x1f) << 6) |
> -		     (msg->u.rx_can.msg[1] & 0x3f);
> -	cf->can_dlc =3D get_can_dlc(msg->u.rx_can.msg[5]);
> +	switch (msg->id) {
> +	case CMD_LOG_MESSAGE:
> +		cf->can_id =3D msg->u.log_message.id;

No need to mangle the can_id like the CMD_RX_EXT_MESSAGE or
CMD_RX_STD_MESSAGE case? What about the extended messages flag?

> +		cf->can_dlc =3D get_can_dlc(msg->u.log_message.dlc);
> +
> +		if (msg->u.log_message.flags & MSG_FLAG_REMOTE_FRAME)
> +			cf->can_id |=3D CAN_RTR_FLAG;
> +		else
> +			memcpy(cf->data, &msg->u.log_message.data,
> +			       cf->can_dlc);

Is this endianness save? But the memcpy was already here. Keep it until
someone with a ppc or sparc complains.

> +		break;
> =20
> -	if (msg->id =3D=3D CMD_RX_EXT_MESSAGE) {
> +	case CMD_RX_EXT_MESSAGE:
>  		cf->can_id <<=3D 18;

who sets the can_id in the first place?

>  		cf->can_id |=3D ((msg->u.rx_can.msg[2] & 0x0f) << 14) |
>  			      ((msg->u.rx_can.msg[3] & 0xff) << 6) |
>  			      (msg->u.rx_can.msg[4] & 0x3f);
>  		cf->can_id |=3D CAN_EFF_FLAG;
> -	}
> +		cf->can_dlc =3D get_can_dlc(msg->u.rx_can.msg[5]);
> =20
> -	if (msg->u.rx_can.flag & MSG_FLAG_REMOTE_FRAME)
> -		cf->can_id |=3D CAN_RTR_FLAG;
> -	else
> -		memcpy(cf->data, &msg->u.rx_can.msg[6], cf->can_dlc);
> +		if (msg->u.rx_can.flag & MSG_FLAG_REMOTE_FRAME)
> +			cf->can_id |=3D CAN_RTR_FLAG;
> +		else
> +			memcpy(cf->data, &msg->u.rx_can.msg[6],
> +			       cf->can_dlc);
> +		break;
> +
> +	case CMD_RX_STD_MESSAGE:
> +		cf->can_id =3D ((msg->u.rx_can.msg[0] & 0x1f) << 6) |
> +			     (msg->u.rx_can.msg[1] & 0x3f);
> +		cf->can_dlc =3D get_can_dlc(msg->u.rx_can.msg[5]);
> +
> +		if (msg->u.rx_can.flag & MSG_FLAG_REMOTE_FRAME)
> +			cf->can_id |=3D CAN_RTR_FLAG;
> +		else
> +			memcpy(cf->data, &msg->u.rx_can.msg[6],
> +			       cf->can_dlc);
> +		break;
> +
> +	default:
> +		netdev_warn(priv->netdev,
> +			    "Unhandled message (%d)\n", msg->id);
> +		dev_kfree_skb(skb);
> +		return;
> +	}
> =20
>  	netif_rx(skb);
> =20
> @@ -911,6 +940,7 @@ static void kvaser_usb_handle_message(const struct =
kvaser_usb *dev,
> =20
>  	case CMD_RX_STD_MESSAGE:
>  	case CMD_RX_EXT_MESSAGE:
> +	case CMD_LOG_MESSAGE:
>  		kvaser_usb_rx_can_msg(dev, msg);
>  		break;
> =20
> @@ -919,11 +949,6 @@ static void kvaser_usb_handle_message(const struct=
 kvaser_usb *dev,
>  		kvaser_usb_rx_error(dev, msg);
>  		break;
> =20
> -	case CMD_LOG_MESSAGE:
> -		if (msg->u.log_message.flags & MSG_FLAG_ERROR_FRAME)
> -			kvaser_usb_rx_error(dev, msg);
> -		break;
> -
>  	case CMD_TX_ACKNOWLEDGE:
>  		kvaser_usb_tx_acknowledge(dev, msg);
>  		break;
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2QMDBPQHEAWATDGMUDSRE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEUEARECAAYFAlGCQY0ACgkQjTAFq1RaXHOUyQCeI1fq/9WrOhNNLAUqV1+E9BFb
2Y0AmN+N+oygpzyDmG2Y8KBUwfkIX2U=
=+lQn
-----END PGP SIGNATURE-----

------enig2QMDBPQHEAWATDGMUDSRE--
