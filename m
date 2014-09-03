From: David Jander <david@protonic.nl>
Subject: RFC: [PATCH v2] can: flexcan: Implement errata ERR005829
Date: Wed,  3 Sep 2014 16:47:22 +0200
Message-ID: <1409755642-28233-1-git-send-email-david@protonic.nl>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:9130 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932926AbaICOrS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 3 Sep 2014 10:47:18 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, David Jander <david@protonic.nl>

Signed-off-by: David Jander <david@protonic.nl>
---

changed from v1:
 - Implemented complete workaround and based on linux-can/testing

 drivers/net/can/flexcan.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 0bcbb96..d9d0ecb 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -125,7 +125,9 @@
 	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT)
 
 /* FLEXCAN interrupt flag register (IFLAG) bits */
-#define FLEXCAN_TX_BUF_ID		8
+/* Errata ERR005829 step7: Reserve first valid MB */
+#define FLEXCAN_FIRST_VALID_MB		8
+#define FLEXCAN_TX_BUF_ID		9
 #define FLEXCAN_IFLAG_BUF(x)		BIT(x)
 #define FLEXCAN_IFLAG_RX_FIFO_OVERFLOW	BIT(7)
 #define FLEXCAN_IFLAG_RX_FIFO_WARN	BIT(6)
@@ -428,6 +430,12 @@ static int flexcan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	flexcan_write(can_id, &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_id);
 	flexcan_write(ctrl, &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
 
+	/* Errata ERR005829 step8: Write twice INACTIVE(0x8) code to first MB */
+	flexcan_write(FLEXCAN_MB_CNT_CODE(0x8),
+		&regs->cantxfg[FLEXCAN_FIRST_VALID_MB].can_ctrl);
+	flexcan_write(FLEXCAN_MB_CNT_CODE(0x8),
+		&regs->cantxfg[FLEXCAN_FIRST_VALID_MB].can_ctrl);
+
 	return NETDEV_TX_OK;
 }
 
-- 
1.9.1

