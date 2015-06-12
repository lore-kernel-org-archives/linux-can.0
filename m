From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: CAN question: how to trace frame errors?
Date: Fri, 12 Jun 2015 22:33:17 +1000
Message-ID: <557AD18D.8010807@optusnet.com.au>
References: <CAOpc7mFv6ePXqkCZxRkCOC+BuY-PC14nAopZyFpEKHvj5gN_tw@mail.gmail.com>	<557AA7BE.6040004@pengutronix.de> <CAOpc7mH-xD+eesJNjhpFwUSeMwGCdsRK8Q9AZSjmE2uw=cBgsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:50469 "EHLO
	mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754999AbbFLMdY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 12 Jun 2015 08:33:24 -0400
In-Reply-To: <CAOpc7mH-xD+eesJNjhpFwUSeMwGCdsRK8Q9AZSjmE2uw=cBgsw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Holger Schurig <holgerschurig@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On 12/06/2015 8:01 PM, Holger Schurig wrote:
>> These are probably RX-FIFO overrun errors:
>
> You're right.
>
> 13:03:16 kernel: ##HS flexcan_irq FIFO overrun
>
> That really puzzles me. The errors occured originally when someuse
> used a Kvazer to generate 80% load at 500 kB/s. In my tests, I used 1
> MB/s and cangen (no Kvazer here). The i.MX6 was otherwise idle:

Idle has nothing to do with it. The problem is the latency.

Let's do the maths.

The worst case CAN message arrival rate is with standard ID CAN messages 
with zero bytes of data. These are about 50 bits long. So at 500kHz they 
arrive at 10kHz or 100us interval. FlexCAN has a six message FIFO. So it 
can receive six without overflowing, but the seventh will blow it. So it 
has to (start to) be unloaded within 700us.

Since the CPU is running at 800MHz, that's only 560,000 instructions to 
respond to an interrupt. And it isn't managing it. That's what "Not Real 
Time" means - half a million instructions isn't enough time.

Except it isn't "respond to an interrupt" as the FlexCAN driver doesn't 
receive the 8-byte messages during the interrupt. It schedules a NAPI 
service routine to read the data, and they can easily be delayed that 
long waiting for a slot.

Do you have a Frame Buffer? Is it write-through or cache-flushed? I've 
read that a flush of a frame-buffer-sized chunk of memory can take the 
L2 cache a very long time to complete. Think MILLIseconds. That locks up 
ALL CORES unless the other ones are lucky enough to stay inside both 
their L1 caches.

We couldn't handle CAN losing data (and run at 1 MBit) so I rewrote the 
3.4 FlexCAN driver to unload the FIFO into a ring buffer during 
interrupts and to have the NAPI routine unload that. No problems since then.

 > kernel is 3.18.14

Then you SHOULD be better off than we were, running 3.4. In that version 
the FlexCAN controller uses NAPI (and always has) while the Ethernet 
controller didn't, but would happily try and unload 100 Ethernet packets 
all the way to the network layer in the interrupt routine, blocking the 
FlexCAN interrupts and NAPI run.

So check your Ethernet driver and see if it uses NAPI and if there's any 
work-limiting in the interrupt routine.

Flood ping (ping -f -l 20) one of them and see if that makes the 
overruns worse during your CAN test.

Run cangen with an 8-byte CAN packet and see if the lower arrival rate 
fixes it. Change the message length and see if you can use that to 
"measure the latency".

Then see what other interrupts you're getting. Try:

     while true; do cat /proc/interrupts; sleep 1; done

See which interrupt counts (apart from FlexCAN) are increasing quickly.

Then you'll want to FTRACE (CONFIG_PERF_EVENTS) the kernel. The Kernel 
Tracing is very good and very powerful. Learning how to run this is a 
skill very worth having. You want to find where it is spending its time 
between the interrupt and the NAPI run.

In our case we found our kernel was spending the majority of its time in 
mutex, spinlock and slub debugging. It got six times faster when I got 
rid of those.

Tom

