From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v6] peak_pci: add support for PEAK-System PCIe/PCIeC/miniPCI
 cards
Date: Mon, 13 Feb 2012 10:12:54 +0100
Message-ID: <4F38D416.2020401@pengutronix.de>
References: <1328543212-9016-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA87E8059F505EAECB3C3DF3C"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45767 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552Ab2BMJNC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Feb 2012 04:13:02 -0500
In-Reply-To: <1328543212-9016-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA87E8059F505EAECB3C3DF3C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/06/2012 04:46 PM, Stephane Grosjean wrote:
> This patch adds the support for the following 3x sja1000 based PCI card=
s
> from PEAK-System Technik (www.peak-system.com):
>=20
> PCAN-PCI Express (1 or 2 channels)
> PCAN-ExpressCard (1 or 2 channels)
> PCAN-miniPCI (1 or 2 channels)
>=20
> The PCAN-ExpressCard card needs I2C bit-banging interface, so it must b=
e
> explicitly selected. Doing this automatically selects I2C and I2C_ALGOB=
IT
> bit-banging kernel configuration options.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> Acked-by: Wolfgang Grandegger <wg@grandegger.com>

I'm adding this patch to can-next, thank for your work!

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigA87E8059F505EAECB3C3DF3C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk841BsACgkQjTAFq1RaXHNdKACfUt2Ix2uKUbJPDgPpFyBhDQr6
sI4AnRQ9S8i8lGP+kk3O3sMbjqz//KL4
=QNUr
-----END PGP SIGNATURE-----

--------------enigA87E8059F505EAECB3C3DF3C--
