Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8483C433EF
	for <linux-can@archiver.kernel.org>; Wed,  9 Mar 2022 14:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbiCIORZ (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 9 Mar 2022 09:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbiCIORY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Mar 2022 09:17:24 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C6ABD8A6
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 06:16:25 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id u3so4642428ybh.5
        for <linux-can@vger.kernel.org>; Wed, 09 Mar 2022 06:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J7N3v/0oKNzD0yORORWpgcnOtNwENjjmqzCOSif0KfQ=;
        b=SQFrm3TYJnfNRj2nsDk5/RB7/BvtPluDwJeB+tu01AUEVaj7EMNcoCz4UEk8k84nwG
         nwNFDBl6Nvj7XCBYIp5Jt66f/NzJ+XGoo/bC4Mj0MbvCIj+oxQxB6Mb7ur4lpg4YMa2F
         GojGdzdtx02ZuXCtC0bhgDZzqTJ3GiQhN54bTpxtgKuIY+sjm7W9rZu2SuU2EUZPg2bg
         tH1aeUK8xJJC589taGMVEwV3IJTpikuq0xx/Wbx1qKw+/KL1DP5pzP3YLsY7IKFZfAUb
         9F64lzBC0TJCza6SZUl4vMCfj7Lcg9aBbVM/1e/z8MQ+bpiIGZ6iXK6pQ9WmSHtYn7Tg
         lcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J7N3v/0oKNzD0yORORWpgcnOtNwENjjmqzCOSif0KfQ=;
        b=Duel4Jq49v3NTmAZqTvtyE+U8ZFIFNfwmfMHHiUz+STlqUwfXQaNkNQCoRDiwd1320
         C7sQFPR8s5yAZkHTfJFcRHClQ4BXg/qd/I10E/2kIeI0MG2V+oG3OjgDAGSeBUAwYjBX
         8ojkEF2h1rWfCP0EsQHVqWbF8FabP15654hLDxmnD5sbzy+mSPn/l5xEcSrvTA+3Zgio
         NSejEVVKD4lfYq5+GzGdfVBK4k/ZlMijF6CnkwkoDmFmuSfcDe638Tj5XScypYHkHElC
         LMNCpSZh/liBrUChQx/sar5dL9+scsdqcHaFDabPAaPlw+YnqLFVCL3NQQPikTJb0Elw
         RCzw==
X-Gm-Message-State: AOAM532YYrKduhONmvggwjPWOl4w4cgJA93m9JeBqNlT5RuYBGKVSG0e
        6pdExWuIVtG7c6D9S3bcLWB9YoJsWIULMORMXXr8nUSEXFs=
X-Google-Smtp-Source: ABdhPJy9a3Px/Pu1d0/AC+p5x6J61a+KLw+lZ7zM2s/yKdVSTRMMpongh8WybVdFm5miVrmC8KCaAYJb1/ORRe+8N0w=
X-Received: by 2002:a25:dacf:0:b0:629:15d8:647d with SMTP id
 n198-20020a25dacf000000b0062915d8647dmr16587182ybf.142.1646835384723; Wed, 09
 Mar 2022 06:16:24 -0800 (PST)
MIME-Version: 1.0
References: <20220309124132.291861-1-mkl@pengutronix.de> <20220309124132.291861-15-mkl@pengutronix.de>
 <CAMZ6Rq+R-yxYm4Kk+aoaQXNedKkmq0LbwDSxs0nXdJMn6t+=bw@mail.gmail.com>
In-Reply-To: <CAMZ6Rq+R-yxYm4Kk+aoaQXNedKkmq0LbwDSxs0nXdJMn6t+=bw@mail.gmail.com>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Wed, 9 Mar 2022 23:16:14 +0900
Message-ID: <CAMZ6RqK57zG88ocEqeeyx+bjM9SZH6h0gqXyN0+NTbHmSOYRsQ@mail.gmail.com>
Subject: Re: [can-next-rfc 14/21] can: gs_usb: use union and FLEX_ARRAY for
 data in struct gs_host_frame
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de,
        Peter Fink <pfink@christ-es.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed. 9 Mar. 2022 at 23:05, Vincent Mailhol <vincent.mailhol@gmail.com> w=
rote:
>
> On Wed. 9 Mar 2022 =C3=A0 22:39, Marc Kleine-Budde <mkl@pengutronix.de> w=
rote:
> > From: Peter Fink <pfink@christ-es.de>
> >
> > Modify struct gs_host_frame to make use of a union and
> > DECLARE_FLEX_ARRAY to be able to store different data (lengths), which
> > will be added in later commits.

I missed that part. You can ignore my previous message.


Yours sincerely,
Vinent Mailhol
