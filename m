Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD29041C71;
	Wed, 16 Sep 2026 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565585; cv=none; b=aDP9NKktc+hqlS5l1eusf+euJpRaD0YS+kaCJVIMGF+YugXCiUuLk8XSsSoTw4YXyuHL1RkDM09jUrdfvpekguW1c5dpl+tBZy7e76jBV8jkDKL0lo4ClnDJWFt3VDQbJrOf4Py6BuPsLppDT1PKklKBM3kYZDrmO0Ec5F+X0Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565585; c=relaxed/simple;
	bh=Vdvj3Qdl9fT0Fxk8/7S8M7kJpeswbGYHhaXrLtiBtGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lQg5HCbeBEUYuvne3j7t1GawK6kfWM1wpMTWoI2fu3uRUIjfFfjd6+5cloz7brrpiIPIy9ZqF9DGMjj+uFuBnSwS1VJlJfyNAw0Y+UbUaS9c3JCZz7sxeBqjYkqpkrpXQED2ahkaQ9jhibqQIeKdV7Mf/YWhA4iUpAJBn0+5reQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=cc2ARzap; arc=none smtp.client-ip=212.27.42.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="cc2ARzap"
Received: from [127.0.1.1] (unknown [IPv6:2a02:8428:60a1:3e01:2ba7:4349:5c56:5541])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 191F919F5B2;
	Wed, 16 Sep 2026 15:32:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1789565573;
	bh=Vdvj3Qdl9fT0Fxk8/7S8M7kJpeswbGYHhaXrLtiBtGk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cc2ARzap3Ahfi6xJohy2f/Vh1By1/naql+3pVnhoPzI8Bm11qUVHMAbwkJZ19mNqU
	 6Pdmz11ksraK6VQS73WbTKIasReBpaFPrlyq1MFhiJDOli2Jl8A5HpfZCThtd6GWzs
	 xPPnFH92BQIJnwXQzCxo3Xogb1t6naGp8aGB5nAH2GBWdKPxXCR1SOt76miHdV2gX1
	 T8Qvh8kBEX62Rq09/5gps/Avyi3Vb0MQT+eVKjW0OYulqGano1kSuBPtOpjT2hxxJT
	 LFgngPiEa3h8iT2r5DAVz7FWZK+SX7MdYoMotk+x73u03e1hlYHbUlzLgA6pQdHqfi
	 jm9KSylHDmUKg==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Date: Wed, 16 Sep 2026 15:31:58 +0200
Subject: [PATCH v2 2/3] can: ixxat_usb: add support for USB-to-CAN CL1 (V2)
 devices
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260916-ixxat_usb_can-v2-2-9b892e362d9e@peak-system.fr>
References: <20260916-ixxat_usb_can-v2-0-9b892e362d9e@peak-system.fr>
In-Reply-To: <20260916-ixxat_usb_can-v2-0-9b892e362d9e@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
X-Mailer: b4 0.14.3

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

Introduce ixxat_usb_cl1.c, which implements the CAN controller
operations (get_ctrl_caps/init_ctrl) and bittiming constants for the
IXXAT USB-to-CAN CL1 communication layer, used by the legacy
USB-to-CAN compact/embedded/professional/automotive family.

Wire up the corresponding struct usb_device_id entries (legacy vendor
ID) and struct ixxat_driver_info descriptors in the core, and mark the
new adapter with cl1_msg_format so that the core message
encode/decode paths pick the CL1 wire format for these devices.

Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/Kconfig                    |   6 +
 drivers/net/can/usb/ixxat_usb/Makefile         |   2 +-
 drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c  | 180 +++++++++++++++++++++++++
 drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c |  57 +++++++-
 drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h |  12 ++
 5 files changed, 252 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index 6a144fb840a6..e0abef67bfac 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -72,6 +72,12 @@ config CAN_IXXAT_USB
 	  interface the USB bus with the CAN bus for communication
 	  via CAN 2.0 and/or CAN FD.
 
+	  The driver provides support for the following devices:
+	    - IXXAT USB-to-CAN compact
+	    - IXXAT USB-to-CAN embedded
+	    - IXXAT USB-to-CAN professional
+	    - IXXAT USB-to-CAN automotive
+
 config CAN_KVASER_USB
 	tristate "Kvaser CAN/USB interface"
 	select NET_DEVLINK
