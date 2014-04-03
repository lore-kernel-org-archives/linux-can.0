From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] c_can: Add support for eg20t (pch_can)
Date: Thu, 3 Apr 2014 22:59:53 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1404032228351.14882@ionos.tec.linutronix.de>
References: <1396534451-9654-1-git-send-email-alexander.stein@systec-electronic.com> <533D774C.4050703@pengutronix.de> <alpine.DEB.2.02.1404031703120.14882@ionos.tec.linutronix.de> <1497730.QLQMESBtqQ@ws-stein> <533DB663.3030408@hartkopp.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:34781 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753566AbaDCU7m (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Apr 2014 16:59:42 -0400
In-Reply-To: <533DB663.3030408@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Oliver,

On Thu, 3 Apr 2014, Oliver Hartkopp wrote:

> Hello Alexander,
> 
> one of the differences of the SMP patch from Thomas
> 
> 	http://marc.info/?l=linux-can&m=139638860032202&w=2
> 
> and your patch
> 
> 	http://marc.info/?l=linux-can&m=139403248814172&w=2
> 
> is that you introduced a
> 
> 	spin_lock_irqsave(&priv->lock, flags);
> 
> additionally to the usage of the two different message interfaces.
> 
> Could this probably help to fix the concurrent access?

The spinlock does not help. There is no concurrent access from two
cpus in the RX path. I can prove the issue with an UP machine on
mainline.

The spinlock in the TX path is a different issue. That one is
necessary on SMP and RT.

What happens is:

RX Packet 1 --> message buffer 1 (newdat bit is not cleared)
RX Packet 2 --> message buffer 2 (newdat bit is not cleared)
RX Packet 3 --> message buffer 3 (newdat bit is not cleared)
RX Packet 4 --> message buffer 4 (newdat bit is not cleared)
RX Packet 5 --> message buffer 5 (newdat bit is not cleared)
RX Packet 6 --> message buffer 6 (newdat bit is not cleared)
RX Packet 7 --> message buffer 7 (newdat bit is not cleared)
RX Packet 8 --> message buffer 8 (newdat bit is not cleared)

Clear newdat bit in message buffer 1
Clear newdat bit in message buffer 2
Clear newdat bit in message buffer 3
Clear newdat bit in message buffer 4
Clear newdat bit in message buffer 5
Clear newdat bit in message buffer 6
Clear newdat bit in message buffer 7
Clear newdat bit in message buffer 8

Now if during that clearing of newdat bits, a new message comes in,
the HW gets confused and drops it. 

It does not matter how many of them you clear. I put a delay between
clear of buffer 1 and buffer 2 which was long enough that the message
should have been queued either in buffer 1 or buffer 9. But it did not
show up anywhere. The next message ended up in buffer 1. So the
hardware lost a packet of course without telling it via one of the
error handlers.

That does not happen on all clear newdat bit events. I see one of 10k
packets dropped in the scenario which allows us to reproduce. But the
trace looks always the same.

Now with the hack patch which kills the RX FIFO split we use the HW as
it was probably designed for. We read from the buffer 1 upwards and
clear the buffer as we get the message. That's how all
microcontrollers use it. So I assume that the way we handle the
buffers was never really tested. According to the public documentation
it should just work :)

If someone with access to the VHDL code could look into that, we might
get an hint how to work around that.

Interestingly enough TI has implemented a 3rd message control
interface which is for RX only. It allows the hardware to transfer a
new message right away to the interface and issue a DMA request which
then DMAs all of the message content into RAM. I'm inclined to use
that as the workaround and ditch the FIFO for that case
completely. The DMA transfer allows to use a single message object, so
we wont see any of that assumed that the mechanism works as advertised.

But of course that's not a generic solution.

Another idea is to read out the message buffers in hard interrupt
context, i.e. leave the RX interrupt enabled all the time and store
the packets in some private data structure and let NAPI drain that
into skbs. Kinda sucks though.

Thanks,

	tglx

