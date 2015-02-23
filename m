From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: add missing initialisations in CAN related skbuffs
Date: Mon, 23 Feb 2015 20:37:54 +0100
Message-ID: <1424720274-3831-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:17295 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbbBWTiO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 23 Feb 2015 14:38:14 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

When accessing CAN network interfaces with AF_PACKET sockets e.g. by dhclient
this can lead to a skb_under_panic due to missing skb initialisations.

Add the missing initialisations at the CAN skbuff creation times on driver
level (rx path) and in the network layer (tx path).

Reported-by: Austin Schuh <austin@peloton-tech.com>
Reported-by: Daniel Steer <daniel.steer@mclaren.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev.c | 8 ++++++++
 net/can/af_can.c      | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 3c82e02..b0f6924 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -579,6 +579,10 @@ struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
 	skb->pkt_type = PACKET_BROADCAST;
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
 
+	skb_reset_mac_header(skb);
+	skb_reset_network_header(skb);
+	skb_reset_transport_header(skb);
+
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
 
@@ -603,6 +607,10 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
 	skb->pkt_type = PACKET_BROADCAST;
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
 
+	skb_reset_mac_header(skb);
+	skb_reset_network_header(skb);
+	skb_reset_transport_header(skb);
+
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
 
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 66e0804..32d710e 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -259,6 +259,9 @@ int can_send(struct sk_buff *skb, int loop)
 		goto inval_skb;
 	}
 
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+	skb_reset_mac_header(skb);
 	skb_reset_network_header(skb);
 	skb_reset_transport_header(skb);
 
-- 
2.1.4

