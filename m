From: Grosjean Stephane <s.grosjean@peak-system.com>
Subject: Re: [PATCH] Add PEAK System USB adapters core driver
Date: Wed, 11 Jan 2012 11:09:54 +0100
Message-ID: <4F0D5FF2.8070906@peak-system.com>
References: <871799.098418222-sendEmail@ubuntu-i386> <4F0C102D.5060304@grandegger.com> <4F0C57B9.2020204@hartkopp.net> <4F0C5AC1.2070806@grandegger.com> <4F0D5529.7020208@peak-system.com> <4F0D5B5C.2040205@pengutronix.de>
Reply-To: s.grosjean@peak-system.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-1d.bbox.fr ([194.158.122.56]:62033 "EHLO mail-1d.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751286Ab2AKKJ7 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 11 Jan 2012 05:09:59 -0500
In-Reply-To: <4F0D5B5C.2040205@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Linux CAN mailing list <linux-can@vger.kernel.org>



Le 11/01/2012 10:50, Marc Kleine-Budde a =E9crit :
> On 01/11/2012 10:23 AM, Grosjean Stephane wrote:
>>>>>>    drivers/net/can/usb/Kconfig                  |    1 +
>>>>>>    drivers/net/can/usb/Makefile                 |    1 +
>>>>>>    drivers/net/can/usb/peak_usb/Kconfig         |   19 +
>>>>>>    drivers/net/can/usb/peak_usb/Makefile        |   10 +
>>>>>>    drivers/net/can/usb/peak_usb/pcan_usb_core.c |  893
>>>>>> ++++++++++++++++++++++++++
>>>>>>    drivers/net/can/usb/peak_usb/peak_usb.h      |  149 +++++
>>>>>>    6 files changed, 1073 insertions(+), 0 deletions(-)
>>>>>>    create mode 100644 drivers/net/can/usb/peak_usb/Kconfig
>>>>>>    create mode 100644 drivers/net/can/usb/peak_usb/Makefile
>>>>>>    create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_core=
=2Ec
>>>>> Why not naming the file peak_usb.c? You already use "peak_usb" fo=
r the
>>>>> header file as function prefix inside!
>>>> AFAIR the driver built results in peak_usb.ko
>>>>
>>>> And the driver contains the pcan_usb.c and pcan_usb_pro.c
>>>>
>>>> If it's possible from the build process pcan_usb_core.c should be
>>>> renamed to
>>>> peak_usb.c - that's right.
>> What I know from the build process doesn't enable to do that (that i=
s,
>> building module.ko from module.c **and** file.c:
>>
>> obj-$(CONFIG_CAN_PEAK_USB) +=3D peak_usb.o pcan_usb.o pcan_usb_pro.o
>>
>> linux-can-next$
>>    CHK     include/linux/version.h
>>    CHK     include/generated/utsrelease.h
>>    CALL    scripts/checksyscalls.sh
>>    CHK     include/generated/compile.h
>>    CC [M]  drivers/net/can/usb/peak_usb/pcan_usb.o
>>    CC [M]  drivers/net/can/usb/peak_usb/pcan_usb_pro.o
>> Kernel: arch/x86/boot/bzImage is ready  (#3)
>>    Building modules, stage 2.
>>    MODPOST 3012 modules
>> ERROR: "pcan_usb_pro" [drivers/net/can/usb/peak_usb/peak_usb.ko] und=
efined!
>> ERROR: "pcan_usb" [drivers/net/can/usb/peak_usb/peak_usb.ko] undefin=
ed!
>> ERROR: "peak_usb_set_ts_now"
>> [drivers/net/can/usb/peak_usb/pcan_usb_pro.ko] undefined!
>> ERROR: "peak_usb_get_ts_tv"
>> [drivers/net/can/usb/peak_usb/pcan_usb_pro.ko] undefined!
>> ERROR: "dump_mem" [drivers/net/can/usb/peak_usb/pcan_usb_pro.ko] und=
efined!
>> ERROR: "peak_usb_init_time_ref"
>> [drivers/net/can/usb/peak_usb/pcan_usb_pro.ko] undefined!
>> ERROR: "peak_usb_set_ts_now" [drivers/net/can/usb/peak_usb/pcan_usb.=
ko]
>> undefined!
>> ERROR: "peak_usb_update_ts_now"
>> [drivers/net/can/usb/peak_usb/pcan_usb.ko] undefined!
>> ERROR: "peak_usb_get_ts_tv" [drivers/net/can/usb/peak_usb/pcan_usb.k=
o]
>> undefined!
>> ERROR: "peak_usb_init_time_ref"
>> [drivers/net/can/usb/peak_usb/pcan_usb.ko] undefined!
>> WARNING: modpost: Found 23 section mismatch(es).
>> To see full details build your kernel with:
>> 'make CONFIG_DEBUG_SECTION_MISMATCH=3Dy'
>> make[1]: *** [__modpost] Error 1
>> make: *** [modules] Error 2
>> linux-can-next$
>>
>> ... but I'm not an expert in the mainline kernel. Is there another w=
ay
>> to do that?
> Documentation/kbuild/makefiles.txt has this example:
>
> 	obj-$(CONFIG_EXT2_FS) +=3D ext2.o
> 	ext2-y :=3D balloc.o dir.o file.o ialloc.o inode.o ioctl.o \
> 		namei.o super.o symlink.o
> 	ext2-$(CONFIG_EXT2_FS_XATTR) +=3D xattr.o xattr_user.o \
> 		xattr_trusted.o
>
> Which translates into (untested, though):
>
> 	obj-$(CONFIG_CAN_PEAK_USB) +=3D peak_usb.o
> 	peak_usb-y :=3D peak_usb_core.o pcan_usb.o pcan_usb_pro.o
>
> With a peak_usb_core.c file.
Yes of course this works... I already tested that but if everybody=20
agrees this workaround, I'll use it  (but it is cheating ;-))
> Marc

St=E9phane.
