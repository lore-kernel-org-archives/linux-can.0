Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6F6C48BE8
	for <linux-can@archiver.kernel.org>; Wed, 16 Jun 2021 23:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D28B613D0
	for <linux-can@archiver.kernel.org>; Wed, 16 Jun 2021 23:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbhFPXUA (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 16 Jun 2021 19:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbhFPXT4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Jun 2021 19:19:56 -0400
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B40DC06175F;
        Wed, 16 Jun 2021 16:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1623885468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rEvCmMNpxeYO45M5lh0EKK3/k+qeySJGXHyN0xv7Mj8=;
        b=bn53FvOpbplok0/cU0AiSfIwIjmAU81Vt0lMX8gL0chsCOjcwp25qBEdvpSVbYTBTFnoJ3
        Df1cvP78tEvuXiPTq/kxSDfIjKzwhB3cyDzi1LgnR1+HQ9Y0I6KPFOomw6meDDKPFKcDtO
        tT+T2Gffd1reOIC884UqwbZBA4v1jYY=
Received: from dfj.1.1.1.1 (host-87-8-57-171.retail.telecomitalia.it [87.8.57.171])
        by ziongate (OpenSMTPD) with ESMTPSA id d3e9026d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Jun 2021 23:17:48 +0000 (UTC)
From:   Angelo Dureghello <angelo@kernel-space.org>
To:     gerg@linux-m68k.org, wg@grandegger.com, mkl@pengutronix.de
Cc:     geert@linux-m68k.org, linux-m68k@vger.kernel.org,
        linux-can@vger.kernel.org, qiangqing.zhang@nxp.com,
        Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH v2 4/5] can: flexcan: enable Kconfig for ColdFire
Date:   Thu, 17 Jun 2021 01:16:51 +0200
Message-Id: <20210616231652.738027-4-angelo@kernel-space.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210616231652.738027-1-angelo@kernel-space.org>
References: <20210616231652.738027-1-angelo@kernel-space.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Enable flexcan KConfig for ColdFire m5441x cpu's.

Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
---
 drivers/net/can/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index e355d3974977..7a1be9dad52d 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -97,7 +97,7 @@ config CAN_AT91
 
 config CAN_FLEXCAN
 	tristate "Support for Freescale FLEXCAN based chips"
-	depends on OF && HAS_IOMEM
+	depends on (OF || M5441x) && HAS_IOMEM
 	help
 	  Say Y here if you want to support for Freescale FlexCAN.
 
-- 
2.31.1

