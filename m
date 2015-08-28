From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: CAN implementation on A20 Allwinner
Date: Fri, 28 Aug 2015 08:21:20 +0200
Message-ID: <55DFFDE0.1060907@pengutronix.de>
References: <2d24e34ceb8e4fe4b0b7c74b9a36da44@SGPMBX1006.APAC.bosch.com>
 <54770F0F.7050904@hartkopp.net>
 <369acf6bdf8b4ae3840b69bef10b5082@SGPMBX1004.APAC.bosch.com>
 <21623.28007.620480.114111@gargle.gargle.HOWL>
 <58243.88.153.236.115.1417116776.squirrel@webmail.rdts.de>
 <58560.88.153.236.115.1417118037.squirrel@webmail.rdts.de>
 <547DB29B.4070601@pengutronix.de>
 <a3cdd6d97480f7b31a53e94169f8a1eb@mail.rdts.de>
 <55DF0F39.10507@pengutronix.de>
 <c05ac4c76aad5f8e94cb98960ccfbc43@mail.rdts.de>
 <55DF1580.3070806@pengutronix.de>
 <8a0d66b660360693b2b9b4ae7da78cd4@mail.rdts.de>
 <55DF2098.4020105@pengutronix.de>
 <4c51a680055342d2a37b3459c9cb74ed@SGPMBX1011.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="hcbnQ4UwsRfnWtf0btbv1Rq3plRkCwTgu"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35539 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbbH1GVb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 28 Aug 2015 02:21:31 -0400
In-Reply-To: <4c51a680055342d2a37b3459c9cb74ed@SGPMBX1011.APAC.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Misra Pankaj Kumar (RBEI/EEA2)" <Pankaj.Kumar@in.bosch.com>
Cc: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>, "linux-can-owner@vger.kernel.org" <linux-can-owner@vger.kernel.org>, Gerhard Bertelsmann <info@gerhard-bertelsmann.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hcbnQ4UwsRfnWtf0btbv1Rq3plRkCwTgu
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/28/2015 07:41 AM, Misra Pankaj Kumar (RBEI/EEA2) wrote:
> I have used CAN4Linux package with A20 Allwinner. Its working fine for =
me.
> Its char device implementation.

Good. Is the A20 supported bt a generic CAN4Linux SJA1000 driver or is
there a separate driver for it?

regards,
Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--hcbnQ4UwsRfnWtf0btbv1Rq3plRkCwTgu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJV3/3hAAoJEP5prqPJtc/HR50H/1JxkZNbvL3AZy1+DuYE8qEw
COJdkmp+jk0IRNUgcnxGIN+ACXjz9wxePBB9pCouxCWkz3MNRj8yFwZdrwIzL5E+
mt5fK5rJNWRMmDElcoWeRbZWhgNU2iQ3jGVnRnwpKBLPkn1zb9MF4bRbziupWU8+
CxZ+UN1Y0Oq9zyhCoxy+vYECz82bzGvobvDrEwMTHa90zWbqo826DQm3R0A0Yb2K
J/W0qnQcTp5BjtYA21UcT46d5U4k63K3LUbDkjiLCiR0zzvk0EjME/eU+Izq7bGc
zAo7zmHhcxhPfJyk3L45Hg38468l7HOe3ew/OR1YzBclyF6KodGom3lgdqRf2Qw=
=D4Jc
-----END PGP SIGNATURE-----

--hcbnQ4UwsRfnWtf0btbv1Rq3plRkCwTgu--
