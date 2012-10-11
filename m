From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3] can: flexcan: disable bus error interrupts for the i.MX6q
Date: Thu, 11 Oct 2012 15:39:22 +0200
Message-ID: <1349962762-24500-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35780 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218Ab2JKNj3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 11 Oct 2012 09:39:29 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: wg@grandegger.com, Hui Wang <jason77.wang@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Wolfgang Grandegger <wg@grandegger.com>

Due to a bug in most Flexcan cores, the bus error interrupt needs
to be enabled. Otherwise we don't get any error warning or passive
interrupts. This is _not_ necessary for the i.MX6q and this patch
disables bus error interrupts if "berr-reporting" is not requested.
This avoids bus error flooding, which might harm, especially on
low-end systems.

Cc: Hui Wang <jason77.wang@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
[mkl: convert to incremental patch]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes since v3:
- convert to incremental patch
- update mx6 glitch filter information
---
Hello Wolfgang,

I've converted your patch so that it can be applied to current net, where David
already accepted your v1 version of the patch.

cheers, Marc

 drivers/net/can/flexcan.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index c78ecfc..a412bf6 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -144,9 +144,22 @@
 
 #define FLEXCAN_MB_CODE_MASK		(0xf0ffffff)
 
-/* FLEXCAN hardware feature flags */
+/*
+ * FLEXCAN hardware feature flags
+ *
+ * Below is some version info we got:
+ *    SOC   Version   IP-Version  Glitch-  [TR]WRN_INT
+ *                                Filter?   connected?
+ *   MX25  FlexCAN2  03.00.00.00     no         no
+ *   MX28  FlexCAN2  03.00.04.00    yes        yes
+ *   MX35  FlexCAN2  03.00.00.00     no         no
+ *   MX53  FlexCAN2  03.00.00.00    yes         no
+ *   MX6s  FlexCAN3  10.00.12.00    yes        yes
+ *
+ * Some SOCs do not have the RX_WARN & TX_WARN interrupt line connected.
+ */
 #define FLEXCAN_HAS_V10_FEATURES	BIT(1) /* For core version >= 10 */
-#define FLEXCAN_HAS_BROKEN_ERR_STATE	BIT(2) /* Broken error state handling */
+#define FLEXCAN_HAS_BROKEN_ERR_STATE	BIT(2) /* [TR]WRN_INT not connected */
 
 /* Structure of the message buffer */
 struct flexcan_mb {
@@ -205,7 +218,7 @@ static struct flexcan_devtype_data fsl_p1010_devtype_data = {
 };
 static struct flexcan_devtype_data fsl_imx28_devtype_data;
 static struct flexcan_devtype_data fsl_imx6q_devtype_data = {
-	.features = FLEXCAN_HAS_V10_FEATURES | FLEXCAN_HAS_BROKEN_ERR_STATE,
+	.features = FLEXCAN_HAS_V10_FEATURES,
 };
 
 static const struct can_bittiming_const flexcan_bittiming_const = {
-- 
1.7.10

