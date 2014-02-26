From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v5 1/6] can: preserve skbuff protocol in can_put_echo_skb
Date: Wed, 26 Feb 2014 23:10:57 +0100
Message-ID: <1393452662-3154-2-git-send-email-socketcan@hartkopp.net>
References: <1393452662-3154-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:10456 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616AbaBZWL1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Feb 2014 17:11:27 -0500
In-Reply-To: <1393452662-3154-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

The skbuff protocol value was formerly fixed/sanitized to ETH_P_CAN in
can_put_echo_skb(). With CAN FD this value has to be preserved.
This patch changes the hard assignment of the protocol value to a check of
valid protocol values for CAN and CAN FD.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index c0563f1..e1a3741 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -317,7 +317,9 @@ void can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 	BUG_ON(idx >= priv->echo_skb_max);
 
 	/* check flag whether this packet has to be looped back */
-	if (!(dev->flags & IFF_ECHO) || skb->pkt_type != PACKET_LOOPBACK) {
+	if (!(dev->flags & IFF_ECHO) || skb->pkt_type != PACKET_LOOPBACK ||
+	    (skb->protocol != htons(ETH_P_CAN) &&
+	     skb->protocol != htons(ETH_P_CANFD))) {
 		kfree_skb(skb);
 		return;
 	}
@@ -329,7 +331,6 @@ void can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 			return;
 
 		/* make settings for echo to reduce code in irq context */
-		skb->protocol = htons(ETH_P_CAN);
 		skb->pkt_type = PACKET_BROADCAST;
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 		skb->dev = dev;
-- 
1.9.0

