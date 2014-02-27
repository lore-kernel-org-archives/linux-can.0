From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v6 4/7] can: provide a separate bittiming_const parameter to bittiming functions
Date: Thu, 27 Feb 2014 19:15:09 +0100
Message-ID: <1393524912-12970-5-git-send-email-socketcan@hartkopp.net>
References: <1393524912-12970-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:54946 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753762AbaB0SPY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 27 Feb 2014 13:15:24 -0500
In-Reply-To: <1393524912-12970-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

As the bittiming calculation functions are to be used with different
bittiming_const structures for CAN and CAN FD the direct reference to
priv->bittiming_const inside these functions has to be removed.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 89fc798..7a355aa 100644
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
@@ -110,7 +110,7 @@ static int can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt)
 	int spt_error = 1000, spt = 0, sampl_pt;
 	u64 v64;
 
-	if (!priv->bittiming_const)
+	if (!btc)
 		return -ENOTSUPP;
 
 	/* Use CIA recommended sample points */
@@ -204,7 +204,8 @@ static int can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt)
 	return 0;
 }
 #else /* !CONFIG_CAN_CALC_BITTIMING */
-static int can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt)
+static int can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt,
+			      const struct can_bittiming_const *btc)
 {
 	netdev_err(dev, "bit-timing calculation not available\n");
 	return -EINVAL;
@@ -217,14 +218,14 @@ static int can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt)
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
+	if (!btc)
 		return -ENOTSUPP;
 
 	tseg1 = bt->prop_seg + bt->phase_seg1;
@@ -254,25 +255,25 @@ static int can_fixup_bittiming(struct net_device *dev, struct can_bittiming *bt)
 	return 0;
 }
 
-static int can_get_bittiming(struct net_device *dev, struct can_bittiming *bt)
+static int can_get_bittiming(struct net_device *dev, struct can_bittiming *bt,
+			     const struct can_bittiming_const *btc)
 {
-	struct can_priv *priv = netdev_priv(dev);
 	int err;
 
 	/* Check if the CAN device has bit-timing parameters */
-	if (priv->bittiming_const) {
+	if (btc) {
 
 		/* Non-expert mode? Check if the bitrate has been pre-defined */
 		if (!bt->tq) {
 			/* Determine bit-timing parameters */
 			if (bt->bitrate)
-				err = can_calc_bittiming(dev, bt);
+				err = can_calc_bittiming(dev, bt, btc);
 			else
 				return -EINVAL;
 		} else {
 			/* Check bit-timing params and calculate proper brp */
 			if (!bt->bitrate)
-				err = can_fixup_bittiming(dev, bt);
+				err = can_fixup_bittiming(dev, bt, btc);
 			else
 				return -EINVAL;
 		}
@@ -674,7 +675,7 @@ static int can_changelink(struct net_device *dev,
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

