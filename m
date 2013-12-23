From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: [PATCH] genirq: Sanitize spurious interrupt detection of threaded irqs
Date: Mon, 23 Dec 2013 11:25:24 -0800
Message-ID: <CANGgnMbszHzYe9pF2C6wag4MY_PfBG2qrMCC=rMmQnb-jyXXXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:33771 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752907Ab3LWTZZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 23 Dec 2013 14:25:25 -0500
Received: by mail-ig0-f180.google.com with SMTP id uq1so13935348igb.1
        for <linux-can@vger.kernel.org>; Mon, 23 Dec 2013 11:25:24 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Hi Thomas,

Did anything happen with your patch to note_interrupt, originally
posted on May 8th of 2013?  (https://lkml.org/lkml/2013/3/7/222)

I am seeing an issue on a machine right now running a
config-preempt-rt kernel and a SJA1000 CAN card from PEAK.  It works
for ~1 day, and then proceeds to die with a "Disabling IRQ #18"
message.  I posted on the Linux CAN mailing list, and Oliver Hartkopp
was able to reproduce the issue only on a realtime kernel.  A function
trace ending when the IRQ was disabled shows that note_interrupt is
being called regularly from the IRQ handler threads, and one of the
threads is doing work (and therefore calling note_interrupt with
IRQ_HANDLED).

Oliver Hartkopp and I ran tests over the weekend on numerous machines
and verified that the patch that you proposed fixes the problem.  We
think that the race condition that Till reported is causing the
problem here.

In reply to the comment about using the upper bit of
threads_handled_last for holding the SPURIOUS_DEFERRED flag, while
that may still be an over-optimization, the code should still work.
All comparisons are done with the bit set, which just makes it a 31
bit counter.  It will take 8 more days for the counter to overflow on
my machine, so I won't know for certain until then.

My only concern is that there may still be a small race condition with
this new code.  If the interrupt handler thread is running at a
realtime priority, but lower than another task, it may not get run
until a large number of IRQs get triggered, and then process them
quickly.  With your new handler code, this would be counted as one
single handled interrupt.  With the current constants, this is only a
problem if more than 1000 calls to the handler happen between IRQs.  I
starved my card's irq threads by running 4 tasks at a higher realtime
priority than the handler threads, and saw the number of unhandled
IRQs jump from 1/100000 to 3/100000, so that problem may not show up
in practice.

Austin Schuh

Tested-by: Austin Schuh <austin@peloton-tech.com>
