From: =?utf-8?Q?Michael_Luxen?= <mluxen@gmx.net>
Subject: AW: Need support J1939 protocol support to my kernel (v3.8 on
 BeagleBone Black)
Date: Mon, 11 Nov 2013 17:14:02 +0100
Message-ID: <zarafa.5281024a.0b28.43b8b0d35b442ecc@v14647.1blu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from v14647.1blu.de ([178.254.6.47]:35751 "EHLO v14647.1blu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753833Ab3KKQXm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 11 Nov 2013 11:23:42 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?utf-8?Q?linux-can=40vger=2Ekernel=2Eorg?= <linux-can@vger.kernel.org>, =?utf-8?Q?patilswa=40gmail=2Ecom?= <patilswa@gmail.com>

Hello Swapnil,

I've success with building the J1939 stack on my BBB based on Debian us=
ing these steps:

git clone git://gitorious.org/linux-can/can-utils.git
cd can-utils
--- get J1939 stuff ---
git remote add j1939 git://gitorious.org/~kurt-vd/linux-can/linux-can-j=
1939.git
git remote update j1939
--- depending on kernel ---
git merge j1939/v3.6
=2E..or=E2=80=A6
git merge j1939/v3.8



Regards
Mike

-----Urspr=C3=BCngliche Nachricht-----
Von:	Swapnil Patil <patilswa@gmail.com>
Gesendet:	Mo 11.11.2013 16:46
Betreff:	Need support J1939 protocol support to my kernel (v3.8 on Beag=
leBone Black)
An:	linux-can@vger.kernel.org;=20
> Hi Kurt,
>=20
>              Thanks for your reply.
> I am using Begalbone Black with Ubuntu 13.04
> I am able to transmit the RAW and extended can message over the can
> bus using can utility
> Now I want to use  J1939 stack.
> I downloaded the
> Linux-can-can-j1939-modules and Linux-can-iproute2-j1939  and tried t=
o
> build them but it failed
>=20
> Log of iproute2-j1939$ make
>=20
> make[1]: Entering directory `/home/ubuntu/BBB/iproute2-j1939/misc'
> gcc -D_GNU_SOURCE -O2 -Wstrict-prototypes -Wall -I../include
> -DRESOLVE_HOSTNAM -DLIBDIR=3D\"/usr/lib/\" -I  -o arpdarpd.c
> ../lib/libnetlink.a ../lib/libutil.-ldb -lpthread
> gcc: error: arpd: No such file or directory
>=20
> Log of can-j1939-modules: make
> /home/ubuntu/BBB/can-j1939-modules/net/can/j1939/rtnl.c:232:25: error=
:
> =C3=A2struct netlink_skb_parms=C3=A2 has no member named=C3=A2pid=C3=A2
> /
>=20
>       If someone already build this on Begalbone black with ubuntu
> 13.04 or angstrom kernel Please add the steps
>=20
> Thanks
> Swapnil
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
