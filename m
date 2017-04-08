From: =?UTF-8?q?Mario=20H=C3=BCttel?= <mario.huettel@gmx.net>
Subject: [PATCH v4 2/7] can: m_can: Removed initialization of FIFO water marks
Date: Sat,  8 Apr 2017 14:10:10 +0200
Message-ID: <20170408121015.11428-2-mario.huettel@gmx.net>
References: <20170408121015.11428-1-mario.huettel@gmx.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:55903 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751901AbdDHMKa (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sat, 8 Apr 2017 08:10:30 -0400
In-Reply-To: <20170408121015.11428-1-mario.huettel@gmx.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Mario Huettel <mario.huettel@gmx.net>

From: Mario Huettel <mario.huettel@gmx.net>

FIFO water marks disabled because the driver doesn't handle water mark events.

Signed-off-by: Mario Huettel <mario.huettel@gmx.net>
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

