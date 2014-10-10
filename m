From: David Jander <david@protonic.nl>
Subject: [PATCH 02/15] can: flexcan: rename crl2 -> ctrl2
Date: Fri, 10 Oct 2014 17:46:47 +0200
Message-ID: <1412956020-21489-3-git-send-email-david@protonic.nl>
References: <1412956020-21489-1-git-send-email-david@protonic.nl>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:18363 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbaJJPrA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Oct 2014 11:47:00 -0400
In-Reply-To: <1412956020-21489-1-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

From: Marc Kleine-Budde <mkl@pengutronix.de>

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 2e70a27..b287367 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -93,13 +93,13 @@
 	(FLEXCAN_CTRL_ERR_BUS | FLEXCAN_CTRL_ERR_STATE)
 
 /* FLEXCAN control register 2 (CTRL2) bits */
-#define FLEXCAN_CRL2_ECRWRE		BIT(29)
-#define FLEXCAN_CRL2_WRMFRZ		BIT(28)
-#define FLEXCAN_CRL2_RFFN(x)		(((x) & 0x0f) << 24)
-#define FLEXCAN_CRL2_TASD(x)		(((x) & 0x1f) << 19)
-#define FLEXCAN_CRL2_MRP		BIT(18)
-#define FLEXCAN_CRL2_RRS		BIT(17)
-#define FLEXCAN_CRL2_EACEN		BIT(16)
+#define FLEXCAN_CTRL2_ECRWRE		BIT(29)
+#define FLEXCAN_CTRL2_WRMFRZ		BIT(28)
+#define FLEXCAN_CTRL2_RFFN(x)		(((x) & 0x0f) << 24)
+#define FLEXCAN_CTRL2_TASD(x)		(((x) & 0x1f) << 19)
+#define FLEXCAN_CTRL2_MRP		BIT(18)
+#define FLEXCAN_CTRL2_RRS		BIT(17)
+#define FLEXCAN_CTRL2_EACEN		BIT(16)
 
 /* FLEXCAN memory error control register (MECR) bits */
 #define FLEXCAN_MECR_ECRWRDIS		BIT(31)
@@ -221,7 +221,7 @@ struct flexcan_regs {
 	u32 imask1;		/* 0x28 */
 	u32 iflag2;		/* 0x2c */
 	u32 iflag1;		/* 0x30 */
-	u32 crl2;		/* 0x34 */
+	u32 ctrl2;		/* 0x34 */
 	u32 esr2;		/* 0x38 */
 	u32 imeur;		/* 0x3c */
 	u32 lrfr;		/* 0x40 */
@@ -893,7 +893,7 @@ static int flexcan_chip_start(struct net_device *dev)
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->base;
 	int err;
-	u32 reg_mcr, reg_ctrl, reg_crl2, reg_mecr;
+	u32 reg_mcr, reg_ctrl, reg_ctrl2, reg_mecr;
 	int i;
 
 	/* enable module */
@@ -996,9 +996,9 @@ static int flexcan_chip_start(struct net_device *dev)
 		 * and Correction of Memory Errors" to write to
 		 * MECR register
 		 */
-		reg_crl2 = flexcan_read(&regs->crl2);
-		reg_crl2 |= FLEXCAN_CRL2_ECRWRE;
-		flexcan_write(reg_crl2, &regs->crl2);
+		reg_ctrl2 = flexcan_read(&regs->ctrl2);
+		reg_ctrl2 |= FLEXCAN_CTRL2_ECRWRE;
+		flexcan_write(reg_ctrl2, &regs->ctrl2);
 
 		reg_mecr = flexcan_read(&regs->mecr);
 		reg_mecr &= ~FLEXCAN_MECR_ECRWRDIS;
-- 
1.9.1

