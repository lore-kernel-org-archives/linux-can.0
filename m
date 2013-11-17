From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: fix sja1000 pre_irq/post_irq handling
Date: Sun, 17 Nov 2013 15:17:19 +0100
Message-ID: <5288CFEF.3060701@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:61726 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951Ab3KQORX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 17 Nov 2013 09:17:23 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>

The SJA1000 driver provides optional function pointers to handle specific
hardware setups at interrupt time.

This patch fixes the issue that the sja1000_interrupt() function may have
returned IRQ_NONE without processing the post_irq function. Additionally
an introduced return value from the pre_irq function is checked to skip the
entire interrupt handling on pre_irq function errors.

Reported-by: Wolfgang Grandegger <wg@grandegger.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

---

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 7164a99..bb20470 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -494,12 +494,12 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 	uint8_t isrc, status;
 	int n = 0;
 
+	if (priv->pre_irq && priv->pre_irq(priv))
+		goto out;
+
 	/* Shared interrupts and IRQ off? */
 	if (priv->read_reg(priv, SJA1000_IER) == IRQ_OFF)
-		return IRQ_NONE;
-
-	if (priv->pre_irq)
-		priv->pre_irq(priv);
+		goto out;
 
 	while ((isrc = priv->read_reg(priv, SJA1000_IR)) &&
 	       (n < SJA1000_MAX_IRQ)) {
@@ -507,7 +507,7 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
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
@@ -544,7 +544,7 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 				break;
 		}
 	}
-
+out:
 	if (priv->post_irq)
 		priv->post_irq(priv);
 
diff --git a/drivers/net/can/sja1000/sja1000.h b/drivers/net/can/sja1000/sja1000.h
index 9d46398..53c9797 100644
--- a/drivers/net/can/sja1000/sja1000.h
+++ b/drivers/net/can/sja1000/sja1000.h
@@ -157,7 +157,7 @@ struct sja1000_priv {
 	/* the lower-layer is responsible for appropriate locking */
 	u8 (*read_reg) (const struct sja1000_priv *priv, int reg);
 	void (*write_reg) (const struct sja1000_priv *priv, int reg, u8 val);
-	void (*pre_irq) (const struct sja1000_priv *priv);
+	int (*pre_irq) (const struct sja1000_priv *priv);
 	void (*post_irq) (const struct sja1000_priv *priv);
 
 	void *priv;		/* for board-specific data */
