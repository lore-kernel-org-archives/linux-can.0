From: Willy Lambert <lambert.willy@gmail.com>
Subject: Fwd: [Socketcan-users] Using sja1000_isa on a 64b system
Date: Wed, 9 Nov 2011 19:05:50 +0100
Message-ID: <CAKvQZ_23uqK6v4sK=CSVLNbx0NESf6xq-aLiVW+9Tia7FEJy+Q@mail.gmail.com>
References: <CAKvQZ_3HSdfOn4xGq7j8GsWJ+iHVan0Ygr=tR+cQm-tpQQWV2A@mail.gmail.com>
	<4E4CA945.7080504@hartkopp.net>
	<4E4CC9D5.6040708@pengutronix.de>
	<CAKvQZ_0raVFUsCFYA2FVH_138DCMw6ipKHdz=Dh62K4YpM5o=Q@mail.gmail.com>
	<4E5CCAA5.4030009@grandegger.com>
	<CAKvQZ_0TFUd4FwOvr4AXArviMYPGHH6Xex4Cjy7LxYoEuBUpxA@mail.gmail.com>
	<4E6271CD.6040407@grandegger.com>
	<CAKvQZ_2PyM5zo5-4PtrMGjMEML3j02MKCCJU=zpnkSK2N_XUjg@mail.gmail.com>
	<4E64B6CB.8010505@grandegger.com>
	<CAKvQZ_1gp9XvVmh+ZEUdEVz2TrvkhHtVKc20ViNgSx=uuPWajQ@mail.gmail.com>
	<4E653775.4030503@grandegger.com>
	<CAKvQZ_28skey9u+rDXi8mkrYiuhTQwnUAAhNMsPNqT-ZP3VNkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59194 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546Ab1KISFv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 9 Nov 2011 13:05:51 -0500
Received: by wyh15 with SMTP id 15so1877195wyh.19
        for <linux-can@vger.kernel.org>; Wed, 09 Nov 2011 10:05:50 -0800 (PST)
In-Reply-To: <CAKvQZ_28skey9u+rDXi8mkrYiuhTQwnUAAhNMsPNqT-ZP3VNkg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

---------- Forwarded message ----------
=46rom: Willy Lambert <lambert.willy@gmail.com>
Date: 2011/11/9
Subject: Re: [Socketcan-users] Using sja1000_isa on a 64b system
To: Wolfgang Grandegger <wg@grandegger.com>
Cc : "socketcan-users@lists.berlios.de"
<socketcan-users@lists.berlios.de>, linux-can@vger.kernel.org




2011/9/5 Wolfgang Grandegger <wg@grandegger.com>
>
> On 09/05/2011 07:35 PM, Willy Lambert wrote:
> > 2011/9/5 Wolfgang Grandegger <wg@grandegger.com>
> >
> >> On 09/04/2011 09:09 PM, Willy Lambert wrote:
> >>> 2011/9/3 Wolfgang Grandegger <wg@grandegger.com>
> >> ...
> >>>> What CAN hardware are you using?
> >>>
> >>>
> >>> Motherboad and CAN stack :
> >>>
> >> http://www.advantech.com/products/PCM-3362/mod_2B69DA4C-D506-4AEA-=
8CC3-F6E58E3CBC87.aspx
> >>> http://www.ixxat.com/pc_i_04_104_en.html
> >>
> >> OK...
> >>
> >>>> And what bus is it
> >>>> connected to? Why do I ask? In "arch/x86/Kconfig" there is:
> >>>>
> >>>> =A0# x86_64 have no ISA slots, but can have ISA-style DMA.
> >>>> =A0config ISA_DMA_API
> >>>> =A0 =A0 =A0 =A0bool "ISA-style DMA support" if (X86_64 && EXPERT=
)
> >>>> =A0 =A0 =A0 =A0default y
> >>>> =A0 =A0 =A0 =A0help
> >>>> =A0 =A0 =A0 =A0 =A0Enables ISA-style DMA support for devices req=
uiring such
> >>>> controllers.
> >>>> =A0 =A0 =A0 =A0 =A0If unsure, say Y.
> >>>>
> >>>> =A0if X86_32
> >>>>
> >>>> =A0config ISA
> >>>> =A0 =A0 =A0 =A0bool "ISA support"
> >>>> =A0 =A0 =A0 =A0---help---
> >>>> =A0 =A0 =A0 =A0 =A0Find out whether you have ISA slots on your m=
otherboard. =A0ISA
> >> is
> >>>> the
> >>>> =A0 =A0 =A0 =A0 =A0name of a bus system, i.e. the way the CPU ta=
lks to the other
> >>>> stuff
> >>>> =A0 =A0 =A0 =A0 =A0inside your box. =A0Other bus systems are PCI=
, EISA, MicroChannel
> >>>> =A0 =A0 =A0 =A0 =A0(MCA) or VESA. =A0ISA is an older system, now=
 being displaced by
> >>>> PCI;
> >>>> =A0 =A0 =A0 =A0 =A0newer boards don't support it. =A0If you have=
 ISA, say Y,
> >> otherwise
> >>>> N.
> >>>>
> >>>>
> >>>> Maybe the assumption that the x86_64 does not have ISA slots is =
wrong
> >> and
> >>>> we
> >>>> should fix that instead of moving to a platform driver like Oliv=
er
> >>>> suggested.
> >>
> >> Intel Atom N450 on that board supports the PC/104-Plus bus, which =
is PCI
> >> (not ISA) based, therefore a SJA1000-PCI-driver seems more appropr=
iate.
> >> Do you find the SJA1000 device with "lspci -vv"?
>
> Ah, at a closer look, the PC/104-Plus is an extension of the PC/104 f=
rom
> factor with an additional connector for PCI. It therefore still suppo=
rts
> ISA bus communication, which the IXXAT PC-I 04/104 board uses.
>
> Therefore I'm going to prepare a patch removing the "X86_32" restrict=
ion
> for CONFIG_ISA above. Sorry for confusion.

May I bump this up ? I read your conversation on other linux ML, but I
don't really know how it ended.

>
> Wolfgang.
