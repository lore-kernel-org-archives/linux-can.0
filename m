From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v6.1] peak_pci: add support for PEAK-System PCIe/PCIeC/miniPCI
 cards
Date: Mon, 20 Feb 2012 13:26:00 +0100
Message-ID: <4F423BD8.3090302@pengutronix.de>
References: <1329736262-21095-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0C16DD5A6595D4993D1EFBA0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52511 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab2BTM0G (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 20 Feb 2012 07:26:06 -0500
In-Reply-To: <1329736262-21095-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0C16DD5A6595D4993D1EFBA0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/20/2012 12:11 PM, Stephane Grosjean wrote:
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

Oliver can you find time to check if the i2c problem is gone? I think
we've still have time to get this patch into the next kernel release.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig0C16DD5A6595D4993D1EFBA0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9CO9sACgkQjTAFq1RaXHOwLQCeM1tmv6sBfrL0M+CNpIcjaSt7
gq0Ani7ed2RVj3DD1u+4CJBo54pXjRrx
=e6IN
-----END PGP SIGNATURE-----

--------------enig0C16DD5A6595D4993D1EFBA0--
