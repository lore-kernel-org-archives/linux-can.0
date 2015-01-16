From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [PATCH v4 2/4] can: kvaser_usb: Update error counters before exiting on
 OOM
Date: Fri, 16 Jan 2015 15:50:40 +0000
Message-ID: <20150116155040.20513.13990@shannon>
References: <20141223154654.GB6460@vivalin-002> <20150111200544.GA8855@linux>
 <20150111201116.GB8855@linux> <20150111201519.GC8855@linux>
 <54B3AB6C.8020900@pengutronix.de> <20150112203650.GA11355@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-am1on0060.outbound.protection.outlook.com ([157.56.112.60]:25198
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751717AbbAPPut convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 16 Jan 2015 10:50:49 -0500
In-Reply-To: <20150112203650.GA11355@linux>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ahmed S. Darwish" <darwish.07@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Linux-CAN <linux-can@vger.kernel.org>

See comments below.

Quoting Ahmed S. Darwish (2015-01-12 20:36:50)
...
> 
> [ Patch is build-tested, but not _fully_ run-time tested.
> 
>   It's based on linux-can/testing commit d642b49f6d84b94bd
>   "can: kvaser_usb: Don't dereference skb after a netif_rx" ]
> 
> Subject: [PATCH] can: kvaser_usb: Update net interface state
>  before exiting on OOM
> 
> From: Ahmed S. Darwish <ahmed.darwish@valeo.com>
> 
> Let the network interface can bus state and error counters be
> more accurate in case of Out of Memory conditions.
> 
> Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Ahmed S. Darwish <ahmed.darwish@valeo.com>
> ---
>  drivers/net/can/usb/kvaser_usb.c | 182 +++++++++++++++++++++++----------------
>  1 file changed, 106 insertions(+), 76 deletions(-)
> 
> diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
> index c32cd61..2d0ef76 100644
> --- a/drivers/net/can/usb/kvaser_usb.c
> +++ b/drivers/net/can/usb/kvaser_usb.c
> @@ -273,6 +273,10 @@ struct kvaser_msg {
>         } u;
>  } __packed;
>  
> +struct kvaser_usb_error_summary {
> +       u8 channel, status, txerr, rxerr, error_factor;
> +};
> +
>  struct kvaser_usb_tx_urb_context {
>         struct kvaser_usb_net_priv *priv;
>         u32 echo_index;
> @@ -615,6 +619,57 @@ static void kvaser_usb_unlink_tx_urbs(struct kvaser_usb_net_priv *priv)
>                 priv->tx_contexts[i].echo_index = MAX_TX_URBS;
>  }
>  

This function is doing some things that are now be handled by
can_change_state(). You can make your state handling code a lot shorter by
using it.

