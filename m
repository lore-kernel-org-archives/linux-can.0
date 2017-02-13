From: Anssi Hannula <anssi.hannula@bitwise.fi>
Subject: Re: [PATCH 5/5] can: xilinx_can: fix TX FIFO accounting getting out
 of sync
Date: Mon, 13 Feb 2017 16:01:10 +0200
Message-ID: <0f108f45-396f-f12f-128a-aa44f61fe547@bitwise.fi>
References: <20170213131208.20227-1-anssi.hannula@bitwise.fi>
 <20170213131208.20227-6-anssi.hannula@bitwise.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170213131208.20227-6-anssi.hannula@bitwise.fi>
Sender: stable-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Kedareswara rao Appana <appanad@xilinx.com>, stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On 13.2.2017 15:12, Anssi Hannula wrote:
> The xilinx_can driver assumes that the TXOK interrupt only clears after
> it has been acknowledged as many times as there have been successfully
> sent frames.
>
> However, the documentation does not mention such behavior, instead
> saying just that the interrupt is cleared when the clear bit is set.
>
> Similarly, testing seems to also suggest that it is immediately cleared
> regardless of the amount of frames having been sent. Performing some
> heavy TX load and then going back to idle has the tx_head drifting
> further away from tx_tail over time, steadily reducing the amount of
> frames the driver keeps in the TX FIFO (but not to zero, as the TXOK
> interrupt always frees up space for 1 frame from the driver's
> perspective, so frames continue to be sent) and delaying the local echo
> frames.
>
> The TX FIFO tracking is also otherwise buggy as it does not account for
> TX FIFO being cleared after software resets, causing
>   BUG!, TX FIFO full when queue awake!
> messages to be output.
>
> Since there does not seem to be any way to accurately track the state of
> the TX FIFO, drop the code trying to do that and perform
> netif_stop_queue() based on whether the HW reports the FIFO being full.
> Driver-side local echo support is also removed as it is not possible to
> do accurately (relying instead on the CAN core fallback support).
>
> Tested with the integrated CAN on Zynq-7000 SoC.
>
> Fixes: b1201e44f50b ("can: xilinx CAN controller support")
> Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
> Cc: <stable@vger.kernel.org>
> ---
>  drivers/net/can/xilinx_can.c | 33 +++++++++------------------------
>  1 file changed, 9 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
> index 392be77..7cfb8b6d 100644
> --- a/drivers/net/can/xilinx_can.c
> +++ b/drivers/net/can/xilinx_can.c
[...]
> @@ -832,17 +826,9 @@ static int xcan_rx_poll(struct napi_struct *napi, int quota)
>  static void xcan_tx_interrupt(struct net_device *ndev, u32 isr)
>  {
>  	struct xcan_priv *priv = netdev_priv(ndev);
> -	struct net_device_stats *stats = &ndev->stats;
>  
> -	while ((priv->tx_head - priv->tx_tail > 0) &&
> -			(isr & XCAN_IXR_TXOK_MASK)) {
> -		priv->write_reg(priv, XCAN_ICR_OFFSET, XCAN_IXR_TXOK_MASK);
> -		can_get_echo_skb(ndev, priv->tx_tail %
> -					priv->tx_max);
> -		priv->tx_tail++;
> -		stats->tx_packets++;
> -		isr = priv->read_reg(priv, XCAN_ISR_OFFSET);
> -	}
> +	priv->write_reg(priv, XCAN_ICR_OFFSET, XCAN_IXR_TXOK_MASK);
> +
>  	can_led_event(ndev, CAN_LED_EVENT_TX);
>  	xcan_update_error_state_after_rxtx(ndev);
>  	netif_wake_queue(ndev);

Hmm, actually I think this netif_wake_queue() is racy with start_xmit()
as the latter
could've filled the TX FIFO at this point...

So maybe some locking is needed here, unless there is another way this
is usually handled.

-- 
Anssi Hannula / Bitwise Oy
