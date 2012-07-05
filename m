From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: [PATCH 1/2] can: add can_cmp_echo_skb() for echo skb comparison
Date: Thu,  5 Jul 2012 13:58:27 -0700
Message-ID: <1341521908-11454-2-git-send-email-iws@ovro.caltech.edu>
References: <1341521908-11454-1-git-send-email-iws@ovro.caltech.edu>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ovro.ovro.caltech.edu ([192.100.16.2]:48738 "EHLO
	ovro.ovro.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727Ab2GEU6d (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Jul 2012 16:58:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by ovro.ovro.caltech.edu (Postfix) with ESMTP id 9442A2229B
	for <linux-can@vger.kernel.org>; Thu,  5 Jul 2012 13:58:33 -0700 (PDT)
In-Reply-To: <1341521908-11454-1-git-send-email-iws@ovro.caltech.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

This function allows drivers to compare an incoming skb against the echo
skb stack. On CAN hardware which has support for hardware loopback, this
allows drivers to support the CAN_RAW_RECV_OWN_MSGS flag correctly.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 drivers/net/can/dev.c   |   34 ++++++++++++++++++++++++++++++++++
 include/linux/can/dev.h |    2 ++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index c5fe3a3..a6c5076 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -348,6 +348,40 @@ unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx)
 EXPORT_SYMBOL_GPL(can_get_echo_skb);
 
 /*
+ * Compare an skb with an existing echo skb
+ *
+ * This function will be used on devices which have a hardware loopback.
+ * On these devices, this function can be used to compare a received skb
+ * with the saved echo skbs so that the hardware echo skb can be dropped.
+ *
+ * Returns true if the skb's are identical, false otherwise.
+ */
+bool can_cmp_echo_skb(struct sk_buff *skb, struct net_device *dev,
+		      unsigned int idx)
+{
+	struct can_priv *priv = netdev_priv(dev);
+	struct can_frame *cf = (struct can_frame *)skb->data;
+
+	BUG_ON(idx >= priv->echo_skb_max);
+
+	if (priv->echo_skb[idx]) {
+		struct sk_buff *echo_skb = priv->echo_skb[idx];
+		struct can_frame *echo_cf = (struct can_frame *)echo_skb->data;
+
+		if (cf->can_id != echo_cf->can_id)
+			return false;
+
+		if (cf->can_dlc != echo_cf->can_dlc)
+			return false;
+
+		return memcmp(cf->data, echo_cf->data, cf->can_dlc) == 0;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(can_cmp_echo_skb);
+
+/*
   * Remove the skb from the stack and free it.
   *
   * The function is typically called when TX failed.
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 5d2efe7..904a938 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -93,6 +93,8 @@ void can_bus_off(struct net_device *dev);
 void can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 		      unsigned int idx);
 unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx);
+bool can_cmp_echo_skb(struct sk_buff *skb, struct net_device *dev,
+		      unsigned int idx);
 void can_free_echo_skb(struct net_device *dev, unsigned int idx);
 
 struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf);
-- 
1.7.3.4

