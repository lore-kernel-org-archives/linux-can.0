From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: use devm_platform_ioremap_resource() to
 simplify code
Date: Fri, 4 Oct 2019 23:10:35 +0200
Message-ID: <246a3760-d8e0-cc52-6d46-f6f4c350ea51@pengutronix.de>
References: <20190929082854.11952-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="OuQhmicYX9t4n2PLAXo3R8NEu2Gq0dsEJ"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190929082854.11952-1-qiangqing.zhang@nxp.com>
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "sean@geanix.com" <sean@geanix.com>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OuQhmicYX9t4n2PLAXo3R8NEu2Gq0dsEJ
Content-Type: multipart/mixed; boundary="iKbLX40TPLku3VHIdDyM7ISs763CJx9Wl";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "sean@geanix.com" <sean@geanix.com>, dl-linux-imx <linux-imx@nxp.com>
Message-ID: <246a3760-d8e0-cc52-6d46-f6f4c350ea51@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: use devm_platform_ioremap_resource() to
 simplify code
References: <20190929082854.11952-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20190929082854.11952-1-qiangqing.zhang@nxp.com>

--iKbLX40TPLku3VHIdDyM7ISs763CJx9Wl
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 9/29/19 10:32 AM, Joakim Zhang wrote:
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together to simplif=
y
> the code.
>=20
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>

Applied to linux-can-next.

tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--iKbLX40TPLku3VHIdDyM7ISs763CJx9Wl--

--OuQhmicYX9t4n2PLAXo3R8NEu2Gq0dsEJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl2XtUsACgkQWsYho5Hk
nSAa3Qf9GOnHb7vZe2FZVqafL8p7QAJPAhLPLgFL9OuVcggBhLNKM0w2w/pBf9x9
IkcMbFWJkkn3VL4ONq+q10MFcjvXt5uanZyExeKyV37Ze8NRhYaGytBn8kO+KAs1
gWjhLgtCZecxLAZ5MomS4T7SKo2w0i2xX+y42J62CDnZAy52DenyHyZ2XHKPC6tw
lH51ljfaDkTFez2ykuecYXXCWT97lImOl+myPBk4WIUpbOpWTq5VYz2GgvLsYkFL
lAGwE4hv4UU7Kb6f2px3EwBCt/p8EJfymtVUZOK1R5Q0e9HBHClVTopvOH6yDBN4
2ZTcHiBhvZ+tiwR5ZdnZbt7N5+9s/g==
=f3bq
-----END PGP SIGNATURE-----

--OuQhmicYX9t4n2PLAXo3R8NEu2Gq0dsEJ--
