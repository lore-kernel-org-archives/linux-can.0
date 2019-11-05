From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: KASAN: use-after-free Read in j1939_session_get_by_addr
Date: Tue, 5 Nov 2019 09:33:33 +0100
Message-ID: <969f940b-05ba-3fbf-79ba-95dc1cebc40d@pengutronix.de>
References: <0000000000009393ba059691c6a3@google.com>
 <0000000000009427b5059694e33c@google.com>
 <BN8PR12MB3266A0CC1496ED5D532EA6D5D37E0@BN8PR12MB3266.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="E8urJeMqxkxvn0jAIW1CNDli4LjSlEgIi"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BN8PR12MB3266A0CC1496ED5D532EA6D5D37E0@BN8PR12MB3266.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jose Abreu <Jose.Abreu@synopsys.com>, syzbot <syzbot+d9536adc269404a984f8@syzkaller.appspotmail.com>, "arvid.brodin@alten.se" <arvid.brodin@alten.se>, "davem@davemloft.net" <davem@davemloft.net>, "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux@rempel-privat.de" <linux@rempel-privat.de>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "robin@protonic.nl" <robin@protonic.nl>, "socketcan@hartkopp.net" <socketcan@hartkopp.net>, "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E8urJeMqxkxvn0jAIW1CNDli4LjSlEgIi
Content-Type: multipart/mixed; boundary="qaAOKCEwENO8qPkNE1tUAKCm02QBejh9u";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jose Abreu <Jose.Abreu@synopsys.com>,
 syzbot <syzbot+d9536adc269404a984f8@syzkaller.appspotmail.com>,
 "arvid.brodin@alten.se" <arvid.brodin@alten.se>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux@rempel-privat.de" <linux@rempel-privat.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "robin@protonic.nl" <robin@protonic.nl>,
 "socketcan@hartkopp.net" <socketcan@hartkopp.net>,
 "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Message-ID: <969f940b-05ba-3fbf-79ba-95dc1cebc40d@pengutronix.de>
Subject: Re: KASAN: use-after-free Read in j1939_session_get_by_addr
References: <0000000000009393ba059691c6a3@google.com>
 <0000000000009427b5059694e33c@google.com>
 <BN8PR12MB3266A0CC1496ED5D532EA6D5D37E0@BN8PR12MB3266.namprd12.prod.outlook.com>
In-Reply-To: <BN8PR12MB3266A0CC1496ED5D532EA6D5D37E0@BN8PR12MB3266.namprd12.prod.outlook.com>

--qaAOKCEwENO8qPkNE1tUAKCm02QBejh9u
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 11/5/19 9:21 AM, Jose Abreu wrote:
> From: syzbot <syzbot+d9536adc269404a984f8@syzkaller.appspotmail.com>
> Date: Nov/05/2019, 08:05:01 (UTC+00:00)
>=20
>> syzbot has bisected this bug to:
>>
>> commit 2af6106ae949651d529c8c3f0734c3a7babd0d4b
>> Author: Jose Abreu <Jose.Abreu@synopsys.com>
>> Date:   Tue Jul 9 08:03:00 2019 +0000
>>
>>      net: stmmac: Introducing support for Page Pool
>=20
> From the config provided, stmmac driver is not even enabled. Can you=20
> please confirm the bisection process ?

Looks like a false positive, as j1939 (net/can/j1939/) hit mainline with
v5.4-rc1~131^2~78^2.

While the bisected commit is v5.3-rc1~140^2~13^2.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--qaAOKCEwENO8qPkNE1tUAKCm02QBejh9u--

--E8urJeMqxkxvn0jAIW1CNDli4LjSlEgIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3BM90ACgkQWsYho5Hk
nSClyAf/aRbtnXNxbxKfoZYB1Hxes/baBaYlNG3vMNllR0AY3Fvxq0x5+CoWS2le
c6yaUcZjjkh51ibpWknN7mlpyYDf4dH0iP+SkdinNv5uSrJuTcJvB+D2LxcxFc4S
oT43qKBa1u4jt3YFp9Kt7GavMbSu/JvZ9P1PVTLhyzjsQ4l7JTMsPuE6p9l4cCBc
HVo08ihz6GVW3EbE0Z4VyNW9SdD/4Ax1NmlcP3y/NwFg3/P7msep8jtZxmzHpsbw
/FB5ptLWi0nF263l5pZJ7R3NZyRJhIxX7UfGquIxb1NncegOdPdJYnM7iPR9iRKu
EKAF9rTeYemswBfJt4cEXKvgospZvA==
=CxHt
-----END PGP SIGNATURE-----

--E8urJeMqxkxvn0jAIW1CNDli4LjSlEgIi--
