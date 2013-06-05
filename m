From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] flexcan: Enable/Disable the CAN regulator in probe/remove
Date: Wed,  5 Jun 2013 16:27:25 -0300
Message-ID: <1370460445-15386-2-git-send-email-festevam@gmail.com>
References: <1370460445-15386-1-git-send-email-festevam@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-gg0-f179.google.com ([209.85.161.179]:59065 "EHLO
	mail-gg0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757289Ab3FETfd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 5 Jun 2013 15:35:33 -0400
Received: by mail-gg0-f179.google.com with SMTP id c4so452281ggn.10
        for <linux-can@vger.kernel.org>; Wed, 05 Jun 2013 12:35:32 -0700 (PDT)
In-Reply-To: <1370460445-15386-1-git-send-email-festevam@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: shawn.guo@linaro.org, linux-can@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

mx28evk has two CAN ports and they are controlled by the same GPIO.

If can0 runs flexcan_chip_stop(), then the regulator will be disabled, which
means that can1 cannot run anymore.

To overcome such scenario, let's enable the CAN regulator in flexcan_probe()
and disabled it in flexcan_remove().

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/net/can/flexcan.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 3de02b1..456a549 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -792,12 +792,6 @@ static int flexcan_chip_start(struct net_device *dev)
 	if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES)
 		flexcan_write(0x0, &regs->rxfgmask);
 
-	if (priv->reg_xceiver)	{
-		err = regulator_enable(priv->reg_xceiver);
-		if (err)
-			goto out;
-	}
-
 	/* synchronize with the can bus */
 	reg_mcr = flexcan_read(&regs->mcr);
 	reg_mcr &= ~FLEXCAN_MCR_HALT;
@@ -839,8 +833,6 @@ static void flexcan_chip_stop(struct net_device *dev)
 	reg |= FLEXCAN_MCR_MDIS | FLEXCAN_MCR_HALT;
 	flexcan_write(reg, &regs->mcr);
 
-	if (priv->reg_xceiver)
-		regulator_disable(priv->reg_xceiver);
 	priv->can.state = CAN_STATE_STOPPED;
 
 	return;
@@ -1099,6 +1091,12 @@ static int flexcan_probe(struct platform_device *pdev)
 
 	devm_can_led_init(dev);
 
+	if (priv->reg_xceiver) {
+		err = regulator_enable(priv->reg_xceiver);
+		if (err)
+			goto failed_register;
+	}
+
 	dev_info(&pdev->dev, "device registered (reg_base=%p, irq=%d)\n",
 		 priv->base, dev->irq);
 
@@ -1122,6 +1120,9 @@ static int flexcan_remove(struct platform_device *pdev)
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct resource *mem;
 
+	if (priv->reg_xceiver)
+		regulator_disable(priv->reg_xceiver);
+
 	unregister_flexcandev(dev);
 	iounmap(priv->base);
 
-- 
1.8.1.2

