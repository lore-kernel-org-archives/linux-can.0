From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH] can: c_can: Add d_can suspend resume support
Date: Fri, 21 Sep 2012 15:29:01 +0530
Message-ID: <1348221541-28878-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36945 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932742Ab2IUKAb (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 21 Sep 2012 06:00:31 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de
Cc: swarren@wwwdotorg.org, linux-can@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com, AnilKumar Ch <anilkumar@ti.com>

Adds suspend resume support to DCAN driver which enables
DCAN power down mode bit (PDR). Then DCAN will ack the local
power-down mode by setting PDA bit in STATUS register.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
Changes from v1:
	- Incorporated Marc's comments on v1
	  * Changed marco name to INIT_WAIT_MS from INIT_WAIT_COUNT.
	  * Added WARN_ON if device is not D_CAN in c_can_power_down/up
	    APIs.
	  * Added enum to c_can_priv data structure to hold device
	    type, C_CAN or D_CAN.

 drivers/net/can/c_can/c_can.c          |   78 ++++++++++++++++++++++++++++++++
 drivers/net/can/c_can/c_can.h          |    8 ++++
 drivers/net/can/c_can/c_can_platform.c |   62 +++++++++++++++++++++++++
 3 files changed, 148 insertions(+)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 768bb48..2c4a21f 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -46,6 +46,9 @@
 #define IF_ENUM_REG_LEN		11
 #define C_CAN_IFACE(reg, iface)	(C_CAN_IF1_##reg + (iface) * IF_ENUM_REG_LEN)
 
+/* control extension register D_CAN specific */
+#define CONTROL_EX_PDR		BIT(8)
+
 /* control register */
 #define CONTROL_TEST		BIT(7)
 #define CONTROL_CCE		BIT(6)
@@ -65,6 +68,7 @@
 #define TEST_BASIC		BIT(2)
 
 /* status register */
+#define STATUS_PDA		BIT(10)
 #define STATUS_BOFF		BIT(7)
 #define STATUS_EWARN		BIT(6)
 #define STATUS_EPASS		BIT(5)
@@ -164,6 +168,9 @@
 /* minimum timeout for checking BUSY status */
 #define MIN_TIMEOUT_VALUE	6
 
+/* Wait for ~1 sec for INIT bit */
+#define INIT_WAIT_MS		1000
+
 /* napi related */
 #define C_CAN_NAPI_WEIGHT	C_CAN_MSG_OBJ_RX_NUM
 
@@ -1153,6 +1160,77 @@ struct net_device *alloc_c_can_dev(void)
 }
 EXPORT_SYMBOL_GPL(alloc_c_can_dev);
 
