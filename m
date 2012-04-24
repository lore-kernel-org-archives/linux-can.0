From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [RFC PATCH v2 1/2] can: add tx/rx LED trigger support
Date: Tue, 24 Apr 2012 10:38:06 +0200
Message-ID: <20120424083806.GB420@vandijck-laurijssen.be>
References: <1335214966-20478-1-git-send-email-fabio.baltieri@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:64283 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755991Ab2DXIiJ (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 24 Apr 2012 04:38:09 -0400
Content-Disposition: inline
In-Reply-To: <1335214966-20478-1-git-send-email-fabio.baltieri@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: linux-can@vger.kernel.org

On Mon, Apr 23, 2012 at 11:02:45PM +0200, Fabio Baltieri wrote:
> This patch implements the functions to add two LED triggers, named
> <ifname>-tx and <ifname>-rx, to a canbus device driver.
> 
[...]

If I understand well, this function is subject to maximal optimization.
> +void can_led_event(struct net_device *netdev, enum can_led_event event)
> +{
> +	struct can_priv *priv = netdev_priv(netdev);
If the assignment is postponed to withing the differenct cases, thereby
repeating this statement 3 times (not 4!), both for RX & TX path a single
assignment could be saved.
For stack usage, I'm not an expert, but I suspect a little less stack use.
I'm not sure wether it's worth the pain of extra lines of code.
I tried to illustrate my point here:
> +++	struct can_led_data *tx_led, *rx_led;
> +
> +	switch (event) {
> +	case CAN_LED_EVENT_OPEN:
> +++		tx_led = priv->tx_led_data;
> +		if (likely(tx_led))
> +			led_trigger_event(&tx_led->trig, LED_FULL);
> +++		rx_led = priv->rx_led_data;
> +		if (likely(rx_led))
> +			led_trigger_event(&rx_led->trig, LED_FULL);
> +		break;
> +	case CAN_LED_EVENT_STOP:
> +++		tx_led = priv->tx_led_data;
> +		if (likely(tx_led)) {
> +			del_timer_sync(&tx_led->timer);
> +			led_trigger_event(&tx_led->trig, LED_OFF);
> +		}
> +++		rx_led = priv->rx_led_data;
> +		if (likely(rx_led)) {
> +			del_timer_sync(&rx_led->timer);
> +			led_trigger_event(&rx_led->trig, LED_OFF);
> +		}
> +		break;
> +	case CAN_LED_EVENT_TX:
> +++		tx_led = priv->tx_led_data;
> +		if (led_delay && likely(tx_led) &&
> +		    !timer_pending(&tx_led->timer))
> +			mod_timer(&tx_led->timer,
> +				jiffies + msecs_to_jiffies(led_delay));
> +		break;
> +	case CAN_LED_EVENT_RX:
> +++		rx_led = priv->rx_led_data;
> +		if (led_delay && likely(rx_led) &&
> +		    !timer_pending(&rx_led->timer))
> +			mod_timer(&rx_led->timer,
> +				jiffies + msecs_to_jiffies(led_delay));
> +		break;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(can_led_event);

Apart from this tiny question, the patch looks very clean, as Wolfgang already
mentioned.

Kind regards,
Kurt
