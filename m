Return-Path: <linux-can-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBBEC77B75
	for <linux-can@archiver.kernel.org>; Tue, 23 May 2023 09:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbjEWJx0 (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 23 May 2023 05:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236373AbjEWJxK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 May 2023 05:53:10 -0400
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EB594
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:51:32 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4f00c33c3d6so8349144e87.2
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1684835431; x=1687427431;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVa2qIjnXkaVa7r43MFxoM+1P1OJSlYDAWlq2yr7K60=;
        b=d4MBgwwH6l7gDjsm8dvnlH4sRz81cV3N8pcFcVi1PlCjDyAzTFTK1oDZ1P1xwi+Ct+
         mnQ2CazZEJxqsGi6L6akdmhX0Sck6aoTuRn5UybBpU2qoIWIVsa3TLHEr0PhZ89w2McQ
         g20v/WoTws0fH6Pr8RRdkLPp3Wq3docSLjH0pYcCWVK9+kWob9/wFBblpcUZdRFDPIl2
         5pm1GwXTO5Gr9dT6Ar137ikiZ9WhNj/EIcdJt7znrWYFW5OWbVPQQuj/lmYFnuh2Yfpz
         NcP26aVb4a/392gMQReTLQyUa6YpMtVuJlQZS71wHwIQikKyOXAgJpm+yNmhZ8F9ztv4
         lK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684835431; x=1687427431;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dVa2qIjnXkaVa7r43MFxoM+1P1OJSlYDAWlq2yr7K60=;
        b=F/BpODcdn0KO9cEmUc+2PQAGBwP3EUhzdYVpKpyp/oHohpfHCCSiPPwjgdSoGetrM5
         DvYTLy+CQwX2ls0kPLlmggLrSeaGjsj4WdwaUknmE/PSQw7+MuwXst4QfKrK6MhwI4Hl
         3YSqBT2re3ghIU+xfE3lVUzFRUZHc+CxG/exqmDfnm75KIBhnC4y4QQPoTENbGtjqlb2
         +atOkx36/QXATSwgb5YgH3ISO34oRY8Wt2JfUyLhUETIrLVTwkckj5UMoJRLL0sZEKjJ
         /L2GlgsNrsZD7AexKOKAVsZhl33aJo+YY+KYTIhWqcqn/qBgG4pAjZEbvRILgi9pkucx
         Q3vQ==
X-Gm-Message-State: AC+VfDz2xEQrnToTGQiZBoX9WiQ1FuVfKBfwvzCQwgwWTd7XxigM9CnH
        RsEZ5VcIymUguTi92wHsGitWiA==
X-Google-Smtp-Source: ACHHUZ59P+bp6ED2Kszxshh260ommkRHiT69oe2FwrGdYZ+HqLlDxWIw/Bu83kjelaVfV2l9S1LXqA==
X-Received: by 2002:a19:f816:0:b0:4f3:a49b:121f with SMTP id a22-20020a19f816000000b004f3a49b121fmr4684707lff.40.1684835430874;
        Tue, 23 May 2023 02:50:30 -0700 (PDT)
Received: from [10.8.0.3] (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id v30-20020a056512049e00b004f37aac79f4sm1291968lfq.185.2023.05.23.02.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 02:50:30 -0700 (PDT)
Subject: Re: [PATCH 00/12] can: kvaser_pciefd: Fixes and improvments
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>
References: <20230523094354.83792-1-extja@kvaser.com>
From:   Jimmy Assarsson <extja@kvaser.com>
Message-ID: <5b10f6cd-c96c-3198-3df4-557e5e91b2e7@kvaser.com>
Date:   Tue, 23 May 2023 11:50:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20230523094354.83792-1-extja@kvaser.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2023-05-23 11:43, Jimmy Assarsson wrote:
> This patch series contains various non critical fixes and improvements for
> the kvaser_pciefd driver.

I messed up and sent both patch series at the same time:
[PATCH 00/12] can: kvaser_pciefd: Fixes and improvments
[PATCH 0/3] can: kvaser_pciefd: Add support for new Kvaser PCI Express devices

Let me know if I should resend them again in separate mails.

/jimmy
