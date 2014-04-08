From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] can: c_can: Fix bit clearing and message object read
Date: Tue, 8 Apr 2014 15:07:10 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1404081421140.14882@ionos.tec.linutronix.de>
References: <1396950382-13091-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57376 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756364AbaDHNHA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Apr 2014 09:07:00 -0400
In-Reply-To: <1396950382-13091-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On Tue, 8 Apr 2014, Alexander Stein wrote:
> It seems that clearing some bits in a message object using COMMSK_REG and
> reading this object afterwards using COMREQ_REG is not race free.
> It might occur that the read message object still contains the
> IF_MCONT_NEWDAT bit set while it was already cleared upon write to
> COMMSK_REG. So insert a dummy read to the hardware.

No. It does not get cleared with the write to COMMSK_REG. That's just
a write. That write does nothing.

The execution of the transfer starts with writing the message object
number to COMREQ_REG. How should the IF know which message object you
want to access?
 
>  	 */
>  	priv->write_reg(priv, C_CAN_IFACE(COMMSK_REG, iface),
>  			IFX_WRITE_LOW_16BIT(mask));
> +
> +	/*
> +	 * Insert additional dummy read to let
> +	 * the write to COMMSK_REG take effect
> +	 */
> +	priv->read_reg(priv, C_CAN_IFACE(COMREQ_REG, iface));
> +

So that read confuses the hell out of the hardware.

>  	priv->write_reg(priv, C_CAN_IFACE(COMREQ_REG, iface),
>  			IFX_WRITE_LOW_16BIT(objno));
>  
> @@ -832,12 +839,11 @@ static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
>  		}
>  
>  		/*
> -		 * This really should not happen, but this covers some
> -		 * odd HW behaviour. Do not remove that unless you
> -		 * want to brick your machine.
> +		 * This really should not happen, but this warns about some
> +		 * odd HW behaviour.
>  		 */
> -		if (!(ctrl & IF_MCONT_NEWDAT))
> -			continue;
> +		if ((ctrl & IF_MCONT_NEWDAT))
> +			netdev_warn(dev, "IF_MCONT_NEWDAT still set on obj: %d", obj);

No, that's wrong. That does not work with any hardware I have access
to.

From the datasheet:

"Note: A read access to a message object can be combined with the reset
 of the INTPND and NEWDAT control bits. The values of these two bits,
 which will be transferred to the IFm message control register, always
 reflect the status before resetting them."

So it is expected, that NEWDAT is set in the crtl register readout if
the message object in the message ram had the bit set.

The point is that when the IF transfers the message from message ram
to the interface it clears the INTPND and NEWDAT bits in the message
ram. That avoids the extra transfers after reading the message.

Thanks,

	tglx


