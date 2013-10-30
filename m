From: =?UTF-8?B?Ik1hcnRpbiBLb8W+dXNrw70gW0tLIG1pY3JvIHMuci5vLl0i?=
	<mkozusky@kkmicro.cz>
Subject: Re: CAN messages being lost on i.MX25 with flexcan - continued (was
 CAN messages being lost on i.MX25 with flexcan - 2012-04-19)
Date: Wed, 30 Oct 2013 10:14:05 +0100
Message-ID: <5270CDDD.9080405@kkmicro.cz>
References: <l4b8eg$40b$1@ger.gmane.org> <526A6B28.4040800@kkmicro.cz> <526AB12C.7090900@grandegger.com> <526C0768.8040903@kkmicro.cz> <526C1A90.4050005@grandegger.com> <526F9216.6010506@kkmicro.cz> <526FA40D.8000202@grandegger.com> <526FACBD.4030605@kkmicro.cz> <526FC670.4000209@grandegger.com> <5270C6B5.8050408@kkmicro.cz> <5270CB8D.5020206@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.aquastore.cz ([37.157.193.242]:57132 "EHLO
	server.aquastore.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927Ab3J3JOO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 30 Oct 2013 05:14:14 -0400
In-Reply-To: <5270CB8D.5020206@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

-------- Original Message  --------
Subject: Re: CAN messages being lost on i.MX25 with flexcan - continued=
 (was CAN messages being lost on i.MX25 with flexcan - 2012-04-19)
=46rom: Wolfgang Grandegger
To: Martin Ko=C5=BEusk=C3=BD [KK micro s.r.o.], linux-can@vger.kernel.o=
rg
Date: 30. =C5=98=C3=ADjen 2013 10:04:13

> On 10/30/2013 09:43 AM, "Martin Ko=C5=BEusk=C3=BD [KK micro s.r.o.]" =
wrote:
>> -------- Original Message  --------
>> Subject: Re: CAN messages being lost on i.MX25 with flexcan - contin=
ued
>> (was CAN messages being lost on i.MX25 with flexcan - 2012-04-19)
>> From: Wolfgang Grandegger
>> To: Martin Kozusky, linux-can@vger.kernel.org
>> Date: 29. =C5=98=C3=ADjen 2013 15:30:08
>>
>>> On 10/29/2013 01:40 PM, Martin Kozusky wrote:
>>>> Dne 29.10.2013 13:03, Wolfgang Grandegger napsal(a):
>>>>> On 10/29/2013 11:46 AM, Martin Kozusky wrote:
>>> ...
>>>>>> Hello Wolfgang,
>>>>>> it seems that my architecture (arm/mx25 on 2.6.35 kernel) is mis=
sing
>>>>>> HAVE_FUNCTION_GRAPH_TRACER, HAVE_DYNAMIC_FTRACE options so it wo=
n't be
>>>>>> that easy, will be?
>>>>>> Timestamps that ftrace is showing me are in 10 miliseconds resol=
ution,
>>>>>> that won't help me much :(
>>>
>>> Are high resolution timers enabled in the kernel? Still, event trac=
ing
>>> could would already be useful.
>>>
>>>>> Probably that version is to old for proper ftrace support. The 10=
0us
>>>>> you
>>>>> measured for alloc_can_skb() is worst case, right? What is the me=
an
>>>>> value?
>>>>
>>>> Now I checked again and logged every call (don't know if realy
>>>> everything was logged but something was :) and I see that it is no=
t
>>>> 100usec, but only around 20usec (mean value - checked by eye). The=
re
>>>> were some very long calls (around 2ms!) that were puttings errors =
in my
>>>> sum/count formula (may be I should filter out calls longer that
>>>> 200usec), with this error it was not 100usec, but almost 1ms (my v=
alue
>>>> was only 32bit and was overflowing when I wrote it first time). So
>>>> normally around 20usec, but with very long calls around 2-3 ms (lo=
oks
>>>> like those long are periodic - each 6th - 8th call is much longer,=
 but
>>>> not all the time)
>>>
>>> Are these long latencies related to the SDcard accesses? I think th=
e
>>> problem is the rather long latencies caused by other kernel activit=
y. In
>>> your case caused by the MMC (SDcard) driver, I assume. The Flexcan
>>> controller does buffer up to 5 messages before loosing packets.
>> I think it is not primary related to SD card, those tests I was doin=
g
>> lately were done when system was idle, no special processes were
>> running. But when I do access SD card, problems get bigger.
>>
>>>> But still with those 20usec call, there are many RX overflows, if =
I
>>>> disable the call alloc_can_skb, there are no overflows and all is
>>>> received (but still not processed further, because I don't have sk=
b
>>>> ... )
>>>
>>> Could you run this test for a longer time? The probability is just =
lower
>>> that RX gets interrupted for a longer time, I think.
>> I have run it for a few minutes, problem is still the same :(
>>
>>> I see a few approaches to overcome this problem:
>>>
>>> - fix the MMC driver to cause less latency. If you are lucky this i=
s
>>>     already the case in more recent versions of the kernel.
>> Hard to say if this helps when it's also doing in idle.
>
> OK, then I misinterpreted your error description.
>
>>> - Use the "-rt" extension (CONFIG_PREEPMT_RT). It will then allow t=
o
>>>     adjust priorities of soft and hard irq threads.
>> I don't know if there is a patch for this :(
>>
>>> - Do the RX processing in the interrupt context, which would requir=
e
>>>     some custom modifications.
>> I was thinking about writing data directly to fifo file, my program
>> would read from it
>
> Well, before hacking something you should try to find out what is
> provoking the long latencies (> 1ms). FTrace is your friend. Therefor=
e I
> would try to get a more recent version of the kernel running somehow.
> 2.6.39 should already be much better.
I will try to get new kernel running, but when I checked the patch for =
2.6.35, I see some incompatibilites in directory structure and files, s=
o I will have to go line-by-line and make my patch that will fit the ne=
w kernel. And when I do that, I will try it on latest 3.x kernel. I hop=
e I will make it work.

Martin
 =20
> Wolfgang.
>
>

