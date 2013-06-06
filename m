From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] flexcan: Use a regulator to control the CAN transceiver
Date: Thu, 06 Jun 2013 07:21:33 +0200
Message-ID: <51B01C5D.2050609@pengutronix.de>
References: <1370460445-15386-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2MAQTDPLLETSKNSUTFLAB"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46805 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467Ab3FFFVm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Jun 2013 01:21:42 -0400
In-Reply-To: <1370460445-15386-1-git-send-email-festevam@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: shawn.guo@linaro.org, linux-can@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2MAQTDPLLETSKNSUTFLAB
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 06/05/2013 09:27 PM, Fabio Estevam wrote:
> Instead of using a GPIO to turn on/off the CAN transceiver, it is bette=
r to
> use a regulator as some systems may use a PMIC to power the CAN transce=
iver.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Just a short note, as I'm not in the office today.

I like the idea of using an established subsystem for the
transceiver/phy. But I don't like the solution you suggested in patch 2.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2MAQTDPLLETSKNSUTFLAB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGwHF0ACgkQjTAFq1RaXHPfVwCdHOR804/1l8hUDvRiAZlzU9Ez
QPQAnjPYbNTlyCkV6Wx1I42+4hSpmwUt
=5qwh
-----END PGP SIGNATURE-----

------enig2MAQTDPLLETSKNSUTFLAB--
