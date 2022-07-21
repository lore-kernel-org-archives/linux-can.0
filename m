Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E25CCA487
	for <linux-can@archiver.kernel.org>; Thu, 21 Jul 2022 16:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiGUQDS (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 21 Jul 2022 12:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiGUQDR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 21 Jul 2022 12:03:17 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB7887C1C
        for <linux-can@vger.kernel.org>; Thu, 21 Jul 2022 09:03:17 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id f73so3478630yba.10
        for <linux-can@vger.kernel.org>; Thu, 21 Jul 2022 09:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9V9VZN6lAEQF6HCAvRIPj9uneFryFIMlLjgG4+lKXOc=;
        b=t3HJsP1VsmEcU1RGE6bmnX+NHF2NAOEW3VfRxdMghFoGUuicixHflc9A/l9BNr2bH4
         Ifh49D9BU44R1dshoPFL8aqmXJJ1k1y82WDF9j2nO3vBTxaJvOFVo7sxLvGqglRg/TtB
         qI9wV2O4vAxBoJboxT44HoUU3nEbkwHsnafzhT5eXDE/MJHgAQtXiI3Jq3lDwOrlv8nI
         5zJK+LtQkPvhec8Yhi2eSHV/HcAXU3ib65DmD7U/J8EtuLWQ5JqF/9DYoHdms5zZ0m1f
         Q6VI5pVMP7TmxjddDv2Xu+h4w1ge56vXt0z+9Pa0X01Zc7jOjiTz3AZlAKA5ata43PeB
         1PBQ==
X-Gm-Message-State: AJIora+zxc6o0pp+WtuWB00/5ZA+f7y51FRyDKGnCCQQAUgKxXGREI3+
        pSrB/EjY2ZAiH9kGhzxMO2mocyuZyKh0g/zu5NI=
X-Google-Smtp-Source: AGRyM1vOioP1X+h/p06HHqtCiHtUJLOj5iGmmjnY7YCr21ePknuBcHV/R0MgjrR0TFAIvwDjnAPB9yBdoNw1d6/ToO8=
X-Received: by 2002:a5b:ad0:0:b0:670:81c5:1b52 with SMTP id
 a16-20020a5b0ad0000000b0067081c51b52mr11447083ybr.20.1658419396206; Thu, 21
 Jul 2022 09:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220721155228.3399103-1-mkl@pengutronix.de>
In-Reply-To: <20220721155228.3399103-1-mkl@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Fri, 22 Jul 2022 01:03:05 +0900
Message-ID: <CAMZ6RqJw8ViJ5bRdJdURbDgFGE5Yggm6NLHR+KaxfUDmXeoORQ@mail.gmail.com>
Subject: Re: [PATCH] can: pch_can: fix uninitialized use of errc
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri. 22 Jul. 2022 at 00:54, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> Fix the uninitialized use of errc by moving the ioread32() up, before
> accessing it.
>
> Fixes: 3a5c7e4611dd ("can: pch_can: do not report txerr and rxerr during bus-off")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

I did not see that you were working on it. I also sent a patch but you
beat me by six minutes. Thanks for the quick action!

Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
