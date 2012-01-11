From: Grosjean Stephane <s.grosjean@peak-system.com>
Subject: Re: [PATCH] Add PEAK System USB adapters core driver
Date: Wed, 11 Jan 2012 10:23:53 +0100
Message-ID: <4F0D5529.7020208@peak-system.com>
References: <871799.098418222-sendEmail@ubuntu-i386> <4F0C102D.5060304@grandegger.com> <4F0C57B9.2020204@hartkopp.net> <4F0C5AC1.2070806@grandegger.com>
Reply-To: s.grosjean@peak-system.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-4d.bbox.fr ([194.158.122.134]:38156 "EHLO mail-4d.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755599Ab2AKJX6 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 11 Jan 2012 04:23:58 -0500
In-Reply-To: <4F0C5AC1.2070806@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Linux CAN mailing list <linux-can@vger.kernel.org>



Le 10/01/2012 16:35, Wolfgang Grandegger a =E9crit :
> On 01/10/2012 04:22 PM, Oliver Hartkopp wrote:
>> On 10.01.2012 11:17, Wolfgang Grandegger wrote:
>>
>>>>   drivers/net/can/usb/Kconfig                  |    1 +
>>>>   drivers/net/can/usb/Makefile                 |    1 +
>>>>   drivers/net/can/usb/peak_usb/Kconfig         |   19 +
>>>>   drivers/net/can/usb/peak_usb/Makefile        |   10 +
>>>>   drivers/net/can/usb/peak_usb/pcan_usb_core.c |  893 ++++++++++++=
++++++++++++++
>>>>   drivers/net/can/usb/peak_usb/peak_usb.h      |  149 +++++
>>>>   6 files changed, 1073 insertions(+), 0 deletions(-)
>>>>   create mode 100644 drivers/net/can/usb/peak_usb/Kconfig
>>>>   create mode 100644 drivers/net/can/usb/peak_usb/Makefile
>>>>   create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_core.c
>>> Why not naming the file peak_usb.c? You already use "peak_usb" for =
the
>>> header file as function prefix inside!
>>
>> AFAIR the driver built results in peak_usb.ko
>>
>> And the driver contains the pcan_usb.c and pcan_usb_pro.c
>>
>> If it's possible from the build process pcan_usb_core.c should be re=
named to
>> peak_usb.c - that's right.

What I know from the build process doesn't enable to do that (that is,=20
building module.ko from module.c **and** file.c:

obj-$(CONFIG_CAN_PEAK_USB) +=3D peak_usb.o pcan_usb.o pcan_usb_pro.o

linux-can-next$
   CHK     include/linux/version.h
   CHK     include/generated/utsrelease.h
   CALL    scripts/checksyscalls.sh
   CHK     include/generated/compile.h
   CC [M]  drivers/net/can/usb/peak_usb/pcan_usb.o
   CC [M]  drivers/net/can/usb/peak_usb/pcan_usb_pro.o
Kernel: arch/x86/boot/bzImage is ready  (#3)
   Building modules, stage 2.
   MODPOST 3012 modules
ERROR: "pcan_usb_pro" [drivers/net/can/usb/peak_usb/peak_usb.ko] undefi=
ned!
ERROR: "pcan_usb" [drivers/net/can/usb/peak_usb/peak_usb.ko] undefined!
ERROR: "peak_usb_set_ts_now"=20
[drivers/net/can/usb/peak_usb/pcan_usb_pro.ko] undefined!
ERROR: "peak_usb_get_ts_tv"=20
[drivers/net/can/usb/peak_usb/pcan_usb_pro.ko] undefined!
ERROR: "dump_mem" [drivers/net/can/usb/peak_usb/pcan_usb_pro.ko] undefi=
ned!
ERROR: "peak_usb_init_time_ref"=20
[drivers/net/can/usb/peak_usb/pcan_usb_pro.ko] undefined!
ERROR: "peak_usb_set_ts_now" [drivers/net/can/usb/peak_usb/pcan_usb.ko]=
=20
undefined!
ERROR: "peak_usb_update_ts_now"=20
[drivers/net/can/usb/peak_usb/pcan_usb.ko] undefined!
ERROR: "peak_usb_get_ts_tv" [drivers/net/can/usb/peak_usb/pcan_usb.ko]=20
undefined!
ERROR: "peak_usb_init_time_ref"=20
[drivers/net/can/usb/peak_usb/pcan_usb.ko] undefined!
WARNING: modpost: Found 23 section mismatch(es).
To see full details build your kernel with:
'make CONFIG_DEBUG_SECTION_MISMATCH=3Dy'
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2
linux-can-next$

=2E.. but I'm not an expert in the mainline kernel. Is there another wa=
y=20
to do that?

> We should remove the device specific Kconfigs including the related
> #ifdefs. It's then *one* driver which always supports the two USB
> devices. Anything else does not really make sense. Maybe just for ver=
y
> low end devices where any byte counts.
Ok I'll do a driver which supports the two usb adapters without any #if=
def.

> Have a look to other USB drivers.
> They supports tons of devices without any #ifdef.
=2E.. had a look to driver/net/usb  but all of these are single file=20
module drivers, so does not help. Where are the other please?
> Wolfgang.
>

St=E9phane.

