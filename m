From: Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH V2 3/4] can: flexcan: change the way of stop mode
 acknowledgment
Date: Wed, 27 Nov 2019 10:58:53 +0100
Message-ID: <9924005b-6136-534d-4a5d-e41716803038@geanix.com>
References: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
 <20191127055334.1476-4-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191127055334.1476-4-qiangqing.zhang@nxp.com>
Content-Language: en-US-large
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org



On 27/11/2019 06.56, Joakim Zhang wrote:
> Stop mode is entered when Stop mode is requested at chip level and
> MCR[LPM_ACK] is asserted by the FlexCAN.
> 
> Double check with IP owner, should poll MCR[LPM_ACK] for stop mode
> acknowledgment, not the acknowledgment from chip level which is used
> for glitch filter.
> 
> Fixes: 5f186c257fa4(can: flexcan: fix stop mode acknowledgment)
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Tested-by: Sean Nyekjaer <sean@geanix.com>
> ------
> ChangeLog:
> 	V1->V2: no change.
> ---
>   drivers/net/can/flexcan.c | 64 ++++++++++++++++++++-------------------
>   1 file changed, 33 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 5d5ed28d3005..d178146b3da5 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -388,6 +388,34 @@ static struct flexcan_mb __iomem *flexcan_get_mb(const struct flexcan_priv *priv
>   		(&priv->regs->mb[bank][priv->mb_size * mb_index]);
>   }
>   
> +static int flexcan_enter_low_power_ack(struct flexcan_priv *priv)
> +{
> +	struct flexcan_regs __iomem *regs = priv->regs;
> +	unsigned int timeout = FLEXCAN_TIMEOUT_US / 10;
> +
> +	while (timeout-- && !(priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
> +		udelay(10);
> +
> +	if (!(priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +static int flexcan_exit_low_power_ack(struct flexcan_priv *priv)
> +{
> +	struct flexcan_regs __iomem *regs = priv->regs;
> +	unsigned int timeout = FLEXCAN_TIMEOUT_US / 10;
> +
> +	while (timeout-- && (priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
> +		udelay(10);
> +
> +	if (priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK)
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
>   static void flexcan_enable_wakeup_irq(struct flexcan_priv *priv, bool enable)
>   {
>   	struct flexcan_regs __iomem *regs = priv->regs;
> @@ -406,7 +434,6 @@ static void flexcan_enable_wakeup_irq(struct flexcan_priv *priv, bool enable)
>   static inline int flexcan_enter_stop_mode(struct flexcan_priv *priv)
>   {
>   	struct flexcan_regs __iomem *regs = priv->regs;
> -	unsigned int ackval;
>   	u32 reg_mcr;
>   
>   	reg_mcr = priv->read(&regs->mcr);
> @@ -418,35 +445,24 @@ static inline int flexcan_enter_stop_mode(struct flexcan_priv *priv)
>   			   1 << priv->stm.req_bit, 1 << priv->stm.req_bit);
>   
>   	/* get stop acknowledgment */
> -	if (regmap_read_poll_timeout(priv->stm.gpr, priv->stm.ack_gpr,
> -				     ackval, ackval & (1 << priv->stm.ack_bit),
> -				     0, FLEXCAN_TIMEOUT_US))
> -		return -ETIMEDOUT;
> -
> -	return 0;
> +	return flexcan_enter_low_power_ack(priv);
>   }
>   
>   static inline int flexcan_exit_stop_mode(struct flexcan_priv *priv)
>   {
>   	struct flexcan_regs __iomem *regs = priv->regs;
> -	unsigned int ackval;
>   	u32 reg_mcr;
>   
>   	/* remove stop request */
>   	regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
>   			   1 << priv->stm.req_bit, 0);
>   
> -	/* get stop acknowledgment */
> -	if (regmap_read_poll_timeout(priv->stm.gpr, priv->stm.ack_gpr,
> -				     ackval, !(ackval & (1 << priv->stm.ack_bit)),
> -				     0, FLEXCAN_TIMEOUT_US))
> -		return -ETIMEDOUT;
> -
>   	reg_mcr = priv->read(&regs->mcr);
>   	reg_mcr &= ~FLEXCAN_MCR_SLF_WAK;
>   	priv->write(reg_mcr, &regs->mcr);
>   
> -	return 0;
> +	/* get stop acknowledgment */
> +	return flexcan_exit_low_power_ack(priv);
>   }
>   
>   static void flexcan_try_exit_stop_mode(struct flexcan_priv *priv)
> @@ -512,39 +528,25 @@ static inline int flexcan_transceiver_disable(const struct flexcan_priv *priv)
>   static int flexcan_chip_enable(struct flexcan_priv *priv)
>   {
>   	struct flexcan_regs __iomem *regs = priv->regs;
> -	unsigned int timeout = FLEXCAN_TIMEOUT_US / 10;
>   	u32 reg;
>   
>   	reg = priv->read(&regs->mcr);
>   	reg &= ~FLEXCAN_MCR_MDIS;
>   	priv->write(reg, &regs->mcr);
>   
> -	while (timeout-- && (priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
> -		udelay(10);
> -
> -	if (priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK)
> -		return -ETIMEDOUT;
> -
> -	return 0;
> +	return flexcan_exit_low_power_ack(priv);
>   }
>   
>   static int flexcan_chip_disable(struct flexcan_priv *priv)
>   {
>   	struct flexcan_regs __iomem *regs = priv->regs;
> -	unsigned int timeout = FLEXCAN_TIMEOUT_US / 10;
>   	u32 reg;
>   
>   	reg = priv->read(&regs->mcr);
>   	reg |= FLEXCAN_MCR_MDIS;
>   	priv->write(reg, &regs->mcr);
>   
> -	while (timeout-- && !(priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
> -		udelay(10);
> -
> -	if (!(priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
> -		return -ETIMEDOUT;
> -
> -	return 0;
> +	return flexcan_enter_low_power_ack(priv);
>   }
>   
>   static int flexcan_chip_freeze(struct flexcan_priv *priv)
> 
