Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF334C433FE
	for <linux-can@archiver.kernel.org>; Sat, 12 Dec 2020 17:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C04DB2226A
	for <linux-can@archiver.kernel.org>; Sat, 12 Dec 2020 17:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439620AbgLLR4x (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Sat, 12 Dec 2020 12:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgLLR4Y (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 12 Dec 2020 12:56:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417A5C06179C
        for <linux-can@vger.kernel.org>; Sat, 12 Dec 2020 09:55:29 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ko979-0000zO-Pw
        for linux-can@vger.kernel.org; Sat, 12 Dec 2020 18:55:27 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id B05115ABDD0
        for <linux-can@vger.kernel.org>; Sat, 12 Dec 2020 17:55:22 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 4BFE25ABDAB;
        Sat, 12 Dec 2020 17:55:20 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id dcaf8c59;
        Sat, 12 Dec 2020 17:55:19 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Sriram Dash <sriram.dash@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 4/7] can: m_can: m_can_config_endisable(): mark as static
Date:   Sat, 12 Dec 2020 18:55:15 +0100
Message-Id: <20201212175518.139651-5-mkl@pengutronix.de>
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

The function m_can_config_endisable() is not used outside of the m_can driver,
so mark it as static.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 2 +-
 drivers/net/can/m_can/m_can.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index fb408ca85188..b1ed925ead63 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -368,7 +368,7 @@ static inline bool m_can_tx_fifo_full(struct m_can_classdev *cdev)
 	return !!(m_can_read(cdev, M_CAN_TXFQS) & TXFQS_TFQF);
 }
 
-void m_can_config_endisable(struct m_can_classdev *cdev, bool enable)
+static void m_can_config_endisable(struct m_can_classdev *cdev, bool enable)
 {
 	u32 cccr = m_can_read(cdev, M_CAN_CCCR);
 	u32 timeout = 10;
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index f8a692596e59..3994e20249f8 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -103,7 +103,6 @@ int m_can_class_register(struct m_can_classdev *cdev);
 void m_can_class_unregister(struct m_can_classdev *cdev);
 int m_can_class_get_clocks(struct m_can_classdev *cdev);
 void m_can_init_ram(struct m_can_classdev *priv);
-void m_can_config_endisable(struct m_can_classdev *priv, bool enable);
 
 int m_can_class_suspend(struct device *dev);
 int m_can_class_resume(struct device *dev);
-- 
2.29.2


