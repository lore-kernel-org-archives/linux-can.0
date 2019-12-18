From: Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH V2 1/2] can: flexcan: disable runtime PM if register
 flexcandev failed
Date: Wed, 18 Dec 2019 15:00:39 +0100
Message-ID: <d51c46d8-33fa-a4e3-8626-ba3622bab7ee@geanix.com>
References: <20191210085721.9853-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191210085721.9853-1-qiangqing.zhang@nxp.com>
Content-Language: en-US-large
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org



On 10/12/2019 10.00, Joakim Zhang wrote:
> Had better disable runtime PM if register flexcandev failed.
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Tested-by: Sean Nyekjaer <sean@geanix.com>
> ------
> ChangeLog:
> 	V1->V2: *no change.
> ---
>   drivers/net/can/flexcan.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 3a754355ebe6..6c1ccf9f6c08 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -1681,6 +1681,8 @@ static int flexcan_probe(struct platform_device *pdev)
>   	return 0;
>   
>    failed_register:
> +	pm_runtime_put_noidle(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
>   	free_candev(dev);
>   	return err;
>   }
> 
