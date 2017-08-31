From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 4/6] can: flexcan: mitigate error interrupt flooding
Date: Thu, 31 Aug 2017 14:06:21 +0200
Message-ID: <a1e82c3a-1632-7692-6014-c59ab4298883@grandegger.com>
References: <9c55377c42d7481688123dd5fe3a775c@SGPMBX1017.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy03.manitu.net ([217.11.48.67]:36860 "EHLO
        mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbdHaMGY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 31 Aug 2017 08:06:24 -0400
In-Reply-To: <9c55377c42d7481688123dd5fe3a775c@SGPMBX1017.APAC.bosch.com>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

Hello,

I think patch 3..6 can be squashed. They implement
FLEXCAN_QUIRK_BROKEN_PERR_STATE.

Am 31.08.2017 um 10:26 schrieb ZHU Yi (ST-FIR/ENG1-Zhu):
>>From 48c96795a780413eeb22f01ca6fff2e2de69bf5b Mon Sep 17 00:00:00 2001
> From: Zhu Yi <yi.zhu5@cn.bosch.com>
> Date: Thu, 31 Aug 2017 10:20:34 +0800
> Subject: [PATCH 4/6] can: flexcan: mitigate error interrupt flooding
> 
> Error interrupt flooding may happen if the broken error state quirk
> fix is enabled. For example, in case there is singled out node on
> the bus and the node sends a frame, then error interrupt flooding
> happens and will not stop because the node cannot go to bus off. The
> flooding will stop after another node connected to the bus again.
> 
> If high bitrate configured on the low end system, then the flooding
> may causes performance issue, hence, this patch mitigates this by:
> 1. disable error interrupt upon error passive state transition
> 2. re-enable error interrupt upon error warning state transition
> 
> In this way, the driver is still able to report correct state
> transitions without additional latency. And flooding of error
> interrupts is limited to the number of frames required to change
> the state to error passive when there are bus problems.
> 
> Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
> Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
> ---
>   drivers/net/can/flexcan.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 40 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 712b7de..148d8c0 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -582,7 +582,7 @@ static void flexcan_irq_bus_err(struct net_device *dev, u32 reg_esr)
>   	can_rx_offload_irq_queue_err_skb(&priv->offload, skb);
>   }
>   
> -static void flexcan_irq_state(struct net_device *dev, u32 reg_esr)
> +static bool flexcan_irq_state(struct net_device *dev, u32 reg_esr)
>   {
>   	struct flexcan_priv *priv = netdev_priv(dev);
>   	struct sk_buff *skb;
> @@ -608,11 +608,11 @@ static void flexcan_irq_state(struct net_device *dev, u32 reg_esr)
>   
>   	/* state hasn't changed */
>   	if (likely(new_state == priv->can.state))
> -		return;
> +		return false;
>   
>   	skb = alloc_can_err_skb(dev, &cf);
>   	if (unlikely(!skb))
> -		return;
> +		return false;
>   
>   	can_change_state(dev, cf, tx_state, rx_state);
>   
> @@ -620,6 +620,7 @@ static void flexcan_irq_state(struct net_device *dev, u32 reg_esr)
>   		can_bus_off(dev);
>   
>   	can_rx_offload_irq_queue_err_skb(&priv->offload, skb);
> +	return true;
>   }
>   
>   static inline struct flexcan_priv *rx_offload_to_priv(struct can_rx_offload *offload)
> @@ -713,7 +714,8 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
>   	struct flexcan_priv *priv = netdev_priv(dev);
>   	struct flexcan_regs __iomem *regs = priv->regs;
>   	irqreturn_t handled = IRQ_NONE;
> -	u32 reg_iflag1, reg_esr;
> +	u32 reg_iflag1, reg_esr, reg_ctrl;
> +	bool state_changed = false;
>   
>   	reg_iflag1 = flexcan_read(&regs->iflag1);
>   
> @@ -770,13 +772,46 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
>   	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
>   	    (priv->devtype_data->quirks & FLEXCAN_QUIRK_BROKEN_WERR_STATE) ||
>   	    (priv->devtype_data->quirks & FLEXCAN_QUIRK_BROKEN_PERR_STATE))
> -		flexcan_irq_state(dev, reg_esr);
> +		state_changed = flexcan_irq_state(dev, reg_esr);
>   
>   	/* bus error IRQ - handle if bus error reporting is activated */
>   	if ((reg_esr & FLEXCAN_ESR_ERR_BUS) &&
>   	    (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
>   		flexcan_irq_bus_err(dev, reg_esr);
>   
> +	/* availability of error interrupt among state transitions in case
> +	 * bus error reporting is de-activated and broken error passive
> +	 * state quirk fix is enabled:
> +	 *  +--------------------------------------------------------------+
> +	 *  | +----------------------------------------------+ [stopped /  |
> +	 *  | |                                              |  sleeping] -+
> +	 *  +-+-> active <-> warning <-> passive -> bus off -+
> +	 *        ^^^^^^^^^^^^^^^^^^^^^^^_______________________________
> +	 *                enabled                      disabled
> +	 */
> +	if (state_changed &&
> +	    (priv->devtype_data->quirks & FLEXCAN_QUIRK_BROKEN_PERR_STATE) &&
> +	   !(priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)) {
> +		switch (priv->can.state) {
> +		case CAN_STATE_ERROR_PASSIVE:
> +		case CAN_STATE_BUS_OFF:
> +			reg_ctrl = flexcan_read(&regs->ctrl);
> +			reg_ctrl &= ~FLEXCAN_CTRL_ERR_MSK;
> +			flexcan_write(reg_ctrl, &regs->ctrl);
> +			break;
> +
> +		case CAN_STATE_ERROR_WARNING:
> +		case CAN_STATE_ERROR_ACTIVE:
> +			reg_ctrl = flexcan_read(&regs->ctrl);
> +			reg_ctrl |= FLEXCAN_CTRL_ERR_MSK;
> +			flexcan_write(reg_ctrl, &regs->ctrl);
> +			break;
> +
> +		default:
> +			break;
> +		}
> +	}

I think it's enough if we  enable the error interrupt just between error 
warning and error passive.

Wolfgang.
