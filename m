From: "Uwe Wilhelm \(PEAK-System\)" <u.wilhelm@peak-system.com>
Subject: AW: AW: [BULK]Re: Linux board with 10 CANs
Date: Fri, 15 May 2015 15:20:59 +0200
Message-ID: <009001d08f11$fc343400$f49c9c00$@peak-system.com>
References: <5555A6A3.7090206@orange.fr>
 <CAGm1_ktyE_CjFwEfi1M48hDxM58HMJNAhQgYC3-8ivJ6AgE1WQ@mail.gmail.com>
 <5555B82B.2010204@pengutronix.de> <5555BD6A.60204@orange.fr>
 <20150515102450.24212.89893@shannon> <5555E93A.7080507@orange.fr>
 <5555EAC6.8010901@pengutronix.de>
 <005401d08f0f$a3b9f960$eb2dec20$@peak-system.com>
 <5555F1FA.6000305@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:51968 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161137AbbEONU7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 15 May 2015 09:20:59 -0400
In-Reply-To: <5555F1FA.6000305@pengutronix.de>
Content-Language: de
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: 'Marc Kleine-Budde' <mkl@pengutronix.de>, =?utf-8?Q?'Fran=C3=A7ois_Beaulier'?= <fbeaulier@orange.fr>, 'Andri Yngvason' <andri.yngvason@marel.com>, 'Yegor Yefremov' <yegorslists@googlemail.com>
Cc: linux-can@vger.kernel.org


> -----Urspr=C3=BCngliche Nachricht-----
> Von: Marc Kleine-Budde [mailto:mkl@pengutronix.de]
> Gesendet: Freitag, 15. Mai 2015 15:18
> An: Uwe Wilhelm (PEAK-System); 'Fran=C3=A7ois Beaulier'; 'Andri Yngva=
son'; 'Yegor
> Yefremov'
> Cc: linux-can@vger.kernel.org
> Betreff: Re: AW: [BULK]Re: Linux board with 10 CANs
>=20
> On 05/15/2015 03:04 PM, Uwe Wilhelm (PEAK-System) wrote:
> >
> >
> >> -----Urspr=C3=BCngliche Nachricht-----
> >> Von: linux-can-owner@vger.kernel.org [mailto:linux-can-
> >> owner@vger.kernel.org] Im Auftrag von Marc Kleine-Budde
> >> Gesendet: Freitag, 15. Mai 2015 14:47
> >> An: Fran=C3=A7ois Beaulier; Andri Yngvason; Yegor Yefremov
> >> Cc: linux-can@vger.kernel.org
> >> Betreff: [BULK]Re: Linux board with 10 CANs
> >>
> >> On 05/15/2015 02:40 PM, Fran=C3=A7ois Beaulier wrote:
> >>>> Have you considered FPGA?
> >>>>
> >>>> Andri
> >>> I don't know much about FPGA, i can see in the kernel that there =
are
> >>> c_can and m_can drivers, i guess i have to add something like a P=
CIe
> >>
> >> c_can and m_can are IP cores by bosch, they are used in various So=
Cs.
> >>
> >>> bridge to connect the CAN controllers with the SOC ?
> >>> Is there a way to use FPGA that would not lead to driver developm=
ent ?
> >>> Do you have any link where i can learn more about Linux + FPGA + =
CAN ?
> >>
> >> You have to use an IP core that is already supported by the kernel=
=2E
> >>
> >> Marc
> >> --
> >
> > PEAK offer a 2 and a 4 CAN Channel FPGA Solution which support Sock=
et CAN.
> > A 12 Channel CAN card build with this Core is running under a Milit=
ary
> > Label without any problem with nearly 100% Busload per Channel / 1
> > Mbit But you need 3 free PCIe 1x Lanes. Cost are cheap, because you
> > only pay License,
>=20
> That is 3 IP-Core instances with 4 Channels/1 PCIe Lane each?

Yes, every FPGA have it=C2=B4s own PCIe Interface and max. 4 CAN Contro=
ller inside

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt
Handelsregister Darmstadt HRB 9183=20
Geschaeftsfuehrung: Alexander Gach, Uwe Wilhelm
--
