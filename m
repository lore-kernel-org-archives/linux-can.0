From: =?utf-8?Q?Michael_Luxen?= <mluxen@gmx.net>
Subject: AW: [Socketcan-users] [socketcan]problem to using CAN with
 BeagleBone Black A5A
Date: Mon, 10 Jun 2013 21:54:35 +0200
Message-ID: <zarafa.51b62efb.7aff.1ab85acd7547c22a@v14647.1blu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from v14647.1blu.de ([178.254.6.47]:55995 "EHLO v14647.1blu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751344Ab3FJTyh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Jun 2013 15:54:37 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?utf-8?Q?Wolfgang_Grandegger?= <wg@grandegger.com>
Cc: =?utf-8?Q?linux-can=40vger=2Ekernel=2Eorg?= <linux-can@vger.kernel.org>, =?utf-8?Q?Oliver_Hartkopp?= <socketcan@hartkopp.net>

Hello Wolfgang,

from the Raspberry Pi point of view I can say that I've patched already=
 the original raspbmc based kernel MCP251x driver to the MCP2515 asynch=
ronous of Andre B. Oliveira. I've also patched the raspbmc SPI driver t=
o use DMA mode for low latency issues.
With these modifications the MCP2515 runs on my setup with the Raspi wi=
thout any message lost. Also with busload >50% @ 1000kbit/s.

More details for Raspi users can be found here:
http://elinux.org/RPi_CANBus

But keep in mind as soon as a second MCP2515 is used on the MCP2515 one=
 of them stops sending/receiving after a few seconds as the ISR seems t=
o hang.

Regards
Mike

-----Urspr=C3=BCngliche Nachricht-----
Von:	Wolfgang Grandegger <wg@grandegger.com>
Gesendet:	Mo 10.06.2013 19:50
Betreff:	Re: [Socketcan-users] [socketcan]problem to using CAN with Bea=
gleBone Black A5A
An:	Michael Luxen <mluxen@gmx.net>;=20
CC:	Oliver Hartkopp <socketcan@hartkopp.net>; linux-can@vger.kernel.org=
;=20
> On 06/10/2013 06:24 PM, Michael Luxen wrote:
> ...
> >>> I'm not sure about the cpu-load, latency and messages lost proble=
ms. My=20
> >> experience on the RasperryPi is that 2x MCP2515 on one SPI-Channel=
 doesn't=20
> work=20
> >> with busload above 10% at 500kbit/s.
> >>
> >> That's not that much. But it's an interesting information to get a=
n=20
> estimation
> >> what one might get with this setup.
> > But keep in mind that the Raspi has only one SPI channel where I've=
 connected=20
> two MCP2515 (only independetn ChipSelect and Interrupt lines). Theref=
ore I'm=20
> interested in to sees how the BeagleBone Black can handle two MCP2515=
 on=20
> idenpendent SPI channels (SPI1/SPI2).
>=20
> The problem is not (only) SPI hardware but software. The CAN messages
> are not read-out quickly enough due to latencies resulting in message
> losses. May user do report that problem with the MPC251x. The followi=
ng
> link does have some nice figures:
>=20
>   http://clientes.netvisao.pt/anbadeol/mcp2515.html
>=20
> I think the software can do better but still latency is critical for =
the
> MPC251x, especialy MPC2510.
>=20
> Wolfgang.
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> > Regards
> > Mike
> > =20
> >>> -----Urspr=C3=BCngliche Nachricht-----
> >>> Von:	Oliver Hartkopp <socketcan@hartkopp.net>
> >>> Gesendet:	Sa 08.06.2013 13:46
> >>> Betreff:	Re: AW: [Socketcan-users] [socketcan]problem to using CA=
N with=20
> >> BeagleBone Black A5A
> >>> An:	Michael Luxen <mluxen@gmx.net>;=20
> >>> CC:	linux-can@vger.kernel.org;=20
> >>>> Hello Mike,
> >>>>
> >>>> thanks for pointing to that comprehensive documentation.
> >>>>
> >>>> I was asked by a colleague how to get both internal CAN controll=
ers working
> >>>> instead of adding SPI-based MCP2515 interfaces.
> >>>>
> >>>> Good job!
> >>>>
> >>>> Best regards,
> >>>> Oliver
> >>>>
> >>>> On 07.06.2013 21:46, Michael Luxen wrote:
> >>>>> Hello Mohamed,
> >>>>>
> >>>>> is you question still open or answered already?
> >>>>>
> >>>>> If still open, please have a look on this page where you can fi=
nd how to=20
> >>>> enable the CAN-Devices on BeagleBone Black.
> >>>>> http://www.aero-box.co.uk/beaglebone-black#TOC-Enable-CANbus-de=
vice
> >>>>>
> >>>>> The only thing you have to do is to edit the am335x-bone-common=
=2Edtsi file=20
> >> for=20
> >>>> enabling dcan0 and/or dcan1.
> >>>>> Please have in mind that dcan0 is normaly used for the optional=
 Capes, as=20
> >>>> they use the I2C2 pins which are muxed on the same pins than dca=
n0.
> >>>>> Nevertheless I've edited am335x-bone-common.dtsi successfully t=
o enable=20
> >> dcan0=20
> >>>> and dcan1. On my BeagleBone Black (Hardware A5A) eveything is ru=
nning fine=20
> >> on=20
> >>>> both internal CAN-Interfaces with latest Angstrom and latest Deb=
ian as=20
> well.
> >>>>> Keep in mind that you have to put a CAN-transceiver on the Pins=
 20/19=20
> >> (DCAN0)=20
> >>>> an 24/26 (DCAN1) on your BeagleBone Black.
> >>>>>
> >>>>> Regards
> >>>>> Mike
> >>>>>
> >>>>> -----Urspr=C3=BCngliche Nachricht-----
> >>>>> Von:	Martin Gysel <m.gysel@gmail.com>
> >>>>> Gesendet:	Di 04.06.2013 13:32
> >>>>> Betreff:	Re: [Socketcan-users] [socketcan]problem to using CAN =
with=20
> >>>> BeagleBone Black A5A
> >>>>> An:	linux-can@vger.kernel.org;=20
> >>>>> CC:	socketcan-users@lists.berlios.de;=20
> >>>>>> Am 25.05.2013 00:49, schrieb Mohamed HAMZAOUI:
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> I started with beaglebone black A5A, i installed on it the la=
test
> >>>>>>> Angstrom image with : Linux beaglebone 3.8.13 #1 SMP Mon May =
20
> >>>>>>> 17:07:58 CEST 2013 armv7l GNU/Linux
> >>>>>>>
> >>>>>>> I have a problem when I try to add a can device, i load with =
modprobe
> >>>>>>> all necessary kernel module (can, ti_hecc, c_can, c_can_platf=
orm,
> >>>>>>> can-raw, can-bcm) but when i execute
> >>>>>>>> ip link add can0 type can
> >>>>>>> I have : RTNETLINK answers: Operation not supported
> >>>>>>> I used a recent version of iproute2.
> >>>>>>
> >>>>>> did you initialize the can module? do you use a can cape? if y=
es, does
> >>>>>> your kernel already include the needed dts to enable the can m=
odule?
> >>>>>>
> >>>>>> /martin
> >>>>>>
> >>>>>> --
> >>>>>> To unsubscribe from this list: send the line "unsubscribe linu=
x-can" in
> >>>>>> the body of a message to majordomo@vger.kernel.org
> >>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.=
html
> >>>>>>
> >>>>> --
> >>>>> To unsubscribe from this list: send the line "unsubscribe linux=
-can" in
> >>>>> the body of a message to majordomo@vger.kernel.org
> >>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.h=
tml
> >>>>>
> >>>>
> >>>> --
> >>>> To unsubscribe from this list: send the line "unsubscribe linux-=
can" in
> >>>> the body of a message to majordomo@vger.kernel.org
> >>>> More majordomo info at  http://vger.kernel.org/majordomo-info.ht=
ml
> >>>>
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe linux-c=
an" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
> >>>
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-ca=
n" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-can=
" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >=20
> >=20
>=20
>
