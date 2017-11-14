From: Pankaj Bansal <pankaj.bansal@nxp.com>
Subject: [PATCH v2 2/2] can: flexcan: adding platform specific details for LS1021A
Date: Tue, 14 Nov 2017 17:26:29 +0530
Message-ID: <1510660589-16125-2-git-send-email-pankaj.bansal@nxp.com>
References: <1510307990-15418-1-git-send-email-pankaj.bansal@nxp.com>
 <1510660589-16125-1-git-send-email-pankaj.bansal@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-dm3nam03on0079.outbound.protection.outlook.com ([104.47.41.79]:13186
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752284AbdKNLxp (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 14 Nov 2017 06:53:45 -0500
In-Reply-To: <1510660589-16125-1-git-send-email-pankaj.bansal@nxp.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: V.Sethi@nxp.com, poonam.aggrwal@nxp.com, Pankaj Bansal <pankaj.bansal@nxp.com>, Bhupesh Sharma <bhupesh.sharma@freescale.com>

This patch adds platform specific details for NXP SOC LS1021A to the
flexcan driver code.

Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
Reviewed-by: Zhengxiong Jin <Jason.Jin@freescale.com>
Reviewed-by: Poonam Aggrwal <poonam.aggrwal@nxp.com>
---
Changes in v2:
  - No change.

 drivers/net/can/flexcan.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 100b451..fa2d4c9 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -304,6 +304,11 @@ static const struct flexcan_devtype_data fsl_vf610_devtype_data = {
 		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_OFF_TIMESTAMP,
 };
 
+/* LS1021A-Rev2 has functional RX-FIFO mode  */
+static const struct flexcan_devtype_data fsl_ls1021a_r2_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_DISABLE_MECR,
+};
+
 static const struct can_bittiming_const flexcan_bittiming_const = {
 	.name = DRV_NAME,
 	.tseg1_min = 4,
@@ -1245,6 +1250,8 @@ static const struct of_device_id flexcan_of_match[] = {
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

