From: David Jander <david@protonic.nl>
Subject: Re: [PATCH 2/3] can: flexcan.c: Re-write receive path to use MB
 queue instead of FIFO
Date: Tue, 2 Sep 2014 14:04:07 +0200
Message-ID: <20140902140407.1ee9db68@archvile>
References: <1409133487-23367-1-git-send-email-david@protonic.nl>
	<1409133487-23367-3-git-send-email-david@protonic.nl>
	<5405AA50.6040100@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:5386 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355AbaIBMD4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Sep 2014 08:03:56 -0400
In-Reply-To: <5405AA50.6040100@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: wg@grandegger.com, linux-can@vger.kernel.org

On Tue, 02 Sep 2014 13:30:24 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 08/27/2014 11:58 AM, David Jander wrote:
> > The FlexCAN controller has a RX FIFO that is only 6 messages deep, and a
> > mailbox space capable of holding up to 63 messages.
> > This space was largely unused, limiting the permissible latency from
> > interrupt to NAPI to only 6 messages. This patch uses all available MBs
> > for message reception and frees the MBs in the IRQ handler to greatly
> > decrease the likelihood of receive overruns.
> 
> What about the order of the incoming CAN frames? Is it still preserved?

Yes, it is preserved as long as latency doesn't exceed 30 frames, which is
way more than the original driver could take. The algorithm is not trivial,
therefor I included an explanatory comment to flexcan_copy_rxmbs().

> You make use of the CTRL2 register, which is not present on some older
> (but supported) flexcan IP cores. You increase FLEXCAN_MCR_MAXMB to
> 0x40, which is not supported on older IPs. The register rximr, is also
> not present on older cores. Don't break support for the older CAN cores.

Oops. Thanks for pointing that out. I will check the reference manual of the
i.MX53 (which should have be the oldest supported version of this IP core,
right?). Of course I do not want to break older CAN cores.
I will check correctness testing the code on an i.MX28 board which I have.

Indeed the MAXMB field in IP-version 3 seems to be 6 bits wide instead of 7,
which doesn't make sense, since there are still 64 MB's. If one would want all
MB's to take part in the arbitration process, one would need to write 0x40 to
this register, which doesn't fit. Could it be that this is just a
documentation error? I would bet so. Who knows?
We can settle for 0x3f to be safe, can't we?

> Please make this patch based on linux-can-next/master (which holds some
> updates to the regs structure).

Thanks for pointing out. I will use that as base for the next version.

Best regards,

-- 
David Jander
Protonic Holland.
