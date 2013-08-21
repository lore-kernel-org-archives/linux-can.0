From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] can: c_can: fix error checking of priv->instance in probe()
Date: Wed, 21 Aug 2013 17:52:24 +0800
Message-ID: <52148DD8.3070201@asianux.com>
References: <1377078508-26713-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:63653 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab3HUJxY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 Aug 2013 05:53:24 -0400
In-Reply-To: <1377078508-26713-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, anilkumar@ti.com, tony@atomide.com, jg1.han@samsung.com

On 08/21/2013 05:48 PM, Marc Kleine-Budde wrote:
> From: Chen Gang <gang.chen@asianux.com>
> 
> This patch adds a type cast from 'unsigned int' to 'int'.
> 
> 'priv->instance' may less than zero, so need a type cast, the related
> warnings (allmodconfig, "EXTRA_CFLAGS=-W"):
> 
>   drivers/net/can/c_can/c_can_platform.c:198:3: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Hello Chen Gang,
> 
> I've tweaked the commit message a bit. If there a no complains the patch will
> be included in my next pull request to David.
> 

Thank you for your tweaking.


> Marc
> 
>  drivers/net/can/c_can/c_can_platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
> index c6f838d..294ced3 100644
> --- a/drivers/net/can/c_can/c_can_platform.c
> +++ b/drivers/net/can/c_can/c_can_platform.c
> @@ -195,7 +195,7 @@ static int c_can_plat_probe(struct platform_device *pdev)
>  
>  		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>  		priv->raminit_ctrlreg = devm_ioremap_resource(&pdev->dev, res);
> -		if (IS_ERR(priv->raminit_ctrlreg) || priv->instance < 0)
> +		if (IS_ERR(priv->raminit_ctrlreg) || (int)priv->instance < 0)
>  			dev_info(&pdev->dev, "control memory is not used for raminit\n");
>  		else
>  			priv->raminit = c_can_hw_raminit;
> 


Thanks.
-- 
Chen Gang
