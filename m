Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E854FB9DF;
	Wed, 16 Sep 2026 13:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565587; cv=none; b=Qmq4UpR7CBhbFlsVYqHu19V1ml/ls8ddJjPl2R4M2eJ3XdFOlPjYl0gA8vOmwxd10oZ2Gd3CK21cE57+Jr0+tWTw9MLL8kOuZpCq28FDcfbv/yXXmmCUwJ62BQf2kuj8YwxbzfMptwDeI79rdXVDykryo/N9PJcmEvwHDKVq4yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565587; c=relaxed/simple;
	bh=efFUidvVi75S+90xGBZsIIzD3g4NT48YaGtK/zPkeHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HxVzguXgujv/DO8tUUevqWZs3oz1ktuWtngK0VXVZ+6QfXpEwsU3QmLSj2uEmq4ubntDUxzNl8Nkvbz1PNmCfXei7lFDQAmKbcrUy4ORoOeRJdSi4WI/nsZ5lHBhygxUbgZvwB6ZKtI2K4ldlZ44j64fQH1+/8Xsj3Cp2Tx5mjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=X0ROTWe/; arc=none smtp.client-ip=212.27.42.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="X0ROTWe/"
Received: from [127.0.1.1] (unknown [IPv6:2a02:8428:60a1:3e01:2ba7:4349:5c56:5541])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id B197219F5A7;
	Wed, 16 Sep 2026 15:32:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1789565579;
	bh=efFUidvVi75S+90xGBZsIIzD3g4NT48YaGtK/zPkeHA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X0ROTWe/XQCiPefq5rCsB1FM8mc2bpYha7Pz/lyBERhso3eFv3GTcFSVyiaGG2Jxm
	 9IHYUaFap+c9A6BpJvTzWsH/3ft7DDrYAYu2yFVvoEC3vdytk5S6so4tBGWtGlfuoG
	 cwnUf8/KeZqMdkUoa5FKPQ7YW554ObBJQH6GvsfhEoX1DQySxQR+pPydl6E65/S1CS
	 DsVTvpcvnjonJFlb5UE0zfij/3tfG+eTg4VocIAPaB24OUqrE4f+pViqt8ZsHE7akM
	 hglEFfuRHcorMIPC5GKDIt+dV0Eb+g7t67r3P9/I2rw6+rzb6n14cUeZ1E8Vui6APV
	 b/zA638yv+NsA==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Date: Wed, 16 Sep 2026 15:31:59 +0200
Subject: [PATCH v2 3/3] can: ixxat_usb: add support for USB-to-CAN FD and
 CAN-IDM devices
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260916-ixxat_usb_can-v2-3-9b892e362d9e@peak-system.fr>
References: <20260916-ixxat_usb_can-v2-0-9b892e362d9e@peak-system.fr>
In-Reply-To: <20260916-ixxat_usb_can-v2-0-9b892e362d9e@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
X-Mailer: b4 0.14.3

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

Introduce ixxat_usb_cl2.c, which implements the CAN(-FD) controller
operations and bittiming constants for the IXXAT CL2 communication
layer, used by:
 - the USB-to-CAN FD compact/professional/automotive/MiniPCIe family,
 - the USB-to-CAR adapter,
 - the CAN-IDM101/IDM200 adapters,
 - the newer USB-to-CAN/FD Pro/Standard (+ Card/Module variants)
   adapters using the new IXXAT_USB_VENDOR_ID.

Wire up the corresponding struct usb_device_id entries and struct
ixxat_driver_info descriptors in the core.

Also restore the firmware-based adapter upgrade path in
ixxat_usb_get_adapter(): legacy USB-to-CAN V2 hardware (CL1) that runs
a firmware new enough to support the CL2 communication layer is
switched to the usb2can_v2 adapter instead, which now becomes
available with this commit.

Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/Kconfig                    |   6 +
 drivers/net/can/usb/ixxat_usb/Makefile         |   2 +-
 drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c  | 307 +++++++++++++++++++++++++
 drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c | 117 +++++++++-
 drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h |  20 ++
 5 files changed, 444 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index e0abef67bfac..dc6f642d4555 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -77,6 +77,12 @@ config CAN_IXXAT_USB
 	    - IXXAT USB-to-CAN embedded
 	    - IXXAT USB-to-CAN professional
 	    - IXXAT USB-to-CAN automotive
