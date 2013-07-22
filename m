From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/2] flexcan: Add MODULE_ALIAS
Date: Mon, 22 Jul 2013 16:55:21 +0200
Message-ID: <51ED47D9.6070703@pengutronix.de>
References: <1374502981-16282-1-git-send-email-fabio.estevam@freescale.com> <1374502981-16282-2-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2FQKADECTLFRFWIMANXUM"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54284 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755757Ab3GVOzY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 22 Jul 2013 10:55:24 -0400
In-Reply-To: <1374502981-16282-2-git-send-email-fabio.estevam@freescale.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: linux-can@vger.kernel.org, festevam@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2FQKADECTLFRFWIMANXUM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/22/2013 04:23 PM, Fabio Estevam wrote:
> Add MODULE_ALIAS, so that auto module loading can work.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/net/can/flexcan.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 0516fd8..cd25af0 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -1156,6 +1156,7 @@ static struct platform_driver flexcan_driver =3D =
{
> =20
>  module_platform_driver(flexcan_driver);
> =20
> +MODULE_ALIAS("platform:" DRV_NAME);
>  MODULE_AUTHOR("Sascha Hauer <kernel@pengutronix.de>, "
>  	      "Marc Kleine-Budde <kernel@pengutronix.de>");
>  MODULE_LICENSE("GPL v2");
>=20

Do we need a MODULE_ALIAS, if we have both a MODULE_DEVICE_TABLE(of,
flexcan_of_match) and MODULE_DEVICE_TABLE(platform, flexcan_id_table)?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2FQKADECTLFRFWIMANXUM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlHtR9oACgkQjTAFq1RaXHNHQQCdHJbf/Z1lnqdfFC3LKp0EXCay
CscAoI33e9XailoCiHyEw2aIkuOmv3Eh
=mm9h
-----END PGP SIGNATURE-----

------enig2FQKADECTLFRFWIMANXUM--
