From: Mohamed HAMZAOUI <requinham@gmail.com>
Subject: Re: AW: [Socketcan-users] [socketcan]problem to using CAN with
 BeagleBone Black A5A
Date: Mon, 10 Jun 2013 10:49:44 +0100
Message-ID: <CABMxt4jtRXdOuKYAmC8NrSPPtmM8J1ngfD2H01ekY-hCvHV82A@mail.gmail.com>
References: <zarafa.51b3a615.6bf0.67d03e2606cfc0c7@v14647.1blu.de>
	<51B42A9A.3000008@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:40744 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651Ab3FJJtq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Jun 2013 05:49:46 -0400
Received: by mail-lb0-f178.google.com with SMTP id y6so4613869lbh.37
        for <linux-can@vger.kernel.org>; Mon, 10 Jun 2013 02:49:45 -0700 (PDT)
In-Reply-To: <51B42A9A.3000008@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Luxen <mluxen@gmx.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>

Hi Mike,

I'm stuck on the activation of second CAN channel. I think everything
is clear now.
Thank you for your help.

Regards,
Mohamed

On Sun, Jun 9, 2013 at 8:11 AM, Oliver Hartkopp <socketcan@hartkopp.net=
> wrote:
> On 08.06.2013 23:45, Michael Luxen wrote:
>
>> Did you or anybody else have already some experience on the BeagleBo=
ne Black with using the SPI-Interface with MCP2515?
>
> Not yet.
>
>> I'm thinking about to use 1-2 additional CAN-Interfaces to my Beagle=
Bone Black! That means two internal CAN-Interfaces and 2x SPI CAN-Inter=
faces.
>> For example the Cape TT3201 uses two MCP2515 via SPI but I don't kno=
w if there are issues with CAN busload above 30% at 500 kbit/s
>> http://www.towertech.it/en/products/hardware/tt3201-can-cape/
>
> We were discussing exactly about this board.
> AFAIK the CAN Capes have a I2C EEPROM for configuration data which co=
nflicts
> with one of the internal DCAN mux pins:
>
> http://circuitco.com/support/index.php?title=3DTT3201_CAN_Cape#EEPROM
>
> My first idea was to to modify the board in a way that both internal =
DCAN
> interfaces and only one MCP2515 would be connected to the three CAN
> transceivers available on the board.
>
> That's why i was happy to see how you made the second DCAN working.
>
>>
>> I'm not sure about the cpu-load, latency and messages lost problems.=
 My experience on the RasperryPi is that 2x MCP2515 on one SPI-Channel =
doesn't work with busload above 10% at 500kbit/s.
>
> That's not that much. But it's an interesting information to get an e=
stimation
> what one might get with this setup.
>
>> IMO the BeagleBone Black has the advantage to use two independent SP=
I-Channels SPI1 and SPI2 for using a MCP2515 on each SPI channel.
>
> This might be better. But IMO sending all the small messages for the =
register
> accesses is the problem. When serial (e.g. SPI) attached CAN controll=
ers had a
> message based programming interface (instead of a register based) usi=
ng the
> SPI would be a real alternative.
>
> Regards,
> Oliver
>
>
>>
>> -----Urspr=FCngliche Nachricht-----
>> Von:  Oliver Hartkopp <socketcan@hartkopp.net>
>> Gesendet:     Sa 08.06.2013 13:46
>> Betreff:      Re: AW: [Socketcan-users] [socketcan]problem to using =
CAN with BeagleBone Black A5A
>> An:   Michael Luxen <mluxen@gmx.net>;
>> CC:   linux-can@vger.kernel.org;
>>> Hello Mike,
>>>
>>> thanks for pointing to that comprehensive documentation.
>>>
>>> I was asked by a colleague how to get both internal CAN controllers=
 working
>>> instead of adding SPI-based MCP2515 interfaces.
>>>
>>> Good job!
>>>
>>> Best regards,
>>> Oliver
>>>
>>> On 07.06.2013 21:46, Michael Luxen wrote:
>>>> Hello Mohamed,
>>>>
>>>> is you question still open or answered already?
>>>>
>>>> If still open, please have a look on this page where you can find =
how to
>>> enable the CAN-Devices on BeagleBone Black.
>>>> http://www.aero-box.co.uk/beaglebone-black#TOC-Enable-CANbus-devic=
e
>>>>
>>>> The only thing you have to do is to edit the am335x-bone-common.dt=
si file for
>>> enabling dcan0 and/or dcan1.
>>>> Please have in mind that dcan0 is normaly used for the optional Ca=
pes, as
>>> they use the I2C2 pins which are muxed on the same pins than dcan0.
>>>> Nevertheless I've edited am335x-bone-common.dtsi successfully to e=
nable dcan0
>>> and dcan1. On my BeagleBone Black (Hardware A5A) eveything is runni=
ng fine on
>>> both internal CAN-Interfaces with latest Angstrom and latest Debian=
 as well.
>>>> Keep in mind that you have to put a CAN-transceiver on the Pins 20=
/19 (DCAN0)
>>> an 24/26 (DCAN1) on your BeagleBone Black.
>>>>
>>>> Regards
>>>> Mike
>>>>
>>>> -----Urspr=FCngliche Nachricht-----
>>>> Von:        Martin Gysel <m.gysel@gmail.com>
>>>> Gesendet:   Di 04.06.2013 13:32
>>>> Betreff:    Re: [Socketcan-users] [socketcan]problem to using CAN =
with
>>> BeagleBone Black A5A
>>>> An: linux-can@vger.kernel.org;
>>>> CC: socketcan-users@lists.berlios.de;
>>>>> Am 25.05.2013 00:49, schrieb Mohamed HAMZAOUI:
>>>>>> Hi,
>>>>>>
>>>>>> I started with beaglebone black A5A, i installed on it the lates=
t
>>>>>> Angstrom image with : Linux beaglebone 3.8.13 #1 SMP Mon May 20
>>>>>> 17:07:58 CEST 2013 armv7l GNU/Linux
>>>>>>
>>>>>> I have a problem when I try to add a can device, i load with mod=
probe
>>>>>> all necessary kernel module (can, ti_hecc, c_can, c_can_platform=
,
>>>>>> can-raw, can-bcm) but when i execute
>>>>>>> ip link add can0 type can
>>>>>> I have : RTNETLINK answers: Operation not supported
>>>>>> I used a recent version of iproute2.
>>>>>
>>>>> did you initialize the can module? do you use a can cape? if yes,=
 does
>>>>> your kernel already include the needed dts to enable the can modu=
le?
>>>>>
>>>>> /martin
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-c=
an" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
>>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-ca=
n" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-can=
" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-can"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
