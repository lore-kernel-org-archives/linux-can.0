From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [RFC: PATCH 4/5] can: sja1000_platform: factor out initialization from platform data
Date: Fri,  5 Oct 2012 16:39:06 +0200
Message-ID: <1349447947-18451-5-git-send-email-mkl@pengutronix.de>
References: <1349447947-18451-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38406 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754802Ab2JEOjS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 5 Oct 2012 10:39:18 -0400
In-Reply-To: <1349447947-18451-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: andreas@gaisler.com, kernel@pengutronix.de, wg@grandegger.com, Marc Kleine-Budde <mkl@pengutronix.de>

This patch moves the initialization from the "sp_probe()" function into a
seperate function. This prepares the driver for the device tree bindings coming
in the next patch.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/sja1000_platform.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000_platform.c b/drivers/net/can/sja1000/sja1000_platform.c
index b0ce5ef..6260209 100644
--- a/drivers/net/can/sja1000/sja1000_platform.c
+++ b/drivers/net/can/sja1000/sja1000_platform.c
@@ -64,6 +64,14 @@ static void sp_write_reg32(const struct sja1000_priv *priv, int reg, u8 val)
 	iowrite8(val, priv->reg_base + reg * 4);
 }
 
+static void __devinit sp_probe_pdata(struct sja1000_priv *priv, const struct sja1000_platform_data *pdata)
+{
+	/* The CAN clock frequency is half the oscillator clock frequency */
+	priv->can.clock.freq = pdata->osc_freq / 2;
+	priv->ocr = pdata->ocr;
+	priv->cdr = pdata->cdr;
+}
+
 static int __devinit sp_probe(struct platform_device *pdev)
 {
 	int err;
@@ -71,7 +79,7 @@ static int __devinit sp_probe(struct platform_device *pdev)
 	struct net_device *dev;
 	struct sja1000_priv *priv;
 	struct resource *res_mem, *res_irq;
-	struct sja1000_platform_data *pdata;
+	const struct sja1000_platform_data *pdata;
 
 	pdata = pdev->dev.platform_data;
 	if (!pdata) {
@@ -105,10 +113,8 @@ static int __devinit sp_probe(struct platform_device *pdev)
 	if (res_irq->flags & IORESOURCE_IRQ_SHAREABLE)
 		priv->irq_flags |= IRQF_SHARED;
 	priv->reg_base = addr;
-	/* The CAN clock frequency is half the oscillator clock frequency */
-	priv->can.clock.freq = pdata->osc_freq / 2;
-	priv->ocr = pdata->ocr;
-	priv->cdr = pdata->cdr;
+
+	sp_probe_pdata(priv, pdata);
 
 	switch (res_mem->flags & IORESOURCE_MEM_TYPE_MASK) {
 	case IORESOURCE_MEM_32BIT:
-- 
1.7.10

