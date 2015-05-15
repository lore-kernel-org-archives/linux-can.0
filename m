From: =?UTF-8?B?RnJhbsOnb2lzIEJlYXVsaWVy?= <fbeaulier@orange.fr>
Subject: Re: AW: [BULK]Re: Linux board with 10 CANs
Date: Fri, 15 May 2015 16:18:44 +0200
Message-ID: <55560044.4060907@orange.fr>
References: <5555A6A3.7090206@orange.fr> <CAGm1_ktyE_CjFwEfi1M48hDxM58HMJNAhQgYC3-8ivJ6AgE1WQ@mail.gmail.com> <5555B82B.2010204@pengutronix.de> <5555BD6A.60204@orange.fr> <20150515102450.24212.89893@shannon> <5555E93A.7080507@orange.fr> <5555EAC6.8010901@pengutronix.de> <005401d08f0f$a3b9f960$eb2dec20$@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:39623 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629AbbEOOSs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 15 May 2015 10:18:48 -0400
In-Reply-To: <005401d08f0f$a3b9f960$eb2dec20$@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Uwe Wilhelm (PEAK-System)" <u.wilhelm@peak-system.com>, 'Marc Kleine-Budde' <mkl@pengutronix.de>, 'Andri Yngvason' <andri.yngvason@marel.com>, 'Yegor Yefremov' <yegorslists@googlemail.com>
Cc: linux-can@vger.kernel.org

Le 15/05/2015 15:04, Uwe Wilhelm (PEAK-System) a =C3=A9crit :
>
>> -----Urspr=C3=BCngliche Nachricht-----
>> Von: linux-can-owner@vger.kernel.org [mailto:linux-can-
>> owner@vger.kernel.org] Im Auftrag von Marc Kleine-Budde
>> Gesendet: Freitag, 15. Mai 2015 14:47
>> An: Fran=C3=A7ois Beaulier; Andri Yngvason; Yegor Yefremov
>> Cc: linux-can@vger.kernel.org
>> Betreff: [BULK]Re: Linux board with 10 CANs
>>
>> On 05/15/2015 02:40 PM, Fran=C3=A7ois Beaulier wrote:
>>>> Have you considered FPGA?
>>>>
>>>> Andri
>>> I don't know much about FPGA, i can see in the kernel that there ar=
e
>>> c_can and m_can drivers, i guess i have to add something like a PCI=
e
>> c_can and m_can are IP cores by bosch, they are used in various SoCs=
=2E
>>
>>> bridge to connect the CAN controllers with the SOC ?
>>> Is there a way to use FPGA that would not lead to driver developmen=
t ?
>>> Do you have any link where i can learn more about Linux + FPGA + CA=
N ?
>> You have to use an IP core that is already supported by the kernel.
>>
>> Marc
>> --
> PEAK offer a 2 and a 4 CAN Channel FPGA Solution which support Socket=
 CAN.
> A 12 Channel CAN card build with this Core is running under a Militar=
y Label
> without any problem with nearly 100% Busload per Channel / 1 Mbit
> But you need 3 free PCIe 1x Lanes. Cost are cheap, because you only p=
ay License,
> no Hardware - that=E2=80=99s up to you (you get the schematic).
> You are 100% compatible to the PEAK PCIe based boards -- see WEB Page=
 or google
Interesting but i.mx6 have only one PCIe lane and other low cost SOCs=20
often have no PCIe at all.
I will think twice about it because having a fully ready and supported=20
driver is a huge plus !

=46rancois
