From: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
Subject: [PATCH 1/4] can: flexcan: fix state transition regression
Date: Tue, 5 Sep 2017 08:35:12 +0000
Message-ID: <9c3cb87be139427a8e494db2b35fa854@SGPMBX1017.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:51890 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750718AbdIEIfQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 5 Sep 2017 04:35:16 -0400
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

From 1e051141a28594d80e2564bc0dde9b1954479551 Mon Sep 17 00:00:00 2001
From: Zhu Yi <yi.zhu5@cn.bosch.com>
Date: Wed, 30 Aug 2017 13:57:50 +0800
Subject: [PATCH 1/4] can: flexcan: fix state transition regression

Update state upon any interrupt to report correct state transitions
in case the flexcan core enabled the broken error state quirk fix.

Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
---
 drivers/net/can/flexcan.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 13f0f21..df4bfb8 100644
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
2.7.4



