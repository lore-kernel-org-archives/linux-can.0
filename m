From: =?utf-8?Q?Michael_Luxen?= <mluxen@gmx.net>
Subject: AW: [Socketcan-users] [socketcan]problem to using CAN with
 BeagleBone Black A5A
Date: Fri, 7 Jun 2013 21:46:13 +0200
Message-ID: <zarafa.51b23885.159b.07db93856850360d@v14647.1blu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from v14647.1blu.de ([178.254.6.47]:37535 "EHLO v14647.1blu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755977Ab3FGT4x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 7 Jun 2013 15:56:53 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?utf-8?Q?linux-can=40vger=2Ekernel=2Eorg?= <linux-can@vger.kernel.org>
Cc: =?utf-8?Q?socketcan-users=40lists=2Eberlios=2Ede?= <socketcan-users@lists.berlios.de>

Hello Mohamed,

is you question still open or answered already?

If still open, please have a look on this page where you can find how t=
o enable the CAN-Devices on BeagleBone Black.
http://www.aero-box.co.uk/beaglebone-black#TOC-Enable-CANbus-device

The only thing you have to do is to edit the am335x-bone-common.dtsi fi=
le for enabling dcan0 and/or dcan1.
Please have in mind that dcan0 is normaly used for the optional Capes, =
as they use the I2C2 pins which are muxed on the same pins than dcan0.
Nevertheless I've edited am335x-bone-common.dtsi successfully to enable=
 dcan0 and dcan1. On my BeagleBone Black (Hardware A5A) eveything is ru=
nning fine on both internal CAN-Interfaces with latest Angstrom and lat=
est Debian as well.
Keep in mind that you have to put a CAN-transceiver on the Pins 20/19 (=
DCAN0) an 24/26 (DCAN1) on your BeagleBone Black.

Regards
Mike

-----Urspr=C3=BCngliche Nachricht-----
Von:	Martin Gysel <m.gysel@gmail.com>
Gesendet:	Di 04.06.2013 13:32
Betreff:	Re: [Socketcan-users] [socketcan]problem to using CAN with Bea=
gleBone Black A5A
An:	linux-can@vger.kernel.org;=20
CC:	socketcan-users@lists.berlios.de;=20
> Am 25.05.2013 00:49, schrieb Mohamed HAMZAOUI:
> > Hi,
> >=20
> > I started with beaglebone black A5A, i installed on it the latest
> > Angstrom image with : Linux beaglebone 3.8.13 #1 SMP Mon May 20
> > 17:07:58 CEST 2013 armv7l GNU/Linux
> >=20
> > I have a problem when I try to add a can device, i load with modpro=
be
> > all necessary kernel module (can, ti_hecc, c_can, c_can_platform,
> > can-raw, can-bcm) but when i execute
> >> ip link add can0 type can
> > I have : RTNETLINK answers: Operation not supported
> > I used a recent version of iproute2.
>=20
> did you initialize the can module? do you use a can cape? if yes, doe=
s
> your kernel already include the needed dts to enable the can module?
>=20
> /martin
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
