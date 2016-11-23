From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/3] arm64: dts: r8a7796: Add CAN/CAN FD support
Date: Wed, 23 Nov 2016 14:18:13 +0100
Message-ID: <f358442c-8373-328c-1270-709498c133f5@pengutronix.de>
References: <1479903243-1860-1-git-send-email-chris.paterson2@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="5AWre6HoBj99473JvGJdx2ubEOfsJo6mf"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:34551 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S936078AbcKWNSj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Nov 2016 08:18:39 -0500
In-Reply-To: <1479903243-1860-1-git-send-email-chris.paterson2@renesas.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Chris Paterson <chris.paterson2@renesas.com>, Simon Horman <horms@verge.net.au>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5AWre6HoBj99473JvGJdx2ubEOfsJo6mf
Content-Type: multipart/mixed; boundary="1XSjpWkA0jnegLIwJasNRRk5U0uI8rTVu";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Chris Paterson <chris.paterson2@renesas.com>,
 Simon Horman <horms@verge.net.au>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
 Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org
Message-ID: <f358442c-8373-328c-1270-709498c133f5@pengutronix.de>
Subject: Re: [PATCH 0/3] arm64: dts: r8a7796: Add CAN/CAN FD support
References: <1479903243-1860-1-git-send-email-chris.paterson2@renesas.com>
In-Reply-To: <1479903243-1860-1-git-send-email-chris.paterson2@renesas.com>

--1XSjpWkA0jnegLIwJasNRRk5U0uI8rTVu
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/23/2016 01:14 PM, Chris Paterson wrote:
> This patch series adds CAN and CAN FD support to the r8a7796.
>=20
> Based on renesas-devel-20161122-v4.9-rc6.
>=20
> Chris Paterson (3):
>   arm64: dts: r8a7796: Add CAN external clock support
>   arm64: dts: r8a7796: Add CAN support
>   arm64: dts: r8a7796: Add CAN FD support
>=20
>  .../devicetree/bindings/net/can/rcar_can.txt       | 12 +++--
>  .../devicetree/bindings/net/can/rcar_canfd.txt     | 12 +++--
>  arch/arm64/boot/dts/renesas/r8a7796.dtsi           | 61 ++++++++++++++=
++++++++
>  3 files changed, 75 insertions(+), 10 deletions(-)

For all three:

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Who takes this series?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--1XSjpWkA0jnegLIwJasNRRk5U0uI8rTVu--

--5AWre6HoBj99473JvGJdx2ubEOfsJo6mf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAlg1lxUACgkQPTuqJayp
JWqV3Qf/UIxAPEdr16NQVBQGedsA0TU1be8nZp8v7mDblV4piUieSxAT00/NpRoC
4UHb5qDYiB28/ezkYdD2FFqclFedEEVUmDuPv5wbFHEPM2DofVCbYRRmyxSDcntE
vlZWV7Kxgn0peYjDk3Dlg+11EZXpxyL8jdkQTwRupBnk2kVFe7akgG2A/KHUBaH/
gA3RnytWj9uh69QtbPmXlTBOFqrp02Qo64IO8xVayxw8d3PIQqPrNZ7Q8nsJrYd5
Kg/ADMTOb76+YlLrVUmOU6BoeqF8dfnRW+vYpzy7NsngMKBI6QNtVEE2clMXak9+
9BaVtqofZr7o8S7U3Og6barqANluPg==
=a8NU
-----END PGP SIGNATURE-----

--5AWre6HoBj99473JvGJdx2ubEOfsJo6mf--