+	    - IXXAT USB-to-CAN FD compact
+	    - IXXAT USB-to-CAN FD professional
+	    - IXXAT USB-to-CAN FD automotive
+	    - IXXAT USB-to-CAN FD MiniPCIe
+	    - IXXAT USB-to-CAR
+	    - IXXAT CAN-IDM101
 
 config CAN_KVASER_USB
 	tristate "Kvaser CAN/USB interface"
diff --git a/drivers/net/can/usb/ixxat_usb/Makefile b/drivers/net/can/usb/ixxat_usb/Makefile
index 28a48feaf395..caa4d253da97 100644
--- a/drivers/net/can/usb/ixxat_usb/Makefile
+++ b/drivers/net/can/usb/ixxat_usb/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CAN_IXXAT_USB) += ix_usb_can.o
-ix_usb_can-y = ixxat_usb_cl1.o ixxat_usb_core.o
+ix_usb_can-y = ixxat_usb_cl1.o ixxat_usb_cl2.o ixxat_usb_core.o
diff --git a/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c b/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c
new file mode 100644
index 000000000000..6c08f4791537
--- /dev/null
+++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c
@@ -0,0 +1,307 @@
+// SPDX-License-Identifier: GPL-2.0
+/* CAN driver adapter for IXXAT USB-to-CAN CL2
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
+#define IXXAT_USB_CLOCK			80000000
+#define IXXAT_USBV2_CLOCK		36000000
+
+#define IXXAT_USBFD_BUFFER_SIZE_RX	512
+#define IXXAT_USBFD_BUFFER_SIZE_TX	512
+
+#define IXXAT_USBV2_BUFFER_SIZE_RX	512
+#define IXXAT_USBV2_BUFFER_SIZE_TX	512
+
+#define IXXAT_USBIDM_BUFFER_SIZE_RX	512
+#define IXXAT_USBIDM_BUFFER_SIZE_TX	512
+
+#define IXXAT_USB_MODES_FD		(CAN_CTRLMODE_LISTENONLY | \
+					 CAN_CTRLMODE_3_SAMPLES | \
+					 CAN_CTRLMODE_LOOPBACK | \
+					 CAN_CTRLMODE_BERR_REPORTING | \
+					 CAN_CTRLMODE_FD | \
+					 CAN_CTRLMODE_FD_NON_ISO | \
+					 CAN_CTRLMODE_TDC_AUTO)
+
+#define IXXAT_USB_MODES			(CAN_CTRLMODE_LISTENONLY | \
+					 CAN_CTRLMODE_3_SAMPLES | \
+					 CAN_CTRLMODE_LOOPBACK | \
+					 CAN_CTRLMODE_BERR_REPORTING)
+
+/* USB endpoint mapping for USB-to-CAN V2 */
+#define IXXAT_USB2CANV2_EP1_IN		(1 | USB_DIR_IN)
+#define IXXAT_USB2CANV2_EP2_IN		(2 | USB_DIR_IN)
+#define IXXAT_USB2CANV2_EP3_IN		(3 | USB_DIR_IN)
+#define IXXAT_USB2CANV2_EP4_IN		(4 | USB_DIR_IN)
+#define IXXAT_USB2CANV2_EP5_IN		(5 | USB_DIR_IN)
+
+#define IXXAT_USB2CANV2_EP1_OUT		(1 | USB_DIR_OUT)
+#define IXXAT_USB2CANV2_EP2_OUT		(2 | USB_DIR_OUT)
+#define IXXAT_USB2CANV2_EP3_OUT		(3 | USB_DIR_OUT)
+#define IXXAT_USB2CANV2_EP4_OUT		(4 | USB_DIR_OUT)
+#define IXXAT_USB2CANV2_EP5_OUT		(5 | USB_DIR_OUT)
+
+/* USB endpoint mapping for USB-to-CAN FD */
+#define IXXAT_USB2CANFD_EP1_IN		(1 | USB_DIR_IN)
+#define IXXAT_USB2CANFD_EP2_IN		(2 | USB_DIR_IN)
+#define IXXAT_USB2CANFD_EP3_IN		(3 | USB_DIR_IN)
+#define IXXAT_USB2CANFD_EP4_IN		(4 | USB_DIR_IN)
+#define IXXAT_USB2CANFD_EP5_IN		(5 | USB_DIR_IN)
+
+#define IXXAT_USB2CANFD_EP1_OUT		(1 | USB_DIR_OUT)
+#define IXXAT_USB2CANFD_EP2_OUT		(2 | USB_DIR_OUT)
+#define IXXAT_USB2CANFD_EP3_OUT		(3 | USB_DIR_OUT)
+#define IXXAT_USB2CANFD_EP4_OUT		(4 | USB_DIR_OUT)
+#define IXXAT_USB2CANFD_EP5_OUT		(5 | USB_DIR_OUT)
+
+/* USB endpoint mapping for CAN IDM */
+#define IXXAT_CANIDM_EP1_IN		(2 | USB_DIR_IN)
+#define IXXAT_CANIDM_EP2_IN		(4 | USB_DIR_IN)
+#define IXXAT_CANIDM_EP3_IN		(6 | USB_DIR_IN)
+#define IXXAT_CANIDM_EP4_IN		(8 | USB_DIR_IN)
+#define IXXAT_CANIDM_EP5_IN		(10 | USB_DIR_IN)
+
+#define IXXAT_CANIDM_EP1_OUT		(1 | USB_DIR_OUT)
+#define IXXAT_CANIDM_EP2_OUT		(3 | USB_DIR_OUT)
+#define IXXAT_CANIDM_EP3_OUT		(5 | USB_DIR_OUT)
+#define IXXAT_CANIDM_EP4_OUT		(7 | USB_DIR_OUT)
+#define IXXAT_CANIDM_EP5_OUT		(9 | USB_DIR_OUT)
+
+#define IXXAT_USB_CAN_CMD_GETCAPS2	0x335
+#define IXXAT_USB_CAN_CMD_INIT2		0x337
+
+static const struct can_bittiming_const usb2can_v2_bt = {
+	.name = KBUILD_MODNAME,
+	.tseg1_min = 1,
+	.tseg1_max = 16,
+	.tseg2_min = 1,
+	.tseg2_max = 8,
+	.sjw_max = 4,
+	.brp_min = 1,
+	.brp_max = 1024,
+	.brp_inc = 1,
+};
+
+static const struct can_bittiming_const usb2can_fd_bt = {
+	.name = KBUILD_MODNAME,
+	.tseg1_min = 1,
+	.tseg1_max = 256,
+	.tseg2_min = 1,
+	.tseg2_max = 256,
+	.sjw_max = 128,
+	.brp_min = 2,
+	.brp_max = 513,
+	.brp_inc = 1,
+};
+
+static const struct can_bittiming_const usb2can_fd_btd = {
+	.name = KBUILD_MODNAME,
+	.tseg1_min = 1,
+	.tseg1_max = 256,
+	.tseg2_min = 1,
+	.tseg2_max = 256,
+	.sjw_max = 128,
+	.brp_min = 2,
+	.brp_max = 513,
+	.brp_inc = 1,
+};
+
+static const struct can_tdc_const usb2can_fd_tdc = {
+	.tdcv_min = 0,
+	.tdcv_max = 0,	/* Manual mode not supported */
+	.tdco_min = 0,
+	.tdco_max = 127,
+};
+
+static const struct can_bittiming_const canidm_bt = {
+	.name = KBUILD_MODNAME,
+	.tseg1_min = 1,
+	.tseg1_max = 256,
+	.tseg2_min = 1,
+	.tseg2_max = 128,
+	.sjw_max = 128,
+	.brp_min = 1,
+	.brp_max = 512,
+	.brp_inc = 1
+};
+
+static const struct can_bittiming_const canidm_btd = {
+	.name = KBUILD_MODNAME,
+	.tseg1_min = 1,
+	.tseg1_max = 32,
+	.tseg2_min = 1,
+	.tseg2_max = 16,
+	.sjw_max = 8,
+	.brp_min = 1,
+	.brp_max = 32,
+	.brp_inc = 1
+};
+
+static int ixxat_usb_get_ctrl_caps(struct ixxat_usb_candevice *dev,
+				   struct ixxat_cancaps2 *caps)
+{
+	struct ixxat_usb_getcaps_cl2_cmd cmd = { 0 };
+	const u16 port = dev->ctrl_index;
+	const u32 req_size = sizeof(cmd.req);
+	const u32 rcv_size = sizeof(cmd) - req_size;
+	const u32 cmd_size = req_size + sizeof(cmd.res);
+	int err;
+
+	ixxat_usb_setup_cmd(&cmd.req, &cmd.res);
+	cmd.req.code = cpu_to_le32(IXXAT_USB_CAN_CMD_GETCAPS2);
+	cmd.req.port = cpu_to_le16(port);
+	cmd.res.res_size = cpu_to_le32(rcv_size);
+
+	err = ixxat_usb_send_cmd(dev, port,
+				 &cmd.req, cmd_size,
+				 &cmd.res, rcv_size,
+				 IXXAT_USB_CMD_TIMEOUT);
+	if (!err && caps)
+		memcpy(caps, &cmd.caps, sizeof(*caps));
+
+	return err;
+}
+
+static int ixxat_usb_init_ctrl(struct ixxat_usb_candevice *dev)
+{
+	struct ixxat_usb_init_cl2_cmd cmd = { 0 };
+	const struct can_bittiming *bt = &dev->can.bittiming;
+	const struct can_bittiming *btd = &dev->can.fd.data_bittiming;
+	const u16 port = dev->ctrl_index;
+	const u32 rcv_size = sizeof(cmd.res);
+	const u32 cmd_size = sizeof(cmd);
+	u32 btmode = IXXAT_USB_BTMODE_NAT;
+	u8 opmode = IXXAT_USB_OPMODE_EXTENDED | IXXAT_USB_OPMODE_STANDARD;
+	u8 exmode = 0;
+
+	dev->loopback = ((dev->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) > 0);
+
+	if (dev->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
+		btmode = IXXAT_USB_BTMODE_TSM;
+	if (dev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
+		opmode |= IXXAT_USB_OPMODE_ERRFRAME;
+	if (dev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
+		opmode |= IXXAT_USB_OPMODE_LISTONLY;
+	if (dev->can.ctrlmode & CAN_CTRLMODE_FD) {
+		exmode |= IXXAT_USB_EXMODE_EXTDATA | IXXAT_USB_EXMODE_FASTDATA;
+
+		if (!(dev->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO))
+			exmode |= IXXAT_USB_EXMODE_ISOFD;
+	}
+
+	ixxat_usb_setup_cmd(&cmd.req, &cmd.res);
+	cmd.req.size = cpu_to_le32(cmd_size - rcv_size);
+	cmd.req.code = cpu_to_le32(IXXAT_USB_CAN_CMD_INIT2);
+	cmd.req.port = cpu_to_le16(port);
+	cmd.opmode = opmode;
+	cmd.exmode = exmode;
+	cmd.sdr.mode = cpu_to_le32(btmode);
+	cmd.sdr.bps = cpu_to_le32(bt->brp);
+	cmd.sdr.ts1 = cpu_to_le16(bt->prop_seg + bt->phase_seg1);
+	cmd.sdr.ts2 = cpu_to_le16(bt->phase_seg2);
+	cmd.sdr.sjw = cpu_to_le16(bt->sjw);
+	cmd.sdr.tdo = 0;
+
+	if (exmode) {
+		cmd.fdr.tdo = cpu_to_le16(dev->can.fd.tdc.tdco);
+		cmd.fdr.mode = cpu_to_le32(btmode);
+		cmd.fdr.bps = cpu_to_le32(btd->brp);
+		cmd.fdr.ts1 = cpu_to_le16(btd->prop_seg + btd->phase_seg1);
+		cmd.fdr.ts2 = cpu_to_le16(btd->phase_seg2);
+		cmd.fdr.sjw = cpu_to_le16(btd->sjw);
+	}
+
+	return ixxat_usb_send_cmd(dev, port,
+				  &cmd.req, cmd_size,
+				  &cmd.res, rcv_size,
+				  IXXAT_USB_CMD_TIMEOUT);
+}
+
+const struct ixxat_usb_adapter usb2can_fd = {
+	.clock = IXXAT_USB_CLOCK,
+	.bt = &usb2can_fd_bt,
+	.btd = &usb2can_fd_btd,
+	.tdc = &usb2can_fd_tdc,
+	.modes = IXXAT_USB_MODES_FD,
+	.buffer_size_rx = IXXAT_USBFD_BUFFER_SIZE_RX,
+	.buffer_size_tx = IXXAT_USBFD_BUFFER_SIZE_TX,
+	.ep_msg_in = {
+		IXXAT_USB2CANFD_EP1_IN,
+		IXXAT_USB2CANFD_EP2_IN,
+		IXXAT_USB2CANFD_EP3_IN,
+		IXXAT_USB2CANFD_EP4_IN,
+		IXXAT_USB2CANFD_EP5_IN
+	},
+	.ep_msg_out = {
+		IXXAT_USB2CANFD_EP1_OUT,
+		IXXAT_USB2CANFD_EP2_OUT,
+		IXXAT_USB2CANFD_EP3_OUT,
+		IXXAT_USB2CANFD_EP4_OUT,
+		IXXAT_USB2CANFD_EP5_OUT
+	},
+	.ep_offs = 1,
+	.get_ctrl_caps = ixxat_usb_get_ctrl_caps,
+	.init_ctrl = ixxat_usb_init_ctrl
+};
+
+const struct ixxat_usb_adapter usb2can_v2 = {
+	.clock = IXXAT_USBV2_CLOCK,
+	.bt = &usb2can_v2_bt,
+	.modes = IXXAT_USB_MODES,
+	.buffer_size_rx = IXXAT_USBV2_BUFFER_SIZE_RX,
+	.buffer_size_tx = IXXAT_USBV2_BUFFER_SIZE_TX,
+	.ep_msg_in = {
+		IXXAT_USB2CANV2_EP1_IN,
+		IXXAT_USB2CANV2_EP2_IN,
+		IXXAT_USB2CANV2_EP3_IN,
+		IXXAT_USB2CANV2_EP4_IN,
+		IXXAT_USB2CANV2_EP5_IN
+	},
+	.ep_msg_out = {
+		IXXAT_USB2CANV2_EP1_OUT,
+		IXXAT_USB2CANV2_EP2_OUT,
+		IXXAT_USB2CANV2_EP3_OUT,
+		IXXAT_USB2CANV2_EP4_OUT,
+		IXXAT_USB2CANV2_EP5_OUT
+	},
+	.get_ctrl_caps = ixxat_usb_get_ctrl_caps,
+	.init_ctrl = ixxat_usb_init_ctrl
+};
+
+const struct ixxat_usb_adapter can_fd_idm = {
+	.clock = IXXAT_USB_CLOCK,
+	.bt = &canidm_bt,
+	.btd = &canidm_btd,
+	.modes = IXXAT_USB_MODES_FD,
+	.buffer_size_rx = IXXAT_USBIDM_BUFFER_SIZE_RX,
+	.buffer_size_tx = IXXAT_USBIDM_BUFFER_SIZE_TX,
+	.ep_msg_in = {
+		IXXAT_CANIDM_EP1_IN,
+		IXXAT_CANIDM_EP2_IN,
+		IXXAT_CANIDM_EP3_IN,
+		IXXAT_CANIDM_EP4_IN,
+		IXXAT_CANIDM_EP5_IN
+	},
+	.ep_msg_out = {
+		IXXAT_CANIDM_EP1_OUT,
+		IXXAT_CANIDM_EP2_OUT,
+		IXXAT_CANIDM_EP3_OUT,
+		IXXAT_CANIDM_EP4_OUT,
+		IXXAT_CANIDM_EP5_OUT
+	},
+	.get_ctrl_caps = ixxat_usb_get_ctrl_caps,
+	.init_ctrl = ixxat_usb_init_ctrl
+};
diff --git a/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c b/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c
index f0f7ce86ae63..bbf2c45fe8cf 100644
--- a/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c
+++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c
@@ -94,12 +94,68 @@ static const struct ixxat_driver_info legacy_usb2can_plugin = {
 	.is_legacy = true,
 };
 
-/* Table of devices that work with this driver
- *
- * Only the USB-to-CAN CL1 (V2 communication layer) adapter family is
- * supported at this point. Support for the USB-to-CAN FD and CAN-IDM
- * families is added by a subsequent commit in this series.
- */
+static const struct ixxat_driver_info legacy_usb2can_fd_compact = {
+	.name = "IXXAT USB Compact FD",
+	.adapter = &usb2can_fd,
+};
+
+static const struct ixxat_driver_info legacy_usb2can_fd_pro = {
+	.name = "IXXAT USB Professional FD",
+	.adapter = &usb2can_fd,
+};
+
+static const struct ixxat_driver_info legacy_usb2can_fd_auto = {
+	.name = "IXXAT USB Automotive FD",
+	.adapter = &usb2can_fd,
+};
+
+static const struct ixxat_driver_info legacy_usb2can_fd_pcie_mini = {
+	.name = "IXXAT USB PCIe Mini FD",
+	.adapter = &usb2can_fd,
+};
+
+static const struct ixxat_driver_info legacy_usb2car = {
+	.name = "IXXAT USB-to-Car",
+	.adapter = &usb2can_fd,
+};
+
+static const struct ixxat_driver_info legacy_can_idm101 = {
+	.name = "IXXAT IDM 101",
+	.adapter = &can_fd_idm,
+};
+
+static const struct ixxat_driver_info legacy_can_idm200 = {
+	.name = "IXXAT IDM 200",
+	.adapter = &can_fd_idm,
+};
+
+/* IXXAT_USB_VENDOR_ID products information */
+static const struct ixxat_driver_info usb2can_fd_pro = {
+	.name = "Ixxat USB-to-CAN/FD Pro",
+	.adapter = &usb2can_fd,
+};
+
+static const struct ixxat_driver_info usb2can_fd_std = {
+	.name = "Ixxat USB-to-CAN/FD Standard",
+	.adapter = &usb2can_fd,
+};
+
+static const struct ixxat_driver_info usb2can_fd_std_card = {
+	.name = "Ixxat USB-to-CAN/FD Standard Card",
+	.adapter = &usb2can_fd,
+};
+
+static const struct ixxat_driver_info usb2can_fd_pro_module = {
+	.name = "Ixxat USB-to-CAN/FD Pro Module",
+	.adapter = &usb2can_fd,
+};
+
+static const struct ixxat_driver_info usb2can_fd_standard_module = {
+	.name = "Ixxat USB-to-CAN/FD Standard Module",
+	.adapter = &usb2can_fd,
+};
+
+/* Table of devices that work with this driver */
 static const struct usb_device_id ixxat_usb_table[] = {
 	/* Legacy Vendor Id products list */
 	{ USB_DEVICE(IXXAT_USB_VENDOR_ID_LEGACY, USB2CAN_V2_COMPACT_PRODUCT_ID),
@@ -120,6 +176,48 @@ static const struct usb_device_id ixxat_usb_table[] = {
 	{ USB_DEVICE(IXXAT_USB_VENDOR_ID_LEGACY, USB2CAN_V2_PLUGIN_PRODUCT_ID),
 	  .driver_info = (kernel_ulong_t)&legacy_usb2can_plugin,
 	},
+	{ USB_DEVICE(IXXAT_USB_VENDOR_ID_LEGACY, USB2CAN_FD_COMPACT_PRODUCT_ID),
+	  .driver_info = (kernel_ulong_t)&legacy_usb2can_fd_compact,
+	},
+	{ USB_DEVICE(IXXAT_USB_VENDOR_ID_LEGACY,
+		     USB2CAN_FD_EMBEDDED_PRODUCT_ID),
+	  .driver_info = (kernel_ulong_t)&legacy_usb2can_fd_pro,
+	},
+	{ USB_DEVICE(IXXAT_USB_VENDOR_ID_LEGACY,
+		     USB2CAN_FD_AUTOMOTIVE_PRODUCT_ID),
+	  .driver_info = (kernel_ulong_t)&legacy_usb2can_fd_auto,
+	},
+	{ USB_DEVICE(IXXAT_USB_VENDOR_ID_LEGACY,
+		     USB2CAN_FD_PCIE_MINI_PRODUCT_ID),
+	  .driver_info = (kernel_ulong_t)&legacy_usb2can_fd_pcie_mini,
+	},
+	{ USB_DEVICE(IXXAT_USB_VENDOR_ID_LEGACY, USB2CAR_PRODUCT_ID),
+	  .driver_info = (kernel_ulong_t)&legacy_usb2car,
+	},
+	{ USB_DEVICE(IXXAT_USB_VENDOR_ID_LEGACY, CAN_IDM101_PRODUCT_ID),
+	  .driver_info = (kernel_ulong_t)&legacy_can_idm101,
+	},
+	{ USB_DEVICE(IXXAT_USB_VENDOR_ID_LEGACY, CAN_IDM200_PRODUCT_ID),
+	  .driver_info = (kernel_ulong_t)&legacy_can_idm200,
+	},
+
+	/* New Vendor Id products list */
+	{ USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_FD_PRO_PRODUCT_ID),
+	  .driver_info = (kernel_ulong_t)&usb2can_fd_pro,
+	},
+	{ USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_FD_STANDARD_PRODUCT_ID),
+	  .driver_info = (kernel_ulong_t)&usb2can_fd_std,
+	},
+	{ USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_FD_STANDARD_CARD_PRODUCT_ID),
+	  .driver_info = (kernel_ulong_t)&usb2can_fd_std_card,
+	},
+	{ USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_FD_PRO_MODULE_PRODUCT_ID),
+	  .driver_info = (kernel_ulong_t)&usb2can_fd_pro_module,
+	},
+	{ USB_DEVICE(IXXAT_USB_VENDOR_ID,
+		     USB2CAN_FD_STANDARD_MODULE_PRODUCT_ID),
+	  .driver_info = (kernel_ulong_t)&usb2can_fd_standard_module,
+	},
 	{ } /* Terminating entry */
 };
 
@@ -190,6 +288,10 @@ static const struct ixxat_usb_adapter *
 	const struct ixxat_driver_info *drv_info =
 		(const struct ixxat_driver_info *)id->driver_info;
 
+	if (drv_info->adapter->cl1_msg_format &&
+	    ixxat_usb_has_cl2_firmware(id, dev_fwinfo))
+		return &usb2can_v2;
+
 	return drv_info->adapter;
 }
 
