From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 05/12] can: flexcan: rename feature into quirks
Date: Tue,  1 Sep 2015 11:29:08 +0200
Message-ID: <1441099755-8601-6-git-send-email-mkl@pengutronix.de>
References: <1441099755-8601-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59783 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755235AbbIAJ3T (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Sep 2015 05:29:19 -0400
In-Reply-To: <1441099755-8601-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, david@protonic.nl, Marc Kleine-Budde <mkl@pengutronix.de>

This patch renames the "features" member of struct flexcan_devtype_data to
"quirks". The corresponding defines are renamed too, to reflect what they
actually do.

    FLEXCAN_HAS_V10_FEATURES      -> FLEXCAN_QUIRK_DISABLE_RXFG
    FLEXCAN_HAS_BROKEN_ERR_STATE  -> FLEXCAN_QUIRK_BROKEN_ERR_STATE
    FLEXCAN_HAS_MECR_FEATURES     -> FLEXCAN_QUIRK_DISABLE_MECR

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 70cdbfcebb46..dd5a9353e0c5 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -187,9 +187,9 @@
  *
  * Some SOCs do not have the RX_WARN & TX_WARN interrupt line connected.
  */
-#define FLEXCAN_HAS_V10_FEATURES	BIT(1) /* For core version >= 10 */
-#define FLEXCAN_HAS_BROKEN_ERR_STATE	BIT(2) /* [TR]WRN_INT not connected */
-#define FLEXCAN_HAS_MECR_FEATURES	BIT(3) /* Memory error detection */
+#define FLEXCAN_QUIRK_BROKEN_ERR_STATE	BIT(1) /* [TR]WRN_INT not connected */
+#define FLEXCAN_QUIRK_DISABLE_RXFG	BIT(2) /* Disable RX FIFO Global mask */
+#define FLEXCAN_QUIRK_DISABLE_MECR	BIT(3) /* Disble Memory error detection */
 
 /* Structure of the message buffer */
 struct flexcan_mb {
@@ -244,7 +244,7 @@ struct flexcan_regs {
 };
 
 struct flexcan_devtype_data {
-	u32 features;	/* hardware controller features */
+	u32 quirks;		/* quirks needed for different IP cores */
 };
 
 struct flexcan_priv {
@@ -263,17 +263,17 @@ struct flexcan_priv {
 };
 
 static struct flexcan_devtype_data fsl_p1010_devtype_data = {
-	.features = FLEXCAN_HAS_BROKEN_ERR_STATE,
+	.quirks = FLEXCAN_QUIRK_BROKEN_ERR_STATE,
 };
 
 static struct flexcan_devtype_data fsl_imx28_devtype_data;
 
 static struct flexcan_devtype_data fsl_imx6q_devtype_data = {
-	.features = FLEXCAN_HAS_V10_FEATURES,
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG,
 };
 
 static struct flexcan_devtype_data fsl_vf610_devtype_data = {
-	.features = FLEXCAN_HAS_V10_FEATURES | FLEXCAN_HAS_MECR_FEATURES,
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_DISABLE_MECR,
 };
 
 static const struct can_bittiming_const flexcan_bittiming_const = {
@@ -870,7 +870,7 @@ static int flexcan_chip_start(struct net_device *dev)
 	 * on most Flexcan cores, too. Otherwise we don't get
 	 * any error warning or passive interrupts.
 	 */
-	if (priv->devtype_data->features & FLEXCAN_HAS_BROKEN_ERR_STATE ||
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_BROKEN_ERR_STATE ||
 	    priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
 		reg_ctrl |= FLEXCAN_CTRL_ERR_MSK;
 	else
@@ -900,7 +900,7 @@ static int flexcan_chip_start(struct net_device *dev)
 	flexcan_write(0x0, &regs->rx14mask);
 	flexcan_write(0x0, &regs->rx15mask);
 
-	if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES)
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_DISABLE_RXFG)
 		flexcan_write(0x0, &regs->rxfgmask);
 
 	/* On Vybrid, disable memory error detection interrupts
@@ -909,7 +909,7 @@ static int flexcan_chip_start(struct net_device *dev)
 	 * false positive memory errors and put the device in
 	 * freeze mode.
 	 */
-	if (priv->devtype_data->features & FLEXCAN_HAS_MECR_FEATURES) {
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_DISABLE_MECR) {
 		/* Follow the protocol as described in "Detection
 		 * and Correction of Memory Errors" to write to
 		 * MECR register
-- 
2.5.0

