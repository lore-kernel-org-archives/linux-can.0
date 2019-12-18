From: Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH V2 2/2] can: flexcan: disable clocks during stop mode
Date: Wed, 18 Dec 2019 15:00:50 +0100
Message-ID: <e9afd8dd-1953-307e-6b5d-a8236381690b@geanix.com>
References: <20191210085721.9853-1-qiangqing.zhang@nxp.com>
 <20191210085721.9853-2-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191210085721.9853-2-qiangqing.zhang@nxp.com>
Content-Language: en-US-large
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org



On 10/12/2019 10.00, Joakim Zhang wrote:
> Disable clocks during CAN in stop mode.
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Tested-by: Sean Nyekjaer <sean@geanix.com>
> ------
> ChangeLog:
> 	V1->V2: * moving the pm_runtime_force_suspend() call for both
> 	cases "device_may_wakeup()" and "!device_may_wakeup()" into the
> 	flexcan_noirq_suspend() handler
> ---
>   drivers/net/can/flexcan.c | 32 +++++++++++++++++++-------------
>   1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 6c1ccf9f6c08..63b2f47635cf 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -1718,10 +1718,6 @@ static int __maybe_unused flexcan_suspend(struct device *device)
>   			if (err)
>   				return err;
>   
> -			err = pm_runtime_force_suspend(device);
> -			if (err)
> -				return err;
> -
>   			err = pinctrl_pm_select_sleep_state(device);
>   			if (err)
>   				return err;
> @@ -1751,10 +1747,6 @@ static int __maybe_unused flexcan_resume(struct device *device)
>   			if (err)
>   				return err;
>   
> -			err = pm_runtime_force_resume(device);
> -			if (err)
> -				return err;
> -
>   			err = flexcan_chip_start(dev);
>   			if (err)
>   				return err;
> @@ -1786,9 +1778,16 @@ static int __maybe_unused flexcan_noirq_suspend(struct device *device)
>   {
>   	struct net_device *dev = dev_get_drvdata(device);
>   	struct flexcan_priv *priv = netdev_priv(dev);
> +	int err;
>   
> -	if (netif_running(dev) && device_may_wakeup(device))
> -		flexcan_enable_wakeup_irq(priv, true);
> +	if (netif_running(dev)) {
> +		if (device_may_wakeup(device))
> +			flexcan_enable_wakeup_irq(priv, true);
> +
> +		err = pm_runtime_force_suspend(device);
> +		if (err)
> +			return err;
> +	}
>   
>   	return 0;
>   }
> @@ -1799,11 +1798,18 @@ static int __maybe_unused flexcan_noirq_resume(struct device *device)
>   	struct flexcan_priv *priv = netdev_priv(dev);
>   	int err;
>   
> -	if (netif_running(dev) && device_may_wakeup(device)) {
> -		flexcan_enable_wakeup_irq(priv, false);
> -		err = flexcan_exit_stop_mode(priv);
> +	if (netif_running(dev)) {
> +		err = pm_runtime_force_resume(device);
>   		if (err)
>   			return err;
> +
> +		if (device_may_wakeup(device)) {
> +			flexcan_enable_wakeup_irq(priv, false);
> +
> +			err = flexcan_exit_stop_mode(priv);
> +			if (err)
> +				return err;
> +		}
>   	}
>   
>   	return 0;
> 
