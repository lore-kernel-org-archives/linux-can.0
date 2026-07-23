Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA303E717A
	for <linux-can@vger.kernel.org>; Thu, 23 Jul 2026 07:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784791839; cv=none; b=ZwwCr9trfFNtEsELu6wKpHp7JBZ6Ln45iHH7RjEZF7U8gls6jszyQgDlzKLamXMLm0u6ildV62gv/YPC6s1rM9FfPzScY1v2OJ2j5ms/nFekiTY0NlGasKd2FYGobUUjrf7MSXrN0TZvPYxhSC2ruWV96h1SaS4fIhjItm4rCNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784791839; c=relaxed/simple;
	bh=lXwCTGw1cw7FBC8Lwqx7qVI6GH//PWteHkRQXpGI8W8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WxX3BgIW/FzrJJEGKHb08EqKYCAHYJ/rpzJ5nCfe911N6S4heqxps76BRonTnid6NazPtkX8/yRJjZ+kQ2oWAt3/rVkz1ZYwls11J0N+FWw7Sv4Z3xoIaDd3y5NDBCLFpqLlZ3C/nonVGTtTBZTZAuJ+u+mHPbZduKUnxbWDjZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=CNIpwGJB; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="CNIpwGJB"
Received: from stf-laptop (unknown [IPv6:2a02:8428:60a1:3e01:76e8:6ddc:7f18:a4b2])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 6BBEB2003E8;
	Thu, 23 Jul 2026 09:30:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1784791832;
	bh=lXwCTGw1cw7FBC8Lwqx7qVI6GH//PWteHkRQXpGI8W8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CNIpwGJBEnpEdr45mPbtQQnA5narbi7Zvi/FYwnSYNZSYlojAHiclv3xE+rTFfpYG
	 EN8/CUnCjvog3UD8PnjRocmtrHs7OyTCifXqg7MrKSYTd9BzF9uoiDMePqXgIaGUtT
	 d3NPDsHQhrME677vys80HI8sE5A5jy/iEA9udcvWrMECIVgwJPKVfUBaJSGURNhncD
	 F8u6bgjc4DWRRlpHD7PjKSwEbJb3KSZb7pTsTdB29xOq990qRv+9UydakPXFZrggH5
	 iTYBk3AJxJuJ3TQLnUO4uSVbQNbFtfU1mo3NE0gwVaJvYQuMt/nxpyr2rxNTTB+yfE
	 6IL/x1P/ybrOw==
From: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <stephane.grosjean@free.fr>
To: linux-can Mailing List <linux-can@vger.kernel.org>
Cc: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <s.grosjean@peak-system.fr>
Subject: [PATCH 3/4] can: usb: ixxat_usb: add CL2/V2 protocol layer with CAN
Date: Thu, 23 Jul 2026 09:29:38 +0200
Message-ID: <20260723072955.32575-4-stephane.grosjean@free.fr>
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

Add ixxat_usb_cl2.c, which implements the CL2 transfer protocol
(V2 communication layer) used by all CAN FD capable IXXAT adapters and
by USB-to-CAN V2 classic-only devices whose firmware version is >= 1.7.

Three adapter descriptors are exported:

  usb2can_fd   – CAN FD adapters (USB-to-CAN FD Compact/Pro/Automotive/
                 MiniPCIe, USB-to-CAN/FD Pro/Standard and variants,
                 USB-to-CAR).  Supports ISO and non-ISO CAN FD with
                 independent arbitration and data-phase bittiming.

  usb2can_v2   – USB-to-CAN V2 (classic CAN 2.0b only via CL2).

  can_fd_idm   – CAN IDM101/IDM200 modules with dedicated USB endpoints
                 per channel and a wider bittiming range.

The init command carries two sets of bittiming parameters (nominal and
data-phase) and flags for listen-only, triple-sampling, loopback,
bus-error reporting, CAN FD (ISO) and non-ISO CAN FD.

Supported control modes (FD adapters): listen-only, loopback,
triple-sampling, bus-error reporting, CAN FD, non-ISO CAN FD.

Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c | 347 ++++++++++++++++++
 1 file changed, 347 insertions(+)
 create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c

