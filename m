From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/2] can: flexcan: add PE clock source select support
Date: Wed, 27 Feb 2019 09:46:36 +0100
Message-ID: <47070f2a-4500-4b48-3718-66569a7cc89e@pengutronix.de>
References: <20181213070537.25095-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Pxt92AojrID2iTJjmoEINMPYia0lteG9L"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181213070537.25095-1-qiangqing.zhang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "robh@kernel.org" <robh@kernel.org>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Pxt92AojrID2iTJjmoEINMPYia0lteG9L
Content-Type: multipart/mixed; boundary="ZIague0BYWJEhUNEZMuuEtcgl8yXde2qF";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "robh@kernel.org"
 <robh@kernel.org>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>
Message-ID: <47070f2a-4500-4b48-3718-66569a7cc89e@pengutronix.de>
Subject: Re: [PATCH 0/2] can: flexcan: add PE clock source select support
References: <20181213070537.25095-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20181213070537.25095-1-qiangqing.zhang@nxp.com>

--ZIague0BYWJEhUNEZMuuEtcgl8yXde2qF
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/13/18 8:07 AM, Joakim Zhang wrote:
> The patch set intends to add support for PE clock source select. The
> FlexCAN controller can parse "fsl,clk-source" property from device tree=

> to select clock source.
>=20
> Dong Aisheng (2):
>   Documentation: can: flexcan: add PE clock source property to device
>     tree
>   can: flexcan: add support for PE clock source select
>=20
>  .../bindings/net/can/fsl-flexcan.txt           |  8 ++++++++
>  drivers/net/can/flexcan.c                      | 18 ++++++++++++++----=

>  2 files changed, 22 insertions(+), 4 deletions(-)

Added to linux-can-next.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ZIague0BYWJEhUNEZMuuEtcgl8yXde2qF--

--Pxt92AojrID2iTJjmoEINMPYia0lteG9L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAlx2TmwACgkQWsYho5Hk
nSBJJAf/XS4wwLi3WpzG4/I78kZgTghRlX1Ij7pyH6LaQOGzrYM7m4GNtcHkuUvz
jf/hqkzRssHQwSNp9qpIa+beO13ZK94xjh+uNL8dDz54MOG3iLRW763ocyozWmCq
BAwLqXvuP0AbBm7kvK4T3rRB/EbhTfMzaq307xhR7/Ffy5PjpaJ69Wz+whvpxxt/
KA7RFKPH/YL3mJWWIIHsad3ALlbeCXCcIU320iCCSgQp20/bf3uywZgYYLAZ9ZRn
1fvwfdjx556Gim/yBUOiT+W6drPOkg0AhQV6qd/vt51ftV8usLiZQO52umMGdSHN
P/NuJkmN1CCiAl8lNar/fdh2YHseDQ==
=22EH
-----END PGP SIGNATURE-----

--Pxt92AojrID2iTJjmoEINMPYia0lteG9L--
