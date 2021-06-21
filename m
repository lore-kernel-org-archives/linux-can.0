Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B87C49EA4
	for <linux-can@archiver.kernel.org>; Mon, 21 Jun 2021 18:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 745D56128A
	for <linux-can@archiver.kernel.org>; Mon, 21 Jun 2021 18:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhFUStf (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 21 Jun 2021 14:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbhFUStf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Jun 2021 14:49:35 -0400
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CCAC061574;
        Mon, 21 Jun 2021 11:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1624301238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KjxUvbur7NrecK7zvDkm9Pv+lRN8fBcNopWY+ZatqeM=;
        b=KMMtBGoerguhBco50bT4YcADKHbUb2aurd/E9UgpYr+KKPOiFOUyi31VO4rX5gaiLIX9ML
        TPDUA86YW1CHghz0A5JzaV8g0M+BJOuqG62fdUSc01/1M7W0qh2m8wYtjTXo1q2uV/dQJ4
        X7myHwGOzgNDQaa/9oY5zv5DvE2Wjrw=
Received: from dfj.bfc.timesys.com (host-87-8-57-171.retail.telecomitalia.it [87.8.57.171])
        by ziongate (OpenSMTPD) with ESMTPSA id 4344951e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 21 Jun 2021 18:47:18 +0000 (UTC)
From:   Angelo Dureghello <angelo@kernel-space.org>
To:     gerg@linux-m68k.org, wg@grandegger.com, mkl@pengutronix.de
Cc:     geert@linux-m68k.org, linux-m68k@vger.kernel.org,
        linux-can@vger.kernel.org, qiangqing.zhang@nxp.com,
        Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH v3 2/5] m68k: stmark2: update board setup
Date:   Mon, 21 Jun 2021 20:46:12 +0200
Message-Id: <20210621184615.3345846-2-angelo@kernel-space.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210621184615.3345846-1-angelo@kernel-space.org>
References: <20210621184615.3345846-1-angelo@kernel-space.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add configuration for flexcan pads.

Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
---
Changes for v2:
none
Changes for v3:
none
---
 arch/m68k/coldfire/stmark2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/coldfire/stmark2.c b/arch/m68k/coldfire/stmark2.c
index 8b5af9c83244..036a6ae5f599 100644
--- a/arch/m68k/coldfire/stmark2.c
+++ b/arch/m68k/coldfire/stmark2.c
@@ -111,7 +111,9 @@ static int __init init_stmark2(void)
 	__raw_writeb(0x00, MCFGPIO_PAR_BE);
 	__raw_writeb(0x00, MCFGPIO_PAR_FBCTL);
 	__raw_writeb(0x00, MCFGPIO_PAR_CS);
-	__raw_writeb(0x00, MCFGPIO_PAR_CANI2C);
+
+	/* CAN pads */
+	__raw_writeb(0x50, MCFGPIO_PAR_CANI2C);
 
 	platform_add_devices(stmark2_devices, ARRAY_SIZE(stmark2_devices));
 
@@ -121,4 +123,4 @@ static int __init init_stmark2(void)
 	return 0;
 }
 
-late_initcall(init_stmark2);
+device_initcall(init_stmark2);
-- 
2.31.1

