From: Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH 1/2] can: flexcan: add support for DT property
 'wakeup-source'
Date: Sat, 8 Jun 2019 19:36:20 +0200
Message-ID: <61ce24fa-34ca-326a-dcd2-75d2783c43c8@geanix.com>
References: <20190409083949.27917-1-sean@geanix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190409083949.27917-1-sean@geanix.com>
Content-Language: en-US-large
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org, linux-can@vger.kernel.org, mkl@pengutronix.de, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, aisheng.dong@nxp.com, qiangqing.zhang@nxp.com
List-Id: linux-can.vger.kernel.org

kind ping :-)

On 09/04/2019 10.39, Sean Nyekjaer wrote:
> The flexcan controller can be forced as a wakeup source by
> stating that explicitly in the device's .dts file using the
> "wakeup-source" boolean property.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   drivers/net/can/flexcan.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index c46e6ce22701..df3d2abd98e4 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -1373,6 +1373,9 @@ static int flexcan_setup_stop_mode(struct platform_device *pdev)
>   
>   	device_set_wakeup_capable(&pdev->dev, true);
>   
> +	if (of_property_read_bool(np, "wakeup-source"))
> +		device_set_wakeup_enable(&pdev->dev, true);
> +
>   	return 0;
>   }
>   
> 
