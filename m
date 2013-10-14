From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: BerliOS shutdown? - Fwd: r1278 - branches tags trunk
Date: Mon, 14 Oct 2013 11:00:26 +0200
Message-ID: <525BB2AA.1040000@pengutronix.de>
References: <20131011152958.914C955B0C@scm.berlios.de> <52582306.3070006@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="pqBOLlxBdAtHDVTJFimEg5KwPm2CfnkP6"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55932 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960Ab3JNJAc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 14 Oct 2013 05:00:32 -0400
In-Reply-To: <52582306.3070006@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Yegor Yefremov <yegorslists@googlemail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pqBOLlxBdAtHDVTJFimEg5KwPm2CfnkP6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/11/2013 06:10 PM, Oliver Hartkopp wrote:
> Hi Marc,
>=20
> according to this G+ post from Yegor
>=20
> 	https://plus.google.com/111984225231618981770/posts/DcC7deT95zF
>=20
> I updated some descriptions on the obsolete BerliOS project site and ad=
ded
> text files to the SVN and the released files section pointing to gitori=
ous.
>=20
> I'm unsure if we finally should shut down the SVN or not.
>=20
> Thinking about this: There's still something missing on gitorious:
>=20
> Can you please move the stuff from socketcan/trunk/test to
> https://gitorious.org/linux-can/can-misc/test if you find some time?

I'll create a seperate repository for can-test. Or as there is more than
one test involved,  I'd like to call the repo can-tests, analogue to
can-utils.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--pqBOLlxBdAtHDVTJFimEg5KwPm2CfnkP6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlJbsqoACgkQjTAFq1RaXHOZ0wCfc5XDZEspzrkb0Eb9pJ/rCZ3J
/PEAnj1xEFMcRgNoi0EIPld2DR6bA/M2
=RLHL
-----END PGP SIGNATURE-----

--pqBOLlxBdAtHDVTJFimEg5KwPm2CfnkP6--
