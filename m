Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25384C433E9
	for <linux-can@archiver.kernel.org>; Tue, 16 Mar 2021 16:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0127764F5D
	for <linux-can@archiver.kernel.org>; Tue, 16 Mar 2021 16:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238329AbhCPQCa (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238335AbhCPQAs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 Mar 2021 12:00:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A70C061765
        for <linux-can@vger.kernel.org>; Tue, 16 Mar 2021 09:00:32 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1lMC7P-0001cf-67; Tue, 16 Mar 2021 17:00:27 +0100
Subject: [BUG] Re: [net 3/6] can: flexcan: invoke flexcan_chip_freeze() to
 enter freeze mode
To:     Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
Cc:     Joakim Zhang <qiangqing.zhang@nxp.com>, linux-can@vger.kernel.org,
        kernel@pengutronix.de, kuba@kernel.org, davem@davemloft.net
References: <20210301112100.197939-1-mkl@pengutronix.de>
 <20210301112100.197939-4-mkl@pengutronix.de>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <65137c60-4fbe-6772-6d48-ac360930f62b@pengutronix.de>
Date:   Tue, 16 Mar 2021 17:00:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210301112100.197939-4-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Joakim, Marc,

On 01.03.21 12:20, Marc Kleine-Budde wrote:
> From: Joakim Zhang <qiangqing.zhang@nxp.com>
> 
> Invoke flexcan_chip_freeze() to enter freeze mode, since need poll
> freeze mode acknowledge.
> 
> Fixes: e955cead03117 ("CAN: Add Flexcan CAN controller driver")
> Link: https://lore.kernel.org/r/20210218110037.16591-4-qiangqing.zhang@nxp.com
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/flexcan.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index e66a51dbea0a..134c05757a3b 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -1480,10 +1480,13 @@ static int flexcan_chip_start(struct net_device *dev)
>  
>  	flexcan_set_bittiming(dev);
>  
> +	/* set freeze, halt */
> +	err = flexcan_chip_freeze(priv);
> +	if (err)
> +		goto out_chip_disable;

With v5.12-rc3, both my FlexCAN controllers on an i.MX6Q now divide by zero
on probe because priv->can.bittiming.bitrate == 0 inside of flexcan_chip_freeze.

Reverting this patch fixes it.

> +
>  	/* MCR
>  	 *
> -	 * enable freeze
> -	 * halt now
>  	 * only supervisor access
>  	 * enable warning int
>  	 * enable individual RX masking
> @@ -1492,9 +1495,8 @@ static int flexcan_chip_start(struct net_device *dev)
>  	 */
>  	reg_mcr = priv->read(&regs->mcr);
>  	reg_mcr &= ~FLEXCAN_MCR_MAXMB(0xff);
> -	reg_mcr |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT | FLEXCAN_MCR_SUPV |
> -		FLEXCAN_MCR_WRN_EN | FLEXCAN_MCR_IRMQ | FLEXCAN_MCR_IDAM_C |
> -		FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
> +	reg_mcr |= FLEXCAN_MCR_SUPV | FLEXCAN_MCR_WRN_EN | FLEXCAN_MCR_IRMQ |
> +		FLEXCAN_MCR_IDAM_C | FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
>  
>  	/* MCR
>  	 *
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
