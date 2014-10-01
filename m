From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH v5] can: flexcan: Re-write receive path to use MB queue instead of FIFO
Date: Wed, 01 Oct 2014 09:11:37 +0200
Message-ID: <1952804.jDdF5Ah5L9@ws-stein>
References: <1411995175-13540-1-git-send-email-david@protonic.nl> <2928841.hvxjaQ0ECy@ws-stein> <20141001082932.7f3d69d4@archvile>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:52228 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750868AbaJAHK5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Oct 2014 03:10:57 -0400
In-Reply-To: <20141001082932.7f3d69d4@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

On Wednesday 01 October 2014 08:29:32, David Jander wrote:
> On Tue, 30 Sep 2014 09:43:33 +0200
> Alexander Stein <alexander.stein@systec-electronic.com> wrote:
> 
> > Hello David,
> > 
> > On Tuesday 30 September 2014 09:13:55, David Jander wrote:
> > > > > Nevertheless, emptying the FIFO in the IRQ handler will still be a big
> > > > > improvement, since the only thing that could still kill the driver and
> > > > > cause message loss is interrupt latency, which normally should not be
> > > > > so high. NAPI scheduling latency is probably much worse, and this is
> > > > > the biggest issue with the current driver.
> > > > > 
> > > > > Any suggestion on what to do?
> > > > 
> > > > Get rid of NAPI and use RT-preempt with proper priorities :) But joke
> > > > aside, which workload does increase the NAPI latency so much, an overrun
> > > > occurs? I tested CAN bursts on i.MX35 without any loss.
> > > 
> > > I have seen overruns on an i.MX6 at only 250kbaud receiving back-to-back
> > > messages of 1 byte long. I usually test bursts of 10000 messages or more.
> > 
> > Mh, that's odd. I have run several tests a 1MBaud on an i.MX35 with 2 CAN
> > nodes attached each sending bursts of 250 message every 200ms with a total
> > message count of 250000 each. No overruns, losses or message misordering.
> 
> Do you have any other system-load? Have you tried something like flood-pinging
> the ethernet port at the same time?
> Your results sound very impressive. If messages are really sent back-to-back,
> then there's about 300 microseconds of permissible latency from interrupt to
> NAPI... how can you not get over that limit at least once?
> You are not running PREEMPT_RT, do you?

It has been a long time ago, but IIRC there was no load despite CAN reception (!), no messages were sent. I'm not sure if I ever ran this test on that i.MX35 without PREEMPT_RT. Currently I don't have access to this hardware, so I cannot use it on a non-rt kernel.

> > > Things get a lot worse if you also happen to have kernel messages output
> > > to a serial console and plug in an USB device (because there are printk's
> > > in the EHCI driver inside spin locks with interrupts disabled!!), but
> > > that's a different story.
> > 
> > Eek. Well, adding quiet to the command line avoids that. IIRC there is even
> > a Kconfig option to disable that announce to kernel log.
> 
> Yes, I know, but what should one expect on a non-RT system, with all sorts of
> drivers (SPI, I2C, NAND, SDHCI, Ethernet,...) doing their work?

Sure, each subsystem will add latency. I don't say your intention is wrong.

BTW: You posted a patch for at91_can in June (Din't get opportunity to try it yet), where you use a kfifo to accomplish the same, why not here?

Best regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
Am Windrad 2
08468 Heinsdorfergrund
Tel.: 03765 38600-1156
Fax: 03765 38600-4100
Email: alexander.stein@systec-electronic.com
Website: www.systec-electronic.com
 
Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Chemnitz, HRB 28082