@@ -834,9 +936,10 @@ static int ixxat_usb_stop_ctrl(struct ixxat_usb_candevice *dev)
 	const u16 port = dev->ctrl_index;
 	const u32 rcv_size = sizeof(cmd.res);
 	const u32 cmd_size = sizeof(cmd);
+	const u32 req_size = cmd_size - rcv_size;
 
 	ixxat_usb_setup_cmd(&cmd.req, &cmd.res);
-	cmd.req.size = cpu_to_le32(cmd_size - rcv_size);
+	cmd.req.size = cpu_to_le32(req_size);
 	cmd.req.code = cpu_to_le32(IXXAT_USB_CAN_CMD_STOP);
 	cmd.req.port = cpu_to_le16(port);
 	cmd.action = cpu_to_le32(IXXAT_USB_STOP_ACTION_CLEARALL);
diff --git a/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h b/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h
index 3cde67f6006b..25d9987de94f 100644
--- a/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h
+++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h
@@ -24,6 +24,7 @@
 
 /* vendor ids used by IXXAT devices */
 #define IXXAT_USB_VENDOR_ID_LEGACY		0x08d8
+#define IXXAT_USB_VENDOR_ID			0x08db
 
 /* IXXAT_USB_VENDOR_ID_LEGACY supported device ids: CL1 */
 #define USB2CAN_V2_COMPACT_PRODUCT_ID		0x0008
