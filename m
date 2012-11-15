From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v9] can: grcan: Add device driver for GRCAN and GRHCAN
 cores
Date: Thu, 15 Nov 2012 21:32:06 +0100
Message-ID: <50A55146.5050008@pengutronix.de>
References: <50A3B4DB.40502@pengutronix.de> <1352965634-26663-1-git-send-email-andreas@gaisler.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig68360BC90475DD30CE670F2D"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51707 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768923Ab2KOUcU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 15 Nov 2012 15:32:20 -0500
In-Reply-To: <1352965634-26663-1-git-send-email-andreas@gaisler.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, devicetree-discuss@lists.ozlabs.org, software@gaisler.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig68360BC90475DD30CE670F2D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/15/2012 08:47 AM, Andreas Larsson wrote:
> This driver supports GRCAN and CRHCAN CAN controllers available in the =
GRLIB
> VHDL IP core library.
>=20
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
> Acked-by: Wolfgang Grandegger <wg@grandegger.com>

Applied to can-next/master - and included in the pull-reqeust I just
sent to David.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig68360BC90475DD30CE670F2D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlClUUYACgkQjTAFq1RaXHOBWACglDxURLOkTxjiVa9ldAY6/S6R
aocAnRlgk1s2n55ol07mo+2VYqdvPOH7
=tBLH
-----END PGP SIGNATURE-----

--------------enig68360BC90475DD30CE670F2D--
