From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 1/2] can + ARM i.MX53: use 24 MHz clock parent on
 i.MX53
Date: Mon, 9 Dec 2013 13:59:05 +0800
Message-ID: <20131209055903.GI825@S2101-09.ap.freescale.net>
References: <1385414121-21493-1-git-send-email-mkl@pengutronix.de>
 <20131126045340.GJ30476@S2101-09.ap.freescale.net>
 <52945B40.5020200@pengutronix.de>
 <20131126143258.GA5685@S2101-09.ap.freescale.net>
 <529DB86B.9010401@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:40521
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755454Ab3LIF65 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Dec 2013 00:58:57 -0500
Content-Disposition: inline
In-Reply-To: <529DB86B.9010401@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, lst@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org

On Tue, Dec 03, 2013 at 11:54:35AM +0100, Marc Kleine-Budde wrote:
> Hello Shawn,
> 
> On 11/26/2013 03:33 PM, Shawn Guo wrote:
> > On Tue, Nov 26, 2013 at 09:26:40AM +0100, Marc Kleine-Budde wrote:
> >> The problem is, that the wrong clock is being used. An all i.mx, but not
> >> on imx6, both clocks are the same, the bug doesn't show up. So before we
> >> can use the 24 MHz clock on mx53, we have to fix the driver.
> > 
> > So it sounds like a more appropriate merging path would be that,
> > you send the driver fix right away to mainline via net tree with
> > v3.13-rc series, and I rebase IMX tree on the -rc that has the fix,
> > and then apply the DTS patch.
> 
> The patch is now in Linus master:
> 1a3e517 can: flexcan: use correct clock as base for bit rate calculation
> 
> So it should be in the v3.13-rc3.

Ok, v3.13-rc3 is out and the clock patch is applied.

Shawn