@@ -32,6 +33,22 @@
 #define USB2CAN_V2_AUTOMOTIVE_PRODUCT_ID	0x000B
 #define USB2CAN_V2_PLUGIN_PRODUCT_ID		0x001F
 
+/* IXXAT_USB_VENDOR_ID_LEGACY supported device ids: CL2 */
+#define USB2CAN_FD_COMPACT_PRODUCT_ID		0x0014
+#define USB2CAN_FD_EMBEDDED_PRODUCT_ID		0x0015
+#define USB2CAN_FD_AUTOMOTIVE_PRODUCT_ID	0x0017
+#define USB2CAN_FD_PCIE_MINI_PRODUCT_ID		0x001B
+#define USB2CAR_PRODUCT_ID			0x001C
+#define CAN_IDM101_PRODUCT_ID			0xFF12
+#define CAN_IDM200_PRODUCT_ID			0xFF13
+
+/* IXXAT_USB_VENDOR_ID supported device ids: CL2 */
+#define USB2CAN_FD_PRO_PRODUCT_ID		0x0010
+#define USB2CAN_FD_STANDARD_PRODUCT_ID		0x0011
+#define USB2CAN_FD_STANDARD_CARD_PRODUCT_ID	0x0012
+#define USB2CAN_FD_PRO_MODULE_PRODUCT_ID	0x0013
+#define USB2CAN_FD_STANDARD_MODULE_PRODUCT_ID	0x0014
+
 /* supported bus types */
 #define IXXAT_USB_BUSTYPE_CAN		1
 
@@ -743,6 +760,9 @@ struct ixxat_usb_adapter {
 };
 
 extern const struct ixxat_usb_adapter usb2can_cl1;
+extern const struct ixxat_usb_adapter usb2can_v2;
+extern const struct ixxat_usb_adapter usb2can_fd;
+extern const struct ixxat_usb_adapter can_fd_idm;
 
 /* ixxat_usb_setup_cmd() - Setup a device command
  * @req: Request block

-- 
2.53.0

