From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 1/6] can: flexcan: fix state transition regression
Date: Thu, 31 Aug 2017 13:37:16 +0200
Message-ID: <ea64fc2b-e94d-3fc0-35ad-3a70d94800e6@grandegger.com>
References: <1f925f5e8c9747cf92351ce2bc471bff@SGPMBX1017.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy03.manitu.net ([217.11.48.67]:44220 "EHLO
        mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751318AbdHaLhS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 31 Aug 2017 07:37:18 -0400
In-Reply-To: <1f925f5e8c9747cf92351ce2bc471bff@SGPMBX1017.APAC.bosch.com>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

Hello ZHU Yi,

usually a [PATCH 0/x] is coming first telling what the series does. We
use "git format-patch --cover-letter ..." for that purpose.

Am 31.08.2017 um 10:24 schrieb ZHU Yi (ST-FIR/ENG1-Zhu):
>>From 08db02ac30d379838be511bc12b851dad1ef8363 Mon Sep 17 00:00:00 2001
> From: Zhu Yi <yi.zhu5@cn.bosch.com>
> Date: Wed, 30 Aug 2017 13:57:50 +0800
> Subject: [PATCH 1/6] can: flexcan: fix state transition regression
> 
> Update state upon any interrupt to report correct state transitions
> in case the flexcan core enabled the broken error state quirk fix.
> 
> Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
> Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
> ---
>   drivers/net/can/flexcan.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 13f0f21..df4bfb8 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -765,8 +765,9 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
>   		flexcan_write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
>   	}
>   
> -	/* state change interrupt */
> -	if (reg_esr & FLEXCAN_ESR_ERR_STATE)
> +	/* state change interrupt or broken error state quirk fix is enabled */
> +	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
> +	    (priv->devtype_data->quirks & FLEXCAN_QUIRK_BROKEN_ERR_STATE))
>   		flexcan_irq_state(dev, reg_esr);

This means that flexcan_irq_state() is called for any interrupt source.
That's what we had in the pre rx-offload version. Thinking about it:
do we need that (overhead for RX and TX)? Maybe the following works already:

 +	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
 +	    ((priv->devtype_data->quirks & FLEXCAN_QUIRK_BROKEN_ERR_STATE) &&
 +		(reg_esr & FLEXCAN_ESR_ERR_STATE)))

>   
>   	/* bus error IRQ - handle if bus error reporting is activated */
> 

