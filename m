From: Andri Yngvason <andri.yngvason@marel.com>
Subject: [PATCH 3/4] Consolidate and unify state change handling
Date: Thu, 18 Sep 2014 16:26:00 +0000
Message-ID: <541B0798.4010308@marel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-by2on0091.outbound.protection.outlook.com ([207.46.100.91]:54347
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756298AbaIRQ0E (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 18 Sep 2014 12:26:04 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
---
  drivers/net/can/mscan/mscan.c | 62 
+++++++++++++++++++------------------------
  1 file changed, 28 insertions(+), 34 deletions(-)

diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
index e0c9be5..c7b5b33 100644
--- a/drivers/net/can/mscan/mscan.c
+++ b/drivers/net/can/mscan/mscan.c
@@ -289,18 +289,15 @@ static netdev_tx_t mscan_start_xmit(struct sk_buff 
*skb, struct net_device *dev)
      return NETDEV_TX_OK;
  }

-/* This function returns the old state to see where we came from */
-static enum can_state check_set_state(struct net_device *dev, u8 canrflg)
+static enum can_state get_new_state(struct net_device *dev, u8 canrflg)
  {
      struct mscan_priv *priv = netdev_priv(dev);
-    enum can_state state, old_state = priv->can.state;

-    if (canrflg & MSCAN_CSCIF && old_state <= CAN_STATE_BUS_OFF) {
-        state = state_map[max(MSCAN_STATE_RX(canrflg),
-                      MSCAN_STATE_TX(canrflg))];
-        priv->can.state = state;
-    }
-    return old_state;
+    if (unlikely(canrflg & MSCAN_CSCIF))
+        return state_map[max(MSCAN_STATE_RX(canrflg),
+                 MSCAN_STATE_TX(canrflg))];
+
+    return priv->can.state;
  }

  static void mscan_get_rx_frame(struct net_device *dev, struct 
can_frame *frame)
@@ -343,13 +340,28 @@ static void mscan_get_rx_frame(struct net_device 
*dev, struct can_frame *frame)
      out_8(&regs->canrflg, MSCAN_RXF);
  }

+static unsigned int mscan_get_err_dir(struct mscan_priv *priv, u8 canrflg)
+{
+    enum can_err_dir dir = CAN_ERR_DIR_UNKNOWN;
+
+    if ((priv->shadow_statflg & MSCAN_RSTAT_MSK) <
+            (canrflg & MSCAN_RSTAT_MSK))
+        dir |= CAN_ERR_DIR_RX;
+
+    if ((priv->shadow_statflg & MSCAN_TSTAT_MSK) <
+            (canrflg & MSCAN_TSTAT_MSK))
+        dir |= CAN_ERR_DIR_TX;
+
+    return dir;
+}
+
  static void mscan_get_err_frame(struct net_device *dev, struct 
can_frame *frame,
                  u8 canrflg)
  {
      struct mscan_priv *priv = netdev_priv(dev);
      struct mscan_regs __iomem *regs = priv->reg_base;
      struct net_device_stats *stats = &dev->stats;
-    enum can_state old_state;
+    enum can_state state;

      netdev_dbg(dev, "error interrupt (canrflg=%#x)\n", canrflg);
      frame->can_id = CAN_ERR_FLAG;
@@ -363,27 +375,12 @@ static void mscan_get_err_frame(struct net_device 
*dev, struct can_frame *frame,
          frame->data[1] = 0;
      }

-    old_state = check_set_state(dev, canrflg);
-    /* State changed */
-    if (old_state != priv->can.state) {
-        switch (priv->can.state) {
-        case CAN_STATE_ERROR_WARNING:
-            frame->can_id |= CAN_ERR_CRTL;
-            priv->can.can_stats.error_warning++;
-            if ((priv->shadow_statflg & MSCAN_RSTAT_MSK) <
-                (canrflg & MSCAN_RSTAT_MSK))
-                frame->data[1] |= CAN_ERR_CRTL_RX_WARNING;
-            if ((priv->shadow_statflg & MSCAN_TSTAT_MSK) <
-                (canrflg & MSCAN_TSTAT_MSK))
-                frame->data[1] |= CAN_ERR_CRTL_TX_WARNING;
-            break;
-        case CAN_STATE_ERROR_PASSIVE:
-            frame->can_id |= CAN_ERR_CRTL;
-            priv->can.can_stats.error_passive++;
-            frame->data[1] |= CAN_ERR_CRTL_RX_PASSIVE;
-            break;
-        case CAN_STATE_BUS_OFF:
-            frame->can_id |= CAN_ERR_BUSOFF;
+    state = get_new_state(dev, canrflg);
+    if (state != priv->can.state) {
+        can_change_state(dev, frame, state,
+                 mscan_get_err_dir(priv, canrflg));
+
+        if (priv->can.state == CAN_STATE_BUS_OFF) {
              /*
               * The MSCAN on the MPC5200 does recover from bus-off
               * automatically. To avoid that we stop the chip doing
@@ -396,9 +393,6 @@ static void mscan_get_err_frame(struct net_device 
*dev, struct can_frame *frame,
                       MSCAN_SLPRQ | MSCAN_INITRQ);
              }
              can_bus_off(dev);
-            break;
-        default:
-            break;
          }
      }
      priv->shadow_statflg = canrflg & MSCAN_STAT_MSK;
