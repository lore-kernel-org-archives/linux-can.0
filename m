From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: Flexcan (was: Re: Fwd: Querying current tx_queue usage of a SocketCAN
 interface)
Date: Sat, 04 Apr 2015 14:32:28 +1100
Message-ID: <551F5B4C.7090900@optusnet.com.au>
References: <CAE+ymru296P+LjkT7_ONVc2OGMP9mtXW46Nq5aSnm1etauj9Aw@mail.gmail.com>	<CAE+ymrt-rsXgteuDCvp27BSsQRE5APGDsgsSPhg31Qz3_qZEdQ@mail.gmail.com>	<55187FF1.7020701@optusnet.com.au>	<CAE+ymrsiE39R2ssXeorAoHuSVFdkLeV7oS-ajTLWDs46iADsYw@mail.gmail.com>	<5519E5A9.7080104@optusnet.com.au>	<CAE+ymrvvqL_o3ZTWdq96kQmMe6c3OzqM+SQN3qPpyH1dLMjmrw@mail.gmail.com>	<551A0FF3.4070400@optusnet.com.au> <CAE+ymrt9gfCDEyNNz-b2gOS0NJt=pupm=t3HqbGosbKBC5wa7A@mail.gmail.com> <551C7D79.50906@optusnet.com.au> <loom.20150402T022922-646@post.gmane.org> <551CA777.8070208@optusnet.com.au> <551CE174.2030303@pengutronix.de> <551D298D.7040809@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:54049 "EHLO
	mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752632AbbDDDce (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 3 Apr 2015 23:32:34 -0400
In-Reply-To: <551D298D.7040809@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, dan.egnor@gmail.com, linux-can@vger.kernel.org

On 2/04/2015 10:35 PM, Tom Evans wrote:
> On 2/04/2015 5:28 PM, Marc Kleine-Budde wrote:
>> On 04/02/2015 04:20 AM, Tom Evans wrote:
>>> I had to seriously rewrite the FlexCAN drivers for our
 >>> i.MX53 because the Ethernet driver blocked the CAN
 >>> driver for so long the CAN hardware receive FIFO overflowed.
 >>
>> Can you share your changes? I'll have some days to hack on a better
>> generic RX-FIFO implementation for the at91 and flexcan.
>
> Sure. "git diff -p" based of the 3.4 kernel sources.

> flexcan.c.patch.buffer
>
> So I fixed it with a sledgehammer. It reads the messages
 > during the ISR to an internal ring buffer (sized to 100,
 > later to 128)

And schedules NAPI to forward them from there rather than reading them 
from the hardware FIFO.

The purpose of NAPI is to make the interrupts as fast as possible, doing 
as little work as possible, but servicing time-critical hardware so it 
doesn't overflow/underflow. Operations like reading characters from a 
serial port.

But that assumes the "little work" is fast. In the case of the FlexCAN 
driver, it takes about 5 reads and a write to read a CAN message, and 
there may be six messages in the FIFO.

Not many accesses, but peripheral device registers can be notoriously 
slow on some CPUs [1]. I've worked on an ARM-based PXA CPU that took 
something like 200 CPU clocks to read a GPIO port once. I don't know how 
fast or slow the FlexCAN register reads and writes are on the i.MX53. If 
they're too slow then my patches may be increasing interrupt latency for 
a given value of "too much".

I'll try and measure this on Tuesday.

Tom

