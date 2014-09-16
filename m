From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v4 1/5] can: flexcan: mark TX mailbox as TX_INACTIVE
Date: Tue, 16 Sep 2014 16:20:30 +0200
Message-ID: <1410877234-29751-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34276 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023AbaIPOUi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 16 Sep 2014 10:20:38 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: david@protonic.nl, Marc Kleine-Budde <mkl@pengutronix.de>

This patch fixes the initialization of the TX mailbox. It is now correctly
initialized as TX_INACTIVE not RX_EMPTY.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes since v3:
- new

 drivers/net/can/flexcan.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 630c7bf..76dcbca 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -136,6 +136,17 @@
 
 /* FLEXCAN message buffers */
 #define FLEXCAN_MB_CNT_CODE(x)		(((x) & 0xf) << 24)
+#define FLEXCAN_MB_CODE_RX_INACTIVE	(0x0 << 24)
+#define FLEXCAN_MB_CODE_RX_EMPTY	(0x4 << 24)
+#define FLEXCAN_MB_CODE_RX_FULL		(0x2 << 24)
+#define FLEXCAN_MB_CODE_RX_OVERRRUN	(0x6 << 24)
+#define FLEXCAN_MB_CODE_RX_RANSWER	(0xa << 24)
+
+#define FLEXCAN_MB_CODE_TX_INACTIVE	(0x8 << 24)
+#define FLEXCAN_MB_CODE_TX_ABORT	(0x9 << 24)
+#define FLEXCAN_MB_CODE_TX_DATA		(0xc << 24)
+#define FLEXCAN_MB_CODE_TX_TANSWER	(0xe << 24)
+
 #define FLEXCAN_MB_CNT_SRR		BIT(22)
 #define FLEXCAN_MB_CNT_IDE		BIT(21)
 #define FLEXCAN_MB_CNT_RTR		BIT(20)
@@ -867,8 +878,8 @@ static int flexcan_chip_start(struct net_device *dev)
 	netdev_dbg(dev, "%s: writing ctrl=0x%08x", __func__, reg_ctrl);
 	flexcan_write(reg_ctrl, &regs->ctrl);
 
-	/* Abort any pending TX, mark Mailbox as INACTIVE */
-	flexcan_write(FLEXCAN_MB_CNT_CODE(0x4),
+	/* mark TX mailbox as INACTIVE */
+	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
 		      &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
 
 	/* acceptance mask/acceptance code (accept everything) */
-- 
2.1.0

