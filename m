From: Andri Yngvason <andri.yngvason@marel.com>
Subject: [PATCH 4/4] Consolidate and unify state change handling
Date: Thu, 18 Sep 2014 16:26:05 +0000
Message-ID: <541B079D.1020409@marel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bl2on0060.outbound.protection.outlook.com ([65.55.169.60]:14603
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756463AbaIRQ0J (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 18 Sep 2014 12:26:09 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
---
  drivers/net/can/sja1000/sja1000.c | 29 +++++++++--------------------
  1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000.c 
b/drivers/net/can/sja1000/sja1000.c
index b27ac60..224e7f3 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -467,27 +467,16 @@ static int sja1000_err(struct net_device *dev, 
uint8_t isrc, uint8_t status)
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
+        unsigned int rxerr = priv->read_reg(priv, SJA1000_RXERR);
+        unsigned int txerr = priv->read_reg(priv, SJA1000_TXERR);

-    priv->can.state = state;
+        can_change_state(dev, cf, state,
+                 can_get_err_dir(rxerr, txerr));
+
+        cf->data[6] = rxerr;
+        cf->data[7] = txerr;
+    }

      netif_rx(skb);
