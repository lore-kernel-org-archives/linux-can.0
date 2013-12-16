From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 1/2] can: mcp251x: Convert to devm-* API
Date: Mon, 16 Dec 2013 11:17:29 +0100
Message-ID: <52AED339.8050102@pengutronix.de>
References: <1387116961-15261-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="JjD86OReVVhpjlqWAIaVxwW8abD0XUfJ2"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60372 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193Ab3LPKVT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 16 Dec 2013 05:21:19 -0500
In-Reply-To: <1387116961-15261-1-git-send-email-shc_work@mail.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JjD86OReVVhpjlqWAIaVxwW8abD0XUfJ2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2013 03:16 PM, Alexander Shiyan wrote:
> Replace existing resource handling in the driver with managed
> device resource, this ensures more consistent error values and
> simplifies error paths.
>=20
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Lookgs good, applied to can-next.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--JjD86OReVVhpjlqWAIaVxwW8abD0XUfJ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlKu0zoACgkQjTAFq1RaXHO55QCeNekH19dTkUSJ9JkQ7GyYT896
8Z4An3Fx9oVcnnm6FOkJix3sB5PubxdX
=Sqcj
-----END PGP SIGNATURE-----

--JjD86OReVVhpjlqWAIaVxwW8abD0XUfJ2--
