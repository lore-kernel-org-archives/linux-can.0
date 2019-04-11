From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [EXT] Re: [PATCH] can: dev: clean up CAN ctrlmode when close CAN
 device
Date: Thu, 11 Apr 2019 08:38:45 +0200
Message-ID: <35c15351-5ae1-0826-1b05-95fe53272244@pengutronix.de>
References: <20190410062533.31535-1-qiangqing.zhang@nxp.com>
 <39d8ef33-50c3-9b7a-88e1-8ef3a7fbac70@pengutronix.de>
 <DB7PR04MB4618D14BE595F3BDE46CBE17E62E0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <ad4c0921-3275-b466-95b4-a63944d5b71f@pengutronix.de>
 <DB7PR04MB4618D30C746B397F8C5308BAE62F0@DB7PR04MB4618.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Mw8JsGkOUkVm7EENA0gbDYPdtFyBtXOT4"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DB7PR04MB4618D30C746B397F8C5308BAE62F0@DB7PR04MB4618.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "wg@grandegger.com" <wg@grandegger.com>, "davem@davemloft.net" <davem@davemloft.net>
Cc: dl-linux-imx <linux-imx@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Mw8JsGkOUkVm7EENA0gbDYPdtFyBtXOT4
Content-Type: multipart/mixed; boundary="PblQydVdEdfzsawluoFlTtk65ZIlGeMdZ";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>,
 "wg@grandegger.com" <wg@grandegger.com>,
 "davem@davemloft.net" <davem@davemloft.net>
Cc: dl-linux-imx <linux-imx@nxp.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <35c15351-5ae1-0826-1b05-95fe53272244@pengutronix.de>
Subject: Re: [EXT] Re: [PATCH] can: dev: clean up CAN ctrlmode when close CAN
 device
References: <20190410062533.31535-1-qiangqing.zhang@nxp.com>
 <39d8ef33-50c3-9b7a-88e1-8ef3a7fbac70@pengutronix.de>
 <DB7PR04MB4618D14BE595F3BDE46CBE17E62E0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <ad4c0921-3275-b466-95b4-a63944d5b71f@pengutronix.de>
 <DB7PR04MB4618D30C746B397F8C5308BAE62F0@DB7PR04MB4618.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB4618D30C746B397F8C5308BAE62F0@DB7PR04MB4618.eurprd04.prod.outlook.com>

--PblQydVdEdfzsawluoFlTtk65ZIlGeMdZ
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 4/11/19 3:16 AM, Joakim Zhang wrote:
>> Whatever mode you enable via user space use user space to disable them=

>> again.
>=20
> Thank you for your detailed explanation. But in flexcan driver, it
> just set register bit when mode on and do not clear register bit when
> mode off, e.g. loopback, listennoly, 3 samples....

Let's see:

> 	reg =3D priv->read(&regs->ctrl);

The ctrl reg is read

> 	reg &=3D ~(FLEXCAN_CTRL_PRESDIV(0xff) |
> 		 FLEXCAN_CTRL_RJW(0x3) |
> 		 FLEXCAN_CTRL_PSEG1(0x7) |
> 		 FLEXCAN_CTRL_PSEG2(0x7) |
> 		 FLEXCAN_CTRL_PROPSEG(0x7) |
> 		 FLEXCAN_CTRL_LPB |
> 		 FLEXCAN_CTRL_SMP |
> 		 FLEXCAN_CTRL_LOM);

=2E...the loopback mode, 3 sample mode and listen only mode bits are
masked out....

> 	reg |=3D FLEXCAN_CTRL_PRESDIV(bt->brp - 1) |
> 		FLEXCAN_CTRL_PSEG1(bt->phase_seg1 - 1) |
> 		FLEXCAN_CTRL_PSEG2(bt->phase_seg2 - 1) |
> 		FLEXCAN_CTRL_RJW(bt->sjw - 1) |
> 		FLEXCAN_CTRL_PROPSEG(bt->prop_seg - 1);
>=20
> 	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
> 		reg |=3D FLEXCAN_CTRL_LPB;
> 	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> 		reg |=3D FLEXCAN_CTRL_LOM;
> 	if (priv->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
> 		reg |=3D FLEXCAN_CTRL_SMP;

=2E..and the bits are set, if enabled by user space...

> 	netdev_dbg(dev, "writing ctrl=3D0x%08x\n", reg);
> 	priv->write(reg, &regs->ctrl);

=2E..and written to the register.

So all three bits will be unset, if unset by user space, right?

> When we configure mode off after configured mode on in the user
> space, corresponding bit will not change. Is this should be improved
> in flexcan driver?

That should work. If it doesn't work, we need a fix.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--PblQydVdEdfzsawluoFlTtk65ZIlGeMdZ--

--Mw8JsGkOUkVm7EENA0gbDYPdtFyBtXOT4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAlyu4PUACgkQWsYho5Hk
nSAM/wf/VLZ2Jptfd/XQecKar70GhTJJOm1fXo1LU35G1IKeOiTOlbWZYOxXiro8
V79OzEcXezHtGJ6uoPyKfWf4uksZ3EQ+6W21TFecZFID9vAU/rsH7mKhc2I8Zd0N
gI0k7GyzErFFFdGFDBju2RtIodeUp8Ql3O6vsSwmHko5Hh7fy8Tr8dpN8sLCWtUN
8nOPmwu6++HAvQWOVBg170Js6FcQzHZGlQBFZu+xVWqRaEgRfEtG8fjqHQueI0Ka
/eQJltcp6wE8HVQbMxBKj0GTTP24Vwzaxm4Ol1K3BO5toyjaD2opRtgRB1OBXrHS
b2SyoEIzcBPk7RmbOs8qWRbKg96ikA==
=gOIv
-----END PGP SIGNATURE-----

--Mw8JsGkOUkVm7EENA0gbDYPdtFyBtXOT4--
