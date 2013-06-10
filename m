From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2] flexcan: Enable/Disable the CAN regulator in probe/remove
Date: Mon, 10 Jun 2013 16:05:17 -0300
Message-ID: <CAOMZO5CEWHTyw3s+vLtOVMdWmNWUndOZ3E4ohpCyTFXiz+VEOQ@mail.gmail.com>
References: <1370460445-15386-1-git-send-email-festevam@gmail.com>
	<1370460445-15386-2-git-send-email-festevam@gmail.com>
	<51B606C0.1070407@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:35688 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940Ab3FJTFS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Jun 2013 15:05:18 -0400
Received: by mail-vc0-f171.google.com with SMTP id gd11so1893794vcb.30
        for <linux-can@vger.kernel.org>; Mon, 10 Jun 2013 12:05:17 -0700 (PDT)
In-Reply-To: <51B606C0.1070407@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: shawn.guo@linaro.org, linux-can@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Hi Marc,

On Mon, Jun 10, 2013 at 2:02 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 06/05/2013 09:27 PM, Fabio Estevam wrote:
>> mx28evk has two CAN ports and they are controlled by the same GPIO.
>>
>> If can0 runs flexcan_chip_stop(), then the regulator will be disabled, which
>> means that can1 cannot run anymore.
>
> Are you sure? I think the regulator framework has a proper refcount.

Yes, the refcount is OK. The problem is that on mx28evk we have two
CAN ports controlled by the same regulator.

Let's say that can0 executes flexcan_chip_stop:

static void flexcan_chip_stop(struct net_device *dev)
{
	struct flexcan_priv *priv = netdev_priv(dev);
	struct flexcan_regs __iomem *regs = priv->base;
	u32 reg;

	/* Disable all interrupts */
	flexcan_write(0, &regs->imask1);

	/* Disable + halt module */
	reg = flexcan_read(&regs->mcr);
	reg |= FLEXCAN_MCR_MDIS | FLEXCAN_MCR_HALT;
	flexcan_write(reg, &regs->mcr);

        if (priv->reg_xceiver)
	        regulator_disabled(priv->reg_xceiver);
...

It will turn off the transceiver here, which means that can1 will not
be able to operate.

Currently this situation is properly handled inside mach-mxs by only
disabling the CAN transceiver when both CAN ports are not used.

With the conversion to regulator I thought on enabling the regulator
at the probe function and disabling it at remove.

I understand that the power consumption will be higher in this case,
but I could not find a better alternative so far.

Regards,

Fabio Estevam
