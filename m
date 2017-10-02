From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/4] can: flexcan: fix state transition, suppress irq
 flooding
Date: Mon, 2 Oct 2017 12:12:45 +0200
Message-ID: <ad3f6258-609c-bc1e-a26c-778dc792b463@pengutronix.de>
References: <da2a7a180eb8445f8fc6539aeca5d44e@SI-MBX1030.de.bosch.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="gJ98KJo3WnqUNtu0tsEjXN1mbqjNwIIn3"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:35653 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750957AbdJBKM5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 2 Oct 2017 06:12:57 -0400
In-Reply-To: <da2a7a180eb8445f8fc6539aeca5d44e@SI-MBX1030.de.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>, "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, Wolfgang Grandegger <wg@grandegger.com>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gJ98KJo3WnqUNtu0tsEjXN1mbqjNwIIn3
Content-Type: multipart/mixed; boundary="urFEUdrggU0wKAhNxgEp30UsPei5Qo8Ka";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>,
 "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Andri Yngvason <andri.yngvason@marel.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>,
 "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>
Message-ID: <ad3f6258-609c-bc1e-a26c-778dc792b463@pengutronix.de>
Subject: Re: [PATCH 0/4] can: flexcan: fix state transition, suppress irq
 flooding
References: <da2a7a180eb8445f8fc6539aeca5d44e@SI-MBX1030.de.bosch.com>
In-Reply-To: <da2a7a180eb8445f8fc6539aeca5d44e@SI-MBX1030.de.bosch.com>

--urFEUdrggU0wKAhNxgEp30UsPei5Qo8Ka
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 10/02/2017 11:05 AM, Jonas Mark (ST-FIR/ENG1) wrote:
> Hello Wolfgang and Marc,
>=20
>> From 9253741b7d8bdd4fabe41a8dc2211869589f0f18 Mon Sep 17 00:00:00 2001=

>> From: Zhu Yi <yi.zhu5@cn.bosch.com>
>> Date: Tue, 5 Sep 2017 16:09:04 +0800
>> Subject: [PATCH 0/4] can: flexcan: fix state transition, suppress irq =
flooding
>=20
> Is the patch set already on its way upstream or is there something we s=
till need to do?

I'll push the series to upstream.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--urFEUdrggU0wKAhNxgEp30UsPei5Qo8Ka--

--gJ98KJo3WnqUNtu0tsEjXN1mbqjNwIIn3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlnSER0ACgkQHv7KIOw4
HPYtgQf/cv/J1NyUf2uwlnJoxwSiZ04bZihhAPbdQ7e8RJ3HxhkS7phZsCfdShkE
jdh6HYb/gQNg78kp9/A1kPrL5Y9gKIeygf2S+19f2Au8Y1wTw5GyeghNY2kAuifE
wGQasUMH4LXoFd6MSWkCZO5m3kxXKBvsf+5hYdyyRsdSd5Qq2Ja50cQYRT8KjOn9
oTt1eVRV5MK7gBrCgp1y6fY/Js5KElPbtbv+f2DduBY4aemgRWZZ1iwa2IayJJlR
oVp3x1zZd8YHG8K23tWIeShz0QlXHNxNBqGF3x3C62Bz9dL95M4Rdhi1pKYWhqie
Fw+Yuhcn68e2cHbiHjxpNXoaInkSRw==
=LTSe
-----END PGP SIGNATURE-----

--gJ98KJo3WnqUNtu0tsEjXN1mbqjNwIIn3--
