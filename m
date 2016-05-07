From: Marek Vasut <marex@denx.de>
Subject: [PATCH 2/6] net: can: ifi: Update timing configuration code
Date: Sun,  8 May 2016 00:34:12 +0200
Message-ID: <1462660456-6179-2-git-send-email-marex@denx.de>
References: <1462660456-6179-1-git-send-email-marex@denx.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:33738 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbcEGWef (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 7 May 2016 18:34:35 -0400
In-Reply-To: <1462660456-6179-1-git-send-email-marex@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>, Marc Kleine-Budde <mkl@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>

The updated documentation regarding the IFI CANFD core from April 2016
adds more details regarding the timing calculation. There is no longer
any distinction in the timing calculation between CANFD and CAN2.0, but
instead there are two timing modes -- 4_12_6_6 and 7_9_8_8 -- where the
numbers mean the width in bits of the SJW/Prescaler/TimeA/TimeB fields.
The code uses 7_9_8_8 mode, which allows more fine-grained control over
the timing.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/ifi_canfd/ifi_canfd.c | 54 ++++++++++++++---------------------
 1 file changed, 21 insertions(+), 33 deletions(-)

diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index 1ad05f1..b9efd6e 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -34,6 +34,7 @@
 #define IFI_CANFD_STCMD_LOOPBACK		BIT(18)
 #define IFI_CANFD_STCMD_DISABLE_CANFD		BIT(24)
 #define IFI_CANFD_STCMD_ENABLE_ISO		BIT(25)
+#define IFI_CANFD_STCMD_ENABLE_7_9_8_8_TIMING	BIT(26)
 #define IFI_CANFD_STCMD_NORMAL_MODE		((u32)BIT(31))
 
 #define IFI_CANFD_RXSTCMD			0x4
@@ -71,12 +72,12 @@
 #define IFI_CANFD_TIME_TIMEB_OFF		0
 #define IFI_CANFD_TIME_TIMEA_OFF		8
 #define IFI_CANFD_TIME_PRESCALE_OFF		16
-#define IFI_CANFD_TIME_SJW_OFF_ISO		25
-#define IFI_CANFD_TIME_SJW_OFF_BOSCH		28
-#define IFI_CANFD_TIME_SET_SJW_BOSCH		BIT(6)
-#define IFI_CANFD_TIME_SET_TIMEB_BOSCH		BIT(7)
-#define IFI_CANFD_TIME_SET_PRESC_BOSCH		BIT(14)
-#define IFI_CANFD_TIME_SET_TIMEA_BOSCH		BIT(15)
+#define IFI_CANFD_TIME_SJW_OFF_7_9_8_8		25
+#define IFI_CANFD_TIME_SJW_OFF_4_12_6_6		28
+#define IFI_CANFD_TIME_SET_SJW_4_12_6_6		BIT(6)
+#define IFI_CANFD_TIME_SET_TIMEB_4_12_6_6	BIT(7)
+#define IFI_CANFD_TIME_SET_PRESC_4_12_6_6	BIT(14)
+#define IFI_CANFD_TIME_SET_TIMEA_4_12_6_6	BIT(15)
 
 #define IFI_CANFD_TDELAY			0x1c
 
@@ -534,24 +535,24 @@ static irqreturn_t ifi_canfd_isr(int irq, void *dev_id)
 static const struct can_bittiming_const ifi_canfd_bittiming_const = {
 	.name		= KBUILD_MODNAME,
 	.tseg1_min	= 1,	/* Time segment 1 = prop_seg + phase_seg1 */
-	.tseg1_max	= 64,
+	.tseg1_max	= 256,
 	.tseg2_min	= 2,	/* Time segment 2 = phase_seg2 */
-	.tseg2_max	= 64,
-	.sjw_max	= 16,
+	.tseg2_max	= 256,
+	.sjw_max	= 128,
 	.brp_min	= 2,
-	.brp_max	= 256,
+	.brp_max	= 512,
 	.brp_inc	= 1,
 };
 
 static const struct can_bittiming_const ifi_canfd_data_bittiming_const = {
 	.name		= KBUILD_MODNAME,
 	.tseg1_min	= 1,	/* Time segment 1 = prop_seg + phase_seg1 */
-	.tseg1_max	= 64,
+	.tseg1_max	= 256,
 	.tseg2_min	= 2,	/* Time segment 2 = phase_seg2 */
-	.tseg2_max	= 64,
-	.sjw_max	= 16,
+	.tseg2_max	= 256,
+	.sjw_max	= 128,
 	.brp_min	= 2,
-	.brp_max	= 256,
+	.brp_max	= 512,
 	.brp_inc	= 1,
 };
 
@@ -561,19 +562,6 @@ static void ifi_canfd_set_bittiming(struct net_device *ndev)
 	const struct can_bittiming *bt = &priv->can.bittiming;
 	const struct can_bittiming *dbt = &priv->can.data_bittiming;
 	u16 brp, sjw, tseg1, tseg2;
-	u32 noniso_arg = 0;
-	u32 time_off;
-
-	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) &&
-	    !(priv->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO)) {
-		time_off = IFI_CANFD_TIME_SJW_OFF_ISO;
-	} else {
-		noniso_arg = IFI_CANFD_TIME_SET_TIMEB_BOSCH |
-			     IFI_CANFD_TIME_SET_TIMEA_BOSCH |
-			     IFI_CANFD_TIME_SET_PRESC_BOSCH |
-			     IFI_CANFD_TIME_SET_SJW_BOSCH;
-		time_off = IFI_CANFD_TIME_SJW_OFF_BOSCH;
-	}
 
 	/* Configure bit timing */
 	brp = bt->brp - 2;
