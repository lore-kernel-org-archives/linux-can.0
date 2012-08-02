From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v4 1/3] can: c_can: Modify c_can device names
Date: Thu, 2 Aug 2012 18:43:09 +0530
Message-ID: <1343913191-14722-2-git-send-email-anilkumar@ti.com>
References: <1343913191-14722-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34904 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753406Ab2HBNNc (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 2 Aug 2012 09:13:32 -0400
In-Reply-To: <1343913191-14722-1-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, anantgole@ti.com, nsekhar@ti.com, AnilKumar Ch <anilkumar@ti.com>

Modify c_can device names from *_CAN_DEVTYPE to BOSCH_*_CAN to make
use of same names for array indexes in c_can_id_table[] as well as
device names.

This patch also add indexes to c_can_id_table array.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 drivers/net/can/c_can/c_can.h          |    5 +++--
 drivers/net/can/c_can/c_can_pci.c      |    6 +++---
 drivers/net/can/c_can/c_can_platform.c |   18 ++++++++++--------
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 01a7049..4e56baa 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -143,8 +143,9 @@ static const u16 reg_map_d_can[] = {
 };
 
 enum c_can_dev_id {
-	C_CAN_DEVTYPE,
-	D_CAN_DEVTYPE,
+	BOSCH_C_CAN_PLATFORM,
+	BOSCH_C_CAN,
+	BOSCH_D_CAN,
 };
 
 /* c_can private data structure */
diff --git a/drivers/net/can/c_can/c_can_pci.c b/drivers/net/can/c_can/c_can_pci.c
index 1011146..3d7830b 100644
--- a/drivers/net/can/c_can/c_can_pci.c
+++ b/drivers/net/can/c_can/c_can_pci.c
@@ -120,10 +120,10 @@ static int __devinit c_can_pci_probe(struct pci_dev *pdev,
 
 	/* Configure CAN type */
 	switch (c_can_pci_data->type) {
-	case C_CAN_DEVTYPE:
+	case BOSCH_C_CAN:
 		priv->regs = reg_map_c_can;
 		break;
-	case D_CAN_DEVTYPE:
+	case BOSCH_D_CAN:
 		priv->regs = reg_map_d_can;
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
 		break;
@@ -192,7 +192,7 @@ static void __devexit c_can_pci_remove(struct pci_dev *pdev)
 }
 
 static struct c_can_pci_data c_can_sta2x11= {
-	.type = C_CAN_DEVTYPE,
+	.type = BOSCH_C_CAN,
 	.reg_align = C_CAN_REG_ALIGN_32,
 	.freq = 52000000, /* 52 Mhz */
 };
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 6ff7ad0..5c46d1c 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -116,7 +116,7 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 	priv = netdev_priv(dev);
 	id = platform_get_device_id(pdev);
 	switch (id->driver_data) {
-	case C_CAN_DEVTYPE:
+	case BOSCH_C_CAN:
 		priv->regs = reg_map_c_can;
 		switch (mem->flags & IORESOURCE_MEM_TYPE_MASK) {
 		case IORESOURCE_MEM_32BIT:
@@ -130,7 +130,7 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 			break;
 		}
 		break;
-	case D_CAN_DEVTYPE:
+	case BOSCH_D_CAN:
 		priv->regs = reg_map_d_can;
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
 		priv->read_reg = c_can_plat_read_reg_aligned_to_16bit;
@@ -196,15 +196,17 @@ static int __devexit c_can_plat_remove(struct platform_device *pdev)
 }
 
 static const struct platform_device_id c_can_id_table[] = {
-	{
+	[BOSCH_C_CAN_PLATFORM] = {
 		.name = KBUILD_MODNAME,
-		.driver_data = C_CAN_DEVTYPE,
-	}, {
+		.driver_data = BOSCH_C_CAN,
+	},
+	[BOSCH_C_CAN] = {
 		.name = "c_can",
-		.driver_data = C_CAN_DEVTYPE,
-	}, {
+		.driver_data = BOSCH_C_CAN,
+	},
+	[BOSCH_D_CAN] = {
 		.name = "d_can",
-		.driver_data = D_CAN_DEVTYPE,
+		.driver_data = BOSCH_D_CAN,
 	}, {
 	}
 };
-- 
1.7.9.5

