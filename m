From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3] can: flexcan: Check the return value from clk_prepare_enable()
Date: Tue, 23 Jul 2013 12:14:17 +0200
Message-ID: <1374574457-28197-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39841 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756241Ab3GWKOW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 23 Jul 2013 06:14:22 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: fabio.estevam@freescale.com
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

From: Fabio Estevam <fabio.estevam@freescale.com>

clk_prepare_enable() may fail, so let's check its return value and propagate it
in the case of error.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello Fabio,

thanks for the patch, I've addresses some nitpicks:
- added "can: " prefix to the subject
- rename labels to have an uniform nameing scheme
- add one space in front of labels, to match the coding style of the driver

I've applied both patchs to my testing branch and will send a pull request to
David in about a week (this is after my holidays) if there are no objections.

regards,
Marc

 drivers/net/can/flexcan.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 9ca27e2..c48174e 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -850,12 +850,17 @@ static int flexcan_open(struct net_device *dev)
 	struct flexcan_priv *priv = netdev_priv(dev);
 	int err;
 
-	clk_prepare_enable(priv->clk_ipg);
-	clk_prepare_enable(priv->clk_per);
+	err = clk_prepare_enable(priv->clk_ipg);
+	if (err)
+		return err;
+
+	err = clk_prepare_enable(priv->clk_per);
+	if (err)
+		goto out_disable_ipg;
 
 	err = open_candev(dev);
 	if (err)
-		goto out;
+		goto out_disable_per;
 
 	err = request_irq(dev->irq, flexcan_irq, IRQF_SHARED, dev->name, dev);
 	if (err)
@@ -875,8 +880,9 @@ static int flexcan_open(struct net_device *dev)
 
  out_close:
 	close_candev(dev);
- out:
+ out_disable_per:
 	clk_disable_unprepare(priv->clk_per);
+ out_disable_ipg:
 	clk_disable_unprepare(priv->clk_ipg);
 
 	return err;
@@ -933,8 +939,13 @@ static int register_flexcandev(struct net_device *dev)
 	struct flexcan_regs __iomem *regs = priv->base;
 	u32 reg, err;
 
-	clk_prepare_enable(priv->clk_ipg);
-	clk_prepare_enable(priv->clk_per);
+	err = clk_prepare_enable(priv->clk_ipg);
+	if (err)
+		return err;
+
+	err = clk_prepare_enable(priv->clk_per);
+	if (err)
+		goto out_disable_ipg;
 
 	/* select "bus clock", chip must be disabled */
 	flexcan_chip_disable(priv);
@@ -959,15 +970,16 @@ static int register_flexcandev(struct net_device *dev)
 	if (!(reg & FLEXCAN_MCR_FEN)) {
 		netdev_err(dev, "Could not enable RX FIFO, unsupported core\n");
 		err = -ENODEV;
-		goto out;
+		goto out_disable_per;
 	}
 
 	err = register_candev(dev);
 
- out:
+ out_disable_per:
 	/* disable core and turn off clocks */
 	flexcan_chip_disable(priv);
 	clk_disable_unprepare(priv->clk_per);
+ out_disable_ipg:
 	clk_disable_unprepare(priv->clk_ipg);
 
 	return err;
-- 
1.8.3.1

