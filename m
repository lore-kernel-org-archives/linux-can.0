From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: flexcan gcc optimization bug
Date: Wed, 26 Jun 2013 12:16:31 +0200
Message-ID: <51CABF7F.3040504@pengutronix.de>
References: <51CAB7CF.2050405@hale.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2HWFFNCFKNBGNGBSNXVMA"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53012 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619Ab3FZKZ0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Jun 2013 06:25:26 -0400
In-Reply-To: <51CAB7CF.2050405@hale.at>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Thalmeier <michael.thalmeier@hale.at>
Cc: linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Hui Wang <jason77.wang@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2HWFFNCFKNBGNGBSNXVMA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/26/2013 11:43 AM, Michael Thalmeier wrote:
> Hi !
>=20
> I have a weird problem with the flexcan driver on our i.MX28 board.
> As soon as i configure the interface with "canconfig can0 bitrate 12500=
0 start"
> (or the equivalent ip command) I get the following segmentation fault i=
n the driver:
>=20
> [   17.830000] Unhandled fault: external abort on non-linefetch (0x008)=
 at 0xf5032048
> [   17.830000] Internal error: : 8 [#1] ARM
> [   17.830000] Modules linked in:
> [   17.830000] CPU: 0    Not tainted  (3.6.0-00059-g867073b #226)
> [   17.830000] PC is at flexcan_chip_start+0x16c/0x204
> [   17.830000] LR is at flexcan_chip_start+0xd0/0x204
> [   17.830000] pc : [<c01de168>]    lr : [<c01de0cc>]    psr: 60000013
> [   17.830000] sp : cf76dae8  ip : 00000478  fp : 00000000
> [   17.830000] r10: c030f394  r9 : c0318430  r8 : 04000000
> [   17.830000] r7 : 00000000  r6 : f5032470  r5 : cf580000  r4 : f50320=
00
> [   17.830000] r3 : 00000004  r2 : 00000000  r1 : 00000047  r0 : f50323=
f0
> [   17.830000] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Seg=
ment user
> [   17.830000] Control: 0005317f  Table: 4f78c000  DAC: 00000015
> [   17.830000] Process canconfig (pid: 216, stack limit =3D 0xcf76c270)=

> [   17.830000] Stack: (0xcf76dae8 to 0xcf76e000)
> ...
> [   17.830000] [<c01de168>] (flexcan_chip_start+0x16c/0x204) from [<c01=
de2ac>] (flexcan_open+0xac/0x140)
> [   17.830000] [<c01de2ac>] (flexcan_open+0xac/0x140) from [<c0270978>]=
 (__dev_open+0xac/0x110)
> [   17.830000] [<c0270978>] (__dev_open+0xac/0x110) from [<c0270bac>] (=
__dev_change_flags+0x78/0x13c)
> [   17.830000] [<c0270bac>] (__dev_change_flags+0x78/0x13c) from [<c027=
0cdc>] (dev_change_flags+0x10/0x48)
> [   17.830000] [<c0270cdc>] (dev_change_flags+0x10/0x48) from [<c027ca0=
8>] (do_setlink+0x338/0x858)
> [   17.830000] [<c027ca08>] (do_setlink+0x338/0x858) from [<c027ddbc>] =
(rtnl_newlink+0x2bc/0x46c)
> [   17.830000] [<c027ddbc>] (rtnl_newlink+0x2bc/0x46c) from [<c027d760>=
] (rtnetlink_rcv_msg+0x150/0x294)
> [   17.830000] [<c027d760>] (rtnetlink_rcv_msg+0x150/0x294) from [<c028=
a3f8>] (netlink_rcv_skb+0xbc/0xd8)
> [   17.830000] [<c028a3f8>] (netlink_rcv_skb+0xbc/0xd8) from [<c027c5f4=
>] (rtnetlink_rcv+0x18/0x24)
> [   17.830000] [<c027c5f4>] (rtnetlink_rcv+0x18/0x24) from [<c0289e20>]=
 (netlink_unicast+0x1a4/0x208)
> [   17.830000] [<c0289e20>] (netlink_unicast+0x1a4/0x208) from [<c028a1=
dc>] (netlink_sendmsg+0x2b4/0x318)
> [   17.830000] [<c028a1dc>] (netlink_sendmsg+0x2b4/0x318) from [<c025ca=
74>] (sock_sendmsg+0x80/0xa0)
> [   17.830000] [<c025ca74>] (sock_sendmsg+0x80/0xa0) from [<c025d074>] =
(__sys_sendmsg+0x2a8/0x2c0)
> [   17.830000] [<c025d074>] (__sys_sendmsg+0x2a8/0x2c0) from [<c025e9b4=
>] (sys_sendmsg+0x3c/0x68)
> [   17.830000] [<c025e9b4>] (sys_sendmsg+0x3c/0x68) from [<c000e7e0>] (=
ret_fast_syscall+0x0/0x2c)
> [   17.830000] Code: e5847018 e595346c e5933000 e3130002 (05947048)=20
> [   17.830000] ---[ end trace 12de4c1559c67321 ]---
>=20
> I have debugged this down to the following line in the flexcan driver i=
n flexcan_chip_start:
>=20
> if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES)
>         flexcan_write(0x0, &regs->rxfgmask);
>=20
> As we have an i.MX28 board this line should not be executed, but it is =
as can be seen in the
> objdump output:
>=20
> gcc 4.7.2:
>=20
> if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES)
>  50c:   e598346c        ldr     r3, [r8, #1132] ; 0x46c
>  510:   e5933000        ldr     r3, [r3]
>  514:   e3130002        tst     r3, #2
>         return readl(addr);
> }
>=20
> static inline void flexcan_write(u32 val, void __iomem *addr)
> {
>         writel(val, addr);
>  518:   15846048        strne   r6, [r4, #72]   ; 0x48
>=20
>=20
> gcc 4.6.4:
>=20
> if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES)
>  518:   e595346c        ldr     r3, [r5, #1132] ; 0x46c
>  51c:   e5933000        ldr     r3, [r3]
>  520:   e3130002        tst     r3, #2
>         return readl(addr);
> }
>=20
> static inline void flexcan_write(u32 val, void __iomem *addr)
> {
>         writel(val, addr);
>  524:   05947048        ldreq   r7, [r4, #72]   ; 0x48
>  528:   e5847048        str     r7, [r4, #72]   ; 0x48
>=20
>=20
> As you can see gcc 4.6.4 obviously produces wrong code that always writ=
es this register.
>=20
> What can I do best to prevent the compiler from thinking it is
> safe to access that memory region.

Update your compiler.

See: http://www.spinics.net/lists/arm-kernel/msg193914.html
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D52445


Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2HWFFNCFKNBGNGBSNXVMA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlHKv38ACgkQjTAFq1RaXHOp7QCghi1HmoRhkVuaNf5hGs9dmlGm
wtAAn3x5k7s8k6YiSoWXT+GS9HRXtzBq
=/m7R
-----END PGP SIGNATURE-----

------enig2HWFFNCFKNBGNGBSNXVMA--
