From: Oliver Hartkopp <peak@hartkopp.net>
Subject: Re: WG: PCAN-USB: new socketCAN driver available
Date: Tue, 06 Dec 2011 20:49:10 +0100
Message-ID: <4EDE71B6.6090805@hartkopp.net>
References: <4E400A36.5050303@hartkopp.net> <A46279271E5345AC9BFA91C73DF57228@DA310MM05> <4E415AB2.5030102@hartkopp.net> <2CD045C79786404EA0A81CED1E59763D@DA310MM05> <4E4BFF24.2010508@hartkopp.net> <33575A72304940CE9103338BA3660CEA@DA310MM05> <26B4E6A46012A1469B4EB3BC2A7CAAEC01266CCC@vwagwox00084.vw.vwg> <4EC6597A.8040704@peak-system.com> <4EC6B080.8090808@hartkopp.net> <4ECB65D8.7050207@peak-system.com> <4ECB8E75.7@volkswagen.de> <4ECBAAFB.8080204@peak-system.com> <4ECBAE4E.8000502@volkswagen.de> <4ECBB49A.2020508@volkswagen.de> <4ED3B355.70209@peak-system.com> <26B4E6A46012A1469B4EB3BC2A7CAAECE55502@vwagwox00084.vw.vwg> <4ED3CC05.6060606@hartkopp.net> <4ED4AF93.8060309@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:57269 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021Ab1LFTtI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 6 Dec 2011 14:49:08 -0500
In-Reply-To: <4ED4AF93.8060309@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: "Maidhof, Michael" <m.maidhof@peak-system.com>, linux-can@vger.kernel.org

Hello Stephane,

i checked your PCAN-USB driver - and also got the printk msg when plugging the
USB pro ;-)

Some remarks to the current state and some details for naming conventions.

On 29.11.2011 11:10, Grosjean Stephane wrote:


~/peak_usb-0.2.0$ wc -l *
   10 Kbuild
   27 Kconfig
  113 Makefile
  813 peak_usb_core.c
  109 peak_usb.h
  854 peak_usb_pcan.c
   31 peak_usb_pcan.h
   64 peak_usb_pcan_pro.c
   32 peak_usb_pcan_pro.h
 2053 total


The number of files should be reduced.

The drivers module name should be

peak_usb.ko
peak_usb_pro.ko

'pcan' is a vendor brand name which should not go into the module name. Having
PCAN in the Kconfig (like it is for the peak_pci driver) or in source file
names is fine.

Eg. if you have a shared source like peak_usb_core.c a peak_usb.h header file
is ok - but you should omit peak_usb_pcan[_pro].h , at least they contain
almost nothing ;-)

The files should then reduce to:

Kbuild
Kconfig
Makefile
pcan_usb_core.h
pcan_usb_core.c
pcan_usb.c
pcan_usb_pro.c

Checking the Kconfig:

> diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
> index 0452549..9ec2f9c 100644
> --- a/drivers/net/can/usb/Kconfig
> +++ b/drivers/net/can/usb/Kconfig
> @@ -13,4 +13,21 @@ config CAN_ESD_USB2
>            This driver supports the CAN-USB/2 interface
>            from esd electronic system design gmbh (http://www.esd.eu).
>
> +config CAN_PEAK_PCAN_USB

name it CAN_PEAK_USB

> +       tristate "PEAK-System's PCAN-USB adapter"

"PEAK PCAN USB adapter"

> +       select CAN_PEAK_USB

remove the select (see Makefile comment below)

> +       ---help---
> +         This driver is for the one channel PCAN-USB interface
> +         from PEAK-System (http://www.peak-system.com).

ok.

> +
> +config CAN_PEAK_PCAN_USB_PRO

CAN_PEAK_USB_PRO

> +       tristate "PEAK-System's PCAN-USB-PRO adapter"

"PEAK PCAN USB Pro adapter"

> +       select CAN_PEAK_USB

remove the select (see Makefile comment below)

> +       ---help---
> +         This driver is for the two channels PCAN-USB-PRO interface

PCAN-USB Pro

> +         from PEAK-System (http://www.peak-system.com).
> +
> +config CAN_PEAK_USB
> +       tristate
> +

Remove this.

To select config entries should be omitted if possible.

And now (tada!) the Makefile:

> diff --git a/drivers/net/can/usb/Makefile b/drivers/net/can/usb/Makefile
> index fce3cf1..7cb115b 100644
> --- a/drivers/net/can/usb/Makefile
> +++ b/drivers/net/can/usb/Makefile
> @@ -6,3 +6,14 @@ obj-$(CONFIG_CAN_EMS_USB) += ems_usb.o
>  obj-$(CONFIG_CAN_ESD_USB2) += esd_usb2.o
>
>  ccflags-$(CONFIG_CAN_DEBUG_DEVICES) := -DDEBUG
> +
> +obj-$(CONFIG_CAN_PEAK_USB) += peak_usb.o
> +peak_usb-y = peak_usb_core.o
> +
> +ifneq ($(CONFIG_CAN_PEAK_PCAN_USB),)
> +peak_usb-y += peak_usb_pcan.o
> +endif
> +
> +ifneq ($(CONFIG_CAN_PEAK_PCAN_USB_PRO),)
> +peak_usb-y += peak_usb_pcan_pro.o
> +endif

Ok it worked, but ...

in the linux/drivers/net/can/usb/Makefile it should look like this:

obj-$(CONFIG_CAN_PEAK_USB) += peak_usb.o
peak_usb-objs := pcan_usb_core.o pcan_usb.o

obj-$(CONFIG_CAN_PEAK_USB_PRO) += peak_usb_pro.o
peak_usb_pro-objs := pcan_usb_core.o pcan_usb_pro.o


> 
> Load the module, then "$cat /sys/modules/peak_usb/version" and plug the
> PCAN-USB adapter... Yes you can also try with the PCAN-USB-PRO...


Is having a version string here a common thing?

> Hope you enjoy!


I did. No crash reports :-)

> Any feedback is welcome.


Done.

Best regards,
Oliver
