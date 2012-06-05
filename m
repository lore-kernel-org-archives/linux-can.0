From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: flexcan_poll_error_state(struct net_device *dev, u32 reg_esr)
Date: Tue, 05 Jun 2012 09:46:05 +0200
Message-ID: <4FCDB93D.5030007@pengutronix.de>
References: <1338849280.43608.YahooMailNeo@web140802.mail.bf1.yahoo.com> <1338849547.86575.YahooMailNeo@web140805.mail.bf1.yahoo.com> <1338852261.93934.YahooMailNeo@web140802.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig858EA4CE45336673BC8CD955"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58786 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756843Ab2FEHqN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 5 Jun 2012 03:46:13 -0400
In-Reply-To: <1338852261.93934.YahooMailNeo@web140802.mail.bf1.yahoo.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Keith Jones <keith.rjones@yahoo.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig858EA4CE45336673BC8CD955
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/05/2012 01:24 AM, Keith Jones wrote:
> My kernel does not have "flexcan_poll_error_state" function in its
> flexcan.c file.  Is the following patch still valid?
>=20
> [RFC PATCH 07/14] can: flexcan: consolidate error state handling.=20

This patch series hasn't been applied yet.

> What would a good linux version to obtain a functioning flexcan
> driver for imx536?  My demo board is shipped with 2.6.35. I am able
> migrate to any version with appropriate patches.

Use v3.4. Your v2.6.35 is probably a freescale kernel, with a freescale
flexcan driver. The mainline driver should work with mx53.

cheers, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig858EA4CE45336673BC8CD955
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/NuUAACgkQjTAFq1RaXHPZfwCfYLLiy0cnN/A/GqK5RWBGVe+Y
HWkAn3QHmy9nroe1fseszb6nJY0l3hWx
=5Jlv
-----END PGP SIGNATURE-----

--------------enig858EA4CE45336673BC8CD955--
