Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3EF3DFC88
	for <linux-can@vger.kernel.org>; Thu, 23 Jul 2026 07:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784791836; cv=none; b=P2BprcX2MWGKreF8O9eDyyKA9HJqXok5YDlrv8fG0qODWbn6oZSdomFt1DdFgRxwm+011lmYJQasSI8i40AVHtNVc22g4VF4R4fpnB5itSwcUf5kvLFzx6FKJfgmKCNYuJ4UXhKeOZ36BqAlPMQ/KHCQ3rMxGe6KmqczqRhVCC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784791836; c=relaxed/simple;
	bh=0Z6k6YNpPxRf1hF5YUmfVEwztPjl5FmmZW+yPMyLBzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZy56xc4YJsJoKM+8vmxTizRURgeenBJiyD+G2N89TQjpXgAK9GiH8wHXxziedmKVZPRrvFYKwyQNn0AQ9686XZjVrh4Sn2+K/gM3bsKF3YPiP0eyWYh2FkenYMAR9I0NlhP2wihPGqQpY7XFnNVw3kfGmUdscbbb+6F5CX/348=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=pxbscT/A; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="pxbscT/A"
Received: from stf-laptop (unknown [IPv6:2a02:8428:60a1:3e01:76e8:6ddc:7f18:a4b2])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 0E3F52003D0;
	Thu, 23 Jul 2026 09:30:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1784791828;
	bh=0Z6k6YNpPxRf1hF5YUmfVEwztPjl5FmmZW+yPMyLBzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pxbscT/APyH64OVT8CI21D7LtOvwe2h+dxAcxiscTn724Ys9QVxtbNDfD56ypy+PC
	 JmneqNMU/4U402CLCB5FBszZ6P83FsDNealzmT2dpP6UhyKjWI/Wumf2CbqpMRyauj
	 ZB7BsXlpoJJ36d31P3wpfPYvyLo1JLBKgKXTVN+zPi+/U6+dJ31yJiGOHUo0JDjutu
	 4wm3eP4kgGdDwtfEcDs9HXYqKtIXsUT+C5TldzueM40uCJi1BfkYm7anerrkNxTQTM
	 8Jl/gAU7lx0sMrO10W3aGPbDEiklXMJ7UkYwG/nYoyqpYvzHDWr+ox6vTM54WtmchL
	 0FjDZ0Evz4Q5w==
From: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <stephane.grosjean@free.fr>
To: linux-can Mailing List <linux-can@vger.kernel.org>
Cc: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <s.grosjean@peak-system.fr>
Subject: [PATCH 2/4] can: usb: ixxat_usb: add CL1 legacy protocol layer
Date: Thu, 23 Jul 2026 09:29:37 +0200
Message-ID: <20260723072955.32575-3-stephane.grosjean@free.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723072955.32575-1-stephane.grosjean@free.fr>
References: <20260723072955.32575-1-stephane.grosjean@free.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

Add ixxat_usb_cl1.c, which implements the CL1 communication protocol used
by the early firmware versions for IXXAT USB-to-CAN adapters.

CL1 devices expose classic CAN 2.0b frames only (no CAN FD).  The
init command carries a single set of bittiming parameters and optional
mode flags for listen-only, triple-sampling, loopback and bus-error
reporting.

The exported usb2can_cl1 adapter descriptor references the CL1
open/close/start/stop callbacks and the CL1 bittiming constants.

Supported control modes: listen-only, loopback, triple-sampling,
                         bus-error reporting.

Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c | 188 ++++++++++++++++++
 1 file changed, 188 insertions(+)
 create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c

diff --git a/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c b/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c
new file mode 100644
index 000000000000..c1e337fc3b91
--- /dev/null
+++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+/* CAN driver adapter for IXXAT USB-to-CAN CL1
+ *
+ * Copyright (C) 2018-2024 HMS Industrial Networks <socketcan@hms-networks.de>
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
+#include <linux/can/dev.h>
+#include <linux/kernel.h>
+#include <linux/usb.h>
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
+/* bittiming parameters */
+#define IXXAT_USB2CAN_TSEG1_MIN		1
+#define IXXAT_USB2CAN_TSEG1_MAX		16
+#define IXXAT_USB2CAN_TSEG2_MIN		1
+#define IXXAT_USB2CAN_TSEG2_MAX		8
+#define IXXAT_USB2CAN_SJW_MAX		4
+#define IXXAT_USB2CAN_BRP_MIN		1
+#define IXXAT_USB2CAN_BRP_MAX		64
+#define IXXAT_USB2CAN_BRP_INC		1
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
+	.tseg1_min = IXXAT_USB2CAN_TSEG1_MIN,
+	.tseg1_max = IXXAT_USB2CAN_TSEG1_MAX,
+	.tseg2_min = IXXAT_USB2CAN_TSEG2_MIN,
+	.tseg2_max = IXXAT_USB2CAN_TSEG2_MAX,
+	.sjw_max = IXXAT_USB2CAN_SJW_MAX,
+	.brp_min = IXXAT_USB2CAN_BRP_MIN,
+	.brp_max = IXXAT_USB2CAN_BRP_MAX,
+	.brp_inc = IXXAT_USB2CAN_BRP_INC,
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
+	const u16 port = dev->ctrl_index;
+	struct ixxat_usb_getcaps_cl1_cmd cmd = { 0 };
+	const u32 cmd_size = sizeof(cmd);
+	const u32 req_size = sizeof(cmd.req);
+	const u32 rcv_size = cmd_size - req_size;
+	const u32 snd_size = req_size + sizeof(cmd.res);
+	int err;
+
+	ixxat_usb_setup_cmd(&cmd.req, &cmd.res);
+	cmd.req.code = cpu_to_le32(IXXAT_USB_CAN_CMD_GETCAPS);
+	cmd.req.port = cpu_to_le16(port);
+	cmd.res.res_size = cpu_to_le32(rcv_size);
+	memset(&cmd.caps, 0, sizeof(cmd.caps));
+
+	err = ixxat_usb_send_cmd(dev, port, &cmd, snd_size, &cmd.res,
+				 rcv_size, IXXAT_USB_CMD_TIMEOUT);
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
+	const struct can_bittiming *bt = &dev->can.bittiming;
+	const u16 port = dev->ctrl_index;
+	struct ixxat_usb_init_cl1_cmd cmd = { 0 };
+	const u32 rcv_size = sizeof(cmd.res);
+	const u32 snd_size = sizeof(cmd);
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
+	cmd.req.size = cpu_to_le32(snd_size - rcv_size);
+	cmd.req.code = cpu_to_le32(IXXAT_USB_CAN_CMD_INIT);
+	cmd.req.port = cpu_to_le16(port);
+	cmd.mode = opmode;
+	cmd.btr0 = btr0;
+	cmd.btr1 = btr1;
+
+	return ixxat_usb_send_cmd(dev, port, &cmd, snd_size, &cmd.res,
+				  rcv_size, IXXAT_USB_CMD_TIMEOUT);
+}
+
+const struct ixxat_usb_adapter usb2can_cl1 = {
+	.clock = IXXAT_USB_CLOCK,
+	.bt = &usb2can_bt,
+	.modes = IXXAT_USB_MODES,
+	.buffer_size_rx = IXXAT_USB_BUFFER_SIZE_RX,
+	.buffer_size_tx = IXXAT_USB_BUFFER_SIZE_TX,
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
-- 
2.53.0

