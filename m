From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH] can: xilinx: Fix suspend/resume crash due to wrong reference
Date: Thu, 15 Oct 2015 23:13:07 +0530
Message-ID: <1444930987-5838-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bl2on0058.outbound.protection.outlook.com ([65.55.169.58]:12509
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751730AbbJOR7O (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 15 Oct 2015 13:59:14 -0400
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
	by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
	(envelope-from <shubhrajyoti.datta@xilinx.com>)
	id 1ZmmYg-0003vP-QG
	for linux-can@vger.kernel.org; Thu, 15 Oct 2015 10:43:18 -0700
Received: from [127.0.0.1] (helo=localhost)
	by xsj-pvapsmtp01 with smtp (Exim 4.63)
	(envelope-from <shubhrajyoti.datta@xilinx.com>)
	id 1ZmmYg-0004Ea-Lr
	for linux-can@vger.kernel.org; Thu, 15 Oct 2015 10:43:18 -0700
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Shubhrajyoti Datta <shubhraj@xilinx.com>

Fix a crash due to wrong dereferencing.
Also in the suspend path we were accessing registers without
enabling clocks. Fix it by enabling the clocks.

In the resume disable of the clocks were missing fix the same.

Signed-off-by: Shubhrajyoti Datta <shubhraj@xilinx.com>
---
 drivers/net/can/xilinx_can.c |   28 ++++++++++++++++++++--------
 1 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 0a62c2a..01d272f 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -967,20 +967,31 @@ static const struct net_device_ops xcan_netdev_ops = {
  */
 static int __maybe_unused xcan_suspend(struct device *dev)
 {
-	struct platform_device *pdev = dev_get_drvdata(dev);
-	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct net_device *ndev = dev_get_drvdata(dev);
 	struct xcan_priv *priv = netdev_priv(ndev);
+	int ret;
 
 	if (netif_running(ndev)) {
 		netif_stop_queue(ndev);
 		netif_device_detach(ndev);
 	}
+	ret = clk_prepare_enable(priv->bus_clk);
+	if (ret) {
+		dev_err(dev, "Cannot enable clock.\n");
+		return ret;
+	}
+	ret = clk_prepare_enable(priv->can_clk);
+	if (ret) {
+		dev_err(dev, "Cannot enable clock.\n");
+		clk_disable_unprepare(priv->bus_clk);
+		return ret;
+	}
 
 	priv->write_reg(priv, XCAN_MSR_OFFSET, XCAN_MSR_SLEEP_MASK);
 	priv->can.state = CAN_STATE_SLEEPING;
 
-	clk_disable(priv->bus_clk);
-	clk_disable(priv->can_clk);
+	clk_disable_unprepare(priv->bus_clk);
+	clk_disable_unprepare(priv->can_clk);
 
 	return 0;
 }
@@ -994,17 +1005,16 @@ static int __maybe_unused xcan_suspend(struct device *dev)
  */
 static int __maybe_unused xcan_resume(struct device *dev)
 {
-	struct platform_device *pdev = dev_get_drvdata(dev);
-	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct net_device *ndev = dev_get_drvdata(dev);
 	struct xcan_priv *priv = netdev_priv(ndev);
 	int ret;
 
-	ret = clk_enable(priv->bus_clk);
+	ret = clk_prepare_enable(priv->bus_clk);
 	if (ret) {
 		dev_err(dev, "Cannot enable clock.\n");
 		return ret;
 	}
-	ret = clk_enable(priv->can_clk);
+	ret = clk_prepare_enable(priv->can_clk);
 	if (ret) {
 		dev_err(dev, "Cannot enable clock.\n");
 		clk_disable_unprepare(priv->bus_clk);
@@ -1020,6 +1030,8 @@ static int __maybe_unused xcan_resume(struct device *dev)
 		netif_start_queue(ndev);
 	}
 
+	clk_disable_unprepare(priv->bus_clk);
+	clk_disable_unprepare(priv->can_clk);
 	return 0;
 }
 
-- 
1.7.1

