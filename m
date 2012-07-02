From: Sascha Hauer <sha@pengutronix.de>
Subject: Re: [PATCH v2 1/2] arm: imx: enable flexcan on imx25, imx35, imx53,
 imx6q
Date: Mon, 2 Jul 2012 11:33:19 +0200
Message-ID: <20120702093319.GN2698@pengutronix.de>
References: <1341219781-26107-1-git-send-email-mkl@pengutronix.de>
 <1341219781-26107-2-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34270 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932692Ab2GBJdV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 2 Jul 2012 05:33:21 -0400
Content-Disposition: inline
In-Reply-To: <1341219781-26107-2-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-can@vger.kernel.org

Shawn,

In case you want to apply this one:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

On Mon, Jul 02, 2012 at 11:03:00AM +0200, Marc Kleine-Budde wrote:
> Aas the flexcan driver has DT binding for some time now. This patch makes
> the flexcan driver available in the can drivers menu if a SOC with flexcan
> is enabled.
> 
> Cc: Sascha Hauer <sha@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  arch/arm/mach-imx/Kconfig |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index eff4db5..c296851 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -52,6 +52,7 @@ config SOC_IMX25
>  	select ARCH_MX25
>  	select COMMON_CLK
>  	select CPU_ARM926T
> +	select HAVE_CAN_FLEXCAN if CAN
>  	select ARCH_MXC_IOMUX_V3
>  	select MXC_AVIC
>  
> @@ -79,6 +80,7 @@ config SOC_IMX35
>  	select HAVE_EPIT
>  	select MXC_AVIC
>  	select SMP_ON_UP if SMP
> +	select HAVE_CAN_FLEXCAN if CAN
>  
>  config SOC_IMX5
>  	select CPU_V7
> @@ -105,6 +107,7 @@ config	SOC_IMX53
>  	select SOC_IMX5
>  	select ARCH_MX5
>  	select ARCH_MX53
> +	select HAVE_CAN_FLEXCAN if CAN
>  
>  if ARCH_IMX_V4_V5
>  
> @@ -826,6 +829,7 @@ config SOC_IMX6Q
>  	select COMMON_CLK
>  	select CPU_V7
>  	select HAVE_ARM_SCU
> +	select HAVE_CAN_FLEXCAN if CAN
>  	select HAVE_IMX_GPC
>  	select HAVE_IMX_MMDC
>  	select HAVE_IMX_SRC
> -- 
> 1.7.10
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
