From: Sam Ravnborg <sam.ravnborg@gmail.com>
Subject: Re: WG: PCAN-USB: new socketCAN driver available
Date: Tue, 6 Dec 2011 21:47:47 +0100
Message-ID: <CAMGS=fBKG-X_dxeqPows0fteLEEFC7ZSiWyU+_r9j8w_CYSiqA@mail.gmail.com>
References: <4E400A36.5050303@hartkopp.net>
	<A46279271E5345AC9BFA91C73DF57228@DA310MM05>
	<4E415AB2.5030102@hartkopp.net>
	<2CD045C79786404EA0A81CED1E59763D@DA310MM05>
	<4E4BFF24.2010508@hartkopp.net>
	<33575A72304940CE9103338BA3660CEA@DA310MM05>
	<26B4E6A46012A1469B4EB3BC2A7CAAEC01266CCC@vwagwox00084.vw.vwg>
	<4EC6597A.8040704@peak-system.com>
	<4EC6B080.8090808@hartkopp.net>
	<4ECB65D8.7050207@peak-system.com>
	<4ECB8E75.7@volkswagen.de>
	<4ECBAAFB.8080204@peak-system.com>
	<4ECBAE4E.8000502@volkswagen.de>
	<4ECBB49A.2020508@volkswagen.de>
	<4ED3B355.70209@peak-system.com>
	<26B4E6A46012A1469B4EB3BC2A7CAAECE55502@vwagwox00084.vw.vwg>
	<4ED3CC05.6060606@hartkopp.net>
	<4ED4AF93.8060309@peak-system.com>
	<4EDE71B6.6090805@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54931 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850Ab1LFUrs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 6 Dec 2011 15:47:48 -0500
Received: by iakc1 with SMTP id c1so4202778iak.19
        for <linux-can@vger.kernel.org>; Tue, 06 Dec 2011 12:47:47 -0800 (PST)
In-Reply-To: <4EDE71B6.6090805@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <peak@hartkopp.net>
Cc: s.grosjean@peak-system.com, "Maidhof, Michael" <m.maidhof@peak-system.com>, linux-can@vger.kernel.org

Hi Oliver.

One not to your comments..

> in the linux/drivers/net/can/usb/Makefile it should look like this:
>
> obj-$(CONFIG_CAN_PEAK_USB) += peak_usb.o
> peak_usb-objs := pcan_usb_core.o pcan_usb.o
>
> obj-$(CONFIG_CAN_PEAK_USB_PRO) += peak_usb_pro.o
> peak_usb_pro-objs := pcan_usb_core.o pcan_usb_pro.o

Today it is really recommended to do:

obj-$(CONFIG_CAN_PEAK_USB) += peak_usb.o
peak_usb-y := pcan_usb_core.o pcan_usb.o

obj-$(CONFIG_CAN_PEAK_USB_PRO) += peak_usb_pro.o
peak_usb_pro-y := pcan_usb_core.o pcan_usb_pro.o

Both solutions will work - but the latter allows for some nice
"kbuild" assignments to conditional stuff.

    Sam
