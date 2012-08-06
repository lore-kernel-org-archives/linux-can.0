From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4 2/3] can: c_can: Add device tree support to Bosch C_CAN/D_CAN
 controller
Date: Mon, 06 Aug 2012 11:37:28 +0200
Message-ID: <501F9058.1050407@pengutronix.de>
References: <1343913191-14722-1-git-send-email-anilkumar@ti.com> <1343913191-14722-3-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8C2AA486D82210D6B7E5179B"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59406 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104Ab2HFJhh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 6 Aug 2012 05:37:37 -0400
In-Reply-To: <1343913191-14722-3-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, linux-can@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, anantgole@ti.com, nsekhar@ti.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8C2AA486D82210D6B7E5179B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/02/2012 03:13 PM, AnilKumar Ch wrote:
> Add device tree support to C_CAN/D_CAN controller and usage details
> are added to device tree documentation. Driver was tested on AM335x
> EVM.
>=20
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>

Applied to can-next/master

tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig8C2AA486D82210D6B7E5179B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAfkFkACgkQjTAFq1RaXHNXJACfeykiC3WSp2vF1+6YcHp3Lb20
OVIAoIj7BsqTsGJ0A0IrhQrbdsxq/quF
=0pfJ
-----END PGP SIGNATURE-----

--------------enig8C2AA486D82210D6B7E5179B--
