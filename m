From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v3 1/4] can: dev: Consolidate and unify state change handling
Date: Tue, 25 Nov 2014 21:55:22 +0100
Message-ID: <5474ECBA.3060505@grandegger.com>
References: <43755b0f-30ca-4baf-b3e3-410eaeab636a@GRBSR0089.marel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:35342 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbaKYUz0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 25 Nov 2014 15:55:26 -0500
In-Reply-To: <43755b0f-30ca-4baf-b3e3-410eaeab636a@GRBSR0089.marel.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, linux-can@vger.kernel.org
Cc: mkl@pengutronix.de

On 09/26/2014 07:19 PM, Andri Yngvason wrote:
> The handling of can error states is different between platforms.
> This is an attempt to correct that problem.
> 
> I've moved this handling into a generic function for changing the
> error state. This ensures that error state changes are handled
> the same way everywhere (where this function is used).

I think it's also important to note that now also *decreasing* error
states are reported.

> Changes made since last proposal:
> can: dev: remove can_errcnt_to_state
> can: dev: reduce nesting in can_change_state

Please move the changes after the "---" line below.

> Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
> ---
>  drivers/net/can/dev.c          | 94 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/can/dev.h        |  4 ++
>  include/uapi/linux/can/error.h |  1 +
>  3 files changed, 99 insertions(+)
> 
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index 02492d2..a10b6ab 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -273,6 +273,100 @@ static int can_get_bittiming(struct net_device *dev, struct can_bittiming *bt,
>  	return err;
>  }
>  
> +static void can_update_error_counters(struct net_device *dev,
> +				      enum can_state new_state)

s/can_update_error_counters/can_update_error_stats/ ?

Error counters are usually txerr/rxerr.

> +{
> +	struct can_priv *priv = netdev_priv(dev);
> +
> +	if (new_state <= priv->state)
> +		return;
> +
> +	switch (new_state) {
> +	case CAN_STATE_ERROR_ACTIVE:
> +		netdev_warn(dev, "%s: did we come from a state less than error-active?",
> +			    __func__);

Please remove __func__ here and below and use a more meaningful warning
message. Such messages should make sense to non-experts as well...
at least a little bit.

> +		break;
> +	case CAN_STATE_ERROR_WARNING:
> +		priv->can_stats.error_warning++;
> +		break;
> +	case CAN_STATE_ERROR_PASSIVE:
> +		priv->can_stats.error_passive++;
> +		break;
> +	case CAN_STATE_BUS_OFF:
> +		priv->can_stats.bus_off++;

Be careful here. This counter will also be incremented in can_bus_off().

> +		break;
> +	default:
> +		netdev_warn(dev, "%s: %d is not a state", __func__, new_state);

"%d is not a valid state" ?

> +		break;
> +	};
> +}
> +
> +static int can_txstate_to_frame(struct net_device *dev, enum can_state state)

s/txstate/tx_state/ ?

> +{
> +	switch (state) {
> +	case CAN_STATE_ERROR_ACTIVE:
> +		return CAN_ERR_CRTL_ACTIVE;
> +	case CAN_STATE_ERROR_WARNING:
> +		return CAN_ERR_CRTL_TX_WARNING;
> +	case CAN_STATE_ERROR_PASSIVE:
> +		return CAN_ERR_CRTL_TX_PASSIVE;
> +	case CAN_STATE_BUS_OFF:
> +		netdev_warn(dev, "%s: bus-off is not handled here", __func__);

Then we may silently ignore it?

> +		return 0;
> +	default:
> +		netdev_warn(dev, "%s: %d is not a state", __func__, state);
> +		return 0;
> +	}
> +}
> +
> +static int can_rxstate_to_frame(struct net_device *dev, enum can_state state)

s/rxstate/rx_state/

> +{
> +	switch (state) {
> +	case CAN_STATE_ERROR_ACTIVE:
> +		return CAN_ERR_CRTL_ACTIVE;
> +	case CAN_STATE_ERROR_WARNING:
> +		return CAN_ERR_CRTL_RX_WARNING;
> +	case CAN_STATE_ERROR_PASSIVE:
> +		return CAN_ERR_CRTL_RX_PASSIVE;
> +	case CAN_STATE_BUS_OFF:
> +		netdev_warn(dev, "%s: bus-off is not handled here", __func__);
> +		return 0;

See above.

> +	default:
> +		netdev_warn(dev, "%s: %d is not a state", __func__, state);
> +		return 0;
> +	}
> +}
> +
> +void can_change_state(struct net_device *dev, struct can_frame *cf,
> +		      enum can_state new_state, enum can_state tx_state,
> +		      enum can_state rx_state)
> +{
> +	struct can_priv *priv = netdev_priv(dev);
> +
> +	if (unlikely(new_state == priv->state)) {
> +		netdev_warn(dev, "%s: oops, state did not change", __func__);
> +		return;
> +	}
> +
> +	can_update_error_counters(dev, new_state);
> +	priv->state = new_state;
> +
> +	if (unlikely(new_state == CAN_STATE_BUS_OFF)) {
> +		cf->can_id |= CAN_ERR_BUSOFF;
> +		return;
> +	}
> +
> +	if (unlikely(tx_state != new_state && rx_state != new_state))
> +		netdev_warn(dev, "%s: neither rx nor tx state match new state", __func__);

Is this worth a warning or is it even an error?

> +
> +	cf->can_id |= CAN_ERR_CRTL;
> +	cf->data[1] |= tx_state >= rx_state ?
> +		       can_txstate_to_frame(dev, tx_state) : 0;
> +	cf->data[1] |= tx_state <= rx_state ?
> +		       can_rxstate_to_frame(dev, rx_state) : 0;

OK, I can live with that solution.

> +}
> +EXPORT_SYMBOL_GPL(can_change_state);
> +
>  /*
>   * Local echo of CAN messages
>   *
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 6992afc..1902bff 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -121,6 +121,10 @@ void unregister_candev(struct net_device *dev);
>  int can_restart_now(struct net_device *dev);
>  void can_bus_off(struct net_device *dev);
>  
> +void can_change_state(struct net_device *dev, struct can_frame *cf,
> +		      enum can_state new_state, enum can_state tx_state,
> +		      enum can_state rx_state);
> +
>  void can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
>  		      unsigned int idx);
>  unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx);
> diff --git a/include/uapi/linux/can/error.h b/include/uapi/linux/can/error.h
> index c247446..1c508be 100644
> --- a/include/uapi/linux/can/error.h
> +++ b/include/uapi/linux/can/error.h
> @@ -71,6 +71,7 @@
>  #define CAN_ERR_CRTL_TX_PASSIVE  0x20 /* reached error passive status TX */
>  				      /* (at least one error counter exceeds */
>  				      /* the protocol-defined level of 127)  */
> +#define CAN_ERR_CRTL_ACTIVE      0x40 /* recovered to error active state */
>  
>  /* error in CAN protocol (type) / data[2] */
>  #define CAN_ERR_PROT_UNSPEC      0x00 /* unspecified */
> 

