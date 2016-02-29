From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can-calc-bit-timing: better bitrate calculcation
Date: Mon, 29 Feb 2016 15:13:08 +0100
Message-ID: <1456755188-28938-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60562 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750772AbcB2ONQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 29 Feb 2016 09:13:16 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: ramesh.shanmugasundaram@bp.renesas.com
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---

This is work-in-progress. I've to port the current algorithm from the kernel
here, than rebase the algorithm ontop, than port the algorithm to the kernel.

Marc

 can-calc-bit-timing.c | 109 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 69 insertions(+), 40 deletions(-)

diff --git a/can-calc-bit-timing.c b/can-calc-bit-timing.c
index 77f133311c27..4eeac554f022 100644
--- a/can-calc-bit-timing.c
+++ b/can-calc-bit-timing.c
@@ -1,6 +1,7 @@
 /* can-calc-bit-timing.c: Calculate CAN bit timing parameters
  *
  * Copyright (C) 2008 Wolfgang Grandegger <wg@grandegger.com>
+ * Copyright (C) 2016 Marc Kleine-Budde <mkl@pengutronix.de>
  *
  * Derived from:
  *   can_baud.c - CAN baudrate calculation
@@ -523,32 +524,57 @@ static long common_bitrates[] = {
 };
 
 #define CAN_CALC_MAX_ERROR 50 /* in one-tenth of a percent */
+#define SYNC_SEG 1
 
 static int can_update_spt(const struct can_bittiming_const *btc,
-			  int sampl_pt, int tseg, int *tseg1, int *tseg2)
+		unsigned int sampl_pt, unsigned int tseg,
+		unsigned int *tseg1_ptr, unsigned int *tseg2_ptr,
+		unsigned int *spt_error_ptr)
 {
-	*tseg2 = tseg + 1 - (sampl_pt * (tseg + 1)) / 1000;
-	if (*tseg2 < btc->tseg2_min)
-		*tseg2 = btc->tseg2_min;
-	if (*tseg2 > btc->tseg2_max)
-		*tseg2 = btc->tseg2_max;
-	*tseg1 = tseg - *tseg2;
-	if (*tseg1 > btc->tseg1_max) {
-		*tseg1 = btc->tseg1_max;
-		*tseg2 = tseg - *tseg1;
+	unsigned int spt_error, best_spt_error = 1000;
+	unsigned int spt, best_spt = 0;
+	unsigned int tseg1, tseg2;
+	int i;
+
+	for (i = 0; i <= 1; i++) {
+		tseg2 = tseg + SYNC_SEG - (sampl_pt * (tseg + SYNC_SEG)) / 1000 - i;
+		tseg2 = clamp(tseg2, btc->tseg2_min, btc->tseg2_max);
+		tseg1 = tseg - tseg2;
+		if (tseg1 > btc->tseg1_max) {
+			tseg1 = btc->tseg1_max;
+			tseg2 = tseg - tseg1;
+		}
+
+		spt = 1000 * (tseg + SYNC_SEG - tseg2) / (tseg + SYNC_SEG);
+		spt_error = abs(((long)sampl_pt - (long)spt));
+
+		if (spt_error < best_spt_error) {
+			best_spt = spt;
+			best_spt_error = spt_error;
+			*tseg1_ptr = tseg1;
+			*tseg2_ptr = tseg2;
+		}
 	}
-	return 1000 * (tseg + 1 - *tseg2) / (tseg + 1);
+
+	if (spt_error_ptr)
+		*spt_error_ptr = best_spt_error;
+
+	return best_spt;
 }
 
 static int can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt)
 {
 	struct can_priv *priv = netdev_priv(dev);
 	const struct can_bittiming_const *btc = priv->bittiming_const;
-	long rate = 0;
-	long best_error = 1000000000, error = 0;
-	int best_tseg = 0, best_brp = 0, brp = 0;
-	int tsegall, tseg = 0, tseg1 = 0, tseg2 = 0;
-	int spt_error = 1000, spt = 0, sampl_pt;
+	long rate;		/* current bitrate */
+	long rate_error;	/* difference between current and target value */
+	long best_rate_error = 1000000000L;
+	unsigned int spt_error;	/* difference between current and target value */
+	unsigned int best_spt_error = 1000;
+	unsigned int sampl_pt;	/* target sample point */
+	unsigned int best_tseg = 0;	/* current best value for tseg */
+	unsigned int best_brp = 0;	/* current best value for brp */
+	unsigned int brp, tsegall, tseg, tseg1, tseg2;
 	u64 v64;
 
 	if (!priv->bittiming_const)
@@ -569,54 +595,57 @@ static int can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt)
 	/* tseg even = round down, odd = round up */
 	for (tseg = (btc->tseg1_max + btc->tseg2_max) * 2 + 1;
 	     tseg >= (btc->tseg1_min + btc->tseg2_min) * 2; tseg--) {
-		tsegall = 1 + tseg / 2;
+		tsegall = SYNC_SEG + tseg / 2;
+
 		/* Compute all possible tseg choices (tseg=tseg1+tseg2) */
 		brp = priv->clock.freq / (tsegall * bt->bitrate) + tseg % 2;
+
 		/* chose brp step which is possible in system */
 		brp = (brp / btc->brp_inc) * btc->brp_inc;
 		if ((brp < btc->brp_min) || (brp > btc->brp_max))
 			continue;
+
 		rate = priv->clock.freq / (brp * tsegall);
-		error = bt->bitrate - rate;
+		rate_error = abs((long)(bt->bitrate - rate));
+
 		/* tseg brp biterror */
-		if (error < 0)
-			error = -error;
-		if (error > best_error)
+		if (rate_error > best_rate_error)
 			continue;
-		best_error = error;
-		if (error == 0) {
-			spt = can_update_spt(btc, sampl_pt, tseg / 2,
-					     &tseg1, &tseg2);
-			error = sampl_pt - spt;
-			if (error < 0)
-				error = -error;
-			if (error > spt_error)
-				continue;
-			spt_error = error;
-		}
+
+		/* reset sample point error if we have a better bitrate */
+		if (rate_error < best_rate_error)
+			best_spt_error = 1000;
+
+		can_update_spt(btc, sampl_pt, tseg / 2, &tseg1, &tseg2, &spt_error);
+		if (spt_error > best_spt_error)
+			continue;
+
+		best_spt_error = spt_error;
+		best_rate_error = rate_error;
 		best_tseg = tseg / 2;
 		best_brp = brp;
-		if (error == 0)
+
+		if (rate_error == 0 && spt_error == 0)
 			break;
 	}
 
