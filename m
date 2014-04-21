From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: sja1000_isa: add locking for indirect register access
 mode
Date: Mon, 21 Apr 2014 19:39:49 +0200
Message-ID: <535557E5.8060907@hartkopp.net>
References: <CA+s8ZrqFBun4bo2rJJFHb0FrV7m7PLybUVM+jjahKsdW8bdnaQ@mail.gmail.com>	<164afc991761b9eeb0eec6902814d00e@grandegger.com>	<534D0F00.7000202@hartkopp.net> <CA+s8Zrqrd_U0g1GRCDzXncgWLA_kO3Hyhjwy6Oe1S0cYohm2og@mail.gmail.com> <534D1F63.6080101@hartkopp.net> <534D270D.5060705@pengutronix.de> <534D31EF.6050107@hartkopp.net> <534D3748.6060602@pengutronix.de> <534D6C98.4020109@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:64011 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779AbaDURjv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 21 Apr 2014 13:39:51 -0400
In-Reply-To: <534D6C98.4020109@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: khurram gulzar <khurramgulzar@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

Hello Khurram,

is it possible for you to test this patch with your hardware?

It should apply on your used kernel without problems.

Thanks & best regards,
Oliver

On 15.04.2014 19:30, Oliver Hartkopp wrote:
> When accessing the SJA1000 controller registers in the indirect access mode,
> writing the register number and reading/writing the data has to be an atomic
> attempt.
> 
> As the sja1000_isa driver is an old style driver with a fixed number of
> instances the locking variable depends on the same index like all the other
> configuration elements given on the module command line.
> 
> As a positive side effect dev->dev_id is populated by the instance index,
> which was missing in 3e66d0138c05d9 ("can: populate netdev::dev_id for udev
> discrimination").
> 
> Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> ---
> 
> diff --git a/drivers/net/can/sja1000/sja1000_isa.c b/drivers/net/can/sja1000/sja1000_isa.c
> index df136a2..014695d 100644
> --- a/drivers/net/can/sja1000/sja1000_isa.c
> +++ b/drivers/net/can/sja1000/sja1000_isa.c
> @@ -46,6 +46,7 @@ static int clk[MAXDEV];
>  static unsigned char cdr[MAXDEV] = {[0 ... (MAXDEV - 1)] = 0xff};
>  static unsigned char ocr[MAXDEV] = {[0 ... (MAXDEV - 1)] = 0xff};
>  static int indirect[MAXDEV] = {[0 ... (MAXDEV - 1)] = -1};
> +static spinlock_t indirect_lock[MAXDEV];  /* lock for indirect access mode */
>  
>  module_param_array(port, ulong, NULL, S_IRUGO);
>  MODULE_PARM_DESC(port, "I/O port number");
> @@ -101,19 +102,26 @@ static void sja1000_isa_port_write_reg(const struct sja1000_priv *priv,
>  static u8 sja1000_isa_port_read_reg_indirect(const struct sja1000_priv *priv,
>  					     int reg)
>  {
> -	unsigned long base = (unsigned long)priv->reg_base;
> +	unsigned long flags, base = (unsigned long)priv->reg_base;
> +	u8 readval;
>  
> +	spin_lock_irqsave(&indirect_lock[priv->dev->dev_id], flags);
>  	outb(reg, base);
> -	return inb(base + 1);
> +	readval = inb(base + 1);
> +	spin_unlock_irqrestore(&indirect_lock[priv->dev->dev_id], flags);
> +
> +	return readval;
>  }
>  
>  static void sja1000_isa_port_write_reg_indirect(const struct sja1000_priv *priv,
>  						int reg, u8 val)
>  {
> -	unsigned long base = (unsigned long)priv->reg_base;
> +	unsigned long flags, base = (unsigned long)priv->reg_base;
>  
> +	spin_lock_irqsave(&indirect_lock[priv->dev->dev_id], flags);
>  	outb(reg, base);
>  	outb(val, base + 1);
> +	spin_unlock_irqrestore(&indirect_lock[priv->dev->dev_id], flags);
>  }
>  
>  static int sja1000_isa_probe(struct platform_device *pdev)
> @@ -169,6 +177,7 @@ static int sja1000_isa_probe(struct platform_device *pdev)
>  		if (iosize == SJA1000_IOSIZE_INDIRECT) {
>  			priv->read_reg = sja1000_isa_port_read_reg_indirect;
>  			priv->write_reg = sja1000_isa_port_write_reg_indirect;
> +			spin_lock_init(&indirect_lock[idx]);
>  		} else {
>  			priv->read_reg = sja1000_isa_port_read_reg;
>  			priv->write_reg = sja1000_isa_port_write_reg;
> @@ -198,6 +207,7 @@ static int sja1000_isa_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, dev);
>  	SET_NETDEV_DEV(dev, &pdev->dev);
> +	dev->dev_id = idx;
>  
>  	err = register_sja1000dev(dev);
>  	if (err) {
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
