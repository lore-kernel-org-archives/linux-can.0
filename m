From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v4 2/5] can: flexcan: correctly initialize mailboxes
Date: Tue, 16 Sep 2014 16:20:31 +0200
Message-ID: <1410877234-29751-2-git-send-email-mkl@pengutronix.de>
References: <1410877234-29751-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34278 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082AbaIPOUj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 16 Sep 2014 10:20:39 -0400
In-Reply-To: <1410877234-29751-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: david@protonic.nl, Marc Kleine-Budde <mkl@pengutronix.de>

From: David Jander <david@protonic.nl>

Apparently mailboxes may contain random data at startup, causing some of them
being prepared for message reception. This causes overruns being missed or even
confusing the IRQ check for trasmitted messages, increasing the transmit
counter instead of the error counter.

This patch initializes all mailboxes after the FIFO as RX_INACTIVE.

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---

Changes since v3:
- make use of FLEXCAN_MB_CODE_RX_INACTIVE instead of using magic numbers

 drivers/net/can/flexcan.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 76dcbca..fc076952 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -812,6 +812,7 @@ static int flexcan_chip_start(struct net_device *dev)
 	struct flexcan_regs __iomem *regs = priv->base;
 	int err;
 	u32 reg_mcr, reg_ctrl;
+	int i;
 
 	/* enable module */
 	err = flexcan_chip_enable(priv);
@@ -878,6 +879,12 @@ static int flexcan_chip_start(struct net_device *dev)
 	netdev_dbg(dev, "%s: writing ctrl=0x%08x", __func__, reg_ctrl);
 	flexcan_write(reg_ctrl, &regs->ctrl);
 
+	/* clear and invalidate all mailboxes first */
+	for (i = FLEXCAN_TX_BUF_ID; i < ARRAY_SIZE(regs->cantxfg); i++) {
+		flexcan_write(FLEXCAN_MB_CODE_RX_INACTIVE,
+			      &regs->cantxfg[i].can_ctrl);
+	}
+
 	/* mark TX mailbox as INACTIVE */
 	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
 		      &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
-- 
2.1.0

