From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH 5/7] can: dev: add berr_limit infrastrucutre
Date: Tue, 08 Oct 2013 08:03:42 +0200
Message-ID: <3564375.WErYyL6CN1@ws-stein>
References: <1381156840-24071-1-git-send-email-mkl@pengutronix.de> <5252D9BE.9040905@pengutronix.de> <5252DAAD.1020009@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:53327 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752176Ab3JHGDp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Oct 2013 02:03:45 -0400
In-Reply-To: <5252DAAD.1020009@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de

On Monday 07 October 2013 18:00:45, Marc Kleine-Budde wrote:
> >>> +void can_berr_limit(struct net_device *dev)
> >>> +{
> >>> +	struct can_priv *priv = netdev_priv(dev);
> >>> +
> >>> +	if (priv->berr_limit_delay) {
> >>> +		netdev_dbg(dev, "berr-limit\n");
> >>> +		mod_timer(&priv->berr_limit_timer,
> >>> +			  jiffies + priv->berr_limit_delay);
> >>> +	} else {
> >>> +		priv->do_berr_restart(dev);
> >>          ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 
> >> Here you are silently requiring that do_berr_restart is non-NULL. I
> >> know that the driver has to properly set this when using
> >> can_berr_limit, but it might seem confusing.
> > 
> > If the driver wants to make use of this feature, it has to setup this
> > callback. If I add NULL pointer checks, the kernel wouldn't blow up, but
> > the driver doesn't work any more.
> 
> I mean, if the driver doesn't setup the callback and there is a NULL
> pointer checks in both functions, the driver doesn't work properly,
> because the bus error interrupts will stay disabled and you might not
> notice it, because there isn't any big sign of failure (like the NULL
> pointer deref).

Mh, what would be the effect if a driver doesn't setup the callback and still uses can_berr_limit? The NULL dereference raises and OOPS and what then? The corresponding application gets killed? Well if the system as a whole still works and even better then faulty driver can be unloaded again, this might be suitable.

Best regards,
Alexander
