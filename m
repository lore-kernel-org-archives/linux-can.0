From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: CAN messages being lost on i.MX25 with flexcan - continued (was
 CAN messages being lost on i.MX25 with flexcan - 2012-04-19)
Date: Tue, 29 Oct 2013 15:30:08 +0100
Message-ID: <526FC670.4000209@grandegger.com>
References: <l4b8eg$40b$1@ger.gmane.org> <526A6B28.4040800@kkmicro.cz> <526AB12C.7090900@grandegger.com> <526C0768.8040903@kkmicro.cz> <526C1A90.4050005@grandegger.com> <526F9216.6010506@kkmicro.cz> <526FA40D.8000202@grandegger.com> <526FACBD.4030605@kkmicro.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:43861 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755289Ab3J2OaK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 29 Oct 2013 10:30:10 -0400
In-Reply-To: <526FACBD.4030605@kkmicro.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Martin Kozusky <mkozusky@kkmicro.cz>, linux-can@vger.kernel.org

On 10/29/2013 01:40 PM, Martin Kozusky wrote:
> Dne 29.10.2013 13:03, Wolfgang Grandegger napsal(a):
>> On 10/29/2013 11:46 AM, Martin Kozusky wrote:
...
>>> Hello Wolfgang,
>>> it seems that my architecture (arm/mx25 on 2.6.35 kernel) is missing
>>> HAVE_FUNCTION_GRAPH_TRACER, HAVE_DYNAMIC_FTRACE options so it won't be
>>> that easy, will be?
>>> Timestamps that ftrace is showing me are in 10 miliseconds resolution,
>>> that won't help me much :(

Are high resolution timers enabled in the kernel? Still, event tracing
could would already be useful.

>> Probably that version is to old for proper ftrace support. The 100us you
>> measured for alloc_can_skb() is worst case, right? What is the mean
>> value?
> 
> Now I checked again and logged every call (don't know if realy
> everything was logged but something was :) and I see that it is not
> 100usec, but only around 20usec (mean value - checked by eye). There
> were some very long calls (around 2ms!) that were puttings errors in my 
> sum/count formula (may be I should filter out calls longer that
> 200usec), with this error it was not 100usec, but almost 1ms (my value
> was only 32bit and was overflowing when I wrote it first time). So
> normally around 20usec, but with very long calls around 2-3 ms (looks
> like those long are periodic - each 6th - 8th call is much longer, but
> not all the time)

Are these long latencies related to the SDcard accesses? I think the
problem is the rather long latencies caused by other kernel activity. In
your case caused by the MMC (SDcard) driver, I assume. The Flexcan
controller does buffer up to 5 messages before loosing packets.

> But still with those 20usec call, there are many RX overflows, if I
> disable the call alloc_can_skb, there are no overflows and all is
> received (but still not processed further, because I don't have skb ... )

Could you run this test for a longer time? The probability is just lower
that RX gets interrupted for a longer time, I think.

I see a few approaches to overcome this problem:

- fix the MMC driver to cause less latency. If you are lucky this is
  already the case in more recent versions of the kernel.

- Use the "-rt" extension (CONFIG_PREEPMT_RT). It will then allow to
  adjust priorities of soft and hard irq threads.

- Do the RX processing in the interrupt context, which would require
  some custom modifications.

Wolfgang.

