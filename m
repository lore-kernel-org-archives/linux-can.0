From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v3] can: fix sja1000 pre_irq/post_irq handling
Date: Mon, 18 Nov 2013 14:01:14 +0100
Message-ID: <528A0F9A.6070305@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:40921 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616Ab3KRNBQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Nov 2013 08:01:16 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>

The SJA1000 driver provides optional function pointers to handle specific
hardware setups at interrupt time.

This patch fixes the issue that the sja1000_interrupt() function may have
returned IRQ_NONE without processing the post_irq function. Additionally
an introduced and documented return value from the pre_irq function is
checked to skip the entire interrupt handling on pre_irq function errors.

Reported-by: Wolfgang Grandegger <wg@grandegger.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

---

v2: move irq processing counter 'n' to the end of the while statement to
return correct IRQ_[NONE|HANDLED] values at error conditions.

v3: added comments about the pre_irq() return values.

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 7164a99..f7733d6 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -494,20 +494,21 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 	uint8_t isrc, status;
 	int n = 0;
 
+	/* skip irq handling if the optional pre_irq() returns non-zero */
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
-		n++;
+
 		status = priv->read_reg(priv, SJA1000_SR);
 		/* check for absent controller due to hw unplug */
 		if (status == 0xFF && sja1000_is_absent(priv))
-			return IRQ_NONE;
+			goto out;
 
 		if (isrc & IRQ_WUI)
 			netdev_warn(dev, "wakeup interrupt\n");
@@ -535,7 +536,7 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 				status = priv->read_reg(priv, SJA1000_SR);
 				/* check for absent controller */
 				if (status == 0xFF && sja1000_is_absent(priv))
-					return IRQ_NONE;
+					goto out;
 			}
 		}
 		if (isrc & (IRQ_DOI | IRQ_EI | IRQ_BEI | IRQ_EPI | IRQ_ALI)) {
@@ -543,8 +544,9 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 			if (sja1000_err(dev, isrc, status))
 				break;
 		}
+		n++;
 	}
-
+out:
 	if (priv->post_irq)
 		priv->post_irq(priv);
 
diff --git a/drivers/net/can/sja1000/sja1000.h b/drivers/net/can/sja1000/sja1000.h
index 9d46398..d7aaa42 100644
--- a/drivers/net/can/sja1000/sja1000.h
+++ b/drivers/net/can/sja1000/sja1000.h
@@ -157,7 +157,13 @@ struct sja1000_priv {
 	/* the lower-layer is responsible for appropriate locking */
 	u8 (*read_reg) (const struct sja1000_priv *priv, int reg);
 	void (*write_reg) (const struct sja1000_priv *priv, int reg, u8 val);
-	void (*pre_irq) (const struct sja1000_priv *priv);
+
+	/*
+	 * Hardware specific optional pre_irq() and post_irq() hooks.
+	 * When pre_irq() returns a non-zero value the sja1000 irq register
+	 * handling is skipped but post_irq() is still called.
+	 */
+	int (*pre_irq) (const struct sja1000_priv *priv);
 	void (*post_irq) (const struct sja1000_priv *priv);
 
 	void *priv;		/* for board-specific data */


