From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 18/25] can: mpc5xxx_can: make data in mpc5xxx_can_probe
 const
Date: Mon, 23 Jul 2012 11:17:49 +0200
Message-ID: <500D16BD.2080900@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de> <1343034810-3386-19-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig079DEA8E93166002AB09AF4D"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57110 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab2GWJSG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 23 Jul 2012 05:18:06 -0400
In-Reply-To: <1343034810-3386-19-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <rob.herring@calxeda.com>, Oliver Hartkopp <socketcan@hartkopp.net>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig079DEA8E93166002AB09AF4D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/23/2012 11:13 AM, Uwe Kleine-K=C3=B6nig wrote:
> From: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Note: this patch is already upstream in David Miller's net-next tree.
0e84eb0 can: mpc5xxx_can: make data in mpc5xxx_can_probe const

cheers, Marc
> ---
>  drivers/net/can/mscan/mpc5xxx_can.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/msca=
n/mpc5xxx_can.c
> index 5caa572..06adf88 100644
> --- a/drivers/net/can/mscan/mpc5xxx_can.c
> +++ b/drivers/net/can/mscan/mpc5xxx_can.c
> @@ -251,7 +251,7 @@ static struct of_device_id mpc5xxx_can_table[];
>  static int __devinit mpc5xxx_can_probe(struct platform_device *ofdev)
>  {
>  	const struct of_device_id *match;
> -	struct mpc5xxx_can_data *data;
> +	const struct mpc5xxx_can_data *data;
>  	struct device_node *np =3D ofdev->dev.of_node;
>  	struct net_device *dev;
>  	struct mscan_priv *priv;
>=20

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig079DEA8E93166002AB09AF4D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlANFsEACgkQjTAFq1RaXHO3zACdE2lBO02wz+SbZdeeun82c0qd
+gEAn1TEUMonSo2Jq+MGPA0LULOJuDll
=ZqyH
-----END PGP SIGNATURE-----

--------------enig079DEA8E93166002AB09AF4D--
