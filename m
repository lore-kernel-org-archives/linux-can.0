Return-Path: <linux-can-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B407AEB64DD
	for <linux-can@archiver.kernel.org>; Thu, 29 Jun 2023 19:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbjF2TG4 (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 29 Jun 2023 15:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbjF2TFk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 29 Jun 2023 15:05:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5B644AE;
        Thu, 29 Jun 2023 12:02:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A6F46160B;
        Thu, 29 Jun 2023 19:02:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69872C433C9;
        Thu, 29 Jun 2023 19:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688065341;
        bh=lUWaVxP15HP+vlQfvQOWXvQCRcQtq2JiU6ju/1xpPYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lvCna0kdGpA6a8y1NtQLhJgt4ew1ZT7Y4qG9LBruOZrEQOzmKs+FDsZMEdR+Tal0S
         7ZxkX0qk7ltYHEB/kL3wRtOLhvkhBSiHTfG7a6fVLlkQKQyRl3WWY8FtdI7zTPtvCx
         M9o7Ur3snucr6fciotlJkiFT0zqC4oEjgsdOZifMLcg/tEnsSCRhHVTAWFd5ck77Qg
         xeAIJ+uwHbfOzh3052io7bTypOpvQJ6bLezkMKMRMWxWImi7bEoFCPLaBRjsKL1gSw
         3dz655oQb07nvEhvc6fvUXcmQzd2B+7RJi369lLw+ivewQqOi3ht59aUM1A43heNy0
         qkAzFLYwD3kWQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heiko Schocher <hs@denx.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>, wg@grandegger.com,
        linux-can@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 3/5] can: sja1000: fix size of OCR_MODE_MASK define
Date:   Thu, 29 Jun 2023 15:02:17 -0400
Message-Id: <20230629190219.908379-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629190219.908379-1-sashal@kernel.org>
References: <20230629190219.908379-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.287
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Heiko Schocher <hs@denx.de>

[ Upstream commit 26e8f6a75248247982458e8237b98c9fb2ffcf9d ]

bitfield mode in ocr register has only 2 bits not 3, so correct
the OCR_MODE_MASK define.

Signed-off-by: Heiko Schocher <hs@denx.de>
Link: https://lore.kernel.org/all/20221123071636.2407823-1-hs@denx.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/can/platform/sja1000.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/can/platform/sja1000.h b/include/linux/can/platform/sja1000.h
index 5755ae5a47122..6a869682c1207 100644
--- a/include/linux/can/platform/sja1000.h
+++ b/include/linux/can/platform/sja1000.h
@@ -14,7 +14,7 @@
 #define OCR_MODE_TEST     0x01
 #define OCR_MODE_NORMAL   0x02
 #define OCR_MODE_CLOCK    0x03
-#define OCR_MODE_MASK     0x07
+#define OCR_MODE_MASK     0x03
 #define OCR_TX0_INVERT    0x04
 #define OCR_TX0_PULLDOWN  0x08
 #define OCR_TX0_PULLUP    0x10
-- 
2.39.2

