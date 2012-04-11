From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC PATCH] can: add tx/rx led trigger support
Date: Wed, 11 Apr 2012 08:14:57 +0200
Message-ID: <4F852161.90706@hartkopp.net>
References: <1334093965-2692-1-git-send-email-fabio.baltieri@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:40209 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731Ab2DKGOz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Apr 2012 02:14:55 -0400
In-Reply-To: <1334093965-2692-1-git-send-email-fabio.baltieri@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: linux-can@vger.kernel.org

Hi Fabio,

at first i REALLY LIKE blinkenlights :-)

According to your implementation i have some remarks:

On 10.04.2012 23:39, Fabio Baltieri wrote:

> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 5d2efe7..76eb70c 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -16,6 +16,8 @@
>  #include <linux/can.h>
>  #include <linux/can/netlink.h>
>  #include <linux/can/error.h>
> +#include <linux/timer.h>
> +#include <linux/leds.h>
>  
>  /*
>   * CAN mode
> @@ -52,6 +54,13 @@ struct can_priv {
>  
>  	unsigned int echo_skb_max;
>  	struct sk_buff **echo_skb;
> +
> +#ifdef CONFIG_CAN_LEDS
> +	struct timer_list tx_off_timer, rx_off_timer;
> +	struct led_trigger *tx_led, *rx_led;
> +	char tx_led_name[32], rx_led_name[32];
> +	atomic_t led_discard_count;
> +#endif
>  };


Why don't you add struct led_trigger directly here, as it makes the two
kzalloc calls in  can_led_init() obsolete?

Struct can_priv is allocated anyway and therefore you do not take care of the
removal of your privately allocated memory.

Now looking into the tx path LEDs as an example:

> +/* This is used to ignore devices not based on the can-dev framework */
> +static int rtnl_link_kind_is(struct net_device *netdev, const char *kind)
> +{
> +	if (netdev->rtnl_link_ops &&
> +		strncmp(kind, netdev->rtnl_link_ops->kind, strlen(kind)) == 0)
> +		return 1;
> +	else
> +		return 0;
> +}


You do this costly compare with *each* tx/rx CAN frame in the hot path.

Not very nice :-(

> +
> +void can_led_tx(struct net_device *netdev, int loop)
> +{
> +	struct can_priv *priv = netdev_priv(netdev);
> +
> +	if (!rtnl_link_kind_is(netdev, "can"))
> +		return;


See here.

> +
> +	if (unlikely(!priv->tx_led))
> +		return;
> +
> +	if (!timer_pending(&priv->tx_off_timer)) {
> +		led_trigger_event(priv->tx_led, LED_FULL);
> +
> +		mod_timer(&priv->tx_off_timer,
> +			jiffies + msecs_to_jiffies(led_off_delay));
> +	}
> +
> +	if (loop)
> +		atomic_dec(&priv->led_discard_count);
> +}
> +


As you pointed out that only CAN devices are supported that use the can-dev
infrastructure you do some costly checks one layer above (in net/can) instead
of implementing it on the driver layer (in drivers/net/can).

The only correct trigger for a tx-LED can be retrieved from the TX done
interrupt in the interrupt function like here:

http://lxr.linux.no/#linux+v3.3.1/drivers/net/can/sja1000/sja1000.c#L507

where the echo skb is sent back to the system.

This makes sure, that the tx-LED is only triggered, when there was a really
successful transmission on the CAN bus.

I wonder if it makes more sense to add the LED trigger stuff into
drivers/net/can/dev.c ?!?

Of course the correct calling points to trigger the rx/tx-LEDs need to be
implemented inside *each* driver at the correct position.

And we should probably add a new CAN netlink command here

	http://lxr.linux.no/#linux+v3.3.1/drivers/net/can/dev.c#L577

to configure the LED timer per interface: 0 -> LEDs off (==default)

The question would be, if this code

> +	if (!timer_pending(&priv->tx_off_timer)) {
> +		led_trigger_event(priv->tx_led, LED_FULL);
> +
> +		mod_timer(&priv->tx_off_timer,
> +			jiffies + msecs_to_jiffies(led_off_delay));
> +	}


is ready to be used in hard IRQ context?

If not we may use a construct with a tasklet that can be triggered from hard
IRQ context, like here:

	http://lxr.linux.no/#linux+v3.3.1/net/can/bcm.c#L356

I think this part

> +
> +	if (loop)
> +		atomic_dec(&priv->led_discard_count);
> +}

is becoming obsolete anyway then, right?

Regards,
Oliver

