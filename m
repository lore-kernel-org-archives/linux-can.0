Return-Path: <SRS0=Fclt=EJ=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A04C2D0A3
	for <linux-can@archiver.kernel.org>; Tue,  3 Nov 2020 22:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B5BA20665
	for <linux-can@archiver.kernel.org>; Tue,  3 Nov 2020 22:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbgKCWHW (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 3 Nov 2020 17:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731306AbgKCWGw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 3 Nov 2020 17:06:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDB5C061A04
        for <linux-can@vger.kernel.org>; Tue,  3 Nov 2020 14:06:52 -0800 (PST)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ka4Rz-0006Ui-5l; Tue, 03 Nov 2020 23:06:47 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de,
        Zhang Changzhong <zhangchangzhong@huawei.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net 16/27] can: ti_hecc: ti_hecc_probe(): add missed clk_disable_unprepare() in error path
Date:   Tue,  3 Nov 2020 23:06:25 +0100
Message-Id: <20201103220636.972106-17-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103220636.972106-1-mkl@pengutronix.de>
References: <20201103220636.972106-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Zhang Changzhong <zhangchangzhong@huawei.com>

The driver forgets to call clk_disable_unprepare() in error path after
a success calling for clk_prepare_enable().

Fix it by adding a clk_disable_unprepare() in error path.

Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
Link: https://lore.kernel.org/r/1594973079-27743-1-git-send-email-zhangchangzhong@huawei.com
Fixes: befa60113ce7 ("can: ti_hecc: add missing prepare and unprepare of the clock")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/ti_hecc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index 1d63006c97bc..9913f5458279 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -933,7 +933,7 @@ static int ti_hecc_probe(struct platform_device *pdev)
 	err = clk_prepare_enable(priv->clk);
 	if (err) {
 		dev_err(&pdev->dev, "clk_prepare_enable() failed\n");
-		goto probe_exit_clk;
+		goto probe_exit_release_clk;
 	}
 
 	priv->offload.mailbox_read = ti_hecc_mailbox_read;
@@ -942,7 +942,7 @@ static int ti_hecc_probe(struct platform_device *pdev)
 	err = can_rx_offload_add_timestamp(ndev, &priv->offload);
 	if (err) {
 		dev_err(&pdev->dev, "can_rx_offload_add_timestamp() failed\n");
-		goto probe_exit_clk;
+		goto probe_exit_disable_clk;
 	}
 
 	err = register_candev(ndev);
@@ -960,7 +960,9 @@ static int ti_hecc_probe(struct platform_device *pdev)
 
 probe_exit_offload:
 	can_rx_offload_del(&priv->offload);
-probe_exit_clk:
+probe_exit_disable_clk:
+	clk_disable_unprepare(priv->clk);
+probe_exit_release_clk:
 	clk_put(priv->clk);
 probe_exit_candev:
 	free_candev(ndev);
-- 
2.28.0

