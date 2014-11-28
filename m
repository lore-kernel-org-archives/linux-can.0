From: Andri Yngvason <andri.yngvason@marel.com>
Subject: [PATCH v4 2/6] can: sja1000: Consolidate and unify state change
 handling.
Date: Fri, 28 Nov 2014 12:12:25 +0000
Message-ID: <074df808-ed37-4106-9882-78804c5ef8fc@GRBSR0089.marel.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db3on0055.outbound.protection.outlook.com ([157.55.234.55]:60736
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751046AbaK1MMj (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 28 Nov 2014 07:12:39 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, wg@grandegger.com

Replacing error state change handling with the new mechanism.

Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
---
Changes made since last proposal:
can: sja1000: move can_bus_off into if clause
can: sja1000: adapt to newer can_change_state

 drivers/net/can/sja1000/sja1000.c | 51 ++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 28 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index b27ac60..32bd7f4 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -392,12 +392,20 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 	struct can_frame *cf;
 	struct sk_buff *skb;
 	enum can_state state = priv->can.state;
+	enum can_state rx_state, tx_state;
+	unsigned int rxerr, txerr;
 	uint8_t ecc, alc;
 
 	skb = alloc_can_err_skb(dev, &cf);
 	if (skb == NULL)
 		return -ENOMEM;
 
+	txerr = priv->read_reg(priv, SJA1000_TXERR);
+	rxerr = priv->read_reg(priv, SJA1000_RXERR);
+
+	cf->data[6] = txerr;
+	cf->data[7] = rxerr;
+
 	if (isrc & IRQ_DOI) {
 		/* data overrun interrupt */
 		netdev_dbg(dev, "data overrun interrupt\n");
@@ -412,13 +420,11 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 		/* error warning interrupt */
 		netdev_dbg(dev, "error warning interrupt\n");
 
-		if (status & SR_BS) {
+		if (status & SR_BS)
 			state = CAN_STATE_BUS_OFF;
-			cf->can_id |= CAN_ERR_BUSOFF;
-			can_bus_off(dev);
-		} else if (status & SR_ES) {
+		else if (status & SR_ES)
 			state = CAN_STATE_ERROR_WARNING;
-		} else
+		else
 			state = CAN_STATE_ERROR_ACTIVE;
 	}
 	if (isrc & IRQ_BEI) {
@@ -452,10 +458,11 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 	if (isrc & IRQ_EPI) {
 		/* error passive interrupt */
 		netdev_dbg(dev, "error passive interrupt\n");
-		if (status & SR_ES)
-			state = CAN_STATE_ERROR_PASSIVE;
+
+		if (state == CAN_STATE_ERROR_PASSIVE)
+			state = CAN_STATE_ERROR_WARNING;
 		else
-			state = CAN_STATE_ERROR_ACTIVE;
+			state = CAN_STATE_ERROR_PASSIVE;
 	}
 	if (isrc & IRQ_ALI) {
 		/* arbitration lost interrupt */
@@ -467,27 +474,15 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 		cf->data[0] = alc & 0x1f;
 	}
 
-	if (state != priv->can.state && (state == CAN_STATE_ERROR_WARNING ||
-					 state == CAN_STATE_ERROR_PASSIVE)) {
-		uint8_t rxerr = priv->read_reg(priv, SJA1000_RXERR);
-		uint8_t txerr = priv->read_reg(priv, SJA1000_TXERR);
-		cf->can_id |= CAN_ERR_CRTL;
-		if (state == CAN_STATE_ERROR_WARNING) {
-			priv->can.can_stats.error_warning++;
-			cf->data[1] = (txerr > rxerr) ?
-				CAN_ERR_CRTL_TX_WARNING :
-				CAN_ERR_CRTL_RX_WARNING;
-		} else {
-			priv->can.can_stats.error_passive++;
-			cf->data[1] = (txerr > rxerr) ?
-				CAN_ERR_CRTL_TX_PASSIVE :
-				CAN_ERR_CRTL_RX_PASSIVE;
-		}
-		cf->data[6] = txerr;
-		cf->data[7] = rxerr;
-	}
+	if (state != priv->can.state) {
+		tx_state = txerr >= rxerr ? state : 0;
+		rx_state = txerr <= rxerr ? state : 0;
 
-	priv->can.state = state;
+		can_change_state(dev, cf, tx_state, rx_state);
+
+		if(state == CAN_STATE_BUS_OFF)
+			can_bus_off(dev);
+	}
 
 	netif_rx(skb);
 
-- 
1.9.1

