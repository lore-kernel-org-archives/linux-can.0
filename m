From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v4 2/3] can: c_can: Add and make use of 32-bit accesses functions
Date: Tue, 13 May 2014 15:40:20 +0200
Message-ID: <1399988421-19429-3-git-send-email-mkl@pengutronix.de>
References: <1399988421-19429-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59073 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933404AbaEMNk0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 13 May 2014 09:40:26 -0400
In-Reply-To: <1399988421-19429-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Pavel Machek <pavel@denx.de>, Thor Thayer <tthayer@altera.com>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Pavel Machek <pavel@denx.de>

Add helpers for 32-bit accesses and replace open-coded 32-bit access
with calls to helpers. Minimum changes are done to the pci case, as I
don't have access to that hardware.

Tested-by: Thor Thayer <tthayer@altera.com>
Signed-off-by: Thor Thayer <tthayer@altera.com>
Signed-off-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can.c          | 15 +++++----------
 drivers/net/can/c_can/c_can.h          |  2 ++
 drivers/net/can/c_can/c_can_pci.c      | 19 +++++++++++++++++++
 drivers/net/can/c_can/c_can_platform.c | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index a2ca820..e154b4c 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -252,8 +252,7 @@ static void c_can_obj_update(struct net_device *dev, int iface, u32 cmd, u32 obj
 	struct c_can_priv *priv = netdev_priv(dev);
 	int cnt, reg = C_CAN_IFACE(COMREQ_REG, iface);
 
-	priv->write_reg(priv, reg + 1, cmd);
-	priv->write_reg(priv, reg, obj);
+	priv->write_reg32(priv, reg, (cmd << 16) | obj);
 
 	for (cnt = MIN_TIMEOUT_VALUE; cnt; cnt--) {
 		if (!(priv->read_reg(priv, reg) & IF_COMR_BUSY))
@@ -328,8 +327,7 @@ static void c_can_setup_tx_object(struct net_device *dev, int iface,
 		change_bit(idx, &priv->tx_dir);
 	}
 
-	priv->write_reg(priv, C_CAN_IFACE(ARB1_REG, iface), arb);
-	priv->write_reg(priv, C_CAN_IFACE(ARB2_REG, iface), arb >> 16);
+	priv->write_reg32(priv, C_CAN_IFACE(ARB1_REG, iface), arb);
 
 	priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface), ctrl);
 
@@ -391,8 +389,7 @@ static int c_can_read_msg_object(struct net_device *dev, int iface, u32 ctrl)
 
 	frame->can_dlc = get_can_dlc(ctrl & 0x0F);
 
-	arb = priv->read_reg(priv, C_CAN_IFACE(ARB1_REG, iface));
-	arb |= priv->read_reg(priv, C_CAN_IFACE(ARB2_REG, iface)) << 16;
+	arb = priv->read_reg32(priv, C_CAN_IFACE(ARB1_REG, iface));
 
 	if (arb & IF_ARB_MSGXTD)
 		frame->can_id = (arb & CAN_EFF_MASK) | CAN_EFF_FLAG;
