From: Matthias Klein <matthias.klein@optimeas.de>
Subject: [PATCH V2 4/5] can: flexcan: fix transition from and to freeze mode in chip_{,un}freeze
Date: Mon, 28 Jul 2014 08:34:27 +0200
Message-ID: <1406529268-20126-4-git-send-email-matthias.klein@optimeas.de>
References: <1406529268-20126-1-git-send-email-matthias.klein@optimeas.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from obi-wan.optimeas.de ([82.165.198.204]:40266 "EHLO
	obi-wan.optimeas.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbaG1Gei (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 28 Jul 2014 02:34:38 -0400
In-Reply-To: <1406529268-20126-1-git-send-email-matthias.klein@optimeas.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org, support@karo-electronics.de
Cc: bigeasy@linutronix.de, linux-stable <stable@vger.kernel.org>

From: Marc Kleine-Budde <mkl@pengutronix.de>

This patch factors out freeze and unfreeze of the CAN core into seperate
functions. Experiments have shown that the transition from and to freeze mode
may take several microseconds, especially the time entering the freeze mode
depends on the current bitrate.

This patch adds a while loop which polls the Freeze Mode ACK bit (FRZ_ACK) that
indicates a successfull mode change. If the function runs into a timeout a
error value is returned.

Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Matthias Klein <matthias.klein@optimeas.de>
---
 drivers/net/can/flexcan.c | 60 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index f6f95ae..b77f1da 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -322,6 +322,44 @@ static int flexcan_chip_disable(struct flexcan_priv *priv)
 	return 0;
 }
 
+static int flexcan_chip_freeze(struct flexcan_priv *priv)
+{
+	struct flexcan_regs __iomem *regs = priv->base;
+	unsigned int timeout = 1000 * 1000 * 10 / priv->can.bittiming.bitrate;
+	u32 reg;
+
+	reg = flexcan_read(&regs->mcr);
+	reg |= FLEXCAN_MCR_HALT;
+	flexcan_write(reg, &regs->mcr);
+
+	while (timeout-- && !(flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
+		usleep_range(100, 200);
+
+	if (!(flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int flexcan_chip_unfreeze(struct flexcan_priv *priv)
+{
+	struct flexcan_regs __iomem *regs = priv->base;
+	unsigned int timeout = FLEXCAN_TIMEOUT_US / 10;
+	u32 reg;
+
+	reg = flexcan_read(&regs->mcr);
+	reg &= ~FLEXCAN_MCR_HALT;
+	flexcan_write(reg, &regs->mcr);
+
+	while (timeout-- && (flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
+		usleep_range(10, 20);
+
+	if (flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
 static int flexcan_get_berr_counter(const struct net_device *dev,
 				    struct can_berr_counter *bec)
 {
@@ -776,7 +814,7 @@ static int flexcan_chip_start(struct net_device *dev)
 		netdev_err(dev, "Failed to softreset can module (mcr=0x%08x)\n",
 			   reg_mcr);
 		err = -ENODEV;
-		goto out;
+		goto out_chip_disable;
 	}
 
 	flexcan_set_bittiming(dev);
@@ -846,12 +884,12 @@ static int flexcan_chip_start(struct net_device *dev)
 
 	err = flexcan_transceiver_enable(priv);
 	if (err)
-		goto out;
+		goto out_chip_disable;
 
 	/* synchronize with the can bus */
-	reg_mcr = flexcan_read(&regs->mcr);
-	reg_mcr &= ~FLEXCAN_MCR_HALT;
-	flexcan_write(reg_mcr, &regs->mcr);
+	err = flexcan_chip_unfreeze(priv);
+	if (err)
+		goto out_transceiver_disable;
 
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
@@ -864,7 +902,9 @@ static int flexcan_chip_start(struct net_device *dev)
 
 	return 0;
 
- out:
+ out_transceiver_disable:
+	flexcan_transceiver_disable(priv);
+ out_chip_disable:
 	flexcan_chip_disable(priv);
 	return err;
 }
@@ -879,12 +919,10 @@ static void flexcan_chip_stop(struct net_device *dev)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->base;
-	u32 reg;
 
-	/* Disable + halt module */
-	reg = flexcan_read(&regs->mcr);
-	reg |= FLEXCAN_MCR_MDIS | FLEXCAN_MCR_HALT;
-	flexcan_write(reg, &regs->mcr);
+	/* freeze + disable module */
+	flexcan_chip_freeze(priv);
+	flexcan_chip_disable(priv);
 
 	/* Disable all interrupts */
 	flexcan_write(0, &regs->imask1);
-- 
2.0.1

