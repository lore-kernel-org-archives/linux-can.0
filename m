From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v10] can: c_can: Add runtime PM support to Bosch C_CAN/D_CAN controller
Date: Thu, 13 Sep 2012 10:34:23 +0200
Message-ID: <1347525263-28414-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60008 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651Ab2IMIeZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 13 Sep 2012 04:34:25 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: anilkumar@ti.com, Marc Kleine-Budde <mkl@pengutronix.de>

From: AnilKumar Ch <anilkumar@ti.com>

Add Runtime PM support to C_CAN/D_CAN controller. The runtime PM
APIs control clocks for C_CAN/D_CAN IP and prevent access to the
register of C_CAN/D_CAN IP when clock is turned off.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello,

I've squashed both patches into one, also changed:
- add and use c_can_pm_runtime_{enable,disable}
- remove leftovers from c_can_platform.c
- cleaned up error path in register_c_can_dev

Please test.

Marc

 drivers/net/can/c_can/c_can.c          |   49 ++++++++++++++++++++++++++++++--
 drivers/net/can/c_can/c_can.h          |    1 +
 drivers/net/can/c_can/c_can_platform.c |    1 +
 3 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 4c538e3..768bb48 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -34,6 +34,7 @@
 #include <linux/if_ether.h>
 #include <linux/list.h>
 #include <linux/io.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/can.h>
 #include <linux/can/dev.h>
@@ -201,6 +202,30 @@ static const struct can_bittiming_const c_can_bittiming_const = {
 	.brp_inc = 1,
 };
 
+static inline void c_can_pm_runtime_enable(const struct c_can_priv *priv)
+{
+	if (priv->device)
+		pm_runtime_enable(priv->device);
+}
+
+static inline void c_can_pm_runtime_disable(const struct c_can_priv *priv)
+{
+	if (priv->device)
+		pm_runtime_disable(priv->device);
+}
+
+static inline void c_can_pm_runtime_get_sync(const struct c_can_priv *priv)
+{
+	if (priv->device)
+		pm_runtime_get_sync(priv->device);
+}
+
+static inline void c_can_pm_runtime_put_sync(const struct c_can_priv *priv)
+{
+	if (priv->device)
+		pm_runtime_put_sync(priv->device);
+}
+
 static inline int get_tx_next_msg_obj(const struct c_can_priv *priv)
 {
 	return (priv->tx_next & C_CAN_NEXT_MSG_OBJ_MASK) +
@@ -673,11 +698,15 @@ static int c_can_get_berr_counter(const struct net_device *dev,
 	unsigned int reg_err_counter;
 	struct c_can_priv *priv = netdev_priv(dev);
 
+	c_can_pm_runtime_get_sync(priv);
+
 	reg_err_counter = priv->read_reg(priv, C_CAN_ERR_CNT_REG);
 	bec->rxerr = (reg_err_counter & ERR_CNT_REC_MASK) >>
 				ERR_CNT_REC_SHIFT;
 	bec->txerr = reg_err_counter & ERR_CNT_TEC_MASK;
 
+	c_can_pm_runtime_put_sync(priv);
+
 	return 0;
 }
 
@@ -1053,11 +1082,13 @@ static int c_can_open(struct net_device *dev)
 	int err;
 	struct c_can_priv *priv = netdev_priv(dev);
 
+	c_can_pm_runtime_get_sync(priv);
+
 	/* open the can device */
 	err = open_candev(dev);
 	if (err) {
 		netdev_err(dev, "failed to open can device\n");
-		return err;
+		goto exit_open_fail;
 	}
 
 	/* register interrupt handler */
@@ -1079,6 +1110,8 @@ static int c_can_open(struct net_device *dev)
 
 exit_irq_fail:
 	close_candev(dev);
+exit_open_fail:
+	c_can_pm_runtime_put_sync(priv);
 	return err;
 }
 
@@ -1091,6 +1124,7 @@ static int c_can_close(struct net_device *dev)
 	c_can_stop(dev);
 	free_irq(dev->irq, dev);
 	close_candev(dev);
+	c_can_pm_runtime_put_sync(priv);
 
 	return 0;
 }
@@ -1133,10 +1167,19 @@ static const struct net_device_ops c_can_netdev_ops = {
 
 int register_c_can_dev(struct net_device *dev)
 {
+	struct c_can_priv *priv = netdev_priv(dev);
+	int err;
+
+	c_can_pm_runtime_enable(priv);
+
 	dev->flags |= IFF_ECHO;	/* we support local echo */
 	dev->netdev_ops = &c_can_netdev_ops;
 
-	return register_candev(dev);
+	err = register_candev(dev);
+	if (err)
+		c_can_pm_runtime_disable(priv);
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(register_c_can_dev);
 
@@ -1148,6 +1191,8 @@ void unregister_c_can_dev(struct net_device *dev)
 	c_can_enable_all_interrupts(priv, DISABLE_ALL_INTERRUPTS);
 
 	unregister_candev(dev);
+
+	c_can_pm_runtime_disable(priv);
 }
 EXPORT_SYMBOL_GPL(unregister_c_can_dev);
 
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 4e56baa..1437a6d 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -153,6 +153,7 @@ struct c_can_priv {
 	struct can_priv can;	/* must be the first member */
 	struct napi_struct napi;
 	struct net_device *dev;
+	struct device *device;
 	int tx_object;
 	int current_status;
 	int last_status;
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index d0a66cf..7b8b7a4 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -179,6 +179,7 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 
 	dev->irq = irq;
 	priv->base = addr;
+	priv->device = &pdev->dev;
 	priv->can.clock.freq = clk_get_rate(clk);
 	priv->priv = clk;
 
-- 
1.7.10

