From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 1/2] can + ARM i.MX53: use 24 MHz clock parent on
 i.MX53
Date: Tue, 26 Nov 2013 12:53:42 +0800
Message-ID: <20131126045340.GJ30476@S2101-09.ap.freescale.net>
References: <1385414121-21493-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:48134
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752705Ab3KZEvP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 25 Nov 2013 23:51:15 -0500
Content-Disposition: inline
In-Reply-To: <1385414121-21493-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, lst@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org

On Mon, Nov 25, 2013 at 10:15:19PM +0100, Marc Kleine-Budde wrote:
> Hello,
> 
> this series first fixes a bug in the flexcan driver, using the wrong clock for
> the bit rate calculcation. The next patch switches the peripheral clock on
> i.MX53 to lp_apm, which has a rate of 24 MHz. This is optimal for the CIA
> recommended bit rates.
> 
> Tested on TQ's mba53 and mba6x [1].
> 
> Who is taking the series? Due to Lucas' patch:
> 
>     0a5b8df clk: imx5: introduce DT includes for clock provider
> 
> this series does not yet apply to my upstream (net-next/mastet).

If the clock setting in flexcan driver is already broken, it shouldn't
matter to have two patches go different tree?  Otherwise, I can have
both go via IMX tree with your ACK on the first one?

> 
> Marc
> 
> [1] On i.MX6 the following patch is needed (which is already in Shawn's
>     for-next):
> 
>     9b3d423 ARM: i.MX6q: fix the wrong parent of can_root clock

This one already hits mainline.

Shawn

> 
> changes since v1:
> * move switch to 24 MHz clock to mx53_clocks_init
>   (tnx Alexander)
> 
> 

