From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: ucan: fix non-atomic allocation in completion
 handler
Date: Tue, 3 Dec 2019 11:07:46 +0100
Message-ID: <6bb1865a-ecfd-6fb4-0621-0fa2c7693aec@pengutronix.de>
References: <20191128182603.22004-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="JnoY2PbaAEAL5dQV9OIN73qLYQw3HAP20"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191128182603.22004-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>, Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>, Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>, Martin Elshuber <martin.elshuber@theobroma-systems.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JnoY2PbaAEAL5dQV9OIN73qLYQw3HAP20
Content-Type: multipart/mixed; boundary="aW3TfrPLtE7jtOJRGUnuzATBqHuU3ZHsv";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Johan Hovold <johan@kernel.org>, Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>,
 Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>,
 Martin Elshuber <martin.elshuber@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Message-ID: <6bb1865a-ecfd-6fb4-0621-0fa2c7693aec@pengutronix.de>
Subject: Re: [PATCH] can: ucan: fix non-atomic allocation in completion
 handler
References: <20191128182603.22004-1-johan@kernel.org>
In-Reply-To: <20191128182603.22004-1-johan@kernel.org>

--aW3TfrPLtE7jtOJRGUnuzATBqHuU3ZHsv
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/28/19 7:26 PM, Johan Hovold wrote:
> USB completion handlers are called in atomic context and must
> specifically not allocate memory using GFP_KERNEL.
>=20
> Fixes: 9f2d3eae88d2 ("can: ucan: add driver for Theobroma Systems UCAN =
devices")
> Cc: stable <stable@vger.kernel.org>     # 4.19
> Cc: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
> Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>
> Cc: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Added to linux-can.

tnx,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--aW3TfrPLtE7jtOJRGUnuzATBqHuU3ZHsv--

--JnoY2PbaAEAL5dQV9OIN73qLYQw3HAP20
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3mM/IACgkQWsYho5Hk
nSCuTgf/fwPYT7PvRKMrRRKbuCiqAnUaOvo85yVfBkEzrLkcIkXCaCpxvncLjJ+W
xhfittVwuCMkM1ed/W6M3a90qn48XR8tlfqoL4TK9rpNczgeowZg7/iHOM8Jdofs
nSOG9xGmd2oz3cZH6nd7pkEswRLqNZ8qgmxxxOSvT/17w2fFqVsZqZJ+jQOci6um
dGpsA6Nf9rmX2+ibTLBdp/Ley+27eZ1ezgrsGFPokaHumMpJLlNw08EbtGfAzAjO
+VXcPDXZWgN6wHIOJpSjsMpsOk1IuTLwP98bdUWI/TBKJl8uuHDaj2zqZ+G0JvZA
UC7QgRTucSHb2HoBa+xyDB6EzCHcOg==
=8qrr
-----END PGP SIGNATURE-----

--JnoY2PbaAEAL5dQV9OIN73qLYQw3HAP20--
