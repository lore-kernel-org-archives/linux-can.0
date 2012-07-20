From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/9] can: mark bittiming_const pointer in struct can_priv as const
Date: Fri, 20 Jul 2012 13:11:41 +0200
Message-ID: <1342782709-4868-2-git-send-email-mkl@pengutronix.de>
References: <1342782709-4868-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42079 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274Ab2GTLLy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Jul 2012 07:11:54 -0400
In-Reply-To: <1342782709-4868-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: "Ira W. Snyder" <iws@ovro.caltech.edu>, Marc Kleine-Budde <mkl@pengutronix.de>

This patch marks the bittiming_const pointer as in the struct can_pric as
"const". This allows us to mark the struct can_bittiming_const in the CAN
drivers as "const", too.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c                   |    2 +-
 drivers/net/can/bfin_can.c                   |    2 +-
 drivers/net/can/c_can/c_can.c                |    2 +-
 drivers/net/can/cc770/cc770.c                |    2 +-
 drivers/net/can/flexcan.c                    |    2 +-
 drivers/net/can/janz-ican3.c                 |    2 +-
 drivers/net/can/mcp251x.c                    |    2 +-
 drivers/net/can/mscan/mscan.c                |    2 +-
 drivers/net/can/pch_can.c                    |    2 +-
 drivers/net/can/sja1000/sja1000.c            |    2 +-
 drivers/net/can/ti_hecc.c                    |    2 +-
 drivers/net/can/usb/ems_usb.c                |    2 +-
 drivers/net/can/usb/esd_usb2.c               |    2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |    2 +-
 include/linux/can/dev.h                      |    2 +-
 15 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 6ea905c..fcff73a 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -170,7 +170,7 @@ static const struct at91_devtype_data at91_devtype_data[] __devinitconst = {
 	},
 };
 
