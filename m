From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [Socketcan-users] Support of MCP2515 and AM35x High-End CAN controller
 in (RT-)SocketCAN
Date: Thu, 03 May 2012 12:33:58 +0200
Message-ID: <4FA25F16.9040602@grandegger.com>
References: <CAKG=6c5jafRAGjeQscTKLQbSjPFp7UJYwhhcpOS2QoNvy7Cggw@mail.gmail.com>	<3F602CD5BF1C69469B2F060E90850642C7E6DC@DQHE01.ent.ti.com> <CAKG=6c50e3Q-fKvfhcSzqMAC66jTg2t7+U3f7uE10_r5sC5pLg@mail.gmail.com> <4FA22FFC.8050905@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:33336 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754407Ab2ECKeI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 May 2012 06:34:08 -0400
In-Reply-To: <4FA22FFC.8050905@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marcus Liebhardt <marcus.liebhardt@yujinrobot.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>

On 05/03/2012 09:13 AM, Wolfgang Grandegger wrote:
> On 05/03/2012 07:21 AM, Marcus Liebhardt wrote:
>> Hi there!
>>
>> First of all, thank you for your valuable feedback! I'll combine my
>> questions and answers in one email.
>>
>>> Setup time is not a strong argument for choosing -rt vs. Xenomai.
>>> [...]
>>> What are your requirements concerning latency and data rate?
>>
>> Our real-time requirements are 10 ms cycles, latencies around 1000 us
>> and we plan to use the 1 Mbit/s data rate. Based on what I read so
>> far, this should be feasible with SocketCAN and a _well-tuned_
>> RT-Linux.
> 
> Yes, that's feasible, I believe.
> 
>> And yes, set-up time is not the most important part for this decision,
>> but since I am a beginner it is not totally unimportant either.
>>
>>> Don't use mcp2515, you won't have any fun with it. [...]
>>
>> Why exactly is the MCP2515 not suitable for real-time applications? Is
>> the SPI interface a bottleneck? (Isn't SPI fast?)
> 
> For each register access a SPI transfer needs to be setup and handled
> and therefore it's much slower than memory mapped I/O. People report
> data-losses at high data rates, especially 1MBit/s. Maybe the -rt helps
> to avoid them. Also the existing SPI interface is not optimal,
> especially for -rt.
> 
>>> Note that Beaglebone uses TI's AM335x SOC which has D_CAN peripheral vs the Beagleboard
>>> Which uses TI's AM37x SOC and it does not have CAN peripheral integrated. AM3517 SOC has
>>> HECC CAN peripheral which is different than D_CAN found on AM335x. Both HECC and D_CAN drivers
>>> have been submitted to the linux-can list and HECC is already mainline - D_CAN driver has
>>> been submitted to this list and is undergoing review - it will be merged with the C_CAN driver
>>> shortly.
>>
>> Thanks a lot for this clarification! It made me realise that I got
>> quite confused by those many SoC variations. Hence, I checked the
>> documents again and I hope I got it right this time:
>> Neither the Beagleboard (OMAP3530), nor the Beagleboard-xM (DM3730)
>> offer a CAN bus controller. But the Beaglebone (AM3359) offers the
>> DCAN controller and the Craneboard (AM3517) the HECC.
>> Are both controllers suitable for a real-time application with the
>> mentioned requirements? Is there a performance difference among both
>> controllers?
>> And do you think that the whole system consisting of SocketCAN + Linux
>> + PREEMPT_RT patch + proper tuning will fulfil the requirements?
> 
> I'm quite optimistic, despite the sub-optimal SPI interface.

To be clear, I'm optimistic for the SOC CAN controllers but not for the
mcp2515.

Wolfgang.
