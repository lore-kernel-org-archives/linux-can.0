From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: CAN question: how to trace frame errors?
Date: Sun, 14 Jun 2015 01:30:11 +1000
Message-ID: <557C4C83.3020501@optusnet.com.au>
References: <CAOpc7mFv6ePXqkCZxRkCOC+BuY-PC14nAopZyFpEKHvj5gN_tw@mail.gmail.com>	<557AA7BE.6040004@pengutronix.de>	<CAOpc7mH-xD+eesJNjhpFwUSeMwGCdsRK8Q9AZSjmE2uw=cBgsw@mail.gmail.com>	<557AD18D.8010807@optusnet.com.au> <CAOpc7mG5nD1daKSkGdqoR84=W_A11s+oQfzc_i4pUsHoVd42Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:45644 "EHLO
	mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751057AbbFMPaS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 13 Jun 2015 11:30:18 -0400
In-Reply-To: <CAOpc7mG5nD1daKSkGdqoR84=W_A11s+oQfzc_i4pUsHoVd42Tw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Holger Schurig <holgerschurig@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 13/06/2015 12:24 AM, Holger Schurig wrote:
> Thanks for the thorought answer.
>
>> so I rewrote the 3.4 FlexCAN driver to unload the FIFO into a ring buffer
>> during interrupts and to have the NAPI routine unload tha
>
> Can you publish it?

This is Open Source, so yes.

> I might mangle it into a form so that I can sent
> it as a patch to Linux HEAD (and use it by myself, LOL)

I have sent the patch to flexcan.c in kernel 3.4 to Holger. It is a 
fairly obvious modification with the buffer-reading code moved to the 
interrupt routine, loading up a ring buffer.

>> Since the CPU is running at 800MHz, that's only 560,000 instructions
>
> I'm running with 1 GHz, but that's still not stellar. I think I'll
> look into the things you mentioned (e.g. I'm using the framebuffer
> from staging, CONFIG_FRM_IMX, but I don't have the debug things
> enabled you mentioned).

The CPU is seriously busy. It is very busy doing things in the order it 
(and all the programmers who wrote it) think is appropriate, but it 
isn't doing what we need to get the job done.

Changing the driver is a "bandage" fixing the first annoying symptom of 
the underlying problem. I found the problem in our case (the 
CONFIG_DEBUG stuff mainly), but put in the driver changes as well as I 
wanted it to stay fixed in the face of kernel changes.

Another thing I changed. CPUs have had multiple interrupt priorities 
(with interrupts being able to interrupt other ones) all the way back to 
the PDP11, then carried through the 68000 and ColdFire chips. But not in 
Linux on ARM on these chips (at least TZIC in i.MX53 in 3.4). There's 
only a single level of interrupt, and while the CPU supports different 
interrupt priorities, the 3.4 TZIC code simply doesn't provide the 
functions to change it. As a result the interrupt priority is that 
implemented by tzic_handle_irq(), which is to take the first-one-set in 
HIPND registers 0 to 3, in that order. In the i.MX53 that puts the FEC 
interrupt ahead of the CAN ones. I think it puts about 74 interrupts 
ahead of the CAN ones. So I added code to allow the interrupt priorities 
to be changed so as to reverse that.

Tom

