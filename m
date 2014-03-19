From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: Documentation: fix spelling of sample-point
Date: Wed, 19 Mar 2014 10:20:42 +0100
Message-ID: <5329616A.6050502@pengutronix.de>
References: <1395218982-20306-1-git-send-email-r.schwebel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Rpl3uVIAJVEOX8r6j3SMesgoMEH1Mqkkm"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46793 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758132AbaCSJUt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 19 Mar 2014 05:20:49 -0400
In-Reply-To: <1395218982-20306-1-git-send-email-r.schwebel@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Robert Schwebel <r.schwebel@pengutronix.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Rpl3uVIAJVEOX8r6j3SMesgoMEH1Mqkkm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/19/2014 09:49 AM, Robert Schwebel wrote:
> Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

Applied to can-next, adjusted the commit message as follows:

> can: Documentation: fix parameter name "sample-point"
>=20
> This patch fixes the name of the parameter to configure the sample poin=
t used
> in iproute2's ip command. The correct writing is "sample-point" not
> "sample_point"

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Rpl3uVIAJVEOX8r6j3SMesgoMEH1Mqkkm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMpYWoACgkQjTAFq1RaXHPjZQCfX0cMXmDL6DC63DFDPOYjHCtc
yyYAnj3Ulk99TWdtV0OeE8C/MiR5dz3Z
=eEOL
-----END PGP SIGNATURE-----

--Rpl3uVIAJVEOX8r6j3SMesgoMEH1Mqkkm--
