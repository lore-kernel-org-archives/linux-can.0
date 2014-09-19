From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 2/4] Consolidate and unify state change handling
Date: Fri, 19 Sep 2014 23:10:48 +0200
Message-ID: <541C9BD8.8070303@grandegger.com>
References: <541B0792.5030002@marel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:59221 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757848AbaISVKv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 19 Sep 2014 17:10:51 -0400
In-Reply-To: <541B0792.5030002@marel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 09/18/2014 06:25 PM, Andri Yngvason wrote:
> Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
> ---
>  drivers/net/can/flexcan.c | 66
> +++--------------------------------------------
>  1 file changed, 3 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 2700865..96a0755 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -559,74 +559,15 @@ static int flexcan_poll_bus_err(struct net_device
> *dev, u32 reg_esr)
>  static void do_state(struct net_device *dev,
>               struct can_frame *cf, enum can_state new_state)
>  {
> -    struct flexcan_priv *priv = netdev_priv(dev);
>      struct can_berr_counter bec;
> 
>      __flexcan_get_berr_counter(dev, &bec);
> 
> -    switch (priv->can.state) {
> -    case CAN_STATE_ERROR_ACTIVE:
> -        /*
> -         * from: ERROR_ACTIVE
> -         * to  : ERROR_WARNING, ERROR_PASSIVE, BUS_OFF
> -         * =>  : there was a warning int
> -         */
> -        if (new_state >= CAN_STATE_ERROR_WARNING &&
> -            new_state <= CAN_STATE_BUS_OFF) {
> -            netdev_dbg(dev, "Error Warning IRQ\n");
> -            priv->can.can_stats.error_warning++;
> -
> -            cf->can_id |= CAN_ERR_CRTL;
> -            cf->data[1] = (bec.txerr > bec.rxerr) ?
> -                CAN_ERR_CRTL_TX_WARNING :
> -                CAN_ERR_CRTL_RX_WARNING;

Hm, can_change_state() handles the equal case differently. In the
SJA1000 manual I found:

"Errors detected during reception or transmission will affect the error
counters according to the CAN 2.0B protocol
specification. The error status bit is set when at least one of the
error counters has reached or exceeded the CPU
warning limit of 96. An error interrupt is generated, if enabled."

If both are equal we do not known if rx or tx has caused the state
change and therefore setting "CAN_ERR_CRTL_TX_WARNING |
CAN_ERR_CRTL_RX_WARNING" seems more logical, indeed. But maybe it simply
does not happen. Any other opinions?

> -        }
> -    case CAN_STATE_ERROR_WARNING:    /* fallthrough */
> -        /*
> -         * from: ERROR_ACTIVE, ERROR_WARNING
> -         * to  : ERROR_PASSIVE, BUS_OFF
> -         * =>  : error passive int
> -         */
> -        if (new_state >= CAN_STATE_ERROR_PASSIVE &&
> -            new_state <= CAN_STATE_BUS_OFF) {
> -            netdev_dbg(dev, "Error Passive IRQ\n");
> -            priv->can.can_stats.error_passive++;
> -
> -            cf->can_id |= CAN_ERR_CRTL;
> -            cf->data[1] = (bec.txerr > bec.rxerr) ?
> -                CAN_ERR_CRTL_TX_PASSIVE :
> -                CAN_ERR_CRTL_RX_PASSIVE;
> -        }
> -        break;
> -    case CAN_STATE_BUS_OFF:
> -        netdev_err(dev, "BUG! "
> -               "hardware recovered automatically from BUS_OFF\n");
> -        break;
> -    default:
> -        break;
> -    }
> +    can_change_state(dev, cf, new_state,
> +             can_get_err_dir(bec.rxerr, bec.txerr));

Saves a lot of lines :).

> 
> -    /* process state changes depending on the new state */
> -    switch (new_state) {
> -    case CAN_STATE_ERROR_WARNING:
> -        netdev_dbg(dev, "Error Warning\n");
> -        cf->can_id |= CAN_ERR_CRTL;
> -        cf->data[1] = (bec.txerr > bec.rxerr) ?
> -            CAN_ERR_CRTL_TX_WARNING :
> -            CAN_ERR_CRTL_RX_WARNING;
> -        break;
> -    case CAN_STATE_ERROR_ACTIVE:
> -        netdev_dbg(dev, "Error Active\n");
> -        cf->can_id |= CAN_ERR_PROT;
> -        cf->data[2] = CAN_ERR_PROT_ACTIVE;
> -        break;
> -    case CAN_STATE_BUS_OFF:
> -        cf->can_id |= CAN_ERR_BUSOFF;
> +    if (unlikely(new_state == CAN_STATE_BUS_OFF))
>          can_bus_off(dev);
> -        break;
> -    default:
> -        break;
> -    }
>  }
> 
>  static int flexcan_poll_state(struct net_device *dev, u32 reg_esr)
> @@ -658,7 +599,6 @@ static int flexcan_poll_state(struct net_device
> *dev, u32 reg_esr)
>          return 0;
> 
>      do_state(dev, cf, new_state);
> -    priv->can.state = new_state;
>      netif_receive_skb(skb);
> 
>      dev->stats.rx_packets++;
> -- 

To validate the correct behaviour could you please send messages while
the cable is disconnected. Then reconnect the cable and see how the
error state decreases. You can monitor the behaviour with ""candump -td
-e any,0:0,#FFFFFFFF" in another shell.

Wolfgang.

