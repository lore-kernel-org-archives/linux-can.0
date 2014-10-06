From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [RESEND] [PATCH] net: CAN: at91_can.c: decrease likelyhood of RX overruns
Date: Mon, 06 Oct 2014 10:52:05 +0200
Message-ID: <5282990.80afdvE4aW@ws-stein>
References: <1403775686-19352-1-git-send-email-david@protonic.nl> <1547907.ZK2VXCpURP@ws-stein> <20141003110141.0ba3c33d@archvile>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:48591 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751289AbaJFIvT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 6 Oct 2014 04:51:19 -0400
In-Reply-To: <20141003110141.0ba3c33d@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Oliver Hartkopp <socketcan@hartkopp.net>, "Hans J. Koch" <hjk@hansjkoch.de>

Hello David,

On Friday 03 October 2014 11:01:41, David Jander wrote:
> On Thu, 02 Oct 2014 14:41:25 +0200
> Alexander Stein <alexander.stein@systec-electronic.com> wrote:
> 
> > finally I got the chance to test your patch. I originally expected to test
> > it on a AT91SAM9263, but I did it now on a AT91SAM9X35. The tests were done
> > on a v3.17-rc7 kernel + a DT patch. If I only run my CAN burst test without
> > any other load on the ARM everything works fine, on the unpatched kernel,
> > with your patch and also with rx-fifo branch of
> > https://gitorious.org/linux-can/linux-can-next. When running an iperf
> > (client on PC) in parallel, the situation is as follows: unpatched kernel:
> > driver hangs after ~15s. No messages are received again while the kernel is
> > still running. your patch: 37346 of 500000 msg lost rx-fifo: 36806 of 500000
> > msg lost
> 
> Thanks a lot for taking the time to look at this.
> I just looked at the rx-fifo patch, but I still don't understand how it is
> supposed to improve the situation of this driver.... beats me.
> Nevertheless you just proved that it is at least as good as my patch.
> AFAIK, there is nothing that should work as well as off-loading the CAN
> controller in the IRQ handler by a far margin. But the rx-fifo patch does not
> do that, so it is hard for me to believe it is really that good.
> Could you repeat your test at a lower bitrate? The only thing I can think of
> is that 37000 out of 500000 messages the latency has spiked on your system,
> but that spike should be a lot more contained with my patch than with rx-fifo,
> so if I'm right, then lowering the bitrate we might see a situation in which
> rx-fifo still loses a message here and there, while my patch doesn't.
> Other than that, I am tempted to think my patch is simply broken.

Ok, here is another test run (including iperf) at 250kBit/s. Did all tests 3 times.
plain:      0, 2, lockup
your patch: 0, 0, 0
rx-fifo:   26, 0, 43

When the plain driver lockups I see those kernel messages:
at91_can f8004000.can can0: order of incoming frames cannot be guaranteed

And the same with 500kBit/s:
plain:      0, 0, lockup
your patch: 0, 0, 0
rx-fifo:    0, 0, 0

I'm wondering why here rx-fifo doesn't raise any misses at 500kBit/s while there were some at 250kBit/s, maybe I just got lucky to detect it then... I get the impression that iperf influence is somewhat different from time to time. For this reason I redid the test at 1MBit/s:
plain:      lockup, lockup, lockup
your patch: 37904, 36436, 37570
rx-fifo:    35626, 34018, 36451

As expected all variants lost frames while with the unmodified kernel the driver lockups.

I only have firmware for the embedded devices which support those bitrates tested, so I can't run again with e.g. 800kBit/s, but it shows that your patch improves the situation a lot. No more driver lockups, and no message losts at at least smaller bitrates.

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

