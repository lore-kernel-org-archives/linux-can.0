From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: sja1000: Fix error location forwarding
Date: Mon, 11 Apr 2016 11:19:35 +0200
Message-ID: <570B6C27.3040305@pengutronix.de>
References: <20160401191645.36722a06@brick.gerasiov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="GCc7h8oQ23q8RCArCGPA5n04Fvjf40Bb5"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:45135 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750820AbcDKJTo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 11 Apr 2016 05:19:44 -0400
In-Reply-To: <20160401191645.36722a06@brick.gerasiov.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Gerasiov <gq@cs.msu.su>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GCc7h8oQ23q8RCArCGPA5n04Fvjf40Bb5
Content-Type: multipart/mixed; boundary="5b1RlUCk4CrnKEm9B65NQ4xeGMHewk3E5"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Alexander Gerasiov <gq@cs.msu.su>, linux-can@vger.kernel.org
Message-ID: <570B6C27.3040305@pengutronix.de>
Subject: Re: [PATCH] can: sja1000: Fix error location forwarding
References: <20160401191645.36722a06@brick.gerasiov.net>
In-Reply-To: <20160401191645.36722a06@brick.gerasiov.net>

--5b1RlUCk4CrnKEm9B65NQ4xeGMHewk3E5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/01/2016 06:16 PM, Alexander Gerasiov wrote:
> According to SJA1000 documentation the location of error is available
> regardless of an error type. Therefore it should always be forwarded to=

> SocketCAN.
>=20
> Signed-off-by: Nikita Edward Baruzdin <nebaruzdin@lvk.cs.msu.su>
> Signed-off-by: Alexander GQ Gerasiov <gq@cs.msu.su>

Applied to can-next/master. Please use git send-email to send your
patches, your mailer converted tabs to spaces.

Tnx,
Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--5b1RlUCk4CrnKEm9B65NQ4xeGMHewk3E5--

--GCc7h8oQ23q8RCArCGPA5n04Fvjf40Bb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXC2wnAAoJED07qiWsqSVqmicIALg4df34GbCSGwzMJlnds0HY
5UMSv5s0ZqaDcqDOatao4cDPKU/EsRmu5jZzY/Rt/iy/iOhvXrlkIvFaRHxgz85U
ojLkQ8Al01EqKGAnyPI4BdMLbo7HlIbHVT7CDxjGhG9Li2njp8DPbvo9Lxxx8eqz
r5sj3KgKMMjmwnWkiGrjRuNAV7ubXsG/vDan5zimX95os2zB/35PcxAcBacxfI7M
AyaLMu5Ts6clhFXDpwT4oNrT0mlEZwkBn7qrrcZgIcPq+Zz9mJmUWGT/dGNmzLmZ
r42IHnhnb4ltLnsPtxYtgenHrkG0q2SRzXWQTtzQPvdeMJ0qel3w24+rNybuezk=
=WHv9
-----END PGP SIGNATURE-----

--GCc7h8oQ23q8RCArCGPA5n04Fvjf40Bb5--
