From: Mario Huettel <mario.huettel@de.bosch.com>
Subject: [PATCH v3 2/6] can: m_can: Removed initialization of FIFO water marks
Date: Fri, 24 Mar 2017 17:49:27 +0100
Message-ID: <1490374171-15190-2-git-send-email-mario.huettel@de.bosch.com>
References: <1490374171-15190-1-git-send-email-mario.huettel@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:39178 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966642AbdCXQtl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 24 Mar 2017 12:49:41 -0400
Received: from vsmta13.fe.internet.bosch.com (unknown [10.4.98.53])
        by imta23.fe.bosch.de (Postfix) with ESMTP id 1B89D1580108
        for <linux-can@vger.kernel.org>; Fri, 24 Mar 2017 17:49:38 +0100 (CET)
Received: from FE-HUB1000.de.bosch.com (vsgw24.fe.internet.bosch.com [10.4.98.24])
        by vsmta13.fe.internet.bosch.com (Postfix) with ESMTP id CBEDE2E405A4
        for <linux-can@vger.kernel.org>; Fri, 24 Mar 2017 17:49:37 +0100 (CET)
In-Reply-To: <1490374171-15190-1-git-send-email-mario.huettel@de.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

FIFO water marks disabled because the driver doesn't handle water mark events.

Signed-off-by: Mario Huettel <mario.huettel@de.bosch.com>
---
 drivers/net/can/m_can/m_can.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 6797977..ddcbe8b 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -864,11 +864,11 @@ static void m_can_chip_config(struct net_device *dev)
 	/* rx fifo configuration, blocking mode, fifo size 1 */
 	m_can_write(priv, M_CAN_RXF0C,
 		    (priv->mcfg[MRAM_RXF0].num << RXFC_FS_OFF) |
-		    RXFC_FWM_1 | priv->mcfg[MRAM_RXF0].off);
+		     priv->mcfg[MRAM_RXF0].off);
 
 	m_can_write(priv, M_CAN_RXF1C,
 		    (priv->mcfg[MRAM_RXF1].num << RXFC_FS_OFF) |
-		    RXFC_FWM_1 | priv->mcfg[MRAM_RXF1].off);
+		     priv->mcfg[MRAM_RXF1].off);
 
 	cccr = m_can_read(priv, M_CAN_CCCR);
 	cccr &= ~(CCCR_TEST | CCCR_MON | (CCCR_CMR_MASK << CCCR_CMR_SHIFT) |
-- 
1.9.1

