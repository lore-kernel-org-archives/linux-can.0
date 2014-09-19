From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 1/4] Consolidate and unify state change handling
Date: Fri, 19 Sep 2014 22:33:10 +0200
Message-ID: <541C9306.1020800@grandegger.com>
References: <541B078C.2020007@marel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:53286 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757906AbaISUdQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 19 Sep 2014 16:33:16 -0400
In-Reply-To: <541B078C.2020007@marel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 09/18/2014 06:25 PM, Andri Yngvason wrote:

Please add a brief patch description. E.g. what is it good for and what
does it improve.

> Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
> ---
>  drivers/net/can/dev.c          | 79
> ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/can/dev.h        | 10 ++++++
>  include/uapi/linux/can/error.h |  1 +
>  3 files changed, 90 insertions(+)
> 
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index 02492d2..d238b68 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -273,6 +273,85 @@ static int can_get_bittiming(struct net_device
> *dev, struct can_bittiming *bt,
>      return err;
>  }
> 
> +enum can_err_dir can_get_err_dir(unsigned int txerr, unsigned int rxerr)
> +{
> +    if (txerr > rxerr)
> +        return CAN_ERR_DIR_TX;
> +
> +    if (rxerr < rxerr)
> +        return CAN_ERR_DIR_RX;
> +
> +    return CAN_ERR_DIR_UNKNOWN;
> +}
> +EXPORT_SYMBOL_GPL(can_get_err_dir);
> +
> +static int can_make_state_warning(enum can_err_dir err_dir)
> +{
> +    switch (err_dir) {
> +    case CAN_ERR_DIR_TX:
> +        return CAN_ERR_CRTL_TX_WARNING;
> +    case CAN_ERR_DIR_RX:
> +        return CAN_ERR_CRTL_RX_WARNING;
> +    default:
> +        return CAN_ERR_CRTL_TX_WARNING | CAN_ERR_CRTL_RX_WARNING;
> +    }
> +}
> +
> +static int can_make_state_passive(enum can_err_dir err_dir)
> +{
> +    switch (err_dir) {
> +    case CAN_ERR_DIR_TX:
> +        return CAN_ERR_CRTL_TX_PASSIVE;
> +    case CAN_ERR_DIR_RX:
> +        return CAN_ERR_CRTL_RX_PASSIVE;
> +    default:
> +        return CAN_ERR_CRTL_TX_PASSIVE | CAN_ERR_CRTL_RX_PASSIVE;
> +    }
> +}
> +
> +void can_change_state(struct net_device *dev, struct can_frame *cf,
> +              enum can_state state, enum can_err_dir err_dir)

Thinking about it... passing txerr and rxerr directly here would make
the err_dir obsolete and the code more simpler. CAN controllers
not supporting tx/rx error counter should pass "0, 0".

Also s/state/new_state/ would improve readability.

> +{
> +    struct can_priv *priv = netdev_priv(dev);
> +
> +    if (unlikely(state == priv->state)) {
> +        netdev_warn(dev, "%s: oops, state did not change", __func__);
> +        return;
> +    }
> +
> +    if (state != CAN_STATE_BUS_OFF)
> +        cf->can_id |= CAN_ERR_CRTL;
> +
> +    switch (state) {
> +    case CAN_STATE_ERROR_WARNING:
> +        if (state > priv->state)
> +            priv->can_stats.error_warning++;
> +        cf->data[1] = can_make_state_warning(err_dir);
> +        break;
> +
> +    case CAN_STATE_ERROR_PASSIVE:
> +        if (state > priv->state)
> +            priv->can_stats.error_passive++;
> +        cf->data[1] = can_make_state_passive(err_dir);
> +        break;
> +
> +    case CAN_STATE_ERROR_ACTIVE:
> +        cf->data[1] = CAN_ERR_CRTL_ACTIVE;
> +        break;
> +
> +    case CAN_STATE_BUS_OFF:
> +        priv->can_stats.bus_off++;
> +        cf->can_id |= CAN_ERR_BUSOFF;
> +        break;
> +
> +    default:

A netdev_warn would be nice here.

> +        break;
> +    };
> +
> +    priv->state = state;
> +}
> +EXPORT_SYMBOL_GPL(can_change_state);
> +
>  /*
>   * Local echo of CAN messages
>   *
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 6992afc..9ef20fe 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -27,6 +27,12 @@ enum can_mode {
>      CAN_MODE_SLEEP
>  };
> 
> +enum can_err_dir {
> +    CAN_ERR_DIR_UNKNOWN = 0,
> +    CAN_ERR_DIR_RX,
> +    CAN_ERR_DIR_TX
> +};

See my comment above.

>  /*
>   * CAN common private data
>   */
> @@ -121,6 +127,10 @@ void unregister_candev(struct net_device *dev);
>  int can_restart_now(struct net_device *dev);
>  void can_bus_off(struct net_device *dev);
> 
> +enum can_err_dir can_get_err_dir(unsigned int txerr, unsigned int rxerr);
> +void can_change_state(struct net_device *dev, struct can_frame *cf,
> +        enum can_state state, enum can_err_dir err_dir);
> +
>  void can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
>                unsigned int idx);
>  unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx);
> diff --git a/include/uapi/linux/can/error.h
> b/include/uapi/linux/can/error.h
> index c247446..1c508be 100644
> --- a/include/uapi/linux/can/error.h
> +++ b/include/uapi/linux/can/error.h
> @@ -71,6 +71,7 @@
>  #define CAN_ERR_CRTL_TX_PASSIVE  0x20 /* reached error passive status
> TX */
>                        /* (at least one error counter exceeds */
>                        /* the protocol-defined level of 127)  */
> +#define CAN_ERR_CRTL_ACTIVE      0x40 /* recovered to error active
> state */
> 
>  /* error in CAN protocol (type) / data[2] */
>  #define CAN_ERR_PROT_UNSPEC      0x00 /* unspecified */
> -- 

Wolfgang.



