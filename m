From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net 0/4] support multipacket broadcast message
Date: Fri, 7 Aug 2020 15:15:52 +0200
Message-ID: <20200807131552.4hsuafdubumvh3hl@pengutronix.de>
References: <1596599425-5534-1-git-send-email-zhangchangzhong@huawei.com>
 <20200806161027.py5ged3a23xpmxgi@pengutronix.de>
 <24c3daa5-8243-0b80-9f4c-aa5883cb75da@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n75w4eckvcy5gpqk"
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <24c3daa5-8243-0b80-9f4c-aa5883cb75da@huawei.com>
Sender: netdev-owner@vger.kernel.org
To: Zhang Changzhong <zhangchangzhong@huawei.com>
Cc: robin@protonic.nl, linux@rempel-privat.de, kernel@pengutronix.de, socketcan@hartkopp.net, mkl@pengutronix.de, davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org


--n75w4eckvcy5gpqk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 07, 2020 at 05:36:38PM +0800, Zhang Changzhong wrote:
> Hi Oleksij,
>=20
> We have tested this j1939 stack according to SAE J1939-21. It works fine =
for
> most cases, but when we test multipacket broadcast message function we fo=
und
> the receiver can't receive those packets.
>=20
> You can reproduce on CAN bus or vcan, for vcan case use cangw to connect =
vcan0
> and vcan1:
> sudo cangw -A -s vcan0 -d vcan1 -e
> sudo cangw -A -s vcan1 -d vcan0 -e
>=20
> To reproduce it use following commands:
> testj1939 -B -r vcan1:0x90 &
> testj1939 -B -s20 vcan0:0x80 :,0x12300
>=20
> Besides, candump receives correct packets while testj1939 receives nothin=
g.

Ok, thank you!

i'm able to reproduce it and added following test:
https://github.com/linux-can/can-tests/blob/master/j1939/j1939_ac_1k_bam_lo=
cal0.sh

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--n75w4eckvcy5gpqk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERBNZvwSgvmcMY/T74omh9DUaUbMFAl8tU/4ACgkQ4omh9DUa
UbPhvxAAxOQ+jcN0KCTwuokh3OstfcYfo1QPKj+HKdphdxy7m6eA84SX1879VOiE
zqJuqho7+jn5Cu7iReznWsHurGje9AB/pu3sDdKjk28DWDtbsen9+hooAOd7hKwZ
ooxjUy2LSf0P6kWOvpboybb5/4D3VFw3lwmyIPZUsrtLhO5wEPCKlE/WQvn91y5x
HQDixiG/ywyE321uKhjeLwTqA20Ub9ZWV6zN3TJYerjFpU5/jYxvlEjX854RNbXS
gyiyM4mQUAQaGCB3zy3SFb22Kf+hZ0Ob7+jwgDiZfAeeVZMjrYjh5H4jlazqKhbX
eeWtTUi3B99lrDK/sQEToi5CYvHa/5mYTwJLDyj0VKl+TqDB5hceM4Is23lvosho
PQ8ZiP7ArK7s7fn1fscVTgLmatG7/ERuUmJYQiOXwWmIFnu0qwZ+kxpN6lDPS0Kf
V93XapZBO+CB8Q50pGltMLpzGe40HGGlYEKLy9d1FQCS6xw8d1tpwfBpdbemPhaY
F1aj3V1VYRe6a5qJQyZpeV6CpGiKEtU3mBoEkrDCu5DERFt8/RlFcKBKLb+OrjoI
jC5kX9NKD6D1522yIuV2fIRX/6Fda9L1ZrwLqTbXfvcIuf/8crXlpNOLwGoINSje
Tl7lC1QNWHYRo66WLEomLtTyZWRCaUawYsG7sGOQKM6msojpyX0=
=RooE
-----END PGP SIGNATURE-----

--n75w4eckvcy5gpqk--
