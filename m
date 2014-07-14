From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH] can: flexcan: add vf61x support for flexcan
Date: Mon, 14 Jul 2014 14:04:01 +0800
Message-ID: <20140714060344.GB2197@dragon>
References: <1405075933-22317-1-git-send-email-stefan@agner.ch>
 <53BFD401.8030101@pengutronix.de> <dac76ccd134f41b86f00352d10cfae4b@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn1blp0184.outbound.protection.outlook.com ([207.46.163.184]:19305
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752717AbaGNGEM (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 14 Jul 2014 02:04:12 -0400
Content-Disposition: inline
In-Reply-To: <dac76ccd134f41b86f00352d10cfae4b@agner.ch>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stefan Agner <stefan@agner.ch>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, wg@grandegger.com, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jul 11, 2014 at 03:58:37PM +0200, Stefan Agner wrote:
> >> @@ -362,7 +374,7 @@
> >>
> >>  			esdhc1: esdhc@400b2000 {
> >>  				compatible = "fsl,imx53-esdhc";
> >> -				reg = <0x400b2000 0x4000>;
> >> +				reg = <0x400b2000 0x1000>;
> > 
> > What's that doing here? :)
> 
> That's an error I just stumbled upon.

I do not see why it's an error.  From Table 2-1. System Memory Map in
i.MX53 RM, the size of ESDHC1 is 16K.

Shawn

> I know it's not related but it's
> such a small change... Do I need to make a separate patch for that or
> can I include it in the FlexCAN dt commit?
