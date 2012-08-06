From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4 1/3] can: c_can: Modify c_can device names
Date: Mon, 06 Aug 2012 11:36:49 +0200
Message-ID: <501F9031.8050709@pengutronix.de>
References: <1343913191-14722-1-git-send-email-anilkumar@ti.com> <1343913191-14722-2-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC92103C594C96F3340F83AAD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56426 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754079Ab2HFJhF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 6 Aug 2012 05:37:05 -0400
In-Reply-To: <1343913191-14722-2-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, linux-can@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, anantgole@ti.com, nsekhar@ti.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC92103C594C96F3340F83AAD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/02/2012 03:13 PM, AnilKumar Ch wrote:
> Modify c_can device names from *_CAN_DEVTYPE to BOSCH_*_CAN to make
> use of same names for array indexes in c_can_id_table[] as well as
> device names.
>=20
> This patch also add indexes to c_can_id_table array.
>=20
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>

I'm taking patch 1 and 2. Runtime pm support seems to need discussion.

Applied to can-next/master

Tnx,
Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigC92103C594C96F3340F83AAD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAfkDYACgkQjTAFq1RaXHNsAQCgjo5cDoubtN7G0SbGZfL491ZY
zbEAn2EOCJm8H5VcqG7kMzBuae5lbaTr
=ZVp6
-----END PGP SIGNATURE-----

--------------enigC92103C594C96F3340F83AAD--
