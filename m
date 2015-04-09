From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: Flexcan
Date: Thu, 09 Apr 2015 18:06:15 +1000
Message-ID: <552632F7.5090204@optusnet.com.au>
References: <CAE+ymru296P+LjkT7_ONVc2OGMP9mtXW46Nq5aSnm1etauj9Aw@mail.gmail.com>	<CAE+ymrt-rsXgteuDCvp27BSsQRE5APGDsgsSPhg31Qz3_qZEdQ@mail.gmail.com>	<55187FF1.7020701@optusnet.com.au>	<CAE+ymrsiE39R2ssXeorAoHuSVFdkLeV7oS-ajTLWDs46iADsYw@mail.gmail.com>	<5519E5A9.7080104@optusnet.com.au>	<CAE+ymrvvqL_o3ZTWdq96kQmMe6c3OzqM+SQN3qPpyH1dLMjmrw@mail.gmail.com>	<551A0FF3.4070400@optusnet.com.au> <CAE+ymrt9gfCDEyNNz-b2gOS0NJt=pupm=t3HqbGosbKBC5wa7A@mail.gmail.com> <551C7D79.50906@optusnet.com.au> <loom.20150402T022922-646@post.gmane.org> <551CA777.8070208@optusnet.com.au> <551CE174.2030303@pengutronix.de> <551D298D.7040809@optusnet.com.au> <551F5B4C.7090900@optusnet.com.au>
Reply-To: tom_usenet@optusnet.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:36397 "EHLO
	mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932254AbbDIIGT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Apr 2015 04:06:19 -0400
In-Reply-To: <551F5B4C.7090900@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, dan.egnor@gmail.com, linux-can@vger.kernel.org

On 04/04/15 14:32, Tom Evans wrote:
> On 2/04/2015 10:35 PM, Tom Evans wrote:
> ...
> And schedules NAPI to forward them from there rather than reading them from
> the hardware FIFO.
>
> The purpose of NAPI is to make the interrupts as fast as possible, doing as
> little work as possible, but servicing time-critical hardware so it doesn't
> overflow/underflow. Operations like reading characters from a serial port.
>
> But that assumes the "little work" is fast. In the case of the FlexCAN driver,
> it takes about 5 reads and a write to read a CAN message, and there may be six
> messages in the FIFO.
>
> Not many accesses, but peripheral device registers can be notoriously slow on
> some CPUs [1].
 > ...
> I'll try and measure this on Tuesday.

Now quite tomorrow, but I have some results:

[    1.494142] flexcan flexcan.1: One do_gettimeofday took 0 us)
[    1.499903] flexcan flexcan.1: Ten do_gettimeofday took 4 us)
[    1.505677] flexcan flexcan.1: 100 flexcan_read() took 23 us)

I first measured the overhead of calling do_gettimeofday(), which is about 
0.4us. So I can pretty much ignore that in this test.

Then in a loop reading a FlexCAN control register, it took about 0.23us per 
read. That's 230ns or about 184 CPU clocks at 800MHz.

OK, so this IS a slow peripheral.

Given it takes about 5 reads to read one message, that's about 1.15us per 
message. With a queue depth of "6" that's a maximum extra delay of 6.9us.

I think that's OK for an interrupt. What's the "modern expectation" of the 
latency?

Tom

