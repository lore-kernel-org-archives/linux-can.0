From: =?utf-8?Q?Michael_Luxen?= <mluxen@gmx.net>
Subject: AW: can-isotp-modules
Date: Wed, 4 Nov 2015 13:02:01 +0100
Message-ID: <zarafa.5639f3b9.40ba.0508b35139c7ae30@euve35974.vserver.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from euve35974.vserver.de ([62.75.213.146]:37155 "EHLO
	euve35974.vserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715AbbKDMCD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 4 Nov 2015 07:02:03 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?utf-8?Q?Oliver_Pajonk?= <oliver@pjnk.de>, =?utf-8?Q?Oliver_Hartko?= =?utf-8?Q?pp?= <socketcan@hartkopp.net>
Cc: =?utf-8?Q?linux-can-owner=40vger=2Ekernel=2Eorg?= <linux-can-owner@vger.kernel.org>, =?utf-8?Q?linux-can=40vger=2Ekernel=2Eorg?= <linux-can@vger.kernel.org>

Hello Oliver & Oliver,

thanks for the hint.
The can-isotp-module is created now.

@Oliver H.:
One proposal from myside, can you please add a can-isotp-module install=
ation process (like it is below) on the GITHUB webside.
It would be easier for some people (like me) to get the source code run=
ning without asking. :-)

Thanks & Regards
Michael

-----Urspr=C3=BCngliche Nachricht-----
Von:	Oliver Hartkopp <socketcan@hartkopp.net>
Gesendet:	Mi 04.11.2015 11:11
Betreff:	Re: can-isotp-modules
An:	Oliver Pajonk <oliver@pjnk.de>; Michael Luxen <mluxen@gmx.net>;=20
CC:	linux-can@vger.kernel.org; linux-can-owner@vger.kernel.org;=20
> Hi all,
>=20
> Oliver is right! :-)
>=20
> Instead of
>=20
> 1. git clone https://github.com/hartkopp/can-isotp-modules/
> 2. cd can-isotp-modules
> 3. make
>=20
> just do
>=20
> 1. git clone https://github.com/hartkopp/can-isotp-modules/
> 2. cd can-isotp-modules/net/can
> 3. ./make_isotp.sh
>=20
> which should create a can-isotp.ko module there.
>=20
> When the PF_CAN infrastructure is loaded (modprobe can) an
>=20
> 	insmod ./can-isotp.ko
>=20
> should make it.
>=20
> Currently MAX_MSG_LENGTH is set to 8200 to be able to play with the n=
ew jumbo=20
> PDU length in ISO 15765-2:2015. For previous ISO versions MAX_MSG_LEN=
GTH was=20
> set to 4095. N.B. take care for the isotp can-utils buffer length too=
 when=20
> using jumbo PDU length there.
>=20
> Regards,
> Oliver
>=20
> On 04.11.2015 07:59, Oliver Pajonk wrote:
> >
> > Hi Michael,
> >
> > I was struggeling to compile ISO-TP as well (on my Raspi), but then=
 I found
> > this script (it was mentioned in some other mailing list post):
> >
> >=20
> https://github.com/hartkopp/can-isotp-modules/blob/master/net/can/mak=
e_isotp.sh
> >
> > That worked just fine. Maybe it helps?
> >
> > Best regards,
> > Oliver
> >
> > On 2015-11-03 23:29, Michael Luxen wrote:
> >> Hello Oliver,
> >>
> >> today I've tried to install can-isotp-modules on my BeagleBone Bla=
ck by
> >>
> >> 1. git clone https://github.com/hartkopp/can-isotp-modules/
> >> 2. cd can-isotp-modules
> >> 3. make
> >>
> >> The make process on my Debian Jessie 8.2 (uname -r: 4.1.6-ti-r16)
> >> powered BBB ends up with:
> >>
> >> root@beaglebone:~/can-isotp-modules# make
> >> make -C /lib/modules/4.1.6-ti-r16/build M=3D/root/can-isotp-module=
s
> >> modules TOPDIR=3D/root/can-isotp-modules
> >> make[1]: Entering directory '/usr/src/linux-headers-4.1.6-ti-r16'
> >>   CC [M]  /root/can-isotp-modules/drivers/net/can/vcan.o
> >> In file included from include/linux/module.h:17:0,
> >>                  from /root/can-isotp-modules/drivers/net/can/vcan=
=2Ec:44:
> >> /root/can-isotp-modules/drivers/net/can/vcan.c: In function '__che=
ck_echo':
> >> include/linux/moduleparam.h:377:61: warning: return from incompati=
ble
> >> pointer type
> >>   static inline type __always_unused *__check_##name(void) { retur=
n(p); }
> >>                                                              ^
> >> include/linux/moduleparam.h:428:35: note: in expansion of macro=20
> '__param_check'
> >>  #define param_check_bool(name, p) __param_check(name, p, bool)
> >>                                    ^
> >> include/linux/moduleparam.h:145:2: note: in expansion of macro
> >> 'param_check_bool'
> >>   param_check_##type(name, &(value));       \
> >>   ^
> >> include/linux/moduleparam.h:125:2: note: in expansion of macro
> >> 'module_param_named'
> >>   module_param_named(name, name, type, perm)
> >>   ^
> >> /root/can-isotp-modules/drivers/net/can/vcan.c:91:1: note: in
> >> expansion of macro 'module_param'
> >>  module_param(echo, bool, S_IRUGO);
> >>  ^
> >>   CC [M]  /root/can-isotp-modules/drivers/net/can/slcan.o
> >> /root/can-isotp-modules/drivers/net/can/slcan.c:46:24: fatal error=
:
> >> asm/system.h: No such file or directory
> >>  #include <asm/system.h>
> >>                         ^
> >> compilation terminated.
> >> scripts/Makefile.build:264: recipe for target
> >> '/root/can-isotp-modules/drivers/net/can/slcan.o' failed
> >> make[3]: *** [/root/can-isotp-modules/drivers/net/can/slcan.o] Err=
or 1
> >> scripts/Makefile.build:403: recipe for target
> >> '/root/can-isotp-modules/drivers/net/can' failed
> >> make[2]: *** [/root/can-isotp-modules/drivers/net/can] Error 2
> >> Makefile:1384: recipe for target '_module_/root/can-isotp-modules'=
 failed
> >> make[1]: *** [_module_/root/can-isotp-modules] Error 2
> >> make[1]: Leaving directory '/usr/src/linux-headers-4.1.6-ti-r16'
> >> Makefile:42: recipe for target 'modules' failed
> >> make: *** [modules] Error 2
> >>
> >>
> >> Any idea/hint how to fix this issue?
> >>
> >> Regards
> >> Michael
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-ca=
n" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-can=
" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
