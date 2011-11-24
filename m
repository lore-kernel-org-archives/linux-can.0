From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 11/11] can: Remove redundant spi driver bus initialization
Date: Thu, 24 Nov 2011 16:36:47 +0100
Message-ID: <4ECE648F.1040102@pengutronix.de>
References: <1322148561-25138-1-git-send-email-lars@metafoo.de> <1322148561-25138-11-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5AD738D33101858136AC04B6"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48137 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995Ab1KXPg6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 24 Nov 2011 10:36:58 -0500
In-Reply-To: <1322148561-25138-11-git-send-email-lars@metafoo.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-kernel@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5AD738D33101858136AC04B6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/24/2011 04:29 PM, Lars-Peter Clausen wrote:
> In ancient times it was necessary to manually initialize the bus field =
of an
> spi_driver to spi_bus_type. These days this is done in spi_driver_regis=
ter(),
> so we can drop the manual assignment.
>=20
> The patch was generated using the following coccinelle semantic patch:
> // <smpl>
> @@
> identifier _driver;
> @@
> struct spi_driver _driver =3D {
> 	.driver =3D {
> -		.bus =3D &spi_bus_type,
> 	},
> };
> // </smpl>
>=20
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: linux-can@vger.kernel.org

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/mcp251x.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
> index 330140e..5e10da5 100644
> --- a/drivers/net/can/mcp251x.c
> +++ b/drivers/net/can/mcp251x.c
> @@ -1185,7 +1185,6 @@ MODULE_DEVICE_TABLE(spi, mcp251x_id_table);
>  static struct spi_driver mcp251x_can_driver =3D {
>  	.driver =3D {
>  		.name =3D DEVICE_NAME,
> -		.bus =3D &spi_bus_type,
>  		.owner =3D THIS_MODULE,
>  	},
> =20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig5AD738D33101858136AC04B6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7OZJYACgkQjTAFq1RaXHMIwgCeKQJcFGAOfI51dGK/kUjVR913
1s8AnAvS4Wjimv+a06fc92kNhWAh+Oo5
=vtQM
-----END PGP SIGNATURE-----

--------------enig5AD738D33101858136AC04B6--
