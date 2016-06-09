From: Marek Vasut <marex@denx.de>
Subject: [PATCH 4/5][RFC] can: kline: Add KLine rtnl configuration options
Date: Thu,  9 Jun 2016 21:21:03 +0200
Message-ID: <1465500064-5402-4-git-send-email-marex@denx.de>
References: <1465500064-5402-1-git-send-email-marex@denx.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:58989 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbcFITVm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Jun 2016 15:21:42 -0400
In-Reply-To: <1465500064-5402-1-git-send-email-marex@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>

Extend the can rtnl with kline timing parameters W0...W5, P1...P4 .

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c            | 16 +++++++++++++++-
 include/linux/can/dev.h          |  2 ++
 include/uapi/linux/can/netlink.h | 18 ++++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 0db16f6..e867b7a 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -787,6 +787,7 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
 				= { .len = sizeof(struct can_bittiming) },
 	[IFLA_CAN_DATA_BITTIMING_CONST]
 				= { .len = sizeof(struct can_bittiming_const) },
+	[IFLA_KLINE_TIMING]	= { .len = sizeof(struct kline_timing) },
 };
 
 static int can_changelink(struct net_device *dev,
@@ -878,6 +879,14 @@ static int can_changelink(struct net_device *dev,
 		}
 	}
 
+	if (data[IFLA_KLINE_TIMING]) {
+		/* Do not allow changing bittiming while running */
+		if (dev->flags & IFF_UP)
+			return -EBUSY;
+		memcpy(&priv->kline_timing, nla_data(data[IFLA_KLINE_TIMING]),
+		       sizeof(struct kline_timing));
+	}
+
 	return 0;
 }
 
@@ -900,6 +909,7 @@ static size_t can_get_size(const struct net_device *dev)
 		size += nla_total_size(sizeof(struct can_bittiming));
 	if (priv->data_bittiming_const)				/* IFLA_CAN_DATA_BITTIMING_CONST */
 		size += nla_total_size(sizeof(struct can_bittiming_const));
+	size += nla_total_size(sizeof(struct kline_timing));	/* IFLA_KLINE_TIMING */
 
 	return size;
 }
@@ -938,7 +948,11 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	    (priv->data_bittiming_const &&
 	     nla_put(skb, IFLA_CAN_DATA_BITTIMING_CONST,
 		     sizeof(*priv->data_bittiming_const),
-		     priv->data_bittiming_const)))
+		     priv->data_bittiming_const)) ||
+
+	    nla_put(skb, IFLA_KLINE_TIMING,
+		    sizeof(priv->kline_timing), &priv->kline_timing)
+	    )
 		return -EMSGSIZE;
 
 	return 0;
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index c67082d..f95f24d 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -65,6 +65,8 @@ struct can_priv {
 	struct led_trigger *rxtx_led_trig;
 	char rxtx_led_trig_name[CAN_LED_NAME_SZ];
 #endif
+
+	struct kline_timing kline_timing;
 };
 
 /*
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 94ffe0c..da5f4b3 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -113,6 +113,23 @@ struct can_device_stats {
 };
 
 /*
+ * KLine timing parameters
+ */
+struct kline_timing {
+	__u32 w0;
+	__u32 w1;
+	__u32 w2;
+	__u32 w3;
+	__u32 w4;
+	__u32 w5;
+	__u32 p1;
+	__u32 p2_94;
+	__u32 p2_08;
+	__u32 p3;
+	__u32 p4;
+};
+
+/*
  * CAN netlink interface
  */
 enum {
@@ -127,6 +144,7 @@ enum {
 	IFLA_CAN_BERR_COUNTER,
 	IFLA_CAN_DATA_BITTIMING,
 	IFLA_CAN_DATA_BITTIMING_CONST,
+	IFLA_KLINE_TIMING,
 	__IFLA_CAN_MAX
 };
 
-- 
2.7.0

