From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: c_can: remove struct c_can_priv::device, use struct net_device::dev.parent instead
Date: Mon,  5 Sep 2016 11:18:24 +0200
Message-ID: <20160905091824.18463-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:57779 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751648AbcIEJS3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 5 Sep 2016 05:18:29 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: tolvupostur@gmail.com, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

This patch remove the device member from the struct c_can_priv. All
users of device are converted to use struct net_device::dev.parent
instead.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello Einar,

can you please test if this patch fixes your problem.

Thanks,
Marc

 drivers/net/can/c_can/c_can.c          | 48 ++++++++++++++--------------------
 drivers/net/can/c_can/c_can.h          |  1 -
 drivers/net/can/c_can/c_can_platform.c |  1 -
 3 files changed, 20 insertions(+), 30 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index e3dccd3200d5..a3b6cca3f420 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -208,28 +208,24 @@ static const struct can_bittiming_const c_can_bittiming_const = {
 	.brp_inc = 1,
 };
 
-static inline void c_can_pm_runtime_enable(const struct c_can_priv *priv)
+static inline void c_can_pm_runtime_enable(const struct net_device *dev)
 {
-	if (priv->device)
-		pm_runtime_enable(priv->device);
+	pm_runtime_enable(dev->dev.parent);
 }
 
-static inline void c_can_pm_runtime_disable(const struct c_can_priv *priv)
+static inline void c_can_pm_runtime_disable(const struct net_device *dev)
 {
-	if (priv->device)
-		pm_runtime_disable(priv->device);
+	pm_runtime_disable(dev->dev.parent);
 }
 
-static inline void c_can_pm_runtime_get_sync(const struct c_can_priv *priv)
+static inline void c_can_pm_runtime_get_sync(const struct net_device *dev)
 {
-	if (priv->device)
-		pm_runtime_get_sync(priv->device);
+	pm_runtime_get_sync(dev->dev.parent);
 }
 
-static inline void c_can_pm_runtime_put_sync(const struct c_can_priv *priv)
+static inline void c_can_pm_runtime_put_sync(const struct net_device *dev)
 {
-	if (priv->device)
-		pm_runtime_put_sync(priv->device);
+	pm_runtime_put_sync(dev->dev.parent);
 }
 
 static inline void c_can_reset_ram(const struct c_can_priv *priv, bool enable)
@@ -630,11 +626,11 @@ static int c_can_start(struct net_device *dev)
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
 	/* Attempt to use "active" if available else use "default" */
-	p = pinctrl_get_select(priv->device, "active");
+	p = pinctrl_get_select(dev->dev.parent, "active");
 	if (!IS_ERR(p))
 		pinctrl_put(p);
 	else
-		pinctrl_pm_select_default_state(priv->device);
+		pinctrl_pm_select_default_state(dev->dev.parent);
 
 	return 0;
 }
@@ -690,12 +686,11 @@ static int __c_can_get_berr_counter(const struct net_device *dev,
 static int c_can_get_berr_counter(const struct net_device *dev,
 				  struct can_berr_counter *bec)
 {
-	struct c_can_priv *priv = netdev_priv(dev);
 	int err;
 
-	c_can_pm_runtime_get_sync(priv);
+	c_can_pm_runtime_get_sync(dev);
 	err = __c_can_get_berr_counter(dev, bec);
-	c_can_pm_runtime_put_sync(priv);
+	c_can_pm_runtime_put_sync(dev);
 
 	return err;
 }
@@ -1099,7 +1094,7 @@ static int c_can_open(struct net_device *dev)
 	int err;
 	struct c_can_priv *priv = netdev_priv(dev);
 
-	c_can_pm_runtime_get_sync(priv);
+	c_can_pm_runtime_get_sync(dev);
 	c_can_reset_ram(priv, true);
 
 	/* open the can device */
@@ -1137,7 +1132,7 @@ exit_irq_fail:
 	close_candev(dev);
 exit_open_fail:
 	c_can_reset_ram(priv, false);
-	c_can_pm_runtime_put_sync(priv);
+	c_can_pm_runtime_put_sync(dev);
 	return err;
 }
 
@@ -1152,7 +1147,7 @@ static int c_can_close(struct net_device *dev)
 	close_candev(dev);
 
 	c_can_reset_ram(priv, false);
-	c_can_pm_runtime_put_sync(priv);
+	c_can_pm_runtime_put_sync(dev);
 
 	can_led_event(dev, CAN_LED_EVENT_STOP);
 
@@ -1212,7 +1207,7 @@ int c_can_power_down(struct net_device *dev)
 	c_can_stop(dev);
 
 	c_can_reset_ram(priv, false);
-	c_can_pm_runtime_put_sync(priv);
+	c_can_pm_runtime_put_sync(dev);
 
 	return 0;
 }
@@ -1230,7 +1225,7 @@ int c_can_power_up(struct net_device *dev)
 
 	WARN_ON(priv->type != BOSCH_D_CAN);
 
-	c_can_pm_runtime_get_sync(priv);
+	c_can_pm_runtime_get_sync(dev);
 	c_can_reset_ram(priv, true);
 
 	/* Clear PDR and INIT bits */
@@ -1277,7 +1272,6 @@ static const struct net_device_ops c_can_netdev_ops = {
 
 int register_c_can_dev(struct net_device *dev)
 {
-	struct c_can_priv *priv = netdev_priv(dev);
 	int err;
 
 	/* Deactivate pins to prevent DRA7 DCAN IP from being
@@ -1287,14 +1281,14 @@ int register_c_can_dev(struct net_device *dev)
 	 */
 	pinctrl_pm_select_sleep_state(dev->dev.parent);
 
-	c_can_pm_runtime_enable(priv);
+	c_can_pm_runtime_enable(dev);
 
 	dev->flags |= IFF_ECHO;	/* we support local echo */
 	dev->netdev_ops = &c_can_netdev_ops;
 
 	err = register_candev(dev);
 	if (err)
-		c_can_pm_runtime_disable(priv);
+		c_can_pm_runtime_disable(dev);
 	else
 		devm_can_led_init(dev);
 
@@ -1304,11 +1298,9 @@ EXPORT_SYMBOL_GPL(register_c_can_dev);
 
 void unregister_c_can_dev(struct net_device *dev)
 {
-	struct c_can_priv *priv = netdev_priv(dev);
-
 	unregister_candev(dev);
 
-	c_can_pm_runtime_disable(priv);
+	c_can_pm_runtime_disable(dev);
 }
 EXPORT_SYMBOL_GPL(unregister_c_can_dev);
 
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 8acdc7fa4792..a6248a563da4 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -196,7 +196,6 @@ struct c_can_priv {
 	struct can_priv can;	/* must be the first member */
 	struct napi_struct napi;
 	struct net_device *dev;
-	struct device *device;
 	atomic_t tx_active;
 	unsigned long tx_dir;
 	int last_status;
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index e36d10520e24..8ada0830fc58 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -378,7 +378,6 @@ static int c_can_plat_probe(struct platform_device *pdev)
 
 	dev->irq = irq;
 	priv->base = addr;
-	priv->device = &pdev->dev;
 	priv->can.clock.freq = clk_get_rate(clk);
 	priv->priv = clk;
 	priv->type = drvdata->id;
-- 
2.9.3

