Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A5EC433B4
	for <linux-can@archiver.kernel.org>; Thu,  1 Apr 2021 20:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0291610F7
	for <linux-can@archiver.kernel.org>; Thu,  1 Apr 2021 20:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbhDAUkU (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 1 Apr 2021 16:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234462AbhDAUkT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 1 Apr 2021 16:40:19 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C5AC0613E6
        for <linux-can@vger.kernel.org>; Thu,  1 Apr 2021 13:40:17 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id v186so2308964pgv.7
        for <linux-can@vger.kernel.org>; Thu, 01 Apr 2021 13:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AHpCAOocAnN7On01G9XoSDRYZjkNolynvq/tTaO1fSk=;
        b=NdigQb38UiNNficOANhOu/rco2c34D4Ahnyof2hOuWqr9VkcOV8DIDc+rPDf14Qcs7
         /RJPaMaMzhV69MnT+1pZuKhMjo33iyyF/FoMls7HsMbkxjzWgPqLye1vMXjz+sCgnCza
         yB2MM/Jk0XY01oSzgcQtUkRkWBYN/aiC5v6w8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AHpCAOocAnN7On01G9XoSDRYZjkNolynvq/tTaO1fSk=;
        b=GFSCnI8BIZqkMlUhM60qe/SVqxqf3+8odROLbtLh6UYxx0MrMxi1XV/bCjLDviIMEi
         qFLpl+w0fqzBf/WC0lRZPRWNxe/KzYiJqkeAUw/WJBLDKGzv2dS0HWRM5idpcLIvzWXj
         jDq2GDaO29Lxqv1fWGEu7+jFghwV8DR5QA4OpnLwjUO2y1i19dwuEwS4p7/R46Jqp6G1
         En/BkCMwTnXDu4/wjAI0bZRd8JnW0RV4jBMb1qdyy7cb19s2OvZfbsZeomj0UNdaRo7N
         4N9NA2P1VxQm8fPg1gOdYAM2hj55xmlRbMkk3lpllDVcngEZfnK1UuMkedVn2CYov/c9
         L+pg==
X-Gm-Message-State: AOAM533o/xpSPlLxDtXKoCRd2BDoYzMZDm11ezQ83LAUjz2FPEiIDwLY
        xPj9U22R55ArbU65blvPSfbiImEGUUZ15A==
X-Google-Smtp-Source: ABdhPJwWLSKBtmBUUEHtJCV4dOZ4bkmOsw+q2B6zH+ICf12vh8oMt5B22I4Fn0j6ET3PeC7ZNSu8QQ==
X-Received: by 2002:a65:6648:: with SMTP id z8mr9248018pgv.268.1617309617590;
        Thu, 01 Apr 2021 13:40:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g3sm5940011pfk.186.2021.04.01.13.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 13:40:17 -0700 (PDT)
Date:   Thu, 1 Apr 2021 13:40:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: Re: [PATCH] can: m_can: m_can_receive_skb(): add missing error
 handling to can_rx_offload_queue_sorted() call
Message-ID: <202104011340.00B25B1656@keescook>
References: <20210401084515.1455013-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401084515.1455013-1-mkl@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, Apr 01, 2021 at 10:45:15AM +0200, Marc Kleine-Budde wrote:
> In commit 1be37d3b0414 ("can: m_can: fix periph RX path: use
> rx-offload to ensure skbs are sent from softirq context") the RX path
> for peripherals (i.e. SPI based m_can controllers) was converted to
> the rx-offload infrastructure. However, the error handling for
> can_rx_offload_queue_sorted() was forgotten.
> can_rx_offload_queue_sorted() will return with an error if the
> internal queue is full.
> 
> This patch adds the missing error handling, by increasing the
> rx_fifo_errors.
> 
> Fixes: 1be37d3b0414 ("can: m_can: fix periph RX path: use rx-offload to ensure skbs are sent from softirq context")
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1503583 ("Error handling issues")
> Cc: Torin Cooper-Bennun <torin@maxiluxsystems.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Thanks for the fix!

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/net/can/m_can/m_can.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 890ed826a355..9df1ba1f2d04 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -466,10 +466,17 @@ static void m_can_receive_skb(struct m_can_classdev *cdev,
>  			      struct sk_buff *skb,
>  			      u32 timestamp)
>  {
> -	if (cdev->is_peripheral)
> -		can_rx_offload_queue_sorted(&cdev->offload, skb, timestamp);
> -	else
> +	if (cdev->is_peripheral) {
> +		struct net_device_stats *stats = &cdev->net->stats;
> +		int err;
> +		
> +		err = can_rx_offload_queue_sorted(&cdev->offload, skb,
> +						  timestamp);
> +		if (err)
> +			stats->rx_fifo_errors++;
> +	} else {
>  		netif_receive_skb(skb);
> +	}
>  }
>  
>  static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
> -- 
> 2.30.2
> 
> 

-- 
Kees Cook
