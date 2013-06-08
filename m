From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: AW: [Socketcan-users] [socketcan]problem to using CAN with BeagleBone
 Black A5A
Date: Sat, 08 Jun 2013 13:35:08 +0200
Message-ID: <51B316EC.3090300@hartkopp.net>
References: <zarafa.51b23885.159b.07db93856850360d@v14647.1blu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:18895 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410Ab3FHLfK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 8 Jun 2013 07:35:10 -0400
In-Reply-To: <zarafa.51b23885.159b.07db93856850360d@v14647.1blu.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Luxen <mluxen@gmx.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Mike,

thanks for pointing to that comprehensive documentation.

I was asked by a colleague how to get both internal CAN controllers wor=
king
instead of adding SPI-based MCP2515 interfaces.

Good job!

Best regards,
Oliver

On 07.06.2013 21:46, Michael Luxen wrote:
> Hello Mohamed,
>=20
> is you question still open or answered already?
>=20
> If still open, please have a look on this page where you can find how=
 to enable the CAN-Devices on BeagleBone Black.
> http://www.aero-box.co.uk/beaglebone-black#TOC-Enable-CANbus-device
>=20
> The only thing you have to do is to edit the am335x-bone-common.dtsi =
file for enabling dcan0 and/or dcan1.
> Please have in mind that dcan0 is normaly used for the optional Capes=
, as they use the I2C2 pins which are muxed on the same pins than dcan0=
=2E
> Nevertheless I've edited am335x-bone-common.dtsi successfully to enab=
le dcan0 and dcan1. On my BeagleBone Black (Hardware A5A) eveything is =
running fine on both internal CAN-Interfaces with latest Angstrom and l=
atest Debian as well.
> Keep in mind that you have to put a CAN-transceiver on the Pins 20/19=
 (DCAN0) an 24/26 (DCAN1) on your BeagleBone Black.
>=20
> Regards
> Mike
>=20
> -----Urspr=C3=BCngliche Nachricht-----
> Von:	Martin Gysel <m.gysel@gmail.com>
> Gesendet:	Di 04.06.2013 13:32
> Betreff:	Re: [Socketcan-users] [socketcan]problem to using CAN with B=
eagleBone Black A5A
> An:	linux-can@vger.kernel.org;=20
> CC:	socketcan-users@lists.berlios.de;=20
>> Am 25.05.2013 00:49, schrieb Mohamed HAMZAOUI:
>>> Hi,
>>>
>>> I started with beaglebone black A5A, i installed on it the latest
>>> Angstrom image with : Linux beaglebone 3.8.13 #1 SMP Mon May 20
>>> 17:07:58 CEST 2013 armv7l GNU/Linux
>>>
>>> I have a problem when I try to add a can device, i load with modpro=
be
>>> all necessary kernel module (can, ti_hecc, c_can, c_can_platform,
>>> can-raw, can-bcm) but when i execute
>>>> ip link add can0 type can
>>> I have : RTNETLINK answers: Operation not supported
>>> I used a recent version of iproute2.
>>
>> did you initialize the can module? do you use a can cape? if yes, do=
es
>> your kernel already include the needed dts to enable the can module?
>>
>> /martin
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

