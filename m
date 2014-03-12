From: <tthayer.linux@gmail.com>
Subject: [PATCH] net: can: c_can_platform: Add D_CAN Module RAM Init
Date: Wed, 12 Mar 2014 18:01:27 -0500
Message-ID: <1394665287-9687-2-git-send-email-tthayer.linux@gmail.com>
References: <1394665287-9687-1-git-send-email-tthayer.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bl2on0117.outbound.protection.outlook.com ([65.55.169.117]:61178
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752254AbaCLXOK (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 12 Mar 2014 19:14:10 -0400
In-Reply-To: <1394665287-9687-1-git-send-email-tthayer.linux@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, anilkumar@ti.com
Cc: linux-can@vger.kernel.org, Thor Thayer <tthayer@altera.com>, Thor Thayer <tthayer.linux@gmail.com>

From: Thor Thayer <tthayer@altera.com>

The D_CAN driver was written to support the TI D_CAN implementation
which placed the D_CAN RAM reset in a separate register. In the
standard D_CAN module case the RAM Init is in the D_CAN module so
handle the RAM Init differently.

Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: AnilKumar Ch <anilkumar@ti.com>
Cc: linux-can@vger.kernel.org
Signed-off-by: Thor Thayer <tthayer.linux@gmail.com>
---
 drivers/net/can/c_can/c_can.h          |    3 +++
 drivers/net/can/c_can/c_can_platform.c |   21 ++++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index d2e1c21..be2dc65 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -61,6 +61,7 @@ enum reg {
 	C_CAN_INTPND2_REG,
 	C_CAN_MSGVAL1_REG,
 	C_CAN_MSGVAL2_REG,
+	C_CAN_FUNCTION_REG,
 };
 
 static const u16 reg_map_c_can[] = {
@@ -112,6 +113,7 @@ static const u16 reg_map_d_can[] = {
 	[C_CAN_BRPEXT_REG]	= 0x0E,
 	[C_CAN_INT_REG]		= 0x10,
 	[C_CAN_TEST_REG]	= 0x14,
+	[C_CAN_FUNCTION_REG]	= 0x18,
 	[C_CAN_TXRQST1_REG]	= 0x88,
 	[C_CAN_TXRQST2_REG]	= 0x8A,
 	[C_CAN_NEWDAT1_REG]	= 0x9C,
@@ -172,6 +174,7 @@ struct c_can_priv {
 	u32 __iomem *raminit_ctrlreg;
 	unsigned int instance;
 	void (*raminit) (const struct c_can_priv *priv, bool enable);
+	unsigned int raminit_bit;
 };
 
 struct net_device *alloc_c_can_dev(void);
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index d66ac26..b4e62f1 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -38,6 +38,7 @@
 #include "c_can.h"
 
 #define CAN_RAMINIT_START_MASK(i)	(1 << (i))
+#define DCAN_RAM_INIT_BIT		3
 
 /*
  * 16-bit c_can registers can be arranged differently in the memory
@@ -75,9 +76,9 @@ static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
 
 	val = readl(priv->raminit_ctrlreg);
 	if (enable)
-		val |= CAN_RAMINIT_START_MASK(priv->instance);
+		val |= CAN_RAMINIT_START_MASK(priv->raminit_bit);
 	else
-		val &= ~CAN_RAMINIT_START_MASK(priv->instance);
+		val &= ~CAN_RAMINIT_START_MASK(priv->raminit_bit);
 	writel(val, priv->raminit_ctrlreg);
 }
 
@@ -194,11 +195,25 @@ static int c_can_plat_probe(struct platform_device *pdev)
 			priv->instance = pdev->id;
 
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-		priv->raminit_ctrlreg = devm_ioremap_resource(&pdev->dev, res);
+		/* Not all D_CAN module have a separate register for the D_CAN
+		 * RAM initialization. Use default RAM init bit in D_CAN module
+		 * if not specified in DT.
+		 */
+		if (!res) {
+			priv->raminit = c_can_hw_raminit;
+			priv->raminit_bit = DCAN_RAM_INIT_BIT;
+			priv->raminit_ctrlreg = addr +
+				priv->regs[C_CAN_FUNCTION_REG];
+			break;
+		} else {
+			priv->raminit_ctrlreg =
+				devm_ioremap_resource(&pdev->dev, res);
+		}
 		if (IS_ERR(priv->raminit_ctrlreg) || (int)priv->instance < 0)
 			dev_info(&pdev->dev, "control memory is not used for raminit\n");
 		else
 			priv->raminit = c_can_hw_raminit;
+			priv->raminit_bit = priv->instance;
 		break;
 	default:
 		ret = -EINVAL;
-- 
1.7.9.5

