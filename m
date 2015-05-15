From: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: Re: Linux board with 10 CANs
Date: Fri, 15 May 2015 14:38:52 +0200
Message-ID: <5555E8DC.7050209@ems-wuensche.com>
References: <5555A6A3.7090206@orange.fr> <CAGm1_ktyE_CjFwEfi1M48hDxM58HMJNAhQgYC3-8ivJ6AgE1WQ@mail.gmail.com> <5555B82B.2010204@pengutronix.de> <5555BD6A.60204@orange.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.ems-wuensche.com ([85.214.92.62]:50166 "EHLO
	mail.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422837AbbEOMqJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 15 May 2015 08:46:09 -0400
In-Reply-To: <5555BD6A.60204@orange.fr>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?RnJhbsOnb2lzIEJlYXVsaWVy?= <fbeaulier@orange.fr>, Marc Kleine-Budde <mkl@pengutronix.de>, Yegor Yefremov <yegorslists@googlemail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>



Am 15.05.2015 um 11:33 schrieb Fran=C3=A7ois Beaulier:
> Le 15/05/2015 11:11, Marc Kleine-Budde a =C3=A9crit :
>> On 05/15/2015 10:20 AM, Yegor Yefremov wrote:
>>> On Fri, May 15, 2015 at 9:56 AM, Fran=C3=A7ois Beaulier=20
>>> <fbeaulier@orange.fr> wrote:
>>>> Hi,
>>>>=20
>>>> I'm starting the design of a CPU board, based on a computer
>>>> on module with a very common SOC like i.mx6 or am335x. I need
>>>> to fit my board with at least 10 CAN ports, may be more.
>>>> (The SOC have 2 CANs so i need 8 more) The board will run
>>>> with Linux and of course i want a socketcan interface for=20
>>>> each bus ! CAN bitrate needed is quite low (50kbps) and
>>>> latency is not critical but bus load may reach 100%
>>>> sometimes. As far as possible i want to avoid driver
>>>> development, or just doing slight modifications on an
>>>> existing driver. I don't want to use MCP2515, i had trouble
>>>> with it on a previous design because of the lack of buffer in
>>>> the chip. I can't imagine putting 8 MCP2515 and not missing
>>>> any frame, but may be i'm wrong ?
>>>>=20
>>>> Here are the options i have considered, they involve using
>>>> external MCUs to provide enough CAN interfaces :
>>>>=20
>>>> - MCUs with SLCAN : SLCAN have the advantage of simplicity
>>>> and it should offer enough performance at low data rate.
>>>> Problem is that it would require 8 UARTS. I could modify
>>>> SLCAN driver to allow multiple CAN channels on the same UART,
>>>> and so use MCUs with multiple CANs, does it sounds reasonable
>>>> ?
>>>>=20
>>>> - MCUs with SPI 1 : adapt MCP2515 driver in a way to make the
>>>> SPI protocol manageable on the MCU side (SPI slave). The MCU
>>>> will be able to provide the buffer for CAN frames that the
>>>> MCP does not have. This option is just a way of trying to go
>>>> fast, it is not very elegant, and have the limitation of one=20
>>>> CAN channel per SPI connection / driver instance.
>>>>=20
>>>> - MCUs with SPI 2 : use the Stefano Babic SPI driver posted
>>>> on this list. This is probably the best choice for a long
>>>> term and more generic solution. But i'm afraid it may require
>>>> too much work to complete. What is the status of this driver
>>>> right now ? Does anyone have an idea of the remaining work
>>>> to do to make it ready for mainline ? Stefano are you
>>>> available to spend more time on it ? I'm also wondering
>>>> whether multiple instances of the driver can run concurently
>>>> if i put more than one MCU ?
>>>>=20
>>>> Concerning the MCU software i could release it as an
>>>> open-source project, anyone interested in participating ? I'm
>>>> very familiar with STM32 MCUs so i will probably use an=20
>>>> STM32F072 (low cost cortex M0 with one CAN).
>>>>=20
>>>> Any idea or advice is welcome, thank you for reading this
>>>> much too long post.
>>> Is it possible to attach 8 SJA1000s over local bus? The driver
>>> is already in mainline kernel.
>> Don't use the mcp251x.
>>=20
>> If you have PCIe, there are some dual CAN modules (available in
>> miniPIC, too). But PCIe ist probably quite cost intensive. USB
>> would be an option, but I'm not sure if there are modules that
>> can be connected/soldered to a PCB. As Yegor said, SJA1000s + a
>> CPLD are an option, too, but IIRC the SJA1000 has a 5V IO
>> interface.
>>=20
>> Marc
>>=20
> Module based solutions are too expensive, whether it is PCIe or
> USB. There are some bridge chips PCIe <-> memory, but i'm not
> familiar with that. And you are right the SJA1000 is an old 5V
> beast !
>=20

Also a point to consider is that the speed you can read a SJA1000 chip
is based on the clock frequency of this chip. And you have to
read/write byte by byte. This may be too slow for 10 channels.

Regards
Gerhard

--=20
EMS Dr. Thomas Wuensche e.K.
Sonnenhang 3
85304 Ilmmuenster
HRA Neuburg a.d. Donau, HR-Nr. 70.106

Phone: +49-8441-490260
=46ax  : +49-8441-81860
http://www.ems-wuensche.com
