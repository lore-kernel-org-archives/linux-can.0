From: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
Subject: Re: [PATCH] can: mcp251x: Add device tree support
Date: Mon, 23 Dec 2013 08:14:03 +0100
Message-ID: <52B7E2BB.3030103@epfl.ch>
References: <1387602101-27851-1-git-send-email-shc_work@mail.ru>
Reply-To: florian.vaussard-p8DiymsW2f8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387602101-27851-1-git-send-email-shc_work-JGs/UdohzUI@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-can.vger.kernel.org

Hello,

On 12/21/2013 06:01 AM, Alexander Shiyan wrote:
> This patch adds Device Tree support to the Microchip MCP251X driver.
> 
> Signed-off-by: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
> ---
>  .../bindings/net/can/microchip,mcp251x.txt         | 25 ++++++
>  drivers/net/can/mcp251x.c                          | 99 ++++++++++++++++------
>  2 files changed, 99 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt
> 

[...]

> +
>  static int mcp251x_can_probe(struct spi_device *spi)
>  {
> +	const struct of_device_id *of_id = of_match_device(mcp251x_of_match,
> +							   &spi->dev);
> +	struct mcp251x_platform_data *pdata = dev_get_platdata(&spi->dev);
>  	struct net_device *net;
>  	struct mcp251x_priv *priv;
> -	struct mcp251x_platform_data *pdata = dev_get_platdata(&spi->dev);
> -	int ret = -ENODEV;
> +	int freq, ret = -ENODEV;
> +	struct clk *clk;
> +
> +	clk = devm_clk_get(&spi->dev, NULL);
> +	if (IS_ERR(clk)) {
> +		if (pdata)
> +			freq = pdata->oscillator_frequency;
> +		else
> +			return PTR_ERR(clk);
> +	} else {
> +		freq = clk_get_rate(clk);
> +	}
>  
> -	if (!pdata)
> -		/* Platform data is required for osc freq */
> -		goto error_out;
> +	/* Sanity check */
> +	if (freq < 1000000 || freq > 25000000)
> +		return -ERANGE;

This sanity check is new, right? This has nothing to do with device tree
conversion and
should be introduced by another patch.

>  
>  	/* Allocate can/net device */
>  	net = alloc_candev(sizeof(struct mcp251x_priv), TX_ECHO_SKB_MAX);
> -	if (!net) {
> -		ret = -ENOMEM;
> -		goto error_alloc;
> +	if (!net)
> +		return -ENOMEM;
> +

Why are you changing this? This is not related to DT and is not duly
motivated.

> +	if (!IS_ERR(clk)) {
> +		ret = clk_prepare_enable(clk);
> +		if (ret)
> +			goto out_free;
>  	}
>  
>  	net->netdev_ops = &mcp251x_netdev_ops;
> @@ -1018,23 +1065,27 @@ static int mcp251x_can_probe(struct spi_device *spi)
>  	priv = netdev_priv(net);
>  	priv->can.bittiming_const = &mcp251x_bittiming_const;
>  	priv->can.do_set_mode = mcp251x_do_set_mode;
> -	priv->can.clock.freq = pdata->oscillator_frequency / 2;
> +	priv->can.clock.freq = freq / 2;
>  	priv->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES |
>  		CAN_CTRLMODE_LOOPBACK | CAN_CTRLMODE_LISTENONLY;
> -	priv->model = spi_get_device_id(spi)->driver_data;
> +	if (of_id)
> +		priv->model = (enum mcp251x_model)of_id->data;
> +	else
> +		priv->model = spi_get_device_id(spi)->driver_data;
>  	priv->net = net;
> +	priv->clk = clk;
>  
>  	priv->power = devm_regulator_get(&spi->dev, "vdd");
>  	priv->transceiver = devm_regulator_get(&spi->dev, "xceiver");
>  	if ((PTR_ERR(priv->power) == -EPROBE_DEFER) ||
>  	    (PTR_ERR(priv->transceiver) == -EPROBE_DEFER)) {
>  		ret = -EPROBE_DEFER;
> -		goto error_power;
> +		goto out_clk;
>  	}
>  
>  	ret = mcp251x_power_enable(priv->power, 1);
>  	if (ret)
> -		goto error_power;
> +		goto out_clk;
>  
>  	spi_set_drvdata(spi, priv);
>  
> @@ -1113,11 +1164,14 @@ error_probe:
>  		dma_free_coherent(&spi->dev, PAGE_SIZE,
>  				  priv->spi_tx_buf, priv->spi_tx_dma);
>  	mcp251x_power_enable(priv->power, 0);
> -error_power:
> +
> +out_clk:
> +	if (!IS_ERR(clk))
> +		clk_disable_unprepare(clk);
> +
> +out_free:
>  	free_candev(net);
> -error_alloc:
> -	dev_err(&spi->dev, "probe failed\n");

Why removing this error message?

> -error_out:
> +
>  	return ret;
>  }
>  
> @@ -1135,6 +1189,9 @@ static int mcp251x_can_remove(struct spi_device *spi)
>  
>  	mcp251x_power_enable(priv->power, 0);
>  
> +	if (!IS_ERR(priv->clk))
> +		clk_disable_unprepare(priv->clk);
> +
>  	free_candev(net);
>  
>  	return 0;
> @@ -1197,21 +1254,13 @@ static int mcp251x_can_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(mcp251x_can_pm_ops, mcp251x_can_suspend,
>  	mcp251x_can_resume);
>  
> -static const struct spi_device_id mcp251x_id_table[] = {
> -	{ "mcp2510",	CAN_MCP251X_MCP2510 },
> -	{ "mcp2515",	CAN_MCP251X_MCP2515 },
> -	{ },
> -};
> -
> -MODULE_DEVICE_TABLE(spi, mcp251x_id_table);
> -
>  static struct spi_driver mcp251x_can_driver = {
>  	.driver = {
>  		.name = DEVICE_NAME,
>  		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(mcp251x_of_match),
>  		.pm = &mcp251x_can_pm_ops,
>  	},
> -

Spurious change

>  	.id_table = mcp251x_id_table,
>  	.probe = mcp251x_can_probe,
>  	.remove = mcp251x_can_remove,
> 

I would say that your patch could be split into several patches, as you
introduce several
non-DT changes:

PATCH 1: use devm_clk_get()
PATCH 2: convert to device tree
PATCH 3: add frequency sanity check

This would be more readable and easier to check.

Best,

Florian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
