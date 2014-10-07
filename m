From: David Jander <david@protonic.nl>
Subject: Re: [RESEND] [PATCH] net: CAN: at91_can.c: decrease likelyhood of
 RX overruns
Date: Tue, 7 Oct 2014 10:31:48 +0200
Message-ID: <20141007103148.5404a4cd@archvile>
References: <1403775686-19352-1-git-send-email-david@protonic.nl>
	<2417882.RxeThGvgsF@ws-stein>
	<20141006133942.0f1c820b@archvile>
	<3545685.3jS4Whu5tJ@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:6811 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758AbaJGIbj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 7 Oct 2014 04:31:39 -0400
In-Reply-To: <3545685.3jS4Whu5tJ@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Oliver Hartkopp <socketcan@hartkopp.net>, "Hans J. Koch" <hjk@hansjkoch.de>

On Mon, 06 Oct 2014 16:14:05 +0200
Alexander Stein <alexander.stein@systec-electronic.com> wrote:

> On Monday 06 October 2014 13:39:42, David Jander wrote:
> > > > One interesting control-metric would be to monitor the amount of
> > > > messages/second your test-devices are able to generate.
> > > 
> > > I just noticed that this testing hardware has a DDR2 with only 16bit
> > > interface. I think this will also reduce performance considerably. The
> > 
> > 16-bit DDR2 (even at its lowest clock of 200MHz) is not exactly slow...
> > why do you think that could be a bottleneck?
> 
> It's a 133MHz clock, so 266MHz effective.

Sorry, my fault. The lowest permitted DDR2 clock is 125MHz.

> I had done similar tests with i.MX28-EVK which also has only a 16-bit DDR
> interface. The rusults were horrible. Even without that ethernet bug... 

Horrible seems a bit of a stretch... I have an i.MX28 board on my desk (with
16-bit 200MHz DDR2), which is capable of spewing out 12200 messages per second
at 1Mbaud when idle. The theoretical maximum bus load (DLC=1) would be around
20000 messages per second, so at least I am able to keep up with the bandwidth
corresponding to a 500kbaud bus at 100% load.
From my PC (with a Peak USB CAN dongle) I can send only 5200 messages per
second (and this is a Core-i7 with 128bit DDR3 memory interface clocked at
800MHz ;-), so if the interfaces from SYS-Tec are significantly better than
that we might have a deal... ;-)

> Now, doing the same tests (also CPU and Memory) again, it is worse than a
> AT91SAM9G20 with 32-bit SDR RAM, which also has 400 MHz. I expected both
> would be equally. If you're correct and the RAM is not the bottleneck it
> seems that the cache (16kByte each, 32kByte on AT91SAM9G20) would be it.

The i.MX28 and the AT91SAM9 have totally different CAN controllers to start
with, so it is more like comparing apples with oranges I guess.

> > > embedded device send ~1000 CAN frames/s, each which is an average
> > > busload of 20%, but in burst time, it should be 100%.
> > 
> > You mean the bursts of 250 messages you talked about earlier should
> > produce a bus load of 100%? I think it is important to get some certainty
> > about what's really going on on the bus, specially if we see things we
> > cannot explain. You don't have access to a PC with a CAN interface or an
> > oscilloscope, do you?
> 
> My PC has our USB-CAN-Modules attached (single or dual channel), so what do
> you want to see? a candump log? My access to oscilloscopes rather limited
> and not reliable.

You can try this (which is what I do):

$ time cangen -g 0 -I 123 -L 1 -D i -p 2 -n 10000 can0

If you tx-queue is smallish compared to the 10000 messages sent, then the
"real" time reported by "time" will correspond approximately to the amount of
time it took to actually transmit 10000 messages.

Best regards,

-- 
David Jander
Protonic Holland.
