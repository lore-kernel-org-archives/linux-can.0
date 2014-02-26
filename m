From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v5 2/6] can: only send bitrate data via netlink when available
Date: Wed, 26 Feb 2014 23:10:58 +0100
Message-ID: <1393452662-3154-3-git-send-email-socketcan@hartkopp.net>
References: <1393452662-3154-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:47691 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607AbaBZWL1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Feb 2014 17:11:27 -0500
In-Reply-To: <1393452662-3154-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

When setting the bitrate both can_calc_bittiming() and can_fixup_bittiming()
lead to the bitrate and the tq variable to be set, when a proper bit timing
is available.

This patch introduces a helper function and only provides the bit timing via
netlink when it's set properly.

This is also a preparation for the CAN FD specific bittiming configurations
which are not existing in non-FD drivers.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index e1a3741..e88934c 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -597,6 +597,16 @@ void free_candev(struct net_device *dev)
 EXPORT_SYMBOL_GPL(free_candev);
 
 /*
+ * When setting the bitrate both can_calc_bittiming() and can_fixup_bittiming()
+ * lead to the bitrate and the tq variable to be set, when a proper bit timing
+ * is available.
+ */
+static inline int candev_has_bitrate(struct can_bittiming *bt)
+{
+	return (bt->bitrate && bt->tq);
+}
+
+/*
  * Common open function when the device gets opened.
  *
  * This function should be called in the open function of the device
@@ -606,7 +616,7 @@ int open_candev(struct net_device *dev)
 {
 	struct can_priv *priv = netdev_priv(dev);
 
-	if (!priv->bittiming.tq && !priv->bittiming.bitrate) {
+	if (!candev_has_bitrate(&priv->bittiming)) {
 		netdev_err(dev, "bit-timing not yet defined\n");
 		return -EINVAL;
 	}
@@ -719,7 +729,8 @@ static size_t can_get_size(const struct net_device *dev)
 	struct can_priv *priv = netdev_priv(dev);
 	size_t size = 0;
 
-	size += nla_total_size(sizeof(struct can_bittiming));	/* IFLA_CAN_BITTIMING */
+	if (candev_has_bitrate(&priv->bittiming))		/* IFLA_CAN_BITTIMING */
+		size += nla_total_size(sizeof(struct can_bittiming));
 	if (priv->bittiming_const)				/* IFLA_CAN_BITTIMING_CONST */
 		size += nla_total_size(sizeof(struct can_bittiming_const));
 	size += nla_total_size(sizeof(struct can_clock));	/* IFLA_CAN_CLOCK */
@@ -741,15 +752,20 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 
 	if (priv->do_get_state)
 		priv->do_get_state(dev, &state);
-	if (nla_put(skb, IFLA_CAN_BITTIMING,
-		    sizeof(priv->bittiming), &priv->bittiming) ||
+
+	if ((candev_has_bitrate(&priv->bittiming) &&
+	     nla_put(skb, IFLA_CAN_BITTIMING,
+		     sizeof(priv->bittiming), &priv->bittiming)) ||
+
 	    (priv->bittiming_const &&
 	     nla_put(skb, IFLA_CAN_BITTIMING_CONST,
 		     sizeof(*priv->bittiming_const), priv->bittiming_const)) ||
+
 	    nla_put(skb, IFLA_CAN_CLOCK, sizeof(cm), &priv->clock) ||
 	    nla_put_u32(skb, IFLA_CAN_STATE, state) ||
 	    nla_put(skb, IFLA_CAN_CTRLMODE, sizeof(cm), &cm) ||
 	    nla_put_u32(skb, IFLA_CAN_RESTART_MS, priv->restart_ms) ||
+
 	    (priv->do_get_berr_counter &&
 	     !priv->do_get_berr_counter(dev, &bec) &&
 	     nla_put(skb, IFLA_CAN_BERR_COUNTER, sizeof(bec), &bec)))
-- 
1.9.0

