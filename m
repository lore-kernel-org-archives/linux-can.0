From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/3] can: janz-ican3: increase tx buffer size
Date: Fri, 13 Jul 2012 11:00:31 +0200
Message-ID: <4FFFE3AF.4020907@pengutronix.de>
References: <1342109732-4995-1-git-send-email-iws@ovro.caltech.edu> <1342109732-4995-3-git-send-email-iws@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2C940CE5927A542E26FD3DAB"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45183 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097Ab2GMJAd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 13 Jul 2012 05:00:33 -0400
In-Reply-To: <1342109732-4995-3-git-send-email-iws@ovro.caltech.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2C940CE5927A542E26FD3DAB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/12/2012 06:15 PM, Ira W. Snyder wrote:
> From: "Ira W. Snyder" <iws@ovro.caltech.edu>
>=20
> Using an skb queue allows the driver to increase the buffer size withou=
t
> any difficult index management.

Looks interesting, can you squash into the first patch for easier review?=


Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig2C940CE5927A542E26FD3DAB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk//468ACgkQjTAFq1RaXHM7qACgmDdqvBdPHzSambLzOBMUNN1+
oawAn3ISLt7H8UTbUEbG5RrwnAQRkxF7
=4UfV
-----END PGP SIGNATURE-----

--------------enig2C940CE5927A542E26FD3DAB--
