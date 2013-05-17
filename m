From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2] can: flexcan: remove HAVE_CAN_FLEXCAN Kconfig symbol
Date: Fri, 17 May 2013 17:09:51 +0800
Message-ID: <20130517090949.GI8607@S2101-09.ap.freescale.net>
References: <1368781157-4646-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db8lp0184.outbound.messaging.microsoft.com ([213.199.154.184]:32797
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750712Ab3EQJJy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 May 2013 05:09:54 -0400
Content-Disposition: inline
In-Reply-To: <1368781157-4646-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Sascha Hauer <s.hauer@pengutronix.de>, Kumar Gala <galak@kernel.crashing.org>, U Bhaskar-B22300 <B22300@freescale.com>, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org

On Fri, May 17, 2013 at 10:59:17AM +0200, Marc Kleine-Budde wrote:
> This patch removes the Kconfig symbol HAVE_CAN_FLEXCAN from arch/{arm,powerpc}
> and allowing compilation unconditionally on all arm and powerpc platforms.
> 
> This brings a bigger compile time coverage and removes the following dependency
> warning found by Arnd Bergmann:
> 
>     warning: (SOC_IMX28 && SOC_IMX25 && SOC_IMX35 && IMX_HAVE_PLATFORM_FLEXCAN &&
>         SOC_IMX53 && SOC_IMX6Q) selects HAVE_CAN_FLEXCAN
>     which has unmet direct dependencies (NET && CAN && CAN_DEV)
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Cc: U Bhaskar-B22300 <B22300@freescale.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

