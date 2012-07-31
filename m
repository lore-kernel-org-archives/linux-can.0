From: Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: [PATCH can-next v3 1/2] can: add tx/rx LED trigger support
Date: Tue, 31 Jul 2012 13:55:39 +0200
Message-ID: <20120731115539.GA30417@gmail.com>
References: <1343676041-29572-1-git-send-email-fabio.baltieri@gmail.com>
 <50179B81.3040907@grandegger.com>
 <5017AFAB.1040609@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56411 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756030Ab2GaLxw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 31 Jul 2012 07:53:52 -0400
Content-Disposition: inline
In-Reply-To: <5017AFAB.1040609@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>

On Tue, Jul 31, 2012 at 12:12:59PM +0200, Marc Kleine-Budde wrote:
> >> +/*
> >> + * Register CAN LED triggers for a CAN device
> >> + *
> >> + * This is normally called from a driver's probe function
> >> + */
> >> +void can_led_init(struct net_device *netdev)
> >> +{
> >> +	struct can_priv *priv = netdev_priv(netdev);
> >> +
> >> +	priv->tx_led_trig_name = kasprintf(GFP_KERNEL, "%s-tx", netdev->name);
> >> +	if (!priv->tx_led_trig_name)
> >> +		goto tx_led_failed;
> > 
> > Just return here?

Right.

> >> +	priv->rx_led_trig_name = kasprintf(GFP_KERNEL, "%s-rx", netdev->name);
> >> +	if (!priv->rx_led_trig_name)
> >> +		goto rx_led_failed;
> >> +
> >> +	led_trigger_register_simple(priv->tx_led_trig_name,
> >> +				    &priv->tx_led_trig);
> >> +	led_trigger_register_simple(priv->rx_led_trig_name,
> >> +				    &priv->rx_led_trig);
> >> +
> >> +	return;
> >> +
> >> +rx_led_failed:
> >> +	kfree(priv->tx_led_trig_name);
> >> +	priv->tx_led_trig_name = NULL;
> >> +tx_led_failed:
> >> +	return;
> > 
> > In case of error the function returns silently. Is this by purpose? What
> > happens if CAN_LEDS is enabled but no LEDs are assigned?
> 
> It's a bit strange, but led_trigger_register_simple() can fail silently,
> too. Or better it has no return value, but does a warning printk in case
> of an error.

Well, that's in line with the behviour of leds trigger registration in
other subsystems out there (mac80211 and power_supply for instance) but
now that you pointed it out, I agree that this is not really nice to the
user.  led_trigger_register_simple already has a printk to KERN_ERR, I
may add another one in the error path (if we keep the kasprintf).

> 
> > 
> >> +}
> >> +EXPORT_SYMBOL_GPL(can_led_init);
> >> +
> >> +/*
> >> + * Unregister CAN LED triggers for a CAN device
> >> + *
> >> + * This is normally called from a driver's remove function
> >> + */
> >> +void can_led_exit(struct net_device *netdev)
> >> +{
> >> +	struct can_priv *priv = netdev_priv(netdev);
> >> +
> >> +	led_trigger_unregister_simple(priv->tx_led_trig);
> >> +	led_trigger_unregister_simple(priv->rx_led_trig);
> >> +
> >> +	kfree(priv->tx_led_trig_name);
> >> +	kfree(priv->rx_led_trig_name);
> >> +}
> >> +EXPORT_SYMBOL_GPL(can_led_exit);
> >> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> >> index 2b2fc34..167b04a 100644
> >> --- a/include/linux/can/dev.h
> >> +++ b/include/linux/can/dev.h
> >> @@ -16,6 +16,7 @@
> >>  #include <linux/can.h>
> >>  #include <linux/can/netlink.h>
> >>  #include <linux/can/error.h>
> >> +#include <linux/can/led.h>
> >>  
> >>  /*
> >>   * CAN mode
> >> @@ -52,6 +53,13 @@ struct can_priv {
> >>  
> >>  	unsigned int echo_skb_max;
> >>  	struct sk_buff **echo_skb;
> >> +
> >> +#ifdef CONFIG_CAN_LEDS
> >> +	struct led_trigger *tx_led_trig;
> >> +	char *tx_led_trig_name;
> >> +	struct led_trigger *rx_led_trig;
> >> +	char *rx_led_trig_name;
> >> +#endif
> > 
> > Do we need to store the names?
> 
> Yes, Seems, so the name is not copied:
> 
> http://lxr.free-electrons.com/source/drivers/leds/led-triggers.c#L253
> 
> Marc

Actually we may try to exploit struct led_trigger to get back the
pointers, but then we have to free the names before calling
led_trigger_unregister, and that's going to be race against
led_trigger_show().  Anyway, those pointers would go away using a
devm-based allocation, so I'll keep that in mind.

Thanks,
Fabio
