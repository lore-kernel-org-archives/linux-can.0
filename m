Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4CAC433FE
	for <linux-can@archiver.kernel.org>; Sat, 12 Dec 2020 17:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0C7322262
	for <linux-can@archiver.kernel.org>; Sat, 12 Dec 2020 17:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439611AbgLLR4Z (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Sat, 12 Dec 2020 12:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436745AbgLLR4H (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 12 Dec 2020 12:56:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA78C0613D6
        for <linux-can@vger.kernel.org>; Sat, 12 Dec 2020 09:55:27 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ko977-0000xN-Ua
        for linux-can@vger.kernel.org; Sat, 12 Dec 2020 18:55:25 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 054425ABDC5
        for <linux-can@vger.kernel.org>; Sat, 12 Dec 2020 17:55:21 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 0BEDA5ABDA8;
        Sat, 12 Dec 2020 17:55:20 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f6177bcb;
        Sat, 12 Dec 2020 17:55:19 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Sriram Dash <sriram.dash@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 1/7] can: m_can: update link to M_CAN user manual
Date:   Sat, 12 Dec 2020 18:55:12 +0100
Message-Id: <20201212175518.139651-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201212175518.139651-1-mkl@pengutronix.de>
References: <20201212175518.139651-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Old versions of the user manual are regularly depublished, so change link to
point to the product page instead. This will be hopefully more stable.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 06c136961c7c..8873f6f6f6da 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -5,8 +5,7 @@
 // Copyright (C) 2018-19 Texas Instruments Incorporated - http://www.ti.com/
 
 /* Bosch M_CAN user manual can be obtained from:
- * http://www.bosch-semiconductors.de/media/pdf_1/ipmodules_1/m_can/
- * mcan_users_manual_v302.pdf
+ * https://www.bosch-semiconductors.com/ip-modules/can-ip-modules/m-can/
  */
 
 #include <linux/interrupt.h>

base-commit: 46d5e62dd3c34770f3bfd0642daa9a7772a00362
-- 
2.29.2


