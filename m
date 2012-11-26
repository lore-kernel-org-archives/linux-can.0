From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] slcanpty.c Remove one Bug
Date: Mon, 26 Nov 2012 15:13:32 +0100
Message-ID: <50B3790C.5010506@pengutronix.de>
References: <50B2B3E7.5040202@myvdr.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0B45ED770861116B2691FF40"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48498 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147Ab2KZONi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Nov 2012 09:13:38 -0500
In-Reply-To: <50B2B3E7.5040202@myvdr.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ulrich Escher <ulrich.escher@myvdr.de>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0B45ED770861116B2691FF40
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 11/26/2012 01:12 AM, Ulrich Escher wrote:
> It is an error to overwrite nbytes at this point.
> LG Ulrich

Can you make the patch description a bit more verbose. With this patch
alone it's impossible to see what's the nbytes is used for and what is
the bug here.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig0B45ED770861116B2691FF40
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlCzeQ8ACgkQjTAFq1RaXHOEJACgj7VErYgY5HvhRjFU4bnaNxTz
I5cAn06xFUPQABHKqy5A+AmHuMuWZ+CR
=rKSz
-----END PGP SIGNATURE-----

--------------enig0B45ED770861116B2691FF40--
