From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: fix timeout when set small bitrate
Date: Thu, 31 Jan 2019 10:11:33 +0100
Message-ID: <0b660fc9-0b02-0b3f-46f5-1d194a52628c@pengutronix.de>
References: <20190131065619.7298-1-qiangqing.zhang@nxp.com>
 <1902c81b-86fa-469e-b495-c37dca744cb9@pengutronix.de>
 <DB7PR04MB46189FE45531AA8FD65D5327E6910@DB7PR04MB4618.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="a35Q4ybFde09PFXDzp7IM6FwIQVzZ04Tr"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <DB7PR04MB46189FE45531AA8FD65D5327E6910@DB7PR04MB4618.eurprd04.prod.outlook.com>
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a35Q4ybFde09PFXDzp7IM6FwIQVzZ04Tr
Content-Type: multipart/mixed; boundary="HOXq45g63QKyFmXXHiCYyaccCGtcrR19d";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>
Message-ID: <0b660fc9-0b02-0b3f-46f5-1d194a52628c@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: fix timeout when set small bitrate
References: <20190131065619.7298-1-qiangqing.zhang@nxp.com>
 <1902c81b-86fa-469e-b495-c37dca744cb9@pengutronix.de>
 <DB7PR04MB46189FE45531AA8FD65D5327E6910@DB7PR04MB4618.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB46189FE45531AA8FD65D5327E6910@DB7PR04MB4618.eurprd04.prod.outlook.com>

--HOXq45g63QKyFmXXHiCYyaccCGtcrR19d
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 1/31/19 9:48 AM, Joakim Zhang wrote:
>> Which SoC are you using? Which clock rate has the flexcan IP core?
>=20
>   We tested on i.MX6 series boards and all met this issue. And ipg cloc=
k rate is 66MHZ, per clock rate is 30MHZ.

ok

>=20
>>> It is caused by calling of flexcan_chip_unfreeze() timeout.
>>>
>>> Originally the code is using usleep_range(10, 20) for unfreeze
>>> operation, but the patch (8badd65 can: flexcan: avoid calling
>>> usleep_range from interrupt context) changed it into udelay(10) which=

>>> is only a half delay of before, there're also some other delay change=
s.
>>>
>>> After only changed unfreeze delay back to udelay(20), the issue is go=
ne.
>>> So other timeout values are kept the same as 8badd65 changed.
>>
>> Can you change FLEXCAN_TIMEOUT_US instead?
>=20
>   Of course, we can change FLEXCAN_TIMEOUT_US to 100, but this will ext=
end the time of enable/disable/softreset.
> Which method do you think is better?

If you double to FLEXCAN_TIMEOUT_US to 100, the loops in question will
spin at maximum the double time. But the loops are left as soon as the
condition is satisfied.

It will fix your problem with the 10 kbit/s bitrate. But if there is
some kind of problem with the IP core it will still fail, it just takes
double amount of time (100 =C2=B5s + overhead) until the function returns=
=2E

I don't see any harm in looping longer:
- The previous good case is unchanged.
- The error case takes double amount of time.
- Your problem is hopefully fixed.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--HOXq45g63QKyFmXXHiCYyaccCGtcrR19d--

--a35Q4ybFde09PFXDzp7IM6FwIQVzZ04Tr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlxSu8UACgkQk9IU1zQo
ZfE6IggAo2YOtz8gIlCbQMMv9cNbO5BVRqS2YXurU7plQV8u4/ze4QnFw4ZNs6oU
lOmJcCWvWauaQzwiFvX7fg/W5NxgNR5o32z0tlx/C/kZSY8EngHA/NhbwN9Qs2A0
azgNrbySv5pIZt3DC9BXR0ulrAQ97qGaBz4oD89S3/6hvJdNe+FbpxzKXY/63wjE
TD8wZwJA2BW8QOCedTTQ/bRvsg38lw0MZKmaMmdVa7n77NsAljP5E1cK2ZUcZlHx
Lu1MojqEJu8hUBt0NHXlBl5TYavR6QkTz9Ixro+lasIOi/PDiMNcGGZF2TZinKcz
6rCjHkyRcdIyz4YAwk4J0ebQLWXSZw==
=udOe
-----END PGP SIGNATURE-----

--a35Q4ybFde09PFXDzp7IM6FwIQVzZ04Tr--
