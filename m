From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: CAN question: how to trace frame errors?
Date: Sun, 14 Jun 2015 12:42:54 +1000
Message-ID: <557CEA2E.5060904@optusnet.com.au>
References: <CAOpc7mFv6ePXqkCZxRkCOC+BuY-PC14nAopZyFpEKHvj5gN_tw@mail.gmail.com>	<557AA7BE.6040004@pengutronix.de>	<CAOpc7mH-xD+eesJNjhpFwUSeMwGCdsRK8Q9AZSjmE2uw=cBgsw@mail.gmail.com>	<557AD18D.8010807@optusnet.com.au>	<CAOpc7mG5nD1daKSkGdqoR84=W_A11s+oQfzc_i4pUsHoVd42Tw@mail.gmail.com>	<557C4C83.3020501@optusnet.com.au> <CAOpc7mHYiX3SAJSEHM32PA1gRFA+BQ0DxCC3U6Aux15Swy06sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:32958 "EHLO
	mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751271AbbFNCnB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 13 Jun 2015 22:43:01 -0400
In-Reply-To: <CAOpc7mHYiX3SAJSEHM32PA1gRFA+BQ0DxCC3U6Aux15Swy06sQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Holger Schurig <holgerschurig@gmail.com>
Cc: linux-can@vger.kernel.org

On 14/06/2015 6:28 AM, Holger Schurig wrote:
>> and while the CPU supports different interrupt priorities, the 3.4 TZIC code
>> simply doesn't provide the functions to change it.
>
> I don't know the i.MX5x and it's TZIC, only the i.MX6 ... and only a
> bit. But I think there it's not a limitation in the silicon, but in
> the software (Linux in our case, e.g. drivers/irqchips/gic*).

I think Linux has to cater for the "lowest common denominator hardware", 
so features like priority interrupts aren't used/supported for the cases 
where they simply aren't present.

> And btw, thanks for your patch. I'll probably rewrite it to use kfifo,
> which is a ringbuffer already contained in Linux (see
> include/linux/kfifo.h), I think that will increase it's chance of
> inclusion.

I think there'll be a architectural/philosophical push-back against a 
change that makes an interrupt service routine take longer. I'll let 
those with more experience than me make this case.

Data point. Reading pretty much any peripheral register (in any ISR) 
takes 180ns on an i.MX53, and I'd expect similar with the i.MX6 [1]. 
Reading the entire FIFO would take four reads/message plus another 
couple for the status words for each entry, so about 7us or 7000 CPU 
clocks at 1GHz.

But here's a compromise. The FlexCAN controller has nearly 70 different 
interrupt sources, although normally only a few are enabled. 
FLEXCANx_IFLAG1[bit 5] is "at least one frame in FIFO" and 
FLEXCANx_IFLAG1[bit 6] is "FIFO nearly full" (4 out of 6).

So I'd suggest enabling both of them and having the code work like it 
does now for the normal interrupt, but have the "FIFO nearly full" one 
trigger an unload (to the ring buffer) within the interrupt. That would 
result in a fast interrupt routine most of the time, only taking a bit 
longer when needed to avoid overflow. Synchronising the reads in the ISR 
and the ones in NAPI "left as an interesting exercise for the 
programmer" (especially trying to test it properly :-).

Slow peripheral reads (even OCRAM is slow) discussed here:

https://community.freescale.com/thread/355199

Tom

