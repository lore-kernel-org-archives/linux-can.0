From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [Socketcan-users] [socketcan]problem to using CAN with BeagleBone
 Black A5A
Date: Tue, 11 Jun 2013 08:30:09 +0200
Message-ID: <51B6C3F1.7090608@grandegger.com>
References: <zarafa.51b62efb.7aff.1ab85acd7547c22a@v14647.1blu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:44654 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075Ab3FKGaS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 11 Jun 2013 02:30:18 -0400
In-Reply-To: <zarafa.51b62efb.7aff.1ab85acd7547c22a@v14647.1blu.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Luxen <mluxen@gmx.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>

On 06/10/2013 09:54 PM, Michael Luxen wrote:
> Hello Wolfgang,
>=20
> from the Raspberry Pi point of view I can say that I've patched alrea=
dy the original raspbmc based kernel MCP251x driver to the MCP2515 asyn=
chronous of Andre B. Oliveira. I've also patched the raspbmc SPI driver=
 to use DMA mode for low latency issues.
> With these modifications the MCP2515 runs on my setup with the Raspi =
without any message lost. Also with busload >50% @ 1000kbit/s.

Ah, I was not aware of that. What about pushing these modifications to
mainline? We would assist in getting it accepted.

> More details for Raspi users can be found here:
> http://elinux.org/RPi_CANBus
>=20
> But keep in mind as soon as a second MCP2515 is used on the MCP2515 o=
ne of them stops sending/receiving after a few seconds as the ISR seems=
 to hang.

OK, sounds more like a hardware problem.

Wolfgang.

> Regards
> Mike
>=20
> -----Urspr=FCngliche Nachricht-----
> Von:	Wolfgang Grandegger <wg@grandegger.com>
> Gesendet:	Mo 10.06.2013 19:50
> Betreff:	Re: [Socketcan-users] [socketcan]problem to using CAN with B=
eagleBone Black A5A
> An:	Michael Luxen <mluxen@gmx.net>;=20
> CC:	Oliver Hartkopp <socketcan@hartkopp.net>; linux-can@vger.kernel.o=
rg;=20
>> On 06/10/2013 06:24 PM, Michael Luxen wrote:
>> ...
>>>>> I'm not sure about the cpu-load, latency and messages lost proble=
ms. My=20
>>>> experience on the RasperryPi is that 2x MCP2515 on one SPI-Channel=
 doesn't=20
>> work=20
>>>> with busload above 10% at 500kbit/s.
>>>>
>>>> That's not that much. But it's an interesting information to get a=
n=20
>> estimation
>>>> what one might get with this setup.
>>> But keep in mind that the Raspi has only one SPI channel where I've=
 connected=20
>> two MCP2515 (only independetn ChipSelect and Interrupt lines). There=
fore I'm=20
>> interested in to sees how the BeagleBone Black can handle two MCP251=
5 on=20
>> idenpendent SPI channels (SPI1/SPI2).
>>
>> The problem is not (only) SPI hardware but software. The CAN message=
s
>> are not read-out quickly enough due to latencies resulting in messag=
e
>> losses. May user do report that problem with the MPC251x. The follow=
ing
>> link does have some nice figures:
>>
>>   http://clientes.netvisao.pt/anbadeol/mcp2515.html
>>
>> I think the software can do better but still latency is critical for=
 the
