From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: mcp251x: add message about sucessful/unsuccessful
 probe
Date: Wed, 22 Jun 2016 22:38:31 +0200
Message-ID: <a24a8bbb-d9e5-8b8d-d3e6-f88c479f23fa@pengutronix.de>
References: <1466448015-20392-1-git-send-email-edo.rus@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="kEhBrIHvcuHavjuOXN5VvdjM042rCDIkR"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:59557 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752136AbcFVUii (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 22 Jun 2016 16:38:38 -0400
In-Reply-To: <1466448015-20392-1-git-send-email-edo.rus@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ed Spiridonov <edo.rus@gmail.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kEhBrIHvcuHavjuOXN5VvdjM042rCDIkR
Content-Type: multipart/mixed; boundary="0CEXrCV3HEIqsVBsGwUHMha2wW5JbIhbO"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ed Spiridonov <edo.rus@gmail.com>
Cc: linux-can@vger.kernel.org
Message-ID: <a24a8bbb-d9e5-8b8d-d3e6-f88c479f23fa@pengutronix.de>
Subject: Re: [PATCH v2] can: mcp251x: add message about sucessful/unsuccessful
 probe
References: <1466448015-20392-1-git-send-email-edo.rus@gmail.com>
In-Reply-To: <1466448015-20392-1-git-send-email-edo.rus@gmail.com>

--0CEXrCV3HEIqsVBsGwUHMha2wW5JbIhbO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/20/2016 08:40 PM, Ed Spiridonov wrote:
> Silent ignorance of errors during probe procedure is a bad thing, this =
patch fixes it.
> Extra message added for hardware initialization failure. Such common is=
sues are mostly caused by wrong wiring.
> Message about success added as well, it should be useful to debug new h=
ardware configuration, especially in case of several CAN buses.
>=20
> Signed-off-by: Ed Spiridonov <edo.rus@gmail.com>

Applied to can-next.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--0CEXrCV3HEIqsVBsGwUHMha2wW5JbIhbO--

--kEhBrIHvcuHavjuOXN5VvdjM042rCDIkR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXavdHAAoJED07qiWsqSVqS68H/1AkSH1uymI8HjxEYkmB+Pok
EwllXytK4MlkxVSF1Cx/91bliGEw/OQQpvs4wdPAG4c3TFNznEzOODmpaWK0SOmN
UP57WaQ6tzJaX9dX8GM2uwGJI07vjhu/yPh1I227uryMxZGOt8DhPzydySvmTe/U
w4V2UFdN6ctI2NY4GwTvzGVYPHJNezNf8yuIVw/5aUSJV/xG5L6JqQGcPVJabvVv
BQAyKJpYnwIRIxnAE6Uou22fA0a5tWJfQjjg/nHXQCBvsVgZFLOQP0QLJhzrPUQ/
+WfPM0JGhoawxW9tT++54y/E/QlS+TpYTOXXBhSbkCUcg5BT6tuk0ExAoIwc00Q=
=hJhJ
-----END PGP SIGNATURE-----

--kEhBrIHvcuHavjuOXN5VvdjM042rCDIkR--
