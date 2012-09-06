From: Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: [PATCH] can: rename LED trigger name on netdev renames
Date: Thu, 6 Sep 2012 22:46:00 +0200
Message-ID: <20120906204559.GB4043@gmail.com>
References: <20120904071128.GB416@vandijck-laurijssen.be>
 <1346750951-10451-1-git-send-email-kurt.van.dijck@eia.be>
 <20120906185938.GA4043@gmail.com>
 <5048F9FB.9020207@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57832 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918Ab2IFUo7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Sep 2012 16:44:59 -0400
Content-Disposition: inline
In-Reply-To: <5048F9FB.9020207@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Kurt Van Dijck <kurt.van.dijck@eia.be>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org

On Thu, Sep 06, 2012 at 09:31:07PM +0200, Oliver Hartkopp wrote:
> >> +
> >> +/*
> >> + * NETDEV rename notifier to rename the associated led triggers too
> >> + */
> >> +static int can_led_notifier(struct notifier_block *nb, unsigned long msg,
> >> +			void *data)
> >> +{
> >> +	struct net_device *netdev = (struct net_device *)data;
> >> +	struct can_priv *priv = netdev_priv(netdev);
> >> +	int busy = 0;
> >> +
> >> +	if (!net_eq(dev_net(netdev), &init_net))
> >> +		return NOTIFY_DONE;
> >> +
> >> +	if (netdev->type != ARPHRD_CAN)
> >> +		return NOTIFY_DONE;
> >> +
> >> +	if (msg != NETDEV_CHANGENAME)
> >> +		return NOTIFY_DONE;
> > 
> > That's the main problem, which I also got stuck into when I did my first
> > can-led implementation.  As LED structures are in netdev's private data,
> > you can only use it if your driver is based on the can-dev API, and
> > there are no way to be sure of that if you get outside driver's code
> > itself.
> > 
> > This would give problems with vcan, slcan, and probabily other
> > non-mainlined drivers.
> 
> 
> Do you think, this is really a problem?
> 
> If a driver decides not to use the can-dev framework it has to implement own
> solutions or just adopt can-dev.

Agreed, but this still means that we can't assume that
netdev_priv(netdev) to a netdev where netdev->type == ARPHRD_CAN points
to a struct can_priv, right?

Fabio
