From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: Re: [RFC PATCH 01/14] can: flexcan: fix irq
 flooding by clearing all interrupt sources
Date: Wed, 07 Dec 2011 16:04:06 +0100
Message-ID: <4EDF8066.4000908@grandegger.com>
References: <1323269728-17491-1-git-send-email-wg@grandegger.com>
	<1323269728-17491-2-git-send-email-wg@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
In-Reply-To: <1323269728-17491-2-git-send-email-wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
List-Unsubscribe: <https://lists.berlios.de/mailman/options/socketcan-users>,
	<mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.berlios.de/pipermail/socketcan-users>
List-Post: <mailto:socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
List-Help: <mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=help>
List-Subscribe: <https://lists.berlios.de/mailman/listinfo/socketcan-users>,
	<mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=subscribe>
Sender: socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
Errors-To: socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
To: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Cc: socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org, Reuben Dowle <Reuben.Dowle-LjHtMTQxemvQT0dZR+AlfA@public.gmane.org>, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-can.vger.kernel.org

On 12/07/2011 03:55 PM, Wolfgang Grandegger wrote:
> As pointed out by Reuben Dowle, the TWRN_INT, RWRN_INT, BOFF_INT
> interrupt sources need to be cleared as well to avoid interrupt
> flooding, at least for the Flexcan on i.MX28 SOCs.
> 
> CC: Reuben Dowle <Reuben.Dowle-LjHtMTQxemvQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>

Argh, I just realize that the commit messages have be swapped. Please
take the one from 

[RFC PATCH 03/14] can: flexcan: only for bus error reporting enable berr interrupt

So far, the bus error (berr) interrupt source is always enabled,
even if bus error reporting is not requested (via ctrlmode flag
CAN_CTRLMODE_BERR_REPORTING). This is not necessay, at least on
the Flexcan of the i.MX28 SOC and it avoids flooding with with
bus error interrupts. State changes interrupts do still arrive
as documented. The function flexcan_has_and_handle_berr() has
been removed and error state changes and bus errors are now
packed into one error message by a common poll function, like
for other CAN controllers.

Puh, managing 14 patches is not a trivial task, at least for me!

Wolfgang.

