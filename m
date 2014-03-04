From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v11 4/7] can: provide a separate bittiming_const parameter to bittiming functions
Date: Tue,  4 Mar 2014 23:00:14 +0100
Message-ID: <1393970417-15399-5-git-send-email-mkl@pengutronix.de>
References: <1393970417-15399-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45789 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755317AbaCDWAX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Mar 2014 17:00:23 -0500
In-Reply-To: <1393970417-15399-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Oliver Hartkopp <socketcan@hartkopp.net>

As the bittiming calculation functions are to be used with different
bittiming_const structures for CAN and CAN FD the direct reference to
priv->bittiming_const inside these functions has to be removed.

Also simplify the return value generation in can_get_bittiming() as only
correct return values of can_[calc|fixup]_bittiming() lead to a return value
of zero. And moved the check for existing bittiming const to one place.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index e5f1faf..8141290 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -99,10 +99,10 @@ static int can_update_spt(const struct can_bittiming_const *btc,
 	return 1000 * (tseg + 1 - *tseg2) / (tseg + 1);
 }
 
-static int can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt)
+static int can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt,
+			      const struct can_bittiming_const *btc)
 {
 	struct can_priv *priv = netdev_priv(dev);
-	const struct can_bittiming_const *btc = priv->bittiming_const;
 	long rate, best_rate = 0;
 	long best_error = 1000000000, error = 0;
 	int best_tseg = 0, best_brp = 0, brp = 0;
@@ -110,9 +110,6 @@ static int can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt)
 	int spt_error = 1000, spt = 0, sampl_pt;
 	u64 v64;
 
-	if (!priv->bittiming_const)
-		return -ENOTSUPP;
-
 	/* Use CIA recommended sample points */
 	if (bt->sample_point) {
 		sampl_pt = bt->sample_point;
@@ -204,7 +201,8 @@ static int can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt)
 	return 0;
 }
 #else /* !CONFIG_CAN_CALC_BITTIMING */
-static int can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt)
+static int can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt,
+			      const struct can_bittiming_const *btc)
 {
 	netdev_err(dev, "bit-timing calculation not available\n");
 	return -EINVAL;
@@ -217,16 +215,13 @@ static int can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt)
  * prescaler value brp. You can find more information in the header
  * file linux/can/netlink.h.
  */
-static int can_fixup_bittiming(struct net_device *dev, struct can_bittiming *bt)
+static int can_fixup_bittiming(struct net_device *dev, struct can_bittiming *bt,
+			       const struct can_bittiming_const *btc)
 {
 	struct can_priv *priv = netdev_priv(dev);
-	const struct can_bittiming_const *btc = priv->bittiming_const;
 	int tseg1, alltseg;
 	u64 brp64;
 
-	if (!priv->bittiming_const)
-		return -ENOTSUPP;
-
 	tseg1 = bt->prop_seg + bt->phase_seg1;
 	if (!bt->sjw)
 		bt->sjw = 1;
@@ -254,14 +249,14 @@ static int can_fixup_bittiming(struct net_device *dev, struct can_bittiming *bt)
 	return 0;
 }
 
-static int can_get_bittiming(struct net_device *dev, struct can_bittiming *bt)
+static int can_get_bittiming(struct net_device *dev, struct can_bittiming *bt,
+			     const struct can_bittiming_const *btc)
 {
-	struct can_priv *priv = netdev_priv(dev);
 	int err;
 
 	/* Check if the CAN device has bit-timing parameters */
-	if (!priv->bittiming_const)
-		return 0;
+	if (!btc)
+		return -ENOTSUPP;
 
 	/*
 	 * Depending on the given can_bittiming parameter structure the CAN
@@ -270,9 +265,9 @@ static int can_get_bittiming(struct net_device *dev, struct can_bittiming *bt)
 	 * provided directly which are then checked and fixed up.
 	 */
 	if (!bt->tq && bt->bitrate)
-		err = can_calc_bittiming(dev, bt);
+		err = can_calc_bittiming(dev, bt, btc);
 	else if (bt->tq && !bt->bitrate)
-		err = can_fixup_bittiming(dev, bt);
+		err = can_fixup_bittiming(dev, bt, btc);
 	else
 		err = -EINVAL;
 
@@ -670,7 +665,7 @@ static int can_changelink(struct net_device *dev,
 		if (dev->flags & IFF_UP)
 			return -EBUSY;
 		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
-		err = can_get_bittiming(dev, &bt);
+		err = can_get_bittiming(dev, &bt, priv->bittiming_const);
 		if (err)
 			return err;
 		memcpy(&priv->bittiming, &bt, sizeof(bt));
-- 
1.9.0