diff --git a/drivers/net/can/usb/ixxat_usb/Makefile b/drivers/net/can/usb/ixxat_usb/Makefile
index 7d87d66d2b6f..28a48feaf395 100644
--- a/drivers/net/can/usb/ixxat_usb/Makefile
+++ b/drivers/net/can/usb/ixxat_usb/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CAN_IXXAT_USB) += ix_usb_can.o
-ix_usb_can-y = ixxat_usb_core.o
+ix_usb_can-y = ixxat_usb_cl1.o ixxat_usb_core.o
diff --git a/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c b/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c
new file mode 100644
index 000000000000..61d1f5dc4407
--- /dev/null
+++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0
+/* CAN driver adapter for IXXAT USB-to-CAN CL1
+ *
+ * Copyright (C) 2018-2024 HMS Industrial Networks <socketcan@hms-networks.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+#include <linux/kernel.h>
+
+#include "ixxat_usb_core.h"
+
+#define IXXAT_USB_CLOCK			8000000
+
+#define IXXAT_USB_BUFFER_SIZE_RX	512
+#define IXXAT_USB_BUFFER_SIZE_TX	256
+
+#define IXXAT_USB_MODES			(CAN_CTRLMODE_BERR_REPORTING | \
+					 CAN_CTRLMODE_3_SAMPLES | \
+					 CAN_CTRLMODE_LOOPBACK | \
+					 CAN_CTRLMODE_LISTENONLY)
+
+#define IXXAT_USB_BTMODE_TSM_CL1	0x80
+
+/* USB endpoint mapping for CL1 */
+#define IXXAT_USB2CAN_EP1_IN		(1 | USB_DIR_IN)
+#define IXXAT_USB2CAN_EP2_IN		(2 | USB_DIR_IN)
+#define IXXAT_USB2CAN_EP3_IN		(3 | USB_DIR_IN)
+#define IXXAT_USB2CAN_EP4_IN		(4 | USB_DIR_IN)
+#define IXXAT_USB2CAN_EP5_IN		(5 | USB_DIR_IN)
+
+#define IXXAT_USB2CAN_EP1_OUT		(1 | USB_DIR_OUT)
+#define IXXAT_USB2CAN_EP2_OUT		(2 | USB_DIR_OUT)
+#define IXXAT_USB2CAN_EP3_OUT		(3 | USB_DIR_OUT)
+#define IXXAT_USB2CAN_EP4_OUT		(4 | USB_DIR_OUT)
+#define IXXAT_USB2CAN_EP5_OUT		(5 | USB_DIR_OUT)
+
+#define IXXAT_USB_CAN_CMD_GETCAPS	0x320
+#define IXXAT_USB_CAN_CMD_INIT		0x325
+
+static const struct can_bittiming_const usb2can_bt = {
+	.name = KBUILD_MODNAME,
+	.tseg1_min = 1,
+	.tseg1_max = 16,
+	.tseg2_min = 1,
+	.tseg2_max = 8,
+	.sjw_max = 4,
+	.brp_min = 1,
+	.brp_max = 64,
+	.brp_inc = 1,
+};
+
+/* ixxat_usb_get_ctrl_caps - get controller capabilities
+ * @dev: pointer to the IXXAT USB CAN device
+ * @caps: pointer to the structure to store capabilities (can be NULL)
+ * This function retrieves the capabilities of the IXXAT USB CAN controller.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+static int ixxat_usb_get_ctrl_caps(struct ixxat_usb_candevice *dev,
+				   struct ixxat_cancaps2 *caps)
+{
+	struct ixxat_usb_getcaps_cl1_cmd cmd = { 0 };
+	const u16 port = dev->ctrl_index;
+	const u32 req_size = sizeof(cmd.req);
+	const u32 rcv_size = sizeof(cmd) - req_size;
+	const u32 cmd_size = req_size + sizeof(cmd.res);
+	int err;
+
+	ixxat_usb_setup_cmd(&cmd.req, &cmd.res);
+	cmd.req.code = cpu_to_le32(IXXAT_USB_CAN_CMD_GETCAPS);
+	cmd.req.port = cpu_to_le16(port);
+	cmd.res.res_size = cpu_to_le32(rcv_size);
+	memset(&cmd.caps, 0, sizeof(cmd.caps));
+
+	err = ixxat_usb_send_cmd(dev, port,
+				 &cmd.req, cmd_size,
+				 &cmd.res, rcv_size,
+				 IXXAT_USB_CMD_TIMEOUT);
+	if (!err && caps) {
+		memset(caps, 0, sizeof(*caps));
+
+		caps->ctrltype = cmd.caps.ctrltype;
+		caps->buscoupling = cmd.caps.buscoupling;
+		caps->features = cmd.caps.features;
+		caps->can_clock_freq = cmd.caps.can_clock_freq;
+
+		/* these are not available in CL1
+		 *  caps->sdr_range_min
+		 *  caps->sdr_range_max
+		 *  caps->fdr_range_min
+		 *  caps->fdr_range_max
+		 */
+		caps->ts_clock_freq = cmd.caps.can_clock_freq;
+		caps->ts_clock_divisor = cmd.caps.ts_clock_divisor;
+
+		caps->cms_clock_freq = cmd.caps.can_clock_freq;
+		caps->cms_clock_divisor = cmd.caps.cms_clock_divisor;
+		caps->cms_max_ticks = cmd.caps.cms_max_ticks;
+
+		caps->dtx_clock_freq = cmd.caps.can_clock_freq;
+		caps->dtx_clock_divisor = cmd.caps.dtx_clock_divisor;
+		caps->dtx_max_ticks = cmd.caps.dtx_max_ticks;
+	}
+
+	return err;
+}
+
+/* ixxat_usb_init_ctrl - initialize the controller
+ * @dev: pointer to the IXXAT USB CAN device
+ * This function initializes the IXXAT USB CAN controller with the specified
+ * bittiming parameters and control modes.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+static int ixxat_usb_init_ctrl(struct ixxat_usb_candevice *dev)
+{
+	struct ixxat_usb_init_cl1_cmd cmd = { 0 };
+	const u16 port = dev->ctrl_index;
+	const u32 rcv_size = sizeof(cmd.res);
+	const u32 cmd_size = sizeof(cmd);
+	const struct can_bittiming *bt = &dev->can.bittiming;
+	u8 opmode = IXXAT_USB_OPMODE_EXTENDED | IXXAT_USB_OPMODE_STANDARD;
+	u8 btr0 = ((bt->brp - 1) & 0x3f) | (((bt->sjw - 1) & 0x3) << 6);
+	u8 btr1 = ((bt->prop_seg + bt->phase_seg1 - 1) & 0xf) |
+		  (((bt->phase_seg2 - 1) & 0x7) << 4);
+
+	dev->loopback = ((dev->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) > 0);
+
+	if (dev->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
+		btr1 |= IXXAT_USB_BTMODE_TSM_CL1;
+	if (dev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
+		opmode |= IXXAT_USB_OPMODE_ERRFRAME;
+	if (dev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
+		opmode |= IXXAT_USB_OPMODE_LISTONLY;
+
+	ixxat_usb_setup_cmd(&cmd.req, &cmd.res);
+	cmd.req.size = cpu_to_le32(cmd_size - rcv_size);
+	cmd.req.code = cpu_to_le32(IXXAT_USB_CAN_CMD_INIT);
+	cmd.req.port = cpu_to_le16(port);
+	cmd.mode = opmode;
+	cmd.btr0 = btr0;
+	cmd.btr1 = btr1;
+
+	return ixxat_usb_send_cmd(dev, port,
+				  &cmd.req, cmd_size,
+				  &cmd.res, rcv_size,
+				  IXXAT_USB_CMD_TIMEOUT);
+}
+
+const struct ixxat_usb_adapter usb2can_cl1 = {
+	.clock = IXXAT_USB_CLOCK,
+	.bt = &usb2can_bt,
+	.modes = IXXAT_USB_MODES,
+	.buffer_size_rx = IXXAT_USB_BUFFER_SIZE_RX,
+	.buffer_size_tx = IXXAT_USB_BUFFER_SIZE_TX,
+	.cl1_msg_format = true,
+	.ep_msg_in = {
+		IXXAT_USB2CAN_EP1_IN,
+		IXXAT_USB2CAN_EP2_IN,
+		IXXAT_USB2CAN_EP3_IN,
+		IXXAT_USB2CAN_EP4_IN,
+		IXXAT_USB2CAN_EP5_IN
+	},
+	.ep_msg_out = {
+		IXXAT_USB2CAN_EP1_OUT,
+		IXXAT_USB2CAN_EP2_OUT,
+		IXXAT_USB2CAN_EP3_OUT,
+		IXXAT_USB2CAN_EP4_OUT,
+		IXXAT_USB2CAN_EP5_OUT
+	},
+	.get_ctrl_caps = ixxat_usb_get_ctrl_caps,
+	.init_ctrl = ixxat_usb_init_ctrl
+};
diff --git a/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c b/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c
index 3602ff9cc2c1..f0f7ce86ae63 100644
--- a/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c
+++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c
@@ -63,14 +63,63 @@ struct ixxat_driver_info {
 	bool is_legacy;
 };
 
+/* IXXAT_USB_VENDOR_ID_LEGACY products information */
+static const struct ixxat_driver_info legacy_usb2can_compact = {
+	.name = "IXXAT USB Compact",
+	.adapter = &usb2can_cl1,
+	.is_legacy = true,
+};
+
+static const struct ixxat_driver_info legacy_usb2can_embedded = {
+	.name = "IXXAT USB Embedded",
+	.adapter = &usb2can_cl1,
+	.is_legacy = true,
+};
+
+static const struct ixxat_driver_info legacy_usb2can_pro = {
+	.name = "IXXAT USB Professional",
+	.adapter = &usb2can_cl1,
+	.is_legacy = true,
+};
+
+static const struct ixxat_driver_info legacy_usb2can_auto = {
+	.name = "IXXAT USB Automotive",
+	.adapter = &usb2can_cl1,
+	.is_legacy = true,
+};
+
+static const struct ixxat_driver_info legacy_usb2can_plugin = {
+	.name = "IXXAT USB Plugin",
+	.adapter = &usb2can_cl1,
+	.is_legacy = true,
+};
+
 /* Table of devices that work with this driver
  *
- * This table is intentionally left empty: no IXXAT USB adapter family is
- * supported yet. Support for the various device families is added by
- * subsequent commits, each of which populates this table with the relevant
- * struct usb_device_id entries.
+ * Only the USB-to-CAN CL1 (V2 communication layer) adapter family is
+ * supported at this point. Support for the USB-to-CAN FD and CAN-IDM
+ * families is added by a subsequent commit in this series.
  */
 static const struct usb_device_id ixxat_usb_table[] = {
+	/* Legacy Vendor Id products list */
+	{ USB_DEVICE(IXXAT_USB_VENDOR_ID_LEGACY, USB2CAN_V2_COMPACT_PRODUCT_ID),
+	  .driver_info = (kernel_ulong_t)&legacy_usb2can_compact,
+	},
+	{ USB_DEVICE(IXXAT_USB_VENDOR_ID_LEGACY,
+		     USB2CAN_V2_EMBEDDED_PRODUCT_ID),
+	  .driver_info = (kernel_ulong_t)&legacy_usb2can_embedded,
+	},
+	{ USB_DEVICE(IXXAT_USB_VENDOR_ID_LEGACY,
+		     USB2CAN_V2_PROFESSIONAL_PRODUCT_ID),
+	  .driver_info = (kernel_ulong_t)&legacy_usb2can_pro,
+	},
+	{ USB_DEVICE(IXXAT_USB_VENDOR_ID_LEGACY,
+		     USB2CAN_V2_AUTOMOTIVE_PRODUCT_ID),
+	  .driver_info = (kernel_ulong_t)&legacy_usb2can_auto,
+	},
+	{ USB_DEVICE(IXXAT_USB_VENDOR_ID_LEGACY, USB2CAN_V2_PLUGIN_PRODUCT_ID),
+	  .driver_info = (kernel_ulong_t)&legacy_usb2can_plugin,
+	},
 	{ } /* Terminating entry */
 };
 
