From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: RFC: [PATCH v2 1/2] can: flexcan: Correctly initialize mailboxes
Date: Tue,  2 Sep 2014 17:03:35 +0200
Message-ID: <1409670216-25674-2-git-send-email-mkl@pengutronix.de>
References: <1409670216-25674-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55030 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735AbaIBPDj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Sep 2014 11:03:39 -0400
In-Reply-To: <1409670216-25674-1-git-send-email-mkl@pengutronix.de>
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
[mkl: adjust starting value of loop]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes since v1:
- don't remove existing initialization of FLEXCAN_TX_BUF_ID
- start loop at FLEXCAN_TX_BUF_ID + 1

Marc

 drivers/net/can/flexcan.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 630c7bf..6ec49bd 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -801,6 +801,7 @@ static int flexcan_chip_start(struct net_device *dev)
 	struct flexcan_regs __iomem *regs = priv->base;
 	int err;
 	u32 reg_mcr, reg_ctrl;
+	int i;
 
 	/* enable module */
 	err = flexcan_chip_enable(priv);
@@ -870,6 +871,11 @@ static int flexcan_chip_start(struct net_device *dev)
 	/* Abort any pending TX, mark Mailbox as INACTIVE */
 	flexcan_write(FLEXCAN_MB_CNT_CODE(0x4),
 		      &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
+	/* Clear and invalidate all mailboxes first */
+	for (i = FLEXCAN_TX_BUF_ID + 1; i < ARRAY_SIZE(regs->cantxfg; i++) {
+		flexcan_write(FLEXCAN_MB_CNT_CODE(0),
+		      &regs->cantxfg[i].can_ctrl);
+	}
 
 	/* acceptance mask/acceptance code (accept everything) */
 	flexcan_write(0x0, &regs->rxgmask);
-- 
2.1.0

