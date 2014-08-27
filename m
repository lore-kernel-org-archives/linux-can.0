From: David Jander <david@protonic.nl>
Subject: [PATCH 1/3] can: flexcan.c: Correctly initialize mailboxes
Date: Wed, 27 Aug 2014 11:58:05 +0200
Message-ID: <1409133487-23367-2-git-send-email-david@protonic.nl>
References: <1409133487-23367-1-git-send-email-david@protonic.nl>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:17912 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933410AbaH0KTh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Aug 2014 06:19:37 -0400
In-Reply-To: <1409133487-23367-1-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, David Jander <david@protonic.nl>

Apparently mailboxes may contain random data at startup, causing some of
them being prepared for message reception. This causes overruns being
missed or even confusing the IRQ check for trasmitted messages, increasing
the transmit counter instead of the error counter.

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/net/can/flexcan.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 944aa5d..a9700f3 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -801,6 +801,7 @@ static int flexcan_chip_start(struct net_device *dev)
 	struct flexcan_regs __iomem *regs = priv->base;
 	int err;
 	u32 reg_mcr, reg_ctrl;
+	int i;
 
 	/* enable module */
 	err = flexcan_chip_enable(priv);
@@ -867,9 +868,11 @@ static int flexcan_chip_start(struct net_device *dev)
 	netdev_dbg(dev, "%s: writing ctrl=0x%08x", __func__, reg_ctrl);
 	flexcan_write(reg_ctrl, &regs->ctrl);
 
-	/* Abort any pending TX, mark Mailbox as INACTIVE */
-	flexcan_write(FLEXCAN_MB_CNT_CODE(0x4),
-		      &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
+	/* Clear and invalidate all mailboxes first */
+	for (i = 0; i < 64; i++) {
+		flexcan_write(FLEXCAN_MB_CNT_CODE(0),
+		      &regs->cantxfg[i].can_ctrl);
+	}
 
 	/* acceptance mask/acceptance code (accept everything) */
 	flexcan_write(0x0, &regs->rxgmask);
-- 
1.9.1

