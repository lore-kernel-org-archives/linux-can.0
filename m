From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: Implement CAN Runtime PM
Date: Wed, 21 Nov 2018 15:36:19 +0100
Message-ID: <24a43a20-7302-c449-06b3-5ee8f6c051a0@pengutronix.de>
References: <20181019094326.28185-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="N1L7IZFo3w1vy5ZVSXaomCo97WEV248H6"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181019094326.28185-1-qiangqing.zhang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "wg@grandegger.com" <wg@grandegger.com>, "davem@davemloft.net" <davem@davemloft.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "A.s. Dong" <aisheng.dong@nxp.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N1L7IZFo3w1vy5ZVSXaomCo97WEV248H6
Content-Type: multipart/mixed; boundary="pwLVP2vQ93tDZ7QegnZmjuh8YZF3IYYuK";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>,
 "wg@grandegger.com" <wg@grandegger.com>,
 "davem@davemloft.net" <davem@davemloft.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, "A.s. Dong" <aisheng.dong@nxp.com>
Message-ID: <24a43a20-7302-c449-06b3-5ee8f6c051a0@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: Implement CAN Runtime PM
References: <20181019094326.28185-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20181019094326.28185-1-qiangqing.zhang@nxp.com>

--pwLVP2vQ93tDZ7QegnZmjuh8YZF3IYYuK
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 10/19/18 11:45 AM, Joakim Zhang wrote:
> From: Dong Aisheng <aisheng.dong@nxp.com>
>=20
> Flexcan will be disabled during suspend if no wakeup function required
> and enabled after resume accordingly. During this period, we could
> explicitly disable clocks.
>=20
> Implement Runtime PM which will:
> 1) Keep device in suspend state (clocks disabled) if it's not openned
> 2) Make Power Domain framework be able to shutdown the corresponding po=
wer
> domain of this device.

Without CONFIG_PM the device fails to probe:

> [  214.420606] flexcan 2090000.flexcan: 2090000.flexcan supply xceiver =
not found, using dummy regulator
> [  214.445952] flexcan 2090000.flexcan: Linked as a consumer to regulat=
or.0
> [  214.453448] flexcan 2090000.flexcan: registering netdev failed
> [  214.459666] flexcan 2090000.flexcan: Dropping the link to regulator.=
0
> [  214.472066] flexcan: probe of 2090000.flexcan failed with error -110=


Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--pwLVP2vQ93tDZ7QegnZmjuh8YZF3IYYuK--

--N1L7IZFo3w1vy5ZVSXaomCo97WEV248H6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlv1bWMACgkQk9IU1zQo
ZfHWswgAyHLljeXDdcQ80nVvPc3J/jzTOUqcRBJIP7RwQ3wUJvJH/vWX9H/T77Ht
LuTcUfz081bJ5Dv4QcdAqQ80dbGtQjRhpmjVgbgDT3/q9hksyE+cq0JYXJ9gzusM
CEUptfd1umX2fpkwNKuFz3BO34uChKcv0VZjRmuvHzKXJUf06Ho69K3/NcBLTV+O
dJFMF1vdRg5/usnV5ZbinppaEONhvKmxXJNHpQcyBpSwCHqQySW+Afy7+tugczZ3
xJ+1PR+6BPdtYOYzFnJyeu6tOxs+dyRwdQtqUfbpxeODHnlPZKqdY5pdVzyuwEGx
Qr7VSEjhYBARxZRJXSTMZPwaQYzS8g==
=ImTB
-----END PGP SIGNATURE-----

--N1L7IZFo3w1vy5ZVSXaomCo97WEV248H6--
