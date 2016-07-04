From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 10/12] can: flexcan: add quirk FLEXCAN_QUIRK_ENABLE_EACEN_RRS
Date: Mon,  4 Jul 2016 20:32:15 +0200
Message-ID: <1467657137-18891-11-git-send-email-mkl@pengutronix.de>
References: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:56939 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753262AbcGDSmy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 4 Jul 2016 14:42:54 -0400
In-Reply-To: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: david@protonic.nl, Marc Kleine-Budde <mkl@pengutronix.de>

In order to receive RTR frames in the non HW FIFO mode the RSS and EACEN bits
of the reg_ctrl2 have to be activated. As this has no side effect in the FIFO
mode, we do this unconditionally on cores with the reg_ctrl2.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 793be68e02b7..c94a65dbb1c2 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -187,7 +187,8 @@
  */
 #define FLEXCAN_QUIRK_BROKEN_ERR_STATE	BIT(1) /* [TR]WRN_INT not connected */
 #define FLEXCAN_QUIRK_DISABLE_RXFG	BIT(2) /* Disable RX FIFO Global mask */
-#define FLEXCAN_QUIRK_DISABLE_MECR	BIT(3) /* Disble Memory error detection */
+#define FLEXCAN_QUIRK_ENABLE_EACEN_RRS	BIT(3) /* Enable EACEN and RRS bit in ctrl2 */
+#define FLEXCAN_QUIRK_DISABLE_MECR	BIT(4) /* Disble Memory error detection */
 
 /* Structure of the message buffer */
 struct flexcan_mb {
@@ -278,11 +279,12 @@ static const struct flexcan_devtype_data fsl_p1010_devtype_data = {
 static const struct flexcan_devtype_data fsl_imx28_devtype_data;
 
 static const struct flexcan_devtype_data fsl_imx6q_devtype_data = {
-	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG,
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS,
 };
 
 static const struct flexcan_devtype_data fsl_vf610_devtype_data = {
-	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_DISABLE_MECR,
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
+		FLEXCAN_QUIRK_DISABLE_MECR,
 };
 
 static const struct can_bittiming_const flexcan_bittiming_const = {
@@ -864,6 +866,12 @@ static int flexcan_chip_start(struct net_device *dev)
 	netdev_dbg(dev, "%s: writing ctrl=0x%08x", __func__, reg_ctrl);
 	flexcan_write(reg_ctrl, &regs->ctrl);
 
+	if ((priv->devtype_data->quirks & FLEXCAN_QUIRK_ENABLE_EACEN_RRS)) {
+		reg_ctrl2 = flexcan_read(&regs->ctrl2);
+		reg_ctrl2 |= FLEXCAN_CTRL2_EACEN | FLEXCAN_CTRL2_RRS;
+		flexcan_write(reg_ctrl2, &regs->ctrl2);
+	}
+
 	/* clear and invalidate all mailboxes first */
 	for (i = priv->tx_mb_idx; i < ARRAY_SIZE(regs->mb); i++) {
 		flexcan_write(FLEXCAN_MB_CODE_RX_INACTIVE,
-- 
2.8.1