-	if (best_error) {
+	if (best_rate_error) {
 		/* Error in one-tenth of a percent */
-		error = (best_error * 1000) / bt->bitrate;
-		if (error > CAN_CALC_MAX_ERROR) {
+		rate_error = (best_rate_error * 1000) / bt->bitrate;
+		if (rate_error > CAN_CALC_MAX_ERROR) {
 			dev_err(dev->dev.parent,
 				"bitrate error %ld.%ld%% too high\n",
-				error / 10, error % 10);
+				rate_error / 10, rate_error % 10);
 			return -EDOM;
 		} else {
 			dev_warn(dev->dev.parent, "bitrate error %ld.%ld%%\n",
-				 error / 10, error % 10);
+				 rate_error / 10, rate_error % 10);
 		}
 	}
 
 	/* real sample point */
 	bt->sample_point = can_update_spt(btc, sampl_pt, best_tseg,
-					  &tseg1, &tseg2);
+					  &tseg1, &tseg2, NULL);
 
 	v64 = (u64)best_brp * 1000000000UL;
 	do_div(v64, priv->clock.freq);
@@ -628,7 +657,7 @@ static int can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt)
 	bt->brp = best_brp;
 
 	/* real bit-rate */
-	bt->bitrate = priv->clock.freq / (bt->brp * (tseg1 + tseg2 + 1));
+	bt->bitrate = priv->clock.freq / (bt->brp * (SYNC_SEG + tseg1 + tseg2));
 
 	return 0;
 }
-- 
2.7.0

