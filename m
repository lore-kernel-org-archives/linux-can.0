From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 01/11] can: flexcan: fix state transition regression
Date: Thu, 19 Oct 2017 13:19:35 +0200
Message-ID: <20171019111945.13580-2-mkl@pengutronix.de>
References: <20171019111945.13580-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:50625 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752794AbdJSLTy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Oct 2017 07:19:54 -0400
In-Reply-To: <20171019111945.13580-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, Zhu Yi <yi.zhu5@cn.bosch.com>, Mark Jonas <mark.jonas@de.bosch.com>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>

From: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>

Update state upon any interrupt to report correct state transitions in
case the flexcan core enabled the broken error state quirk fix.

Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
Acked-by: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-stable <stable@vger.kernel.org> # >= v4.11
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 13f0f219d8aa..df4bfb83024c 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -765,8 +765,9 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		flexcan_write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
 	}
 
-	/* state change interrupt */
-	if (reg_esr & FLEXCAN_ESR_ERR_STATE)
+	/* state change interrupt or broken error state quirk fix is enabled */
+	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
+	    (priv->devtype_data->quirks & FLEXCAN_QUIRK_BROKEN_ERR_STATE))
 		flexcan_irq_state(dev, reg_esr);
 
 	/* bus error IRQ - handle if bus error reporting is activated */
-- 
2.14.2

