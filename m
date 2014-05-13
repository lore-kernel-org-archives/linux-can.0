From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v4 3/3] can: c_can: add hwinit support for non-TI devices
Date: Tue, 13 May 2014 15:40:21 +0200
Message-ID: <1399988421-19429-4-git-send-email-mkl@pengutronix.de>
References: <1399988421-19429-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59075 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933429AbaEMNk0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 13 May 2014 09:40:26 -0400
In-Reply-To: <1399988421-19429-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Pavel Machek <pavel@denx.de>, Thor Thayer <tthayer@altera.com>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Pavel Machek <pavel@denx.de>

Non-TI chips (including socfpga) needs different raminit sequence. Implement
it.

Tested-by: Thor Thayer <tthayer@altera.com>
Signed-off-by: Thor Thayer <tthayer@altera.com>
Signed-off-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can.h          |  2 ++
 drivers/net/can/c_can/c_can_platform.c | 40 ++++++++++++++++++++++++++++++----
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 44433e1..99ad1aa 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -78,6 +78,7 @@ enum reg {
 	C_CAN_INTPND2_REG,
 	C_CAN_MSGVAL1_REG,
 	C_CAN_MSGVAL2_REG,
+	C_CAN_FUNCTION_REG,
 };
 
 static const u16 reg_map_c_can[] = {
@@ -129,6 +130,7 @@ static const u16 reg_map_d_can[] = {
 	[C_CAN_BRPEXT_REG]	= 0x0E,
 	[C_CAN_INT_REG]		= 0x10,
 	[C_CAN_TEST_REG]	= 0x14,
+	[C_CAN_FUNCTION_REG]	= 0x18,
 	[C_CAN_TXRQST1_REG]	= 0x88,
 	[C_CAN_TXRQST2_REG]	= 0x8A,
 	[C_CAN_NEWDAT1_REG]	= 0x9C,
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index e71bb76..a560953 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -40,6 +40,7 @@
 #define CAN_RAMINIT_START_MASK(i)	(0x001 << (i))
 #define CAN_RAMINIT_DONE_MASK(i)	(0x100 << (i))
 #define CAN_RAMINIT_ALL_MASK(i)		(0x101 << (i))
+#define DCAN_RAM_INIT_BIT	(1 << 3)
 static DEFINE_SPINLOCK(raminit_lock);
 /*
  * 16-bit c_can registers can be arranged differently in the memory
@@ -80,7 +81,7 @@ static void c_can_hw_raminit_wait_ti(const struct c_can_priv *priv, u32 mask,
 		udelay(1);
 }
 
-static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
+static void c_can_hw_raminit_ti(const struct c_can_priv *priv, bool enable)
 {
 	u32 mask = CAN_RAMINIT_ALL_MASK(priv->instance);
 	u32 ctrl;
@@ -96,14 +97,14 @@ static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
 	ctrl |= CAN_RAMINIT_DONE_MASK(priv->instance);
 	writel(ctrl, priv->raminit_ctrlreg);
 	ctrl &= ~CAN_RAMINIT_DONE_MASK(priv->instance);
-	c_can_hw_raminit_wait(priv, ctrl, mask);
+	c_can_hw_raminit_wait_ti(priv, ctrl, mask);
 
 	if (enable) {
 		/* Set start bit and wait for the done bit. */
 		ctrl |= CAN_RAMINIT_START_MASK(priv->instance);
 		writel(ctrl, priv->raminit_ctrlreg);
 		ctrl |= CAN_RAMINIT_DONE_MASK(priv->instance);
-		c_can_hw_raminit_wait(priv, ctrl, mask);
+		c_can_hw_raminit_wait_ti(priv, ctrl, mask);
 	}
 	spin_unlock(&raminit_lock);
 }
@@ -136,6 +137,28 @@ static void d_can_plat_write_reg32(const struct c_can_priv *priv, enum reg index
 	writel(val, priv->base + priv->regs[index]);
 }
 
+static void c_can_hw_raminit_wait(const struct c_can_priv *priv, u32 mask)
+{
+	while (priv->read_reg32(priv, C_CAN_FUNCTION_REG) & mask)
+		udelay(1);
+}
+
+static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
+{
+	u32 ctrl;
+
+	ctrl = priv->read_reg32(priv, C_CAN_FUNCTION_REG);
+	ctrl &= ~DCAN_RAM_INIT_BIT;
+	priv->write_reg32(priv, C_CAN_FUNCTION_REG, ctrl);
+	c_can_hw_raminit_wait(priv, ctrl);
+
+	if (enable) {
+		ctrl |= DCAN_RAM_INIT_BIT;
+		priv->write_reg32(priv, C_CAN_FUNCTION_REG, ctrl);
+		c_can_hw_raminit_wait(priv, ctrl);
+	}
+}
+
 static struct platform_device_id c_can_id_table[] = {
 	[BOSCH_C_CAN_PLATFORM] = {
 		.name = KBUILD_MODNAME,
@@ -255,11 +278,20 @@ static int c_can_plat_probe(struct platform_device *pdev)
 			priv->instance = pdev->id;
 
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		/* Not all D_CAN modules have a separate register for the D_CAN
+		 * RAM initialization. Use default RAM init bit in D_CAN module
+		 * if not specified in DT.
+		 */
+		if (!res) {
+			priv->raminit = c_can_hw_raminit;
+			break;
+		}
+
 		priv->raminit_ctrlreg = devm_ioremap_resource(&pdev->dev, res);
 		if (IS_ERR(priv->raminit_ctrlreg) || priv->instance < 0)
 			dev_info(&pdev->dev, "control memory is not used for raminit\n");
 		else
-			priv->raminit = c_can_hw_raminit;
+			priv->raminit = c_can_hw_raminit_ti;
 		break;
 	default:
 		ret = -EINVAL;
-- 
2.0.0.rc0

