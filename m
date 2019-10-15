From: Simon Horman <simon.horman@netronome.com>
Subject: Re: [PATCH net-next] can: ifi: use devm_platform_ioremap_resource()
 to simplify code
Date: Tue, 15 Oct 2019 18:10:23 +0200
Message-ID: <20191015161022.mtgohberdmhkbo46@netronome.com>
References: <20191015142046.24844-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191015142046.24844-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On Tue, Oct 15, 2019 at 10:20:46PM +0800, YueHaibing wrote:
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <simon.horman@netronome.com>

> ---
>  drivers/net/can/ifi_canfd/ifi_canfd.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
> index fedd927..04d59be 100644
> --- a/drivers/net/can/ifi_canfd/ifi_canfd.c
> +++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
> @@ -942,13 +942,11 @@ static int ifi_canfd_plat_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct net_device *ndev;
>  	struct ifi_canfd_priv *priv;
> -	struct resource *res;
>  	void __iomem *addr;
>  	int irq, ret;
>  	u32 id, rev;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	addr = devm_ioremap_resource(dev, res);
> +	addr = devm_platform_ioremap_resource(pdev, 0);
>  	irq = platform_get_irq(pdev, 0);
>  	if (IS_ERR(addr) || irq < 0)
>  		return -EINVAL;
> -- 
> 2.7.4
> 
> 
