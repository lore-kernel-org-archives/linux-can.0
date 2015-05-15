From: =?UTF-8?B?RnJhbsOnb2lzIEJlYXVsaWVy?= <fbeaulier@orange.fr>
Subject: Re: Linux board with 10 CANs
Date: Fri, 15 May 2015 11:33:30 +0200
Message-ID: <5555BD6A.60204@orange.fr>
References: <5555A6A3.7090206@orange.fr> <CAGm1_ktyE_CjFwEfi1M48hDxM58HMJNAhQgYC3-8ivJ6AgE1WQ@mail.gmail.com> <5555B82B.2010204@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:40625 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbbEOJdd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 15 May 2015 05:33:33 -0400
In-Reply-To: <5555B82B.2010204@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Yegor Yefremov <yegorslists@googlemail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Le 15/05/2015 11:11, Marc Kleine-Budde a =C3=A9crit :
> On 05/15/2015 10:20 AM, Yegor Yefremov wrote:
>> On Fri, May 15, 2015 at 9:56 AM, Fran=C3=A7ois Beaulier <fbeaulier@o=
range.fr> wrote:
>>> Hi,
>>>
>>> I'm starting the design of a CPU board, based on a computer on modu=
le with a
>>> very common SOC like i.mx6 or am335x.
>>> I need to fit my board with at least 10 CAN ports, may be more. (Th=
e SOC
>>> have 2 CANs so i need 8 more)
>>> The board will run with Linux and of course i want a socketcan inte=
rface for
>>> each bus !
>>> CAN bitrate needed is quite low (50kbps) and latency is not critica=
l but bus
>>> load may reach 100% sometimes.
>>> As far as possible i want to avoid driver development, or just doin=
g slight
>>> modifications on an existing driver.
>>> I don't want to use MCP2515, i had trouble with it on a previous de=
sign
>>> because of the lack of buffer in the chip.
>>> I can't imagine putting 8 MCP2515 and not missing any frame, but ma=
y be i'm
>>> wrong ?
>>>
>>> Here are the options i have considered, they involve using external=
 MCUs to
>>> provide enough CAN interfaces :
>>>
>>> - MCUs with SLCAN : SLCAN have the advantage of simplicity and it s=
hould
>>> offer enough performance at low data rate. Problem is that it would=
 require
>>> 8 UARTS. I could modify SLCAN driver to allow multiple CAN channels=
 on the
>>> same UART, and so use MCUs with multiple CANs, does it sounds reaso=
nable ?
>>>
>>> - MCUs with SPI 1 : adapt MCP2515 driver in a way to make the SPI p=
rotocol
>>> manageable on the MCU side (SPI slave). The MCU will be able to pro=
vide the
>>> buffer for CAN frames that the MCP does not have. This option is ju=
st a way
>>> of trying to go fast, it is not very elegant, and have the limitati=
on of one
>>> CAN channel per SPI connection / driver instance.
>>>
>>> - MCUs with SPI 2 : use the Stefano Babic SPI driver posted on this=
 list.
>>> This is probably the best choice for a long term and more generic s=
olution.
>>> But i'm afraid it may require too much work to complete. What is th=
e status
>>> of this driver right now ? Does anyone have an idea of the remainin=
g work to
>>> do to make it ready for mainline ? Stefano are you available to spe=
nd more
>>> time on it ? I'm also wondering whether multiple instances of the d=
river can
>>> run concurently if i put more than one MCU ?
>>>
>>> Concerning the MCU software i could release it as an open-source pr=
oject,
>>> anyone interested in participating ?
>>> I'm very familiar with STM32 MCUs so i will probably use an STM32F0=
72 (low
>>> cost cortex M0 with one CAN).
>>>
>>> Any idea or advice is welcome, thank you for reading this much too =
long
>>> post.
>> Is it possible to attach 8 SJA1000s over local bus? The driver is
>> already in mainline kernel.
> Don't use the mcp251x.
>
> If you have PCIe, there are some dual CAN modules (available in miniP=
IC,
> too). But PCIe ist probably quite cost intensive. USB would be an
> option, but I'm not sure if there are modules that can be
> connected/soldered to a PCB. As Yegor said, SJA1000s + a CPLD are an
> option, too, but IIRC the SJA1000 has a 5V IO interface.
>
> Marc
>
Module based solutions are too expensive, whether it is PCIe or USB.
There are some bridge chips PCIe <-> memory, but i'm not familiar with =
that.
And you are right the SJA1000 is an old 5V beast !

=46rancois
