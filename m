From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH V2 2/4] can: flexcan: try to exit stop mode during probe
 stage
Date: Sun, 8 Dec 2019 11:56:26 +0100
Message-ID: <01039df6-8e38-cd04-6da1-35c1014bee0f@pengutronix.de>
References: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
 <20191127055334.1476-3-qiangqing.zhang@nxp.com>
 <ad7e7b15-26f3-daa1-02d2-782ff548756d@pengutronix.de>
 <DB7PR04MB46180C5F1EAC7C4A69A45E0CE65D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <d68b2b79-34ec-eb4c-cf4b-047b5157d5e3@pengutronix.de>
 <a1ded645-9e12-d939-7920-8e79983b02a0@geanix.com>
 <DB7PR04MB46184164EAC5719BDCF3822CE65C0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <e7bef254-9762-0b77-1ace-2040113982ec@geanix.com>
 <DB7PR04MB461820120FF61E08B8B5B0B5E65C0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <3a4102bc-8a86-3425-e227-590c005df044@geanix.com>
 <2c8f83aa-e7e6-ba15-1e42-2cb834da1c48@pengutronix.de>
 <cdf11f66-92f5-7431-9e76-6a5c92eb4d91@geanix.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="1GeyrOEprw0YVtGNDAxNVnNwZcRcRABuY"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <cdf11f66-92f5-7431-9e76-6a5c92eb4d91@geanix.com>
Sender: netdev-owner@vger.kernel.org
To: Sean Nyekjaer <sean@geanix.com>, Joakim Zhang <qiangqing.zhang@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1GeyrOEprw0YVtGNDAxNVnNwZcRcRABuY
Content-Type: multipart/mixed; boundary="NM6vI8sWWYfrEQGYANM1JlnsgTooQGD0a";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sean Nyekjaer <sean@geanix.com>, Joakim Zhang <qiangqing.zhang@nxp.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <01039df6-8e38-cd04-6da1-35c1014bee0f@pengutronix.de>
Subject: Re: [PATCH V2 2/4] can: flexcan: try to exit stop mode during probe
 stage
References: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
 <20191127055334.1476-3-qiangqing.zhang@nxp.com>
 <ad7e7b15-26f3-daa1-02d2-782ff548756d@pengutronix.de>
 <DB7PR04MB46180C5F1EAC7C4A69A45E0CE65D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <d68b2b79-34ec-eb4c-cf4b-047b5157d5e3@pengutronix.de>
 <a1ded645-9e12-d939-7920-8e79983b02a0@geanix.com>
 <DB7PR04MB46184164EAC5719BDCF3822CE65C0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <e7bef254-9762-0b77-1ace-2040113982ec@geanix.com>
 <DB7PR04MB461820120FF61E08B8B5B0B5E65C0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <3a4102bc-8a86-3425-e227-590c005df044@geanix.com>
 <2c8f83aa-e7e6-ba15-1e42-2cb834da1c48@pengutronix.de>
 <cdf11f66-92f5-7431-9e76-6a5c92eb4d91@geanix.com>
In-Reply-To: <cdf11f66-92f5-7431-9e76-6a5c92eb4d91@geanix.com>

--NM6vI8sWWYfrEQGYANM1JlnsgTooQGD0a
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/8/19 11:47 AM, Sean Nyekjaer wrote:
>> But both patches:
>>
>>      can: flexcan: fix deadlock when using self wakeup
>>      can: flexcan: try to exit stop mode during probe stage
>>
>> are not yet mainline, so if "can: flexcan: fix deadlock when using sel=
f
>> wakeup" fixes the problem and goes into stable we don't need "can:
>> flexcan: try to exit stop mode during probe stage", right?
>>
>>> That's what i meant by this patch doesn't do any harm to have the che=
ck
>>> included.
>>
>> I don't want to have code in the driver that serves no purpose.
>=20
> Fine with me, I'm continuing to have the patch included in my tree unti=
l=20
> all devices are upgraded with:
> 	can: flexcan: fix deadlock when using self wakeup

That makes sende in your usecase, as you already have "can: flexcan: try
to exit stop mode during probe stage" in your tree.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--NM6vI8sWWYfrEQGYANM1JlnsgTooQGD0a--

--1GeyrOEprw0YVtGNDAxNVnNwZcRcRABuY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3s1toACgkQWsYho5Hk
nSB3jwf+OcC5PHpmSVaRCCLnD8oWB3syQApc1hdy96T9/2/F6agAF8cKoxhLIgQQ
PDShvn6bfCkv+LUEyKfiA0CFFxTWVJEhBvaMz+Kr3xhCGYzxc7Uq1nTdXuAIyyud
oOCC/Q+EYNlu5g56IzGY3oK3hwtWxE2C+56GSIJf4WD2nnIteM4b+tKhML39GTbj
cw6podzwDyNPGvxBK6WDzbVYj0T+Ps7jhH7uh+kp+I+uBzXEJhqH7BAfLUiOvuwr
dk9IhVXw79vCreZPMzKiFeOjV7vNUhANYGtBeUXZUs0RZpjdWQzse4t2adHLEZU+
ZkxvFgZOLoX/wEklL/DkHSdXDwUywg==
=aKmy
-----END PGP SIGNATURE-----

--1GeyrOEprw0YVtGNDAxNVnNwZcRcRABuY--
