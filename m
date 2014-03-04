From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v10 3/7] can: move sanity check for bitrate and tq into can_get_bittiming
Date: Tue,  4 Mar 2014 21:44:11 +0100
Message-ID: <1393965855-3408-4-git-send-email-mkl@pengutronix.de>
References: <1393965855-3408-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54689 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932784AbaCDUoU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Mar 2014 15:44:20 -0500
In-Reply-To: <1393965855-3408-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Oliver Hartkopp <socketcan@hartkopp.net>

This patch moves a sanity check in order to have a second user for CAN FD.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index de04eac..e5f1faf 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -260,20 +260,23 @@ static int can_get_bittiming(struct net_device *dev, struct can_bittiming *bt)
 	int err;
 
 	/* Check if the CAN device has bit-timing parameters */
-	if (priv->bittiming_const) {
+	if (!priv->bittiming_const)
+		return 0;
 
-		/* Non-expert mode? Check if the bitrate has been pre-defined */
-		if (!bt->tq)
-			/* Determine bit-timing parameters */
-			err = can_calc_bittiming(dev, bt);
-		else
-			/* Check bit-timing params and calculate proper brp */
-			err = can_fixup_bittiming(dev, bt);
-		if (err)
-			return err;
-	}
+	/*
+	 * Depending on the given can_bittiming parameter structure the CAN
+	 * timing parameters are calculated based on the provided bitrate OR
+	 * alternatively the CAN timing parameters (tq, prop_seg, etc.) are
+	 * provided directly which are then checked and fixed up.
+	 */
+	if (!bt->tq && bt->bitrate)
+		err = can_calc_bittiming(dev, bt);
+	else if (bt->tq && !bt->bitrate)
+		err = can_fixup_bittiming(dev, bt);
+	else
+		err = -EINVAL;
 
-	return 0;
+	return err;
 }
 
 /*
@@ -667,8 +670,6 @@ static int can_changelink(struct net_device *dev,
 		if (dev->flags & IFF_UP)
 			return -EBUSY;
 		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
-		if ((!bt.bitrate && !bt.tq) || (bt.bitrate && bt.tq))
-			return -EINVAL;
 		err = can_get_bittiming(dev, &bt);
 		if (err)
 			return err;
-- 
1.9.0

