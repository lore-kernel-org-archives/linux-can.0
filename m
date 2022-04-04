Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965A0C4707E
	for <linux-can@archiver.kernel.org>; Mon,  4 Apr 2022 21:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383087AbiDDVlW (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380400AbiDDUCS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 4 Apr 2022 16:02:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0EF30576;
        Mon,  4 Apr 2022 13:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84BDBB819DC;
        Mon,  4 Apr 2022 20:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48557C340F3;
        Mon,  4 Apr 2022 20:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649102418;
        bh=UnyFj8CQeTLpyLgUK0Q+kXJzH9zPVxCwJuLgHavoWvE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A1oDYnj2Q3HEO8kAOG2E7zNw8Zqiex/H6fwLixIdABdPaOMBMB6YZY9aRLMdkR1VP
         jDhECmzqeQECXvVpjM/MqTrZVE6k+hXqNXGg8Jtlw/rt91YrevQaFRBLzoNFA1+4gA
         qp9k9cU/ne9vMy5koCF5m3fO2nQbmetPcJS+WOf4ViZ7cwenI9rYgKbkBH/yg626QN
         0pLMDJp835CfxwqDRe+R5FJjOsz/E40/1pfp7s64ZbcfyK01baX/rVvEXMBY9WdKbX
         MYZaB/lYiSJdXiylUIgvQhItnBpP6x4cCakUC6InD5hnlYGL5iSCBg1BIj7Y8wvswL
         0yxcwmN+nWevA==
Received: by mail-il1-f182.google.com with SMTP id y16so7691170ilq.6;
        Mon, 04 Apr 2022 13:00:18 -0700 (PDT)
X-Gm-Message-State: AOAM532ApUfzpSkt68elZ3JU+1Mwcy3AiDD4NRHxboJzCWDG3wsK9kvN
        nzI1T77TxwI09ya1DlfKG5rHxt1EVJhKQvRv5A==
X-Google-Smtp-Source: ABdhPJy2I+THynd3YKwgtuqP1Z+qNUJvNfI+KxmiDjCSv83RkgMVAwjROABfaejv1c+IbVRz1hHVNh3x5d/12zN6G3A=
X-Received: by 2002:a05:6e02:1685:b0:2c9:a9e9:846 with SMTP id
 f5-20020a056e02168500b002c9a9e90846mr696618ila.273.1649102417418; Mon, 04 Apr
 2022 13:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220401153743.77871-1-wsa+renesas@sang-engineering.com> <20220404193101.nqe2s4rin3bzp6vx@pengutronix.de>
In-Reply-To: <20220404193101.nqe2s4rin3bzp6vx@pengutronix.de>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 4 Apr 2022 15:00:06 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJCZKFrucY_JJOZ-px0js82Dkgmbz7KmvDnwhU9UFyS5g@mail.gmail.com>
Message-ID: <CAL_JsqJCZKFrucY_JJOZ-px0js82Dkgmbz7KmvDnwhU9UFyS5g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: can: renesas,rcar-canfd: Document r8a77961 support
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-can@vger.kernel.org,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Apr 4, 2022 at 2:31 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> Cc += Rob, devicetree

That's a roll of the dice whether I see it, but for compatible string
additions I don't really need to.

In any case, the only way automated checks run is if the patch goes to
the DT list. IOW, use get_maintainers.pl.

Rob
