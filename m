From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2] can: sja1000 fix isr hang when hw is unplugged under load
Date: Wed, 15 Feb 2012 17:51:56 +0100
Message-ID: <4F3BE2AC.9020108@hartkopp.net>
References: <1318506157-10329-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:61389 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab2BOQwR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 15 Feb 2012 11:52:17 -0500
Received: from [109.40.207.183]
	(ip-109-40-207-183.web.vodafone.de [109.40.207.183])
	by smtp.strato.de (jimi mo43) (RZmta 27.6 DYNA|AUTH)
	with ESMTPA id Q0128do1FFEwD3 for <linux-can@vger.kernel.org>;
	Wed, 15 Feb 2012 17:52:00 +0100 (MET)
In-Reply-To: <1318506157-10329-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

In the case of hotplug enabled devices (PCMCIA/PCIeC) the removal of the
hardware can cause an infinite loop in the common sja1000 isr.

Use the already retrieved status register to indicate a possible hardware
removal and double check by reading the mode register in sja1000_is_absent.

v2: Create a new function to not print information in irq context.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

---

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 04a3f1b..192b0d1 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -95,11 +95,16 @@ static void sja1000_write_cmdreg(struct sja1000_priv *priv, u8 val)
 	spin_unlock_irqrestore(&priv->cmdreg_lock, flags);
 }
 
+static int sja1000_is_absent(struct sja1000_priv *priv)
+{
+	return (priv->read_reg(priv, REG_MOD) == 0xFF);
+}
+
 static int sja1000_probe_chip(struct net_device *dev)
 {
 	struct sja1000_priv *priv = netdev_priv(dev);
 
-	if (priv->reg_base && (priv->read_reg(priv, 0) == 0xFF)) {
+	if (priv->reg_base && sja1000_is_absent(priv)) {
 		printk(KERN_INFO "%s: probing @0x%lX failed\n",
 		       DRV_NAME, dev->base_addr);
 		return 0;
@@ -493,6 +498,9 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 	while ((isrc = priv->read_reg(priv, REG_IR)) && (n < SJA1000_MAX_IRQ)) {
 		n++;
 		status = priv->read_reg(priv, REG_SR);
+		/* check for absent controller due to hw unplug */
+		if (status == 0xFF && sja1000_is_absent(priv))
+			return IRQ_NONE;
 
 		if (isrc & IRQ_WUI)
 			dev_warn(dev->dev.parent, "wakeup interrupt\n");
@@ -509,6 +517,9 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 			while (status & SR_RBS) {
 				sja1000_rx(dev);
 				status = priv->read_reg(priv, REG_SR);
+				/* check for absent controller */
+				if (status == 0xFF && sja1000_is_absent(priv))
+					return IRQ_NONE;
 			}
 		}
 		if (isrc & (IRQ_DOI | IRQ_EI | IRQ_BEI | IRQ_EPI | IRQ_ALI)) {

