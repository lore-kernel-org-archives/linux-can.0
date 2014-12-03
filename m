From: Andri Yngvason <andri.yngvason@marel.com>
Subject: [PATCH v5 1/5] can: dev: Consolidate and unify state change handling
Date: Wed, 3 Dec 2014 17:54:13 +0000
Message-ID: <8163485d-0470-4aef-a2f9-bb33dc580504@GRBSR0089.marel.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-am1on0063.outbound.protection.outlook.com ([157.56.112.63]:46970
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751321AbaLCRyR (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 3 Dec 2014 12:54:17 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, wg@grandegger.com

The handling of can error states is different between platforms.
This is an attempt to correct that problem.

I've moved this handling into a generic function for changing the
error state. This ensures that error state changes are handled
the same way everywhere (where this function is used).

This new mechanism also adds reverse state transitioning in error
frames, i.e. the user will be notified through the socket interface
when the state goes down.

Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
---
Changes made since last proposal:
can: dev: add debug message for new state

 drivers/net/can/dev.c          | 78 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/can/dev.h        |  3 ++
 include/uapi/linux/can/error.h |  1 +
 3 files changed, 82 insertions(+)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 02492d2..b4ecb10 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -273,6 +273,84 @@ static int can_get_bittiming(struct net_device *dev, struct can_bittiming *bt,
 	return err;
 }
 
+static void can_update_state_error_stats(struct net_device *dev,
+					 enum can_state new_state)
+{
+	struct can_priv *priv = netdev_priv(dev);
+
+	if (new_state <= priv->state)
+		return;
+
+	switch (new_state) {
+	case CAN_STATE_ERROR_WARNING:
+		priv->can_stats.error_warning++;
+		break;
+	case CAN_STATE_ERROR_PASSIVE:
+		priv->can_stats.error_passive++;
+		break;
+	case CAN_STATE_BUS_OFF:
+	default:
+		break;
+	};
+}
+
+static int can_tx_state_to_frame(struct net_device *dev, enum can_state state)
+{
+	switch (state) {
+	case CAN_STATE_ERROR_ACTIVE:
+		return CAN_ERR_CRTL_ACTIVE;
+	case CAN_STATE_ERROR_WARNING:
+		return CAN_ERR_CRTL_TX_WARNING;
+	case CAN_STATE_ERROR_PASSIVE:
+		return CAN_ERR_CRTL_TX_PASSIVE;
+	default:
+		return 0;
+	}
+}
+
+static int can_rx_state_to_frame(struct net_device *dev, enum can_state state)
+{
+	switch (state) {
+	case CAN_STATE_ERROR_ACTIVE:
+		return CAN_ERR_CRTL_ACTIVE;
+	case CAN_STATE_ERROR_WARNING:
+		return CAN_ERR_CRTL_RX_WARNING;
+	case CAN_STATE_ERROR_PASSIVE:
+		return CAN_ERR_CRTL_RX_PASSIVE;
+	default:
+		return 0;
+	}
+}
+
+void can_change_state(struct net_device *dev, struct can_frame *cf,
+		      enum can_state tx_state, enum can_state rx_state)
+{
+	struct can_priv *priv = netdev_priv(dev);
+	enum can_state new_state = max(tx_state, rx_state);
+
+	if (unlikely(new_state == priv->state)) {
+		netdev_warn(dev, "%s: oops, state did not change", __func__);
+		return;
+	}
+
+	netdev_dbg(dev, "New error state: %d\n", new_state);
+
+	can_update_state_error_stats(dev, new_state);
+	priv->state = new_state;
+
+	if (unlikely(new_state == CAN_STATE_BUS_OFF)) {
+		cf->can_id |= CAN_ERR_BUSOFF;
+		return;
+	}
+
+	cf->can_id |= CAN_ERR_CRTL;
+	cf->data[1] |= tx_state >= rx_state ?
+		       can_tx_state_to_frame(dev, tx_state) : 0;
+	cf->data[1] |= tx_state <= rx_state ?
+		       can_rx_state_to_frame(dev, rx_state) : 0;
+}
+EXPORT_SYMBOL_GPL(can_change_state);
+
 /*
  * Local echo of CAN messages
  *
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 6992afc..9600701 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -121,6 +121,9 @@ void unregister_candev(struct net_device *dev);
 int can_restart_now(struct net_device *dev);
 void can_bus_off(struct net_device *dev);
 
+void can_change_state(struct net_device *dev, struct can_frame *cf,
+		      enum can_state tx_state, enum can_state rx_state);
+
 void can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 		      unsigned int idx);
 unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx);
diff --git a/include/uapi/linux/can/error.h b/include/uapi/linux/can/error.h
index c247446..1c508be 100644
--- a/include/uapi/linux/can/error.h
+++ b/include/uapi/linux/can/error.h
@@ -71,6 +71,7 @@
 #define CAN_ERR_CRTL_TX_PASSIVE  0x20 /* reached error passive status TX */
 				      /* (at least one error counter exceeds */
 				      /* the protocol-defined level of 127)  */
+#define CAN_ERR_CRTL_ACTIVE      0x40 /* recovered to error active state */
 
 /* error in CAN protocol (type) / data[2] */
 #define CAN_ERR_PROT_UNSPEC      0x00 /* unspecified */
-- 
1.9.1

