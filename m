From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: pcan_usb: don't provide CAN FD bittimings by non-FD
 adapters
Date: Thu, 6 Aug 2015 09:54:03 +0200
Message-ID: <55C3129B.80702@pengutronix.de>
References: <1438293228-20185-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="wIq8JDKlcVvPl3cLAL0FGf2b81gqAJxSs"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44662 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbbHFHyU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Aug 2015 03:54:20 -0400
In-Reply-To: <1438293228-20185-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: s.grosjean@peak-system.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wIq8JDKlcVvPl3cLAL0FGf2b81gqAJxSs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/30/2015 11:53 PM, Oliver Hartkopp wrote:
> The CAN FD data bittiming constants are provided via netlink only when =
there
> are valid CAN FD constants available in priv->data_bittiming_const.
>=20
> Due to the indirection of pointer assignments in the peak_usb driver th=
e
> priv->data_bittiming_const never becomes NULL - not even for non-FD ada=
pters.
>=20
> The data_bittiming_const points to zero'ed data which leads to this res=
ult
> when running 'ip -details link show can0':
>=20
> 35: can0: <NOARP,ECHO> mtu 16 qdisc noop state DOWN mode DEFAULT group =
default qlen 10
>     link/can  promiscuity 0
>     can state STOPPED restart-ms 0
> 	  pcan_usb: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
> 	  : dtseg1 0..0 dtseg2 0..0 dsjw 1..0 dbrp 0..0 dbrp-inc 0  <=3D=3D BR=
OKEN!
> 	  clock 8000000
>=20
> This patch sets the dev_set_data_bittiming in struct peak_adapter to NU=
LL to
> be able to disable the CAN FD specific information on non-FD adapters.
>=20
> Relevant for stable kernels 4.0+
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  drivers/net/can/usb/peak_usb/pcan_usb.c      | 1 +
>  drivers/net/can/usb/peak_usb/pcan_usb_core.c | 9 +++++++--
>  drivers/net/can/usb/peak_usb/pcan_usb_pro.c  | 1 +
>  3 files changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/=
usb/peak_usb/pcan_usb.c
> index 6b94007..5c4b270 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
> @@ -896,6 +896,7 @@ const struct peak_usb_adapter pcan_usb =3D {
>  	.dev_init =3D pcan_usb_init,
>  	.dev_set_bus =3D pcan_usb_write_mode,
>  	.dev_set_bittiming =3D pcan_usb_set_bittiming,
> +	.dev_set_data_bittiming =3D NULL,

Due to C99 initializers this is not needed, as unset elements are
automatically set to 0.

>  	.dev_get_device_id =3D pcan_usb_get_device_id,
>  	.dev_decode_buf =3D pcan_usb_decode_buf,
>  	.dev_encode_msg =3D pcan_usb_encode_msg,
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net=
/can/usb/peak_usb/pcan_usb_core.c
> index 7921cff..76c0624 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> @@ -794,8 +794,13 @@ static int peak_usb_create_dev(const struct peak_u=
sb_adapter *peak_usb_adapter,
>  	dev->can.clock =3D peak_usb_adapter->clock;
>  	dev->can.bittiming_const =3D &peak_usb_adapter->bittiming_const;
>  	dev->can.do_set_bittiming =3D peak_usb_set_bittiming;
> -	dev->can.data_bittiming_const =3D &peak_usb_adapter->data_bittiming_c=
onst;
> -	dev->can.do_set_data_bittiming =3D peak_usb_set_data_bittiming;

Set bittiming can be assigned unconditionally. We just have to take care
about data_bittiming_const.

> +	if (peak_usb_adapter->dev_set_data_bittiming) {
> +		dev->can.data_bittiming_const =3D &peak_usb_adapter->data_bittiming_=
const;
> +		dev->can.do_set_data_bittiming =3D peak_usb_set_data_bittiming;
> +	} else {
> +		dev->can.data_bittiming_const =3D NULL;
> +		dev->can.do_set_data_bittiming =3D NULL;
> +	}
>  	dev->can.do_set_mode =3D peak_usb_set_mode;
>  	dev->can.do_get_berr_counter =3D peak_usb_adapter->do_get_berr_counte=
r;
>  	dev->can.ctrlmode_supported =3D peak_usb_adapter->ctrlmode_supported;=

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/=
can/usb/peak_usb/pcan_usb_pro.c
> index 7d61b32..9111a54 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> @@ -1048,6 +1048,7 @@ const struct peak_usb_adapter pcan_usb_pro =3D {
>  	.dev_free =3D pcan_usb_pro_free,
>  	.dev_set_bus =3D pcan_usb_pro_set_bus,
>  	.dev_set_bittiming =3D pcan_usb_pro_set_bittiming,
> +	.dev_set_data_bittiming =3D NULL,

not needed, C99.

>  	.dev_get_device_id =3D pcan_usb_pro_get_device_id,
>  	.dev_decode_buf =3D pcan_usb_pro_decode_buf,
>  	.dev_encode_msg =3D pcan_usb_pro_encode_msg,
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--wIq8JDKlcVvPl3cLAL0FGf2b81gqAJxSs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJVwxKbAAoJEP5prqPJtc/HsNcH/0y+jSFMjK8JYnhYxfb8lMY6
f5eatCsYiF8CZkT9VCruWRkBbvlBHVvjso1UQGi+TTJswJe8E0yffi7lcwE+H9LZ
2X4TrX5qJsJuZuukymVcU9DJjp6Pwe6X2BksIMVYaLSD2MwH55rMXa50Yca0IIo2
ehpSA5Pf8zdK7uC7+X21iXoOLhqjQsD4AgRzmpYtt52zKHNJHgoPdYqp+hSzuMYJ
Aly2IHGSUnSkur2HyMQ8h4qUEeBFqPSXy/tsyyebmMrBs0e7Q9KIZZ104VmLQfi5
ZpbbxhmJFN2IGJ7J3exYZCtMM7ttIotFhkGsMRQxBVWZxM9Y/n+w83PwdWjVEY0=
=RYyJ
-----END PGP SIGNATURE-----

--wIq8JDKlcVvPl3cLAL0FGf2b81gqAJxSs--
