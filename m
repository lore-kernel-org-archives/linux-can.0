From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [RFC v2 2/7] c_can: rename callback "initram" to "init" to more general usage
Date: Thu, 29 Nov 2012 15:39:42 +0100
Message-ID: <1354199987-10350-3-git-send-email-wg@grandegger.com>
References: <1354199987-10350-1-git-send-email-wg@grandegger.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:44190 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754841Ab2K2Oj4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 29 Nov 2012 09:39:56 -0500
In-Reply-To: <1354199987-10350-1-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: bhupesh.sharma@st.com, tomoya.rohm@gmail.com, Wolfgang Grandegger <wg@grandegger.com>

The callback "init" is called with the argument "true" when the
device is opened and with "false" when it is closed allowing for
device specific initialization and cleanup, e.g. raminit or reset.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/c_can/c_can.c          |   16 ++++++++--------
 drivers/net/can/c_can/c_can.h          |    2 +-
 drivers/net/can/c_can/c_can_platform.c |    2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 5233b8f..3ae356f 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -233,10 +233,10 @@ static inline void c_can_pm_runtime_put_sync(const struct c_can_priv *priv)
 		pm_runtime_put_sync(priv->device);
 }
 
-static inline void c_can_reset_ram(const struct c_can_priv *priv, bool enable)
+static inline void c_can_init(const struct c_can_priv *priv, bool enable)
 {
-	if (priv->raminit)
-		priv->raminit(priv, enable);
+	if (priv->init)
+		priv->init(priv, enable);
 }
 
 static inline int get_tx_next_msg_obj(const struct c_can_priv *priv)
@@ -1096,7 +1096,7 @@ static int c_can_open(struct net_device *dev)
 	struct c_can_priv *priv = netdev_priv(dev);
 
 	c_can_pm_runtime_get_sync(priv);
-	c_can_reset_ram(priv, true);
+	c_can_init(priv, true);
 
 	/* open the can device */
 	err = open_candev(dev);
@@ -1125,7 +1125,7 @@ static int c_can_open(struct net_device *dev)
 exit_irq_fail:
 	close_candev(dev);
 exit_open_fail:
-	c_can_reset_ram(priv, false);
+	c_can_init(priv, false);
 	c_can_pm_runtime_put_sync(priv);
 	return err;
 }
@@ -1140,7 +1140,7 @@ static int c_can_close(struct net_device *dev)
 	free_irq(dev->irq, dev);
 	close_candev(dev);
 
-	c_can_reset_ram(priv, false);
+	c_can_init(priv, false);
 	c_can_pm_runtime_put_sync(priv);
 
 	return 0;
@@ -1198,7 +1198,7 @@ int c_can_power_down(struct net_device *dev)
 
 	c_can_stop(dev);
 
-	c_can_reset_ram(priv, false);
+	c_can_init(priv, false);
 	c_can_pm_runtime_put_sync(priv);
 
 	return 0;
@@ -1217,7 +1217,7 @@ int c_can_power_up(struct net_device *dev)
 	WARN_ON(priv->type != BOSCH_D_CAN);
 
 	c_can_pm_runtime_get_sync(priv);
-	c_can_reset_ram(priv, true);
+	c_can_init(priv, true);
 
 	/* Clear PDR and INIT bits */
 	val = priv->read_reg(priv, C_CAN_CTRL_EX_REG);
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index d2e1c21..4baf3f6 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -171,7 +171,7 @@ struct c_can_priv {
 	enum c_can_dev_id type;
 	u32 __iomem *raminit_ctrlreg;
 	unsigned int instance;
-	void (*raminit) (const struct c_can_priv *priv, bool enable);
+	void (*init) (const struct c_can_priv *priv, bool enable);
 };
 
 struct net_device *alloc_c_can_dev(void);
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 0044fd8..5619b9c 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -205,7 +205,7 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 		if (!priv->raminit_ctrlreg || priv->instance < 0)
 			dev_info(&pdev->dev, "control memory is not used for raminit\n");
 		else
-			priv->raminit = c_can_hw_raminit;
+			priv->init = c_can_hw_raminit;
 		break;
 	default:
 		ret = -EINVAL;
-- 
1.7.9.5

