Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812ACC433EF
	for <linux-can@archiver.kernel.org>; Fri,  8 Jul 2022 18:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239689AbiGHSri (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 8 Jul 2022 14:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239690AbiGHSrh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Jul 2022 14:47:37 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AB082391
        for <linux-can@vger.kernel.org>; Fri,  8 Jul 2022 11:47:36 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id q7so4560004lji.12
        for <linux-can@vger.kernel.org>; Fri, 08 Jul 2022 11:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NCdrXXw4OIFVN2T2yq7UtG+zJ8BpWvZk3Tva/wkAXMM=;
        b=YMY8aTdqUvKlx3QklbPKjwZVX6KV2JtgbQNUrDPo24uULNySBuir11UmqhiRi/3s9j
         fTObmmsQK6Es5kgJff/QFpo6cp+Ax3SBKoESZU5MhDqwSinkOOwEwE+d5II6UCHyUUGs
         48vjqWI4z9BhzBwuJXPXi53qCvcQ1p9pYcdT/R2nSlnYYtSSXHJUoSPu+7SFLsVVwqjo
         uzhxLH/O1pbL1rVBfC6S/r+1VKI21KqqkT1jYRW2nv9VpgPdWChtaVht9Md+Z+qhOWRL
         pD015lheW6DG9YftbeJj2zP0lWa49XVI1SrWz+46eGcZzoiQtUIxlIIyaSEHd59Djyv/
         avgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NCdrXXw4OIFVN2T2yq7UtG+zJ8BpWvZk3Tva/wkAXMM=;
        b=7xJSSvsj7pdzTGcybuoPdiW0h1XxDWsa1uC4jbWJyVJZbylfmoBT1oaOWNDDIaV1Uj
         ylVYIEa94aWlToRlC6T6EDHe3CXXJh+w8skjJRv3Tbt98ZbtmmFPDWdGFgyoCo74Vtfk
         yIjqn6Fb8KkLT+wXA0Or3jEQD2gSu9o34RAInOJqIo0UAqh79+wuto5p32k4aNNU8Q09
         0TOxPPueDWj0UGjjEimcP2uK3S1nUWedIZ5uI6qxEfkQ9wES7cKYhmco+omBP4zWZCsH
         2FDeMxdNSckfGeY4sXfV6WSbc+Zg9Hlr4SDDetLlvp9U5tE+gECErwAxj05eDVTjSdOY
         LTRQ==
X-Gm-Message-State: AJIora/DyL0gNO/kzhnvgYLv5fGC7zivXeZ1i8NF7dx5+CyWiCBFtdG4
        08H1cy3QvVPWL3VEiDNvqCPF+A==
X-Google-Smtp-Source: AGRyM1vhXZyujhmCvs/N6J6rfSz+8v8GdUoN4IWZR9VpJlSg1vPh+1rLn4hjTJLG7zw9LX/PvoyQCA==
X-Received: by 2002:a2e:7c1a:0:b0:25b:bd36:2e32 with SMTP id x26-20020a2e7c1a000000b0025bbd362e32mr2641594ljc.12.1657306054790;
        Fri, 08 Jul 2022 11:47:34 -0700 (PDT)
Received: from freke.kvaser.se (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id o18-20020ac24bd2000000b004811dae391fsm6084500lfq.48.2022.07.08.11.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 11:47:34 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     stable@vger.kernel.org, linux-can@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 4.19 0/3] can: kvaser_usb: CAN clock frequency regression
Date:   Fri,  8 Jul 2022 20:47:23 +0200
Message-Id: <20220708184726.280961-1-extja@kvaser.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Backport of upstream patch series [1].

When fixing the CAN clock frequency,
fb12797ab1fe ("can: kvaser_usb: get CAN clock frequency from device"),
I introduced a regression.

For Leaf devices based on M32C, the firmware expects bittiming parameters
calculated for 16MHz clock. Regardless of the actual clock frequency.

This regression affects M32C based Leaf devices with non-16MHz clock.

Also correct the bittiming constants in kvaser_usb_leaf.c, where the
limits are different depending on which firmware/device being used.

[1]
https://lore.kernel.org/linux-can/20220603083820.800246-1-extja@kvaser.com/

Jimmy Assarsson (3):
  can: kvaser_usb: replace run-time checks with struct
    kvaser_usb_driver_info
  can: kvaser_usb: kvaser_usb_leaf: fix CAN clock frequency regression
  can: kvaser_usb: kvaser_usb_leaf: fix bittiming limits

 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  25 +-
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 255 ++++++++++--------
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c |   4 +-
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 119 ++++----
 4 files changed, 226 insertions(+), 177 deletions(-)

-- 
2.36.1

