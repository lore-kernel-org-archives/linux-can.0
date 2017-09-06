From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 3/4] can: flexcan: implement error passive state quirk
Date: Wed, 6 Sep 2017 13:47:38 +0200
Message-ID: <cc678b44-0aa8-ac91-567e-8b9c234ed024@grandegger.com>
References: <87faf67d90a246938e0b51d2ddbc8b82@SGPMBX1017.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy02.manitu.net ([217.11.48.66]:45354 "EHLO
        mailproxy02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753586AbdIFLrm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 6 Sep 2017 07:47:42 -0400
In-Reply-To: <87faf67d90a246938e0b51d2ddbc8b82@SGPMBX1017.APAC.bosch.com>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

Hello,

Am 05.09.2017 um 10:39 schrieb ZHU Yi (ST-FIR/ENG1-Zhu):
>>From a44bf37a7276d8b985f7bdc92f094af80daeb3f9 Mon Sep 17 00:00:00 2001
> From: Zhu Yi <yi.zhu5@cn.bosch.com>
> Date: Thu, 31 Aug 2017 09:21:24 +0800
> Subject: [PATCH 3/4] can: flexcan: implement error passive state quirk
> 
> Add FLEXCAN_QUIRK_BROKEN_PERR_STATE for better description
> of the missing error passive interrupt quirk.
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
> 3. disable/enable error interrupt upon error active state transition
>     depends on FLEXCAN_QUIRK_BROKEN_WERR_STATE
> 
> In this way, the driver is still able to report correct state
> transitions without additional latency. When there are bus problems,
> flooding of error interrupts is limited to the number of frames
> required to change state from error warning to error passive if the
> core has [TR]WRN_INT connected (FLEXCAN_QUIRK_BROKEN_WERR_STATE is
> not enabled), otherwise, the flooding is limited to the number of
> frames required to change state from error active to error passive.
> 
> Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
> Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
> ---
>   drivers/net/can/flexcan.c | 79 +++++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 70 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index e163c55..52b69fc 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -182,14 +182,14 @@
>   /* FLEXCAN hardware feature flags
>    *
>    * Below is some version info we got:
> - *    SOC   Version   IP-Version  Glitch- [TR]WRN_INT Memory err RTR re-
> - *                                Filter? connected?  detection  ception in MB
> - *   MX25  FlexCAN2  03.00.00.00     no        no         no        no
> - *   MX28  FlexCAN2  03.00.04.00    yes       yes         no        no
> - *   MX35  FlexCAN2  03.00.00.00     no        no         no        no
> - *   MX53  FlexCAN2  03.00.00.00    yes        no         no        no
> - *   MX6s  FlexCAN3  10.00.12.00    yes       yes         no       yes
> - *   VF610 FlexCAN3  ?               no       yes        yes       yes?
> + *    SOC   Version   IP-Version  Glitch- [TR]WRN_INT IRQ Err Memory err RTR re-
> + *                                Filter? connected?  Passive detection  ception in MB
> + *   MX25  FlexCAN2  03.00.00.00     no        no         ?       no        no
> + *   MX28  FlexCAN2  03.00.04.00    yes       yes         ?       no        no
> + *   MX35  FlexCAN2  03.00.00.00     no        no         ?       no        no
> + *   MX53  FlexCAN2  03.00.00.00    yes        no        no?      no        no
> + *   MX6s  FlexCAN3  10.00.12.00    yes       yes        no       no       yes
> + *   VF610 FlexCAN3  ?               no       yes         ?      yes       yes?
>    *
>    * Some SOCs do not have the RX_WARN & TX_WARN interrupt line connected.
>    */
> @@ -198,6 +198,7 @@
>   #define FLEXCAN_QUIRK_ENABLE_EACEN_RRS	BIT(3) /* Enable EACEN and RRS bit in ctrl2 */
>   #define FLEXCAN_QUIRK_DISABLE_MECR	BIT(4) /* Disable Memory error detection */
>   #define FLEXCAN_QUIRK_USE_OFF_TIMESTAMP	BIT(5) /* Use timestamp based offloading */
> +#define FLEXCAN_QUIRK_BROKEN_PERR_STATE	BIT(6) /* No interrupt for error passive */
>   
>   /* Structure of the message buffer */
>   struct flexcan_mb {
> @@ -335,6 +336,26 @@ static inline void flexcan_write(u32 val, void __iomem *addr)
>   }
>   #endif
>   
> +static inline void flexcan_error_irq_enable(const struct flexcan_priv *priv)
> +{
> +	struct flexcan_regs __iomem *regs = priv->regs;
> +	u32 reg_ctrl;
> +
> +	reg_ctrl = flexcan_read(&regs->ctrl);
> +	reg_ctrl |= FLEXCAN_CTRL_ERR_MSK;
> +	flexcan_write(reg_ctrl, &regs->ctrl);
> +}
> +
> +static inline void flexcan_error_irq_disable(const struct flexcan_priv *priv)
> +{
> +	struct flexcan_regs __iomem *regs = priv->regs;
> +	u32 reg_ctrl;
> +
> +	reg_ctrl = flexcan_read(&regs->ctrl);
> +	reg_ctrl &= ~FLEXCAN_CTRL_ERR_MSK;
> +	flexcan_write(reg_ctrl, &regs->ctrl);
> +}
> +
>   static inline int flexcan_transceiver_enable(const struct flexcan_priv *priv)
>   {
>   	if (!priv->reg_xceiver)
> @@ -713,6 +734,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
>   	struct flexcan_regs __iomem *regs = priv->regs;
>   	irqreturn_t handled = IRQ_NONE;
>   	u32 reg_iflag1, reg_esr;
> +	enum can_state last_state = priv->can.state;
>   
>   	reg_iflag1 = flexcan_read(&regs->iflag1);
>   
> @@ -767,7 +789,8 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
>   
>   	/* state change interrupt or broken error state quirk fix is enabled */
>   	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
> -	    (priv->devtype_data->quirks & FLEXCAN_QUIRK_BROKEN_WERR_STATE))
> +	    (priv->devtype_data->quirks & (FLEXCAN_QUIRK_BROKEN_WERR_STATE |
> +	                                   FLEXCAN_QUIRK_BROKEN_PERR_STATE)))
>   		flexcan_irq_state(dev, reg_esr);
>   
>   	/* bus error IRQ - handle if bus error reporting is activated */
> @@ -775,6 +798,44 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
>   	    (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
>   		flexcan_irq_bus_err(dev, reg_esr);
>   
> +	/* availability of error interrupt among state transitions in case
> +	 * bus error reporting is de-activated and
> +	 * FLEXCAN_QUIRK_BROKEN_PERR_STATE is enabled:
> +	 *  +--------------------------------------------------------------+
> +	 *  | +----------------------------------------------+ [stopped /  |
> +	 *  | |                                              |  sleeping] -+
> +	 *  +-+-> active <-> warning <-> passive -> bus off -+
> +	 *        ___________^^^^^^^^^^^^_______________________________
> +	 *        disabled(1)  enabled             disabled
> +	 *
> +	 * (1): enabled if FLEXCAN_QUIRK_BROKEN_WERR_STATE is enabled
> +	 */
> +	if ((last_state != priv->can.state) &&
> +	    (priv->devtype_data->quirks & FLEXCAN_QUIRK_BROKEN_PERR_STATE) &&
> +	   !(priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)) {

This block is only entered when FLEXCAN_QUIRK_BROKEN_PERR_STATE is set
but not for legacy cores. Or have I missed something.

> +		switch (priv->can.state) {
> +		case CAN_STATE_ERROR_ACTIVE:
> +			if (priv->devtype_data->quirks &
> +			    FLEXCAN_QUIRK_BROKEN_WERR_STATE)
> +				flexcan_error_irq_enable(priv);
> +			else
> +				flexcan_error_irq_disable(priv);
> +			break;
> +
> +		case CAN_STATE_ERROR_WARNING:
> +			flexcan_error_irq_enable(priv);
> +			break;
> +
> +		case CAN_STATE_ERROR_PASSIVE:
> +		case CAN_STATE_BUS_OFF:
> +			flexcan_error_irq_disable(priv);
> +			break;
> +
> +		default:
> +			break;
> +		}
> +	}
> +
>   	return handled;
>   }

Hope to find some time this week to test the patches on my i.MX53 and 
i.MX28 boards.

Wolfgang.

