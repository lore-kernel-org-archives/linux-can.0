From: Hui Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH] can: flexcan: add hardware controller version support
Date: Mon, 2 Jul 2012 10:24:40 +0800
Message-ID: <4FF10668.4000504@gmail.com>
References: <1341174085-11781-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:55155 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754763Ab2GBCZD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 1 Jul 2012 22:25:03 -0400
In-Reply-To: <1341174085-11781-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, Hui Wang <jason77.wang@gmail.com>, Wolfgang Grandegger <wg@grandegger.com>, Shawn Guo <shawn.guo@linaro.org>

Marc Kleine-Budde wrote:
> From: Hui Wang <jason77.wang@gmail.com>
>
> At least in the i.MX series, the flexcan contrller divides into ver_3
> and ver_10, current driver is for ver_3 controller.
>
> i.MX6 has ver_10 controller, it has more reigsters than ver_3 has.
> The rxfgmask (Rx FIFO Global Mask) register is one of the new added.
> Its reset value is 0xffffffff, this means ID Filter Table must be
> checked when receive a packet, but the driver is designed to accept
> everything during the chip start, we need to clear this register to
> follow this design.
>
> Use the data entry of the struct of_device_id to point chip specific
> info, we can set hardware version for each platform.
>
> Cc: linux-can@vger.kernel.org
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Hui Wang <jason77.wang@gmail.com>
> [mkl: add id_table support]
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Hui Wang,
>
> can you please test if this works for you on mx6.
>   
Sorry for reply late.

This patch works well on the mx6. But i found a minor problem, please 
see below.
> regards, Marc
>
>
>  drivers/net/can/flexcan.c |   61 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 53 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
>
>   
<snip>
>  	}
>  
> +	of_id = of_match_device(flexcan_of_match, &pdev->dev);
> +	if (of_id) {
> +		devtype_data = of_id->data;
> +	} else if (pdev->id_entry->driver_data) {
> +		devtype_data = (struct flexcan_devtype_data *)
> +			pdev->id_entry->driver_data;
> +	} else {
> +		err = -ENODEV;
> +		goto failed_devtype;
> +	}
> +
>  	dev->netdev_ops = &flexcan_netdev_ops;
>  	dev->irq = irq;
>  	dev->flags |= IFF_ECHO;
>  
>  	priv = netdev_priv(dev);
> +	priv->devtype_data = devtype_data;
>  	priv->can.clock.freq = clock_freq;
>  	priv->can.bittiming_const = &flexcan_bittiming_const;
>  	priv->can.do_set_mode = flexcan_set_mode;
> @@ -993,6 +1042,7 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
>  	priv->dev = dev;
>  	priv->clk = clk;
>  	priv->pdata = pdev->dev.platform_data;
> +	priv->devtype_data = devtype_data;
>   
Two priv->devtype_data = devtype_data; ?

It seems one of them is redundant and is not needed.

Regards,
Hui.
>  
>  	netif_napi_add(dev, &priv->napi, flexcan_poll, FLEXCAN_NAPI_WEIGHT);
>  
> @@ -1011,6 +1061,7 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
>  	return 0;
>  
>   failed_register:
> + failed_devtype:
>  	free_candev(dev);
>   failed_alloc:
>  	iounmap(base);
> @@ -1044,13 +1095,6 @@ static int __devexit flexcan_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static struct of_device_id flexcan_of_match[] = {
> -	{
> -		.compatible = "fsl,p1010-flexcan",
> -	},
> -	{},
> -};
> -
>  #ifdef CONFIG_PM
>  static int flexcan_suspend(struct platform_device *pdev, pm_message_t state)
>  {
> @@ -1097,6 +1141,7 @@ static struct platform_driver flexcan_driver = {
>  	.remove = __devexit_p(flexcan_remove),
>  	.suspend = flexcan_suspend,
>  	.resume = flexcan_resume,
> +	.id_table = flexcan_id_table,
>  };
>  
>  module_platform_driver(flexcan_driver);
>   

