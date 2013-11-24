From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v5 2/2] can: sja1000: fix return value of interrupt handler
Date: Sun, 24 Nov 2013 22:45:01 +0100
Message-ID: <1385329501-28021-3-git-send-email-mkl@pengutronix.de>
References: <1385329501-28021-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45007 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003Ab3KXVpI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 24 Nov 2013 16:45:08 -0500
In-Reply-To: <1385329501-28021-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, kurt.van.dijck@eia.be, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Oliver Hartkopp <socketcan@hartkopp.net>

The irq processing counter 'n' is moved to the end of the while statement to
return correct IRQ_[NONE|HANDLED] values at error conditions.

Reported-by: Wolfgang Grandegger <wg@grandegger.com>
Acked-by: Wolfgang Grandegger <wg@grandegger.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/sja1000.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 253845f..f17c301 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -503,11 +503,11 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 
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
@@ -543,6 +543,7 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 			if (sja1000_err(dev, isrc, status))
 				break;
 		}
+		n++;
 	}
 out:
 	if (priv->post_irq)
-- 
1.8.5.rc0

