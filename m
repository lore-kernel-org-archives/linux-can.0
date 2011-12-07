From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [RFC PATCH 09/14] can: sja1000: consolidate error state handling
Date: Wed,  7 Dec 2011 15:55:23 +0100
Message-ID: <1323269728-17491-10-git-send-email-wg@grandegger.com>
References: <1323269728-17491-1-git-send-email-wg@grandegger.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:49272 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756480Ab1LGOzl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Dec 2011 09:55:41 -0500
In-Reply-To: <1323269728-17491-1-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: socketcan-users@lists.berlios.de, Wolfgang Grandegger <wg@grandegger.com>

Allow state to decrease bus-off->passive->warning->active.
Use the common function can_chage_state().

Here is an example output of "candump -candump -td -e any,0:0,#FFFFFFFF"
for a recovery from error passive state due to no ack/cable (reconnect
after 5s) for a SJA1000 on an on EMS PCI card:

 (000.201913)  can0   1C  [0]
 (000.212241)  can0  20000204  [8] 00 08 00 00 00 00 60 00   ERRORFRAME
        controller-problem{tx-error-warning}
        state-change{tx-error-warning}
        error-counter-tx-rx{{96}{0}}
 (000.003544)  can0  20000204  [8] 00 20 00 00 00 00 80 00   ERRORFRAME
        controller-problem{tx-error-passive}
        state-change{tx-error-passive}
        error-counter-tx-rx{{128}{0}}
 (004.901842)  can0   1D  [7] 1D F6 33 52 31 4B DE
 (000.000116)  can0  20000200  [8] 00 08 00 00 00 00 7F 00   ERRORFRAME
        state-change{tx-error-warning}
        error-counter-tx-rx{{127}{0}}
 (000.000678)  can0   1E  [6] 42 05 14 82 23 B6
 ...
 (000.201927)  can0   49  [4] 2F 1A 97 25
 (000.000096)  can0  20000200  [8] 00 40 00 00 00 00 5F 00   ERRORFRAME
        state-change{back-to-error-active}
        error-counter-tx-rx{{95}{0}}
 (000.202184)  can0   4A  [8] 7F 87 0E FE 03 BA 78 91

This is how it should be on other CAN controllers as well.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/sja1000/sja1000.c |   39 ++++++++++++------------------------
 1 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index ebbcfca..f6a1c74 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -371,6 +371,8 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 	enum can_state state = priv->can.state;
 	uint8_t ecc, alc;
 
+	netdev_dbg(dev, "%s: ir=0x%02x sr=0x%02x", __func__, isrc, status);
+
 	skb = alloc_can_err_skb(dev, &cf);
 	if (skb == NULL)
 		return -ENOMEM;
@@ -391,12 +393,12 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 
 		if (status & SR_BS) {
 			state = CAN_STATE_BUS_OFF;
-			cf->can_id |= CAN_ERR_BUSOFF;
 			can_bus_off(dev);
 		} else if (status & SR_ES) {
 			state = CAN_STATE_ERROR_WARNING;
-		} else
+		} else {
 			state = CAN_STATE_ERROR_ACTIVE;
+		}
 	}
 	if (isrc & IRQ_BEI) {
 		/* bus error interrupt */
@@ -429,10 +431,14 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 	if (isrc & IRQ_EPI) {
 		/* error passive interrupt */
 		netdev_dbg(dev, "error passive interrupt\n");
-		if (status & SR_ES)
-			state = CAN_STATE_ERROR_PASSIVE;
-		else
+		if (status & SR_ES) {
+			if (state == CAN_STATE_ERROR_WARNING)
+				state = CAN_STATE_ERROR_PASSIVE;
+			else
+				state = CAN_STATE_ERROR_WARNING;
+		} else {
 			state = CAN_STATE_ERROR_ACTIVE;
+		}
 	}
 	if (isrc & IRQ_ALI) {
 		/* arbitration lost interrupt */
@@ -444,27 +450,8 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 		cf->data[0] = alc & 0x1f;
 	}
 
-	if (state != priv->can.state && (state == CAN_STATE_ERROR_WARNING ||
-					 state == CAN_STATE_ERROR_PASSIVE)) {
-		uint8_t rxerr = priv->read_reg(priv, REG_RXERR);
-		uint8_t txerr = priv->read_reg(priv, REG_TXERR);
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
-
-	priv->can.state = state;
+	if (state != priv->can.state)
+		can_change_state(dev, cf, state, CAN_ERR_DIR_UNKNOWN);
 
 	netif_rx(skb);
 
-- 
1.7.4.1

