From: Hui Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH v2] can: flexcan: add 2nd clock to support imx53 and newer
Date: Wed, 18 Jul 2012 18:05:08 +0800
Message-ID: <50068A54.80705@gmail.com>
References: <1342601282-1208-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:65150 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128Ab2GRKF4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Jul 2012 06:05:56 -0400
In-Reply-To: <1342601282-1208-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Hui Wang <jason77.wang@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, kernel@pengutronix.de, Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-arm-kernel@lists.infradead.org

Marc Kleine-Budde wrote:
> From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>
> This patch adds support for a second clock to the flexcan driver. On
> modern freescale ARM cores like the imx53 and imx6q two clocks ("ipg"
> and "per") must be enabled in order to access the CAN core.
>
> In the original driver, the clock was requested without specifying the
> connection id, further all mainline ARM archs with flexcan support
> (imx28, imx25, imx35) register their flexcan clock without a
> connection id, too.
>
> This patch first renames the existing clk variable to clk_ipg and
> converts it to devm for easier error handling. The connection id "ipg"
> is added to the devm_clk_get() call. Then a second clock "per" is
> requested. As all archs don't specify a connection id, both clk_get
> return the same clock. This ensures compatibility to existing flexcan
> support and adds support for imx53 at the same time.
>
> After this patch hits mainline, the archs may give their existing
> flexcan clock the "ipg" connection id and implement a dummy "per"
> clock.
>
> This patch has been tested on imx28 (unmodified clk tree) and on imx53
> with a seperate "ipg" and "per" clock.
>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Hui Wang <jason77.wang@gmail.com>
>   
Acked-by: Hui Wang <jason77.wang@gmail.com>
