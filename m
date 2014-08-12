From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 3/4] can: flexcan: Put enabling error irq into separate function
Date: Tue, 12 Aug 2014 15:43:06 +0200
Message-ID: <1407850987-26707-3-git-send-email-alexander.stein@systec-electronic.com>
References: <1407850987-26707-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:35612 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751810AbaHLNqj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 Aug 2014 09:46:39 -0400
In-Reply-To: <1407850987-26707-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, linux-can@vger.kernel.org

This is a preparation for a further patch disabling/enabling that irq
when needed. This has no functional changes.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 drivers/net/can/flexcan.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 5e391ec70a2b..65102e5456c2 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -563,6 +563,18 @@ static void do_state(struct net_device *dev,
 	}
 }
 
+static void flexcan_enable_err_irq(struct flexcan_priv *priv)
+{
+	/* Enable the flag in reg_ctrl_default which will be written
+	 * in flexcan_poll
+	 */
+	if (priv->devtype_data->features & FLEXCAN_HAS_BROKEN_ERR_STATE ||
+	    priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
+		priv->reg_ctrl_default |= FLEXCAN_CTRL_ERR_MSK;
+	else
+		priv->reg_ctrl_default &= ~FLEXCAN_CTRL_ERR_MSK;
+}
+
 static int flexcan_poll_state(struct net_device *dev, u32 reg_esr)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
@@ -855,21 +867,20 @@ static int flexcan_chip_start(struct net_device *dev)
 	reg_ctrl &= ~FLEXCAN_CTRL_TSYN;
 	reg_ctrl |= FLEXCAN_CTRL_BOFF_REC | FLEXCAN_CTRL_LBUF |
 		FLEXCAN_CTRL_ERR_STATE;
+
+	/* save for later use */
+	priv->reg_ctrl_default = reg_ctrl;
+
 	/*
 	 * enable the "error interrupt" (FLEXCAN_CTRL_ERR_MSK),
 	 * on most Flexcan cores, too. Otherwise we don't get
 	 * any error warning or passive interrupts.
 	 */
-	if (priv->devtype_data->features & FLEXCAN_HAS_BROKEN_ERR_STATE ||
-	    priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
-		reg_ctrl |= FLEXCAN_CTRL_ERR_MSK;
-	else
-		reg_ctrl &= ~FLEXCAN_CTRL_ERR_MSK;
+	flexcan_enable_err_irq(priv);
 
-	/* save for later use */
-	priv->reg_ctrl_default = reg_ctrl;
-	netdev_dbg(dev, "%s: writing ctrl=0x%08x", __func__, reg_ctrl);
-	flexcan_write(reg_ctrl, &regs->ctrl);
+	netdev_dbg(dev, "%s: writing ctrl=0x%08x", __func__,
+		   priv->reg_ctrl_default);
+	flexcan_write(priv->reg_ctrl_default, &regs->ctrl);
 
 	/* Abort any pending TX, mark Mailbox as INACTIVE */
 	flexcan_write(FLEXCAN_MB_CNT_CODE(0x4),
-- 
1.8.5.5

