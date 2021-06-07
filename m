Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3161C47095
	for <linux-can@archiver.kernel.org>; Mon,  7 Jun 2021 16:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BA4961C5D
	for <linux-can@archiver.kernel.org>; Mon,  7 Jun 2021 16:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbhFGQdB (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 7 Jun 2021 12:33:01 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:42730 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbhFGQa5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 7 Jun 2021 12:30:57 -0400
Received: by mail-lf1-f46.google.com with SMTP id a2so27266092lfc.9
        for <linux-can@vger.kernel.org>; Mon, 07 Jun 2021 09:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZJajTiG1pO7FKqF5OSKd0lfapkYFLpcjfATFaOyP3tc=;
        b=RuaepdpiL9h+sukLaiNq6Z9bVLynH33YyAEDA3Q5CSHFSBqWZCxtho/jTv7X9RWq6i
         ZaViWpBRgNRqjEi021UuOnJCPMjfLomMTRqGy3J0Pwht+dV+vPy/7cGP+WlIlboJJgTG
         /60d1GDZK7kxghcmGoL/p3+5JBX0CAjIYdH6VUOhVGFhE0ms4exUEQ2T702JIX53DN2U
         eOwaGWUeATJu/GRvuEhQmbOmzj/n1DnSn8Dne35990Kb/mbtbW+zUkhVeFPKRzdc46qj
         UrvUoZxhGxAnPLgN6y8r9v9D5Dqu5/T07U/JJN16affdN7dE+WJ30Ilq+kDckXZsYIGK
         fodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZJajTiG1pO7FKqF5OSKd0lfapkYFLpcjfATFaOyP3tc=;
        b=U0BSHhACRfXRZaB2UmyydmGXdXv8Ji9Fqo4UJqm0ceKUCbj/8oKAajp/CQdsBcEhXh
         uOanCKclGE6JkrFJ7bSRA9ANM32C7LrzF+JJjwCPmdm9E1Lgy/duygnBk75SX3QidhNo
         xbMcR1JwY5kJTAlyRAvpT0XQpuN/B7G5kWMMITYq1evksg/IPmQ1WH4Jf7B8Fy7S4JDw
         EuN7ITd3qy6B0mWyWJyTB9zdchtBn5qtVmuuYBSlpPpgFTBe3pXWk2kU4ys0T+7aBJ7b
         3FgGIhKR0f+U3eTCO0w5Fl5/IHPuNvn2CfNABEp/O6PI8AJU9k7XMkVN5VfD86QDbh2f
         sOTQ==
X-Gm-Message-State: AOAM530kppXUCsRAFndRgshNqzXnHG6iyhiY4sI0fbSNljibGA7pfYqP
        kU4FA2lDyAdHDZO9LDAeLLtx2CBt88NuQJ/WXGvSvn7kj/A=
X-Google-Smtp-Source: ABdhPJzY5SkaELhywsGzFtP1nMzdyEiKuggXQjTZBNmL4GalthVdOkY8J1l9jCzsMTYYOI7f8Ir+U+EHf1PjpNyZH1Y=
X-Received: by 2002:ac2:51a9:: with SMTP id f9mr12030788lfk.223.1623083284336;
 Mon, 07 Jun 2021 09:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210603142450.2221703-1-festevam@gmail.com> <20210607150108.r5idhfnaxdccaduc@pengutronix.de>
In-Reply-To: <20210607150108.r5idhfnaxdccaduc@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 7 Jun 2021 13:27:53 -0300
Message-ID: <CAOMZO5DtFXBNrTPQ=JT=e3u_uthd2sbHv6sf9Zp=aTr5KGobyQ@mail.gmail.com>
Subject: Re: [PATCH] can: mcp251xfd: Align the table of comments
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On Mon, Jun 7, 2021 at 12:01 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 03.06.2021 11:24:50, Fabio Estevam wrote:
> > Align the table of comments for better readability.
>
> My editor uses 1 tab = 8 spaces and it looks correct without the patch.
> Have a look at:
>
> | tps://elixir.bootlin.com/linux/v5.12/source/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c#L2915

Oh, it is on my editor that it appears unaligned then. Sorry for the noise!

Cheers
