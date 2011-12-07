From: Grosjean Stephane <s.grosjean@peak-system.com>
Subject: Re: WG: PCAN-USB: new socketCAN driver available
Date: Wed, 07 Dec 2011 11:29:07 +0100
Message-ID: <4EDF3FF3.80302@peak-system.com>
References: <4E400A36.5050303@hartkopp.net> <A46279271E5345AC9BFA91C73DF57228@DA310MM05>	<4E415AB2.5030102@hartkopp.net> <2CD045C79786404EA0A81CED1E59763D@DA310MM05>	<4E4BFF24.2010508@hartkopp.net> <33575A72304940CE9103338BA3660CEA@DA310MM05> <26B4E6A46012A1469B4EB3BC2A7CAAEC01266CCC@vwagwox00084.vw.vwg> <4EC6597A.8040704@peak-system.com>	<4EC6B080.8090808@hartkopp.net> <4ECB65D8.7050207@peak-system.com>	<4ECB8E75.7@volkswagen.de> <4ECBAAFB.8080204@peak-system.com>	<4ECBAE4E.8000502@volkswagen.de> <4ECBB49A.2020508@volkswagen.de>	<4ED3B355.70209@peak-system.com> <26B4E6A46012A1469B4EB3BC2A7CAAECE55502@vwagwox00084.vw.vwg> <4ED3CC05.6060606@hartkopp.net>	<4ED4AF93.8060309@peak-system.com> <4EDE71B6.6090805@hartkopp.net> <CAMGS=fBKG-X_dxeqPows0fteLEEFC7ZSiWyU+_r9j8w_CYSiqA@mail.gmail.com> <4
 EDE8825.80901@hartkopp.net>
Reply-To: s.grosjean@peak-system.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-2d.bbox.fr ([194.158.122.57]:50974 "EHLO mail-2d.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753825Ab1LGK3M (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 7 Dec 2011 05:29:12 -0500
In-Reply-To: <4EDE8825.80901@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Sam Ravnborg <sam.ravnborg@gmail.com>
Cc: "Maidhof, Michael" <m.maidhof@peak-system.com>, linux-can@vger.kernel.org, "Uwe Wilhelm (PEAK-System)" <u.wilhelm@peak-system.com>

Hi,

=46irst of all, thank you for your time and all your comments.

Le 06/12/2011 22:24, Oliver Hartkopp a =E9crit :
 > On 06.12.2011 21:47, Sam Ravnborg wrote:
 >
 >> Today it is really recommended to do:
 >>
 >> obj-$(CONFIG_CAN_PEAK_USB) +=3D peak_usb.o
 >> peak_usb-y :=3D pcan_usb_core.o pcan_usb.o
 >>
 >> obj-$(CONFIG_CAN_PEAK_USB_PRO) +=3D peak_usb_pro.o
 >> peak_usb_pro-y :=3D pcan_usb_core.o pcan_usb_pro.o
 >>
 >> Both solutions will work - but the latter allows for some nice
 >> "kbuild" assignments to conditional stuff.
 >>

right...

 > I just tried out the suggestion myself ...
 >
 > As my idea was to link the common functions directly to the module=20
binary this
 > may double the needed size. Maybe your approach is really better 8-)
 >
 > But the fact that the select should be omitted is still true.
 >
 > Better you define a
 >
 > config CAN_PEAK_USB
 >     tristate "PEAK System USB adapters"
 >
 > and then
 >
 > config CAN_PCAN_USB
 >     tristate "PEAK PCAN USB adapter"
 >     depends on CAN_PEAK_USB
 >
 >
 > config CAN_PCAN_USB_PRO
 >     tristate "PEAK PCAN USB Pro adapter"
 >     depends on CAN_PEAK_USB
 >
 > ...
 >
 > Regards,
 > Oliver

I thought this was better for memory size and also for easier handling=20
of (any) further PEAK USB adapter, never know...
But, what next? According to your below Kconfig and Sam's Kbuild, and i=
f=20
I understand well your suggestions, the Kbuild file always builds 2=20
module files, while I wanted to build only a single one, capable of=20
handling one or both adapters.

Please, confirm that a mainline kernel driver should (must?) handle one=
=20
and only one kind of device.
If it should (must), I will modify the Kbuild file as proposed by Sam,=20
in order to build a peak_usb.ko and/or a peak_usb_pro.ko file.

But in that case, I wonder why the Kernel API offers some data=20
structures like "struct usb_driver.id_table" which are supposed to=20
describe more than one device id.

Regards,

St=E9phane

