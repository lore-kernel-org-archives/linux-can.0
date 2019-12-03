From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: KMSAN: uninit-value in can_receive
Date: Tue, 3 Dec 2019 11:09:12 +0100
Message-ID: <0f395f1e-b7d4-6254-2a0c-54029b4dc38f@pengutronix.de>
References: <0000000000005c08d10597a3a05d@google.com>
 <a5f73d92-fdf2-2590-c863-39a181dca8e1@hartkopp.net>
 <deedd609-6f3b-8035-47e1-252ab221faa1@pengutronix.de>
 <7934bc2b-597f-0bb3-be2d-32f3b07b4de9@hartkopp.net>
 <7f5c4546-0c1a-86ae-581e-0203b5fca446@pengutronix.de>
 <1f7d6ea7-152e-ff18-549c-b196d8b5e3a7@hartkopp.net>
 <9e06266a-67f3-7352-7b87-2b9144c7c9a9@gmail.com>
 <3142c032-e46a-531c-d1b8-d532e5b403a6@hartkopp.net>
 <92c04159-b83a-3e33-91da-25a727a692d0@gmail.com>
 <c1f80bac-bb75-e671-ba32-05cfae86569c@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="f2B7MSGQBQp6YbVQWJU9Lrw0rJtRR0jeS"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <c1f80bac-bb75-e671-ba32-05cfae86569c@hartkopp.net>
Sender: netdev-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>, Eric Dumazet <eric.dumazet@gmail.com>, syzbot <syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com>, davem@davemloft.net, glider@google.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f2B7MSGQBQp6YbVQWJU9Lrw0rJtRR0jeS
Content-Type: multipart/mixed; boundary="At7nxJr8wb5hZye1lmWJKyOb0UJhSIXOC";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Eric Dumazet <eric.dumazet@gmail.com>,
 syzbot <syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com>,
 davem@davemloft.net, glider@google.com, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
Message-ID: <0f395f1e-b7d4-6254-2a0c-54029b4dc38f@pengutronix.de>
Subject: Re: KMSAN: uninit-value in can_receive
References: <0000000000005c08d10597a3a05d@google.com>
 <a5f73d92-fdf2-2590-c863-39a181dca8e1@hartkopp.net>
 <deedd609-6f3b-8035-47e1-252ab221faa1@pengutronix.de>
 <7934bc2b-597f-0bb3-be2d-32f3b07b4de9@hartkopp.net>
 <7f5c4546-0c1a-86ae-581e-0203b5fca446@pengutronix.de>
 <1f7d6ea7-152e-ff18-549c-b196d8b5e3a7@hartkopp.net>
 <9e06266a-67f3-7352-7b87-2b9144c7c9a9@gmail.com>
 <3142c032-e46a-531c-d1b8-d532e5b403a6@hartkopp.net>
 <92c04159-b83a-3e33-91da-25a727a692d0@gmail.com>
 <c1f80bac-bb75-e671-ba32-05cfae86569c@hartkopp.net>
In-Reply-To: <c1f80bac-bb75-e671-ba32-05cfae86569c@hartkopp.net>

--At7nxJr8wb5hZye1lmWJKyOb0UJhSIXOC
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/20/19 9:10 PM, Oliver Hartkopp wrote:
[...]
> So the KMSAN detection was right at the end :-(
>=20
> I'll take a closer look to enable PF_PACKET to send CAN frames again=20
> which will fix up the entire  problem.

I'm going to send a pull request today. Do you already have a fix for thi=
s?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--At7nxJr8wb5hZye1lmWJKyOb0UJhSIXOC--

--f2B7MSGQBQp6YbVQWJU9Lrw0rJtRR0jeS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3mNEgACgkQWsYho5Hk
nSDJXQf/fIq/7xN90kzcb37GjA+786hSOo75BmT1hys0AlmwhGfVDAnykpN8yOUS
PXouEyLei42dgV3ISBtk3DBPv25P0asIaYe2OD9vyO7dxlZYb4QNe83+kDp7AQis
wzXpTbjhdB/5IVcdDvk/d3NdTVdfADhZ2yvjp5n7ucJ4TtjVk8TbL9X3f1YW/lP/
5i63Obt/apof1I9B9W9hx0ZbGJBnOpH5CGxJ+QgBERExoXUye/pKlfwe2UET0Miv
/ASxLiHH+sR/sdNu7ItHn5eWAGZOpncAZJk2T6Lelc/77u3IeZaBtHXb0hQa946q
WgYezs+opZzcLMl7nYbKJKl8kr6NMg==
=y804
-----END PGP SIGNATURE-----

--f2B7MSGQBQp6YbVQWJU9Lrw0rJtRR0jeS--
