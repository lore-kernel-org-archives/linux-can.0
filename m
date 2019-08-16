From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: rcar_can: Remove unused platform data support
Date: Fri, 16 Aug 2019 09:06:15 +0200
Message-ID: <20456e4e-e56c-7e7e-c390-e959d0ef50d0@pengutronix.de>
References: <20190814092221.12959-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="AdrRRVl7yIBdNyNfHGtSq1Oj7rO0sdXKi"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190814092221.12959-1-geert+renesas@glider.be>
Sender: netdev-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Wolfgang Grandegger <wg@grandegger.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: "David S . Miller" <davem@davemloft.net>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AdrRRVl7yIBdNyNfHGtSq1Oj7rO0sdXKi
Content-Type: multipart/mixed; boundary="S6sBI0XHi3tQ8SIYfRXrgceCgNgXSB2w0";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-can@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org
Message-ID: <20456e4e-e56c-7e7e-c390-e959d0ef50d0@pengutronix.de>
Subject: Re: [PATCH] can: rcar_can: Remove unused platform data support
References: <20190814092221.12959-1-geert+renesas@glider.be>
In-Reply-To: <20190814092221.12959-1-geert+renesas@glider.be>

--S6sBI0XHi3tQ8SIYfRXrgceCgNgXSB2w0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 8/14/19 11:22 AM, Geert Uytterhoeven wrote:
> All R-Car platforms use DT for describing CAN controllers.
> R-Car CAN platform data support was never used in any upstream kernel.
>=20
> Move the Clock Select Register settings enum into the driver, and remov=
e
> platform data support and the corresponding header file.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied to can-next-testing.

tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--S6sBI0XHi3tQ8SIYfRXrgceCgNgXSB2w0--

--AdrRRVl7yIBdNyNfHGtSq1Oj7rO0sdXKi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl1WVecACgkQWsYho5Hk
nSDU5ggAgyN9BwVFh/xMh10s6ONd5da1RQxGFEF3oehwPxxMasBRfiGMYeUecz84
E4hNoKapYtG78o7FiR7sL0YWJU6WP6lrAF7U04rByw/vJjlokd+kskkxd5niYhCf
G/xbSe1+xSSfzbEGzgQ8hh5IvEqvm2G16V3wRyqO8ET59A9FXCUilhcFwlHAqvnV
cX0nP0IA+yf6c7nGczCUS8QyaJymmKkBu15wmXieDrsh8Gj7oKoDuxHXV86/OHPX
1hfzRSBWK5zb9hX9U7AP6vSUpRTV3tphtAPx/nBzxOHuVwP29Wl0qLMAQgbRVGl4
T+2ZafWFCUKjp82Wr6HH1nzcaKkJ/Q==
=hKXp
-----END PGP SIGNATURE-----

--AdrRRVl7yIBdNyNfHGtSq1Oj7rO0sdXKi--
