From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: Re: [PATCH v2 1/2] net: flexcan: clock-frequency is optional for
 device tree probe
Date: Thu, 28 Jun 2012 19:23:37 +0800
Message-ID: <20120628112336.GI6406@shlinux2.ap.freescale.net>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
 <1340853701-4488-2-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:18801
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751205Ab2F1L3N (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Jun 2012 07:29:13 -0400
Content-Disposition: inline
In-Reply-To: <1340853701-4488-2-git-send-email-shawn.guo@linaro.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Hui Wang <jason77.wang@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org

On Thu, Jun 28, 2012 at 11:21:40AM +0800, Shawn Guo wrote:
> The property clock-frequency is optional for device tree probe.  When
> it's absent, the flexcan driver will try to get the frequency from clk
> system by calling clk_get_rate.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

Regards
Dong Aisheng

