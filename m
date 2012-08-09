From: "Schmitt, Sven (EVM/8)" <Sven.Schmitt@volkswagen.de>
Subject: AW: Fwd: [Socketcan-users] sja1000_platform interrupt sharing
Date: Thu, 9 Aug 2012 14:46:34 +0200
Message-ID: <6C5A3B79888A804CAB605257CD26D37703955B60@vwagwox00032.vw.vwg>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mr1.volkswagen.de ([194.114.62.75]:48473 "EHLO
	mr1.volkswagen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932418Ab2HIMrI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Aug 2012 08:47:08 -0400
Content-class: urn:content-classes:message
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
Cc: yegor_sub1@visionsystems.de, linux-can@vger.kernel.org

Second try:

Signed-off-by: Sven Schmitt <sven.schmitt@volkswagen.de>

--- linux-3.5/drivers/net/can/sja1000/sja1000_platform.c.orig
+++ linux-3.5/drivers/net/can/sja1000/sja1000_platform.c
@@ -109,7 +109,9 @@ static int sp_probe(struct platform_devi
 	priv = netdev_priv(dev);
 
 	dev->irq = res_irq->start;
-	priv->irq_flags = res_irq->flags & (IRQF_TRIGGER_MASK |
IRQF_SHARED);
+	priv->irq_flags &= IRQF_TRIGGER_MASK;
+	if (res_irq->flags & IORESOURCE_IRQ_SHAREABLE)
+		priv->irq_flags |= IRQF_SHARED;
 	priv->reg_base = addr;
 	/* The CAN clock frequency is half the oscillator clock
frequency */
 	priv->can.clock.freq = pdata->osc_freq / 2;


note: patch is compile tested only.

Sven
