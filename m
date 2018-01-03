From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] flex_can: Correct the checking for frame length in
 flexcan_start_xmit()
Date: Wed, 3 Jan 2018 11:35:40 +0100
Message-ID: <ba6946a4-95eb-9944-3aa5-87a13dd800d0@pengutronix.de>
References: <1514864658-13194-1-git-send-email-phu.luuan@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="KDqxDTuFOrhbhoiD2G2D58w6u4enjNDTX"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1514864658-13194-1-git-send-email-phu.luuan@nxp.com>
Sender: netdev-owner@vger.kernel.org
To: Luu An Phu <phu.luuan@nxp.com>, wg@grandegger.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, stefan-gabriel.mirea@nxp.com
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KDqxDTuFOrhbhoiD2G2D58w6u4enjNDTX
Content-Type: multipart/mixed; boundary="DOIcr5JRnuzF5ycxSnZt6AsOcxvc9ZDxa";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Luu An Phu <phu.luuan@nxp.com>, wg@grandegger.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 stefan-gabriel.mirea@nxp.com
Message-ID: <ba6946a4-95eb-9944-3aa5-87a13dd800d0@pengutronix.de>
Subject: Re: [PATCH] flex_can: Correct the checking for frame length in
 flexcan_start_xmit()
References: <1514864658-13194-1-git-send-email-phu.luuan@nxp.com>
In-Reply-To: <1514864658-13194-1-git-send-email-phu.luuan@nxp.com>

--DOIcr5JRnuzF5ycxSnZt6AsOcxvc9ZDxa
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 01/02/2018 04:44 AM, Luu An Phu wrote:
> From: "phu.luuan" <phu.luuan@nxp.com>
>=20
> The flexcan_start_xmit() function compares the frame length with data r=
egister
> length to write frame content into data[0] and data[1] register. Data r=
egister
> length is 4 bytes and frame maximum length is 8 bytes.
>=20
> Fix the check that compares frame length with 3. Because the register l=
ength
> is 4.
>=20
> Signed-off-by: Luu An Phu <phu.luuan@nxp.com>

Applied to can.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--DOIcr5JRnuzF5ycxSnZt6AsOcxvc9ZDxa--

--KDqxDTuFOrhbhoiD2G2D58w6u4enjNDTX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpMsf8ACgkQHv7KIOw4
HPbLWwgAgkAuJxN/Qjm3gV0kq/qj0Cd+qGUajP3rukCKnkaUZcJN38XC0pBKEzt+
DVArc0attaiBRtcPOC27ZlFoQA8CuD4TyFSYOuuPc4wwG3oZjYOIUMt5+JmLRoz2
uDrPsO3z6HQMwaHhp7yL88+fJaFKD0Y5I7omnKI3SIS4aqRIwTGDuRS763em9pfZ
QnYgibCqMg5WfaW8ll2d1TWH+GhaMu8PL+Xgdo6VuoyNdG4dtykfKFjqQIaMAYL4
VSfL+0oE6Hwr0IZsDHwcB510UYbdeDr4ybF5hyLlIMlWRc7+qz7YpXWz6uiV8JaM
2qzwABPicKjMBRlMhp02Y1OJXXWSLA==
=ZkeF
-----END PGP SIGNATURE-----

--KDqxDTuFOrhbhoiD2G2D58w6u4enjNDTX--
