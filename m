From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [EXT] Re: [PATCH] can: dev: clean up CAN ctrlmode when close CAN
 device
Date: Wed, 10 Apr 2019 19:49:45 +0200
Message-ID: <ad4c0921-3275-b466-95b4-a63944d5b71f@pengutronix.de>
References: <20190410062533.31535-1-qiangqing.zhang@nxp.com>
 <39d8ef33-50c3-9b7a-88e1-8ef3a7fbac70@pengutronix.de>
 <DB7PR04MB4618D14BE595F3BDE46CBE17E62E0@DB7PR04MB4618.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="sAD5g9P2Xuu9kzudljw12e5c4FSw1osqD"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <DB7PR04MB4618D14BE595F3BDE46CBE17E62E0@DB7PR04MB4618.eurprd04.prod.outlook.com>
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "wg@grandegger.com" <wg@grandegger.com>, "davem@davemloft.net" <davem@davemloft.net>
Cc: dl-linux-imx <linux-imx@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sAD5g9P2Xuu9kzudljw12e5c4FSw1osqD
Content-Type: multipart/mixed; boundary="hoElUhimVX7PJ0G4OAQNTnW8GRz7qiNvR";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>,
 "wg@grandegger.com" <wg@grandegger.com>,
 "davem@davemloft.net" <davem@davemloft.net>
Cc: dl-linux-imx <linux-imx@nxp.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <ad4c0921-3275-b466-95b4-a63944d5b71f@pengutronix.de>
Subject: Re: [EXT] Re: [PATCH] can: dev: clean up CAN ctrlmode when close CAN
 device
References: <20190410062533.31535-1-qiangqing.zhang@nxp.com>
 <39d8ef33-50c3-9b7a-88e1-8ef3a7fbac70@pengutronix.de>
 <DB7PR04MB4618D14BE595F3BDE46CBE17E62E0@DB7PR04MB4618.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB4618D14BE595F3BDE46CBE17E62E0@DB7PR04MB4618.eurprd04.prod.outlook.com>

--hoElUhimVX7PJ0G4OAQNTnW8GRz7qiNvR
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 4/10/19 9:55 AM, Joakim Zhang wrote:
>=20
>> -----Original Message-----
>> From: Marc Kleine-Budde <mkl@pengutronix.de>
>> Sent: 2019=E5=B9=B44=E6=9C=8810=E6=97=A5 15:19
>> To: Joakim Zhang <qiangqing.zhang@nxp.com>; wg@grandegger.com;
>> davem@davemloft.net
>> Cc: dl-linux-imx <linux-imx@nxp.com>; linux-can@vger.kernel.org;
>> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: [EXT] Re: [PATCH] can: dev: clean up CAN ctrlmode when close =
CAN
>> device
>>
>> On 4/10/19 8:27 AM, Joakim Zhang wrote:
>>> CAN driver always writes registers according to "ctrlmode", and now
>>> CAN framework will keep CAN ctrlmode after device closed.
>>>
>>> e.g. with following sequences:
>>> 1)ip link set can0 type can bitrate 1000000 loopback on 2)ip link set=

>>> can0 up 3)ip link set can0 down 4)ip link set can0 type can bitrate
>>> 1000000 5)ip link set can0 up
>>>
>>> After this sequence, we may want to test loopback for the first time
>>> and not to test loopback second time. However, CAN device still keep
>>> "ctrlmode" as loopback on.
>>
>> Then you should configure loopback off in userspace.
>=20
>  Got it. Thank you.
>=20
>>> This patch intends to clean up CAN ctrlmode when close CAN device. We=

>>> can set which ctrlmode we need when open CAN device again.
>>
>> Consider a CANFD device, where CANFD has been enabled. It will feel ve=
ry
>> weird if the interface looses the CANFD property by just a ifdown; ifu=
p.
>=20
> Yes, you are right. But fd mode should compatible with normal can.

CANFD was just an example. Take CAN_CTRLMODE_ONE_SHOT as another
example. You don't want your network device settings to vanish if you
switch the interface off and on again.

> When I want to switch to normal can from fd mode. You mean that we
> should configure fd off in userspace as we may write some specific
> registers only by fd mode?

Whatever mode you enable via user space use user space to disable them
again.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--hoElUhimVX7PJ0G4OAQNTnW8GRz7qiNvR--

--sAD5g9P2Xuu9kzudljw12e5c4FSw1osqD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAlyuLLkACgkQWsYho5Hk
nSCW9Qf+Ido/s3ZA19sMUCV6OKJ21IZloSgDbM8NQgC5ARCCm45dJTgrceX4/FDM
fNGwcRT/0BAnjj9+cCPKzzACbVKqhvtWGlEJlPID6uABFiNPCKRXN07o/5sIlTPH
y+C9KOtcSRJ3EjOnHKsjHcul2NfN/vMxD9bF7dpKFaNBw4M/ft5FUD/G8AQ5KIUL
reIA4752gU85EYtQLX6KVpwXw36Gs1403J4UBb5brh+survIqjJed8OFkKUAtqot
M6L/kVoQECianGxUwjQQqRUwXMA/Z7TU98qJ/KQ+3UMoN/QJbmZrMbO4p7K+AryB
yG+36p4z8hKpGY/7AmjwYqTgAKsO1g==
=Z7Rj
-----END PGP SIGNATURE-----

--sAD5g9P2Xuu9kzudljw12e5c4FSw1osqD--
