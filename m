From: Torsten Lang <torsten.lang@uweschneider.de>
Subject: Re: can: flexcan: implement workaround for FIFO overruns (based on
 code by David Jander)
Date: Wed, 22 Jul 2015 10:00:29 +0200
Message-ID: <55AF4D9D.8040904@uweschneider.de>
References: <559D35CA.2050402@uweschneider.de>	<2576741.YrBIndJIHB@ws-stein>	<CAOpc7mEc+kr=Es34772fcTnsQpJsaCaoVOx67AhfRjxucPhAhw@mail.gmail.com>	<3634451.aFQ5B85Yzk@ws-stein> <CAOpc7mG52ni5ESuijv1qVLpMznZXSxxU8gmkhjGqtKZfXuxUNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from groat.dascon.de ([195.225.198.185]:51425 "EHLO groat.dascon.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933092AbbGVIBI (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 22 Jul 2015 04:01:08 -0400
In-Reply-To: <CAOpc7mG52ni5ESuijv1qVLpMznZXSxxU8gmkhjGqtKZfXuxUNQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
Cc: Holger Schurig <holgerschurig@gmail.com>, Alexander Stein <alexander.stein@systec-electronic.com>, linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

Am 09.07.2015 um 09:59 schrieb Holger Schurig:
>> The early parts (ColdFire) have 16 buffers, didn't have "Message Queueing" or the FIFO, so aren't supported by Linux at all.
> Fine, so we can ignore them :-)
That would be one more reason to at least have an option for working without the hardware FIFO.
>
>> Is it "normal" to have interrupts locked out for more than 300us (six 50us CAN messages at 1MHz)?
> Unfortunately yes.  My $CUSTOMER had overruns with 500 kB/s, 80% bus
> load, and CAN messages with 3 bytes of data. My guess this was mostly
> due to the sucky SDHCI (eMMC) driver code in Linux. I fixed that, but
> occassionally ftrace still shows large times with irqsoff, I need to
> dig into them as well. Still /me thinks that an RxFIFO of just 6 CAN
> messages isn't swell for an OS that is known to not guarantee response
> times, like Linux. Especially not for CAN, people use it after all
> because of it's reliability guarantees.
I've done some tests with FTRACE, same result. The trace results show that the SDHCI driver executes long sequences of code under spinlock_irqsave. As far as I can see from the trace, sdhci_do_set_ios first locks the interrupts, then activates the clock, does the operation and deactivates the clock again. The actual busy looping appears in the IMX SD/MMC driver which is waiting after every clock change. Turning off CONFIG_MMC_CLKGATE doesn't help here. Even when these busy waits would be avoided there still would be ~100us of operations under spinlock_irqsave.
>
> BTW, with the current in-tree FlexCAN drivers we have two things were
> IRQ or scheduling latency can cause lost frames:
>
> * the time from the hardware IRQ until flexcan_isr() is actually
> called, e.g. because for spin_lock_irqsave
> * the time when the ISR does a napi_schedule() until NAPI get's
> scheduled and calls flexcan_poll()
>
> For the first latency, only FTRACE and fixing the other kernel parts
> helps. Unfortunately, some kernel parts are so complex that it is
> over-the-head of many people (ok, I confess: over my head).
>
> I killed the second latency with my kfifo patch that I posted the
> other day. Getting rid of NAPI completely would also be a method, I'm
> not sure NAPI wins us anything, compared to Ethernet CAN is slow.

