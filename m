From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/3] ARM: imx: prepare for removal of flexcan_platform_data
Date: Wed, 12 Jun 2013 11:41:43 +0200
Message-ID: <51B84257.608@pengutronix.de>
References: <1370916778-4406-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2ESDRGEJGIMRLMOGAILWO"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46150 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876Ab3FLJls (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 12 Jun 2013 05:41:48 -0400
In-Reply-To: <1370916778-4406-1-git-send-email-festevam@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: shawn.guo@linaro.org, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2ESDRGEJGIMRLMOGAILWO
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 06/11/2013 04:12 AM, Fabio Estevam wrote:
> From: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> As there are no imx in-tree users of flexcan_platform_data, this patch =
removes
> the possibility to register a flexcan device with platform data.
>=20
> The functionality to swith on/off CAN transceivers is added to DT via
> regulators on a later patch.
>=20
> Compile time tested with imx_v4_v5_defconfig and imx_v6_v7_defconfig.
>=20
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Nitpick: Don't forget to add your S-o-b when posting patches from other
people ;)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2ESDRGEJGIMRLMOGAILWO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlG4QlcACgkQjTAFq1RaXHN2FQCfVaEydKA9MRE0Whuf6fGmC1RC
KlAAnRqj55hRH+fJqD0Mr1Ocscr3zyCI
=QqNW
-----END PGP SIGNATURE-----

------enig2ESDRGEJGIMRLMOGAILWO--