@@ -424,12 +421,10 @@ static void c_can_setup_receive_object(struct net_device *dev, int iface,
 	struct c_can_priv *priv = netdev_priv(dev);
 
 	mask |= BIT(29);
-	priv->write_reg(priv, C_CAN_IFACE(MASK1_REG, iface), mask);
-	priv->write_reg(priv, C_CAN_IFACE(MASK2_REG, iface), mask >> 16);
+	priv->write_reg32(priv, C_CAN_IFACE(MASK1_REG, iface), mask);
 
 	id |= IF_ARB_MSGVAL;
-	priv->write_reg(priv, C_CAN_IFACE(ARB1_REG, iface), id);
-	priv->write_reg(priv, C_CAN_IFACE(ARB2_REG, iface), id >> 16);
+	priv->write_reg32(priv, C_CAN_IFACE(ARB1_REG, iface), id);
 
 	priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface), mcont);
 	c_can_object_put(dev, iface, obj, IF_COMM_RCV_SETUP);
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index b948b55..44433e1 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -178,6 +178,8 @@ struct c_can_priv {
 	int last_status;
 	u16 (*read_reg) (const struct c_can_priv *priv, enum reg index);
 	void (*write_reg) (const struct c_can_priv *priv, enum reg index, u16 val);
+	u32 (*read_reg32) (const struct c_can_priv *priv, enum reg index);
+	void (*write_reg32) (const struct c_can_priv *priv, enum reg index, u32 val);
 	void __iomem *base;
 	const u16 *regs;
 	void *priv;		/* for board-specific data */
diff --git a/drivers/net/can/c_can/c_can_pci.c b/drivers/net/can/c_can/c_can_pci.c
index 58f71e1..db14880 100644
--- a/drivers/net/can/c_can/c_can_pci.c
+++ b/drivers/net/can/c_can/c_can_pci.c
@@ -83,6 +83,23 @@ static void c_can_pci_write_reg_32bit(struct c_can_priv *priv,
 	iowrite32((u32)val, priv->base + 2 * priv->regs[index]);
 }
 
+static u32 c_can_plat_read_reg32(struct c_can_priv *priv, enum reg index)
+{
+	u32 val;
+
+	val = priv->read_reg(priv, index);
+	val |= ((u32) priv->read_reg(priv, index + 1)) << 16;
+
+	return val;
+}
+
+static void c_can_plat_write_reg32(struct c_can_priv *priv, enum reg index,
+		u32 val)
+{
+	priv->write_reg(priv, index + 1, val >> 16);
+	priv->write_reg(priv, index, val);
+}
+
 static void c_can_pci_reset_pch(const struct c_can_priv *priv, bool enable)
 {
 	if (enable) {
@@ -187,6 +204,8 @@ static int c_can_pci_probe(struct pci_dev *pdev,
 		ret = -EINVAL;
 		goto out_free_c_can;
 	}
+	priv->read_reg32 = c_can_plat_read_reg32;
+	priv->write_reg32 = c_can_plat_write_reg32;
 
 	priv->raminit = c_can_pci_data->init;
 
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 0b44f4d..e71bb76 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -108,6 +108,34 @@ static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
 	spin_unlock(&raminit_lock);
 }
 
+static u32 c_can_plat_read_reg32(const struct c_can_priv *priv, enum reg index)
+{
+	u32 val;
+
+	val = priv->read_reg(priv, index);
+	val |= ((u32) priv->read_reg(priv, index + 1)) << 16;
+
+	return val;
+}
+
+static void c_can_plat_write_reg32(const struct c_can_priv *priv, enum reg index,
+		u32 val)
+{
+	priv->write_reg(priv, index + 1, val>>16);
+	priv->write_reg(priv, index, val);
+}
+
+static u32 d_can_plat_read_reg32(const struct c_can_priv *priv, enum reg index)
+{
+	return readl(priv->base + priv->regs[index]);
+}
+
+static void d_can_plat_write_reg32(const struct c_can_priv *priv, enum reg index,
+		u32 val)
+{
+	writel(val, priv->base + priv->regs[index]);
+}
+
 static struct platform_device_id c_can_id_table[] = {
 	[BOSCH_C_CAN_PLATFORM] = {
 		.name = KBUILD_MODNAME,
@@ -201,11 +229,15 @@ static int c_can_plat_probe(struct platform_device *pdev)
 		case IORESOURCE_MEM_32BIT:
 			priv->read_reg = c_can_plat_read_reg_aligned_to_32bit;
 			priv->write_reg = c_can_plat_write_reg_aligned_to_32bit;
+			priv->read_reg32 = c_can_plat_read_reg32;
+			priv->write_reg32 = c_can_plat_write_reg32;
 			break;
 		case IORESOURCE_MEM_16BIT:
 		default:
 			priv->read_reg = c_can_plat_read_reg_aligned_to_16bit;
 			priv->write_reg = c_can_plat_write_reg_aligned_to_16bit;
+			priv->read_reg32 = c_can_plat_read_reg32;
+			priv->write_reg32 = c_can_plat_write_reg32;
 			break;
 		}
 		break;
@@ -214,6 +246,8 @@ static int c_can_plat_probe(struct platform_device *pdev)
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
 		priv->read_reg = c_can_plat_read_reg_aligned_to_16bit;
 		priv->write_reg = c_can_plat_write_reg_aligned_to_16bit;
+		priv->read_reg32 = d_can_plat_read_reg32;
+		priv->write_reg32 = d_can_plat_write_reg32;
 
 		if (pdev->dev.of_node)
 			priv->instance = of_alias_get_id(pdev->dev.of_node, "d_can");
-- 
2.0.0.rc0

