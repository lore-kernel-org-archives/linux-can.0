From: Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH] can: flexcan: fix timeout when set small bitrate
Date: Thu, 31 Jan 2019 10:09:15 +0000
Message-ID: <AM0PR04MB42118221E7FEC6EC2503A72B80910@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190131093509.12613-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190131093509.12613-1-qiangqing.zhang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-can.vger.kernel.org

> -----Original Message-----
> From: Joakim Zhang
> Sent: Thursday, January 31, 2019 5:37 PM
> To: mkl@pengutronix.de; linux-can@vger.kernel.org
> Cc: wg@grandegger.com; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; Joakim
> Zhang <qiangqing.zhang@nxp.com>
> Subject: [PATCH] can: flexcan: fix timeout when set small bitrate
>=20
> Current we can meet timeout issue when setting a small bitrate like 10000=
 as
> follows on i.MX6UL EVK board (ipg clock =3D 66MHZ, per clock =3D 30MHZ):
> root@imx6ul7d:~# ip link set can0 up type can bitrate 10000 A link change
> request failed with some changes committed already.
> Interface can0 may have been left with an inconsistent configuration, ple=
ase
> check.
> RTNETLINK answers: Connection timed out
>=20
> It is caused by calling of flexcan_chip_unfreeze() timeout.
>=20
> Originally the code is using usleep_range(10, 20) for unfreeze operation,=
 but
> the patch (8badd65 can: flexcan: avoid calling usleep_range from interrup=
t
> context) changed it into udelay(10) which is only a half delay of before,
> there're also some other delay changes.
>=20
> After double to FLEXCAN_TIMEOUT_US to 100 can fix the issue.
>=20
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng
