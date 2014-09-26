From: Andri Yngvason <andri.yngvason@marel.com>
Subject: [PATCH v2 1/4] can: dev: Consolidate and unify state change handling.
Date: Fri, 26 Sep 2014 18:25:24 +0000
Message-ID: <5425AF94.5000206@marel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bl2on0079.outbound.protection.outlook.com ([65.55.169.79]:38407
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755453AbaIZSZb (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 26 Sep 2014 14:25:31 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>

The handling of can error states is different between platforms.
This is an attempt to correct that problem.

I've moved this handling into a generic function for changing the
error state. This ensures that error state changes are handled
the same way everywhere (where this function is used).

What's changed from the last version of this patch-set is that
can_change_state() now relies on the individual states of the rx/tx
counters rather than their individual count values.

Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
---
 drivers/net/can/dev.c          | 106 +++++++++++++++++++++++++++++++++++++++++
 include/linux/can/dev.h        |   5 ++
 include/uapi/linux/can/error.h |   1 +
 3 files changed, 112 insertions(+)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 02492d2..f2ad15e 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -273,6 +273,112 @@ static int can_get_bittiming(struct net_device *dev,
struct can_bittiming *bt,
     return err;
 }
 
+static void can_update_error_counters(struct net_device *dev,
+                      enum can_state new_state)
+{
+    struct can_priv *priv = netdev_priv(dev);
+
+    if (new_state <= priv->state)
+        return;
+
+    switch (new_state) {
+    case CAN_STATE_ERROR_ACTIVE:
+        netdev_warn(dev, "%s: did we come from a state less than error-active?",
+                __func__);
+        break;
+    case CAN_STATE_ERROR_WARNING:
+        priv->can_stats.error_warning++;
+        break;
+    case CAN_STATE_ERROR_PASSIVE:
+        priv->can_stats.error_passive++;
+        break;
+    case CAN_STATE_BUS_OFF:
+        priv->can_stats.bus_off++;
+        break;
+    default:
+        netdev_warn(dev, "%s: %d is not a state", __func__, new_state);
+        break;
+    };
+}
+
+static int can_txstate_to_frame(struct net_device *dev, enum can_state state)
+{
+    switch (state) {
+    case CAN_STATE_ERROR_ACTIVE:
+        return CAN_ERR_CRTL_ACTIVE;
+    case CAN_STATE_ERROR_WARNING:
+        return CAN_ERR_CRTL_TX_WARNING;
+    case CAN_STATE_ERROR_PASSIVE:
+        return CAN_ERR_CRTL_TX_PASSIVE;
+    case CAN_STATE_BUS_OFF:
+        netdev_warn(dev, "%s: bus-off is not handled here", __func__);
+        return 0;
+    default:
+        netdev_warn(dev, "%s: %d is not a state", __func__, state);
+        return 0;
+    }
+}
+
+static int can_rxstate_to_frame(struct net_device *dev, enum can_state state)
+{
+    switch (state) {
+    case CAN_STATE_ERROR_ACTIVE:
+        return CAN_ERR_CRTL_ACTIVE;
+    case CAN_STATE_ERROR_WARNING:
+        return CAN_ERR_CRTL_RX_WARNING;
+    case CAN_STATE_ERROR_PASSIVE:
+        return CAN_ERR_CRTL_RX_PASSIVE;
+    case CAN_STATE_BUS_OFF:
+        netdev_warn(dev, "%s: bus-off is not handled here", __func__);
+        return 0;
+    default:
+        netdev_warn(dev, "%s: %d is not a state", __func__, state);
+        return 0;
+    }
+}
+
+void can_change_state(struct net_device *dev, struct can_frame *cf,
+              enum can_state new_state, enum can_state tx_state,
+              enum can_state rx_state)
+{
+    struct can_priv *priv = netdev_priv(dev);
+
+    if (unlikely(new_state == priv->state)) {
+        netdev_warn(dev, "%s: oops, state did not change", __func__);
+        return;
+    }
+
+    can_update_error_counters(dev, new_state);
+
+    if (unlikely(new_state == CAN_STATE_BUS_OFF)) {
+        cf->can_id |= CAN_ERR_BUSOFF;
+    } else {
+        cf->can_id |= CAN_ERR_CRTL;
+        if (tx_state > rx_state)
+            cf->data[1] |= can_txstate_to_frame(dev, tx_state);
+        else if (tx_state < rx_state)
+            cf->data[1] |= can_rxstate_to_frame(dev, rx_state);
+        else
+            cf->data[1] |= can_txstate_to_frame(dev, tx_state)
+                    |  can_rxstate_to_frame(dev, rx_state);
+    }
+
+    priv->state = new_state;
+}
+EXPORT_SYMBOL_GPL(can_change_state);
+
+enum can_state can_errcnt_to_state(unsigned int count)
+{
+    if (unlikely(count > 127))
+        return CAN_STATE_ERROR_PASSIVE;
+
+    if (unlikely(count > 96))
+        return CAN_STATE_ERROR_WARNING;
+
+    return CAN_STATE_ERROR_ACTIVE;
+}
+EXPORT_SYMBOL_GPL(can_errcnt_to_state);
+
 /*
  * Local echo of CAN messages
  *
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 6992afc..6505208 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -121,6 +121,11 @@ void unregister_candev(struct net_device *dev);
 int can_restart_now(struct net_device *dev);
 void can_bus_off(struct net_device *dev);
 
+void can_change_state(struct net_device *dev, struct can_frame *cf,
+              enum can_state new_state, enum can_state tx_state,
+              enum can_state rx_state);
+enum can_state can_errcnt_to_state(unsigned int count);
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

