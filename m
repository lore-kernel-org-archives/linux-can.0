From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH] can: add ability to allocate CANFD frame in skb data
Date: Wed, 15 Jan 2014 09:50:13 +0100
Message-ID: <1389775813-14838-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:23252 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbaAOIuj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 15 Jan 2014 03:50:39 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Stephane Grosjean <s.grosjean@peak-system.com>

This patch adds the ability of allocating a CANFD frame data structure in the
skb data area.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

---
 drivers/net/can/dev.c   | 24 ++++++++++++++++++++++++
 include/linux/can/dev.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 13a9098..cb584ea 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -521,6 +521,30 @@ struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
 }
 EXPORT_SYMBOL_GPL(alloc_can_skb);
 
+struct sk_buff *alloc_canfd_skb(struct net_device *dev,
+				struct canfd_frame **cfd)
+{
+	struct sk_buff *skb;
+
+	skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
+			       sizeof(struct canfd_frame));
+	if (unlikely(!skb))
+		return NULL;
+
+	skb->protocol = htons(ETH_P_CANFD);
+	skb->pkt_type = PACKET_BROADCAST;
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+	can_skb_reserve(skb);
+	can_skb_prv(skb)->ifindex = dev->ifindex;
+
+	*cfd = (struct canfd_frame *)skb_put(skb, sizeof(struct canfd_frame));
+	memset(*cfd, 0, sizeof(struct canfd_frame));
+
+	return skb;
+}
+EXPORT_SYMBOL_GPL(alloc_canfd_skb);
+
 struct sk_buff *alloc_can_err_skb(struct net_device *dev, struct can_frame **cf)
 {
 	struct sk_buff *skb;
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index fb0ab65..dc5f902 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -124,6 +124,8 @@ unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx);
 void can_free_echo_skb(struct net_device *dev, unsigned int idx);
 
 struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf);
+struct sk_buff *alloc_canfd_skb(struct net_device *dev,
+				struct canfd_frame **cfd);
 struct sk_buff *alloc_can_err_skb(struct net_device *dev,
 				  struct can_frame **cf);
 
-- 
1.8.1.2

