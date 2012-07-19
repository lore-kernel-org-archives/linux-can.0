From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/6] can: janz-ican3: remove dead code
Date: Thu, 19 Jul 2012 10:02:06 +0200
Message-ID: <5007BEFE.3080203@pengutronix.de>
References: <1342650798-2991-1-git-send-email-iws@ovro.caltech.edu> <1342650798-2991-2-git-send-email-iws@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig09365B6D9AA31886C2A112DD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49603 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041Ab2GSICJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 19 Jul 2012 04:02:09 -0400
In-Reply-To: <1342650798-2991-2-git-send-email-iws@ovro.caltech.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig09365B6D9AA31886C2A112DD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/19/2012 12:33 AM, Ira W. Snyder wrote:
> From: "Ira W. Snyder" <iws@ovro.caltech.edu>
>=20
> The code which used this variable was removed during review, before the=

> driver was added to mainline Linux. It is now dead code, and can be
> removed.
>=20
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>

Looks good.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig09365B6D9AA31886C2A112DD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAHvv4ACgkQjTAFq1RaXHNDYwCfYrry/0zfXoXZ/RCASPu+mm/X
vl0AnjSx7Ra+m987uRFqrIQqMChjf2CQ
=5rXF
-----END PGP SIGNATURE-----

--------------enig09365B6D9AA31886C2A112DD--
