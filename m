From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v3] can: sja1000: Add support for listen-only mode and
 one-shot mode
Date: Wed, 19 Sep 2012 09:33:10 +0200
Message-ID: <50597536.10703@grandegger.com>
References: <50595E93.2030307@gaisler.com> <1348038735-3218-1-git-send-email-andreas@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:42281 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754624Ab2ISHdV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 19 Sep 2012 03:33:21 -0400
In-Reply-To: <1348038735-3218-1-git-send-email-andreas@gaisler.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: linux-can@vger.kernel.org, software@gaisler.com

Hi Andreas,

looks nice now. Just some final comments from my side...

On 09/19/2012 09:12 AM, Andreas Larsson wrote:
> One-shot mode uses the TCS bit of the status register to discern
> whether the transmission was successful or not. On a failed
> transmission frames are not echoed back.
> 
> When one-shot mode is not enabled, no transmit interrupt is generated
> by a failed transmission. Therefore, the branch in the interrupt
> handler that frees the echo skb is never triggered unless one-shot
> mode is enabled.
> 
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
> ---
>  drivers/net/can/sja1000/sja1000.c |   29 ++++++++++++++++++++++-------
>  1 files changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
> index 4c4f33d..fb39461 100644
> --- a/drivers/net/can/sja1000/sja1000.c
> +++ b/drivers/net/can/sja1000/sja1000.c
> @@ -156,7 +156,10 @@ static void set_normal_mode(struct net_device *dev)
>  		}
>  
>  		/* set chip to normal mode */
> -		priv->write_reg(priv, REG_MOD, 0x00);
> +		if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> +			priv->write_reg(priv, REG_MOD, MOD_LOM);
> +		else
> +			priv->write_reg(priv, REG_MOD, 0x00);
>  		udelay(10);
>  		status = priv->read_reg(priv, REG_MOD);
>  	}
> @@ -310,7 +313,10 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buff *skb,
>  
>  	can_put_echo_skb(skb, dev, 0);
>  
> -	sja1000_write_cmdreg(priv, CMD_TR);
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
> +		sja1000_write_cmdreg(priv, CMD_TR | CMD_AT);
> +	else
> +		sja1000_write_cmdreg(priv, CMD_TR);
>  
>  	return NETDEV_TX_OK;
>  }
> @@ -505,10 +511,18 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
>  			netdev_warn(dev, "wakeup interrupt\n");
>  
>  		if (isrc & IRQ_TI) {
> -			/* transmission complete interrupt */
> -			stats->tx_bytes += priv->read_reg(priv, REG_FI) & 0xf;
> -			stats->tx_packets++;
> -			can_get_echo_skb(dev, 0);
> +			/* transmission buffer released */
> +			if (status & SR_TCS) {
> +				/* transmission complete */
> +				stats->tx_bytes +=
> +					priv->read_reg(priv, REG_FI) & 0xf;
> +				stats->tx_packets++;
> +				can_get_echo_skb(dev, 0);
> +			} else {
> +				/* reachable only in one-shot mode */
> +				stats->tx_errors++;
> +				can_free_echo_skb(dev, 0);
> +			}

I would prefer not touching the original path:

			if (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT &&
			    !(status & SR_TCS) {
				/* reachable only in one-shot mode */
				stats->tx_errors++;
				can_free_echo_skb(dev, 0);
			} else {
				/* transmission complete */
				stats->tx_bytes +=
					priv->read_reg(priv, REG_FI) & 0xf;
				stats->tx_packets++;
				can_get_echo_skb(dev, 0);
			}

With that change you can add my:

Acked-by: Wolfgang Grandegger <wg@grandegger.com>

Thanks,

Wolfgang.
