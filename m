From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: fix handling of unmodifiable configuration options
 fix
Date: Thu, 23 Jun 2016 10:57:04 +0200
Message-ID: <65d3bb99-ab73-4985-5553-4c7c05c1889f@pengutronix.de>
References: <1466504047-5110-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="POUKsmX4XvijKnbF4ueR1Mtqj7oJn07so"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48258 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751782AbcFWI5P (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 Jun 2016 04:57:15 -0400
In-Reply-To: <1466504047-5110-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--POUKsmX4XvijKnbF4ueR1Mtqj7oJn07so
Content-Type: multipart/mixed; boundary="MehcGUJQUPLxSVfmLC37kVIjOCtauS4e8"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Message-ID: <65d3bb99-ab73-4985-5553-4c7c05c1889f@pengutronix.de>
Subject: Re: [PATCH] can: fix handling of unmodifiable configuration options
 fix
References: <1466504047-5110-1-git-send-email-socketcan@hartkopp.net>
In-Reply-To: <1466504047-5110-1-git-send-email-socketcan@hartkopp.net>

--MehcGUJQUPLxSVfmLC37kVIjOCtauS4e8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/21/2016 12:14 PM, Oliver Hartkopp wrote:
> With upstream commit bb208f144cf3f59 (can: fix handling of unmodifiable=

> configuration options) a new can_validate() function was introduced.
>=20
> When invoking 'ip link set can0 type can' without any configuration dat=
a
> can_validate() tries to validate the content without taking into accoun=
t that
> there's totally no content. This patch adds a check for missing content=
=2E
>=20
> Reported-by: ajneu <ajneu1@gmail.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Applied to can + stable on Cc.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--MehcGUJQUPLxSVfmLC37kVIjOCtauS4e8--

--POUKsmX4XvijKnbF4ueR1Mtqj7oJn07so
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXa6RgAAoJED07qiWsqSVq3RIH/14Zqhg38+U6KsHNPm7lPTGH
mFO06+o/21CeZgUeDZe79zeANnLF04eUSQvVZYNMXvmJ6ZAOwmk8qXgeB0M7Q+tn
7lF65pkY90Nmj1OJA8p9SjHpisjE/K89tppE1ecYEMGZOM9t88hz724LDYYt+r4Y
JIngoc2K7MVve2Uy8XgGBfCUaWpPjU1ZmwUbSVUp5HvJEKsefUc73E0RW8Olg5G6
rVqK0Jl8x7ieJgbhg7febhE9RoNNm+Hu5NB/ovFHITksnhdSTVcW6b63SRd3dYup
WnnXDh3Qnxym3QCKVz4scuChUhwk6r1V9F8RlTMTY/VYV7F8m8vLT1FjPdo/e7U=
=K7nf
-----END PGP SIGNATURE-----

--POUKsmX4XvijKnbF4ueR1Mtqj7oJn07so--
