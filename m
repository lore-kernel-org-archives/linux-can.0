From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: RFC: [PATCH] can: mcp251x: add missing IRQF_ONESHOT to request_threaded_irq
Date: Thu, 11 Apr 2013 10:36:50 +0200
Message-ID: <1365669410-8101-1-git-send-email-mkl@pengutronix.de>
References: <51666B21.10109@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53155 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154Ab3DKIgx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 11 Apr 2013 04:36:53 -0400
In-Reply-To: <51666B21.10109@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Mylene.Josserand@navocap.com, Marc Kleine-Budde <mkl@pengutronix.de>

Since commit:

    1c6c695 genirq: Reject bogus threaded irq requests

threaded irqs must provide a primary handler or set the IRQF_ONESHOT flag.
Since the mcp251x driver doesn't make use of a primary handler set the
IRQF_ONESHOT flag.

/* Cc: linux-stable <stable@vger.kernel.org> # >= v3.5 */
Reported-by: Mylene Josserand <Mylene.Josserand@navocap.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/mcp251x.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
index f32b9fc..9aa0c64 100644
--- a/drivers/net/can/mcp251x.c
+++ b/drivers/net/can/mcp251x.c
@@ -929,6 +929,7 @@ static int mcp251x_open(struct net_device *net)
 	struct mcp251x_priv *priv = netdev_priv(net);
 	struct spi_device *spi = priv->spi;
 	struct mcp251x_platform_data *pdata = spi->dev.platform_data;
+	unsigned long flags;
 	int ret;
 
 	ret = open_candev(net);
@@ -945,9 +946,14 @@ static int mcp251x_open(struct net_device *net)
 	priv->tx_skb = NULL;
 	priv->tx_len = 0;
 
+	flags = IRQF_ONESHOT;
+	if (pdata->irq_flags)
+		flags |= pdata->irq_flags;
+	else
+		flags |= IRQF_TRIGGER_FALLING;
+
 	ret = request_threaded_irq(spi->irq, NULL, mcp251x_can_ist,
-		  pdata->irq_flags ? pdata->irq_flags : IRQF_TRIGGER_FALLING,
-		  DEVICE_NAME, priv);
+				   flags, DEVICE_NAME, priv);
 	if (ret) {
 		dev_err(&spi->dev, "failed to acquire irq %d\n", spi->irq);
 		if (pdata->transceiver_enable)
-- 
1.8.2.rc2

