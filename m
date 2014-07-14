From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH] can: flexcan: add vf61x support for flexcan
Date: Mon, 14 Jul 2014 15:32:35 +0800
Message-ID: <20140714073234.GD2197@dragon>
References: <1405075933-22317-1-git-send-email-stefan@agner.ch>
 <53BFD401.8030101@pengutronix.de> <dac76ccd134f41b86f00352d10cfae4b@agner.ch>
 <20140714060344.GB2197@dragon> <cecd42e333cdf65ad512f719125f9180@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-by2lp0244.outbound.protection.outlook.com ([207.46.163.244]:13671
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752785AbaGNHcq (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 14 Jul 2014 03:32:46 -0400
Content-Disposition: inline
In-Reply-To: <cecd42e333cdf65ad512f719125f9180@agner.ch>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stefan Agner <stefan@agner.ch>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, wg@grandegger.com, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jul 14, 2014 at 09:06:33AM +0200, Stefan Agner wrote:
> Am 2014-07-14 08:04, schrieb Shawn Guo:
> > On Fri, Jul 11, 2014 at 03:58:37PM +0200, Stefan Agner wrote:
> >> >> @@ -362,7 +374,7 @@
> >> >>
> >> >>  			esdhc1: esdhc@400b2000 {
> >> >>  				compatible = "fsl,imx53-esdhc";
> >> >> -				reg = <0x400b2000 0x4000>;
> >> >> +				reg = <0x400b2000 0x1000>;
> >> >
> >> > What's that doing here? :)
> >>
> >> That's an error I just stumbled upon.
> > 
> > I do not see why it's an error.  From Table 2-1. System Memory Map in
> > i.MX53 RM, the size of ESDHC1 is 16K.
> > 
> > Shawn
> 
> Hi Shawn,
> 
> In the Vybrid RM memory map, 0x400B4000 is allocated to USB. 0x400B3000
> is empty, whereas for other peripherals (e.g. FlexCAN) which use
> multiple 0x1000 blocks, they are all explicitly stated. That is why I
> assumed 0x1000 is correct.

Ah, sorry.  I thought you're on i.MX53.  You're right about Vybrid, and
it should be 0x1000.

> 
> But then, the memory map within the SDHC peripheral has some registers
> also located in 0x400B3000.

Really?  Which one?

Shawn

> Hence I think 0x2000 is correct. Will send
> an updated and separated patch.
