From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH RESEND v3] can: flexcan: fix resume function
Date: Mon,  5 Sep 2016 19:15:16 -0300
Message-ID: <1473113716-2834-1-git-send-email-festevam@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33530 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753358AbcIEWPh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 5 Sep 2016 18:15:37 -0400
Received: by mail-qk0-f193.google.com with SMTP id n66so13300634qkf.0
        for <linux-can@vger.kernel.org>; Mon, 05 Sep 2016 15:15:37 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: wg@grandegger.com, linux-can@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>

From: Fabio Estevam <fabio.estevam@nxp.com>

On a imx6ul-pico board the following error is seen during system suspend:
    
dpm_run_callback(): platform_pm_resume+0x0/0x54 returns -110     
PM: Device 2090000.flexcan failed to resume: error -110          

The reason for this suspend error is because when the CAN interface is not
active the clocks are disabled and then flexcan_chip_enable() will
always fail due to a timeout error.

In order to fix this issue, only call flexcan_chip_enable/disable()
when the CAN interface is active.

Based on a patch from Dong Aisheng in the NXP kernel.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v2:
- Move flexcan_chip_disable() to be called as the first function in
flexcan_suspen() to keep the original order.
Changes since v1:
- Change Subject: 'resume' instead of 'suspend'

 drivers/net/can/flexcan.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 41c0fc9..16f7cad 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1268,11 +1268,10 @@ static int __maybe_unused flexcan_suspend(struct device *device)
 	struct flexcan_priv *priv = netdev_priv(dev);
 	int err;
 
-	err = flexcan_chip_disable(priv);
-	if (err)
-		return err;
-
 	if (netif_running(dev)) {
+		err = flexcan_chip_disable(priv);
+		if (err)
+			return err;
 		netif_stop_queue(dev);
 		netif_device_detach(dev);
 	}
@@ -1285,13 +1284,17 @@ static int __maybe_unused flexcan_resume(struct device *device)
 {
 	struct net_device *dev = dev_get_drvdata(device);
 	struct flexcan_priv *priv = netdev_priv(dev);
+	int err;
 
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 	if (netif_running(dev)) {
 		netif_device_attach(dev);
 		netif_start_queue(dev);
+		err = flexcan_chip_enable(priv);
+		if (err)
+			return err;
 	}
-	return flexcan_chip_enable(priv);
+	return 0;
 }
 
 static SIMPLE_DEV_PM_OPS(flexcan_pm_ops, flexcan_suspend, flexcan_resume);
-- 
1.9.1

