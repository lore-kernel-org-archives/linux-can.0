From: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
Subject: [PATCH 3/6] can: flexcan: add error passive state quirk
Date: Thu, 31 Aug 2017 08:25:35 +0000
Message-ID: <3cbb306756434138b1c80fd76ecace8d@SGPMBX1017.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:46950 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbdHaIZj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 31 Aug 2017 04:25:39 -0400
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

From 916835bc515f24dff133526239c9e464b0153ba0 Mon Sep 17 00:00:00 2001
From: Zhu Yi <yi.zhu5@cn.bosch.com>
Date: Thu, 31 Aug 2017 09:21:24 +0800
Subject: [PATCH 3/6] can: flexcan: add error passive state quirk

Add FLEXCAN_QUIRK_BROKEN_PERR_STATE for better description
of the missing error passive interrupt quirk.

Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
---
 drivers/net/can/flexcan.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index e163c55..712b7de 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -198,6 +198,7 @@
 #define FLEXCAN_QUIRK_ENABLE_EACEN_RRS	BIT(3) /* Enable EACEN and RRS bit in ctrl2 */
 #define FLEXCAN_QUIRK_DISABLE_MECR	BIT(4) /* Disable Memory error detection */
 #define FLEXCAN_QUIRK_USE_OFF_TIMESTAMP	BIT(5) /* Use timestamp based offloading */
+#define FLEXCAN_QUIRK_BROKEN_PERR_STATE	BIT(6) /* No interrupt for error passive */
 
 /* Structure of the message buffer */
 struct flexcan_mb {
@@ -767,7 +768,8 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 
 	/* state change interrupt or broken error state quirk fix is enabled */
 	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
-	    (priv->devtype_data->quirks & FLEXCAN_QUIRK_BROKEN_WERR_STATE))
+	    (priv->devtype_data->quirks & FLEXCAN_QUIRK_BROKEN_WERR_STATE) ||
+	    (priv->devtype_data->quirks & FLEXCAN_QUIRK_BROKEN_PERR_STATE))
 		flexcan_irq_state(dev, reg_esr);
 
 	/* bus error IRQ - handle if bus error reporting is activated */
@@ -889,6 +891,7 @@ static int flexcan_chip_start(struct net_device *dev)
 	 * any error warning or passive interrupts.
 	 */
 	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_BROKEN_WERR_STATE ||
+	    priv->devtype_data->quirks & FLEXCAN_QUIRK_BROKEN_PERR_STATE ||
 	    priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
 		reg_ctrl |= FLEXCAN_CTRL_ERR_MSK;
 	else
-- 
2.7.4

