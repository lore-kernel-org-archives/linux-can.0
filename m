From: Thor Thayer <tthayer.linux@gmail.com>
Subject: Re: [PATCH v4 3/3] can: c_can: add hwinit support for non-TI devices
Date: Tue, 27 May 2014 12:01:06 -0500
Message-ID: <CAF03EBcSH=zWqEFuEFLvRQYgez8j=hKLukaV-ogkcNVtgMtQXA@mail.gmail.com>
References: <1399988421-19429-1-git-send-email-mkl@pengutronix.de>
	<1399988421-19429-4-git-send-email-mkl@pengutronix.de>
	<20140527120521.GB15088@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-vc0-f172.google.com ([209.85.220.172]:64587 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbaE0RBH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 27 May 2014 13:01:07 -0400
Received: by mail-vc0-f172.google.com with SMTP id ik5so7656951vcb.3
        for <linux-can@vger.kernel.org>; Tue, 27 May 2014 10:01:06 -0700 (PDT)
In-Reply-To: <20140527120521.GB15088@amd.pavel.ucw.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Machek <pavel@denx.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, kernel@pengutronix.de, Thor Thayer <tthayer@altera.com>, gsi@denx.de

On Tue, May 27, 2014 at 7:05 AM, Pavel Machek <pavel@denx.de> wrote:
> Hi!
>
>
>> Non-TI chips (including socfpga) needs different raminit sequence. Implement
>> it.
>>
>> Tested-by: Thor Thayer <tthayer@altera.com>
>> Signed-off-by: Thor Thayer <tthayer@altera.com>
>> Signed-off-by: Pavel Machek <pavel@denx.de>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>
> Thanks for the series. This should mean working can on socfpga...
>
> Just for the record, these are the changes that were on rocketboards
> originally and that are not merged. They do not seem to be required
> according to my testing.
>
> If anyone knows why to do them, it would be good idea to speak up now.
>
> Best regards,
>                                                                 Pavel

Hi Pavel!

For the rocketboards changes, I grabbed the series of changes from
Benedict Spranger submitted ([PATCH 05/16] c_can: use 32 bit access
for D_CAN) on 9/9/2013 after searching for D_CAN patches. This patch
solved my packet problems but that could have been due to the issues
that Thomas Gleixner found.

As far as the CONTROL_MIL bit, this doesn't appear to be necessary and
should not be added.

I tested the checked-in changes on the Altera Development Kit to a
Microchip CAN analyzer. Everything looks fine. It appears these
additional changes aren't needed.

Regards,
                                              Thor

>
> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
> index e154b4c..824ec21 100644
> --- a/drivers/net/can/c_can/c_can.c
> +++ b/drivers/net/can/c_can/c_can.c
> @@ -48,6 +48,7 @@
>  #define C_CAN_IFACE(reg, iface)        (C_CAN_IF1_##reg + (iface) * IF_ENUM_REG_LEN)
>
>  /* control extension register D_CAN specific */
> +#define CONTROL_MIL            BIT(17)
>  #define CONTROL_EX_PDR         BIT(8)
>
>  /* control register */
> @@ -239,12 +240,20 @@ static inline void c_can_reset_ram(const struct c_can_priv *priv, bool enable)
>
>  static void c_can_irq_control(struct c_can_priv *priv, bool enable)
>  {
> -       u32 ctrl = priv->read_reg(priv, C_CAN_CTRL_REG) & ~CONTROL_IRQMSK;
> +       u32 ctrl;
> +
> +       if (priv->type == BOSCH_D_CAN)
> +               ctrl = priv->read_reg32(priv, C_CAN_CTRL_REG) & ~CONTROL_IRQMSK;
> +       else
> +               ctrl = priv->read_reg(priv, C_CAN_CTRL_REG) & ~CONTROL_IRQMSK;
>
>         if (enable)
>                 ctrl |= CONTROL_IRQMSK;
>
> -       priv->write_reg(priv, C_CAN_CTRL_REG, ctrl);
> +       if (priv->type == BOSCH_D_CAN)
> +               priv->write_reg32(priv, C_CAN_CTRL_REG, ctrl);
> +       else
> +               priv->write_reg(priv, C_CAN_CTRL_REG, ctrl);
>  }
>
>  static void c_can_obj_update(struct net_device *dev, int iface, u32 cmd, u32 obj)
> @@ -505,16 +514,22 @@ static int c_can_set_bittiming(struct net_device *dev)
>         netdev_info(dev,
>                 "setting BTR=%04x BRPE=%04x\n", reg_btr, reg_brpe);
>
> -       ctrl_save = priv->read_reg(priv, C_CAN_CTRL_REG);
> +       if (priv->type == BOSCH_D_CAN)
> +               ctrl_save = priv->read_reg32(priv, C_CAN_CTRL_REG);
> +       else
> +               ctrl_save = priv->read_reg(priv, C_CAN_CTRL_REG);
>         ctrl_save &= ~CONTROL_INIT;
> -       priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_CCE | CONTROL_INIT);
> +       priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_CCE | CONTROL_INIT); /* FIXME: want to do write32? */
>         res = c_can_wait_for_ctrl_init(dev, priv, CONTROL_INIT);
>         if (res)
>                 return res;
>
>         priv->write_reg(priv, C_CAN_BTR_REG, reg_btr);
>         priv->write_reg(priv, C_CAN_BRPEXT_REG, reg_brpe);
> -       priv->write_reg(priv, C_CAN_CTRL_REG, ctrl_save);
> +       if (priv->type == BOSCH_D_CAN)
> +               priv->write_reg32(priv, C_CAN_CTRL_REG, ctrl_save);
> +       else
> +               priv->write_reg(priv, C_CAN_CTRL_REG, ctrl_save);
>
>         return c_can_wait_for_ctrl_init(dev, priv, 0);
>  }
> @@ -1235,7 +1250,7 @@ int c_can_power_up(struct net_device *dev)
>
>         /* Clear PDR and INIT bits */
>         val = priv->read_reg(priv, C_CAN_CTRL_EX_REG);
> -       val &= ~CONTROL_EX_PDR;
> +       val &= ~(CONTROL_EX_PDR | CONTROL_MIL);
>         priv->write_reg(priv, C_CAN_CTRL_EX_REG, val);
>         val = priv->read_reg(priv, C_CAN_CTRL_REG);
>         val &= ~CONTROL_INIT;
>
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
