From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: WG: PCAN-USB: new socketCAN driver available
Date: Wed, 07 Dec 2011 12:15:04 +0100
Message-ID: <4EDF4AB8.6060502@hartkopp.net>
References: <4E400A36.5050303@hartkopp.net> <A46279271E5345AC9BFA91C73DF57228@DA310MM05>	<4E415AB2.5030102@hartkopp.net> <2CD045C79786404EA0A81CED1E59763D@DA310MM05>	<4E4BFF24.2010508@hartkopp.net> <33575A72304940CE9103338BA3660CEA@DA310MM05> <26B4E6A46012A1469B4EB3BC2A7CAAEC01266CCC@vwagwox00084.vw.vwg> <4EC6597A.8040704@peak-system.com>	<4EC6B080.8090808@hartkopp.net> <4ECB65D8.7050207@peak-system.com>	<4ECB8E75.7@volkswagen.de> <4ECBAAFB.8080204@peak-system.com>	<4ECBAE4E.8000502@volkswagen.de> <4ECBB49A.2020508@volkswagen.de>	<4ED3B355.70209@peak-system.com> <26B4E6A46012A1469B4EB3BC2A7CAAECE55502@vwagwox00084.vw.vwg> <4ED3CC05.6060606@hartkopp.net>	<4ED4AF93.8060309@peak-system.com> <4EDE71B6.6090805@hartkopp.net> <CAMGS=fBKG-X_dxeqPows0fteLEEFC7ZSiWyU+_r9j8w_CYSiqA@mail.gmail.com> <4
 EDE8825.80901@hartkopp.net> <4EDF3FF3.80302@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:11151 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973Ab1LGLPF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Dec 2011 06:15:05 -0500
In-Reply-To: <4EDF3FF3.80302@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: Sam Ravnborg <sam.ravnborg@gmail.com>, "Maidhof, Michael" <m.maidhof@peak-system.com>, linux-can@vger.kernel.org, "Uwe Wilhelm (PEAK-System)" <u.wilhelm@peak-system.com>

On 07.12.2011 11:29, Grosjean Stephane wrote:

> Hi,
>=20
> First of all, thank you for your time and all your comments.
>=20
> Le 06/12/2011 22:24, Oliver Hartkopp a =E9crit :
>> On 06.12.2011 21:47, Sam Ravnborg wrote:
>>
>>> Today it is really recommended to do:
>>>
>>> obj-$(CONFIG_CAN_PEAK_USB) +=3D peak_usb.o
>>> peak_usb-y :=3D pcan_usb_core.o pcan_usb.o
>>>
>>> obj-$(CONFIG_CAN_PEAK_USB_PRO) +=3D peak_usb_pro.o
>>> peak_usb_pro-y :=3D pcan_usb_core.o pcan_usb_pro.o
>>>
>>> Both solutions will work - but the latter allows for some nice
>>> "kbuild" assignments to conditional stuff.
>>>
>=20
> right...
>=20
>> I just tried out the suggestion myself ...
>>
>> As my idea was to link the common functions directly to the module b=
inary this
>> may double the needed size. Maybe your approach is really better 8-)
>>
>> But the fact that the select should be omitted is still true.
>>
>> Better you define a
>>
>> config CAN_PEAK_USB
>>     tristate "PEAK System USB adapters"
>>
>> and then
>>
>> config CAN_PCAN_USB
>>     tristate "PEAK PCAN USB adapter"
>>     depends on CAN_PEAK_USB
>>
>>
>> config CAN_PCAN_USB_PRO
>>     tristate "PEAK PCAN USB Pro adapter"
>>     depends on CAN_PEAK_USB
>>
>> ...
>>
>> Regards,
>> Oliver
>=20
> I thought this was better for memory size and also for easier handlin=
g of
> (any) further PEAK USB adapter, never know...
> But, what next? According to your below Kconfig and Sam's Kbuild, and=
 if I
> understand well your suggestions, the Kbuild file always builds 2 mod=
ule
> files, while I wanted to build only a single one, capable of handling=
 one or
> both adapters.


Ah, ok. I formerly thought that you plan to have three separated kernel
modules (core, usb, usbpro) - but i just checked that you only create a
peak_usb.ko which is perfectly fine.

> Please, confirm that a mainline kernel driver should (must?) handle o=
ne and

> only one kind of device.


No. If your driver supports "PEAK PCAN USB / USB Pro adapters" you can =
put
this into a single Kconfig entry and build a single peak_usb.ko if you =
like.

I don't know whether it's worth the effort to build separate drivers an=
d
kernel modules. The current code has some space for improvements and cl=
eanups :-)

When you're finished your work with the USB Pro it's time to post it on
linux-can ML and the we can discuss together how the sources and the dr=
iver
should be packaged best.

Post early & often :-)

> If it should (must), I will modify the Kbuild file as proposed by Sam=
, in
> order to build a peak_usb.ko and/or a peak_usb_pro.ko file.


This was just a suggestion.

>=20
> But in that case, I wonder why the Kernel API offers some data struct=
ures like
> "struct usb_driver.id_table" which are supposed to describe more than=
 one
> device id.


Yes you can do that also (as written above).

Regards,
Oliver