>> MPC251x, especialy MPC2510.
>>
>> Wolfgang.
>>
>>
>>
>>
>>
>>
>>
>>
>>> Regards
>>> Mike
>>> =20
>>>>> -----Urspr=FCngliche Nachricht-----
>>>>> Von:	Oliver Hartkopp <socketcan@hartkopp.net>
>>>>> Gesendet:	Sa 08.06.2013 13:46
>>>>> Betreff:	Re: AW: [Socketcan-users] [socketcan]problem to using CA=
N with=20
>>>> BeagleBone Black A5A
>>>>> An:	Michael Luxen <mluxen@gmx.net>;=20
>>>>> CC:	linux-can@vger.kernel.org;=20
>>>>>> Hello Mike,
>>>>>>
>>>>>> thanks for pointing to that comprehensive documentation.
>>>>>>
>>>>>> I was asked by a colleague how to get both internal CAN controll=
ers working
>>>>>> instead of adding SPI-based MCP2515 interfaces.
>>>>>>
>>>>>> Good job!
>>>>>>
>>>>>> Best regards,
>>>>>> Oliver
>>>>>>
>>>>>> On 07.06.2013 21:46, Michael Luxen wrote:
>>>>>>> Hello Mohamed,
>>>>>>>
>>>>>>> is you question still open or answered already?
>>>>>>>
>>>>>>> If still open, please have a look on this page where you can fi=
nd how to=20
>>>>>> enable the CAN-Devices on BeagleBone Black.
>>>>>>> http://www.aero-box.co.uk/beaglebone-black#TOC-Enable-CANbus-de=
vice
>>>>>>>
>>>>>>> The only thing you have to do is to edit the am335x-bone-common=
=2Edtsi file=20
>>>> for=20
>>>>>> enabling dcan0 and/or dcan1.
>>>>>>> Please have in mind that dcan0 is normaly used for the optional=
 Capes, as=20
>>>>>> they use the I2C2 pins which are muxed on the same pins than dca=
n0.
>>>>>>> Nevertheless I've edited am335x-bone-common.dtsi successfully t=
o enable=20
>>>> dcan0=20
>>>>>> and dcan1. On my BeagleBone Black (Hardware A5A) eveything is ru=
nning fine=20
>>>> on=20
>>>>>> both internal CAN-Interfaces with latest Angstrom and latest Deb=
ian as=20
>> well.
>>>>>>> Keep in mind that you have to put a CAN-transceiver on the Pins=
 20/19=20
>>>> (DCAN0)=20
>>>>>> an 24/26 (DCAN1) on your BeagleBone Black.
>>>>>>>
>>>>>>> Regards
>>>>>>> Mike
>>>>>>>
>>>>>>> -----Urspr=FCngliche Nachricht-----
>>>>>>> Von:	Martin Gysel <m.gysel@gmail.com>
>>>>>>> Gesendet:	Di 04.06.2013 13:32
>>>>>>> Betreff:	Re: [Socketcan-users] [socketcan]problem to using CAN =
with=20
>>>>>> BeagleBone Black A5A
>>>>>>> An:	linux-can@vger.kernel.org;=20
>>>>>>> CC:	socketcan-users@lists.berlios.de;=20
>>>>>>>> Am 25.05.2013 00:49, schrieb Mohamed HAMZAOUI:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> I started with beaglebone black A5A, i installed on it the la=
test
>>>>>>>>> Angstrom image with : Linux beaglebone 3.8.13 #1 SMP Mon May =
20
>>>>>>>>> 17:07:58 CEST 2013 armv7l GNU/Linux
>>>>>>>>>
>>>>>>>>> I have a problem when I try to add a can device, i load with =
modprobe
>>>>>>>>> all necessary kernel module (can, ti_hecc, c_can, c_can_platf=
orm,
>>>>>>>>> can-raw, can-bcm) but when i execute
>>>>>>>>>> ip link add can0 type can
>>>>>>>>> I have : RTNETLINK answers: Operation not supported
>>>>>>>>> I used a recent version of iproute2.
>>>>>>>>
>>>>>>>> did you initialize the can module? do you use a can cape? if y=
es, does
>>>>>>>> your kernel already include the needed dts to enable the can m=
odule?
>>>>>>>>
>>>>>>>> /martin
>>>>>>>>
>>>>>>>> --
>>>>>>>> To unsubscribe from this list: send the line "unsubscribe linu=
x-can" in
>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.=
html
>>>>>>>>
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe linux=
-can" in
>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.h=
tml
>>>>>>>
>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-=
can" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.ht=
ml
>>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-c=
an" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
>>>>>
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
>>>
>>
>>
>=20
>=20

