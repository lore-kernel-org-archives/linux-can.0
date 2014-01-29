From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Janz ICAN3 build warnings
Date: Wed, 29 Jan 2014 21:30:43 +0100
Message-ID: <52E964F3.9040007@pengutronix.de>
References: <52E90BEB.9040608@hartkopp.net> <20140129175824.GC20561@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Pbiga6rnTKftbcEGoKClr7QNhpbdV59Sp"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60082 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbaA2Uax (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 29 Jan 2014 15:30:53 -0500
In-Reply-To: <20140129175824.GC20561@ovro.caltech.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Pbiga6rnTKftbcEGoKClr7QNhpbdV59Sp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/29/2014 06:58 PM, Ira W. Snyder wrote:
> From 90dd8d23b90d837d8d2bc5d53d0319b15f1db5a8 Mon Sep 17 00:00:00 2001
> From: "Ira W. Snyder" <iws@ovro.caltech.edu>
> Date: Wed, 29 Jan 2014 09:51:48 -0800
> Subject: [PATCH] can: janz-ican3: fix uninitialized variable warnings
>=20
> Analysis of the code shows that the struct ican3_msg variable cannot be=

> used uninitialized. Error conditions are checked and the loop terminate=
s
> before calling the ican3_handle_message() function with an uninitialize=
d
> value.
>=20
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>

Applied to can/master.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Pbiga6rnTKftbcEGoKClr7QNhpbdV59Sp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLpZPQACgkQjTAFq1RaXHOoEQCgjkJ/dDPZFOO6VxXe9kUb8WSz
wdYAmgPSAa1xluLgnisFs2ZAGxiIT+1c
=i6WF
-----END PGP SIGNATURE-----

--Pbiga6rnTKftbcEGoKClr7QNhpbdV59Sp--
