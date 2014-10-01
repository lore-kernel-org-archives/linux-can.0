From: David Jander <david@protonic.nl>
Subject: Re: [PATCH v5] can: flexcan: Re-write receive path to use MB queue
 instead of FIFO
Date: Wed, 1 Oct 2014 11:19:39 +0200
Message-ID: <20141001111939.163edc61@archvile>
References: <1411995175-13540-1-git-send-email-david@protonic.nl>
	<2928841.hvxjaQ0ECy@ws-stein>
	<20141001082932.7f3d69d4@archvile>
	<1952804.jDdF5Ah5L9@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:10783 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbaJAJTf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Oct 2014 05:19:35 -0400
In-Reply-To: <1952804.jDdF5Ah5L9@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

On Wed, 01 Oct 2014 09:11:37 +0200
Alexander Stein <alexander.stein@systec-electronic.com> wrote:

> On Wednesday 01 October 2014 08:29:32, David Jander wrote:
> > On Tue, 30 Sep 2014 09:43:33 +0200
> > Alexander Stein <alexander.stein@systec-electronic.com> wrote:
> > 
> > > Hello David,
> > > 
> > > On Tuesday 30 September 2014 09:13:55, David Jander wrote:
> > > > > > Nevertheless, emptying the FIFO in the IRQ handler will still be a
> > > > > > big improvement, since the only thing that could still kill the
> > > > > > driver and cause message loss is interrupt latency, which normally
> > > > > > should not be so high. NAPI scheduling latency is probably much
> > > > > > worse, and this is the biggest issue with the current driver.
> > > > > > 
> > > > > > Any suggestion on what to do?
> > > > > 
> > > > > Get rid of NAPI and use RT-preempt with proper priorities :) But joke
> > > > > aside, which workload does increase the NAPI latency so much, an
> > > > > overrun occurs? I tested CAN bursts on i.MX35 without any loss.
> > > > 
> > > > I have seen overruns on an i.MX6 at only 250kbaud receiving
> > > > back-to-back messages of 1 byte long. I usually test bursts of 10000
> > > > messages or more.
> > > 
> > > Mh, that's odd. I have run several tests a 1MBaud on an i.MX35 with 2 CAN
> > > nodes attached each sending bursts of 250 message every 200ms with a
> > > total message count of 250000 each. No overruns, losses or message
> > > misordering.
> > 
> > Do you have any other system-load? Have you tried something like
> > flood-pinging the ethernet port at the same time?
> > Your results sound very impressive. If messages are really sent
> > back-to-back, then there's about 300 microseconds of permissible latency
> > from interrupt to NAPI... how can you not get over that limit at least
> > once? You are not running PREEMPT_RT, do you?
> 
> It has been a long time ago, but IIRC there was no load despite CAN
> reception (!), no messages were sent. I'm not sure if I ever ran this test
> on that i.MX35 without PREEMPT_RT. Currently I don't have access to this
> hardware, so I cannot use it on a non-rt kernel.

It would be very interesting to see how it performs on a non-RT kernel under
load. In my experience flood-pinging, USB traffic and some CPU-bound load
(benchmark or similar) are interesting attacks to try each on its own or in
combination while the CAN test runs.
On the CAN side, I'd recommend long bursts (10000) of short back-to-back
messages (DLC=1) at a sensible baudrate (250kbaud, 500kbaud and 1Mbaud).
I used a Peak USB-CAN dongle on my PC to generate messages with can-utils
cangen. On the target candump to a log-file and a python script to analyze the
log-file for packet-ordering and -count, and a scope to make sure there is no
space between messages.

[...]

Best regards,

-- 
David Jander
Protonic Holland.
