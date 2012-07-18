From: Hui Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH] can: flexcan: add 2nd clock to support imx53 and newer
Date: Wed, 18 Jul 2012 10:12:22 +0800
Message-ID: <50061B86.7080200@gmail.com>
References: <1342562748-24701-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:59443 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807Ab2GRCND (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Jul 2012 22:13:03 -0400
In-Reply-To: <1342562748-24701-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Hui Wang <jason77.wang@gmail.com>

Marc Kleine-Budde wrote:
> From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>
> This patch add support for a second clock to the flexcan driver. On modern
> freescale ARM cores like the imx53 and imx6q two clocks ("ipg" and "per")
> must be enabled in order to access the CAN core.
>
> In the original driver, the clock was requested without specifying the
> connection id, further all mainline ARM archs with flexcan support
> (imx28, imx25, imx35) register their flexcan clock without a connection id,
> too.
>
> This patch first renames the existing clk variable to clk_ipg and adds the
> connection id "ipg" to the clk_get() call. Then a second clock "per" is
> requested. As all archs don't specify a connection id, both clk_get return
> the same clock. This ensures compatibility to existing flexcan support
> and adds support for imx53 at the same time.
>
> After this patch hits mainline, the archs may give their existing flexcan
> clock the "ipg" connection id and implement a dummy "per" clock.
>
> This patch has been tested on imx28 (unmodified clk tree) and on imx53
> with a seperate "ipg" and "per" clock.
>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Hui Wang <jason77.wang@gmail.com>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/flexcan.c |   52 ++++++++++++++++++++++++++++++---------------
>  1 file changed, 35 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index c8a6fc7..281d51f 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -190,7 +190,8 @@ struct flexcan_priv {
>
>   
[...]
>  	if (!clock_freq) {
> -		clk = clk_get(&pdev->dev, NULL);
> -		if (IS_ERR(clk)) {
> -			dev_err(&pdev->dev, "no clock defined\n");
> -			err = PTR_ERR(clk);
> +		clk_ipg = clk_get(&pdev->dev, "ipg");
> +		if (IS_ERR(clk_ipg)) {
> +			dev_err(&pdev->dev, "no ipg clock defined\n");
> +			err = PTR_ERR(clk_ipg);
> +			goto failed_clock;
> +		}
> +		clock_freq = clk_get_rate(clk_ipg);
> +
> +		clk_per = clk_get(&pdev->dev, "per");
> +		if (IS_ERR(clk_per)) {
> +			dev_err(&pdev->dev, "no per clock defined\n");
> +			err = PTR_ERR(clk_per);
>  			goto failed_clock;
>  		}
>   
For those only register one clk and without con_id (mx35), clk_per will 
equal to clk_ipg, how to handle this situation, modify mx35 clk tree?
> -		clock_freq = clk_get_rate(clk);
>  	}
>  
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -1039,7 +1052,8 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
>  		CAN_CTRLMODE_BERR_REPORTING;
>  	priv->base = base;
>  	priv->dev = dev;
> -	priv->clk = clk;
> +	priv->clk_ipg = clk_ipg;
> +	priv->clk_per = clk_per;
>  	priv->pdata = pdev->dev.platform_data;
>  	priv->devtype_data = devtype_data;
>  
> @@ -1067,9 +1081,11 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
>   failed_map:
>  	release_mem_region(mem->start, mem_size);
>   failed_get:
> -	if (clk)
> -		clk_put(clk);
>   failed_clock:
> +	if (clk_per)
>   
Use if (!IS_ERR(clk_per))
> +		clk_put(clk_per);
> +	if (clk_ipg)
>   
Ditto.

If we use devm_clk_get(), we can save to call clk_put().
> +		clk_put(clk_ipg);
>  	return err;
>  }
>  
> @@ -1086,8 +1102,10 @@ static int __devexit flexcan_remove(struct platform_device *pdev)
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	release_mem_region(mem->start, resource_size(mem));
>  
> -	if (priv->clk)
> -		clk_put(priv->clk);
> +	if (priv->clk_per)
> +		clk_put(priv->clk_per);
> +	if (priv->clk_ipg)
> +		clk_put(priv->clk_ipg);
>  
>  	free_candev(dev);
>  
>   

