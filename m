From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH 5/7] can: dev: add berr_limit infrastrucutre
Date: Mon, 07 Oct 2013 17:39:47 +0200
Message-ID: <1876232.tLyIP8q8GR@ws-stein>
References: <1381156840-24071-1-git-send-email-mkl@pengutronix.de> <1381156840-24071-6-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:57364 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755376Ab3JGPrV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Oct 2013 11:47:21 -0400
In-Reply-To: <1381156840-24071-6-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de

Hello Marc,

On Monday 07 October 2013 16:40:38, Marc Kleine-Budde wrote:
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index bda1888..969d3cd 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -486,6 +486,29 @@ void can_bus_off(struct net_device *dev)
>  }
>  EXPORT_SYMBOL_GPL(can_bus_off);
>  
> +static void can_berr_restart(unsigned long data)
> +{
> +	struct net_device *dev = (struct net_device *)data;
> +	struct can_priv *priv = netdev_priv(dev);
> +
> +	netdev_dbg(dev, "berr-restart\n");
> +	priv->do_berr_restart(dev);
     ^^^^^^^^^^^^^^^^^^^^^^^^
see below!

> +}
> +
> +void can_berr_limit(struct net_device *dev)
> +{
> +	struct can_priv *priv = netdev_priv(dev);
> +
> +	if (priv->berr_limit_delay) {
> +		netdev_dbg(dev, "berr-limit\n");
> +		mod_timer(&priv->berr_limit_timer,
> +			  jiffies + priv->berr_limit_delay);
> +	} else {
> +		priv->do_berr_restart(dev);
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^
Here you are silently requiring that do_berr_restart is non-NULL. I know that the driver has to properly set this when using can_berr_limit, but it might seem confusing.

Regards,
Alexander

