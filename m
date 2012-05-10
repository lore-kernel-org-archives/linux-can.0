From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v2 4/4] can: c_can: Add support for Bosch D_CAN controller
Date: Thu, 10 May 2012 17:04:17 +0530
Message-ID: <1336649657-4152-5-git-send-email-anilkumar@ti.com>
References: <1336649657-4152-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57786 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758869Ab2EJLfa (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 10 May 2012 07:35:30 -0400
In-Reply-To: <1336649657-4152-1-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: anantgole@ti.com, nsekhar@ti.com, AnilKumar Ch <anilkumar@ti.com>

This patch adds the support for D_CAN controller driver to the existing
C_CAN driver.

Bosch D_CAN controller is a full-CAN implementation which is compliant
to CAN protocol version 2.0 part A and B. Bosch D_CAN user manual can be
obtained from: http://www.semiconductors.bosch.de/media/en/pdf/
ipmodules_1/can/d_can_users_manual_111.pdf

A new array is added for accessing the d_can registers, according to d_can
controller register space.

Current D_CAN implementation has following limitations, this is done
to avoid large changes to the C_CAN driver.
1. Message objects are limited to 32, 16 for RX and 16 for TX. C_CAN IP
   supports upto 32 message objects but in case of D_CAN we can configure
   upto 128 message objects.
2. Using two 16bit reads/writes for accessing the 32bit D_CAN registers.
3. These patches have been tested on little endian machine, there might
   be some hidden endian-related issues due to the nature of the accesses
   (32-bit registers accessed as 2 16-bit registers). However, I do not
   have a big-endian D_CAN implementation to confirm.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 drivers/net/can/c_can/c_can.h          |   30 ++++++++++++++++++++++
 drivers/net/can/c_can/c_can_platform.c |   31 +++++++++++++----------
 include/linux/can/platform/c_can.h     |   42 ++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+), 13 deletions(-)
 create mode 100644 include/linux/can/platform/c_can.h

diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 747d478..63a8727 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -80,6 +80,35 @@ static u16 reg_map_c_can[] = {
 	[C_CAN_MSGVAL2_REG]	= 0xB2,
 };
 
+static u16 reg_map_d_can[] = {
+	[C_CAN_CTRL_REG]	= 0x00,
+	[C_CAN_STS_REG]		= 0x04,
+	[C_CAN_ERR_CNT_REG]	= 0x08,
+	[C_CAN_BTR_REG]		= 0x0C,
+	[C_CAN_BRPEXT_REG]	= 0x0E,
+	[C_CAN_INT_REG]		= 0x10,
+	[C_CAN_TEST_REG]	= 0x14,
+	[C_CAN_TXRQST1_REG]	= 0x88,
+	[C_CAN_TXRQST2_REG]	= 0x8A,
+	[C_CAN_NEWDAT1_REG]	= 0x9C,
+	[C_CAN_NEWDAT2_REG]	= 0x9E,
+	[C_CAN_INTPND1_REG]	= 0xB0,
+	[C_CAN_INTPND2_REG]	= 0xB2,
+	[C_CAN_MSGVAL1_REG]	= 0xC4,
+	[C_CAN_MSGVAL2_REG]	= 0xC6,
+	[C_CAN_IF1_COMREQ_REG]	= 0x100,
+	[C_CAN_IF1_COMMSK_REG]	= 0x102,
+	[C_CAN_IF1_MASK1_REG]	= 0x104,
+	[C_CAN_IF1_MASK2_REG]	= 0x106,
+	[C_CAN_IF1_ARB1_REG]	= 0x108,
+	[C_CAN_IF1_ARB2_REG]	= 0x10A,
+	[C_CAN_IF1_MSGCTRL_REG]	= 0x10C,
+	[C_CAN_IF1_DATA1_REG]	= 0x110,
+	[C_CAN_IF1_DATA2_REG]	= 0x112,
+	[C_CAN_IF1_DATA3_REG]	= 0x114,
+	[C_CAN_IF1_DATA4_REG]	= 0x116,
+};
+
 /* c_can private data structure */
 struct c_can_priv {
 	struct can_priv can;	/* must be the first member */
@@ -97,6 +126,7 @@ struct c_can_priv {
 	unsigned int tx_echo;
 	void *priv;		/* for board-specific data */
 	u16 irqstatus;
+	unsigned int dev_type;
 };
 
 struct net_device *alloc_c_can_dev(void);
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 0cca9db..394b05d 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -117,7 +117,24 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 	}
 
 	priv = netdev_priv(dev);
