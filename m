From: Matthias Klein <matthias.klein@optimeas.de>
Subject: [PATCH 1/5] net: can: flexcan: provide propper return code in ISR
Date: Fri, 25 Jul 2014 20:16:38 +0200
Message-ID: <1406312202-2542-1-git-send-email-matthias.klein@optimeas.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from obi-wan.optimeas.de ([82.165.198.204]:60850 "EHLO
	obi-wan.optimeas.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757667AbaGYSYF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 25 Jul 2014 14:24:05 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org, support@karo-electronics.de
Cc: bigeasy@linutronix.de

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

flexcan_irq() always returns IRQ_HANDLED no matter if it actually did
something or not. If the CAN interface is brought up without BERR
reporting on a SoC which has the FLEXCAN_HAS_BROKEN_ERR_STATE feature
then ERR reporting is activated but not really handled. That means on an
open bus one receives a lot of STF_ERR and the only thing that happens
is that the number of interrupts is incremented.
This patch ensures that in such a case the core has a chance to detect
such (or similar) misbehavior and disable the interrupt line.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Matthias Klein <matthias.klein@optimeas.de>
---
 drivers/net/can/flexcan.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index e381142..f677b49 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -641,6 +641,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->base;
 	u32 reg_iflag1, reg_esr;
+	int worked = 0;
 
 	reg_iflag1 = flexcan_read(&regs->iflag1);
 	reg_esr = flexcan_read(&regs->esr);
@@ -667,6 +668,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		flexcan_write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
 		       &regs->ctrl);
 		napi_schedule(&priv->napi);
+		worked = 1;
 	}
 
 	/* FIFO overflow */
@@ -674,6 +676,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		flexcan_write(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW, &regs->iflag1);
 		dev->stats.rx_over_errors++;
 		dev->stats.rx_errors++;
+		worked = 1;
 	}
 
 	/* transmission complete interrupt */
@@ -683,9 +686,12 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		can_led_event(dev, CAN_LED_EVENT_TX);
 		flexcan_write((1 << FLEXCAN_TX_BUF_ID), &regs->iflag1);
 		netif_wake_queue(dev);
+		worked = 1;
 	}
-
-	return IRQ_HANDLED;
+	if (worked)
+		return IRQ_HANDLED;
+	else
+		return IRQ_NONE;
 }
 
 static void flexcan_set_bittiming(struct net_device *dev)
-- 
2.0.1

