From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3 1/2] can: flexcan: Correctly initialize mailboxes
Date: Wed,  3 Sep 2014 11:08:33 +0200
Message-ID: <1409735314-27504-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56209 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756017AbaICJIj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 3 Sep 2014 05:08:39 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: david@protonic.nl, Marc Kleine-Budde <mkl@pengutronix.de>

From: David Jander <david@protonic.nl>

Apparently mailboxes may contain random data at startup, causing some of
them being prepared for message reception. This causes overruns being
missed or even confusing the IRQ check for trasmitted messages, increasing
the transmit counter instead of the error counter.

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes since v2: 
- move before FLEXCAN_TX_BUF_ID
- start loop at FLEXCAN_TX_BUF_ID

Changes since v1:
- don't remove existing initialization of FLEXCAN_TX_BUF_ID
- start loop at FLEXCAN_TX_BUF_ID + 1

 drivers/net/can/flexcan.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 630c7bf..56eb375 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -801,6 +801,7 @@ static int flexcan_chip_start(struct net_device *dev)
 	struct flexcan_regs __iomem *regs = priv->base;
 	int err;
 	u32 reg_mcr, reg_ctrl;
+	int i;
 
 	/* enable module */
 	err = flexcan_chip_enable(priv);
@@ -867,6 +868,12 @@ static int flexcan_chip_start(struct net_device *dev)
 	netdev_dbg(dev, "%s: writing ctrl=0x%08x", __func__, reg_ctrl);
 	flexcan_write(reg_ctrl, &regs->ctrl);
 
+	/* Clear and invalidate all mailboxes first */
+	for (i = FLEXCAN_TX_BUF_ID; i < ARRAY_SIZE(regs->cantxfg; i++) {
+		flexcan_write(FLEXCAN_MB_CNT_CODE(0x0),
+		      &regs->cantxfg[i].can_ctrl);
+	}
+
 	/* Abort any pending TX, mark Mailbox as INACTIVE */
 	flexcan_write(FLEXCAN_MB_CNT_CODE(0x4),
 		      &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
-- 
2.1.0

