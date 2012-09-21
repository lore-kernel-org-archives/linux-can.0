From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v5] can: sja1000: Add support for listen-only mode and
 one-shot mode
Date: Fri, 21 Sep 2012 10:08:54 +0200
Message-ID: <505C2096.3020808@pengutronix.de>
References: <5059F783.5030200@hartkopp.net> <1348127441-2165-1-git-send-email-andreas@gaisler.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7443271C5C541F5685AD9459"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59709 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754914Ab2IUIJK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 21 Sep 2012 04:09:10 -0400
In-Reply-To: <1348127441-2165-1-git-send-email-andreas@gaisler.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: linux-can@vger.kernel.org, software@gaisler.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7443271C5C541F5685AD9459
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/20/2012 09:50 AM, Andreas Larsson wrote:
> One-shot mode uses the TCS bit of the status register to discern
> whether a transmission was successful or not. On a failed
> transmission, the frame is not echoed back.
>=20
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Applied to can-next.

Tnx, Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig7443271C5C541F5685AD9459
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBcIJoACgkQjTAFq1RaXHNXIwCfXyHUaD8EA9cPT+M9DoGQDUsR
2J4An15VOBGcy9+LDihN5pN+C4ws5CwZ
=c0P9
-----END PGP SIGNATURE-----

--------------enig7443271C5C541F5685AD9459--
