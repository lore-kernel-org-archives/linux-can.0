From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: Fwd: Querying current tx_queue usage of a SocketCAN interface
Date: Thu, 02 Apr 2015 13:20:44 +1100
Message-ID: <551CA77C.2080706@optusnet.com.au>
References: <CAE+ymru296P+LjkT7_ONVc2OGMP9mtXW46Nq5aSnm1etauj9Aw@mail.gmail.com> <CAE+ymrt-rsXgteuDCvp27BSsQRE5APGDsgsSPhg31Qz3_qZEdQ@mail.gmail.com> <55187FF1.7020701@optusnet.com.au> <CAE+ymrsiE39R2ssXeorAoHuSVFdkLeV7oS-ajTLWDs46iADsYw@mail.gmail.com> <5519E5A9.7080104@optusnet.com.au> <CAE+ymrvvqL_o3ZTWdq96kQmMe6c3OzqM+SQN3qPpyH1dLMjmrw@mail.gmail.com> <551A0FF3.4070400@optusnet.com.au> <CAE+ymrt9gfCDEyNNz-b2gOS0NJt=pupm=t3HqbGosbKBC5wa7A@mail.gmail.com> <loom.20150401T225437-75@post.gmane.org>
Reply-To: tom_usenet@optusnet.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:36480 "EHLO
	mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751906AbbDBCUq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Apr 2015 22:20:46 -0400
In-Reply-To: <loom.20150401T225437-75@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dan Egnor <dan.egnor@gmail.com>, linux-can@vger.kernel.org

On 02/04/15 07:57, Dan Egnor wrote:
> Paarvai Naai <opensource3141 <at> gmail.com> writes:
>> I have a suspicion that SocketCAN implementations are not careful
>> about doing this, even though particular controllers may support this
>> type of re-prioritization of frames (with their own internal TX
>> queues).
>
> Actually I think this is a problem even if you have one process -- a higher
> priority message can get stuck behind a lower priority message (priority
> inversion).

If there's a "single pipe" anywhere - a queue in the Application, in the OS, 
the driver or the hardware then you get this problem.

> Is there any way to deal with this, assuming that one node wants to send both
> high priority and low priority messages?

You need separate pipes all the way down to the CAN bus, through separate 
hardware "transmit buffers" that compete for the wire based on the IDs. You 
can probably get 90% of this by using the QDISC system though (in my other email).

> There must be a solution, otherwise
> half the point of CAN (prioritized messages) would be lost...!

That's right, it is lost. Unlike a more "generic" protocol like Ethernet, 
there's no requirement for every implementation to support every operating 
mode. There's no "testing authority" other than what vehicle manufacturers 
require suppliers to meet.

Every hardware and software implementation is a "good enough subset for some 
purpose", but can't be expected to meet every requirement.

In most cases it doesn't matter. As long as all devices have controlled and 
limited transmit rates and don't saturate the bus it all works well enough.

If your system requires the priority system to work for some reason, then YOU 
(as the system designer) have to be across every piece of hardware and 
software in the system to prove that it does work. That means binning all 
devices that use SJA1000s and replacing them with something better. That means 
replacing all devices running Linux with something else, or at least replacing 
the software and the drivers to work the way you need them to, probably 
bypassing socketcan and writing your own custom driver interface using ioctls.

Tom

