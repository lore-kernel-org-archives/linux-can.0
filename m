From: Holger Schurig <holgerschurig@gmail.com>
Subject: Re: can: flexcan: implement workaround for FIFO overruns (based on
 code by David Jander)
Date: Thu, 9 Jul 2015 09:59:26 +0200
Message-ID: <CAOpc7mG52ni5ESuijv1qVLpMznZXSxxU8gmkhjGqtKZfXuxUNQ@mail.gmail.com>
References: <559D35CA.2050402@uweschneider.de>
	<2576741.YrBIndJIHB@ws-stein>
	<CAOpc7mEc+kr=Es34772fcTnsQpJsaCaoVOx67AhfRjxucPhAhw@mail.gmail.com>
	<3634451.aFQ5B85Yzk@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34763 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbbGIH72 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Jul 2015 03:59:28 -0400
Received: by wifm2 with SMTP id m2so10483124wif.1
        for <linux-can@vger.kernel.org>; Thu, 09 Jul 2015 00:59:26 -0700 (PDT)
In-Reply-To: <3634451.aFQ5B85Yzk@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Torsten Lang <torsten.lang@uweschneider.de>, linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

> The early parts (ColdFire) have 16 buffers, didn't have "Message Queueing" or the FIFO, so aren't supported by Linux at all.

Fine, so we can ignore them :-)

> Is it "normal" to have interrupts locked out for more than 300us (six 50us CAN messages at 1MHz)?

Unfortunately yes.  My $CUSTOMER had overruns with 500 kB/s, 80% bus
load, and CAN messages with 3 bytes of data. My guess this was mostly
due to the sucky SDHCI (eMMC) driver code in Linux. I fixed that, but
occassionally ftrace still shows large times with irqsoff, I need to
dig into them as well. Still /me thinks that an RxFIFO of just 6 CAN
messages isn't swell for an OS that is known to not guarantee response
times, like Linux. Especially not for CAN, people use it after all
because of it's reliability guarantees.

BTW, with the current in-tree FlexCAN drivers we have two things were
IRQ or scheduling latency can cause lost frames:

* the time from the hardware IRQ until flexcan_isr() is actually
called, e.g. because for spin_lock_irqsave
* the time when the ISR does a napi_schedule() until NAPI get's
scheduled and calls flexcan_poll()

For the first latency, only FTRACE and fixing the other kernel parts
helps. Unfortunately, some kernel parts are so complex that it is
over-the-head of many people (ok, I confess: over my head).

I killed the second latency with my kfifo patch that I posted the
other day. Getting rid of NAPI completely would also be a method, I'm
not sure NAPI wins us anything, compared to Ethernet CAN is slow.
