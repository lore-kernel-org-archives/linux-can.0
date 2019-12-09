From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH V3 0/6] can: flexcan: fixes for stop mode
Date: Mon, 9 Dec 2019 09:43:10 +0100
Message-ID: <6ad7b8c6-52cf-817e-1b54-a9e9b04cc974@pengutronix.de>
References: <20191204113249.3381-1-qiangqing.zhang@nxp.com>
 <67da1a42-f3d3-6ac1-e5f9-211d2da00ba3@pengutronix.de>
 <DB7PR04MB4618328FDC7BC5B4DA3953A2E6580@DB7PR04MB4618.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="SkGwe87A1uOZFQqtvHKPr2IrHwx6iBmj6"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <DB7PR04MB4618328FDC7BC5B4DA3953A2E6580@DB7PR04MB4618.eurprd04.prod.outlook.com>
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "sean@geanix.com" <sean@geanix.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SkGwe87A1uOZFQqtvHKPr2IrHwx6iBmj6
Content-Type: multipart/mixed; boundary="4QL2KSorwpxwloSuGVGIa16Vxdlq8kBfC";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "sean@geanix.com"
 <sean@geanix.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <6ad7b8c6-52cf-817e-1b54-a9e9b04cc974@pengutronix.de>
Subject: Re: [PATCH V3 0/6] can: flexcan: fixes for stop mode
References: <20191204113249.3381-1-qiangqing.zhang@nxp.com>
 <67da1a42-f3d3-6ac1-e5f9-211d2da00ba3@pengutronix.de>
 <DB7PR04MB4618328FDC7BC5B4DA3953A2E6580@DB7PR04MB4618.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB4618328FDC7BC5B4DA3953A2E6580@DB7PR04MB4618.eurprd04.prod.outlook.com>

--4QL2KSorwpxwloSuGVGIa16Vxdlq8kBfC
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/9/19 9:28 AM, Joakim Zhang wrote:
>=20
>> -----Original Message-----
>> From: Marc Kleine-Budde <mkl@pengutronix.de>
>> Sent: 2019=E5=B9=B412=E6=9C=887=E6=97=A5 22:11
>> To: Joakim Zhang <qiangqing.zhang@nxp.com>; sean@geanix.com;
>> linux-can@vger.kernel.org
>> Cc: dl-linux-imx <linux-imx@nxp.com>; netdev@vger.kernel.org
>> Subject: Re: [PATCH V3 0/6] can: flexcan: fixes for stop mode
>>
>> On 12/4/19 12:36 PM, Joakim Zhang wrote:
>>> Hi Marc,
>>>
>>>    I removed the patch (can: flexcan: try to exit stop mode during
>>> probe stage) out of this patch set for now. This patch should further=

>>> discuss with Sean and I will prepare it according to final conclusion=
=2E Thanks.
>>>
>>> Regards,
>>> Joakim Zhang
>>>
>>> Joakim Zhang (5):
>>>   can: flexcan: Ack wakeup interrupt separately
>>>   can: flexcan: add low power enter/exit acknowledgment helper
>>>   can: flexcan: change the way of stop mode acknowledgment
>>
>> Above 3 applied to linux-can.
>=20
> From below link, I have not found the patch: can: flexcan: Ack wakeup i=
nterrupt separately
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git/log/?=
h=3Dlinux-can-fixes-for-5.5-20191208

Right, "Ack wakeup interrupt separately" went into linux-can-next.

>>>   can: flexcan: propagate error value of flexcan_chip_stop()
>>>   can: flexcan: add LPSR mode support
>>
>> Above 2 applied to linux-can-next
>=20
> I also have not found these two patch on linux-can-next, which branch h=
as you pushed?

It's in linux-can-test/testing.

I just pushed both linux-can/testing and linux-can-test/testing.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--4QL2KSorwpxwloSuGVGIa16Vxdlq8kBfC--

--SkGwe87A1uOZFQqtvHKPr2IrHwx6iBmj6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3uCR4ACgkQWsYho5Hk
nSABMgf/aNyHqH6Y40FJctjRxEOM+lH4nuHiDszgfx/ohPZxCPyRzUqlwqOHG6CW
8/fIKkhREyTwIiYwJG+6DxYnzaxJF83A/ASH1qJqfJPpvDvKnYosSfHienVW8Ga/
Wu/KObPpHKgx7t5cIK3xhGEEfaenvytiO+0AY8L/XSPxgUK5375rAoldcyDi87tT
yX1pBQ1YgillMJAljPlR9j2uN1GzMBNjL9H4uasjclYVFnwKZwtM2zgEkvvHL24z
8DRNczrmBrPvotEDVaUpTxDLvA53jtUl9w2Eho8y7P3RejFMy2wqXRx9lf5JoPAm
HCOnXV0QuKJEEFPtkg44sse5XdFrGQ==
=ncqA
-----END PGP SIGNATURE-----

--SkGwe87A1uOZFQqtvHKPr2IrHwx6iBmj6--
