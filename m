From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: can: fix sja1000 post_irq handling and resulting return value
Date: Thu, 21 Nov 2013 18:07:05 +0100
Message-ID: <528E3DB9.6020809@hartkopp.net>
References: <528E3CCB.9080501@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:29736 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609Ab3KURHJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 21 Nov 2013 12:07:09 -0500
In-Reply-To: <528E3CCB.9080501@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Kurt Van Dijck <kurt.van.dijck@eia.be>



On 21.11.2013 18:03, Oliver Hartkopp wrote:
> This patch fixes the issue that the sja1000_interrupt() function may have
> returned IRQ_NONE without processing the optional post_irq function before.
> Additionally the irq processing counter 'n' is moved to the end of the while
> statement to return correct IRQ_[NONE|HANDLED] values at error conditions.
> 

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

8-)

> ---
> 
> diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
> index 7164a99..f17c301 100644
> --- a/drivers/net/can/sja1000/sja1000.c
> +++ b/drivers/net/can/sja1000/sja1000.c
> @@ -494,20 +494,20 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
>  	uint8_t isrc, status;
>  	int n = 0;
>  
> -	/* Shared interrupts and IRQ off? */
> -	if (priv->read_reg(priv, SJA1000_IER) == IRQ_OFF)
> -		return IRQ_NONE;
> -
>  	if (priv->pre_irq)
>  		priv->pre_irq(priv);
>  
> +	/* Shared interrupts and IRQ off? */
> +	if (priv->read_reg(priv, SJA1000_IER) == IRQ_OFF)
> +		goto out;
> +
>  	while ((isrc = priv->read_reg(priv, SJA1000_IR)) &&
>  	       (n < SJA1000_MAX_IRQ)) {
> -		n++;
> +
>  		status = priv->read_reg(priv, SJA1000_SR);
>  		/* check for absent controller due to hw unplug */
>  		if (status == 0xFF && sja1000_is_absent(priv))
> -			return IRQ_NONE;
> +			goto out;
>  
>  		if (isrc & IRQ_WUI)
>  			netdev_warn(dev, "wakeup interrupt\n");
> @@ -535,7 +535,7 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
>  				status = priv->read_reg(priv, SJA1000_SR);
>  				/* check for absent controller */
>  				if (status == 0xFF && sja1000_is_absent(priv))
> -					return IRQ_NONE;
> +					goto out;
>  			}
>  		}
>  		if (isrc & (IRQ_DOI | IRQ_EI | IRQ_BEI | IRQ_EPI | IRQ_ALI)) {
> @@ -543,8 +543,9 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
>  			if (sja1000_err(dev, isrc, status))
>  				break;
>  		}
> +		n++;
>  	}
> -
> +out:
>  	if (priv->post_irq)
>  		priv->post_irq(priv);
>  
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
