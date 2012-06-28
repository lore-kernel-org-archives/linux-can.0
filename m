From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
Date: Thu, 28 Jun 2012 20:00:04 +0800
Message-ID: <20120628120002.GG22990@S2101-09.ap.freescale.net>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
 <1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
 <20120628113327.GJ6406@shlinux2.ap.freescale.net>
 <20120628114559.GE22990@S2101-09.ap.freescale.net>
 <20120628114815.GL6406@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:6625
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754527Ab2F1L7q (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Jun 2012 07:59:46 -0400
Content-Disposition: inline
In-Reply-To: <20120628114815.GL6406@shlinux2.ap.freescale.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dong Aisheng <aisheng.dong@freescale.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Hui Wang <jason77.wang@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org

On Thu, Jun 28, 2012 at 07:48:16PM +0800, Dong Aisheng wrote:
> Yes, that is a solution.
> But it may not so reasonable since dts file should represent hw, but here
> we have to do some trick by we know how driver works.
> Maybe we need find a better solution.
> 
I wouldn't agree that driver should take care of all such kind of board
weirdness.

-- 
Regards,
Shawn

