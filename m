From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v8] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Sat, 15 Dec 2012 09:06:10 +0100
Message-ID: <50CC2F72.60609@hartkopp.net>
References: <1355554434-10502-1-git-send-email-krumboeck@universalnet.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:12537 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896Ab2LOIGU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 15 Dec 2012 03:06:20 -0500
In-Reply-To: <1355554434-10502-1-git-send-email-krumboeck@universalnet.at>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Bernd Krumboeck <b.krumboeck@gmail.com>
Cc: linux-can@vger.kernel.org, linux-usb@vger.kernel.org, info@gerhard-bertelsmann.de, gediminas@8devices.com, Bernd Krumboeck <krumboeck@universalnet.at>

On 15.12.2012 07:53, Bernd Krumboeck wrote:

> +++ b/Documentation/ABI/testing/sysfs-driver-usb_8dev
> @@ -0,0 +1,13 @@
> +What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/firmware
> +Date:		December 2012
> +Contact:	Bernd Krumboeck <krumboeck@universalnet.at>
> +Description:
> +		Returns the firmware version in the form "<major>.<minor>".
> +		This file is readonly.
> +
> +What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/hardware
> +Date:		December 2012
> +Contact:	Bernd Krumboeck <krumboeck@universalnet.at>
> +Description:
> +		Returns the hardware version in the form "<major>.<minor>".
> +		This file is readonly.


Hello Bernd,

sorry but probably i missed the discussion about this point:

Why do your create some extra sysfs entries for plain static information that
could be retrieved from the syslog too?

E.g. when attaching the PCAN USB, i get this:

usb 2-1.3: new full-speed USB device number 6 using ehci-pci
usb 2-1.3: New USB device found, idVendor=0c72, idProduct=000c
usb 2-1.3: New USB device strings: Mfr=0, Product=3, SerialNumber=0
usb 2-1.3: Product: VER1:PEAK    
VER2:02.8.01        
DAT :06.05.2004
TIME:09:35:37
                             ...
peak_usb 2-1.3:1.0: PEAK-System PCAN-USB adapter hwrev 28 serial FFFFFFFF (1 channel)
peak_usb 2-1.3:1.0 can2: attached to PCAN-USB channel 0 (device 67)
usbcore: registered new interface driver peak_usb

Don't you think it's a better idea to add an additional line to the syslog
telling about this *static* hw/sw information than adding the extra complexity
and documentation for the sysfs handling?

Regards,
Oliver

