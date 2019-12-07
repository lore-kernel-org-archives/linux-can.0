From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: ensure an initialized headroom in outgoing CAN sk_buffs
Date: Sat,  7 Dec 2019 19:34:18 +0100
Message-ID: <20191207183418.28868-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: linux-can@vger.kernel.org, dvyukov@google.com, mkl@pengutronix.de
Cc: syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com, glider@google.com, syzkaller-bugs@googlegroups.com, netdev@vger.kernel.org, o.rempel@pengutronix.de, eric.dumazet@gmail.com, Oliver Hartkopp <socketcan@hartkopp.net>
List-Id: linux-can.vger.kernel.org

KMSAN sysbot detected a read access to an untinitialized value in the headroom
of an outgoing CAN related sk_buff. When using CAN sockets this area is filled
appropriately - but when using a packet socket this initialization is missing.

The problematic read access occurs in the CAN receive path which can only be
triggered when the sk_buff is sent through a (virtual) CAN interface. So we
check in the sending path whether we need to perform the missing
initializations.

Fixes: d3b58c47d330d ("can: replace timestamp as unique skb attribute")
Reported-by: syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/linux/can/dev.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 9b3c720a31b1..8f86e7a1f8e9 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -18,6 +18,7 @@
 #include <linux/can/error.h>
 #include <linux/can/led.h>
 #include <linux/can/netlink.h>
+#include <linux/can/skb.h>
 #include <linux/netdevice.h>
 
 /*
@@ -91,6 +92,37 @@ struct can_priv {
 #define get_can_dlc(i)		(min_t(__u8, (i), CAN_MAX_DLC))
 #define get_canfd_dlc(i)	(min_t(__u8, (i), CANFD_MAX_DLC))
 
+/* Check for outgoing skbs that have not been created by the CAN subsystem */
+static inline bool can_check_skb_headroom(struct net_device *dev,
+					  struct sk_buff *skb)
+{
+	/* af_packet creates a headroom of HH_DATA_MOD bytes which is fine */
+	if (WARN_ON_ONCE(skb_headroom(skb) < sizeof(struct can_skb_priv)))
+		return true;
+
+	/* af_packet does not apply CAN skb specific settings */
+	if (skb->ip_summed == CHECKSUM_NONE) {
+
+		/* init headroom */
+		can_skb_prv(skb)->ifindex = dev->ifindex;
+		can_skb_prv(skb)->skbcnt = 0;
+
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+		/* preform proper loopback on capable devices */
+		if (dev->flags & IFF_ECHO)
+			skb->pkt_type = PACKET_LOOPBACK;
+		else
+			skb->pkt_type = PACKET_HOST;
+
+		skb_reset_mac_header(skb);
+		skb_reset_network_header(skb);
+		skb_reset_transport_header(skb);
+	}
+
+	return false;
+}
+
 /* Drop a given socketbuffer if it does not contain a valid CAN frame. */
 static inline bool can_dropped_invalid_skb(struct net_device *dev,
 					  struct sk_buff *skb)
@@ -108,6 +140,9 @@ static inline bool can_dropped_invalid_skb(struct net_device *dev,
 	} else
 		goto inval_skb;
 
+	if (can_check_skb_headroom(dev, skb))
+		goto inval_skb;
+
 	return false;
 
 inval_skb:
-- 
2.20.1
