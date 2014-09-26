From: Andri Yngvason <andri.yngvason@marel.com>
Subject: [PATCH v2 4/4] can: sja1000: Consolidate and unify state change handling.
Date: Fri, 26 Sep 2014 18:26:01 +0000
Message-ID: <5425AFB9.8050507@marel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn1bon0066.outbound.protection.outlook.com ([157.56.111.66]:3073
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755453AbaIZS0K (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 26 Sep 2014 14:26:10 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>

Replacing error state change handling with the new mechanism.

Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
---
 drivers/net/can/sja1000/sja1000.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index b27ac60..953bf2d 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -392,6 +392,8 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc,
uint8_t status)
     struct can_frame *cf;
     struct sk_buff *skb;
     enum can_state state = priv->can.state;
+    enum can_state rx_state, tx_state;
+    unsigned int rxerr, txerr;
     uint8_t ecc, alc;
 
     skb = alloc_can_err_skb(dev, &cf);
@@ -467,27 +469,18 @@ static int sja1000_err(struct net_device *dev, uint8_t
isrc, uint8_t status)
         cf->data[0] = alc & 0x1f;
     }
 
-    if (state != priv->can.state && (state == CAN_STATE_ERROR_WARNING ||
-                     state == CAN_STATE_ERROR_PASSIVE)) {
-        uint8_t rxerr = priv->read_reg(priv, SJA1000_RXERR);
-        uint8_t txerr = priv->read_reg(priv, SJA1000_TXERR);
-        cf->can_id |= CAN_ERR_CRTL;
-        if (state == CAN_STATE_ERROR_WARNING) {
-            priv->can.can_stats.error_warning++;
-            cf->data[1] = (txerr > rxerr) ?
-                CAN_ERR_CRTL_TX_WARNING :
-                CAN_ERR_CRTL_RX_WARNING;
-        } else {
-            priv->can.can_stats.error_passive++;
-            cf->data[1] = (txerr > rxerr) ?
-                CAN_ERR_CRTL_TX_PASSIVE :
-                CAN_ERR_CRTL_RX_PASSIVE;
-        }
-        cf->data[6] = txerr;
-        cf->data[7] = rxerr;
-    }
+    if (state != priv->can.state) {
+        txerr = priv->read_reg(priv, SJA1000_TXERR);
+        rxerr = priv->read_reg(priv, SJA1000_RXERR);
 
-    priv->can.state = state;
+        tx_state = can_errcnt_to_state(txerr);
+        rx_state = can_errcnt_to_state(rxerr);
+
+        can_change_state(dev, cf, state, tx_state, rx_state);
+
+        cf->data[6] = rxerr;
+        cf->data[7] = txerr;
+    }
 
     netif_rx(skb);
 
-- 
1.9.1

