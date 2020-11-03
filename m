Return-Path: <SRS0=Fclt=EJ=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1678BC4742C
	for <linux-can@archiver.kernel.org>; Tue,  3 Nov 2020 22:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6BD820665
	for <linux-can@archiver.kernel.org>; Tue,  3 Nov 2020 22:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbgKCWHE (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 3 Nov 2020 17:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731532AbgKCWG7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 3 Nov 2020 17:06:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D176DC061A4B
        for <linux-can@vger.kernel.org>; Tue,  3 Nov 2020 14:06:58 -0800 (PST)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ka4S5-0006Ui-9n; Tue, 03 Nov 2020 23:06:53 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Joakim Zhang <qiangqing.zhang@nxp.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net 27/27] can: flexcan: flexcan_remove(): disable wakeup completely
Date:   Tue,  3 Nov 2020 23:06:36 +0100
Message-Id: <20201103220636.972106-28-mkl@pengutronix.de>
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

From: Joakim Zhang <qiangqing.zhang@nxp.com>

With below sequence, we can see wakeup default is enabled after re-load module,
if it was enabled before, so we need disable wakeup in flexcan_remove().

| # cat /sys/bus/platform/drivers/flexcan/5a8e0000.can/power/wakeup
| disabled
| # echo enabled > /sys/bus/platform/drivers/flexcan/5a8e0000.can/power/wakeup
| # cat /sys/bus/platform/drivers/flexcan/5a8e0000.can/power/wakeup
| enabled
| # rmmod flexcan
| # modprobe flexcan
| # cat /sys/bus/platform/drivers/flexcan/5a8e0000.can/power/wakeup
| enabled

Fixes: de3578c198c6 ("can: flexcan: add self wakeup support")
Fixes: 915f9666421c ("can: flexcan: add support for DT property 'wakeup-source'")
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Link: https://lore.kernel.org/r/20201020184527.8190-1-qiangqing.zhang@nxp.com
[mkl: streamlined commit message]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 06f94b6f0ebe..881799bd9c5e 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -2062,6 +2062,8 @@ static int flexcan_remove(struct platform_device *pdev)
 {
 	struct net_device *dev = platform_get_drvdata(pdev);
 
+	device_set_wakeup_enable(&pdev->dev, false);
+	device_set_wakeup_capable(&pdev->dev, false);
 	unregister_flexcandev(dev);
 	pm_runtime_disable(&pdev->dev);
 	free_candev(dev);
-- 
2.28.0

