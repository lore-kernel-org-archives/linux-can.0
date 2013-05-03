From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: kvaser_usb: handle rx msg correctly
Date: Fri, 03 May 2013 11:51:41 +0200
Message-ID: <518388AD.3050902@pengutronix.de>
References: <CAJW3KNWxa_a727sgi_EO7nMBVbyVrCz0V3wCJBfvhz0ubbqCfA@mail.gmail.com> <517A968D.20508@pengutronix.de> <20130430214044.GA22921@thinkoso.home> <51824189.8090402@pengutronix.de> <20130502180610.GA14242@thinkoso.home> <20130502185710.GA1041@thinkoso.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2AENMXPXCILUOBRQGJUDS"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48235 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754431Ab3ECJvo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 3 May 2013 05:51:44 -0400
In-Reply-To: <20130502185710.GA1041@thinkoso.home>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Olivier Sobrie <olivier@sobrie.be>
Cc: Jonas Peterson <jonas.peterson@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2AENMXPXCILUOBRQGJUDS
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 05/02/2013 08:57 PM, Olivier Sobrie wrote:
> From: Jonas Peterson <jonas.peterson@gmail.com>
>=20
> Unlike Kvaser Leaf light devices, some other Kvaser devices (like USBca=
n
> Pro, USBcan R) receive CAN messages in CMD_LOG_MESSAGE frames. This
> patch adds support for it.

Looks better...

>=20
> Signed-off-by: Jonas Peterson <jonas.peterson@gmail.com>
> Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
> ---
>  drivers/net/can/usb/kvaser_usb.c | 49 ++++++++++++++++++++++++--------=
--------
>  1 file changed, 29 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kva=
ser_usb.c
> index 45cb9f3..6c89360 100644
> --- a/drivers/net/can/usb/kvaser_usb.c
> +++ b/drivers/net/can/usb/kvaser_usb.c
> @@ -834,22 +834,35 @@ static void kvaser_usb_rx_can_msg(const struct kv=
aser_usb *dev,
>  		return;
>  	}
> =20
> -	cf->can_id =3D ((msg->u.rx_can.msg[0] & 0x1f) << 6) |
> -		     (msg->u.rx_can.msg[1] & 0x3f);
> -	cf->can_dlc =3D get_can_dlc(msg->u.rx_can.msg[5]);
> -
> -	if (msg->id =3D=3D CMD_RX_EXT_MESSAGE) {
> -		cf->can_id <<=3D 18;
> -		cf->can_id |=3D ((msg->u.rx_can.msg[2] & 0x0f) << 14) |
> -			      ((msg->u.rx_can.msg[3] & 0xff) << 6) |
> -			      (msg->u.rx_can.msg[4] & 0x3f);
> -		cf->can_id |=3D CAN_EFF_FLAG;
> -	}
> +	if (msg->id =3D=3D CMD_LOG_MESSAGE) {
> +		cf->can_id =3D le32_to_cpu(msg->u.log_message.id);

I'd like to see the mentioned mask 11 or 29 bits and add EFF_FLAG here.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2AENMXPXCILUOBRQGJUDS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGDiK0ACgkQjTAFq1RaXHNpaACcCAyvHCyRDW89sylFAbgyUFNi
LecAoIXyYqXx+GhO2mWWi/0xSLZtOkfE
=elPr
-----END PGP SIGNATURE-----

------enig2AENMXPXCILUOBRQGJUDS--
