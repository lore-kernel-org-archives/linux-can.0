From: Paarvai Naai <opensource3141@gmail.com>
Subject: Re: Fwd: Querying current tx_queue usage of a SocketCAN interface
Date: Thu, 2 Apr 2015 11:28:19 -0700
Message-ID: <CAE+ymrv2mf1Cn+9EQgyS5yhSxFdSadRKvwb_opLm8AkKqfqV5w@mail.gmail.com>
References: <CAE+ymru296P+LjkT7_ONVc2OGMP9mtXW46Nq5aSnm1etauj9Aw@mail.gmail.com>
	<CAE+ymrt-rsXgteuDCvp27BSsQRE5APGDsgsSPhg31Qz3_qZEdQ@mail.gmail.com>
	<55187FF1.7020701@optusnet.com.au>
	<CAE+ymrsiE39R2ssXeorAoHuSVFdkLeV7oS-ajTLWDs46iADsYw@mail.gmail.com>
	<5519E5A9.7080104@optusnet.com.au>
	<CAE+ymrvvqL_o3ZTWdq96kQmMe6c3OzqM+SQN3qPpyH1dLMjmrw@mail.gmail.com>
	<551A0FF3.4070400@optusnet.com.au>
	<CAE+ymrt9gfCDEyNNz-b2gOS0NJt=pupm=t3HqbGosbKBC5wa7A@mail.gmail.com>
	<551C7D79.50906@optusnet.com.au>
	<loom.20150402T022922-646@post.gmane.org>
	<551CE5C9.6020600@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:36196 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215AbbDBS2W (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 2 Apr 2015 14:28:22 -0400
Received: by obbec2 with SMTP id ec2so140909400obb.3
        for <linux-can@vger.kernel.org>; Thu, 02 Apr 2015 11:28:19 -0700 (PDT)
In-Reply-To: <551CE5C9.6020600@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Dan Egnor <dan.egnor@gmail.com>, linux-can@vger.kernel.org

Hi Marc,

Thanks for your response!  Yes, even with better driver-level TX
buffer management, there can be eventually a point where the CAN
hardware TX buffer is full with low-priority messages.  One mitigation
for this is to provide a facility for querying the current tx_queue
usage of a SocketCAN interface so that a process chooses to only
submit "bulk" low-priority messages if the tx_queue fill state is less
than some low watermark.

Ironically, that brings us full-circle back to my original reason for
this thread, but we went off on a tangent in the meantime (partly my
fault!).  Querying the tx_queue usage has multiple benefits.  Is there
some way we can address that easier issue first?

Thanks,
Paarvai

On Wed, Apr 1, 2015 at 11:46 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 04/02/2015 02:33 AM, Dan Egnor wrote:
>> That seems surprisingly awful for something that's an established generic
>> interface for all CAN hardware on this operating system! No matter how many
>> mailboxes the controller might support, the operating system simply does not
>> support prioritized transmission.
>
> You have access to all queueing disc in linux, to prioritize your CAN
> frames until they are send via the CAN driver into the hardware. This is
> currently done in all drivers via a single TX queue. In default
> configuration (without a special queueing discipline), you have multiple
> FIFO from the userspace (the sockets) that are combined into a single
> FIFO (queueing disc + TX routine in driver +  hardward).
>
> However, if you need more control, fist make use of a queueing disc.
> Then, if you still suffer from prio inversion, we can have a look at
> your hardware. For now, all drivers, even those with multiple TX
> buffers, configure them into one large TX-FIFO. We can define and
> implement a new per interface option (or options, if needed) that
> switches the hardware between FIFO and priority based sending. This
> however is still a problem, if all your HW buffers are filled with low
> prio CAN frames before a high prio one has the change to be transferred
> into the hardware. This leads us to the implementation of multiple TX
> queues from the linux stack into the driver. This is manly used on big
> server Ethernet card, so that more than one processor can send packages.
> We have to check if a) we can attach a queueing disc to a TX queue and
> b) if these multiple TX queues are properly used on a single processor
> system.
>
> regards,
> Marc
>
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>
