From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: Fwd: Querying current tx_queue usage of a SocketCAN interface
Date: Thu, 02 Apr 2015 13:20:39 +1100
Message-ID: <551CA777.8070208@optusnet.com.au>
References: <CAE+ymru296P+LjkT7_ONVc2OGMP9mtXW46Nq5aSnm1etauj9Aw@mail.gmail.com>	<CAE+ymrt-rsXgteuDCvp27BSsQRE5APGDsgsSPhg31Qz3_qZEdQ@mail.gmail.com>	<55187FF1.7020701@optusnet.com.au>	<CAE+ymrsiE39R2ssXeorAoHuSVFdkLeV7oS-ajTLWDs46iADsYw@mail.gmail.com>	<5519E5A9.7080104@optusnet.com.au>	<CAE+ymrvvqL_o3ZTWdq96kQmMe6c3OzqM+SQN3qPpyH1dLMjmrw@mail.gmail.com>	<551A0FF3.4070400@optusnet.com.au> <CAE+ymrt9gfCDEyNNz-b2gOS0NJt=pupm=t3HqbGosbKBC5wa7A@mail.gmail.com> <551C7D79.50906@optusnet.com.au> <loom.20150402T022922-646@post.gmane.org>
Reply-To: tom_usenet@optusnet.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:36184 "EHLO
	mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751906AbbDBCUn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Apr 2015 22:20:43 -0400
In-Reply-To: <loom.20150402T022922-646@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dan Egnor <dan.egnor@gmail.com>, linux-can@vger.kernel.org

On 02/04/15 11:33, Dan Egnor wrote:
> Tom Evans <tom_usenet <at> optusnet.com.au> writes:
>> As the "System Designer", if your system (your car) uses SJA1000
>> controllers, or other ones, but with software that doesn't support
 >> the multiple hardware buffers, or has more IDs in use that the
 >> number of buffers, they you have to design the *SYSTEM* so it
 >> works within those constraints.
>
> That's all well and good, but what you're saying is that Linux SocketCAN is
> incapable of supporting anything but the most absolutely basic single-mailbox
> operation.

That's a restriction of the socket interface. It gives you a lot "for free" in 
all the demultiplexing of receive data and the transmit FIFOs, but at a cost.

If you read this paper you'll see that you can use QDISC to implement priority 
queues. That fixes MOST of the problems, but not all as the priority queues 
don't connect through the driver to individual hardware transmit buffers. So 
there's always going to be a "single pipe" somewhere in the system where 
you'll get the priority inversion.

http://rtime.felk.cvut.cz/can/socketcan-qdisc-final.pdf

If you wanted a "perfect" solution you'd need a probably separate can drive 
instance for each hardware buffer.

There's a lot of manual work and overhead setting up those priority queues. 
There's nothing "automatic" about it.

> That seems surprisingly awful for something that's an established generic
> interface for all CAN hardware on this operating system! No matter how many
> mailboxes the controller might support, the operating system simply does not
> support prioritized transmission.

Generic and simple versus custom and complicated. Give me simple any day.

> This means that in our system architecture, Linux nodes must be treated as
> substantially less capable than most embedded controllers. (The TI MCUs we're
> using have 64 mailboxes, for example.)

Linux nodes are by definition a lot less capable. They're not "real time" for 
a start, unless you want to use some "Real Time Linux" (Xenomai etc). But they 
need the CAN drivers rewritten to support them (Xenomai anyway).

I had to seriously rewrite the FlexCAN drivers for our i.MX53 because the 
Ethernet driver blocked the CAN driver for so long the CAN hardware receive 
FIFO overflowed. Linux doesn't even support setting different interrupt 
priorities on ARM (but my problem was with NAPI).

Even if you're running SMP and multicore with ARM, if the framebuffer driver 
does a cache flush it can lock all cores out for L2 for a millisecond, that's 
10 CAN messages at 1MHz:

http://www.arm.com/files/pdf/cachecoherencywhitepaper_6june2011.pdf

> This feels like a massive functional deficit that's acknowledged
 > nowhere in the documentation. Is this really the case??

And everything else in Linux is "perfect"?

Tom

