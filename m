From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/3] flexcan: Use a regulator to control the CAN transceiver
Date: Wed, 12 Jun 2013 11:40:52 +0200
Message-ID: <51B84224.2040807@pengutronix.de>
References: <1370916778-4406-1-git-send-email-festevam@gmail.com> <1370916778-4406-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2JAOLJDEEDCETFSCWAQTA"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46145 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876Ab3FLJk6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 12 Jun 2013 05:40:58 -0400
In-Reply-To: <1370916778-4406-2-git-send-email-festevam@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: shawn.guo@linaro.org, linux-can@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2JAOLJDEEDCETFSCWAQTA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 06/11/2013 04:12 AM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Instead of using a GPIO to turn on/off the CAN transceiver, it is bette=
r to
> use a regulator as some systems may use a PMIC to power the CAN transce=
iver.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Marc/Shawn,
>=20
> Only boot tested. I haven't tested CAN operation.

Can you test on real hardware? I don't have access to an evk until Monday=
=2E

Marc


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2JAOLJDEEDCETFSCWAQTA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlG4QiQACgkQjTAFq1RaXHPyjACZARJIEsxk4jBn2qlJYyahgkCn
/TQAoICMGHwPFjyHCbEoOsIJIR+e7ttI
=gb3Y
-----END PGP SIGNATURE-----

------enig2JAOLJDEEDCETFSCWAQTA--
