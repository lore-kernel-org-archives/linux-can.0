From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH V2 2/4] can: flexcan: try to exit stop mode during probe
 stage
Date: Wed, 4 Dec 2019 09:45:04 +0100
Message-ID: <d68b2b79-34ec-eb4c-cf4b-047b5157d5e3@pengutronix.de>
References: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
 <20191127055334.1476-3-qiangqing.zhang@nxp.com>
 <ad7e7b15-26f3-daa1-02d2-782ff548756d@pengutronix.de>
 <DB7PR04MB46180C5F1EAC7C4A69A45E0CE65D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ZlZmhQmN6SpMV8nrfBVgIvHUioSnJWW5x"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <DB7PR04MB46180C5F1EAC7C4A69A45E0CE65D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "sean@geanix.com" <sean@geanix.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZlZmhQmN6SpMV8nrfBVgIvHUioSnJWW5x
Content-Type: multipart/mixed; boundary="4nMcngxFmMvjwzxK6dfDliCaJBTLTplAs";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "sean@geanix.com"
 <sean@geanix.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <d68b2b79-34ec-eb4c-cf4b-047b5157d5e3@pengutronix.de>
Subject: Re: [PATCH V2 2/4] can: flexcan: try to exit stop mode during probe
 stage
References: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
 <20191127055334.1476-3-qiangqing.zhang@nxp.com>
 <ad7e7b15-26f3-daa1-02d2-782ff548756d@pengutronix.de>
 <DB7PR04MB46180C5F1EAC7C4A69A45E0CE65D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB46180C5F1EAC7C4A69A45E0CE65D0@DB7PR04MB4618.eurprd04.prod.outlook.com>

--4nMcngxFmMvjwzxK6dfDliCaJBTLTplAs
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 12/4/19 3:22 AM, Joakim Zhang wrote:
>=20
>> -----Original Message-----
>> From: Marc Kleine-Budde <mkl@pengutronix.de>
>> Sent: 2019=E5=B9=B412=E6=9C=884=E6=97=A5 2:15
>> To: Joakim Zhang <qiangqing.zhang@nxp.com>; sean@geanix.com;
>> linux-can@vger.kernel.org
>> Cc: dl-linux-imx <linux-imx@nxp.com>; netdev@vger.kernel.org
>> Subject: Re: [PATCH V2 2/4] can: flexcan: try to exit stop mode during=
 probe
>> stage
>>
>> On 11/27/19 6:56 AM, Joakim Zhang wrote:
>>> CAN controller could be stucked in stop mode once it enters stop mode=

>>                           ^^^^^^^ stuck
>>> when suspend, and then it fails to exit stop mode when resume.
>>
>> How can this happen?
>=20
> I am also confused how can this happen, as I asked Sean, only CAN
> enter stop mode when suspend, then system hang,
How do you recover the system when suspended?

> it could let CAN=20
> stuck in stop mode. However, Sean said this indeed happen at his
> side, @sean@geanix.com, could you explain how this happen in
> details?
That would be good.

>>> Only code reset can get CAN out of stop mode,
>>
>> What is "code reset"?
>=20
> As I know, "code reset" is to press the POWER KEY from the board. At
> my side, reboot command from OS also can get CAN out of stop mode.
Do you mean "cold reset", also known as Power-On-Reset, POR or power cycl=
e?

What does pressing the POWER KEY do? A power cycle of the system or
toggling the reset line of the imx?

We need to describe in detail, as not everyone has the same board as
you, and these boards might not even have a power key :)

> Below is experiment I did:
> 	Firstly, do a hacking to let CAN stuck into stop mode, then:

You mean you put the CAN into stop mode without keeping track in the CAN
driver that the CAN-IP is in stop mode, e.g. by hacking the driver.

Then you try several methods to recover:

> 	(1) press power on/off key, get CAN out of stop mode;
> 	(2) reboot command from console, get CAN out of stop mode;
> 	(3) unbind/bind driver, cannot get CAN out of stop mode; =20
> 	(4) remod/insmod module, cannot get CAN out of stop mode;

(2) resets the complete imx, including the CAN-IP core, (1) probably, too=
=2E

(3) and (4) fail to recover the CAN core, as the IP core is still
powered off by some upstream component. So the question why this happens
in the first place is IMHO as important as trying to wake up the core. I
think if we discover this situation (CAN Core is in stop-mode in probe)
we should print a warning message, but try to recover.

>>> so add stop mode remove request during probe stage for other
>>> methods(soft reset from chip level, unbind/bind driver, etc) to let
>>         ^^^ please add a space
>>> CAN active again.
>>
>> Can you rephrase the sentence after "so add stop mode remove request d=
uring
>> probe stage". I'm not completely sure what you want to tell.
>=20
> Sure.

tnx,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--4nMcngxFmMvjwzxK6dfDliCaJBTLTplAs--

--ZlZmhQmN6SpMV8nrfBVgIvHUioSnJWW5x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3nchAACgkQWsYho5Hk
nSCTpggAmAMrS03XnqjmwdpdqX/3QzdujpVXMAIIdRhp1Hdsx0qsrlFKzXSZ9jsi
AyvrmiO/2t76mxKZQkQ0ngKHYgHKmBS+YwWSXIoRC0ATg0H6qX2TXjxQhCu87puX
odLHR/vuG40R28Alc8YR37+yzuxmfoHT8at6jjGFqWStPen3siOzBj8K2gA7QhN1
kBoH0L4AxDqXZwNUbSghVwrca1t/X09T7hpCBYDhBblwkZovGl8rfGpGCdV2NFaP
QYOqUwBA5Sw6bGpKBHPxrFHZWuFpg/NhaoRyEt/7E7/9BUx0kjzLV4WkpDez/hNa
Zritj7qKbAcZmSlBfWWFegMda7x1PA==
=qCmu
-----END PGP SIGNATURE-----

--ZlZmhQmN6SpMV8nrfBVgIvHUioSnJWW5x--
