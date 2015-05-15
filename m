From: =?UTF-8?B?RnJhbsOnb2lzIEJlYXVsaWVy?= <fbeaulier@orange.fr>
Subject: Re: Linux board with 10 CANs
Date: Fri, 15 May 2015 10:50:11 +0200
Message-ID: <5555B343.2030409@orange.fr>
References: <5555A6A3.7090206@orange.fr> <CAGm1_ktyE_CjFwEfi1M48hDxM58HMJNAhQgYC3-8ivJ6AgE1WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:16830 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753705AbbEOIuN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 15 May 2015 04:50:13 -0400
In-Reply-To: <CAGm1_ktyE_CjFwEfi1M48hDxM58HMJNAhQgYC3-8ivJ6AgE1WQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Le 15/05/2015 10:20, Yegor Yefremov a =C3=A9crit :
> On Fri, May 15, 2015 at 9:56 AM, Fran=C3=A7ois Beaulier <fbeaulier@or=
ange.fr> wrote:
>> Hi,
>>
>> I'm starting the design of a CPU board, based on a computer on modul=
e with a
>> very common SOC like i.mx6 or am335x.
>> I need to fit my board with at least 10 CAN ports, may be more. (The=
 SOC
>> have 2 CANs so i need 8 more)
>> The board will run with Linux and of course i want a socketcan inter=
face for
>> each bus !
>> CAN bitrate needed is quite low (50kbps) and latency is not critical=
 but bus
>> load may reach 100% sometimes.
>> As far as possible i want to avoid driver development, or just doing=
 slight
>> modifications on an existing driver.
>> I don't want to use MCP2515, i had trouble with it on a previous des=
ign
>> because of the lack of buffer in the chip.
>> I can't imagine putting 8 MCP2515 and not missing any frame, but may=
 be i'm
>> wrong ?
>>
>> Here are the options i have considered, they involve using external =
MCUs to
>> provide enough CAN interfaces :
>>
>> - MCUs with SLCAN : SLCAN have the advantage of simplicity and it sh=
ould
>> offer enough performance at low data rate. Problem is that it would =
require
>> 8 UARTS. I could modify SLCAN driver to allow multiple CAN channels =
on the
>> same UART, and so use MCUs with multiple CANs, does it sounds reason=
able ?
>>
>> - MCUs with SPI 1 : adapt MCP2515 driver in a way to make the SPI pr=
otocol
>> manageable on the MCU side (SPI slave). The MCU will be able to prov=
ide the
>> buffer for CAN frames that the MCP does not have. This option is jus=
t a way
>> of trying to go fast, it is not very elegant, and have the limitatio=
n of one
>> CAN channel per SPI connection / driver instance.
>>
>> - MCUs with SPI 2 : use the Stefano Babic SPI driver posted on this =
list.
>> This is probably the best choice for a long term and more generic so=
lution.
>> But i'm afraid it may require too much work to complete. What is the=
 status
>> of this driver right now ? Does anyone have an idea of the remaining=
 work to
>> do to make it ready for mainline ? Stefano are you available to spen=
d more
>> time on it ? I'm also wondering whether multiple instances of the dr=
iver can
>> run concurently if i put more than one MCU ?
>>
>> Concerning the MCU software i could release it as an open-source pro=
ject,
>> anyone interested in participating ?
>> I'm very familiar with STM32 MCUs so i will probably use an STM32F07=
2 (low
>> cost cortex M0 with one CAN).
>>
>> Any idea or advice is welcome, thank you for reading this much too l=
ong
>> post.
> Is it possible to attach 8 SJA1000s over local bus? The driver is
> already in mainline kernel.
>
> Yegor
The am335x have a GPMC (General Purpose Memory Controller), i suppose i=
=20
should be able to use it to connect SJA1000s but GPMC settings needs to=
=20
be added to the driver somewhere.
I will search about how the GPMC is supported in the Linux kernel.
Nice idea, thanks Yegor

=46rancois