> +static void kvaser_usb_rx_error_update_state(struct kvaser_usb_net_priv *priv,
> +                                            const struct kvaser_usb_error_summary *es)
> +{
> +       struct net_device_stats *stats;
> +       unsigned int new_state;
> +
> +       stats = &priv->netdev->stats;
> +       new_state = priv->can.state;
> +
> +       netdev_dbg(priv->netdev, "Error status: 0x%02x\n", es->status);
> +
> +       if (es->status & M16C_STATE_BUS_OFF) {
can_change_state() updates the state stats.
> +               priv->can.can_stats.bus_off++;
> +               new_state = CAN_STATE_BUS_OFF;
> +       } else if (es->status & M16C_STATE_BUS_PASSIVE) {
> +               if (priv->can.state != CAN_STATE_ERROR_PASSIVE) {
See last comment.
> +                       priv->can.can_stats.error_passive++;
> +               }
> +               new_state = CAN_STATE_ERROR_PASSIVE;
> +       }
> +
> +       if (es->status == M16C_STATE_BUS_ERROR) {
> +               if ((priv->can.state < CAN_STATE_ERROR_WARNING) &&
> +                   ((es->txerr >= 96) || (es->rxerr >= 96))) {
Same as above.
> +                       priv->can.can_stats.error_warning++;
> +                       new_state = CAN_STATE_ERROR_WARNING;
> +               } else if (priv->can.state > CAN_STATE_ERROR_ACTIVE) {
> +                       new_state = CAN_STATE_ERROR_ACTIVE;
> +               }
> +       }
> +
> +       if (!es->status) {
> +               new_state = CAN_STATE_ERROR_ACTIVE;
> +       }
> +
> +       if (priv->can.restart_ms &&
> +           (priv->can.state >= CAN_STATE_BUS_OFF) &&
> +           (new_state < CAN_STATE_BUS_OFF)) {
This is NOT in can_change_state(). Keep it.
> +               priv->can.can_stats.restarts++;
> +       }
> +
> +       if (es->error_factor) {
> +               priv->can.can_stats.bus_error++;
> +               stats->rx_errors++;
> +       }
> +
> +       priv->bec.txerr = es->txerr;
> +       priv->bec.rxerr = es->rxerr;
can_change_state() does this too.
> +       priv->can.state = new_state;
> +}
> +
>  static void kvaser_usb_rx_error(const struct kvaser_usb *dev,
>                                 const struct kvaser_msg *msg)
...
> -       if (status & M16C_STATE_BUS_RESET) {
> +       if (es.status & M16C_STATE_BUS_RESET) {
>                 kvaser_usb_unlink_tx_urbs(priv);
>                 return;
>         }
>  
OK, maybe we need to move "priv->can.state = new_state" out of
can_change_state(). See explanation below.
> +       old_state = priv->can.state;
> +       kvaser_usb_rx_error_update_state(priv, &es);
> +       new_state = priv->can.state;
> +
>         skb = alloc_can_err_skb(priv->netdev, &cf);
>         if (!skb) {
>                 stats->rx_dropped++;
>                 return;
>         }
>  
You should be able to replace this:
> -       new_state = priv->can.state;
> -
> -       netdev_dbg(priv->netdev, "Error status: 0x%02x\n", status);
> -
> -       if (status & M16C_STATE_BUS_OFF) {
> -               cf->can_id |= CAN_ERR_BUSOFF;
> -
> -               priv->can.can_stats.bus_off++;
> +       if (es.status & M16C_STATE_BUS_OFF) {
>                 if (!priv->can.restart_ms)
>                         kvaser_usb_simple_msg_async(priv, CMD_STOP_CHIP);
> -
>                 netif_carrier_off(priv->netdev);
>  
> -               new_state = CAN_STATE_BUS_OFF;
> -       } else if (status & M16C_STATE_BUS_PASSIVE) {
> -               if (priv->can.state != CAN_STATE_ERROR_PASSIVE) {
> +               cf->can_id |= CAN_ERR_BUSOFF;
> +       } else if (es.status & M16C_STATE_BUS_PASSIVE) {
> +               if (old_state != CAN_STATE_ERROR_PASSIVE) {
>                         cf->can_id |= CAN_ERR_CRTL;
>  
> -                       if (txerr || rxerr)
> -                               cf->data[1] = (txerr > rxerr)
> +                       if (es.txerr || es.rxerr)
> +                               cf->data[1] = (es.txerr > es.rxerr)
>                                                 ? CAN_ERR_CRTL_TX_PASSIVE
>                                                 : CAN_ERR_CRTL_RX_PASSIVE;
>                         else
>                                 cf->data[1] = CAN_ERR_CRTL_TX_PASSIVE |
>                                               CAN_ERR_CRTL_RX_PASSIVE;
> -
> -                       priv->can.can_stats.error_passive++;
>                 }
> -
> -               new_state = CAN_STATE_ERROR_PASSIVE;
>         }
>  
> -       if (status == M16C_STATE_BUS_ERROR) {
> -               if ((priv->can.state < CAN_STATE_ERROR_WARNING) &&
> -                   ((txerr >= 96) || (rxerr >= 96))) {
> +       if (es.status == M16C_STATE_BUS_ERROR) {
> +               if ((old_state < CAN_STATE_ERROR_WARNING) &&
> +                   ((es.txerr >= 96) || (es.rxerr >= 96))) {
>                         cf->can_id |= CAN_ERR_CRTL;
> -                       cf->data[1] = (txerr > rxerr)
> +                       cf->data[1] = (es.txerr > es.rxerr)
>                                         ? CAN_ERR_CRTL_TX_WARNING
>                                         : CAN_ERR_CRTL_RX_WARNING;
> -
> -                       priv->can.can_stats.error_warning++;
> -                       new_state = CAN_STATE_ERROR_WARNING;
> -               } else if (priv->can.state > CAN_STATE_ERROR_ACTIVE) {
> +               } else if (old_state > CAN_STATE_ERROR_ACTIVE) {
>                         cf->can_id |= CAN_ERR_PROT;
>                         cf->data[2] = CAN_ERR_PROT_ACTIVE;
> -
> -                       new_state = CAN_STATE_ERROR_ACTIVE;
>                 }
With something like:
	if(new_state != old_state)
	{
		tx_state = get_tx_state(...);
		rx_state = get_rx_state(...);
		can_change_state(priv, cf, tx_state, rx_state);
		if(new_state == CAN_STATE_BUS_OFF)
			bus_off(...);
	}
>         }
>  
> -       if (!status) {
> +       if (!es.status) {
>                 cf->can_id |= CAN_ERR_PROT;
>                 cf->data[2] = CAN_ERR_PROT_ACTIVE;
> -
> -               new_state = CAN_STATE_ERROR_ACTIVE;
>         }
>  
...

I suggest that you create functions named kvaser_get_tx_state and
kvaser_get_rx_state (or one function that returns to argument if that suits you
better) based on kvaser_usb_rx_error_update_state.

Because you want to assign the netlink state before you do the skb alloc, you
need to make a copy of the netlink state before you change it and reassign the
old state to the netlink structure after the alloc succeeds. This is because
can_change_state() relies on priv->can.state for the "current state". This is a
hack. Perhaps we need to split up can_change_state().

See:
http://article.gmane.org/gmane.linux.can/7164
http://article.gmane.org/gmane.linux.can/7162
http://article.gmane.org/gmane.linux.can/7163
http://article.gmane.org/gmane.linux.can/7167

Best regards,
Andri Yngvason
