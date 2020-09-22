Return-Path: <SRS0=rcP+=C7=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64A7C4741F
	for <linux-can@archiver.kernel.org>; Tue, 22 Sep 2020 14:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA2002396D
	for <linux-can@archiver.kernel.org>; Tue, 22 Sep 2020 14:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgIVOog (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 22 Sep 2020 10:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgIVOog (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Sep 2020 10:44:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5887FC061755
        for <linux-can@vger.kernel.org>; Tue, 22 Sep 2020 07:44:36 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kKjX0-0001FU-FX; Tue, 22 Sep 2020 16:44:34 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, michael@walle.cc, qiangqing.zhang@nxp.com,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 03/20] can: flexcan: more register names
Date:   Tue, 22 Sep 2020 16:44:12 +0200
Message-Id: <20200922144429.2613631-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922144429.2613631-1-mkl@pengutronix.de>
References: <20200922144429.2613631-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch adds some new register names and tries to ensure with a
static_assert that the documented offset is correct.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 43fa38033383..c24d7b63e1b9 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -205,7 +205,7 @@ struct flexcan_regs {
 	u32 mcr;		/* 0x00 */
 	u32 ctrl;		/* 0x04 */
 	u32 timer;		/* 0x08 */
-	u32 _reserved1;		/* 0x0c */
+	u32 tcr;		/* 0x0c */
 	u32 rxgmask;		/* 0x10 */
 	u32 rx14mask;		/* 0x14 */
 	u32 rx15mask;		/* 0x18 */
@@ -225,7 +225,11 @@ struct flexcan_regs {
 	u32 crcr;		/* 0x44 */
 	u32 rxfgmask;		/* 0x48 */
 	u32 rxfir;		/* 0x4c */
-	u32 _reserved3[12];	/* 0x50 */
+	u32 cbt;		/* 0x50 */
+	u32 _reserved2;		/* 0x54 */
+	u32 dbg1;		/* 0x58 */
+	u32 dbg2;		/* 0x5c */
+	u32 _reserved3[8];	/* 0x60 */
 	u8 mb[2][512];		/* 0x80 */
 	/* FIFO-mode:
 	 *			MB
@@ -250,8 +254,14 @@ struct flexcan_regs {
 	u32 rerrdr;		/* 0xaf4 */
 	u32 rerrsynr;		/* 0xaf8 */
 	u32 errsr;		/* 0xafc */
+	u32 _reserved7[64];	/* 0xb00 */
+	u32 fdctrl;		/* 0xc00 */
+	u32 fdcbt;		/* 0xc04 */
+	u32 fdcrc;		/* 0xc08 */
 };
 
+static_assert(sizeof(struct flexcan_regs) == 0x4 + 0xc08);
+
 struct flexcan_devtype_data {
 	u32 quirks;		/* quirks needed for different IP cores */
 };
-- 
2.28.0

