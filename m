From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v6] can: sja1000: fix {pre,post}_irq() handling and IRQ handler return value
Date: Mon, 25 Nov 2013 00:03:40 +0100
Message-ID: <1385334220-31887-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42478 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760Ab3KXXDp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 24 Nov 2013 18:03:45 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Oliver Hartkopp <socketcan@hartkopp.net>

It has been reported that on PREEMPT_RT enabled system the peak SJA1000
hardware can trigger "irq X: nobody cared" errors.

This patch fixes the issue that the sja1000_interrupt() function may have
returned IRQ_NONE without processing the optional pre_irq() and post_irq()
function before. Further the irq processing counter 'n' is moved to the end of
the while statement to return correct IRQ_[NONE|HANDLED] values at error
conditions.

Reported-by: Wolfgang Grandegger <wg@grandegger.com>
Acked-by: Wolfgang Grandegger <wg@grandegger.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes since v5: make it one patch again.

 drivers/net/can/sja1000/sja1000.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 7164a99..f17c301 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -494,20 +494,20 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 	uint8_t isrc, status;
 	int n = 0;
 
-	/* Shared interrupts and IRQ off? */
-	if (priv->read_reg(priv, SJA1000_IER) == IRQ_OFF)
-		return IRQ_NONE;
-
 	if (priv->pre_irq)
 		priv->pre_irq(priv);
 
+	/* Shared interrupts and IRQ off? */
+	if (priv->read_reg(priv, SJA1000_IER) == IRQ_OFF)
+		goto out;
+
 	while ((isrc = priv->read_reg(priv, SJA1000_IR)) &&
 	       (n < SJA1000_MAX_IRQ)) {
-		n++;
+
 		status = priv->read_reg(priv, SJA1000_SR);
 		/* check for absent controller due to hw unplug */
 		if (status == 0xFF && sja1000_is_absent(priv))
-			return IRQ_NONE;
+			goto out;
 
 		if (isrc & IRQ_WUI)
 			netdev_warn(dev, "wakeup interrupt\n");
@@ -535,7 +535,7 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 				status = priv->read_reg(priv, SJA1000_SR);
 				/* check for absent controller */
 				if (status == 0xFF && sja1000_is_absent(priv))
-					return IRQ_NONE;
+					goto out;
 			}
 		}
 		if (isrc & (IRQ_DOI | IRQ_EI | IRQ_BEI | IRQ_EPI | IRQ_ALI)) {
@@ -543,8 +543,9 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 			if (sja1000_err(dev, isrc, status))
 				break;
 		}
+		n++;
 	}
-
+out:
 	if (priv->post_irq)
 		priv->post_irq(priv);
 
-- 
1.8.5.rc0

