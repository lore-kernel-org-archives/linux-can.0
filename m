From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 3/6] can: flexcan: add error passive state quirk
Date: Thu, 31 Aug 2017 13:44:27 +0200
Message-ID: <f43242ea-ca7e-8d56-880f-cd629759d185@grandegger.com>
References: <3cbb306756434138b1c80fd76ecace8d@SGPMBX1017.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy03.manitu.net ([217.11.48.67]:49082 "EHLO
        mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751074AbdHaLo3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 31 Aug 2017 07:44:29 -0400
In-Reply-To: <3cbb306756434138b1c80fd76ecace8d@SGPMBX1017.APAC.bosch.com>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>



Am 31.08.2017 um 10:25 schrieb ZHU Yi (ST-FIR/ENG1-Zhu):
>>From 916835bc515f24dff133526239c9e464b0153ba0 Mon Sep 17 00:00:00 2001
> From: Zhu Yi <yi.zhu5@cn.bosch.com>
> Date: Thu, 31 Aug 2017 09:21:24 +0800
> Subject: [PATCH 3/6] can: flexcan: add error passive state quirk
> 
> Add FLEXCAN_QUIRK_BROKEN_PERR_STATE for better description
> of the missing error passive interrupt quirk.
> 
> Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
> Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
> ---
>   drivers/net/can/flexcan.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index e163c55..712b7de 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -198,6 +198,7 @@
>   #define FLEXCAN_QUIRK_ENABLE_EACEN_RRS	BIT(3) /* Enable EACEN and RRS bit in ctrl2 */
>   #define FLEXCAN_QUIRK_DISABLE_MECR	BIT(4) /* Disable Memory error detection */
>   #define FLEXCAN_QUIRK_USE_OFF_TIMESTAMP	BIT(5) /* Use timestamp based offloading */
> +#define FLEXCAN_QUIRK_BROKEN_PERR_STATE	BIT(6) /* No interrupt for error passive */
>   
>   /* Structure of the message buffer */
>   struct flexcan_mb {
> @@ -767,7 +768,8 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
>   
>   	/* state change interrupt or broken error state quirk fix is enabled */
>   	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
> -	    (priv->devtype_data->quirks & FLEXCAN_QUIRK_BROKEN_WERR_STATE))
> +	    (priv->devtype_data->quirks & FLEXCAN_QUIRK_BROKEN_WERR_STATE) ||
> +	    (priv->devtype_data->quirks & FLEXCAN_QUIRK_BROKEN_PERR_STATE))

            (priv->devtype_data->quirks & (FLEXCAN_QUIRK_BROKEN_WERR_STATE |
                                           FLEXCAN_QUIRK_BROKEN_PERR_STATE))
	    

Is a bit more efficient. Here and in many other places.

>   		flexcan_irq_state(dev, reg_esr);
>   
>   	/* bus error IRQ - handle if bus error reporting is activated */
> @@ -889,6 +891,7 @@ static int flexcan_chip_start(struct net_device *dev)
>   	 * any error warning or passive interrupts.
>   	 */
>   	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_BROKEN_WERR_STATE ||
> +	    priv->devtype_data->quirks & FLEXCAN_QUIRK_BROKEN_PERR_STATE ||

Ditto.

>   	    priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
>   		reg_ctrl |= FLEXCAN_CTRL_ERR_MSK;

Do we want to enable the error interrupt from the beginning? We can 
wait for the error warning interrupt!?

Wolfgang.
