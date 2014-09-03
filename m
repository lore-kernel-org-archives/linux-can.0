From: David Jander <david@protonic.nl>
Subject: Re: [PATCH 2/3] can: flexcan.c: Re-write receive path to use MB
 queue instead of FIFO
Date: Wed, 3 Sep 2014 09:19:54 +0200
Message-ID: <20140903091954.611e527e@archvile>
References: <1409133487-23367-1-git-send-email-david@protonic.nl>
	<1409133487-23367-3-git-send-email-david@protonic.nl>
	<5405AA50.6040100@pengutronix.de>
	<20140902140407.1ee9db68@archvile>
	<5405D9FA.6050207@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:8057 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755424AbaICHTm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 3 Sep 2014 03:19:42 -0400
In-Reply-To: <5405D9FA.6050207@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: wg@grandegger.com, linux-can@vger.kernel.org

On Tue, 02 Sep 2014 16:53:46 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 09/02/2014 02:04 PM, David Jander wrote:
> > On Tue, 02 Sep 2014 13:30:24 +0200
> > Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > 
> >> On 08/27/2014 11:58 AM, David Jander wrote:
> >>> The FlexCAN controller has a RX FIFO that is only 6 messages deep, and a
> >>> mailbox space capable of holding up to 63 messages.
> >>> This space was largely unused, limiting the permissible latency from
> >>> interrupt to NAPI to only 6 messages. This patch uses all available MBs
> >>> for message reception and frees the MBs in the IRQ handler to greatly
> >>> decrease the likelihood of receive overruns.
> >>
> >> What about the order of the incoming CAN frames? Is it still preserved?
> > 
> > Yes, it is preserved as long as latency doesn't exceed 30 frames, which is
> > way more than the original driver could take. The algorithm is not trivial,
> > therefor I included an explanatory comment to flexcan_copy_rxmbs().
> 
> To be honest, I haven't looked at the algorithm in detail. I think we
> first have to fix both bugs (the errata and the mailbox initialization
> issue).

Ok, I agree.

> >> You make use of the CTRL2 register, which is not present on some older
> >> (but supported) flexcan IP cores. You increase FLEXCAN_MCR_MAXMB to
> >> 0x40, which is not supported on older IPs. The register rximr, is also
> >> not present on older cores. Don't break support for the older CAN cores.
> > 
> > Oops. Thanks for pointing that out. I will check the reference manual of
> > the i.MX53 (which should have be the oldest supported version of this IP
> > core, right?). Of course I do not want to break older CAN cores.
> > I will check correctness testing the code on an i.MX28 board which I have.
> 
> Regarding the versions of the IP cores, we should not trust them, as
> they are not public available..

Ok. I fear that for this last patch we will need some run-time check for the
version of the flexcan we have. I suppose the typical table with OF ids and
flags will do?

Best regards,

-- 
David Jander
Protonic Holland.
