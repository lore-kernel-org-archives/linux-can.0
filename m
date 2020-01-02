From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: tcan4x5x: Turn on the power before parsing the
 config
Date: Thu, 2 Jan 2020 15:40:36 +0100
Message-ID: <a59d4384-9cb9-baaa-e5f4-1e2111e295c9@pengutronix.de>
References: <20191210163204.28225-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="0KU4DLo8SwRpHjvSqkuatOgkkGHa7Ksz3"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191210163204.28225-1-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0KU4DLo8SwRpHjvSqkuatOgkkGHa7Ksz3
Content-Type: multipart/mixed; boundary="0eQF700mEiUNKSVyqGioPj8OHXiNmWw4A";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dan Murphy <dmurphy@ti.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Message-ID: <a59d4384-9cb9-baaa-e5f4-1e2111e295c9@pengutronix.de>
Subject: Re: [PATCH v2] can: tcan4x5x: Turn on the power before parsing the
 config
References: <20191210163204.28225-1-dmurphy@ti.com>
In-Reply-To: <20191210163204.28225-1-dmurphy@ti.com>

--0eQF700mEiUNKSVyqGioPj8OHXiNmWw4A
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/10/19 5:32 PM, Dan Murphy wrote:
> The parse config function now performs action on the device either
> reading or writing and a reset.

BTW n+1:
Why is the function called parse_config? I don't see any parsing going on=
=2E

Please add it directly to the tcan4x5x_can_probe() function.

Marc
--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--0eQF700mEiUNKSVyqGioPj8OHXiNmWw4A--

--0KU4DLo8SwRpHjvSqkuatOgkkGHa7Ksz3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl4OAOQACgkQWsYho5Hk
nSCsXggAs4T5UKkkEcJzPQRv5NjpqncQ4dQpvNmXevnS+1syYyvrOf3ZIW5rA5ke
8mpmvsGotKjKQ4W+oVA4nY5S0xlIT2AuQFlx5aQAOkcxgEinb6qzyx1N+tXAPftT
Q4dqRJXZFqEvWSIUqMryrGa7Iq85ZkDM08TGjDcxm+/lA/5UHevCv7ULEb5W6/qo
C/XwTSnS0LprV40VCSG1i67RCVNJGLJLmWvjTZ9jgQq+90g/tHqCdWRQznsTBnIO
zwTVuNGti9183PIMMUtI88IkWTKqif547lrbxJQs7HBGPbAKBqX/4k3OUJzRUMoh
86AC2wQbYrF5erohGcTfGZgQyoX1Fg==
=83Gt
-----END PGP SIGNATURE-----

--0KU4DLo8SwRpHjvSqkuatOgkkGHa7Ksz3--
