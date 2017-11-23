From: Pankaj Bansal <pankaj.bansal@nxp.com>
Subject: [PATCH v3 2/2] can: flexcan: adding platform specific details for LS1021A
Date: Thu, 23 Nov 2017 14:39:18 +0530
Message-ID: <1511428158-28710-2-git-send-email-pankaj.bansal@nxp.com>
References: <1510660589-16125-1-git-send-email-pankaj.bansal@nxp.com>
 <1511428158-28710-1-git-send-email-pankaj.bansal@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-by2nam03on0069.outbound.protection.outlook.com ([104.47.42.69]:18704
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752273AbdKWJFq (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 23 Nov 2017 04:05:46 -0500
In-Reply-To: <1511428158-28710-1-git-send-email-pankaj.bansal@nxp.com>
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
Changes in v3:
  - Add LS1021 in FLEXCAN hardware feature flags table
  - Kept LS1021 compatible in one line, even if it's more than 80
    chars.
  - Add PERR_STATE quirk and USE_OFF_TIMESTAMP quirk and
    ENABLE_EACEN_RRS quirk for LS1021A.
  - Tested on LS1021A using "cangen can0 -D 11223344DEADBEEF -L 8 -R"
    and "cangen can0 -D 11223344DEADBEEF -L 8"
Changes in v2:
  - No change.

 drivers/net/can/flexcan.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 4c873fb..21d0dd8 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -190,6 +190,7 @@
  *   MX53  FlexCAN2  03.00.00.00    yes        no        no       no        no
  *   MX6s  FlexCAN3  10.00.12.00    yes       yes        no       no       yes
  *   VF610 FlexCAN3  ?               no       yes         ?      yes       yes?
+ * LS1021A FlexCAN2  03.00.04.00     no       yes        no       no       yes
  *
  * Some SOCs do not have the RX_WARN & TX_WARN interrupt line connected.
  */
@@ -304,6 +305,13 @@ static const struct flexcan_devtype_data fsl_vf610_devtype_data = {
 		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_OFF_TIMESTAMP,
 };
 
+/* LS1021A-Rev2 has functional RX-FIFO mode  */
+static const struct flexcan_devtype_data fsl_ls1021a_r2_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
+		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
+		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP,
+};
+
 static const struct can_bittiming_const flexcan_bittiming_const = {
 	.name = DRV_NAME,
 	.tseg1_min = 4,
@@ -1248,6 +1256,7 @@ static const struct of_device_id flexcan_of_match[] = {
 	{ .compatible = "fsl,imx25-flexcan", .data = &fsl_p1010_devtype_data, },
 	{ .compatible = "fsl,p1010-flexcan", .data = &fsl_p1010_devtype_data, },
 	{ .compatible = "fsl,vf610-flexcan", .data = &fsl_vf610_devtype_data, },
+	{ .compatible = "fsl,ls1021ar2-flexcan", .data = &fsl_ls1021a_r2_devtype_data, },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, flexcan_of_match);
-- 
2.7.4

