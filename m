From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can.h: Fix can error class mask dir path
Date: Mon, 23 Jul 2018 13:45:51 +0200
Message-ID: <d1ceff63-a5ad-894e-43a4-c237bbe48d22@pengutronix.de>
References: <20180529202612.4873-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="aIqZSDHx1vCu6kpYIcu2PuE77g4zrxMHf"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180529202612.4873-1-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, socketcan@hartkopp.net, linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aIqZSDHx1vCu6kpYIcu2PuE77g4zrxMHf
Content-Type: multipart/mixed; boundary="Ddgq5eDBfXedFv5iIiEAPiRi4YjYQeOD0";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dan Murphy <dmurphy@ti.com>, socketcan@hartkopp.net,
 linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Message-ID: <d1ceff63-a5ad-894e-43a4-c237bbe48d22@pengutronix.de>
Subject: Re: [PATCH] can.h: Fix can error class mask dir path
References: <20180529202612.4873-1-dmurphy@ti.com>
In-Reply-To: <20180529202612.4873-1-dmurphy@ti.com>

--Ddgq5eDBfXedFv5iIiEAPiRi4YjYQeOD0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 05/29/2018 10:26 PM, Dan Murphy wrote:
> The CAN error masks header file is in the
> include/uapi directory.
>=20
> Fix the path in the header to the correct location.
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

Applied to linux-can-next.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Ddgq5eDBfXedFv5iIiEAPiRi4YjYQeOD0--

--aIqZSDHx1vCu6kpYIcu2PuE77g4zrxMHf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAltVv+8ACgkQk9IU1zQo
ZfHnqQf3Q7HVaUiZDMa4fsr+o7dp9iefnT9lnlvfyC1uONYkQWugButtC3Ia+CdQ
+oPMFSy0+lAOy6vjXB8Cr2xzjYRZ08hHaclhmXEifOz0PyXc8AVTS+7sc7BC4EiJ
yFk1suFpKRc0F5ZHlbcBTYWaSx/mnjEyxrbOZ9E4KggBzfCl1i/GsgITFmB6TaSR
2xylJWgd15S7ehPg93LIQsAQ/Jx+Wen+YdqSo1AHVBkIv2f5oYy9WzkmI7Tc/5wQ
9RwV2gmCCpZ6QQWGBXhn/hu2268LMNgyIz4aXmjfmgi2XDw/J4oVqyCWkirw5XOY
f6sDfxrhbvuxW9Msq6fFIRY1OPBK
=irG7
-----END PGP SIGNATURE-----

--aIqZSDHx1vCu6kpYIcu2PuE77g4zrxMHf--
