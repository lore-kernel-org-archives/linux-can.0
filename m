From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: WG: PCAN-USB: new socketCAN driver available
Date: Tue, 06 Dec 2011 22:24:53 +0100
Message-ID: <4EDE8825.80901@hartkopp.net>
References: <4E400A36.5050303@hartkopp.net>	<A46279271E5345AC9BFA91C73DF57228@DA310MM05>	<4E415AB2.5030102@hartkopp.net>	<2CD045C79786404EA0A81CED1E59763D@DA310MM05>	<4E4BFF24.2010508@hartkopp.net>	<33575A72304940CE9103338BA3660CEA@DA310MM05>	<26B4E6A46012A1469B4EB3BC2A7CAAEC01266CCC@vwagwox00084.vw.vwg>	<4EC6597A.8040704@peak-system.com>	<4EC6B080.8090808@hartkopp.net>	<4ECB65D8.7050207@peak-system.com>	<4ECB8E75.7@volkswagen.de>	<4ECBAAFB.8080204@peak-system.com>	<4ECBAE4E.8000502@volkswagen.de>	<4ECBB49A.2020508@volkswagen.de>	<4ED3B355.70209@peak-system.com>	<26B4E6A46012A1469B4EB3BC2A7CAAECE55502@vwagwox00084.vw.vwg>	<4ED3CC05.6060606@hartkopp.net>	<4ED4AF93.8060309@peak-system.com>	<4EDE71B6.6090805@hartkopp.net> <CAMGS=fBKG-X_dxeqPows0fteLEEFC7ZSiWyU+_r9j8w_CYSiqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:28669 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605Ab1LFVYz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 6 Dec 2011 16:24:55 -0500
In-Reply-To: <CAMGS=fBKG-X_dxeqPows0fteLEEFC7ZSiWyU+_r9j8w_CYSiqA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sam Ravnborg <sam.ravnborg@gmail.com>
Cc: s.grosjean@peak-system.com, "Maidhof, Michael" <m.maidhof@peak-system.com>, linux-can@vger.kernel.org

On 06.12.2011 21:47, Sam Ravnborg wrote:

> Hi Oliver.
> 
> One not to your comments..
> 
>> in the linux/drivers/net/can/usb/Makefile it should look like this:
>>
>> obj-$(CONFIG_CAN_PEAK_USB) += peak_usb.o
>> peak_usb-objs := pcan_usb_core.o pcan_usb.o
>>
>> obj-$(CONFIG_CAN_PEAK_USB_PRO) += peak_usb_pro.o
>> peak_usb_pro-objs := pcan_usb_core.o pcan_usb_pro.o
> 
> Today it is really recommended to do:
> 
> obj-$(CONFIG_CAN_PEAK_USB) += peak_usb.o
> peak_usb-y := pcan_usb_core.o pcan_usb.o
> 
> obj-$(CONFIG_CAN_PEAK_USB_PRO) += peak_usb_pro.o
> peak_usb_pro-y := pcan_usb_core.o pcan_usb_pro.o
> 
> Both solutions will work - but the latter allows for some nice
> "kbuild" assignments to conditional stuff.
> 


Ah ok,

i picked that from here:

http://patchwork.ozlabs.org/patch/129539/

Good to know that it can be made 'even better' :-)

Thanks,
Oliver
