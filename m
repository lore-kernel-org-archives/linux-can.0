From: Pankaj Bansal <pankaj.bansal@nxp.com>
Subject: [PATCH 2/2] can: flexcan: adding platform specific details for LS1021A
Date: Fri, 10 Nov 2017 15:29:50 +0530
Message-ID: <1510307990-15418-2-git-send-email-pankaj.bansal@nxp.com>
References: <1510307990-15418-1-git-send-email-pankaj.bansal@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-cys01nam02on0065.outbound.protection.outlook.com ([104.47.37.65]:49248
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751664AbdKJJ4n (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 10 Nov 2017 04:56:43 -0500
In-Reply-To: <1510307990-15418-1-git-send-email-pankaj.bansal@nxp.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: V.Sethi@nxp.com, poonam.aggrwal@nxp.com, Pankaj Bansal <pankaj.bansal@nxp.com>, Bhupesh Sharma <bhupesh.sharma@freescale.com>

This patch adds platform specific details for NXP SOC LS1021A
to the flexcan driver code.

Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
Reviewed-by: Zhengxiong Jin <Jason.Jin@freescale.com>
Reviewed-by: Poonam Aggrwal <poonam.aggrwal@nxp.com>
---
 drivers/net/can/flexcan.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index d4ce2df..d8cac4c 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -304,6 +304,12 @@ static const struct flexcan_devtype_data fsl_vf610_devtype_data = {
 		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_OFF_TIMESTAMP,
 };
 
+/* LS1021A-Rev2 has functional RX-FIFO mode
+ */
+static struct flexcan_devtype_data fsl_ls1021a_r2_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_DISABLE_MECR,
+};
+
 static const struct can_bittiming_const flexcan_bittiming_const = {
 	.name = DRV_NAME,
 	.tseg1_min = 4,
@@ -1245,6 +1251,8 @@ static const struct of_device_id flexcan_of_match[] = {
 	{ .compatible = "fsl,imx28-flexcan", .data = &fsl_imx28_devtype_data, },
 	{ .compatible = "fsl,p1010-flexcan", .data = &fsl_p1010_devtype_data, },
 	{ .compatible = "fsl,vf610-flexcan", .data = &fsl_vf610_devtype_data, },
+	{ .compatible = "fsl,ls1021ar2-flexcan",
+	  .data = &fsl_ls1021a_r2_devtype_data, },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, flexcan_of_match);
-- 
2.7.4

