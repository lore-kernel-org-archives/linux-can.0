Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0237C63697
	for <linux-can@archiver.kernel.org>; Sun, 15 Nov 2020 16:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8484620719
	for <linux-can@archiver.kernel.org>; Sun, 15 Nov 2020 16:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgylcF5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgKOQbO (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Sun, 15 Nov 2020 11:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgKOQbL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 15 Nov 2020 11:31:11 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2933DC0613D1
        for <linux-can@vger.kernel.org>; Sun, 15 Nov 2020 08:31:10 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id i17so15882743ljd.3
        for <linux-can@vger.kernel.org>; Sun, 15 Nov 2020 08:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gSxpHxUYMsKvi2BXGiPuImfZDhALPYbaTFURWGkTG/Q=;
        b=YgylcF5BJu/9V4qhCwxtwRGK4jd40AWGxnzUZjjMNDzO/4Ueon7TCAuYWD55TKyQEd
         RrFc6bUlxpjWcNPVb0NkB90R0BWSDn3gQlGDd2IMtpafhi/0HDOQy/WwJFtlXLjQTbBe
         sDt6cefhKaseHWeEsSUq4sDa34uXvDjGLD2+9yroDKl1c2/bDQTmySw2OUoaS9vCUiYk
         S5QPRs2kdwrk0S+kEKKansgWw+sjyBZGUWVhxoYmgDNn54QO+FRlN/WXuvqG3JacZ8fE
         483Y7AjO5un83ucZ3/dveoYgO9IIebkTSA3HZN8LiYspnQg/JyeMX8H/h7OeSSYgYTmj
         Bp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gSxpHxUYMsKvi2BXGiPuImfZDhALPYbaTFURWGkTG/Q=;
        b=QALZ/wjtaZwMgGtksvZZ4kym7+fU2N82XgKUE52kJ6DQvc1T/73cSYi2Iv2rva7KB4
         mhl/FjOzAlieFXO8+WkLcmAtV+zKavORrTCUnBnfB/X/NZ4Q6dShV+JryTUVnMx1Q59F
         GcRDiuxAcdtafZ0UtiS+CF4G7f5TC2pIjaSVD0TpRtloxbpeLNrngRFU71SKCFqaGrzG
         fogUUpKhXM8wPOJ59tuDlOYNvgbBLazVdfeAehZzZyTscLUte9QuMbmDW8+nO7pZ9b4G
         CzG5kbidmbL10Yj7kgezIZqM4VZ07egwFlaEpZrUzOLCKxIvIGvqzhDceMDCFQ0vUh6/
         uD4w==
X-Gm-Message-State: AOAM5333l5AYNV/JfvZZKghjCzVTIVKa/vbz4mKF3abDEKHJmaDXWp+h
        M7tXC7RAFRFgo38c4wS7/tWxFkd+vus=
X-Google-Smtp-Source: ABdhPJwFilI/UeMzsgiKxEyAyKv91/h24Q9TELpdkFsgIEblu+iVZvZHTX1dOxBJ4n9DfYQHpQuXeA==
X-Received: by 2002:a2e:8244:: with SMTP id j4mr5178257ljh.322.1605457868238;
        Sun, 15 Nov 2020 08:31:08 -0800 (PST)
Received: from jimmy-desk-arch.kvaser.se (h-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id b12sm2419462ljj.133.2020.11.15.08.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 08:31:07 -0800 (PST)
From:   Jimmy Assarsson <jimmyassarsson@gmail.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 1/6] can: kvaser_pciefd: Fix KCAN bittiming limits
Date:   Sun, 15 Nov 2020 17:30:22 +0100
Message-Id: <20201115163027.16851-1-jimmyassarsson@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Jimmy Assarsson <extja@kvaser.com>

Use correct bittiming limits for the KCAN CAN controller.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 6f766918211a..72acd1ba162d 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -287,12 +287,12 @@ struct kvaser_pciefd_tx_packet {
 static const struct can_bittiming_const kvaser_pciefd_bittiming_const = {
 	.name = KVASER_PCIEFD_DRV_NAME,
 	.tseg1_min = 1,
-	.tseg1_max = 255,
+	.tseg1_max = 512,
 	.tseg2_min = 1,
 	.tseg2_max = 32,
 	.sjw_max = 16,
 	.brp_min = 1,
-	.brp_max = 4096,
+	.brp_max = 8192,
 	.brp_inc = 1,
 };
 
-- 
2.29.2

