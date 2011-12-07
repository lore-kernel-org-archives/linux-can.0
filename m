From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [RFC PATCH 06/14] can: dev: consolidate error state change handling
Date: Wed,  7 Dec 2011 15:55:20 +0100
Message-ID: <1323269728-17491-7-git-send-email-wg@grandegger.com>
References: <1323269728-17491-1-git-send-email-wg@grandegger.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:49264 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756557Ab1LGOzk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Dec 2011 09:55:40 -0500
In-Reply-To: <1323269728-17491-1-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: socketcan-users@lists.berlios.de, Wolfgang Grandegger <wg@grandegger.com>

This patch provides the core support to allow state changes going down
including "back to error active".

For any state change the CAN_ERR_STATE_CHANGE bit will be set in the
can_id. If the state gets worse, the CAN_ERR_CRTL bis is set as usual
also for backward compatibility. If the state is back to error active,
the data[1] field will be set to CAN_ERR_CRTL_ACTIVE. The state change
management will be done by a common "can_change_state()" function doing
all the necessary bit settings and counter increments.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/dev.c     |   69 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/can/dev.h   |   11 +++++++
 include/linux/can/error.h |    2 +
 3 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 400d871..d8e4ebb 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -242,6 +242,75 @@ static int can_get_bittiming(struct net_device *dev, struct can_bittiming *bt)
 	return 0;
 }
 
+void can_change_state(struct net_device *dev, struct can_frame *cf,
+		      enum can_state state, unsigned int err_dir)
+{
+	struct can_priv *priv = netdev_priv(dev);
+
+	/* Function should only be called in case of real state changes */
+	if (state == priv->state) {
+		netdev_warn(dev, "%s: oops, state did not change", __func__);
+		return;
+	}
+
+	/* This message reports CAN error state changes */
+	cf->can_id |= CAN_ERR_STATE_CHANGE;
+	/* If it get's worse, we set the controller problem bit */
+	if (state > priv->state && state != CAN_STATE_BUS_OFF)
+		cf->can_id |= CAN_ERR_CRTL;
+
+	switch (state) {
+	case CAN_STATE_ERROR_WARNING:
+	case CAN_STATE_ERROR_PASSIVE:
+		/* State change triggered by TX or RX errors? */
+		if (err_dir == CAN_ERR_DIR_UNKNOWN &&
+		    priv->do_get_berr_counter) {
+			if (cf->data[6] > cf->data[7])
+				err_dir = CAN_ERR_DIR_TX;
+			else if (cf->data[7] > cf->data[6])
+				err_dir = CAN_ERR_DIR_RX;
+		}
+
+		if (state == CAN_STATE_ERROR_WARNING) {
+			priv->can_stats.error_warning++;
+			if (err_dir == CAN_ERR_DIR_TX)
+				cf->data[1] = CAN_ERR_CRTL_TX_WARNING;
+			else if (err_dir == CAN_ERR_DIR_RX)
+				cf->data[1] = CAN_ERR_CRTL_RX_WARNING;
+			else
+				cf->data[1] = CAN_ERR_CRTL_TX_WARNING |
+					CAN_ERR_CRTL_RX_WARNING;
+		} else {
+			priv->can_stats.error_passive++;
+			if (err_dir == CAN_ERR_DIR_TX)
+				cf->data[1] = CAN_ERR_CRTL_TX_PASSIVE;
+			else if (err_dir == CAN_ERR_DIR_RX)
+				cf->data[1] = CAN_ERR_CRTL_RX_PASSIVE;
+			else
+				cf->data[1] = CAN_ERR_CRTL_TX_PASSIVE |
+					CAN_ERR_CRTL_RX_PASSIVE;
+		}
+		break;
+
+	case CAN_STATE_ERROR_ACTIVE:
+		cf->data[1] = CAN_ERR_CRTL_ACTIVE; /* back to error active */
+		break;
+
+	case CAN_STATE_BUS_OFF:
+		priv->can_stats.bus_off++;
+		cf->can_id |= CAN_ERR_BUSOFF;
+		break;
+
+	default:
+		break;
+
+	}
+
+	/* Finally set new state */
+	priv->state = state;
+}
+EXPORT_SYMBOL_GPL(can_change_state);
+
 /*
  * Local echo of CAN messages
  *
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index a0969fc..a50862f 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -27,6 +27,13 @@ enum can_mode {
 };
 
 /*
+ * CAN error direction
+ */
+#define CAN_ERR_DIR_UNKNOWN	0x0
+#define CAN_ERR_DIR_RX		0x1
+#define CAN_ERR_DIR_TX		0x2
+
+/*
  * CAN common private data
  */
 struct can_priv {
@@ -90,6 +97,9 @@ void unregister_candev(struct net_device *dev);
 int can_restart_now(struct net_device *dev);
 void can_bus_off(struct net_device *dev);
 
+void can_change_state(struct net_device *dev, struct can_frame *cf,
+		      enum can_state state, unsigned int err_dir);
+
 void can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 		      unsigned int idx);
 void can_get_echo_skb(struct net_device *dev, unsigned int idx);
@@ -99,4 +109,5 @@ struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf);
 struct sk_buff *alloc_can_err_skb(struct net_device *dev,
 				  struct can_frame **cf);
 
+
 #endif /* CAN_DEV_H */
diff --git a/include/linux/can/error.h b/include/linux/can/error.h
index 63e855e..44c893c 100644
--- a/include/linux/can/error.h
+++ b/include/linux/can/error.h
@@ -24,6 +24,7 @@
 #define CAN_ERR_BUSOFF       0x00000040U /* bus off */
 #define CAN_ERR_BUSERROR     0x00000080U /* bus error (may flood!) */
 #define CAN_ERR_RESTARTED    0x00000100U /* controller restarted */
+#define CAN_ERR_STATE_CHANGE 0x00000200U /* CAN error state change / data[1] */
 
 /* arbitration lost in bit ... / data[0] */
 #define CAN_ERR_LOSTARB_UNSPEC   0x00 /* unspecified */
@@ -39,6 +40,7 @@
 #define CAN_ERR_CRTL_TX_PASSIVE  0x20 /* reached error passive status TX */
 				      /* (at least one error counter exceeds */
 				      /* the protocol-defined level of 127)  */
+#define CAN_ERR_CRTL_ACTIVE      0x40 /* recovered to error active state */
 
 /* error in CAN protocol (type) / data[2] */
 #define CAN_ERR_PROT_UNSPEC      0x00 /* unspecified */
-- 
1.7.4.1

