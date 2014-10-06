From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [RESEND] [PATCH] net: CAN: at91_can.c: decrease likelyhood of RX overruns
Date: Mon, 06 Oct 2014 13:21:22 +0200
Message-ID: <2417882.RxeThGvgsF@ws-stein>
References: <1403775686-19352-1-git-send-email-david@protonic.nl> <5282990.80afdvE4aW@ws-stein> <20141006112644.672440b2@archvile>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:52195 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751289AbaJFLUg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 6 Oct 2014 07:20:36 -0400
In-Reply-To: <20141006112644.672440b2@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Oliver Hartkopp <socketcan@hartkopp.net>, "Hans J. Koch" <hjk@hansjkoch.de>

On Monday 06 October 2014 11:26:44, David Jander wrote:
> Alexander Stein <alexander.stein@systec-electronic.com> wrote:
> 
> > Hello David,
> > 
> > On Friday 03 October 2014 11:01:41, David Jander wrote:
> > > On Thu, 02 Oct 2014 14:41:25 +0200
> > > Alexander Stein <alexander.stein@systec-electronic.com> wrote:
> > > 
> > > > finally I got the chance to test your patch. I originally expected to
> > > > test it on a AT91SAM9263, but I did it now on a AT91SAM9X35. The tests
> > > > were done on a v3.17-rc7 kernel + a DT patch. If I only run my CAN burst
> > > > test without any other load on the ARM everything works fine, on the
> > > > unpatched kernel, with your patch and also with rx-fifo branch of
> > > > https://gitorious.org/linux-can/linux-can-next. When running an iperf
> > > > (client on PC) in parallel, the situation is as follows: unpatched
> > > > kernel: driver hangs after ~15s. No messages are received again while
> > > > the kernel is still running. your patch: 37346 of 500000 msg lost
> > > > rx-fifo: 36806 of 500000 msg lost
> > > 
> > > Thanks a lot for taking the time to look at this.
> > > I just looked at the rx-fifo patch, but I still don't understand how it is
> > > supposed to improve the situation of this driver.... beats me.
> > > Nevertheless you just proved that it is at least as good as my patch.
> > > AFAIK, there is nothing that should work as well as off-loading the CAN
> > > controller in the IRQ handler by a far margin. But the rx-fifo patch does
> > > not do that, so it is hard for me to believe it is really that good.
> > > Could you repeat your test at a lower bitrate? The only thing I can think
> > > of is that 37000 out of 500000 messages the latency has spiked on your
> > > system, but that spike should be a lot more contained with my patch than
> > > with rx-fifo, so if I'm right, then lowering the bitrate we might see a
> > > situation in which rx-fifo still loses a message here and there, while my
> > > patch doesn't. Other than that, I am tempted to think my patch is simply
> > > broken.
> > 
> > Ok, here is another test run (including iperf) at 250kBit/s. Did all tests 3
> > times. plain:      0, 2, lockup
> > your patch: 0, 0, 0
> > rx-fifo:   26, 0, 43
> 
> Ok, this confirms what I suspected... latency-peaks are more contained when
> emptying the CAN controller in the interrupt handler.
> 
> > When the plain driver lockups I see those kernel messages:
> > at91_can f8004000.can can0: order of incoming frames cannot be guaranteed
> > 
> > And the same with 500kBit/s:
> > plain:      0, 0, lockup
> > your patch: 0, 0, 0
> > rx-fifo:    0, 0, 0
> 
> This is weird. Either you were lucky, your embedded devices aren't able to
> send back-to-back at that rate specifically, or the situation regarding load
> and latency spikes changed somehow. The results don't make sense to me.

Well, I guess this will change if I would run more than 3 times, but as overruns already occured at 250kBit/s there _is_ still a problem in rx-fifo, independently from 1MBit/s drops due to heavy load.

> One interesting control-metric would be to monitor the amount of
> messages/second your test-devices are able to generate.

I just noticed that this testing hardware has a DDR2 with only 16bit interface. I think this will also reduce performance considerably.
The embedded device send ~1000 CAN frames/s, each which is an average busload of 20%, but in burst time, it should be 100%.

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