diff --git a/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c b/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c
new file mode 100644
index 000000000000..6a56a2bbdbbf
--- /dev/null
+++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c
@@ -0,0 +1,347 @@
+// SPDX-License-Identifier: GPL-2.0
+/* CAN driver adapter for IXXAT USB-to-CAN CL2
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
+					 CAN_CTRLMODE_FD_NON_ISO)
+
+#define IXXAT_USB_MODES			(CAN_CTRLMODE_LISTENONLY | \
+					 CAN_CTRLMODE_3_SAMPLES | \
+					 CAN_CTRLMODE_LOOPBACK | \
+					 CAN_CTRLMODE_BERR_REPORTING)
+
+/* bittiming parameters USB-to-CAN FD */
+#define IXXAT_USB2CANFD_TSEG1_MIN	1
+#define IXXAT_USB2CANFD_TSEG1_MAX	256
+#define IXXAT_USB2CANFD_TSEG2_MIN	1
+#define IXXAT_USB2CANFD_TSEG2_MAX	256
+#define IXXAT_USB2CANFD_SJW_MAX		128
+#define IXXAT_USB2CANFD_BRP_MIN		2
+#define IXXAT_USB2CANFD_BRP_MAX		513
+#define IXXAT_USB2CANFD_BRP_INC		1
+
+#define IXXAT_USB2CANFD_TSEG1_MIN_DATA	1
+#define IXXAT_USB2CANFD_TSEG1_MAX_DATA	256
+#define IXXAT_USB2CANFD_TSEG2_MIN_DATA	1
+#define IXXAT_USB2CANFD_TSEG2_MAX_DATA	256
+#define IXXAT_USB2CANFD_SJW_MAX_DATA	128
+#define IXXAT_USB2CANFD_BRP_MIN_DATA	2
+#define IXXAT_USB2CANFD_BRP_MAX_DATA	513
+#define IXXAT_USB2CANFD_BRP_INC_DATA	1
+
+/* bittiming parameters USB-to-CAN V2 */
+#define IXXAT_USB2CANV2_TSEG1_MIN	1
+#define IXXAT_USB2CANV2_TSEG1_MAX	16
+#define IXXAT_USB2CANV2_TSEG2_MIN	1
+#define IXXAT_USB2CANV2_TSEG2_MAX	8
+#define IXXAT_USB2CANV2_SJW_MAX		4
+#define IXXAT_USB2CANV2_BRP_MIN		1
+#define IXXAT_USB2CANV2_BRP_MAX		1024
+#define IXXAT_USB2CANV2_BRP_INC		1
+
+/* bittiming parameters CAN IDM */
+#define IXXAT_CANIDM_TSEG1_MIN		1
+#define IXXAT_CANIDM_TSEG1_MAX		256
+#define IXXAT_CANIDM_TSEG2_MIN		1
+#define IXXAT_CANIDM_TSEG2_MAX		128
+#define IXXAT_CANIDM_SJW_MAX		128
+#define IXXAT_CANIDM_BRP_MIN		1
+#define IXXAT_CANIDM_BRP_MAX		512
+#define IXXAT_CANIDM_BRP_INC		1
+
+#define IXXAT_CANIDM_TSEG1_MIN_DATA	1
+#define IXXAT_CANIDM_TSEG1_MAX_DATA	32
+#define IXXAT_CANIDM_TSEG2_MIN_DATA	1
+#define IXXAT_CANIDM_TSEG2_MAX_DATA	16
+#define IXXAT_CANIDM_SJW_MAX_DATA	8
+#define IXXAT_CANIDM_BRP_MIN_DATA	1
+#define IXXAT_CANIDM_BRP_MAX_DATA	32
+#define IXXAT_CANIDM_BRP_INC_DATA	1
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
+	.tseg1_min = IXXAT_USB2CANV2_TSEG1_MIN,
+	.tseg1_max = IXXAT_USB2CANV2_TSEG1_MAX,
+	.tseg2_min = IXXAT_USB2CANV2_TSEG2_MIN,
+	.tseg2_max = IXXAT_USB2CANV2_TSEG2_MAX,
+	.sjw_max = IXXAT_USB2CANV2_SJW_MAX,
+	.brp_min = IXXAT_USB2CANV2_BRP_MIN,
+	.brp_max = IXXAT_USB2CANV2_BRP_MAX,
+	.brp_inc = IXXAT_USB2CANV2_BRP_INC,
+};
+
+static const struct can_bittiming_const usb2can_fd_bt = {
+	.name = KBUILD_MODNAME,
+	.tseg1_min = IXXAT_USB2CANFD_TSEG1_MIN,
+	.tseg1_max = IXXAT_USB2CANFD_TSEG1_MAX,
+	.tseg2_min = IXXAT_USB2CANFD_TSEG2_MIN,
+	.tseg2_max = IXXAT_USB2CANFD_TSEG2_MAX,
+	.sjw_max = IXXAT_USB2CANFD_SJW_MAX,
+	.brp_min = IXXAT_USB2CANFD_BRP_MIN,
+	.brp_max = IXXAT_USB2CANFD_BRP_MAX,
+	.brp_inc = IXXAT_USB2CANFD_BRP_INC,
+};
+
+static const struct can_bittiming_const usb2can_fd_btd = {
+	.name = KBUILD_MODNAME,
+	.tseg1_min = IXXAT_USB2CANFD_TSEG1_MIN_DATA,
+	.tseg1_max = IXXAT_USB2CANFD_TSEG1_MAX_DATA,
+	.tseg2_min = IXXAT_USB2CANFD_TSEG2_MIN_DATA,
+	.tseg2_max = IXXAT_USB2CANFD_TSEG2_MAX_DATA,
+	.sjw_max = IXXAT_USB2CANFD_SJW_MAX_DATA,
+	.brp_min = IXXAT_USB2CANFD_BRP_MIN_DATA,
+	.brp_max = IXXAT_USB2CANFD_BRP_MAX_DATA,
+	.brp_inc = IXXAT_USB2CANFD_BRP_INC_DATA,
+};
+
+static const struct can_bittiming_const canidm_bt = {
+	.name = KBUILD_MODNAME,
+	.tseg1_min = IXXAT_CANIDM_TSEG1_MIN,
+	.tseg1_max = IXXAT_CANIDM_TSEG1_MAX,
+	.tseg2_min = IXXAT_CANIDM_TSEG2_MIN,
+	.tseg2_max = IXXAT_CANIDM_TSEG2_MAX,
+	.sjw_max = IXXAT_CANIDM_SJW_MAX,
+	.brp_min = IXXAT_CANIDM_BRP_MIN,
+	.brp_max = IXXAT_CANIDM_BRP_MAX,
+	.brp_inc = IXXAT_CANIDM_BRP_INC
+};
+
+static const struct can_bittiming_const canidm_btd = {
+	.name = KBUILD_MODNAME,
+	.tseg1_min = IXXAT_CANIDM_TSEG1_MIN_DATA,
+	.tseg1_max = IXXAT_CANIDM_TSEG1_MAX_DATA,
+	.tseg2_min = IXXAT_CANIDM_TSEG2_MIN_DATA,
+	.tseg2_max = IXXAT_CANIDM_TSEG2_MAX_DATA,
+	.sjw_max = IXXAT_CANIDM_SJW_MAX_DATA,
+	.brp_min = IXXAT_CANIDM_BRP_MIN_DATA,
+	.brp_max = IXXAT_CANIDM_BRP_MAX_DATA,
+	.brp_inc = IXXAT_CANIDM_BRP_INC_DATA
+};
+
+static int ixxat_usb_get_ctrl_caps(struct ixxat_usb_candevice *dev,
+				   struct ixxat_cancaps2 *caps)
+{
+	const u16 port = dev->ctrl_index;
+	struct ixxat_usb_getcaps_cl2_cmd cmd = { 0 };
+	const u32 cmd_size = sizeof(cmd);
+	const u32 req_size = sizeof(cmd.req);
+	const u32 rcv_size = cmd_size - req_size;
+	const u32 snd_size = req_size + sizeof(cmd.res);
+	int err;
+
+	ixxat_usb_setup_cmd(&cmd.req, &cmd.res);
+	cmd.req.code = cpu_to_le32(IXXAT_USB_CAN_CMD_GETCAPS2);
+	cmd.req.port = cpu_to_le16(port);
+	cmd.res.res_size = cpu_to_le32(rcv_size);
+
+	err = ixxat_usb_send_cmd(dev, port, &cmd, snd_size, &cmd.res,
+				 rcv_size, IXXAT_USB_CMD_TIMEOUT);
+	if (!err && caps)
+		memcpy(caps, &cmd.caps, sizeof(*caps));
+
+	return err;
+}
+
+static int ixxat_usb_init_ctrl(struct ixxat_usb_candevice *dev)
+{
+	const struct can_bittiming *bt = &dev->can.bittiming;
+	const struct can_bittiming *btd = &dev->can.fd.data_bittiming;
+	const u16 port = dev->ctrl_index;
+	struct ixxat_usb_init_cl2_cmd cmd = { 0 };
+	const u32 rcv_size = sizeof(cmd.res);
+	const u32 snd_size = sizeof(cmd);
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
+	cmd.req.size = cpu_to_le32(snd_size - rcv_size);
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
+		u16 tdo = btd->brp * (btd->phase_seg1 + 1 + btd->prop_seg);
+
+		cmd.fdr.mode = cpu_to_le32(btmode);
+		cmd.fdr.bps = cpu_to_le32(btd->brp);
+		cmd.fdr.ts1 = cpu_to_le16(btd->prop_seg + btd->phase_seg1);
+		cmd.fdr.ts2 = cpu_to_le16(btd->phase_seg2);
+		cmd.fdr.sjw = cpu_to_le16(btd->sjw);
+		cmd.fdr.tdo = cpu_to_le16(tdo);
+	}
+
+	return ixxat_usb_send_cmd(dev, port, &cmd, snd_size, &cmd.res,
+				  rcv_size, IXXAT_USB_CMD_TIMEOUT);
+}
+
+const struct ixxat_usb_adapter usb2can_fd = {
+	.clock = IXXAT_USB_CLOCK,
+	.bt = &usb2can_fd_bt,
+	.btd = &usb2can_fd_btd,
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
-- 
2.53.0

