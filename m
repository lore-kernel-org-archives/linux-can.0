From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3 14/16] can: flexcan: add quirk FLEXCAN_QUIRK_ENABLE_EACEN_RRS
Date: Wed, 18 Jan 2017 15:52:25 +0100
Message-ID: <20170118145227.24916-15-mkl@pengutronix.de>
References: <20170118145227.24916-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:55191 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751832AbdARPaS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2017 10:30:18 -0500
In-Reply-To: <20170118145227.24916-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: david@protonic.nl, Mirza Krak <mirza.krak@hostmobility.com>, Holger Schurig <holgerschurig@gmail.com>, alexander.stein@systec-electronic.com, Marc Kleine-Budde <mkl@pengutronix.de>

In order to receive RTR frames in the non HW FIFO mode the RSS and EACEN bits
of the reg_ctrl2 have to be activated. As this has no side effect in the FIFO
mode, we do this unconditionally on cores with the reg_ctrl2.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 27121f9cd59b..a0fdced0e849 100644
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
@@ -276,11 +277,12 @@ static const struct flexcan_devtype_data fsl_p1010_devtype_data = {
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
@@ -825,6 +827,12 @@ static int flexcan_chip_start(struct net_device *dev)
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
2.11.0

