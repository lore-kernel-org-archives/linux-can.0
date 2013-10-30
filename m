From: =?UTF-8?B?Ik1hcnRpbiBLb8W+dXNrw70gW0tLIG1pY3JvIHMuci5vLl0i?=
	<mkozusky@kkmicro.cz>
Subject: Re: CAN messages being lost on i.MX25 with flexcan - continued (was
 CAN messages being lost on i.MX25 with flexcan - 2012-04-19)
Date: Wed, 30 Oct 2013 09:43:33 +0100
Message-ID: <5270C6B5.8050408@kkmicro.cz>
References: <l4b8eg$40b$1@ger.gmane.org> <526A6B28.4040800@kkmicro.cz> <526AB12C.7090900@grandegger.com> <526C0768.8040903@kkmicro.cz> <526C1A90.4050005@grandegger.com> <526F9216.6010506@kkmicro.cz> <526FA40D.8000202@grandegger.com> <526FACBD.4030605@kkmicro.cz> <526FC670.4000209@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from server.aquastore.cz ([37.157.193.242]:57000 "EHLO
	server.aquastore.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269Ab3J3Inj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 30 Oct 2013 04:43:39 -0400
In-Reply-To: <526FC670.4000209@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

-------- Original Message  --------
Subject: Re: CAN messages being lost on i.MX25 with flexcan - continued=
 (was CAN messages being lost on i.MX25 with flexcan - 2012-04-19)
=46rom: Wolfgang Grandegger
To: Martin Kozusky, linux-can@vger.kernel.org
Date: 29. =C5=98=C3=ADjen 2013 15:30:08

> On 10/29/2013 01:40 PM, Martin Kozusky wrote:
>> Dne 29.10.2013 13:03, Wolfgang Grandegger napsal(a):
>>> On 10/29/2013 11:46 AM, Martin Kozusky wrote:
> ...
>>>> Hello Wolfgang,
>>>> it seems that my architecture (arm/mx25 on 2.6.35 kernel) is missi=
ng
>>>> HAVE_FUNCTION_GRAPH_TRACER, HAVE_DYNAMIC_FTRACE options so it won'=
t be
>>>> that easy, will be?
>>>> Timestamps that ftrace is showing me are in 10 miliseconds resolut=
ion,
>>>> that won't help me much :(
>
> Are high resolution timers enabled in the kernel? Still, event tracin=
g
> could would already be useful.
>
>>> Probably that version is to old for proper ftrace support. The 100u=
s you
>>> measured for alloc_can_skb() is worst case, right? What is the mean
>>> value?
>>
>> Now I checked again and logged every call (don't know if realy
>> everything was logged but something was :) and I see that it is not
>> 100usec, but only around 20usec (mean value - checked by eye). There
>> were some very long calls (around 2ms!) that were puttings errors in=
 my
>> sum/count formula (may be I should filter out calls longer that
>> 200usec), with this error it was not 100usec, but almost 1ms (my val=
ue
>> was only 32bit and was overflowing when I wrote it first time). So
>> normally around 20usec, but with very long calls around 2-3 ms (look=
s
>> like those long are periodic - each 6th - 8th call is much longer, b=
ut
>> not all the time)
>
> Are these long latencies related to the SDcard accesses? I think the
> problem is the rather long latencies caused by other kernel activity.=
 In
> your case caused by the MMC (SDcard) driver, I assume. The Flexcan
> controller does buffer up to 5 messages before loosing packets.
I think it is not primary related to SD card, those tests I was doing l=
ately were done when system was idle, no special processes were running=
=2E But when I do access SD card, problems get bigger.

>> But still with those 20usec call, there are many RX overflows, if I
>> disable the call alloc_can_skb, there are no overflows and all is
>> received (but still not processed further, because I don't have skb =
=2E.. )
>
> Could you run this test for a longer time? The probability is just lo=
wer
> that RX gets interrupted for a longer time, I think.
I have run it for a few minutes, problem is still the same :(
 =20
> I see a few approaches to overcome this problem:
>
> - fix the MMC driver to cause less latency. If you are lucky this is
>    already the case in more recent versions of the kernel.
Hard to say if this helps when it's also doing in idle.

> - Use the "-rt" extension (CONFIG_PREEPMT_RT). It will then allow to
>    adjust priorities of soft and hard irq threads.
I don't know if there is a patch for this :(
 =20
> - Do the RX processing in the interrupt context, which would require
>    some custom modifications.
I was thinking about writing data directly to fifo file, my program wou=
ld read from it
 =20
Martin

> Wolfgang.
>

