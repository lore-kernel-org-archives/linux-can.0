From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: Re: Fwd: [Socketcan-users] sja1000_platform interrupt sharing
Date: Thu, 09 Aug 2012 14:56:43 +0200
Message-ID: <5023B38B.80702@visionsystems.de>
References: <6C5A3B79888A804CAB605257CD26D37703955B60@vwagwox00032.vw.vwg>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ns.vscom.de ([62.145.30.242]:46036 "EHLO mail.visionsystems.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932262Ab2HIM5A (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 9 Aug 2012 08:57:00 -0400
In-Reply-To: <6C5A3B79888A804CAB605257CD26D37703955B60@vwagwox00032.vw.vwg>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Schmitt, Sven (EVM/8)" <Sven.Schmitt@volkswagen.de>
Cc: linux-can@vger.kernel.org

Am 09.08.2012 14:46, schrieb Schmitt, Sven (EVM/8):
> Second try:
>
> Signed-off-by: Sven Schmitt <sven.schmitt@volkswagen.de>
>
> --- linux-3.5/drivers/net/can/sja1000/sja1000_platform.c.orig
> +++ linux-3.5/drivers/net/can/sja1000/sja1000_platform.c
> @@ -109,7 +109,9 @@ static int sp_probe(struct platform_devi
>  	priv = netdev_priv(dev);
>  
>  	dev->irq = res_irq->start;
> -	priv->irq_flags = res_irq->flags & (IRQF_TRIGGER_MASK |
> IRQF_SHARED);
> +	priv->irq_flags &= IRQF_TRIGGER_MASK;
> +	if (res_irq->flags & IORESOURCE_IRQ_SHAREABLE)
> +		priv->irq_flags |= IRQF_SHARED;
>  	priv->reg_base = addr;
>  	/* The CAN clock frequency is half the oscillator clock
> frequency */
>  	priv->can.clock.freq = pdata->osc_freq / 2;
>
>
> note: patch is compile tested only.
>
> Sven

O.K. Nice catch. I just picked the wrong header file include/linux/interrupt.h, it should be include/linux/ioport.h. Now I'll have to change my board file as well.

You can add my

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

See how I manage patches with git: https://libbits.wordpress.com/2011/12/27/managing-patch-series-with-git/

Yegor

