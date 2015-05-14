From: Bhupesh Sharma <bhupesh.sharma@freescale.com>
Subject: [PATCH v2 3/5] can: flexcan: Add ls1021a flexcan device entry
Date: Thu, 14 May 2015 17:03:33 +0530
Message-ID: <1431603215-25546-4-git-send-email-bhupesh.sharma@freescale.com>
References: <1431603215-25546-1-git-send-email-bhupesh.sharma@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn1bon0146.outbound.protection.outlook.com ([157.56.111.146]:24672
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752673AbbENLeX (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 14 May 2015 07:34:23 -0400
In-Reply-To: <1431603215-25546-1-git-send-email-bhupesh.sharma@freescale.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: arnd@arndb.de, linux-can@vger.kernel.org, mkl@pengutronix.de
Cc: bhupesh.linux@gmail.com, bhupesh.sharma@freescale.com, Sakar.Arora@freescale.com, linux-arm-kernel@lists.infradead.org

This patch adds ls1021a flexcan device entry to the flexcan driver code.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
---
 drivers/net/can/flexcan.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index ad0a7e8..deaa24e 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -267,10 +267,26 @@ static struct flexcan_devtype_data fsl_imx28_devtype_data;
 static struct flexcan_devtype_data fsl_imx6q_devtype_data = {
 	.features = FLEXCAN_HAS_V10_FEATURES,
 };
+
 static struct flexcan_devtype_data fsl_vf610_devtype_data = {
 	.features = FLEXCAN_HAS_V10_FEATURES | FLEXCAN_HAS_MECR_FEATURES,
 };
 
+/* LS1021A-Rev1 has a broken RX-FIFO support. So only legacy RX message-buffers
+ * work here.
+ */
+static struct flexcan_devtype_data fsl_ls1021a_devtype_data = {
+	.features = FLEXCAN_HAS_V10_FEATURES | FLEXCAN_HAS_MECR_FEATURES |
+		    FLEXCAN_HAS_ONLY_LEGACY_RX_SUPPORT,
+};
+
+/* LS1021A-Rev2 has functional RX-FIFO mode, so no need to fall back to
+ * the legacy mode.
+ */
+static struct flexcan_devtype_data fsl_ls1021a_r2_devtype_data = {
+	.features = FLEXCAN_HAS_V10_FEATURES | FLEXCAN_HAS_MECR_FEATURES,
+};
+
 static const struct can_bittiming_const flexcan_bittiming_const = {
 	.name = DRV_NAME,
 	.tseg1_min = 4,
@@ -1139,6 +1155,10 @@ static void unregister_flexcandev(struct net_device *dev)
 static const struct of_device_id flexcan_of_match[] = {
 	{ .compatible = "fsl,imx6q-flexcan", .data = &fsl_imx6q_devtype_data, },
 	{ .compatible = "fsl,imx28-flexcan", .data = &fsl_imx28_devtype_data, },
+	{ .compatible = "fsl,ls1021a-flexcan",
+	  .data = &fsl_ls1021a_devtype_data, },
+	{ .compatible = "fsl,ls1021ar2-flexcan",
+	  .data = &fsl_ls1021a_r2_devtype_data, },
 	{ .compatible = "fsl,p1010-flexcan", .data = &fsl_p1010_devtype_data, },
 	{ .compatible = "fsl,vf610-flexcan", .data = &fsl_vf610_devtype_data, },
 	{ /* sentinel */ },
-- 
1.7.9.5


