From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 2/2] can: m_can: handle frame transmission on IP core >= 3.1.x
Date: Mon,  6 Mar 2017 22:20:11 +0100
Message-ID: <20170306212011.29519-2-socketcan@hartkopp.net>
References: <20170306212011.29519-1-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:8983 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753672AbdCFVVT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 6 Mar 2017 16:21:19 -0500
In-Reply-To: <20170306212011.29519-1-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

Enables the transmission of CAN FD frames on M_CAN IP core >= v3.1.x
including bit rate switching and error state indicator.

Suggested-by: Wenyou Yang <wenyou.yang@atmel.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/m_can/m_can.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 650b656f3c05..297b55163812 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -283,8 +283,12 @@ enum m_can_mram_cfg {
 
 /* Tx Buffer Element */
 /* R0 */
+#define TX_BUF_ESI		BIT(31)
 #define TX_BUF_XTD		BIT(30)
 #define TX_BUF_RTR		BIT(29)
+#define TX_BUF_EFC		BIT(23)
+#define TX_BUF_FDF		BIT(21)
+#define TX_BUF_BRS		BIT(20)
 
 /* address offset and element number for each FIFO/Buffer in the Message RAM */
 struct mram_cfg {
@@ -916,7 +920,7 @@ static void m_can_chip_config(struct net_device *dev)
 	}
 
 	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
-		cccr |= CCCR_CME_CANFD_BRS << CCCR_CME_SHIFT;
+		cccr |= (CCCR_CME_CANFD_BRS | CCCR_CME_CANFD) << CCCR_CME_SHIFT;
 
 	m_can_write(priv, M_CAN_CCCR, cccr);
 	m_can_write(priv, M_CAN_TEST, test);
@@ -1079,6 +1083,7 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
 	u32 id, cccr;
 	int i;
+	u32 dlc;
 
 	if (can_dropped_invalid_skb(dev, skb))
 		return NETDEV_TX_OK;
@@ -1097,7 +1102,6 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 
 	/* message ram configuration */
 	m_can_fifo_write(priv, 0, M_CAN_FIFO_ID, id);
-	m_can_fifo_write(priv, 0, M_CAN_FIFO_DLC, can_len2dlc(cf->len) << 16);
 
 	for (i = 0; i < cf->len; i += 4)
 		m_can_fifo_write(priv, 0, M_CAN_FIFO_DATA(i / 4),
@@ -1105,19 +1109,34 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 
 	can_put_echo_skb(skb, dev, 0);
 
+	dlc = can_len2dlc(cf->len) << 16;
+
 	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
-		cccr = m_can_read(priv, M_CAN_CCCR);
-		cccr &= ~(CCCR_CMR_MASK << CCCR_CMR_SHIFT);
-		if (can_is_canfd_skb(skb)) {
-			if (cf->flags & CANFD_BRS)
-				cccr |= CCCR_CMR_CANFD_BRS << CCCR_CMR_SHIFT;
-			else
-				cccr |= CCCR_CMR_CANFD << CCCR_CMR_SHIFT;
+		if (m_can_read_core_rev(priv) < M_CAN_COREREL_3_1_0) {
+			/* set CCCR according to frame content */
+			cccr = m_can_read(priv, M_CAN_CCCR);
+			cccr &= ~(CCCR_CMR_MASK << CCCR_CMR_SHIFT);
+			if (can_is_canfd_skb(skb)) {
+				if (cf->flags & CANFD_BRS)
+					cccr |= CCCR_CMR_CANFD_BRS << CCCR_CMR_SHIFT;
+				else
+					cccr |= CCCR_CMR_CANFD << CCCR_CMR_SHIFT;
+			} else {
+				cccr |= CCCR_CMR_CAN << CCCR_CMR_SHIFT;
+			}
+			m_can_write(priv, M_CAN_CCCR, cccr);
 		} else {
-			cccr |= CCCR_CMR_CAN << CCCR_CMR_SHIFT;
+			/* set tx buffer according to frame content */
+			if (can_is_canfd_skb(skb)) {
+				dlc |= TX_BUF_FDF;
+				if (cf->flags & CANFD_ESI)
+					dlc |= TX_BUF_ESI;
+				if (cf->flags & CANFD_BRS)
+					dlc |= TX_BUF_BRS;
+			}
 		}
-		m_can_write(priv, M_CAN_CCCR, cccr);
 	}
+	m_can_fifo_write(priv, 0, M_CAN_FIFO_DLC, dlc);
 
 	/* enable first TX buffer to start transfer  */
 	m_can_write(priv, M_CAN_TXBTIE, 0x1);
-- 
2.11.0

