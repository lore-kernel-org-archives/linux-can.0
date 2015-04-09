From: Bhupesh Sharma <bhupesh.sharma@freescale.com>
Subject: [PATCH 1/3] can: flexcan: Add ls1021a flexcan device entry
Date: Thu, 9 Apr 2015 20:54:14 +0530
Message-ID: <1428593056-13701-1-git-send-email-bhupesh.sharma@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bl2on0135.outbound.protection.outlook.com ([65.55.169.135]:15343
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753603AbbDIPjP (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 9 Apr 2015 11:39:15 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org, mkl@pengutronix.de
Cc: arnd@arndb.de, bhupesh.linux@gmail.com, bhupesh.sharma@freescale.com, Sakar.Arora@freescale.com

This patch adds ls1021a flexcan device entry to the flexcan driver code.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
---
 drivers/net/can/flexcan.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 80c46ad..437d6bd 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -267,10 +267,15 @@ static struct flexcan_devtype_data fsl_imx28_devtype_data;
 static struct flexcan_devtype_data fsl_imx6q_devtype_data = {
 	.features = FLEXCAN_HAS_V10_FEATURES,
 };
+
 static struct flexcan_devtype_data fsl_vf610_devtype_data = {
 	.features = FLEXCAN_HAS_V10_FEATURES | FLEXCAN_HAS_MECR_FEATURES,
 };
 
+static struct flexcan_devtype_data fsl_ls1021a_devtype_data = {
+	.features = FLEXCAN_HAS_V10_FEATURES | FLEXCAN_HAS_MECR_FEATURES,
+};
+
 static const struct can_bittiming_const flexcan_bittiming_const = {
 	.name = DRV_NAME,
 	.tseg1_min = 4,
@@ -1140,6 +1145,8 @@ static void unregister_flexcandev(struct net_device *dev)
 static const struct of_device_id flexcan_of_match[] = {
 	{ .compatible = "fsl,imx6q-flexcan", .data = &fsl_imx6q_devtype_data, },
 	{ .compatible = "fsl,imx28-flexcan", .data = &fsl_imx28_devtype_data, },
+	{ .compatible = "fsl,ls1021a-flexcan",
+	  .data = &fsl_ls1021a_devtype_data, },
 	{ .compatible = "fsl,p1010-flexcan", .data = &fsl_p1010_devtype_data, },
 	{ .compatible = "fsl,vf610-flexcan", .data = &fsl_vf610_devtype_data, },
 	{ /* sentinel */ },
-- 
1.7.9.5


