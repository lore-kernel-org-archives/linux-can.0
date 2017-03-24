From: Mario Huettel <mario.huettel@de.bosch.com>
Subject: [PATCH v3 5/6] can: m_can: Configuration for TX and TX event FIFOs
Date: Fri, 24 Mar 2017 17:49:30 +0100
Message-ID: <1490374171-15190-5-git-send-email-mario.huettel@de.bosch.com>
References: <1490374171-15190-1-git-send-email-mario.huettel@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:39181 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966717AbdCXQtl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 24 Mar 2017 12:49:41 -0400
Received: from vsmta13.fe.internet.bosch.com (unknown [10.4.98.53])
        by imta23.fe.bosch.de (Postfix) with ESMTP id 14E11158016B
        for <linux-can@vger.kernel.org>; Fri, 24 Mar 2017 17:49:39 +0100 (CET)
Received: from FE-HUB1000.de.bosch.com (vsgw24.fe.internet.bosch.com [10.4.98.24])
        by vsmta13.fe.internet.bosch.com (Postfix) with ESMTP id BDB3B2E405A8
        for <linux-can@vger.kernel.org>; Fri, 24 Mar 2017 17:49:38 +0100 (CET)
In-Reply-To: <1490374171-15190-1-git-send-email-mario.huettel@de.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

* TX/TX Event FIFO sizes are configured for version >= v3.1.x

Signed-off-by: Mario Huettel <mario.huettel@de.bosch.com>
---
 drivers/net/can/m_can/m_can.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 7f19ce5..a9f7de4 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -382,6 +382,18 @@ static inline void m_can_fifo_write(const struct m_can_priv *priv,
 	       fpi * TXB_ELEMENT_SIZE + offset);
 }
 
+static inline u32 m_can_txe_fifo_read(const struct m_can_priv *priv,
+				      u32 fgi,
+				      u32 offset) {
+	return readl(priv->mram_base + priv->mcfg[MRAM_TXE].off +
+			fgi * TXE_ELEMENT_SIZE + offset);
+}
+
+static inline bool m_can_tx_fifo_full(const struct m_can_priv *priv)
+{
+		return !!(m_can_read(priv, M_CAN_TXFQS) & TXFQS_TFQF);
+}
+
 static inline void m_can_config_endisable(const struct m_can_priv *priv,
 					  bool enable)
 {
@@ -925,6 +937,7 @@ static int m_can_set_bittiming(struct net_device *dev)
  * - configure rx fifo
  * - accept non-matching frame into fifo 0
  * - configure tx buffer
+ *		- >= v3.1.x: TX FIFO is used
  * - configure mode
  * - setup bittiming
  */
@@ -941,15 +954,31 @@ static void m_can_chip_config(struct net_device *dev)
 	/* Accept Non-matching Frames Into FIFO 0 */
 	m_can_write(priv, M_CAN_GFC, 0x0);
 
-	/* only support one Tx Buffer currently */
-	m_can_write(priv, M_CAN_TXBC, (1 << TXBC_NDTB_SHIFT) |
-		    priv->mcfg[MRAM_TXB].off);
+	if (priv->version == 30) {
+		/* only support one Tx Buffer currently */
+		m_can_write(priv, M_CAN_TXBC, (1 << TXBC_NDTB_SHIFT) |
+				priv->mcfg[MRAM_TXB].off);
+	} else {
+		/* TX FIFO is used for newer IP Core versions */
+		m_can_write(priv, M_CAN_TXBC,
+			    (priv->mcfg[MRAM_TXB].num << TXBC_TFQS_SHIFT) |
+			    (priv->mcfg[MRAM_TXB].off));
+	}
 
 	/* support 64 bytes payload */
 	m_can_write(priv, M_CAN_TXESC, TXESC_TBDS_64BYTES);
 
-	m_can_write(priv, M_CAN_TXEFC, (1 << TXEFC_EFS_SHIFT) |
-		    priv->mcfg[MRAM_TXE].off);
+	/* TX Event FIFO */
+	if (priv->version == 30) {
+		m_can_write(priv, M_CAN_TXEFC, (1 << TXEFC_EFS_SHIFT) |
+				priv->mcfg[MRAM_TXE].off);
+	} else {
+		/* Full TX Event FIFO is used */
+		m_can_write(priv, M_CAN_TXEFC,
+			    ((priv->mcfg[MRAM_TXE].num << TXEFC_EFS_SHIFT)
+			     & TXEFC_EFS_MASK) |
+			    priv->mcfg[MRAM_TXE].off);
+	}
 
 	/* rx fifo configuration, blocking mode, fifo size 1 */
 	m_can_write(priv, M_CAN_RXF0C,
-- 
1.9.1