> ---
>  drivers/net/can/flexcan.c |   67 ++++++++++++++++-----------------------------
>  1 files changed, 24 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 165a4c7..feb8e64 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -118,6 +118,9 @@
>  	(FLEXCAN_ESR_TWRN_INT | FLEXCAN_ESR_RWRN_INT | FLEXCAN_ESR_BOFF_INT)
>  #define FLEXCAN_ESR_ERR_ALL \
>  	(FLEXCAN_ESR_ERR_BUS | FLEXCAN_ESR_ERR_STATE)
> +#define FLEXCAN_ESR_ALL_INT \
> +	(FLEXCAN_ESR_TWRN_INT | FLEXCAN_ESR_RWRN_INT | \
> +	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT)
>  
>  /* FLEXCAN interrupt flag register (IFLAG) bits */
>  #define FLEXCAN_TX_BUF_ID		8
> @@ -224,13 +227,6 @@ static void flexcan_transceiver_switch(const struct flexcan_priv *priv, int on)
>  		priv->pdata->transceiver_switch(on);
>  }
>  
> -static inline int flexcan_has_and_handle_berr(const struct flexcan_priv *priv,
> -					      u32 reg_esr)
> -{
> -	return (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) &&
> -		(reg_esr & FLEXCAN_ESR_ERR_BUS);
> -}
> -
>  static inline void flexcan_chip_enable(struct flexcan_priv *priv)
>  {
>  	struct flexcan_regs __iomem *regs = priv->base;
> @@ -358,24 +354,6 @@ static void do_bus_err(struct net_device *dev,
>  		dev->stats.tx_errors++;
>  }
>  
> -static int flexcan_poll_bus_err(struct net_device *dev, u32 reg_esr)
> -{
> -	struct sk_buff *skb;
> -	struct can_frame *cf;
> -
> -	skb = alloc_can_err_skb(dev, &cf);
> -	if (unlikely(!skb))
> -		return 0;
> -
> -	do_bus_err(dev, cf, reg_esr);
> -	netif_receive_skb(skb);
> -
> -	dev->stats.rx_packets++;
> -	dev->stats.rx_bytes += cf->can_dlc;
> -
> -	return 1;
> -}
> -
>  static void do_state(struct net_device *dev,
>  		     struct can_frame *cf, enum can_state new_state)
>  {
> @@ -442,7 +420,7 @@ static void do_state(struct net_device *dev,
>  	}
>  }
>  
> -static int flexcan_poll_state(struct net_device *dev, u32 reg_esr)
> +static int flexcan_poll_error_state(struct net_device *dev, u32 reg_esr)
>  {
>  	struct flexcan_priv *priv = netdev_priv(dev);
>  	struct sk_buff *skb;
> @@ -462,16 +440,23 @@ static int flexcan_poll_state(struct net_device *dev, u32 reg_esr)
>  	else
>  		new_state = CAN_STATE_BUS_OFF;
>  
> -	/* state hasn't changed */
> -	if (likely(new_state == priv->can.state))
> +	/* has state changed or are there bus errros? */
> +	if (likely(new_state == priv->can.state &&
> +		  !(reg_esr & FLEXCAN_ESR_ERR_BUS)))
>  		return 0;
>  
>  	skb = alloc_can_err_skb(dev, &cf);
>  	if (unlikely(!skb))
>  		return 0;
>  
> -	do_state(dev, cf, new_state);
> -	priv->can.state = new_state;
> +	if (new_state != priv->can.state) {
> +		do_state(dev, cf, new_state);
> +		priv->can.state = new_state;
> +	}
> +
> +	if (reg_esr & FLEXCAN_ESR_ERR_BUS)
> +		do_bus_err(dev, cf, reg_esr);
> +
>  	netif_receive_skb(skb);
>  
>  	dev->stats.rx_packets++;
> @@ -540,10 +525,10 @@ static int flexcan_poll(struct napi_struct *napi, int quota)
>  	 * The error bits are cleared on read,
>  	 * use saved value from irq handler.
>  	 */
> -	reg_esr = flexcan_read(&regs->esr) | priv->reg_esr;
> +	reg_esr = priv->reg_esr;
>  
> -	/* handle state changes */
> -	work_done += flexcan_poll_state(dev, reg_esr);
> +	/* handle bus error amd state changes */
> +	work_done += flexcan_poll_error_state(dev, reg_esr);
>  
>  	/* handle RX-FIFO */
>  	reg_iflag1 = flexcan_read(&regs->iflag1);
> @@ -553,10 +538,6 @@ static int flexcan_poll(struct napi_struct *napi, int quota)
>  		reg_iflag1 = flexcan_read(&regs->iflag1);
>  	}
>  
> -	/* report bus errors */
> -	if (flexcan_has_and_handle_berr(priv, reg_esr) && work_done < quota)
> -		work_done += flexcan_poll_bus_err(dev, reg_esr);
> -
>  	if (work_done < quota) {
>  		napi_complete(napi);
>  		/* enable IRQs */
> @@ -577,7 +558,9 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
>  
>  	reg_iflag1 = flexcan_read(&regs->iflag1);
>  	reg_esr = flexcan_read(&regs->esr);
> -	flexcan_write(FLEXCAN_ESR_ERR_INT, &regs->esr);	/* ACK err IRQ */
> +	/* ACK all bus error and state change IRQ sources */
> +	if (reg_esr & FLEXCAN_ESR_ALL_INT)
> +		flexcan_write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
>  
>  	/*
>  	 * schedule NAPI in case of:
> @@ -586,13 +569,11 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
>  	 * - bus error IRQ and bus error reporting is activated
>  	 */
>  	if ((reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) ||
> -	    (reg_esr & FLEXCAN_ESR_ERR_STATE) ||
> -	    flexcan_has_and_handle_berr(priv, reg_esr)) {
> +	    (reg_esr & FLEXCAN_ESR_ALL_INT)) {
>  		/*
> -		 * The error bits are cleared on read,
> -		 * save them for later use.
> +		 * save esr at interrupt time for later use in poll function
>  		 */
> -		priv->reg_esr = reg_esr & FLEXCAN_ESR_ERR_BUS;
> +		priv->reg_esr = reg_esr;
>  		flexcan_write(FLEXCAN_IFLAG_DEFAULT &
>  			~FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->imask1);
>  		flexcan_write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