+#ifdef CONFIG_PM
+int c_can_power_down(struct net_device *dev)
+{
+	u32 val;
+	unsigned long time_out;
+	struct c_can_priv *priv = netdev_priv(dev);
+
+	if (!(dev->flags & IFF_UP))
+		return 0;
+
+	WARN_ON(priv->type != BOSCH_D_CAN);
+
+	/* set PDR value so the device goes to power down mode */
+	val = priv->read_reg(priv, C_CAN_CTRL_EX_REG);
+	val |= CONTROL_EX_PDR;
+	priv->write_reg(priv, C_CAN_CTRL_EX_REG, val);
+
+	/* Wait for the PDA bit to get set */
+	time_out = jiffies + msecs_to_jiffies(INIT_WAIT_MS);
+	while (!(priv->read_reg(priv, C_CAN_STS_REG) & STATUS_PDA) &&
+				time_after(time_out, jiffies))
+		cpu_relax();
+
+	if (time_after(jiffies, time_out))
+		return -ETIMEDOUT;
+
+	c_can_stop(dev);
+
+	c_can_pm_runtime_put_sync(priv);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(c_can_power_down);
+
+int c_can_power_up(struct net_device *dev)
+{
+	u32 val;
+	unsigned long time_out;
+	struct c_can_priv *priv = netdev_priv(dev);
+
+	if (!(dev->flags & IFF_UP))
+		return 0;
+
+	WARN_ON(priv->type != BOSCH_D_CAN);
+
+	c_can_pm_runtime_get_sync(priv);
+
+	/* Clear PDR and INIT bits */
+	val = priv->read_reg(priv, C_CAN_CTRL_EX_REG);
+	val &= ~CONTROL_EX_PDR;
+	priv->write_reg(priv, C_CAN_CTRL_EX_REG, val);
+	val = priv->read_reg(priv, C_CAN_CTRL_REG);
+	val &= ~CONTROL_INIT;
+	priv->write_reg(priv, C_CAN_CTRL_REG, val);
+
+	/* Wait for the PDA bit to get clear */
+	time_out = jiffies + msecs_to_jiffies(INIT_WAIT_MS);
+	while ((priv->read_reg(priv, C_CAN_STS_REG) & STATUS_PDA) &&
+				time_after(time_out, jiffies))
+		cpu_relax();
+
+	if (time_after(jiffies, time_out))
+		return -ETIMEDOUT;
+
+	c_can_start(dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(c_can_power_up);
+#endif
+
 void free_c_can_dev(struct net_device *dev)
 {
 	free_candev(dev);
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 1437a6d..e5ed41d 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -24,6 +24,7 @@
 
 enum reg {
 	C_CAN_CTRL_REG = 0,
+	C_CAN_CTRL_EX_REG,
 	C_CAN_STS_REG,
 	C_CAN_ERR_CNT_REG,
 	C_CAN_BTR_REG,
@@ -104,6 +105,7 @@ static const u16 reg_map_c_can[] = {
 
 static const u16 reg_map_d_can[] = {
 	[C_CAN_CTRL_REG]	= 0x00,
+	[C_CAN_CTRL_EX_REG]	= 0x02,
 	[C_CAN_STS_REG]		= 0x04,
 	[C_CAN_ERR_CNT_REG]	= 0x08,
 	[C_CAN_BTR_REG]		= 0x0C,
@@ -166,6 +168,7 @@ struct c_can_priv {
 	unsigned int tx_echo;
 	void *priv;		/* for board-specific data */
 	u16 irqstatus;
+	enum c_can_dev_id type;
 };
 
 struct net_device *alloc_c_can_dev(void);
@@ -173,4 +176,9 @@ void free_c_can_dev(struct net_device *dev);
 int register_c_can_dev(struct net_device *dev);
 void unregister_c_can_dev(struct net_device *dev);
 
+#ifdef CONFIG_PM
+int c_can_power_up(struct net_device *dev);
+int c_can_power_down(struct net_device *dev);
+#endif
+
 #endif /* C_CAN_H */
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index d6b94b7..ee141613 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -189,6 +189,7 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 	priv->device = &pdev->dev;
 	priv->can.clock.freq = clk_get_rate(clk);
 	priv->priv = clk;
+	priv->type = id->driver_data;
 
 	platform_set_drvdata(pdev, dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
@@ -239,6 +240,65 @@ static int __devexit c_can_plat_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int c_can_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	int ret;
+	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct c_can_priv *priv = netdev_priv(ndev);
+
+	if (priv->type != BOSCH_D_CAN) {
+		dev_warn(&pdev->dev, "Not supported\n");
+		return 0;
+	}
+
+	if (netif_running(ndev)) {
+		netif_stop_queue(ndev);
+		netif_device_detach(ndev);
+	}
+
+	ret = c_can_power_down(ndev);
+	if (ret) {
+		netdev_err(ndev, "failed to enter power down mode\n");
+		return ret;
+	}
+
+	priv->can.state = CAN_STATE_SLEEPING;
+
+	return 0;
+}
+
+static int c_can_resume(struct platform_device *pdev)
+{
+	int ret;
+	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct c_can_priv *priv = netdev_priv(ndev);
+
+	if (priv->type != BOSCH_D_CAN) {
+		dev_warn(&pdev->dev, "Not supported\n");
+		return 0;
+	}
+
+	ret = c_can_power_up(ndev);
+	if (ret) {
+		netdev_err(ndev, "Still in power down mode\n");
+		return ret;
+	}
+
+	priv->can.state = CAN_STATE_ERROR_ACTIVE;
+
+	if (netif_running(ndev)) {
+		netif_device_attach(ndev);
+		netif_start_queue(ndev);
+	}
+
+	return 0;
+}
+#else
+#define c_can_suspend NULL
+#define c_can_resume NULL
+#endif
+
 static struct platform_driver c_can_plat_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
@@ -247,6 +307,8 @@ static struct platform_driver c_can_plat_driver = {
 	},
 	.probe = c_can_plat_probe,
 	.remove = __devexit_p(c_can_plat_remove),
+	.suspend = c_can_suspend,
+	.resume = c_can_resume,
 	.id_table = c_can_id_table,
 };
 
-- 
1.7.9.5

