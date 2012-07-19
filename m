From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/6] can: janz-ican3: drop invalid skbs
Date: Thu, 19 Jul 2012 10:02:24 +0200
Message-ID: <5007BF10.1080702@pengutronix.de>
References: <1342650798-2991-1-git-send-email-iws@ovro.caltech.edu> <1342650798-2991-3-git-send-email-iws@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig32EF564A7518EB87F5823C49"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49684 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041Ab2GSIC0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 19 Jul 2012 04:02:26 -0400
In-Reply-To: <1342650798-2991-3-git-send-email-iws@ovro.caltech.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig32EF564A7518EB87F5823C49
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/19/2012 12:33 AM, Ira W. Snyder wrote:
> From: "Ira W. Snyder" <iws@ovro.caltech.edu>
>=20
> The commit which added the janz-ican3 driver and commit
> 3ccd4c61 "can: Unify droping of invalid tx skbs and netdev stats" were
> committed into mainline Linux during the same merge window.
>=20
> Therefore, the addition of this code to the janz-ican3 driver was
> forgotten. This patch adds the expected code.
>=20
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>

looks good.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig32EF564A7518EB87F5823C49
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAHvxAACgkQjTAFq1RaXHMYKwCdHgEy934CX6ArSjIFByqD5XBp
pw0AniPh0woIgSeCf60aApDrqaIh631u
=ufmd
-----END PGP SIGNATURE-----

--------------enig32EF564A7518EB87F5823C49--
