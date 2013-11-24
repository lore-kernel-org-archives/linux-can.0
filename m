From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v5 1/2] can: sja1000: fix pre_irq() and post_irq() handling
Date: Sun, 24 Nov 2013 22:45:00 +0100
Message-ID: <1385329501-28021-2-git-send-email-mkl@pengutronix.de>
References: <1385329501-28021-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45019 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821Ab3KXVpP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 24 Nov 2013 16:45:15 -0500
In-Reply-To: <1385329501-28021-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, kurt.van.dijck@eia.be, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Oliver Hartkopp <socketcan@hartkopp.net>

It has been reported that on PREEMPT_RT enabled system the peak SJA1000
hardware can trigger "irq X: nobody cared" errors.

This patch fixes the issue that the sja1000_interrupt() function may have
returned IRQ_NONE without processing the optional pre_irq() and post_irq()
function before.

Reported-by: Wolfgang Grandegger <wg@grandegger.com>
Acked-by: Wolfgang Grandegger <wg@grandegger.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/sja1000.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 7164a99..253845f 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -494,13 +494,13 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
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
 		n++;
@@ -544,7 +544,7 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 				break;
 		}
 	}
-
+out:
 	if (priv->post_irq)
 		priv->post_irq(priv);
 
-- 
1.8.5.rc0