diff --git a/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h b/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h
index 423a280d8c4c..3cde67f6006b 100644
--- a/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h
+++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h
@@ -22,6 +22,16 @@
 #include <linux/usb.h>
 #include <linux/can/dev.h>
 
+/* vendor ids used by IXXAT devices */
+#define IXXAT_USB_VENDOR_ID_LEGACY		0x08d8
+
+/* IXXAT_USB_VENDOR_ID_LEGACY supported device ids: CL1 */
+#define USB2CAN_V2_COMPACT_PRODUCT_ID		0x0008
+#define USB2CAN_V2_EMBEDDED_PRODUCT_ID		0x0009
+#define USB2CAN_V2_PROFESSIONAL_PRODUCT_ID	0x000A
+#define USB2CAN_V2_AUTOMOTIVE_PRODUCT_ID	0x000B
+#define USB2CAN_V2_PLUGIN_PRODUCT_ID		0x001F
+
 /* supported bus types */
 #define IXXAT_USB_BUSTYPE_CAN		1
 
@@ -732,6 +742,8 @@ struct ixxat_usb_adapter {
 	int (*init_ctrl)(struct ixxat_usb_candevice *dev);
 };
 
+extern const struct ixxat_usb_adapter usb2can_cl1;
+
 /* ixxat_usb_setup_cmd() - Setup a device command
  * @req: Request block
  * @res: Response block

-- 
2.53.0

