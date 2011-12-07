From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [RFC PATCH 05/14] can: add error counters to the data fields of any CAN error message
Date: Wed,  7 Dec 2011 15:55:19 +0100
Message-ID: <1323269728-17491-6-git-send-email-wg@grandegger.com>
References: <1323269728-17491-1-git-send-email-wg@grandegger.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:49261 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756273Ab1LGOzk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Dec 2011 09:55:40 -0500
In-Reply-To: <1323269728-17491-1-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: socketcan-users@lists.berlios.de, Wolfgang Grandegger <wg@grandegger.com>

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/dev.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index ac4ac92..400d871 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -476,6 +476,7 @@ EXPORT_SYMBOL_GPL(alloc_can_skb);
 
 struct sk_buff *alloc_can_err_skb(struct net_device *dev, struct can_frame **cf)
 {
+	struct can_priv *priv = netdev_priv(dev);
 	struct sk_buff *skb;
 
 	skb = alloc_can_skb(dev, cf);
@@ -485,6 +486,16 @@ struct sk_buff *alloc_can_err_skb(struct net_device *dev, struct can_frame **cf)
 	(*cf)->can_id = CAN_ERR_FLAG;
 	(*cf)->can_dlc = CAN_ERR_DLC;
 
+	/* For each message, add TX and RX error counters */
+	if (priv->do_get_berr_counter) {
+		struct can_berr_counter bec;
+
+		if (!priv->do_get_berr_counter(dev, &bec)) {
+			(*cf)->data[6] = bec.txerr;
+			(*cf)->data[7] = bec.rxerr;
+		}
+	}
+
 	return skb;
 }
 EXPORT_SYMBOL_GPL(alloc_can_err_skb);
-- 
1.7.4.1

