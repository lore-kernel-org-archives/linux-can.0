From: Torsten Lang <torsten.lang@uweschneider.de>
Subject: Re: can: flexcan: implement workaround for FIFO overruns (based on
 code by David Jander)
Date: Thu, 09 Jul 2015 12:03:44 +0200
Message-ID: <559E4700.2080109@uweschneider.de>
References: <559D35CA.2050402@uweschneider.de>	<2576741.YrBIndJIHB@ws-stein>	<CAOpc7mEc+kr=Es34772fcTnsQpJsaCaoVOx67AhfRjxucPhAhw@mail.gmail.com>	<3634451.aFQ5B85Yzk@ws-stein> <CAOpc7mG52ni5ESuijv1qVLpMznZXSxxU8gmkhjGqtKZfXuxUNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from groat.dascon.de ([195.225.198.185]:52892 "EHLO groat.dascon.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750893AbbGIKEF (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 9 Jul 2015 06:04:05 -0400
In-Reply-To: <CAOpc7mG52ni5ESuijv1qVLpMznZXSxxU8gmkhjGqtKZfXuxUNQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Holger Schurig <holgerschurig@gmail.com>, Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

Am 09.07.2015 um 09:59 schrieb Holger Schurig:
>> The early parts (ColdFire) have 16 buffers, didn't have "Message Queueing" or the FIFO, so aren't supported by Linux at all.
> Fine, so we can ignore them :-)
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
Same for our customer's project. I first noticed when data was missing in the logs our application writes.
> BTW, with the current in-tree FlexCAN drivers we have two things were
> IRQ or scheduling latency can cause lost frames:
>
> * the time from the hardware IRQ until flexcan_isr() is actually
> called, e.g. because for spin_lock_irqsave
> * the time when the ISR does a napi_schedule() until NAPI get's
> scheduled and calls flexcan_poll()
I'm not sure yet which latencies allocating and feeding the SKBs introduces, but I think NAPI could help when splitting up the mailbox handling where in the interrupt just the mailboxes are pushed into an internal queue of the driver and then fed into the network stack in the NAPI.
> For the first latency, only FTRACE and fixing the other kernel parts
> helps. Unfortunately, some kernel parts are so complex that it is
> over-the-head of many people (ok, I confess: over my head).
Same for me. I'm not the one to fix the basics of the TZIC code.
> I killed the second latency with my kfifo patch that I posted the
> other day. Getting rid of NAPI completely would also be a method, I'm
> not sure NAPI wins us anything, compared to Ethernet CAN is slow.

