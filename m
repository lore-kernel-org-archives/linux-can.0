From: Marcus Liebhardt <marcus.liebhardt@yujinrobot.com>
Subject: Re: [Socketcan-users] Support of MCP2515 and AM35x High-End CAN
 controller in (RT-)SocketCAN
Date: Fri, 4 May 2012 11:27:31 +0900
Message-ID: <CAKG=6c6wRV=-WzjNQvexurOFLxfv+EswAA02BpL6mMQALmLSpw@mail.gmail.com>
References: <CAKG=6c5jafRAGjeQscTKLQbSjPFp7UJYwhhcpOS2QoNvy7Cggw@mail.gmail.com>
	<3F602CD5BF1C69469B2F060E90850642C7E6DC@DQHE01.ent.ti.com>
	<CAKG=6c50e3Q-fKvfhcSzqMAC66jTg2t7+U3f7uE10_r5sC5pLg@mail.gmail.com>
	<4FA22FFC.8050905@grandegger.com>
	<4FA25F16.9040602@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:61984 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756922Ab2EDC1c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 May 2012 22:27:32 -0400
Received: by obbtb18 with SMTP id tb18so3304729obb.19
        for <linux-can@vger.kernel.org>; Thu, 03 May 2012 19:27:31 -0700 (PDT)
In-Reply-To: <4FA25F16.9040602@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>

2012/5/3 Wolfgang Grandegger <wg@grandegger.com>:
> On 05/03/2012 09:13 AM, Wolfgang Grandegger wrote:
>> On 05/03/2012 07:21 AM, Marcus Liebhardt wrote:
>>> Hi there!
>>>
>>> First of all, thank you for your valuable feedback! I'll combine my
>>> questions and answers in one email.
>>>
>>>> Setup time is not a strong argument for choosing -rt vs. Xenomai.
>>>> [...]
>>>> What are your requirements concerning latency and data rate?
>>>
>>> Our real-time requirements are 10 ms cycles, latencies around 1000 =
us
>>> and we plan to use the 1 Mbit/s data rate. Based on what I read so
>>> far, this should be feasible with SocketCAN and a _well-tuned_
>>> RT-Linux.
>>
>> Yes, that's feasible, I believe.
>>
>>> And yes, set-up time is not the most important part for this decisi=
on,
>>> but since I am a beginner it is not totally unimportant either.
>>>
>>>> Don't use mcp2515, you won't have any fun with it. [...]
>>>
>>> Why exactly is the MCP2515 not suitable for real-time applications?=
 Is
>>> the SPI interface a bottleneck? (Isn't SPI fast?)
>>
>> For each register access a SPI transfer needs to be setup and handle=
d
>> and therefore it's much slower than memory mapped I/O. People report
>> data-losses at high data rates, especially 1MBit/s. Maybe the -rt he=
lps
>> to avoid them. Also the existing SPI interface is not optimal,
>> especially for -rt.
>>
>>>> Note that Beaglebone uses TI's AM335x SOC which has D_CAN peripher=
al vs the Beagleboard
>>>> Which uses TI's AM37x SOC and it does not have CAN peripheral inte=
grated. AM3517 SOC has
>>>> HECC CAN peripheral which is different than D_CAN found on AM335x.=
 Both HECC and D_CAN drivers
>>>> have been submitted to the linux-can list and HECC is already main=
line - D_CAN driver has
>>>> been submitted to this list and is undergoing review - it will be =
merged with the C_CAN driver
>>>> shortly.
>>>
>>> Thanks a lot for this clarification! It made me realise that I got
>>> quite confused by those many SoC variations. Hence, I checked the
>>> documents again and I hope I got it right this time:
>>> Neither the Beagleboard (OMAP3530), nor the Beagleboard-xM (DM3730)
>>> offer a CAN bus controller. But the Beaglebone (AM3359) offers the
>>> DCAN controller and the Craneboard (AM3517) the HECC.
>>> Are both controllers suitable for a real-time application with the
>>> mentioned requirements? Is there a performance difference among bot=
h
>>> controllers?
>>> And do you think that the whole system consisting of SocketCAN + Li=
nux
>>> + PREEMPT_RT patch + proper tuning will fulfil the requirements?
>>
>> I'm quite optimistic, despite the sub-optimal SPI interface.
>
> To be clear, I'm optimistic for the SOC CAN controllers but not for t=
he
> mcp2515.

I was already suspecting that. :-)

However, I'm confused by "[...] despite the sub-optimal SPI
interface.". Do you mean, that the SOC CAN controllers (e.g. DCAN,
HECC) are also using the SPI interface? If so, are they not suffering
the same problems as external CAN controllers (e.g. the MCP2515) using
this bus?


Marcus

>
> Wolfgang.
>
>



--=20
Dipl.-Ing. (M.Sc.) Marcus Liebhardt
Control Engineer
Yujin Robot
=C1=D6=BC=D2: =B4=EB=C7=D1=B9=CE=B1=B9 =BC=AD=BF=EF=BD=C3 =B1=DD=C3=B5=B1=
=B8 =B0=A1=BB=EA=B5=BF 345-30 =B3=B2=BC=BA=C7=C1=B6=F3=C0=DA #601, 153-=
023.
Address: Door #601, Namsung-Plaza, 345-30 Gasan-dong, Guemcheon-gu,
Seoul, 153-023, Republic of Korea
Website: http://www.yujinrobot.com
Email: marcus.liebhardt@yujinrobot.com
Phone: +82-2-2104-0435
