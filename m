From: Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: [PATCH can-next v3 1/2] can: add tx/rx LED trigger support
Date: Tue, 31 Jul 2012 13:57:33 +0200
Message-ID: <20120731115733.GB30417@gmail.com>
References: <1343676041-29572-1-git-send-email-fabio.baltieri@gmail.com>
 <5016FA01.5000109@pengutronix.de>
 <20120731065733.GA30267@gmail.com>
 <501784C8.9050803@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47115 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298Ab2GaLzo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 31 Jul 2012 07:55:44 -0400
Content-Disposition: inline
In-Reply-To: <501784C8.9050803@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>

On Tue, Jul 31, 2012 at 09:10:00AM +0200, Marc Kleine-Budde wrote:
> >>> +/*
> >>> + * Register CAN LED triggers for a CAN device
> >>> + *
> >>> + * This is normally called from a driver's probe function
> >>> + */
> >>> +void can_led_init(struct net_device *netdev)
> >>> +{
> >>> +	struct can_priv *priv = netdev_priv(netdev);
> >>> +
> >>> +	priv->tx_led_trig_name = kasprintf(GFP_KERNEL, "%s-tx", netdev->name);
> >>> +	if (!priv->tx_led_trig_name)
> >>> +		goto tx_led_failed;
> >>> +
> >>> +	priv->rx_led_trig_name = kasprintf(GFP_KERNEL, "%s-rx", netdev->name);
> >>> +	if (!priv->rx_led_trig_name)
> >>> +		goto rx_led_failed;
> >>> +
> >>> +	led_trigger_register_simple(priv->tx_led_trig_name,
> >>> +				    &priv->tx_led_trig);
> >>> +	led_trigger_register_simple(priv->rx_led_trig_name,
> >>> +				    &priv->rx_led_trig);
> >>> +
> >>> +	return;
> >>> +
> >>> +rx_led_failed:
> >>> +	kfree(priv->tx_led_trig_name);
> >>> +	priv->tx_led_trig_name = NULL;
> >>> +tx_led_failed:
> >>> +	return;
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(can_led_init);
> >>
> >> Can you provide a devm implementation for can_led?
> > 
> > Sounds reasonable, you mean like a devm_kasprintf implementation to
> > remove kfree and unwinding code?
> 
> IMHO it would be sufficient if you implement the devm cleanup functions
> here.

Uh - can you be more specific?  I mean, are you suggesting to just
convert the code to something like:

unsigned int len;
char *p;

len = snprintf(NULL, 0, "%s-tx", netdev->name);
p = devm_kzalloc(&netdev->dev, len + 1, GFP_KERNEL);
if (!p)
return -ENOMEM;
sprintf(p, len + 1, "%s-tx", netdev->name);

or to implement something with devres_alloc() and a specific
release function?

Fabio