@@ -583,8 +571,7 @@ static void ifi_canfd_set_bittiming(struct net_device *ndev)
 	writel((tseg2 << IFI_CANFD_TIME_TIMEB_OFF) |
 	       (tseg1 << IFI_CANFD_TIME_TIMEA_OFF) |
 	       (brp << IFI_CANFD_TIME_PRESCALE_OFF) |
-	       (sjw << time_off) |
-	       noniso_arg,
+	       (sjw << IFI_CANFD_TIME_SJW_OFF_7_9_8_8),
 	       priv->base + IFI_CANFD_TIME);
 
 	/* Configure data bit timing */
@@ -595,8 +582,7 @@ static void ifi_canfd_set_bittiming(struct net_device *ndev)
 	writel((tseg2 << IFI_CANFD_TIME_TIMEB_OFF) |
 	       (tseg1 << IFI_CANFD_TIME_TIMEA_OFF) |
 	       (brp << IFI_CANFD_TIME_PRESCALE_OFF) |
-	       (sjw << time_off) |
-	       noniso_arg,
+	       (sjw << IFI_CANFD_TIME_SJW_OFF_7_9_8_8),
 	       priv->base + IFI_CANFD_FTIME);
 }
 
@@ -641,7 +627,8 @@ static void ifi_canfd_start(struct net_device *ndev)
 
 	/* Reset the IP */
 	writel(IFI_CANFD_STCMD_HARDRESET, priv->base + IFI_CANFD_STCMD);
-	writel(0, priv->base + IFI_CANFD_STCMD);
+	writel(IFI_CANFD_STCMD_ENABLE_7_9_8_8_TIMING,
+	       priv->base + IFI_CANFD_STCMD);
 
 	ifi_canfd_set_bittiming(ndev);
 	ifi_canfd_set_filters(ndev);
@@ -660,7 +647,8 @@ static void ifi_canfd_start(struct net_device *ndev)
 	writel((u32)(~IFI_CANFD_INTERRUPT_SET_IRQ),
 	       priv->base + IFI_CANFD_INTERRUPT);
 
-	stcmd = IFI_CANFD_STCMD_ENABLE | IFI_CANFD_STCMD_NORMAL_MODE;
+	stcmd = IFI_CANFD_STCMD_ENABLE | IFI_CANFD_STCMD_NORMAL_MODE |
+		IFI_CANFD_STCMD_ENABLE_7_9_8_8_TIMING;
 
 	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
 		stcmd |= IFI_CANFD_STCMD_BUSMONITOR;
-- 
2.7.0

