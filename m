From: Andri Yngvason <andri.yngvason@marel.com>
Subject: [PATCH v2 2/4] can: flexcan: Consolidate and unify state change handling.
Date: Fri, 26 Sep 2014 18:25:38 +0000
Message-ID: <5425AFA2.3040804@marel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn1on0088.outbound.protection.outlook.com ([157.56.110.88]:41888
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755453AbaIZSZq (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 26 Sep 2014 14:25:46 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>

Replacing error state change handling with the new mechanism.

Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
---
 drivers/net/can/flexcan.c | 69 +++++------------------------------------------
 1 file changed, 6 insertions(+), 63 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 2700865..e0aee9a 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -559,74 +559,18 @@ static int flexcan_poll_bus_err(struct net_device *dev,
u32 reg_esr)
 static void do_state(struct net_device *dev,
              struct can_frame *cf, enum can_state new_state)
 {
-    struct flexcan_priv *priv = netdev_priv(dev);
     struct can_berr_counter bec;
+    enum can_state rx_state, tx_state;
 
     __flexcan_get_berr_counter(dev, &bec);
 
-    switch (priv->can.state) {
-    case CAN_STATE_ERROR_ACTIVE:
-        /*
-         * from: ERROR_ACTIVE
-         * to  : ERROR_WARNING, ERROR_PASSIVE, BUS_OFF
-         * =>  : there was a warning int
-         */
-        if (new_state >= CAN_STATE_ERROR_WARNING &&
-            new_state <= CAN_STATE_BUS_OFF) {
-            netdev_dbg(dev, "Error Warning IRQ\n");
-            priv->can.can_stats.error_warning++;
-
-            cf->can_id |= CAN_ERR_CRTL;
-            cf->data[1] = (bec.txerr > bec.rxerr) ?
-                CAN_ERR_CRTL_TX_WARNING :
-                CAN_ERR_CRTL_RX_WARNING;
-        }
-    case CAN_STATE_ERROR_WARNING:    /* fallthrough */
-        /*
-         * from: ERROR_ACTIVE, ERROR_WARNING
-         * to  : ERROR_PASSIVE, BUS_OFF
-         * =>  : error passive int
-         */
-        if (new_state >= CAN_STATE_ERROR_PASSIVE &&
-            new_state <= CAN_STATE_BUS_OFF) {
-            netdev_dbg(dev, "Error Passive IRQ\n");
-            priv->can.can_stats.error_passive++;
-
-            cf->can_id |= CAN_ERR_CRTL;
-            cf->data[1] = (bec.txerr > bec.rxerr) ?
-                CAN_ERR_CRTL_TX_PASSIVE :
-                CAN_ERR_CRTL_RX_PASSIVE;
-        }
-        break;
-    case CAN_STATE_BUS_OFF:
-        netdev_err(dev, "BUG! "
-               "hardware recovered automatically from BUS_OFF\n");
-        break;
-    default:
-        break;
-    }
+    tx_state = can_errcnt_to_state(bec.txerr);
+    rx_state = can_errcnt_to_state(bec.rxerr);
 
-    /* process state changes depending on the new state */
-    switch (new_state) {
-    case CAN_STATE_ERROR_WARNING:
-        netdev_dbg(dev, "Error Warning\n");
-        cf->can_id |= CAN_ERR_CRTL;
-        cf->data[1] = (bec.txerr > bec.rxerr) ?
-            CAN_ERR_CRTL_TX_WARNING :
-            CAN_ERR_CRTL_RX_WARNING;
-        break;
-    case CAN_STATE_ERROR_ACTIVE:
-        netdev_dbg(dev, "Error Active\n");
-        cf->can_id |= CAN_ERR_PROT;
-        cf->data[2] = CAN_ERR_PROT_ACTIVE;
-        break;
-    case CAN_STATE_BUS_OFF:
-        cf->can_id |= CAN_ERR_BUSOFF;
+    can_change_state(dev, cf, new_state, tx_state, rx_state);
+
+    if (unlikely(new_state == CAN_STATE_BUS_OFF))
         can_bus_off(dev);
-        break;
-    default:
-        break;
-    }
 }
 
 static int flexcan_poll_state(struct net_device *dev, u32 reg_esr)
@@ -658,7 +602,6 @@ static int flexcan_poll_state(struct net_device *dev, u32
reg_esr)
         return 0;
 
     do_state(dev, cf, new_state);
-    priv->can.state = new_state;
     netif_receive_skb(skb);
 
     dev->stats.rx_packets++;
-- 
1.9.1

