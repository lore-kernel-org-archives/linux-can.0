From: =?UTF-8?B?RnJhbsOnb2lzIEJlYXVsaWVy?= <fbeaulier@orange.fr>
Subject: Re: Linux board with 10 CANs
Date: Fri, 15 May 2015 14:40:26 +0200
Message-ID: <5555E93A.7080507@orange.fr>
References: <5555A6A3.7090206@orange.fr> <CAGm1_ktyE_CjFwEfi1M48hDxM58HMJNAhQgYC3-8ivJ6AgE1WQ@mail.gmail.com> <5555B82B.2010204@pengutronix.de> <5555BD6A.60204@orange.fr> <20150515102450.24212.89893@shannon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:52365 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030185AbbEOMka (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 15 May 2015 08:40:30 -0400
In-Reply-To: <20150515102450.24212.89893@shannon>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Yegor Yefremov <yegorslists@googlemail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Le 15/05/2015 12:24, Andri Yngvason a =C3=A9crit :
> Quoting Fran=C3=A7ois Beaulier (2015-05-15 09:33:30)
>> Le 15/05/2015 11:11, Marc Kleine-Budde a =C3=A9crit :
>>> On 05/15/2015 10:20 AM, Yegor Yefremov wrote:
>>>> On Fri, May 15, 2015 at 9:56 AM, Fran=C3=A7ois Beaulier <fbeaulier=
@orange.fr> wrote:
>>>>> Hi,
>>>>>
>>>>> I'm starting the design of a CPU board, based on a computer on mo=
dule with a
>>>>> very common SOC like i.mx6 or am335x.
>>>>> I need to fit my board with at least 10 CAN ports, may be more. (=
The SOC
>>>>> have 2 CANs so i need 8 more)
>>>>> The board will run with Linux and of course i want a socketcan in=
terface for
>>>>> each bus !
>>>>> CAN bitrate needed is quite low (50kbps) and latency is not criti=
cal but bus
>>>>> load may reach 100% sometimes.
>>>>> As far as possible i want to avoid driver development, or just do=
ing slight
>>>>> modifications on an existing driver.
>>>>> I don't want to use MCP2515, i had trouble with it on a previous =
design
>>>>> because of the lack of buffer in the chip.
>>>>> I can't imagine putting 8 MCP2515 and not missing any frame, but =
may be i'm
>>>>> wrong ?
>>>>>
>>>>> Here are the options i have considered, they involve using extern=
al MCUs to
>>>>> provide enough CAN interfaces :
>>>>>
>>>>> - MCUs with SLCAN : SLCAN have the advantage of simplicity and it=
 should
>>>>> offer enough performance at low data rate. Problem is that it wou=
ld require
>>>>> 8 UARTS. I could modify SLCAN driver to allow multiple CAN channe=
ls on the
>>>>> same UART, and so use MCUs with multiple CANs, does it sounds rea=
sonable ?
>>>>>
>>>>> - MCUs with SPI 1 : adapt MCP2515 driver in a way to make the SPI=
 protocol
>>>>> manageable on the MCU side (SPI slave). The MCU will be able to p=
rovide the
>>>>> buffer for CAN frames that the MCP does not have. This option is =
just a way
>>>>> of trying to go fast, it is not very elegant, and have the limita=
tion of one
>>>>> CAN channel per SPI connection / driver instance.
>>>>>
>>>>> - MCUs with SPI 2 : use the Stefano Babic SPI driver posted on th=
is list.
>>>>> This is probably the best choice for a long term and more generic=
 solution.
>>>>> But i'm afraid it may require too much work to complete. What is =
the status
>>>>> of this driver right now ? Does anyone have an idea of the remain=
ing work to
>>>>> do to make it ready for mainline ? Stefano are you available to s=
pend more
>>>>> time on it ? I'm also wondering whether multiple instances of the=
 driver can
>>>>> run concurently if i put more than one MCU ?
>>>>>
>>>>> Concerning the MCU software i could release it as an open-source =
project,
>>>>> anyone interested in participating ?
>>>>> I'm very familiar with STM32 MCUs so i will probably use an STM32=
=46072 (low
>>>>> cost cortex M0 with one CAN).
>>>>>
>>>>> Any idea or advice is welcome, thank you for reading this much to=
o long
>>>>> post.
>>>> Is it possible to attach 8 SJA1000s over local bus? The driver is
>>>> already in mainline kernel.
>>> Don't use the mcp251x.
>>>
>>> If you have PCIe, there are some dual CAN modules (available in min=
iPIC,
>>> too). But PCIe ist probably quite cost intensive. USB would be an
>>> option, but I'm not sure if there are modules that can be
>>> connected/soldered to a PCB. As Yegor said, SJA1000s + a CPLD are a=
n
>>> option, too, but IIRC the SJA1000 has a 5V IO interface.
>>>
>>> Marc
>>>
>> Module based solutions are too expensive, whether it is PCIe or USB.
>> There are some bridge chips PCIe <-> memory, but i'm not familiar wi=
th that.
>> And you are right the SJA1000 is an old 5V beast !
>>
>> Francois
> Have you considered FPGA?
>
> Andri
I don't know much about FPGA, i can see in the kernel that there are=20
c_can and m_can drivers, i guess i have to add something like a PCIe=20
bridge to connect the CAN controllers with the SOC ?
Is there a way to use FPGA that would not lead to driver development ?
Do you have any link where i can learn more about Linux + FPGA + CAN ?

Thanks Andri

