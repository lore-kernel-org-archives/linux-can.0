From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] CAN: sja1000: Add support for Connect Tech Inc's Canpro/104-Plus
 Opto CAN board
Date: Wed, 17 Oct 2012 12:13:25 +0200
Message-ID: <507E84C5.2040600@pengutronix.de>
References: <02ac01cdabe1$b5403e10$1fc0ba30$@connecttech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8D5B72D20F7CC475792A0925"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57777 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756480Ab2JQKNc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 17 Oct 2012 06:13:32 -0400
In-Reply-To: <02ac01cdabe1$b5403e10$1fc0ba30$@connecttech.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Muhammad Ghias <mghias@connecttech.com>
Cc: 'Wolfgang Grandegger' <wg@grandegger.com>, linux-kernel@vger.kernel.org, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8D5B72D20F7CC475792A0925
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/16/2012 11:03 PM, Muhammad Ghias wrote:
> Patch adds support for CANpro/104-Plus Opto CAN board. Board uses PLX90=
30
> bridge and two NXP SJA1000 CAN controllers. Patch is generated and test=
ed
> with kernel 3.6.1.
>=20
> If you have any questions or any feedback please let me know.

Thanks, the code looks good. Please try, if possible, to send your
patches via git send-email, as outlooks messed up the patch. I've fixed
all line wrapping problems by hand, applied the patch and send a v2,
please test.

regards, Marc

P.S.: Please use the linux-can@vger.kernel.org mailing list for CAN
related patches/topics.

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig8D5B72D20F7CC475792A0925
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlB+hMkACgkQjTAFq1RaXHN5+gCgkQgUwEFbBnHR6gLtggQMESMf
CwcAn3NcIBF+JHe/Sz/4jYpagskAQDXZ
=zB7O
-----END PGP SIGNATURE-----

--------------enig8D5B72D20F7CC475792A0925--
