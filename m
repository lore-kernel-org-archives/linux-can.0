From: David Jander <david@protonic.nl>
Subject: Re: [PATCH v5] can: flexcan: Re-write receive path to use MB queue
 instead of FIFO
Date: Wed, 1 Oct 2014 08:29:32 +0200
Message-ID: <20141001082932.7f3d69d4@archvile>
References: <1411995175-13540-1-git-send-email-david@protonic.nl>
	<5017123.OgYMn6dde4@ws-stein>
	<20140930091355.770fac72@archvile>
	<2928841.hvxjaQ0ECy@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:10215 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbaJAG33 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Oct 2014 02:29:29 -0400
In-Reply-To: <2928841.hvxjaQ0ECy@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org


Dear Alexander,

On Tue, 30 Sep 2014 09:43:33 +0200
Alexander Stein <alexander.stein@systec-electronic.com> wrote:

> Hello David,
> 
> On Tuesday 30 September 2014 09:13:55, David Jander wrote:
> > > > Nevertheless, emptying the FIFO in the IRQ handler will still be a big
> > > > improvement, since the only thing that could still kill the driver and
> > > > cause message loss is interrupt latency, which normally should not be
> > > > so high. NAPI scheduling latency is probably much worse, and this is
> > > > the biggest issue with the current driver.
> > > > 
> > > > Any suggestion on what to do?
> > > 
> > > Get rid of NAPI and use RT-preempt with proper priorities :) But joke
> > > aside, which workload does increase the NAPI latency so much, an overrun
> > > occurs? I tested CAN bursts on i.MX35 without any loss.
> > 
> > I have seen overruns on an i.MX6 at only 250kbaud receiving back-to-back
> > messages of 1 byte long. I usually test bursts of 10000 messages or more.
> 
> Mh, that's odd. I have run several tests a 1MBaud on an i.MX35 with 2 CAN
> nodes attached each sending bursts of 250 message every 200ms with a total
> message count of 250000 each. No overruns, losses or message misordering.

Do you have any other system-load? Have you tried something like flood-pinging
the ethernet port at the same time?
Your results sound very impressive. If messages are really sent back-to-back,
then there's about 300 microseconds of permissible latency from interrupt to
NAPI... how can you not get over that limit at least once?
You are not running PREEMPT_RT, do you?

> > Things get a lot worse if you also happen to have kernel messages output
> > to a serial console and plug in an USB device (because there are printk's
> > in the EHCI driver inside spin locks with interrupts disabled!!), but
> > that's a different story.
> 
> Eek. Well, adding quiet to the command line avoids that. IIRC there is even
> a Kconfig option to disable that announce to kernel log.

Yes, I know, but what should one expect on a non-RT system, with all sorts of
drivers (SPI, I2C, NAND, SDHCI, Ethernet,...) doing their work?

> Best regards,
> Alexander

Best regards,

-- 
David Jander
Protonic Holland.
