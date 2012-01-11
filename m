From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] Add PEAK System USB adapters core driver
Date: Wed, 11 Jan 2012 11:12:06 +0100
Message-ID: <4F0D6076.3070101@grandegger.com>
References: <871799.098418222-sendEmail@ubuntu-i386> <4F0C102D.5060304@grandegger.com> <4F0C57B9.2020204@hartkopp.net> <4F0C5AC1.2070806@grandegger.com> <4F0D5529.7020208@peak-system.com> <4F0D5B5C.2040205@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:46552 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757367Ab2AKKMQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Jan 2012 05:12:16 -0500
In-Reply-To: <4F0D5B5C.2040205@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: s.grosjean@peak-system.com, Oliver Hartkopp <socketcan@hartkopp.net>, Linux CAN mailing list <linux-can@vger.kernel.org>

On 01/11/2012 10:50 AM, Marc Kleine-Budde wrote:
> On 01/11/2012 10:23 AM, Grosjean Stephane wrote:
>>>>>>   drivers/net/can/usb/Kconfig                  |    1 +
>>>>>>   drivers/net/can/usb/Makefile                 |    1 +
>>>>>>   drivers/net/can/usb/peak_usb/Kconfig         |   19 +
>>>>>>   drivers/net/can/usb/peak_usb/Makefile        |   10 +
>>>>>>   drivers/net/can/usb/peak_usb/pcan_usb_core.c |  893
>>>>>> ++++++++++++++++++++++++++
>>>>>>   drivers/net/can/usb/peak_usb/peak_usb.h      |  149 +++++
>>>>>>   6 files changed, 1073 insertions(+), 0 deletions(-)
>>>>>>   create mode 100644 drivers/net/can/usb/peak_usb/Kconfig
>>>>>>   create mode 100644 drivers/net/can/usb/peak_usb/Makefile
>>>>>>   create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_core.c
>>>>> Why not naming the file peak_usb.c? You already use "peak_usb" for the
>>>>> header file as function prefix inside!
>>>>
>>>> AFAIR the driver built results in peak_usb.ko
>>>>
>>>> And the driver contains the pcan_usb.c and pcan_usb_pro.c
>>>>
>>>> If it's possible from the build process pcan_usb_core.c should be
>>>> renamed to
>>>> peak_usb.c - that's right.
>>
>> What I know from the build process doesn't enable to do that (that is,
>> building module.ko from module.c **and** file.c:
>>
>> obj-$(CONFIG_CAN_PEAK_USB) += peak_usb.o pcan_usb.o pcan_usb_pro.o
>>
>> linux-can-next$
>>   CHK     include/linux/version.h
>>   CHK     include/generated/utsrelease.h
>>   CALL    scripts/checksyscalls.sh
>>   CHK     include/generated/compile.h
>>   CC [M]  drivers/net/can/usb/peak_usb/pcan_usb.o
>>   CC [M]  drivers/net/can/usb/peak_usb/pcan_usb_pro.o
>> Kernel: arch/x86/boot/bzImage is ready  (#3)
>>   Building modules, stage 2.
>>   MODPOST 3012 modules
>> ERROR: "pcan_usb_pro" [drivers/net/can/usb/peak_usb/peak_usb.ko] undefined!
>> ERROR: "pcan_usb" [drivers/net/can/usb/peak_usb/peak_usb.ko] undefined!
>> ERROR: "peak_usb_set_ts_now"
>> [drivers/net/can/usb/peak_usb/pcan_usb_pro.ko] undefined!
>> ERROR: "peak_usb_get_ts_tv"
>> [drivers/net/can/usb/peak_usb/pcan_usb_pro.ko] undefined!
>> ERROR: "dump_mem" [drivers/net/can/usb/peak_usb/pcan_usb_pro.ko] undefined!
>> ERROR: "peak_usb_init_time_ref"
>> [drivers/net/can/usb/peak_usb/pcan_usb_pro.ko] undefined!
>> ERROR: "peak_usb_set_ts_now" [drivers/net/can/usb/peak_usb/pcan_usb.ko]
>> undefined!
>> ERROR: "peak_usb_update_ts_now"
>> [drivers/net/can/usb/peak_usb/pcan_usb.ko] undefined!
>> ERROR: "peak_usb_get_ts_tv" [drivers/net/can/usb/peak_usb/pcan_usb.ko]
>> undefined!
>> ERROR: "peak_usb_init_time_ref"
>> [drivers/net/can/usb/peak_usb/pcan_usb.ko] undefined!
>> WARNING: modpost: Found 23 section mismatch(es).
>> To see full details build your kernel with:
>> 'make CONFIG_DEBUG_SECTION_MISMATCH=y'
>> make[1]: *** [__modpost] Error 1
>> make: *** [modules] Error 2
>> linux-can-next$
>>
>> ... but I'm not an expert in the mainline kernel. Is there another way
>> to do that?
> 
> Documentation/kbuild/makefiles.txt has this example:
> 
> 	obj-$(CONFIG_EXT2_FS) += ext2.o
> 	ext2-y := balloc.o dir.o file.o ialloc.o inode.o ioctl.o \
> 		namei.o super.o symlink.o
> 	ext2-$(CONFIG_EXT2_FS_XATTR) += xattr.o xattr_user.o \
> 		xattr_trusted.o
> 
> Which translates into (untested, though):
> 
> 	obj-$(CONFIG_CAN_PEAK_USB) += peak_usb.o
> 	peak_usb-y := peak_usb_core.o pcan_usb.o pcan_usb_pro.o
> 
> With a peak_usb_core.c file.

I suggested to use peak_usb.c (instead of pcan_core.c) to have a
consistent naming (header file and prefix). This seems not to be
possible. I was not aware of that. Naming the files peak_usb_core.c and
peak_usb_core.h seems a good alternative.

Wolfgang.

