From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: xilinx_can: Fix missing Rx can packets on CANFD2.0
Date: Tue, 3 Dec 2019 12:16:23 +0100
Message-ID: <885dca39-92be-50f1-8814-f14fa3271c7f@pengutronix.de>
References: <1575371522-3030-1-git-send-email-srinivas.neeli@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="KRPJWEPvktscw2cXv6pxzoCjmQsk8lzFK"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1575371522-3030-1-git-send-email-srinivas.neeli@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Neeli <srinivas.neeli@xilinx.com>, wg@grandegger.com, davem@davemloft.net, michal.simek@xilinx.com, appanad@xilinx.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, git@xilinx.com, nagasure@xilinx.com
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KRPJWEPvktscw2cXv6pxzoCjmQsk8lzFK
Content-Type: multipart/mixed; boundary="TyjDWf9B9YjbpCa7nSUZyuRlmimp8m8Ab";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Srinivas Neeli <srinivas.neeli@xilinx.com>, wg@grandegger.com,
 davem@davemloft.net, michal.simek@xilinx.com, appanad@xilinx.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 git@xilinx.com, nagasure@xilinx.com
Message-ID: <885dca39-92be-50f1-8814-f14fa3271c7f@pengutronix.de>
Subject: Re: [PATCH] can: xilinx_can: Fix missing Rx can packets on CANFD2.0
References: <1575371522-3030-1-git-send-email-srinivas.neeli@xilinx.com>
In-Reply-To: <1575371522-3030-1-git-send-email-srinivas.neeli@xilinx.com>

--TyjDWf9B9YjbpCa7nSUZyuRlmimp8m8Ab
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/3/19 12:12 PM, Srinivas Neeli wrote:
> CANFD2.0 core uses BRAM for storing acceptance filter ID(AFID) and MASK=

> (AFMASK)registers. So by default AFID and AFMASK registers contain rand=
om
> data. Due to random data, not able to receive all CAN ids.
>=20
> Initializing AFID and AFMASK registers with Zero before enabling
> acceptance filter to receive all packets irrespective of ID and Mask.
>=20
> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
> Reviewed-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>=

> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Please add a "Fixes:" tag.

Some nitpicks: Please add your S-o-B as the last one. Further I'd be
happier, if Naga Sureshkumar Relli adds the Reviewed-by in a seperate mai=
l.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--TyjDWf9B9YjbpCa7nSUZyuRlmimp8m8Ab--

--KRPJWEPvktscw2cXv6pxzoCjmQsk8lzFK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3mRAcACgkQWsYho5Hk
nSAHJgf/VaE8e0cY3G9IlwKJ61hgtboO4c1PW+e40qaBOKTY3MuF00XIC7DecbHR
xoA1DHwh50kmqgg60wegLAy7GQaLEQ1zAs8qQzOuduf8Fr4EHgWzFnIwFWBrajrA
WakrmzfLHMQlS3nSKYEDwDd1eI+AfdRdt+JYp7JXCskKGeR/ZUTge6PXVeO1aCEN
iRX9VtCuwD6gFvylMYs0Zt8o/h23sD2p7yjGY5yHaiQK9QTBktstdoiCAHGg3tl6
NoY7+qPLo2xpT+FGuDWmBlsTNCItPcIoeHMansRze2hB+STuFoiuommKFiHLG4U/
X6Vt72cS7CeQrAqveG256vhbdu+MjA==
=4+Hn
-----END PGP SIGNATURE-----

--KRPJWEPvktscw2cXv6pxzoCjmQsk8lzFK--
