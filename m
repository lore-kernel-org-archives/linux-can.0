From: "Uwe Wilhelm \(PEAK-System\)" <u.wilhelm@peak-system.com>
Subject: AW: [BULK]Re: Linux board with 10 CANs
Date: Fri, 15 May 2015 15:04:12 +0200
Message-ID: <005401d08f0f$a3b9f960$eb2dec20$@peak-system.com>
References: <5555A6A3.7090206@orange.fr>
 <CAGm1_ktyE_CjFwEfi1M48hDxM58HMJNAhQgYC3-8ivJ6AgE1WQ@mail.gmail.com>
 <5555B82B.2010204@pengutronix.de> <5555BD6A.60204@orange.fr>
 <20150515102450.24212.89893@shannon> <5555E93A.7080507@orange.fr>
 <5555EAC6.8010901@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:49598 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422674AbbEONNX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 15 May 2015 09:13:23 -0400
In-Reply-To: <5555EAC6.8010901@pengutronix.de>
Content-Language: de
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: 'Marc Kleine-Budde' <mkl@pengutronix.de>, =?utf-8?Q?'Fran=C3=A7ois_Beaulier'?= <fbeaulier@orange.fr>, 'Andri Yngvason' <andri.yngvason@marel.com>, 'Yegor Yefremov' <yegorslists@googlemail.com>
Cc: linux-can@vger.kernel.org



> -----Urspr=C3=BCngliche Nachricht-----
> Von: linux-can-owner@vger.kernel.org [mailto:linux-can-
> owner@vger.kernel.org] Im Auftrag von Marc Kleine-Budde
> Gesendet: Freitag, 15. Mai 2015 14:47
> An: Fran=C3=A7ois Beaulier; Andri Yngvason; Yegor Yefremov
> Cc: linux-can@vger.kernel.org
> Betreff: [BULK]Re: Linux board with 10 CANs
>=20
> On 05/15/2015 02:40 PM, Fran=C3=A7ois Beaulier wrote:
> >> Have you considered FPGA?
> >>
> >> Andri
> > I don't know much about FPGA, i can see in the kernel that there ar=
e
> > c_can and m_can drivers, i guess i have to add something like a PCI=
e
>=20
> c_can and m_can are IP cores by bosch, they are used in various SoCs.
>=20
> > bridge to connect the CAN controllers with the SOC ?
> > Is there a way to use FPGA that would not lead to driver developmen=
t ?
> > Do you have any link where i can learn more about Linux + FPGA + CA=
N ?
>=20
> You have to use an IP core that is already supported by the kernel.
>=20
> Marc
> --

PEAK offer a 2 and a 4 CAN Channel FPGA Solution which support Socket C=
AN. =20
A 12 Channel CAN card build with this Core is running under a Military =
Label=20
without any problem with nearly 100% Busload per Channel / 1 Mbit
But you need 3 free PCIe 1x Lanes. Cost are cheap, because you only pay=
 License,=20
no Hardware - that=E2=80=99s up to you (you get the schematic).
You are 100% compatible to the PEAK PCIe based boards -- see WEB Page o=
r google

Regards

   Uwe

PEAK-System Technik GmbH
E-mail:  support@peak-system.com=20
Webseite: www.peak-system.com




--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt
Handelsregister Darmstadt HRB 9183=20
Geschaeftsfuehrung: Alexander Gach, Uwe Wilhelm
--
