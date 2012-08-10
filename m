From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/2] can: sja1000_platform: fix wrong flag IRQF_SHARED for interrupt sharing
Date: Fri, 10 Aug 2012 10:54:22 +0200
Message-ID: <1344588862-26470-3-git-send-email-mkl@pengutronix.de>
References: <1344588862-26470-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39013 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab2HJIyg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Aug 2012 04:54:36 -0400
In-Reply-To: <1344588862-26470-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: "Schmitt, Sven (EVM/8)" <Sven.Schmitt@volkswagen.de>, Sven Schmitt <sven.schmitt@volkswagen.de>, Marc Kleine-Budde <mkl@pengutronix.de>

From: "Schmitt, Sven (EVM/8)" <Sven.Schmitt@volkswagen.de>

The sja1000 platform driver wrongly assumes that a shared IRQ is indicated
with the IRQF_SHARED flag in irq resource flags. This patch changes the
driver to handle the correct flag IORESOURCE_IRQ_SHAREABLE instead.

There are no mainline users of the platform driver which wrongly make use
of IRQF_SHARED.

Signed-off-by: Sven Schmitt <sven.schmitt@volkswagen.de>
Acked-by: Yegor Yefremov <yegorslists@googlemail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/sja1000_platform.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/sja1000_platform.c b/drivers/net/can/sja1000/sja1000_platform.c
index 4f50145..662c5f7 100644
--- a/drivers/net/can/sja1000/sja1000_platform.c
+++ b/drivers/net/can/sja1000/sja1000_platform.c
@@ -109,7 +109,9 @@ static int sp_probe(struct platform_device *pdev)
 	priv = netdev_priv(dev);
 
 	dev->irq = res_irq->start;
-	priv->irq_flags = res_irq->flags & (IRQF_TRIGGER_MASK | IRQF_SHARED);
+	priv->irq_flags = res_irq->flags & IRQF_TRIGGER_MASK;
+	if (res_irq->flags & IORESOURCE_IRQ_SHAREABLE)
+		priv->irq_flags |= IRQF_SHARED;
 	priv->reg_base = addr;
 	/* The CAN clock frequency is half the oscillator clock frequency */
 	priv->can.clock.freq = pdata->osc_freq / 2;
-- 
1.7.10

