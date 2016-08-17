From: Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] can: flexcan: fix suspend function
Date: Wed, 17 Aug 2016 11:00:23 -0300
Message-ID: <1471442423-14539-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-by2nam01on0088.outbound.protection.outlook.com ([104.47.34.88]:36832
	"EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752296AbcHQQfz (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 17 Aug 2016 12:35:55 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: wg@grandegger.com, aisheng.dong@nxp.com, linux-can@vger.kernel.org, festevam@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>

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
 drivers/net/can/flexcan.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 41c0fc9..13bea0f 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1268,13 +1268,12 @@ static int __maybe_unused flexcan_suspend(struct device *device)
 	struct flexcan_priv *priv = netdev_priv(dev);
 	int err;
 
-	err = flexcan_chip_disable(priv);
-	if (err)
-		return err;
-
 	if (netif_running(dev)) {
 		netif_stop_queue(dev);
 		netif_device_detach(dev);
+		err = flexcan_chip_disable(priv);
+		if (err)
+			return err;
 	}
 	priv->can.state = CAN_STATE_SLEEPING;
 
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

