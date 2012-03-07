From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] peak_usb: PCAN-USB specific part: fix little endian usage
Date: Wed, 07 Mar 2012 15:55:56 +0100
Message-ID: <4F5776FC.7000007@pengutronix.de>
References: <1331130691-25782-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig69AB154D75E56F6B1DAE2C2F"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34118 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964784Ab2CGO4O (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Mar 2012 09:56:14 -0500
In-Reply-To: <1331130691-25782-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, linux-usb Mailing List <linux-usb@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig69AB154D75E56F6B1DAE2C2F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/07/2012 03:31 PM, Stephane Grosjean wrote:
> That patch fixes some bad usage of two little-endian variables, which l=
ead to
> some warning/error when building the peak_usb driver.
>=20
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

Thanks - looks good. Applied to can-next.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig69AB154D75E56F6B1DAE2C2F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9Xdv8ACgkQjTAFq1RaXHOPUgCfbmTIsc0enW9TmhjQiZZ5D6qO
kVAAniBfni6l1O5ubc6NQIcFe0Xcfosy
=rzci
-----END PGP SIGNATURE-----

--------------enig69AB154D75E56F6B1DAE2C2F--
