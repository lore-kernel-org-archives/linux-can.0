From: David Jander <david@protonic.nl>
Subject: Re: [RESEND] [PATCH] net: CAN: at91_can.c: decrease likelyhood of
 RX overruns
Date: Mon, 6 Oct 2014 13:39:42 +0200
Message-ID: <20141006133942.0f1c820b@archvile>
References: <1403775686-19352-1-git-send-email-david@protonic.nl>
	<5282990.80afdvE4aW@ws-stein>
	<20141006112644.672440b2@archvile>
	<2417882.RxeThGvgsF@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:28864 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbaJFLje (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 6 Oct 2014 07:39:34 -0400
In-Reply-To: <2417882.RxeThGvgsF@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Oliver Hartkopp <socketcan@hartkopp.net>, "Hans J. Koch" <hjk@hansjkoch.de>

On Mon, 06 Oct 2014 13:21:22 +0200
Alexander Stein <alexander.stein@systec-electronic.com> wrote:

> On Monday 06 October 2014 11:26:44, David Jander wrote:
> > Alexander Stein <alexander.stein@systec-electronic.com> wrote:
> > 
> > > Hello David,
> > > 
> > > On Friday 03 October 2014 11:01:41, David Jander wrote:
> > > > On Thu, 02 Oct 2014 14:41:25 +0200
> > > > Alexander Stein <alexander.stein@systec-electronic.com> wrote:
> > > > 
> > > > > finally I got the chance to test your patch. I originally expected to
> > > > > test it on a AT91SAM9263, but I did it now on a AT91SAM9X35. The
> > > > > tests were done on a v3.17-rc7 kernel + a DT patch. If I only run my
> > > > > CAN burst test without any other load on the ARM everything works
> > > > > fine, on the unpatched kernel, with your patch and also with rx-fifo
> > > > > branch of https://gitorious.org/linux-can/linux-can-next. When
> > > > > running an iperf (client on PC) in parallel, the situation is as
> > > > > follows: unpatched kernel: driver hangs after ~15s. No messages are
> > > > > received again while the kernel is still running. your patch: 37346
> > > > > of 500000 msg lost rx-fifo: 36806 of 500000 msg lost
> > > > 
> > > > Thanks a lot for taking the time to look at this.
> > > > I just looked at the rx-fifo patch, but I still don't understand how
> > > > it is supposed to improve the situation of this driver.... beats me.
> > > > Nevertheless you just proved that it is at least as good as my patch.
> > > > AFAIK, there is nothing that should work as well as off-loading the CAN
> > > > controller in the IRQ handler by a far margin. But the rx-fifo patch
> > > > does not do that, so it is hard for me to believe it is really that
> > > > good. Could you repeat your test at a lower bitrate? The only thing I
> > > > can think of is that 37000 out of 500000 messages the latency has
> > > > spiked on your system, but that spike should be a lot more contained
> > > > with my patch than with rx-fifo, so if I'm right, then lowering the
> > > > bitrate we might see a situation in which rx-fifo still loses a
> > > > message here and there, while my patch doesn't. Other than that, I am
> > > > tempted to think my patch is simply broken.
> > > 
> > > Ok, here is another test run (including iperf) at 250kBit/s. Did all
> > > tests 3 times. plain:      0, 2, lockup
> > > your patch: 0, 0, 0
> > > rx-fifo:   26, 0, 43
> > 
> > Ok, this confirms what I suspected... latency-peaks are more contained when
> > emptying the CAN controller in the interrupt handler.
> > 
> > > When the plain driver lockups I see those kernel messages:
> > > at91_can f8004000.can can0: order of incoming frames cannot be guaranteed
> > > 
> > > And the same with 500kBit/s:
> > > plain:      0, 0, lockup
> > > your patch: 0, 0, 0
> > > rx-fifo:    0, 0, 0
> > 
> > This is weird. Either you were lucky, your embedded devices aren't able to
> > send back-to-back at that rate specifically, or the situation regarding
> > load and latency spikes changed somehow. The results don't make sense to
> > me.
> 
> Well, I guess this will change if I would run more than 3 times, but as
> overruns already occured at 250kBit/s there _is_ still a problem in rx-fifo,
> independently from 1MBit/s drops due to heavy load.

Well, I now think that rx-fifo was never intended to improve the driver
performance (correct me if I'm wrong, Marc), but only to build a common
subsystem around the same concept that seems to be re-invented in at91_can,
flexcan and ti_hecc. It does fix the lockup-bug in at91_can though.

> > One interesting control-metric would be to monitor the amount of
> > messages/second your test-devices are able to generate.
> 
> I just noticed that this testing hardware has a DDR2 with only 16bit
> interface. I think this will also reduce performance considerably. The

16-bit DDR2 (even at its lowest clock of 200MHz) is not exactly slow... why do
you think that could be a bottleneck?

> embedded device send ~1000 CAN frames/s, each which is an average busload of
> 20%, but in burst time, it should be 100%.

You mean the bursts of 250 messages you talked about earlier should produce a
bus load of 100%? I think it is important to get some certainty about what's
really going on on the bus, specially if we see things we cannot explain. You
don't have access to a PC with a CAN interface or an oscilloscope, do you?

Best regards,

-- 
David Jander
Protonic Holland.
