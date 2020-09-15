Return-Path: <SRS0=ffhE=CY=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96551C43461
	for <linux-can@archiver.kernel.org>; Tue, 15 Sep 2020 22:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FD5C206BE
	for <linux-can@archiver.kernel.org>; Tue, 15 Sep 2020 22:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgIOWgG (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 15 Sep 2020 18:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbgIOWfz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Sep 2020 18:35:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7449AC0611BD
        for <linux-can@vger.kernel.org>; Tue, 15 Sep 2020 15:35:42 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kIJY4-0002Tb-E4; Wed, 16 Sep 2020 00:35:40 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Zhang Changzhong <zhangchangzhong@huawei.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 31/37] can: mscan: simplify clock enable/disable
Date:   Wed, 16 Sep 2020 00:35:21 +0200
Message-Id: <20200915223527.1417033-32-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915223527.1417033-1-mkl@pengutronix.de>
References: <20200915223527.1417033-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Zhang Changzhong <zhangchangzhong@huawei.com>

All the NULL checks are pointless, clk_*() routines already deal with
NULL just fine.

Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
Link: https://lore.kernel.org/r/1594972875-27631-1-git-send-email-zhangchangzhong@huawei.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/mscan/mscan.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
index 0b3532dd50e2..640ba1b356ec 100644
--- a/drivers/net/can/mscan/mscan.c
+++ b/drivers/net/can/mscan/mscan.c
@@ -541,16 +541,12 @@ static int mscan_open(struct net_device *dev)
 	struct mscan_priv *priv = netdev_priv(dev);
 	struct mscan_regs __iomem *regs = priv->reg_base;
 
-	if (priv->clk_ipg) {
-		ret = clk_prepare_enable(priv->clk_ipg);
-		if (ret)
-			goto exit_retcode;
-	}
-	if (priv->clk_can) {
-		ret = clk_prepare_enable(priv->clk_can);
-		if (ret)
-			goto exit_dis_ipg_clock;
-	}
+	ret = clk_prepare_enable(priv->clk_ipg);
+	if (ret)
+		goto exit_retcode;
+	ret = clk_prepare_enable(priv->clk_can);
+	if (ret)
+		goto exit_dis_ipg_clock;
 
 	/* common open */
 	ret = open_candev(dev);
@@ -584,11 +580,9 @@ static int mscan_open(struct net_device *dev)
 	napi_disable(&priv->napi);
 	close_candev(dev);
 exit_dis_can_clock:
-	if (priv->clk_can)
-		clk_disable_unprepare(priv->clk_can);
+	clk_disable_unprepare(priv->clk_can);
 exit_dis_ipg_clock:
-	if (priv->clk_ipg)
-		clk_disable_unprepare(priv->clk_ipg);
+	clk_disable_unprepare(priv->clk_ipg);
 exit_retcode:
 	return ret;
 }
@@ -607,10 +601,8 @@ static int mscan_close(struct net_device *dev)
 	close_candev(dev);
 	free_irq(dev->irq, dev);
 
-	if (priv->clk_can)
-		clk_disable_unprepare(priv->clk_can);
-	if (priv->clk_ipg)
-		clk_disable_unprepare(priv->clk_ipg);
+	clk_disable_unprepare(priv->clk_can);
+	clk_disable_unprepare(priv->clk_ipg);
 
 	return 0;
 }
-- 
2.28.0

