From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 2/2] can: mcp251x: Add device tree support
Date: Mon, 16 Dec 2013 11:20:04 +0100
Message-ID: <52AED3D4.40608@pengutronix.de>
References: <1387116961-15261-1-git-send-email-shc_work@mail.ru> <1387116961-15261-2-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="uKPgCUqLcKU5OWlNbdb491tnVPhL25Igc"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60371 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190Ab3LPKVT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 16 Dec 2013 05:21:19 -0500
In-Reply-To: <1387116961-15261-2-git-send-email-shc_work@mail.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uKPgCUqLcKU5OWlNbdb491tnVPhL25Igc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cOn 12/15/2013 03:16 PM, Alexander Shiyan wrote:
> This patch adds Device Tree support to the Microchip MCP251X driver.

What about completing the clock support for the driver, too? You get the
clock, but it's never enabled. It probably works on your board because
it's a fixed always on clock.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--uKPgCUqLcKU5OWlNbdb491tnVPhL25Igc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlKu09QACgkQjTAFq1RaXHP16QCeMx2cCu+0/5g0dOBypPeaofTi
qeIAoJFr12eHCrEhZtqYvQ3l1pxLU/Xg
=1vg7
-----END PGP SIGNATURE-----

--uKPgCUqLcKU5OWlNbdb491tnVPhL25Igc--
