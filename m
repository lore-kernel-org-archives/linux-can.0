From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: AW: [Socketcan-users] [socketcan]problem to using CAN with BeagleBone
 Black A5A
Date: Sun, 09 Jun 2013 09:11:22 +0200
Message-ID: <51B42A9A.3000008@hartkopp.net>
References: <zarafa.51b3a615.6bf0.67d03e2606cfc0c7@v14647.1blu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:49999 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913Ab3FIHL0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 9 Jun 2013 03:11:26 -0400
In-Reply-To: <zarafa.51b3a615.6bf0.67d03e2606cfc0c7@v14647.1blu.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Luxen <mluxen@gmx.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 08.06.2013 23:45, Michael Luxen wrote:

> Did you or anybody else have already some experience on the BeagleBon=
e Black with using the SPI-Interface with MCP2515?

Not yet.

> I'm thinking about to use 1-2 additional CAN-Interfaces to my BeagleB=
one Black! That means two internal CAN-Interfaces and 2x SPI CAN-Interf=
aces.
> For example the Cape TT3201 uses two MCP2515 via SPI but I don't know=
 if there are issues with CAN busload above 30% at 500 kbit/s
> http://www.towertech.it/en/products/hardware/tt3201-can-cape/

We were discussing exactly about this board.
AFAIK the CAN Capes have a I2C EEPROM for configuration data which conf=
licts
with one of the internal DCAN mux pins:

http://circuitco.com/support/index.php?title=3DTT3201_CAN_Cape#EEPROM

My first idea was to to modify the board in a way that both internal DC=
AN
interfaces and only one MCP2515 would be connected to the three CAN
transceivers available on the board.

That's why i was happy to see how you made the second DCAN working.

>=20
> I'm not sure about the cpu-load, latency and messages lost problems. =
My experience on the RasperryPi is that 2x MCP2515 on one SPI-Channel d=
oesn't work with busload above 10% at 500kbit/s.

That's not that much. But it's an interesting information to get an est=
imation
what one might get with this setup.

> IMO the BeagleBone Black has the advantage to use two independent SPI=
-Channels SPI1 and SPI2 for using a MCP2515 on each SPI channel.

This might be better. But IMO sending all the small messages for the re=
gister
accesses is the problem. When serial (e.g. SPI) attached CAN controller=
s had a
message based programming interface (instead of a register based) using=
 the
SPI would be a real alternative.

Regards,
Oliver


>=20
> -----Urspr=C3=BCngliche Nachricht-----
> Von:	Oliver Hartkopp <socketcan@hartkopp.net>
> Gesendet:	Sa 08.06.2013 13:46
> Betreff:	Re: AW: [Socketcan-users] [socketcan]problem to using CAN wi=
th BeagleBone Black A5A
> An:	Michael Luxen <mluxen@gmx.net>;=20
> CC:	linux-can@vger.kernel.org;=20
>> Hello Mike,
>>
>> thanks for pointing to that comprehensive documentation.
>>
>> I was asked by a colleague how to get both internal CAN controllers =
working
>> instead of adding SPI-based MCP2515 interfaces.
>>
>> Good job!
>>
>> Best regards,
>> Oliver
>>
>> On 07.06.2013 21:46, Michael Luxen wrote:
>>> Hello Mohamed,
>>>
>>> is you question still open or answered already?
>>>
>>> If still open, please have a look on this page where you can find h=
ow to=20
>> enable the CAN-Devices on BeagleBone Black.
>>> http://www.aero-box.co.uk/beaglebone-black#TOC-Enable-CANbus-device
>>>
>>> The only thing you have to do is to edit the am335x-bone-common.dts=
i file for=20
>> enabling dcan0 and/or dcan1.
>>> Please have in mind that dcan0 is normaly used for the optional Cap=
es, as=20
>> they use the I2C2 pins which are muxed on the same pins than dcan0.
>>> Nevertheless I've edited am335x-bone-common.dtsi successfully to en=
able dcan0=20
>> and dcan1. On my BeagleBone Black (Hardware A5A) eveything is runnin=
g fine on=20
>> both internal CAN-Interfaces with latest Angstrom and latest Debian =
as well.
>>> Keep in mind that you have to put a CAN-transceiver on the Pins 20/=
19 (DCAN0)=20
>> an 24/26 (DCAN1) on your BeagleBone Black.
>>>
>>> Regards
>>> Mike
>>>
>>> -----Urspr=C3=BCngliche Nachricht-----
>>> Von:	Martin Gysel <m.gysel@gmail.com>
>>> Gesendet:	Di 04.06.2013 13:32
>>> Betreff:	Re: [Socketcan-users] [socketcan]problem to using CAN with=
=20
>> BeagleBone Black A5A
>>> An:	linux-can@vger.kernel.org;=20
>>> CC:	socketcan-users@lists.berlios.de;=20
>>>> Am 25.05.2013 00:49, schrieb Mohamed HAMZAOUI:
>>>>> Hi,
>>>>>
>>>>> I started with beaglebone black A5A, i installed on it the latest
>>>>> Angstrom image with : Linux beaglebone 3.8.13 #1 SMP Mon May 20
>>>>> 17:07:58 CEST 2013 armv7l GNU/Linux
>>>>>
>>>>> I have a problem when I try to add a can device, i load with modp=
robe
>>>>> all necessary kernel module (can, ti_hecc, c_can, c_can_platform,
>>>>> can-raw, can-bcm) but when i execute
>>>>>> ip link add can0 type can
>>>>> I have : RTNETLINK answers: Operation not supported
>>>>> I used a recent version of iproute2.
>>>>
>>>> did you initialize the can module? do you use a can cape? if yes, =
does
>>>> your kernel already include the needed dts to enable the can modul=
e?
>>>>
>>>> /martin
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-ca=
n" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-can=
" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-can"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

