From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v3 4/4] can: flexcan: Consolidate and unify state change
 handling
Date: Tue, 25 Nov 2014 22:03:24 +0100
Message-ID: <5474EE9C.7030605@grandegger.com>
References: <59767b14-4cc1-43e4-b4e9-32620c1d0118@GRBSR0089.marel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:36932 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbaKYVD0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 25 Nov 2014 16:03:26 -0500
In-Reply-To: <59767b14-4cc1-43e4-b4e9-32620c1d0118@GRBSR0089.marel.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, linux-can@vger.kernel.org
Cc: mkl@pengutronix.de

On 09/26/2014 07:31 PM, Andri Yngvason wrote:
> Replacing error state change handling with the new mechanism.
> 
> Changes made since last proposal:
> can: flexcan: improve rx/tx state recognition.

Move below "---", please.

> Note: Flexcan is problematic because there is no interrupt generated when
> transitioning between error-active and error-passive. If the bus is
> disconnected, there is no event that will trigger a napi poll, so the new state
> will not be discovered until the bus is connected. This problem goes away if
> berr-reporting is enabled, because then the ack-error takes care of it.

Well, this is a known issue and should be addressed via platform data
(using the FLEXCAN_HAS_BROKEN_ERR_STATE flags).

> 
> Another problem is that if nothing is happening on the bus, when it's connected
> again, we won't see the new state until someone transmits something on the bus.
> 
> I'd say that these are minor issues because a "healthy" bus has traffic and the
> "disconnected bus" issue has a work-around.

Would be nice to do some tests on a more recent Flexcan core as well.

