From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: KMSAN: uninit-value in can_receive
Date: Tue, 3 Dec 2019 11:40:07 +0100
Message-ID: <5d539fdf-dcd8-3bab-1347-dbcbe63c646d@pengutronix.de>
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
 <0f395f1e-b7d4-6254-2a0c-54029b4dc38f@pengutronix.de>
 <82b02a62-51ff-4568-c33d-90223a2aed86@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="wTDiHAZ40UyZRmeXKAzo1IfJUECuaBNE4"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <82b02a62-51ff-4568-c33d-90223a2aed86@hartkopp.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>, Eric Dumazet <eric.dumazet@gmail.com>, syzbot <syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com>, davem@davemloft.net, glider@google.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wTDiHAZ40UyZRmeXKAzo1IfJUECuaBNE4
Content-Type: multipart/mixed; boundary="erGAT8plmeXGe87IUrkUEGtfmoKpbKo9C";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Eric Dumazet <eric.dumazet@gmail.com>,
 syzbot <syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com>,
 davem@davemloft.net, glider@google.com, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
Message-ID: <5d539fdf-dcd8-3bab-1347-dbcbe63c646d@pengutronix.de>
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
 <0f395f1e-b7d4-6254-2a0c-54029b4dc38f@pengutronix.de>
 <82b02a62-51ff-4568-c33d-90223a2aed86@hartkopp.net>
In-Reply-To: <82b02a62-51ff-4568-c33d-90223a2aed86@hartkopp.net>

--erGAT8plmeXGe87IUrkUEGtfmoKpbKo9C
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hey Oliver,

On 12/3/19 11:37 AM, Oliver Hartkopp wrote:
> No. I have analyzed several solutions which turn out to be either unsaf=
e=20
> in processing or need some changes in af_packet :-(
>=20
> I'm currently very busy @work

I know this problem :/
Thanks for your quick feedback, although your busy.

> but will come up with a discussion until end of this week.

Looking forward to this.

> There is no big pressure as the problem is more unpleasant than causing=
=20
> a real problem right now.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--erGAT8plmeXGe87IUrkUEGtfmoKpbKo9C--

--wTDiHAZ40UyZRmeXKAzo1IfJUECuaBNE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3mO4cACgkQWsYho5Hk
nSBSUQgAl5zQRiGygswxp9a9NSLOCofSwtPE+kM+7Izoe32OLmU2K0YOFTriUIzu
AEOMbMH1+4Yd3E62m8OojYRQdbmIxJuGpCFG0tz/1qxBPy5Er6T8oLM2j1cdUTYa
X5ySXkdeS5Sfo20zf7w0FxrqdPXH8xbmDuerAnjE2lRESjPx2Lxepo5oLd305rlK
lHAj4AehgNQfqdVTAN/abFLIQ1AeA8RGsZC5F2E9nizS6A+x5vLDxqim9RaXXbdE
swFN32k3eOZz1Sr1453ehAsuFgcJ33dZwzOFZzvineAFSE9/RaI+cDJcFfzO+B7F
dwRPXiwR5HvkzL7NIz43rO/Qtk0ytA==
=Vtx6
-----END PGP SIGNATURE-----

--wTDiHAZ40UyZRmeXKAzo1IfJUECuaBNE4--
