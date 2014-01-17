From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: Re: [PATCH RFC 1/2] can: Limit default size of CAN_RAW socket send queue
Date: Fri, 17 Jan 2014 13:11:43 +0100
Message-ID: <87eh46lse8.fsf@steelpick.2x.cz>
References: <1389902301-24505-1-git-send-email-sojkam1@fel.cvut.cz> <52D8F44A.7000007@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from max.feld.cvut.cz ([147.32.192.36]:44825 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751450AbaAQMLu (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 17 Jan 2014 07:11:50 -0500
In-Reply-To: <52D8F44A.7000007@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: yegorslists@googlemail.com

On Fri, Jan 17 2014, Marc Kleine-Budde wrote:
> On 01/16/2014 08:58 PM, Michal Sojka wrote:
>> This fixes the infamous ENOBUFS problem, which appears when an
>> application sends CAN frames faster than they leave the system.
>> 
>> Packets for sending can be queued at three places: socket, queueing
>> discipline and device driver. Only the socket queue is able to block
>> the sender; other queues are non-blocking. Since the size of the qdisc
>> queue was set by default to 10 packets, this queue was full much
>> earlier than the socket queue and this resulted in ENOBUFS error.
>> 
>> This patch limits the default size of the socket send queue to
>> approximately 3 CAN frames and increases the size of the qdisc queue
>> to 100 frames. This setting allows for at least 33 CAN_RAW sockets to
>> be used simultaneously in the system without getting ENOBUFS errors.
>
> Do you mean in the system, per CAN interface or per socket? 

Per CAN interface is correct. I'll send an updated patch later.

> How many CAN frames does a socket take before it blocks (with the
> default values), in case the CAN interface doesn't send any messages?

Without this patch, the answer depends on the value of
/proc/sys/net/core/wmem_default and the size of sk_buff which in turn
depends on the kernel configuration.

wmem_default is 163840 on my PowerPC and 212992 on my laptop. This gives
163840/448 = 366 frames. Then, 10 more frames can sit in qdisc and a few
more in the driver/hardware.

With this patch, 366 changes to 3.

>> Note that the size of the socket queue is only approximate, because it
>> is counted in bytes and the realy allocated memory (skb->truesize) can
>> be bigger than what is reported by SKB_TRUESIZE(). For example, on my
>> 32 bit PowerPC system, SKB_TRUESIZE() = 408, but skb->truesize = 448.
>
> What does that mean for number of CAN frames in the above question?

The exact maximal number of CAN frames sitting in the send socket queue
is 1+floor(sk_sndbuf/skb->truesize). For the numbers above this gives:

  1+floor(3*408/448) = 1+floor(2.73) = 3

Of course, this only holds if skb->truesize is the same for all CAN
sk_buffs, which I expect that be true. The truesize depends on how much
memory is really allocated by a memory allocator, which may be more than
what you ask [1]. That's why SKB_TRUESIZE()=408, but skb->truesize=448
on my system.

[1]:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/net/core/skbuff.c?id=v3.12#n255

>
>> Open issues:
>> - Will this work with CANFD?
>
> Can you calculate the size in bytes depending if we have a CAN or a
> CANFD network card at this socket?

I'm not sure whether this is possible at socket creation time. You could
do it at bind time, but first, nobody would expect that sk_sndbuf gets
changed by calling bind and second, you can have a socket not bound to
any interface and use dest_addr parameter of sendto() to specify the
interface.

Thanks,
-Michal
