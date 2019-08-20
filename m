From: Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH] can: flexcan: free error skb if enqueueing failed
Date: Tue, 20 Aug 2019 11:49:46 +0200
Message-ID: <6bddb702-e9ba-1c9e-7d7a-eb974d2e0fdd@geanix.com>
References: <20190715185308.104333-1-martin@geanix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190715185308.104333-1-martin@geanix.com>
Content-Language: en-US-large
Sender: netdev-owner@vger.kernel.org
To: =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

CC'ing Joakim Zhang

On 15/07/2019 20.53, Martin Hundebøll wrote:
> If the call to can_rx_offload_queue_sorted() fails, the passed skb isn't
> consumed, so the caller must do so.
> 
> Fixes: 30164759db1b ("can: flexcan: make use of rx-offload's irq_offload_fifo")
> Signed-off-by: Martin Hundebøll <martin@geanix.com>
> ---
>   drivers/net/can/flexcan.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 1c66fb2ad76b..21f39e805d42 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -688,7 +688,8 @@ static void flexcan_irq_bus_err(struct net_device *dev, u32 reg_esr)
>   	if (tx_errors)
>   		dev->stats.tx_errors++;
>   
> -	can_rx_offload_queue_sorted(&priv->offload, skb, timestamp);
> +	if (can_rx_offload_queue_sorted(&priv->offload, skb, timestamp))
> +		kfree_skb(skb);
>   }
>   
>   static void flexcan_irq_state(struct net_device *dev, u32 reg_esr)
> @@ -732,7 +733,8 @@ static void flexcan_irq_state(struct net_device *dev, u32 reg_esr)
>   	if (unlikely(new_state == CAN_STATE_BUS_OFF))
>   		can_bus_off(dev);
>   
> -	can_rx_offload_queue_sorted(&priv->offload, skb, timestamp);
> +	if (can_rx_offload_queue_sorted(&priv->offload, skb, timestamp))
> +		kfree_skb(skb);
>   }
>   
>   static inline struct flexcan_priv *rx_offload_to_priv(struct can_rx_offload *offload)
> 
