From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: add vf61x support for flexcan
Date: Fri, 11 Jul 2014 16:00:44 +0200
Message-ID: <1405087244.4630.15.camel@weser.hi.pengutronix.de>
References: <1405075933-22317-1-git-send-email-stefan@agner.ch>
	 <53BFD401.8030101@pengutronix.de>
	 <dac76ccd134f41b86f00352d10cfae4b@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53179 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754341AbaGKOCd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 Jul 2014 10:02:33 -0400
In-Reply-To: <dac76ccd134f41b86f00352d10cfae4b@agner.ch>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stefan Agner <stefan@agner.ch>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, wg@grandegger.com, kernel@pengutronix.de, shawn.guo@freescale.com

Am Freitag, den 11.07.2014, 15:58 +0200 schrieb Stefan Agner:
> Hi Marc,
> 
> Am 2014-07-11 14:09, schrieb Marc Kleine-Budde:
> > IMHO it should be 4 seperate patches:
> > - dt
> > - clocks
> > - flexcan_get_berr_counter fixes
> > - your flexcan enhancements
> 
> Ok, will split.
> 
> >> @@ -362,7 +374,7 @@
> >>
> >>  			esdhc1: esdhc@400b2000 {
> >>  				compatible = "fsl,imx53-esdhc";
> >> -				reg = <0x400b2000 0x4000>;
> >> +				reg = <0x400b2000 0x1000>;
> > 
> > What's that doing here? :)
> 
> That's an error I just stumbled upon. I know it's not related but it's
> such a small change... Do I need to make a separate patch for that or
> can I include it in the FlexCAN dt commit?
> 
Upstream changes are meant to be traceable by reading the git log. Thus
no drive-by changes are allowed in unrelated commits. This absolutely
needs to be a separate patch.

Regards,
Lucas 
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

