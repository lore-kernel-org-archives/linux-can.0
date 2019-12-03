From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3/6] can: slcan: Fix use-after-free Read in slcan_open
Date: Tue, 3 Dec 2019 12:53:54 +0100
Message-ID: <78836d74-1440-fb8d-3178-08d01480d73d@pengutronix.de>
References: <20191203104703.14620-1-mkl@pengutronix.de>
 <20191203104703.14620-4-mkl@pengutronix.de>
 <df8db94f-307f-6a08-2711-c869b4548a67@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="m5q2nLK3MfThEV8N3sBiy9t3Trj7TCZ1P"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <df8db94f-307f-6a08-2711-c869b4548a67@hartkopp.net>
Sender: netdev-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>, netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Jouni Hogander <jouni.hogander@unikie.com>, Wolfgang Grandegger <wg@grandegger.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, linux-stable <stable@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m5q2nLK3MfThEV8N3sBiy9t3Trj7TCZ1P
Content-Type: multipart/mixed; boundary="2qNtbmPEnGrGDMxkUcanKkFxyGpCXlfzi";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de,
 Jouni Hogander <jouni.hogander@unikie.com>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 linux-stable <stable@vger.kernel.org>
Message-ID: <78836d74-1440-fb8d-3178-08d01480d73d@pengutronix.de>
Subject: Re: [PATCH 3/6] can: slcan: Fix use-after-free Read in slcan_open
References: <20191203104703.14620-1-mkl@pengutronix.de>
 <20191203104703.14620-4-mkl@pengutronix.de>
 <df8db94f-307f-6a08-2711-c869b4548a67@hartkopp.net>
In-Reply-To: <df8db94f-307f-6a08-2711-c869b4548a67@hartkopp.net>

--2qNtbmPEnGrGDMxkUcanKkFxyGpCXlfzi
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/3/19 12:21 PM, Oliver Hartkopp wrote:
>=20
>=20
> On 03/12/2019 11.47, Marc Kleine-Budde wrote:
>> From: Jouni Hogander <jouni.hogander@unikie.com>
>>
>> Slcan_open doesn't clean-up device which registration failed from the
>> slcan_devs device list. On next open this list is iterated and freed
>> device is accessed. Fix this by calling slc_free_netdev in error path.=

>>
>> Driver/net/can/slcan.c is derived from slip.c. Use-after-free error wa=
s
>> identified in slip_open by syzboz. Same bug is in slcan.c. Here is the=

>> trace from the Syzbot slip report:
>>
>> __dump_stack lib/dump_stack.c:77 [inline]
>> dump_stack+0x197/0x210 lib/dump_stack.c:118
>> print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.=
c:374
>> __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
>> kasan_report+0x12/0x20 mm/kasan/common.c:634
>> __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:132
>> sl_sync drivers/net/slip/slip.c:725 [inline]
>> slip_open+0xecd/0x11b7 drivers/net/slip/slip.c:801
>> tty_ldisc_open.isra.0+0xa3/0x110 drivers/tty/tty_ldisc.c:469
>> tty_set_ldisc+0x30e/0x6b0 drivers/tty/tty_ldisc.c:596
>> tiocsetd drivers/tty/tty_io.c:2334 [inline]
>> tty_ioctl+0xe8d/0x14f0 drivers/tty/tty_io.c:2594
>> vfs_ioctl fs/ioctl.c:46 [inline]
>> file_ioctl fs/ioctl.c:509 [inline]
>> do_vfs_ioctl+0xdb6/0x13e0 fs/ioctl.c:696
>> ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
>> __do_sys_ioctl fs/ioctl.c:720 [inline]
>> __se_sys_ioctl fs/ioctl.c:718 [inline]
>> __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
>> do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
>> entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> Fixes: ed50e1600b44 ("slcan: Fix memory leak in error path")
>> Cc: Wolfgang Grandegger <wg@grandegger.com>
>> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
>> Cc: David Miller <davem@davemloft.net>
>> Cc: Oliver Hartkopp <socketcan@hartkopp.net>
>> Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>> Signed-off-by: Jouni Hogander <jouni.hogander@unikie.com>
>> Cc: linux-stable <stable@vger.kernel.org> # >=3D v5.4
>=20
> I think this problem existed from the initial commit in 2010 and is not=
=20
> restricted to >=3D v5.4
>=20
> Together with commit commit ed50e1600b4483c049 ("slcan: Fix memory leak=
=20
> in error path") from Jouni Hogander.

Yes, both patches shoud be backported:

ed50e1600b44 slcan: Fix memory leak in error path
9ebd796e2400 can: slcan: Fix use-after-free Read in slcan_open

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--2qNtbmPEnGrGDMxkUcanKkFxyGpCXlfzi--

--m5q2nLK3MfThEV8N3sBiy9t3Trj7TCZ1P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3mTNIACgkQWsYho5Hk
nSAzwgf/dBXyxO4dG6a6EcSFB2muU2YA283PJtKsMsKDa2sNoHcdQjLxTol9K1Q1
C4J+k3I6iecCgPDbXQLPeo8MWzvDsBFVMAC8+46GZ46hbOvtz8iTq8b1y3d802UD
3SfB7KIXv0UzQrfQTZH+vgSS0iMak7E0kBR+AozPCdt6DC5G2CgaucNXV2h7h4EU
DE9D8ERBPWkw+0pvaMygDyiVSBW26oqqp+Prz+wAR9yxcSBEFqfaHIuTlXDuRgbf
WmFgF7Tv1n7Y29Hd7B+UcVaPaxCoIE7KwJxu3m4QpV9HdlxD40am0syO7E/w1Gmh
JE0si4pMzmPyioem02U9TOBbTT9M2w==
=AUfD
-----END PGP SIGNATURE-----

--m5q2nLK3MfThEV8N3sBiy9t3Trj7TCZ1P--
