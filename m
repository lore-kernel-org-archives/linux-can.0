From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] can: fix sja1000 pre_irq/post_irq handling
Date: Sun, 17 Nov 2013 21:51:02 +0100
Message-ID: <52892C36.8060709@grandegger.com>
References: <5288CFEF.3060701@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:46264 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270Ab3KQUvD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 17 Nov 2013 15:51:03 -0500
In-Reply-To: <5288CFEF.3060701@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver,

On 11/17/2013 03:17 PM, Oliver Hartkopp wrote:
> The SJA1000 driver provides optional function pointers to handle specific
> hardware setups at interrupt time.
> 
> This patch fixes the issue that the sja1000_interrupt() function may have
> returned IRQ_NONE without processing the post_irq function. Additionally
> an introduced return value from the pre_irq function is checked to skip the
> entire interrupt handling on pre_irq function errors.
> 
> Reported-by: Wolfgang Grandegger <wg@grandegger.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> ---
> 
> diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
> index 7164a99..bb20470 100644
> --- a/drivers/net/can/sja1000/sja1000.c
> +++ b/drivers/net/can/sja1000/sja1000.c
> @@ -494,12 +494,12 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
>  	uint8_t isrc, status;
>  	int n = 0;
>  
> +	if (priv->pre_irq && priv->pre_irq(priv))
> +		goto out;
> +

Well, not sure if we need that. Looks like a fatal error to me.

>  	/* Shared interrupts and IRQ off? */
>  	if (priv->read_reg(priv, SJA1000_IER) == IRQ_OFF)
> -		return IRQ_NONE;
> -
> -	if (priv->pre_irq)
> -		priv->pre_irq(priv);
> +		goto out;
>  
>  	while ((isrc = priv->read_reg(priv, SJA1000_IR)) &&
>  	       (n < SJA1000_MAX_IRQ)) {
> @@ -507,7 +507,7 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
>  		status = priv->read_reg(priv, SJA1000_SR);
>  		/* check for absent controller due to hw unplug */
>  		if (status == 0xFF && sja1000_is_absent(priv))
> -			return IRQ_NONE;
> +			goto out;

Be aware that the function will return IRQ_HANDLED if n > 0... which may
happen. Not exactly the same behaviour.

>  
>  		if (isrc & IRQ_WUI)
>  			netdev_warn(dev, "wakeup interrupt\n");
> @@ -535,7 +535,7 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
>  				status = priv->read_reg(priv, SJA1000_SR);
>  				/* check for absent controller */
>  				if (status == 0xFF && sja1000_is_absent(priv))
> -					return IRQ_NONE;
> +					goto out;

Ditto.

>  			}
>  		}
>  		if (isrc & (IRQ_DOI | IRQ_EI | IRQ_BEI | IRQ_EPI | IRQ_ALI)) {
> @@ -544,7 +544,7 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
>  				break;
>  		}
>  	}
> -
> +out:
>  	if (priv->post_irq)
>  		priv->post_irq(priv);

Wolfgang.

