From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 25/25] can: mpc5xxx_can: make data used as *of_device_id.data
 const
Date: Mon, 23 Jul 2012 11:20:25 +0200
Message-ID: <500D1759.4040002@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de> <1343034810-3386-26-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig084DA8F2DB3B093B3DB444EC"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57153 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719Ab2GWJUj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 23 Jul 2012 05:20:39 -0400
In-Reply-To: <1343034810-3386-26-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <rob.herring@calxeda.com>, Oliver Hartkopp <socketcan@hartkopp.net>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig084DA8F2DB3B093B3DB444EC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/23/2012 11:13 AM, Uwe Kleine-K=C3=B6nig wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> [ukl: split Arnd's patch by driver]
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Marc

> ---
>  drivers/net/can/mscan/mpc5xxx_can.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/msca=
n/mpc5xxx_can.c
> index 06adf88..8a8df82 100644
> --- a/drivers/net/can/mscan/mpc5xxx_can.c
> +++ b/drivers/net/can/mscan/mpc5xxx_can.c
> @@ -380,12 +380,12 @@ static int mpc5xxx_can_resume(struct platform_dev=
ice *ofdev)
>  }
>  #endif
> =20
> -static struct mpc5xxx_can_data __devinitdata mpc5200_can_data =3D {
> +static const struct mpc5xxx_can_data __devinitdata mpc5200_can_data =3D=
 {
>  	.type =3D MSCAN_TYPE_MPC5200,
>  	.get_clock =3D mpc52xx_can_get_clock,
>  };
> =20
> -static struct mpc5xxx_can_data __devinitdata mpc5121_can_data =3D {
> +static const struct mpc5xxx_can_data __devinitdata mpc5121_can_data =3D=
 {
>  	.type =3D MSCAN_TYPE_MPC5121,
>  	.get_clock =3D mpc512x_can_get_clock,
>  };
>=20

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig084DA8F2DB3B093B3DB444EC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlANF1kACgkQjTAFq1RaXHNEqQCfQmSecj0s/bBjR/br0NApITGr
w7gAn31b/4cy0gWjUuTVEbiBF2Q1m2wZ
=RxWA
-----END PGP SIGNATURE-----

--------------enig084DA8F2DB3B093B3DB444EC--
