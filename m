Return-Path: <linux-can-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B70C77B73
	for <linux-can@archiver.kernel.org>; Sun, 21 May 2023 09:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjEUJUP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-can@archiver.kernel.org>);
        Sun, 21 May 2023 05:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjEUJUO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 21 May 2023 05:20:14 -0400
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B352493;
        Sun, 21 May 2023 02:20:13 -0700 (PDT)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-528dd896165so3372953a12.2;
        Sun, 21 May 2023 02:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684660813; x=1687252813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HwM6KmZId1WNbACaRjkfOnAGeuoeekyl1zBNcHd9TA=;
        b=XryRZG9kjgR04Bo7y5DJ1NWf9L1YacHwnzTTjdMy6+HRQxSLhryJA2mwGII3zz4uHf
         ZXFo68HzIhcQfxvylfF9alveHChOjBEwKQCFSm5fugwpEwaDvScEd6S6CPs2iwj6uZdG
         2FglrwCM1ZXbqReWy0LC9/5fiet6G2k2OEcpPL3emVJ+OQq5KgeD18i0yP3VNGbB1oW+
         8i7Ilei2iPMa4mAaSB4YRKswINobG23Be6ot5vYOkzlWRqbloU+H6O94Aqr7b11LkFoE
         /pzCE2TMoq+92poT6Yp6pJKyEs7rvrsrb7zBntWzm6Ls2FmkiZS67RqSeCJKC4vrP1ZU
         bNgw==
X-Gm-Message-State: AC+VfDw9cdKdoBQOuy+PYdJ/FObCY6UhgDGhvE8Xc/oW9qVVOajWK5hS
        Ffm1gGwIWtsCLVC8cVQLTALl+zGqxJbiohJt+mI=
X-Google-Smtp-Source: ACHHUZ5EcacBz0A46K/VKH3jwBK9qhZjbtZFgrRtmxBbmqtC0ruud8NkHVNYVHupcXDOIoSnjQ9K+XwaOO3YjxUV2t8=
X-Received: by 2002:a17:90a:e2d3:b0:246:5f9e:e4cf with SMTP id
 fr19-20020a17090ae2d300b002465f9ee4cfmr7011890pjb.43.1684660813127; Sun, 21
 May 2023 02:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230519195600.420644-1-frank.jungclaus@esd.eu>
In-Reply-To: <20230519195600.420644-1-frank.jungclaus@esd.eu>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sun, 21 May 2023 18:20:02 +0900
Message-ID: <CAMZ6Rq+hYcDks2MWz5fuhHogKYhAhSHg0J7bpKQ8DZaxpXRriw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] can: esd_usb: More preparation before supporting
 esd CAN-USB/3
To:     Frank Jungclaus <frank.jungclaus@esd.eu>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        =?UTF-8?Q?Stefan_M=C3=A4tje?= <stefan.maetje@esd.eu>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Frank,

On Sat. 20 mai 2023 à 04:57, Frank Jungclaus <frank.jungclaus@esd.eu> wrote:
> Apply another small batch of patches as preparation for adding support
> of the newly available esd CAN-USB/3 to esd_usb.c.
> ---

I sent two nitpicks but aside from that the series looks good. Thank
you for taking time to clean-up the existing code before introducing
the new changes.

I do not think I will need to review the v3, so in advance:

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
