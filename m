Return-Path: <SRS0=yT01=D2=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599C1C43467
	for <linux-can@archiver.kernel.org>; Mon, 19 Oct 2020 15:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27D4721548
	for <linux-can@archiver.kernel.org>; Mon, 19 Oct 2020 15:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbgJSPmq (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 19 Oct 2020 11:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730377AbgJSPmp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Oct 2020 11:42:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D680C0613D8
        for <linux-can@vger.kernel.org>; Mon, 19 Oct 2020 08:42:45 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kUXJ4-0000nY-IL; Mon, 19 Oct 2020 17:42:42 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-rfc 12/12] can: m_can: Remove unused clock function from the framework
Date:   Mon, 19 Oct 2020 17:42:33 +0200
Message-Id: <20201019154233.1262589-13-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019154233.1262589-1-mkl@pengutronix.de>
References: <20201019154233.1262589-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Dan Murphy <dmurphy@ti.com>

Remove the unused clock function from the framework as the clock discovery,
initilaization and management are all within the registrars code.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
Link: http://lore.kernel.org/r/20200131183433.11041-4-dmurphy@ti.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 16 ----------------
 drivers/net/can/m_can/m_can.h |  3 ---
 2 files changed, 19 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 90ee636dd382..e1d8d1c8ab7d 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1747,22 +1747,6 @@ void m_can_init_ram(struct m_can_classdev *cdev)
 }
 EXPORT_SYMBOL_GPL(m_can_init_ram);
 
-int m_can_class_get_clocks(struct m_can_classdev *m_can_dev)
-{
-	int ret = 0;
-
-	m_can_dev->hclk = devm_clk_get(m_can_dev->dev, "hclk");
-	m_can_dev->cclk = devm_clk_get(m_can_dev->dev, "cclk");
-
-	if (IS_ERR(m_can_dev->cclk)) {
-		dev_err(m_can_dev->dev, "no clock found\n");
-		ret = -ENODEV;
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(m_can_class_get_clocks);
-
 struct m_can_classdev *m_can_class_allocate_dev(struct device *dev)
 {
 	struct m_can_classdev *class_dev = NULL;
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index b2699a7c9997..03e97872675d 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -74,8 +74,6 @@ struct m_can_classdev {
 	struct napi_struct napi;
 	struct net_device *net;
 	struct device *dev;
-	struct clk *hclk;
-	struct clk *cclk;
 
 	struct workqueue_struct *tx_wq;
 	struct work_struct tx_work;
@@ -102,7 +100,6 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev);
 void m_can_class_free_dev(struct net_device *net);
 int m_can_class_register(struct m_can_classdev *cdev);
 void m_can_class_unregister(struct m_can_classdev *cdev);
-int m_can_class_get_clocks(struct m_can_classdev *cdev);
 void m_can_init_ram(struct m_can_classdev *priv);
 void m_can_config_endisable(struct m_can_classdev *priv, bool enable);
 
-- 
2.28.0

