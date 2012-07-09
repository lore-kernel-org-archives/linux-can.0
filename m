From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: [PATCH 1/3] can: make the echo stack keep packet information longer
Date: Mon,  9 Jul 2012 12:56:28 -0700
Message-ID: <1341863790-5645-2-git-send-email-iws@ovro.caltech.edu>
References: <1341863790-5645-1-git-send-email-iws@ovro.caltech.edu>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ovro.ovro.caltech.edu ([192.100.16.2]:53239 "EHLO
	ovro.ovro.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768Ab2GIT4c (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Jul 2012 15:56:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by ovro.ovro.caltech.edu (Postfix) with ESMTP id 38DE9222F3
	for <linux-can@vger.kernel.org>; Mon,  9 Jul 2012 12:56:32 -0700 (PDT)
In-Reply-To: <1341863790-5645-1-git-send-email-iws@ovro.caltech.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: "Ira W. Snyder" <iws@ovro.caltech.edu>

From: "Ira W. Snyder" <iws@ovro.caltech.edu>

In order for the can_cmp_echo_skb() function to be able to detect
packets received via the hardware loopback feature, all packets must be
saved. This means we cannot drop non-loopback packets until reception
time.
---
 drivers/net/can/dev.c |   41 +++++++++++++++++++++--------------------
 1 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index c5fe3a3..98e6c50 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -282,12 +282,6 @@ void can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 
 	BUG_ON(idx >= priv->echo_skb_max);
 
-	/* check flag whether this packet has to be looped back */
-	if (!(dev->flags & IFF_ECHO) || skb->pkt_type != PACKET_LOOPBACK) {
-		kfree_skb(skb);
-		return;
-	}
-
 	if (!priv->echo_skb[idx]) {
 		struct sock *srcsk = skb->sk;
 
@@ -303,12 +297,6 @@ void can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 
 		skb->sk = srcsk;
 
-		/* make settings for echo to reduce code in irq context */
-		skb->protocol = htons(ETH_P_CAN);
-		skb->pkt_type = PACKET_BROADCAST;
-		skb->ip_summed = CHECKSUM_UNNECESSARY;
-		skb->dev = dev;
-
 		/* save this skb for tx interrupt echo handling */
 		priv->echo_skb[idx] = skb;
 	} else {
@@ -329,21 +317,34 @@ EXPORT_SYMBOL_GPL(can_put_echo_skb);
 unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx)
 {
 	struct can_priv *priv = netdev_priv(dev);
+	struct sk_buff *skb = priv->echo_skb[idx];
+	struct can_frame *cf;
+	u8 dlc;
 
 	BUG_ON(idx >= priv->echo_skb_max);
 
-	if (priv->echo_skb[idx]) {
-		struct sk_buff *skb = priv->echo_skb[idx];
-		struct can_frame *cf = (struct can_frame *)skb->data;
-		u8 dlc = cf->can_dlc;
+	if (!skb)
+		return 0;
 
-		netif_rx(priv->echo_skb[idx]);
-		priv->echo_skb[idx] = NULL;
+	priv->echo_skb[idx] = NULL;
+	cf = (struct can_frame *)skb->data;
 
-		return dlc;
+	/* check flag whether this packet has to be looped back */
+	if (!(dev->flags & IFF_ECHO) || skb->pkt_type != PACKET_LOOPBACK) {
+		kfree_skb(skb);
+		return 0;
 	}
 
-	return 0;
+	/* make settings for echo to reduce code in irq context */
+	skb->protocol = htons(ETH_P_CAN);
+	skb->pkt_type = PACKET_BROADCAST;
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+	skb->dev = dev;
+
+	dlc = cf->can_dlc;
+	netif_rx(skb);
+
+	return dlc;
 }
 EXPORT_SYMBOL_GPL(can_get_echo_skb);
 
-- 
1.7.8.6