-	priv->regs = reg_map_c_can;
+	if (pdata && (pdata->dev_type == DEV_TYPE_D_CAN)) {
+		priv->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
+		priv->dev_type = DEV_TYPE_D_CAN;
+		priv->regs = reg_map_d_can;
+		priv->read_reg = c_can_plat_read_reg_aligned_to_16bit;
+		priv->write_reg = c_can_plat_write_reg_aligned_to_16bit;
+	} else {
+		priv->dev_type = DEV_TYPE_C_CAN;
+		priv->regs = reg_map_c_can;
+		if ((mem->flags & IORESOURCE_MEM_TYPE_MASK) ==
+					IORESOURCE_MEM_32BIT) {
+			priv->read_reg = c_can_plat_read_reg_aligned_to_32bit;
+			priv->write_reg = c_can_plat_write_reg_aligned_to_32bit;
+		} else {
+			priv->read_reg = c_can_plat_read_reg_aligned_to_16bit;
+			priv->write_reg = c_can_plat_write_reg_aligned_to_16bit;
+		}
+	}
 
 	dev->irq = irq;
 	priv->base = addr;
@@ -126,18 +143,6 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 	priv->priv = clk;
 #endif
 
-	switch (mem->flags & IORESOURCE_MEM_TYPE_MASK) {
-	case IORESOURCE_MEM_32BIT:
-		priv->read_reg = c_can_plat_read_reg_aligned_to_32bit;
-		priv->write_reg = c_can_plat_write_reg_aligned_to_32bit;
-		break;
-	case IORESOURCE_MEM_16BIT:
-	default:
-		priv->read_reg = c_can_plat_read_reg_aligned_to_16bit;
-		priv->write_reg = c_can_plat_write_reg_aligned_to_16bit;
-		break;
-	}
-
 	platform_set_drvdata(pdev, dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
diff --git a/include/linux/can/platform/c_can.h b/include/linux/can/platform/c_can.h
new file mode 100644
index 0000000..e95201a
--- /dev/null
+++ b/include/linux/can/platform/c_can.h
@@ -0,0 +1,42 @@
+/*
+ * C_CAN controller driver platform header
+ *
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * Bosch C_CAN/D_CAN controller is compliant to CAN protocol version 2.0
+ * part A and B.
+ * Bosch C_CAN user manual can be obtained from:
+ * http://www.semiconductors.bosch.de/media/en/pdf/ipmodules_1/c_can/
+ * users_manual_c_can.pdf
+ * Bosch D_CAN user manual can be obtained from:
+ * http://www.semiconductors.bosch.de/media/en/pdf/ipmodules_1/can/
+ * d_can_users_manual_111.pdf
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __CAN_PLATFORM_TI_C_CAN_H__
+#define __CAN_PLATFORM_TI_C_CAN_H__
+
+#define DEV_TYPE_C_CAN		0
+#define DEV_TYPE_D_CAN		1
+
+/**
+ * struct c_can_platform_data - CCAN Platform Data
+ *
+ * @dev_type:		Device type C_CAN/D_CAN
+ *
+ * Platform data structure to get all platform specific settings.
+ */
+
+struct c_can_platform_data {
+	unsigned int dev_type;
+};
+#endif
-- 
1.7.0.4