-static struct can_bittiming_const at91_bittiming_const = {
+static const struct can_bittiming_const at91_bittiming_const = {
 	.name		= KBUILD_MODNAME,
 	.tseg1_min	= 4,
 	.tseg1_max	= 16,
diff --git a/drivers/net/can/bfin_can.c b/drivers/net/can/bfin_can.c
index ea31438..f2d6d25 100644
--- a/drivers/net/can/bfin_can.c
+++ b/drivers/net/can/bfin_can.c
@@ -44,7 +44,7 @@ struct bfin_can_priv {
 /*
  * bfin can timing parameters
  */
-static struct can_bittiming_const bfin_can_bittiming_const = {
+static const struct can_bittiming_const bfin_can_bittiming_const = {
 	.name = DRV_NAME,
 	.tseg1_min = 1,
 	.tseg1_max = 16,
diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index eea6608..4c538e3 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -189,7 +189,7 @@ enum c_can_bus_error_types {
 	C_CAN_ERROR_PASSIVE,
 };
 
-static struct can_bittiming_const c_can_bittiming_const = {
+static const struct can_bittiming_const c_can_bittiming_const = {
 	.name = KBUILD_MODNAME,
 	.tseg1_min = 2,		/* Time segment 1 = prop_seg + phase_seg1 */
 	.tseg1_max = 16,
diff --git a/drivers/net/can/cc770/cc770.c b/drivers/net/can/cc770/cc770.c
index a138db1..0f12abf 100644
--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -90,7 +90,7 @@ static unsigned char cc770_obj_flags[CC770_OBJ_MAX] = {
 	[CC770_OBJ_TX] = 0,
 };
 
-static struct can_bittiming_const cc770_bittiming_const = {
+static const struct can_bittiming_const cc770_bittiming_const = {
 	.name = KBUILD_MODNAME,
 	.tseg1_min = 1,
 	.tseg1_max = 16,
diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 1b6f562..c8a6fc7 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -203,7 +203,7 @@ static struct flexcan_devtype_data fsl_imx6q_devtype_data = {
 	.hw_ver = 10,
 };
 
-static struct can_bittiming_const flexcan_bittiming_const = {
+static const struct can_bittiming_const flexcan_bittiming_const = {
 	.name = DRV_NAME,
 	.tseg1_min = 4,
 	.tseg1_max = 16,
diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 08c893c..e7d1532 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -1490,7 +1490,7 @@ static const struct net_device_ops ican3_netdev_ops = {
  */
 
 /* This structure was stolen from drivers/net/can/sja1000/sja1000.c */
-static struct can_bittiming_const ican3_bittiming_const = {
+static const struct can_bittiming_const ican3_bittiming_const = {
 	.name = DRV_NAME,
 	.tseg1_min = 1,
 	.tseg1_max = 16,
diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
index 9120a36..a580db2 100644
--- a/drivers/net/can/mcp251x.c
+++ b/drivers/net/can/mcp251x.c
@@ -214,7 +214,7 @@ static int mcp251x_enable_dma; /* Enable SPI DMA. Default: 0 (Off) */
 module_param(mcp251x_enable_dma, int, S_IRUGO);
 MODULE_PARM_DESC(mcp251x_enable_dma, "Enable SPI DMA. Default: 0 (Off)");
 
-static struct can_bittiming_const mcp251x_bittiming_const = {
+static const struct can_bittiming_const mcp251x_bittiming_const = {
 	.name = DEVICE_NAME,
 	.tseg1_min = 3,
 	.tseg1_max = 16,
diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
index 41a2a2d..2b104d5 100644
--- a/drivers/net/can/mscan/mscan.c
+++ b/drivers/net/can/mscan/mscan.c
@@ -34,7 +34,7 @@
 
 #include "mscan.h"
 
-static struct can_bittiming_const mscan_bittiming_const = {
+static const struct can_bittiming_const mscan_bittiming_const = {
 	.name = "mscan",
 	.tseg1_min = 4,
 	.tseg1_max = 16,
diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
index 1226297..48b3d62 100644
--- a/drivers/net/can/pch_can.c
+++ b/drivers/net/can/pch_can.c
@@ -184,7 +184,7 @@ struct pch_can_priv {
 	int use_msi;
 };
 
-static struct can_bittiming_const pch_can_bittiming_const = {
+static const struct can_bittiming_const pch_can_bittiming_const = {
 	.name = KBUILD_MODNAME,
 	.tseg1_min = 2,
 	.tseg1_max = 16,
diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 5e10472..4c4f33d 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -69,7 +69,7 @@ MODULE_AUTHOR("Oliver Hartkopp <oliver.hartkopp@volkswagen.de>");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DESCRIPTION(DRV_NAME "CAN netdevice driver");
 
-static struct can_bittiming_const sja1000_bittiming_const = {
+static const struct can_bittiming_const sja1000_bittiming_const = {
 	.name = DRV_NAME,
 	.tseg1_min = 1,
 	.tseg1_max = 16,
diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index 4accd7e..527dbcf 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -196,7 +196,7 @@ MODULE_VERSION(HECC_MODULE_VERSION);
 #define HECC_CANGIM_SIL		BIT(2)	/* system interrupts to int line 1 */
 
 /* CAN Bittiming constants as per HECC specs */
-static struct can_bittiming_const ti_hecc_bittiming_const = {
+static const struct can_bittiming_const ti_hecc_bittiming_const = {
 	.name = DRV_NAME,
 	.tseg1_min = 1,
 	.tseg1_max = 16,
diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 7ae65fc..086fa32 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -889,7 +889,7 @@ static const struct net_device_ops ems_usb_netdev_ops = {
 	.ndo_start_xmit = ems_usb_start_xmit,
 };
 
-static struct can_bittiming_const ems_usb_bittiming_const = {
+static const struct can_bittiming_const ems_usb_bittiming_const = {
 	.name = "ems_usb",
 	.tseg1_min = 1,
 	.tseg1_max = 16,
diff --git a/drivers/net/can/usb/esd_usb2.c b/drivers/net/can/usb/esd_usb2.c
index 09b1da5..bd36e55 100644
--- a/drivers/net/can/usb/esd_usb2.c
+++ b/drivers/net/can/usb/esd_usb2.c
@@ -871,7 +871,7 @@ static const struct net_device_ops esd_usb2_netdev_ops = {
 	.ndo_start_xmit = esd_usb2_start_xmit,
 };
 
-static struct can_bittiming_const esd_usb2_bittiming_const = {
+static const struct can_bittiming_const esd_usb2_bittiming_const = {
 	.name = "esd_usb2",
 	.tseg1_min = ESD_USB2_TSEG1_MIN,
 	.tseg1_max = ESD_USB2_TSEG1_MAX,
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index a948c5a..4c775b6 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -45,7 +45,7 @@ struct peak_usb_adapter {
 	char *name;
 	u32 device_id;
 	struct can_clock clock;
-	struct can_bittiming_const bittiming_const;
+	const struct can_bittiming_const bittiming_const;
 	unsigned int ctrl_count;
 
 	int (*intf_probe)(struct usb_interface *intf);
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index ee5a771..2b2fc34 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -33,7 +33,7 @@ struct can_priv {
 	struct can_device_stats can_stats;
 
 	struct can_bittiming bittiming;
-	struct can_bittiming_const *bittiming_const;
+	const struct can_bittiming_const *bittiming_const;
 	struct can_clock clock;
 
 	enum can_state state;
-- 
1.7.10

