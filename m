From: Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] can: add tx/rx LED trigger support
Date: Tue, 24 Apr 2012 22:22:00 +0200
Message-ID: <20120424202200.GA1672@gmail.com>
References: <1335214966-20478-1-git-send-email-fabio.baltieri@gmail.com>
 <20120424083806.GB420@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:55885 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756912Ab2DXUUQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Apr 2012 16:20:16 -0400
Received: by wibhj6 with SMTP id hj6so4296317wib.1
        for <linux-can@vger.kernel.org>; Tue, 24 Apr 2012 13:20:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120424083806.GB420@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

On Tue, Apr 24, 2012 at 10:38:06AM +0200, Kurt Van Dijck wrote:
> On Mon, Apr 23, 2012 at 11:02:45PM +0200, Fabio Baltieri wrote:
> > This patch implements the functions to add two LED triggers, named
> > <ifname>-tx and <ifname>-rx, to a canbus device driver.
> > 
> [...]

Hello Kurt,

> If I understand well, this function is subject to maximal optimization.
> > +void can_led_event(struct net_device *netdev, enum can_led_event event)
> > +{
> > +	struct can_priv *priv = netdev_priv(netdev);
> If the assignment is postponed to withing the differenct cases, thereby
> repeating this statement 3 times (not 4!), both for RX & TX path a single
> assignment could be saved.
> For stack usage, I'm not an expert, but I suspect a little less stack use.
> I'm not sure wether it's worth the pain of extra lines of code.
> I tried to illustrate my point here:

I'm looking at the disassembled function for both cases on ARM.  Your
version uses some less instructions but I think the optimizer is
crunching the whoole thing in some funny way and I'm not sure if it's
going to make a difference at all in the end.

Do you know if there are any other part of the kernel which are using
similar optimiziations?

> > +++	struct can_led_data *tx_led, *rx_led;
> > +
> > +	switch (event) {
> > +	case CAN_LED_EVENT_OPEN:
> > +++		tx_led = priv->tx_led_data;
> > +		if (likely(tx_led))
> > +			led_trigger_event(&tx_led->trig, LED_FULL);
> > +++		rx_led = priv->rx_led_data;
> > +		if (likely(rx_led))
> > +			led_trigger_event(&rx_led->trig, LED_FULL);
> > +		break;
> > +	case CAN_LED_EVENT_STOP:
> > +++		tx_led = priv->tx_led_data;
> > +		if (likely(tx_led)) {
> > +			del_timer_sync(&tx_led->timer);
> > +			led_trigger_event(&tx_led->trig, LED_OFF);
> > +		}
> > +++		rx_led = priv->rx_led_data;
> > +		if (likely(rx_led)) {
> > +			del_timer_sync(&rx_led->timer);
> > +			led_trigger_event(&rx_led->trig, LED_OFF);
> > +		}
> > +		break;
> > +	case CAN_LED_EVENT_TX:
> > +++		tx_led = priv->tx_led_data;
> > +		if (led_delay && likely(tx_led) &&
> > +		    !timer_pending(&tx_led->timer))
> > +			mod_timer(&tx_led->timer,
> > +				jiffies + msecs_to_jiffies(led_delay));
> > +		break;
> > +	case CAN_LED_EVENT_RX:
> > +++		rx_led = priv->rx_led_data;
> > +		if (led_delay && likely(rx_led) &&
> > +		    !timer_pending(&rx_led->timer))
> > +			mod_timer(&rx_led->timer,
> > +				jiffies + msecs_to_jiffies(led_delay));
> > +		break;
> > +	}
> > +}
> > +EXPORT_SYMBOL_GPL(can_led_event);
> 
> Apart from this tiny question, the patch looks very clean, as Wolfgang already
> mentioned.

Thanks.

Regards,
Fabio
