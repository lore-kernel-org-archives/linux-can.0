From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/2] arm: mxs: enable flexcan on imx28
Date: Mon, 2 Jul 2012 10:01:23 +0800
Message-ID: <20120702020121.GB21003@S2101-09.ap.freescale.net>
References: <1341175565-13218-1-git-send-email-mkl@pengutronix.de>
 <1341175565-13218-3-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:37981 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753217Ab2GBCAn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 1 Jul 2012 22:00:43 -0400
Content-Disposition: inline
In-Reply-To: <1341175565-13218-3-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-can@vger.kernel.org

Suggested subject prefix is "ARM: mxs: ...".

On Sun, Jul 01, 2012 at 10:46:05PM +0200, Marc Kleine-Budde wrote:
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Can we fill the commit message with something like what we have in
the cover letter?

Regards,
Shawn

> ---
>  arch/arm/mach-mxs/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
> index 91cf062..ccdf83b 100644
> --- a/arch/arm/mach-mxs/Kconfig
> +++ b/arch/arm/mach-mxs/Kconfig
> @@ -16,6 +16,7 @@ config SOC_IMX28
>  	bool
>  	select ARM_AMBA
>  	select CPU_ARM926T
> +	select HAVE_CAN_FLEXCAN if CAN
>  	select HAVE_PWM
>  	select PINCTRL_IMX28
>  
> -- 
> 1.7.10
> 