> 
> Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
> ---
>  drivers/net/can/flexcan.c | 101 +++++++++-------------------------------------
>  1 file changed, 18 insertions(+), 83 deletions(-)
> 
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 60f86bd..e7dea64 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -577,98 +577,30 @@ static int flexcan_poll_bus_err(struct net_device *dev, u32 reg_esr)
>  	return 1;
>  }
>  
> -static void do_state(struct net_device *dev,
> -		     struct can_frame *cf, enum can_state new_state)
> -{
> -	struct flexcan_priv *priv = netdev_priv(dev);
> -	struct can_berr_counter bec;
> -
> -	__flexcan_get_berr_counter(dev, &bec);
> -
> -	switch (priv->can.state) {
> -	case CAN_STATE_ERROR_ACTIVE:
> -		/*
> -		 * from: ERROR_ACTIVE
> -		 * to  : ERROR_WARNING, ERROR_PASSIVE, BUS_OFF
> -		 * =>  : there was a warning int
> -		 */
> -		if (new_state >= CAN_STATE_ERROR_WARNING &&
> -		    new_state <= CAN_STATE_BUS_OFF) {
> -			netdev_dbg(dev, "Error Warning IRQ\n");
> -			priv->can.can_stats.error_warning++;
> -
> -			cf->can_id |= CAN_ERR_CRTL;
> -			cf->data[1] = (bec.txerr > bec.rxerr) ?
> -				CAN_ERR_CRTL_TX_WARNING :
> -				CAN_ERR_CRTL_RX_WARNING;
> -		}
> -	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
> -		/*
> -		 * from: ERROR_ACTIVE, ERROR_WARNING
> -		 * to  : ERROR_PASSIVE, BUS_OFF
> -		 * =>  : error passive int
> -		 */
> -		if (new_state >= CAN_STATE_ERROR_PASSIVE &&
> -		    new_state <= CAN_STATE_BUS_OFF) {
> -			netdev_dbg(dev, "Error Passive IRQ\n");
> -			priv->can.can_stats.error_passive++;
> -
> -			cf->can_id |= CAN_ERR_CRTL;
> -			cf->data[1] = (bec.txerr > bec.rxerr) ?
> -				CAN_ERR_CRTL_TX_PASSIVE :
> -				CAN_ERR_CRTL_RX_PASSIVE;
> -		}
> -		break;
> -	case CAN_STATE_BUS_OFF:
> -		netdev_err(dev, "BUG! "
> -			   "hardware recovered automatically from BUS_OFF\n");
> -		break;
> -	default:
> -		break;
> -	}
> -
> -	/* process state changes depending on the new state */
> -	switch (new_state) {
> -	case CAN_STATE_ERROR_WARNING:
> -		netdev_dbg(dev, "Error Warning\n");
> -		cf->can_id |= CAN_ERR_CRTL;
> -		cf->data[1] = (bec.txerr > bec.rxerr) ?
> -			CAN_ERR_CRTL_TX_WARNING :
> -			CAN_ERR_CRTL_RX_WARNING;
> -		break;
> -	case CAN_STATE_ERROR_ACTIVE:
> -		netdev_dbg(dev, "Error Active\n");
> -		cf->can_id |= CAN_ERR_PROT;
> -		cf->data[2] = CAN_ERR_PROT_ACTIVE;
> -		break;
> -	case CAN_STATE_BUS_OFF:
> -		cf->can_id |= CAN_ERR_BUSOFF;
> -		can_bus_off(dev);
> -		break;
> -	default:
> -		break;
> -	}
> -}
> -
>  static int flexcan_poll_state(struct net_device *dev, u32 reg_esr)
>  {
>  	struct flexcan_priv *priv = netdev_priv(dev);
>  	struct sk_buff *skb;
>  	struct can_frame *cf;
> -	enum can_state new_state;
> +	enum can_state new_state = 0, rx_state = 0, tx_state = 0;
>  	int flt;
> +	struct can_berr_counter bec;
>  
>  	flt = reg_esr & FLEXCAN_ESR_FLT_CONF_MASK;
>  	if (likely(flt == FLEXCAN_ESR_FLT_CONF_ACTIVE)) {
> -		if (likely(!(reg_esr & (FLEXCAN_ESR_TX_WRN |
> -					FLEXCAN_ESR_RX_WRN))))
> -			new_state = CAN_STATE_ERROR_ACTIVE;
> -		else
> -			new_state = CAN_STATE_ERROR_WARNING;
> -	} else if (unlikely(flt == FLEXCAN_ESR_FLT_CONF_PASSIVE))
> +		tx_state = unlikely(reg_esr & FLEXCAN_ESR_TX_WRN) ?
> +			   CAN_STATE_ERROR_WARNING : CAN_STATE_ERROR_ACTIVE;
> +		rx_state = unlikely(reg_esr & FLEXCAN_ESR_RX_WRN) ?
> +			   CAN_STATE_ERROR_WARNING : CAN_STATE_ERROR_ACTIVE;
> +		new_state = max(tx_state, rx_state);
> +	} else if (unlikely(flt == FLEXCAN_ESR_FLT_CONF_PASSIVE)) {
> +		__flexcan_get_berr_counter(dev, &bec);
>  		new_state = CAN_STATE_ERROR_PASSIVE;
> -	else
> +		rx_state = bec.rxerr >= bec.txerr ? new_state : 0;
> +		tx_state = bec.rxerr <= bec.txerr ? new_state : 0;
> +	} else {
>  		new_state = CAN_STATE_BUS_OFF;
> +	}
>  
>  	/* state hasn't changed */
>  	if (likely(new_state == priv->can.state))
> @@ -678,8 +610,11 @@ static int flexcan_poll_state(struct net_device *dev, u32 reg_esr)
>  	if (unlikely(!skb))
>  		return 0;
>  
> -	do_state(dev, cf, new_state);
> -	priv->can.state = new_state;

On SJA1000 and MSCAN you use:

	if (new_state != priv->can.state) ...

> +	can_change_state(dev, cf, new_state, tx_state, rx_state);
> +
> +	if (unlikely(new_state == CAN_STATE_BUS_OFF))
> +		can_bus_off(dev);
> +
>  	netif_receive_skb(skb);
>  
>  	dev->stats.rx_packets++;
> 

