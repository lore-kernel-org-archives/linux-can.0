From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v11 2/7] can: only send bitrate data via netlink when available
Date: Tue,  4 Mar 2014 23:00:12 +0100
Message-ID: <1393970417-15399-3-git-send-email-mkl@pengutronix.de>
References: <1393970417-15399-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45785 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755189AbaCDWAW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Mar 2014 17:00:22 -0500
In-Reply-To: <1393970417-15399-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Oliver Hartkopp <socketcan@hartkopp.net>

When setting the bitrate both can_calc_bittiming() and can_fixup_bittiming()
lead to the bitrate variable to be set, when a proper bit timing is available.
Only then the bitrate configuration is stored for the device, so checking for
priv->bittiming.bitrate is always sufficient.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index e1a3741..de04eac 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -606,7 +606,7 @@ int open_candev(struct net_device *dev)
 {
 	struct can_priv *priv = netdev_priv(dev);
 
-	if (!priv->bittiming.tq && !priv->bittiming.bitrate) {
+	if (!priv->bittiming.bitrate) {
 		netdev_err(dev, "bit-timing not yet defined\n");
 		return -EINVAL;
 	}
@@ -719,7 +719,8 @@ static size_t can_get_size(const struct net_device *dev)
 	struct can_priv *priv = netdev_priv(dev);
 	size_t size = 0;
 
-	size += nla_total_size(sizeof(struct can_bittiming));	/* IFLA_CAN_BITTIMING */
+	if (priv->bittiming.bitrate)				/* IFLA_CAN_BITTIMING */
+		size += nla_total_size(sizeof(struct can_bittiming));
 	if (priv->bittiming_const)				/* IFLA_CAN_BITTIMING_CONST */
 		size += nla_total_size(sizeof(struct can_bittiming_const));
 	size += nla_total_size(sizeof(struct can_clock));	/* IFLA_CAN_CLOCK */
@@ -741,8 +742,9 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 
 	if (priv->do_get_state)
 		priv->do_get_state(dev, &state);
-	if (nla_put(skb, IFLA_CAN_BITTIMING,
-		    sizeof(priv->bittiming), &priv->bittiming) ||
+	if ((priv->bittiming.bitrate &&
+	     nla_put(skb, IFLA_CAN_BITTIMING,
+		     sizeof(priv->bittiming), &priv->bittiming)) ||
 	    (priv->bittiming_const &&
 	     nla_put(skb, IFLA_CAN_BITTIMING_CONST,
 		     sizeof(*priv->bittiming_const), priv->bittiming_const)) ||
-- 
1.9.0

