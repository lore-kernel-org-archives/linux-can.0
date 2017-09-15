From: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
Subject: [PATCH V1 2/6] can: flexcan: rename legacy error state quirk
Date: Fri, 15 Sep 2017 07:01:23 +0000
Message-ID: <11b0b1ce5fb445e6b3e4f94f147d650f@SGPMBX1017.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:60438 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751124AbdIOHB1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 15 Sep 2017 03:01:27 -0400
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

From acff501b3d2fd5d3854ba1834e7d89bd937155f5 Mon Sep 17 00:00:00 2001
From: Zhu Yi <yi.zhu5@cn.bosch.com>
Date: Thu, 31 Aug 2017 09:09:08 +0800
Subject: [PATCH V1 2/6] can: flexcan: rename legacy error state quirk

Rename FLEXCAN_QUIRK_BROKEN_ERR_STATE to
FLEXCAN_QUIRK_BROKEN_WERR_STATE for better
description of the missing [TR]WRN_INT quirk.

Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
Acked-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/flexcan.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index df4bfb8..e163c55 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -193,7 +193,7 @@
  *
  * Some SOCs do not have the RX_WARN & TX_WARN interrupt line connected.
  */
-#define FLEXCAN_QUIRK_BROKEN_ERR_STATE	BIT(1) /* [TR]WRN_INT not connected */
+#define FLEXCAN_QUIRK_BROKEN_WERR_STATE	BIT(1) /* [TR]WRN_INT not connected */
 #define FLEXCAN_QUIRK_DISABLE_RXFG	BIT(2) /* Disable RX FIFO Global mask */
 #define FLEXCAN_QUIRK_ENABLE_EACEN_RRS	BIT(3) /* Enable EACEN and RRS bit in ctrl2 */
 #define FLEXCAN_QUIRK_DISABLE_MECR	BIT(4) /* Disable Memory error detection */
@@ -281,7 +281,7 @@ struct flexcan_priv {
 };
 
 static const struct flexcan_devtype_data fsl_p1010_devtype_data = {
-	.quirks = FLEXCAN_QUIRK_BROKEN_ERR_STATE,
+	.quirks = FLEXCAN_QUIRK_BROKEN_WERR_STATE,
 };
 
 static const struct flexcan_devtype_data fsl_imx28_devtype_data;
@@ -767,7 +767,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 
 	/* state change interrupt or broken error state quirk fix is enabled */
 	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
-	    (priv->devtype_data->quirks & FLEXCAN_QUIRK_BROKEN_ERR_STATE))
+	    (priv->devtype_data->quirks & FLEXCAN_QUIRK_BROKEN_WERR_STATE))
 		flexcan_irq_state(dev, reg_esr);
 
 	/* bus error IRQ - handle if bus error reporting is activated */
@@ -888,7 +888,7 @@ static int flexcan_chip_start(struct net_device *dev)
 	 * on most Flexcan cores, too. Otherwise we don't get
 	 * any error warning or passive interrupts.
 	 */
-	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_BROKEN_ERR_STATE ||
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_BROKEN_WERR_STATE ||
 	    priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
 		reg_ctrl |= FLEXCAN_CTRL_ERR_MSK;
 	else
-- 
2.7.4



