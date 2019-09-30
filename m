From: Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH] can: flexcan: use devm_platform_ioremap_resource() to
 simplify code
Date: Mon, 30 Sep 2019 07:53:10 +0200
Message-ID: <542c7e8a-ed76-70db-36ff-f46e8de71d77@geanix.com>
References: <20190929082854.11952-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190929082854.11952-1-qiangqing.zhang@nxp.com>
Content-Language: en-US-large
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-can.vger.kernel.org



On 29/09/2019 10.32, Joakim Zhang wrote:
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together to simplify
> the code.
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   drivers/net/can/flexcan.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index b3edaf6a5a61..3cfa6037f03c 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -1507,7 +1507,6 @@ static int flexcan_probe(struct platform_device *pdev)
>   	struct net_device *dev;
>   	struct flexcan_priv *priv;
>   	struct regulator *reg_xceiver;
> -	struct resource *mem;
>   	struct clk *clk_ipg = NULL, *clk_per = NULL;
>   	struct flexcan_regs __iomem *regs;
>   	int err, irq;
> @@ -1538,12 +1537,11 @@ static int flexcan_probe(struct platform_device *pdev)
>   		clock_freq = clk_get_rate(clk_per);
>   	}
>   
> -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	irq = platform_get_irq(pdev, 0);
>   	if (irq <= 0)
>   		return -ENODEV;
>   
> -	regs = devm_ioremap_resource(&pdev->dev, mem);
> +	regs = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(regs))
>   		return PTR_ERR(regs);
>   
> 
