From: =?utf-8?Q?Michael_Luxen?= <mluxen@gmx.net>
Subject: AW: [Socketcan-users] [socketcan]problem to using CAN with
 BeagleBone Black A5A
Date: Mon, 10 Jun 2013 18:24:13 +0200
Message-ID: <zarafa.51b5fdad.6ffe.67c77ee34ea9157d@v14647.1blu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from v14647.1blu.de ([178.254.6.47]:59064 "EHLO v14647.1blu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753227Ab3FJQYP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Jun 2013 12:24:15 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?utf-8?Q?Oliver_Hartkopp?= <socketcan@hartkopp.net>
Cc: =?utf-8?Q?linux-can=40vger=2Ekernel=2Eorg?= <linux-can@vger.kernel.org>

Hello Oliver,


> > I'm thinking about to use 1-2 additional CAN-Interfaces to my Beagl=
eBone=20
> Black! That means two internal CAN-Interfaces and 2x SPI CAN-Interfac=
es.
> > For example the Cape TT3201 uses two MCP2515 via SPI but I don't kn=
ow if=20
> there are issues with CAN busload above 30% at 500 kbit/s
> > http://www.towertech.it/en/products/hardware/tt3201-can-cape/
>=20
> We were discussing exactly about this board.
> AFAIK the CAN Capes have a I2C EEPROM for configuration data which co=
nflicts
> with one of the internal DCAN mux pins:
>=20
> http://circuitco.com/support/index.php?title=3DTT3201_CAN_Cape#EEPROM
>=20
> My first idea was to to modify the board in a way that both internal =
DCAN
> interfaces and only one MCP2515 would be connected to the three CAN
> transceivers available on the board.
OK, that's fine. For me using of two SPI driven MCP2515 was not good en=
ough if I've 2x CAN-channels onBoard (best performance or lowest CPU lo=
ad). That was the reason for me not to use this board an to use the bot=
h internal CAN interfaces.
To add further CAN channels via the SPI driven MCP2515 is the next step=
 for me (Wednesday afternoon I've hopefully more details and some test =
results available).
Loosing the CAPE detection feature is OK for me. Maybe someone else poi=
nt me to a important point why I need it on my own CAPE.

> > I'm not sure about the cpu-load, latency and messages lost problems=
=2E My=20
> experience on the RasperryPi is that 2x MCP2515 on one SPI-Channel do=
esn't work=20
> with busload above 10% at 500kbit/s.
>=20
> That's not that much. But it's an interesting information to get an e=
stimation
> what one might get with this setup.
But keep in mind that the Raspi has only one SPI channel where I've con=
nected two MCP2515 (only independetn ChipSelect and Interrupt lines). T=
herefore I'm interested in to sees how the BeagleBone Black can handle =
two MCP2515 on idenpendent SPI channels (SPI1/SPI2).

Regards
Mike
=20
> > -----Urspr=C3=BCngliche Nachricht-----
> > Von:	Oliver Hartkopp <socketcan@hartkopp.net>
> > Gesendet:	Sa 08.06.2013 13:46
> > Betreff:	Re: AW: [Socketcan-users] [socketcan]problem to using CAN =
with=20
> BeagleBone Black A5A
> > An:	Michael Luxen <mluxen@gmx.net>;=20
> > CC:	linux-can@vger.kernel.org;=20
> >> Hello Mike,
> >>
> >> thanks for pointing to that comprehensive documentation.
> >>
> >> I was asked by a colleague how to get both internal CAN controller=
s working
> >> instead of adding SPI-based MCP2515 interfaces.
> >>
> >> Good job!
> >>
> >> Best regards,
> >> Oliver
> >>
> >> On 07.06.2013 21:46, Michael Luxen wrote:
> >>> Hello Mohamed,
> >>>
> >>> is you question still open or answered already?
> >>>
> >>> If still open, please have a look on this page where you can find=
 how to=20
> >> enable the CAN-Devices on BeagleBone Black.
> >>> http://www.aero-box.co.uk/beaglebone-black#TOC-Enable-CANbus-devi=
ce
> >>>
> >>> The only thing you have to do is to edit the am335x-bone-common.d=
tsi file=20
> for=20
> >> enabling dcan0 and/or dcan1.
> >>> Please have in mind that dcan0 is normaly used for the optional C=
apes, as=20
> >> they use the I2C2 pins which are muxed on the same pins than dcan0=
=2E
> >>> Nevertheless I've edited am335x-bone-common.dtsi successfully to =
enable=20
> dcan0=20
> >> and dcan1. On my BeagleBone Black (Hardware A5A) eveything is runn=
ing fine=20
> on=20
> >> both internal CAN-Interfaces with latest Angstrom and latest Debia=
n as well.
> >>> Keep in mind that you have to put a CAN-transceiver on the Pins 2=
0/19=20
> (DCAN0)=20
> >> an 24/26 (DCAN1) on your BeagleBone Black.
> >>>
> >>> Regards
> >>> Mike
> >>>
> >>> -----Urspr=C3=BCngliche Nachricht-----
> >>> Von:	Martin Gysel <m.gysel@gmail.com>
> >>> Gesendet:	Di 04.06.2013 13:32
> >>> Betreff:	Re: [Socketcan-users] [socketcan]problem to using CAN wi=
th=20
> >> BeagleBone Black A5A
> >>> An:	linux-can@vger.kernel.org;=20
> >>> CC:	socketcan-users@lists.berlios.de;=20
> >>>> Am 25.05.2013 00:49, schrieb Mohamed HAMZAOUI:
> >>>>> Hi,
> >>>>>
> >>>>> I started with beaglebone black A5A, i installed on it the late=
st
> >>>>> Angstrom image with : Linux beaglebone 3.8.13 #1 SMP Mon May 20
> >>>>> 17:07:58 CEST 2013 armv7l GNU/Linux
> >>>>>
> >>>>> I have a problem when I try to add a can device, i load with mo=
dprobe
> >>>>> all necessary kernel module (can, ti_hecc, c_can, c_can_platfor=
m,
> >>>>> can-raw, can-bcm) but when i execute
> >>>>>> ip link add can0 type can
> >>>>> I have : RTNETLINK answers: Operation not supported
> >>>>> I used a recent version of iproute2.
> >>>>
> >>>> did you initialize the can module? do you use a can cape? if yes=
, does
> >>>> your kernel already include the needed dts to enable the can mod=
ule?
> >>>>
> >>>> /martin
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
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
