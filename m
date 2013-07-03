From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Usb to can driver
Date: Wed, 03 Jul 2013 09:55:55 +0200
Message-ID: <51D3D90B.2060809@pengutronix.de>
References: <1372204758.9593.13.camel@blackbox>   <a32451031b577e68f4c79750800c5d71@grandegger.com>  <1372272912.3805.27.camel@blackbox> <51CB39D2.60501@pengutronix.de> <1372810462.15632.2.camel@blackbox>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2SBAGCGURSTMWHWNXNPDJ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39273 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932065Ab3GCH4I (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 3 Jul 2013 03:56:08 -0400
In-Reply-To: <1372810462.15632.2.camel@blackbox>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Max S." <max@schneidersoft.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2SBAGCGURSTMWHWNXNPDJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/03/2013 02:14 AM, Max S. wrote:
>> > Can you send a patch? :)
>> >=20
> sure. attached.

Thanks. Please the mailinglist for all linux can related patches.

> However, since i don't have the hardware; I can't test this.

Me neither, but the patch looks good.

> From f6f2ec1b1c2fa4f2d29fb48e8a315ff814ed2be9 Mon Sep 17 00:00:00 2001
> From: Maximilian Schneider <max@schneidersoft.net>
> Date: Tue, 2 Jul 2013 23:43:29 +0000
> Subject: [PATCH] use of raw input in net lookup
>=20
>=20
> Signed-off-by: Maximilian Schneider <max@schneidersoft.net>
> ---
>  drivers/net/can/usb/esd_usb2.c |    6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/net/can/usb/esd_usb2.c b/drivers/net/can/usb/esd_u=
sb2.c
> index 6aa7b32..ee89b19 100644
> --- a/drivers/net/can/usb/esd_usb2.c
> +++ b/drivers/net/can/usb/esd_usb2.c
> @@ -412,10 +412,16 @@ static void esd_usb2_read_bulk_callback(struct ur=
b *urb)
> =20
>  		switch (msg->msg.hdr.cmd) {
>  		case CMD_CAN_RX:
> +			if (msg->msg.rx.net >=3D dev->net_count)

I've added an error message here.

> +				break;
> +
>  			esd_usb2_rx_can_msg(dev->nets[msg->msg.rx.net], msg);
>  			break;
> =20
>  		case CMD_CAN_TX:
> +			if (msg->msg.txdone.net >=3D dev->net_count)

and here, too.

> +				break;
> +
>  			esd_usb2_tx_done_msg(dev->nets[msg->msg.txdone.net],
>  					     msg);
>  			break;
> -- 1.7.10.4
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2SBAGCGURSTMWHWNXNPDJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlHT2RQACgkQjTAFq1RaXHOqeACdFq0qYFa/PGyLYUcZNFobnphx
P9IAoIdfZAdtLQdVTkEScphWmzSVCbIJ
=HxGx
-----END PGP SIGNATURE-----

------enig2SBAGCGURSTMWHWNXNPDJ--
