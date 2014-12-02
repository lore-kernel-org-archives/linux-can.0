From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH v2 2/3] can/peak_usb: CAN-FD: add new adapters specific files
Date: Tue,  2 Dec 2014 11:31:53 +0100
Message-ID: <1417516314-17486-3-git-send-email-s.grosjean@peak-system.com>
References: <1417516314-17486-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:51748 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162AbaLBKcb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Dec 2014 05:32:31 -0500
In-Reply-To: <1417516314-17486-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Stephane Grosjean <s.grosjean@peak-system.com>

This patch adds 3 new files to add support to the following CAN-FD USB adapters
from PEAK-System Technik:

PCAN-USB FD             single CAN-FD channel USB adapter
PCAN-USB Pro FD         dual CAN-FD channels USB adapter

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_ucan.h   | 208 +++++++
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 955 +++++++++++++++++++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_fd.h | 108 ++++
 3 files changed, 1271 insertions(+)
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_ucan.h
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_fd.c
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_fd.h

diff --git a/drivers/net/can/usb/peak_usb/pcan_ucan.h b/drivers/net/can/usb/peak_usb/pcan_ucan.h
new file mode 100644
index 0000000..2223c05
--- /dev/null
+++ b/drivers/net/can/usb/peak_usb/pcan_ucan.h
@@ -0,0 +1,208 @@
+/*
+ * CAN driver for PEAK System micro-CAN based adapters
+ *
+ * Copyright (C) 2003-2011 PEAK System-Technik GmbH
+ * Copyright (C) 2011-2013 Stephane Grosjean <s.grosjean@peak-system.com>
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
+#ifndef PUCAN_H
+#define PUCAN_H
+
+/* uCAN commands opcodes list (low-order 10 bits) */
+#define PUCAN_CMD_NOP			0x000
+#define PUCAN_CMD_RESET_MODE		0x001
+#define PUCAN_CMD_NORMAL_MODE		0x002
+#define PUCAN_CMD_LISTEN_ONLY_MODE	0x003
+#define PUCAN_CMD_TIMING_SLOW		0x004
+#define PUCAN_CMD_TIMING_FAST		0x005
+#define PUCAN_CMD_FILTER_STD		0x008
+#define PUCAN_CMD_TX_ABORT		0x009
+#define PUCAN_CMD_WR_ERR_CNT		0x00a
+#define PUCAN_CMD_RX_FRAME_ENABLE	0x00b
+#define PUCAN_CMD_RX_FRAME_DISABLE	0x00c
+#define PUCAN_CMD_END_OF_COLLECTION	0x3ff
+
+/* uCAN received messages list */
+#define PUCAN_MSG_CAN_RX		0x0001
+#define PUCAN_MSG_ERROR			0x0002
+#define PUCAN_MSG_STATUS		0x0003
+#define PUCAN_MSG_BUSLOAD		0x0004
+#define PUCAN_MSG_CAN_TX		0x1000
+
+/* uCAN command common header */
+#define PUCAN_CMD_OPCODE(c)		((c)->opcode_channel & 0x3ff)
+#define PUCAN_CMD_CHANNEL(c)		((c)->opcode_channel >> 12)
+#define PUCAN_CMD_OPCODE_CHANNEL(c, o)	cpu_to_le16(((c) << 12) | ((o) & 0x3ff))
+
+struct __packed pucan_command {
+	u16	opcode_channel;
+	u16	args[3];
+};
+
+/* uCAN TIMING_SLOW command fields */
+#define PUCAN_TSLOW_SJW_T(s, t)		(((s) & 0xf) | ((!!(t)) << 7))
+#define PUCAN_TSLOW_TSEG2(t)		((t) & 0xf)
+#define PUCAN_TSLOW_TSEG1(t)		((t) & 0x3f)
+#define PUCAN_TSLOW_BRP(b)		cpu_to_le16((b) & 0x3ff)
+
+struct __packed pucan_timing_slow {
+	u16	opcode_channel;
+
+	u8	ewl;		/* Error Warning limit */
+	u8	sjw_t;		/* Sync Jump Width + Triple sampling */
+	u8	tseg2;		/* Timing SEGment 2 */
+	u8	tseg1;		/* Timing SEGment 1 */
+
+	u16	brp;		/* BaudRate Prescaler */
+};
+
+/* uCAN TIMING_FAST command fields */
+#define PUCAN_TFAST_SJW(s)		((s) & 0x3)
+#define PUCAN_TFAST_TSEG2(t)		((t) & 0x7)
+#define PUCAN_TFAST_TSEG1(t)		((t) & 0xf)
+#define PUCAN_TFAST_BRP(b)		cpu_to_le16((b) & 0x3ff)
+
+struct __packed pucan_timing_fast {
+	u16	opcode_channel;
+
+	u8	unused;
+	u8	sjw;		/* Sync Jump Width */
+	u8	tseg2;		/* Timing SEGment 2 */
+	u8	tseg1;		/* Timing SEGment 1 */
+
+	u16	brp;		/* BaudRate Prescaler */
+};
+
+/* uCAN FILTER_STD command fields */
+#define PUCAN_FLTSTD_ROW_IDX_BITS	6
+
+struct __packed pucan_filter_std {
+	u16	opcode_channel;
+
+	u16	idx;
+	u32	mask;		/* CAN-ID bitmask in idx range */
+};
+
+/* uCAN WR_ERR_CNT command fields */
+#define PUCAN_WRERRCNT_TE(c)		0x4000	/* Tx error cntr write Enable */
+#define PUCAN_WRERRCNT_RE(c)		0x8000	/* Rx error cntr write Enable */
+
+struct __packed pucan_wr_err_cnt {
+	u16	opcode_channel;
+
+	u16	sel_mask;
+	u8	tx_counter;	/* Tx error counter new value */
+	u8	rx_counter;	/* Rx error counter new value */
+
+	u16	unused;
+};
+
+/* uCAN RX_FRAME_ENABLE command fields */
+#define PUCAN_FLTEXT_ERROR		0x0001
+#define PUCAN_FLTEXT_BUSLOAD		0x0002
+
+struct __packed pucan_filter_ext {
+	u16	opcode_channel;
+
+	u16	ext_mask;
+	u32	unused;
+};
+
+/* uCAN received messages global format */
+struct __packed pucan_msg {
+	__le16	size;
+	__le16	type;
+	__le32	ts_low;
+	__le32	ts_high;
+};
+
+/* uCAN flags for CAN/CANFD messages */
+#define PUCAN_MSG_SELF_RECEIVE		0x80
+#define PUCAN_MSG_ERROR_STATE_IND	0x40	/* error state indicator */
+#define PUCAN_MSG_BITRATE_SWITCH	0x20	/* bitrate switch */
+#define PUCAN_MSG_EXT_DATA_LEN		0x10	/* extended data length */
+#define PUCAN_MSG_SINGLE_SHOT		0x08
+#define PUCAN_MSG_LOOPED_BACK		0x04
+#define PUCAN_MSG_EXT_ID		0x02
+#define PUCAN_MSG_RTR			0x01
+
+#define PUCAN_MSG_CHANNEL(m)		((m)->channel_dlc & 0xf)
+#define PUCAN_MSG_DLC(m)		((m)->channel_dlc >> 4)
+
+struct __packed pucan_rx_msg {
+	__le16	size;
+	__le16	type;
+	__le32	ts_low;
+	__le32	ts_high;
+	__le32	tag_low;
+	__le32	tag_high;
+	u8	channel_dlc;
+	u8	client;
+	__le16	flags;
+	__le32	can_id;
+	u8	d[0];
+};
+
+/* uCAN error types */
+#define PUCAN_ERMSG_BIT_ERROR		0
+#define PUCAN_ERMSG_FORM_ERROR		1
+#define PUCAN_ERMSG_STUFF_ERROR		2
+#define PUCAN_ERMSG_OTHER_ERROR		3
+#define PUCAN_ERMSG_ERR_CNT_DEC		4
+
+#define PUCAN_ERMSG_CHANNEL(e)		((e)->channel_type_d & 0x0f)
+#define PUCAN_ERMSG_ERRTYPE(e)		(((e)->channel_type_d >> 4) & 0x07)
+#define PUCAN_ERMSG_D(e)		((e)->channel_type_d & 0x80)
+
+#define PUCAN_ERMSG_ERRCODE(e)		((e)->code_g & 0x7f)
+#define PUCAN_ERMSG_G(e)		((e)->code_g & 0x80)
+
+struct __packed pucan_error_msg {
+	__le16	size;
+	__le16	type;
+	__le32	ts_low;
+	__le32	ts_high;
+	u8	channel_type_d;
+	u8	code_g;
+	u8	tx_err_cnt;
+	u8	rx_err_cnt;
+};
+
+#define PUCAN_STMSG_CHANNEL(e)		((e)->channel_p_w_b & 0x0f)
+#define PUCAN_STMSG_PASSIVE(e)		((e)->channel_p_w_b & 0x20)
+#define PUCAN_STMSG_WARNING(e)		((e)->channel_p_w_b & 0x40)
+#define PUCAN_STMSG_BUSOFF(e)		((e)->channel_p_w_b & 0x80)
+
+struct __packed pucan_status_msg {
+	__le16	size;
+	__le16	type;
+	__le32	ts_low;
+	__le32	ts_high;
+	u8	channel_p_w_b;
+	u8	unused[3];
+};
+
+/* uCAN transmitted message format */
+#define PUCAN_MSG_CHANNEL_DLC(c, d)	(((c) & 0xf) | ((d) << 4))
+
+struct __packed pucan_tx_msg {
+	__le16	size;
+	__le16	type;
+	__le32	tag_low;
+	__le32	tag_high;
+	u8	channel_dlc;
+	u8	client;
+	u16	flags;
+	__le32	can_id;
+	u8	d[0];
+};
+
+#endif
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
new file mode 100644
index 0000000..cc6fc76
--- /dev/null
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -0,0 +1,955 @@
+/*
+ * CAN driver for PEAK System PCAN-USB FD / PCAN-USB Pro FD adapter
+ *
+ * Copyright (C) 2013-2014 Stephane Grosjean <s.grosjean@peak-system.com>
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
+#include <linux/netdevice.h>
+#include <linux/usb.h>
+#include <linux/module.h>
+
+#include <linux/can.h>
+#include <linux/can/dev.h>
+#include <linux/can/error.h>
+
+#include "pcan_usb_core.h"
+#include "pcan_usb_fd.h"
+
+MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB FD adapter");
+MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB Pro FD adapter");
+
+#define ALIGN32(x)			(((x) + 3) & 0xFFFFFFFC)
+
+#define PCAN_USBPROFD_CHANNEL_COUNT	2
+#define PCAN_USBFD_CHANNEL_COUNT	1
+
+/* PCAN-USB Pro FD adapter internal clock (MHz) */
+#define PCAN_UFD_CRYSTAL_HZ		80000000
+
+#define PCAN_UFD_CMD_BUFFER_SIZE	512
+#define PCAN_UFD_LOSPD_PKT_SIZE		64
+
+/* PCAN-USB Pro FD command timeout (ms.) */
+#define PCAN_UFD_COMMAND_TIMEOUT	1000
+
+/* PCAN-USB Pro FD rx/tx buffers size */
+#define PCAN_UFD_RX_BUFFER_SIZE		2048
+#define PCAN_UFD_TX_BUFFER_SIZE		512
+
+/* handle device specific info used by the netdevices */
+struct pcan_usb_fd_if {
+	struct peak_usb_device *dev[PCAN_USB_MAX_CHANNEL];
+	struct peak_time_ref time_ref;
+	int cm_ignore_count;
+	int dev_opened_count;
+};
+
+/* device information */
+struct pcan_usb_fd_device {
+	struct peak_usb_device dev;
+	struct pcan_usb_fd_if *usb_if;
+
+	u8 *cmd_buffer_addr;
+
+	uint tx_error_counter;
+	uint rx_error_counter;
+};
+
+/* Clock mode frequence values */
+static const u32 pcan_usb_fd_clk_freq[6] = {
+	[PCAN_UFD_CLK_80MHZ] = 80000000,
+	[PCAN_UFD_CLK_60MHZ] = 60000000,
+	[PCAN_UFD_CLK_40MHZ] = 40000000,
+	[PCAN_UFD_CLK_30MHZ] = 30000000,
+	[PCAN_UFD_CLK_24MHZ] = 24000000,
+	[PCAN_UFD_CLK_20MHZ] = 20000000
+};
+
+/* functions exported from PCAN-USB Pro interface */
+extern int pcan_usb_pro_probe(struct usb_interface *intf);
+extern int pcan_usb_pro_send_req(struct peak_usb_device *dev, int req_id,
+				 int req_value, void *req_addr, int req_size);
+extern void pcan_usb_pro_restart_complete(struct urb *urb);
+
+/* return a device USB interface */
+static inline
+struct pcan_usb_fd_if *pcan_usb_fd_dev_if(struct peak_usb_device *dev)
+{
+	struct pcan_usb_fd_device *pdev =
+			container_of(dev, struct pcan_usb_fd_device, dev);
+	return pdev->usb_if;
+}
+
+/* return a device USB commands buffer */
+static inline void *pcan_usb_fd_cmd_buffer(struct peak_usb_device *dev)
+{
+	struct pcan_usb_fd_device *pdev =
+			container_of(dev, struct pcan_usb_fd_device, dev);
+	return pdev->cmd_buffer_addr;
+}
+
+/* send PCAN-USB Pro FD commands synchronously */
+static int pcan_usb_fd_send_cmd(struct peak_usb_device *dev, void *cmd_tail)
+{
+	void *cmd_head = pcan_usb_fd_cmd_buffer(dev);
+	int actual_length;
+	int err, cmd_len;
+	u8 *packet_ptr;
+	int p, n = 1, packet_len;
+
+	/* usb device unregistered? */
+	if (!(dev->state & PCAN_USB_STATE_CONNECTED))
+		return 0;
+
+	/*
+	 * if a packet is not filled completely by commands, the command list
+	 * is terminated with an "end of collection" record.
+	 */
+	cmd_len = cmd_tail - cmd_head;
+	if (cmd_len < PCAN_UFD_CMD_BUFFER_SIZE) {
+		memset(cmd_tail, 0xff, sizeof(u64));
+		cmd_len += sizeof(u64);
+	}
+
+	packet_ptr = cmd_head;
+
+	/* firmware is not able to re-assemble 512 bytes buffer in full-speed */
+	if ((dev->udev->speed != USB_SPEED_HIGH) &&
+	    (cmd_len > PCAN_UFD_LOSPD_PKT_SIZE)) {
+		packet_len = PCAN_UFD_LOSPD_PKT_SIZE;
+		n += cmd_len / packet_len;
+	} else {
+		packet_len = cmd_len;
+	}
+
+	for (p = 1; p <= n; p++) {
+		err = usb_bulk_msg(dev->udev,
+				   usb_sndbulkpipe(dev->udev,
+						   PCAN_USBPRO_EP_CMDOUT),
+				   packet_ptr, packet_len,
+				   &actual_length, PCAN_UFD_COMMAND_TIMEOUT);
+		if (err) {
+			netdev_err(dev->netdev,
+				   "sending command failure: %d\n", err);
+			break;
+		}
+
+		packet_ptr += packet_len;
+	}
+
+	return err;
+}
+
+static int pcan_usb_fd_set_bus(struct peak_usb_device *dev, u8 onoff)
+{
+	struct pucan_command *cmd = pcan_usb_fd_cmd_buffer(dev);
+	u16 opcode;
+
+	if (onoff) {
+		opcode = (dev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY) ?
+				PUCAN_CMD_LISTEN_ONLY_MODE :
+				PUCAN_CMD_NORMAL_MODE;
+	} else {
+		opcode = PUCAN_CMD_RESET_MODE;
+	}
+
+	cmd->opcode_channel = PUCAN_CMD_OPCODE_CHANNEL(dev->ctrl_idx, opcode);
+
+	/* send the command */
+	return pcan_usb_fd_send_cmd(dev, ++cmd);
+}
+
+/*
+ * Set filtering masks:
+ *
+ *	idx in range [0..63] selects row #idx, all rows otherwise.
+ *	mask in range [0..0xffffffff]
+ *
+ */
+static int pcan_usb_fd_set_filter_std(struct peak_usb_device *dev, int idx,
+				      u32 mask)
+{
+	return 0;
+}
+
+/*
+ * set/unset notifications filter:
+ *
+ *	onoff	sets(1)/unset(0) notifications
+ *	mask	each bit defines a kind of notification to set/unset
+ */
+static int pcan_usb_fd_set_filter_ext(struct peak_usb_device *dev,
+				      int onoff, u16 ext_mask, u16 usb_mask)
+{
+	struct pcan_ufd_filter_ext *cmd = pcan_usb_fd_cmd_buffer(dev);
+
+	cmd->opcode_channel = PUCAN_CMD_OPCODE_CHANNEL(dev->ctrl_idx,
+					(onoff) ? PUCAN_CMD_RX_FRAME_ENABLE :
+						  PUCAN_CMD_RX_FRAME_DISABLE);
+
+	cmd->ext_mask = cpu_to_le16(ext_mask);
+	cmd->usb_mask = cpu_to_le16(usb_mask);
+
+	/* send the command */
+	return pcan_usb_fd_send_cmd(dev, ++cmd);
+}
+
+/* setup LED control */
+static int pcan_usb_fd_set_can_led(struct peak_usb_device *dev, u8 led_mode)
+{
+	struct pcan_ufd_led *cmd = pcan_usb_fd_cmd_buffer(dev);
+
+	cmd->opcode_channel = PUCAN_CMD_OPCODE_CHANNEL(dev->ctrl_idx,
+						       PCAN_UFD_CMD_LED_SET);
+	cmd->mode = led_mode;
+
+	/* send the command */
+	return pcan_usb_fd_send_cmd(dev, ++cmd);
+}
+
+/* set CAN clock domain */
+static int pcan_usb_fd_set_clock_domain(struct peak_usb_device *dev,
+					u8 clk_mode)
+{
+	struct pcan_ufd_clock *cmd = pcan_usb_fd_cmd_buffer(dev);
+
+	cmd->opcode_channel = PUCAN_CMD_OPCODE_CHANNEL(dev->ctrl_idx,
+						       PCAN_UFD_CMD_CLK_SET);
+	cmd->mode = clk_mode;
+
+	/* send the command */
+	return pcan_usb_fd_send_cmd(dev, ++cmd);
+}
+
+/* set bittiming for CAN and CAN-FD header */
+static int pcan_usb_fd_set_bittiming_slow(struct peak_usb_device *dev,
+					  struct can_bittiming *bt)
+{
+	struct pucan_timing_slow *cmd = pcan_usb_fd_cmd_buffer(dev);
+
+	cmd->opcode_channel = PUCAN_CMD_OPCODE_CHANNEL(dev->ctrl_idx,
+						       PUCAN_CMD_TIMING_SLOW);
+	cmd->sjw_t = PUCAN_TSLOW_SJW_T(bt->sjw - 1,
+				dev->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES);
+
+	cmd->tseg2 = PUCAN_TSLOW_TSEG2(bt->phase_seg2 - 1);
+	cmd->tseg1 = PUCAN_TSLOW_TSEG1(bt->prop_seg + bt->phase_seg1 - 1);
+	cmd->brp = PUCAN_TSLOW_BRP(bt->brp - 1);
+
+	cmd->ewl = 96;	/* default */
+
+	/* send the command */
+	return pcan_usb_fd_send_cmd(dev, ++cmd);
+}
+
+/* set CAN-FD bittiming for data */
+static int pcan_usb_fd_set_bittiming_fast(struct peak_usb_device *dev,
+					  struct can_bittiming *bt)
+{
+	struct pucan_timing_fast *cmd = pcan_usb_fd_cmd_buffer(dev);
+
+	cmd->opcode_channel = PUCAN_CMD_OPCODE_CHANNEL(dev->ctrl_idx,
+						       PUCAN_CMD_TIMING_FAST);
+	cmd->sjw = PUCAN_TFAST_SJW(bt->sjw - 1);
+	cmd->tseg2 = PUCAN_TFAST_TSEG2(bt->phase_seg2 - 1);
+	cmd->tseg1 = PUCAN_TFAST_TSEG1(bt->prop_seg + bt->phase_seg1 - 1);
+	cmd->brp = PUCAN_TFAST_BRP(bt->brp - 1);
+
+	/* send the command */
+	return pcan_usb_fd_send_cmd(dev, ++cmd);
+}
+
+/*
+ * handle restart but in asynchronously way
+ * (uses PCAN-USB Pro code to complete)
+ */
+static int pcan_usb_fd_restart_async(struct peak_usb_device *dev,
+				     struct urb *urb, u8 *buf)
+{
+	struct pucan_command *cmd = (struct pucan_command *)buf;
+
+	cmd->opcode_channel = PUCAN_CMD_OPCODE_CHANNEL(dev->ctrl_idx,
+				(dev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY) ?
+						PUCAN_CMD_LISTEN_ONLY_MODE :
+						PUCAN_CMD_NORMAL_MODE);
+	/* EOC */
+	memset(cmd+1, 0xff, sizeof(struct pucan_command));
+
+	usb_fill_bulk_urb(urb, dev->udev,
+			  usb_sndbulkpipe(dev->udev, PCAN_USBPRO_EP_CMDOUT),
+			  buf, 2 * sizeof(struct pucan_command),
+			  pcan_usb_pro_restart_complete, dev);
+
+	return usb_submit_urb(urb, GFP_ATOMIC);
+}
+
+static int pcan_usb_fd_drv_loaded(struct peak_usb_device *dev, int loaded)
+{
+	struct pcan_usb_fd_device *pdev =
+			container_of(dev, struct pcan_usb_fd_device, dev);
+
+	pdev->cmd_buffer_addr[0] = 0;
+	pdev->cmd_buffer_addr[1] = !!loaded;
+
+	return pcan_usb_pro_send_req(dev,
+				PCAN_USBPRO_REQ_FCT,
+				PCAN_USBPRO_FCT_DRVLD,
+				pdev->cmd_buffer_addr,
+				PCAN_USBPRO_FCT_DRVLD_REQ_LEN);
+}
+
+static int pcan_usb_fd_decode_canmsg(struct pcan_usb_fd_if *usb_if,
+				     struct pucan_msg *rx_msg)
+{
+	struct pucan_rx_msg *rm = (struct pucan_rx_msg *)rx_msg;
+	struct peak_usb_device *dev = usb_if->dev[PUCAN_MSG_CHANNEL(rm)];
+	struct net_device *netdev = dev->netdev;
+	struct canfd_frame *cfd;
+	struct sk_buff *skb;
+
+	if (rm->flags & PUCAN_MSG_EXT_DATA_LEN) {
+		/* CANFD frame case */
+		skb = alloc_canfd_skb(netdev, &cfd);
+		if (!skb)
+			return -ENOMEM;
+
+		if (rm->flags & PUCAN_MSG_BITRATE_SWITCH)
+			cfd->flags |= CANFD_BRS;
+
+		if (rm->flags & PUCAN_MSG_ERROR_STATE_IND)
+			cfd->flags |= CANFD_ESI;
+
+		cfd->len = can_dlc2len(PUCAN_MSG_DLC(rm));
+	} else {
+		/* CANFD frame case */
+		skb = alloc_can_skb(netdev, (struct can_frame **)&cfd);
+		if (!skb)
+			return -ENOMEM;
+
+		cfd->len = get_can_dlc(PUCAN_MSG_DLC(rm));
+	}
+
+	cfd->can_id = le32_to_cpu(rm->can_id);
+
+	if (rm->flags & PUCAN_MSG_EXT_ID)
+		cfd->can_id |= CAN_EFF_FLAG;
+
+	if (rm->flags & PUCAN_MSG_RTR)
+		cfd->can_id |= CAN_RTR_FLAG;
+	else
+		memcpy(cfd->data, rm->d, cfd->len);
+
+	peak_usb_netif_rx(skb, &usb_if->time_ref,
+			  le32_to_cpu(rm->ts_low), le32_to_cpu(rm->ts_high));
+
+	netdev->stats.rx_packets++;
+	netdev->stats.rx_bytes += cfd->len;
+
+	return 0;
+}
+
+/* handle uCAN status message */
+static int pcan_usb_fd_decode_status(struct pcan_usb_fd_if *usb_if,
+				     struct pucan_msg *rx_msg)
+{
+	struct pucan_status_msg *st = (struct pucan_status_msg *)rx_msg;
+	struct peak_usb_device *dev = usb_if->dev[PUCAN_STMSG_CHANNEL(st)];
+	struct pcan_usb_fd_device *pdev =
+			container_of(dev, struct pcan_usb_fd_device, dev);
+	enum can_state new_state = CAN_STATE_ERROR_ACTIVE;
+	struct net_device *netdev = dev->netdev;
+	struct can_frame *cf;
+	struct sk_buff *skb;
+
+	/* nothing should be sent while in BUS_OFF state */
+	if (dev->can.state == CAN_STATE_BUS_OFF)
+		return 0;
+
+	if (PUCAN_STMSG_BUSOFF(st)) {
+		new_state = CAN_STATE_BUS_OFF;
+	} else if (PUCAN_STMSG_PASSIVE(st)) {
+		new_state = CAN_STATE_ERROR_PASSIVE;
+	} else if (PUCAN_STMSG_WARNING(st)) {
+		new_state = CAN_STATE_ERROR_WARNING;
+	} else {
+		/* no error bit (so, no error skb, back to active state) */
+		dev->can.state = CAN_STATE_ERROR_ACTIVE;
+		pdev->tx_error_counter = 0;
+		pdev->rx_error_counter = 0;
+		return 0;
+	}
+
+	/* donot post any error if current state didn't change */
+	if (dev->can.state == new_state)
+		return 0;
+
+	/* allocate an skb to store the error frame */
+	skb = alloc_can_err_skb(netdev, &cf);
+	if (!skb)
+		return -ENOMEM;
+
+	switch (new_state) {
+	case CAN_STATE_BUS_OFF:
+		cf->can_id |= CAN_ERR_BUSOFF;
+		can_bus_off(netdev);
+		break;
+
+	case CAN_STATE_ERROR_PASSIVE:
+		cf->can_id |= CAN_ERR_CRTL;
+		if (pdev->rx_error_counter > 127)
+			cf->data[1] |= CAN_ERR_CRTL_RX_PASSIVE;
+		if (pdev->tx_error_counter > 127)
+			cf->data[1] |= CAN_ERR_CRTL_TX_PASSIVE;
+
+		dev->can.can_stats.error_passive++;
+		break;
+
+	case CAN_STATE_ERROR_WARNING:
+		cf->can_id |= CAN_ERR_CRTL;
+		if (pdev->rx_error_counter > 96)
+			cf->data[1] |= CAN_ERR_CRTL_RX_WARNING;
+		if (pdev->tx_error_counter > 96)
+			cf->data[1] |= CAN_ERR_CRTL_TX_WARNING;
+
+		dev->can.can_stats.error_warning++;
+		break;
+
+	default:
+		/* default case never happens, only for warnings */
+		new_state = CAN_STATE_ERROR_ACTIVE;
+
+	case CAN_STATE_ERROR_ACTIVE:	/* fallthrough */
+		pdev->tx_error_counter = 0;
+		pdev->rx_error_counter = 0;
+		break;
+	}
+
+	dev->can.state = new_state;
+
+	peak_usb_netif_rx(skb, &usb_if->time_ref,
+			  le32_to_cpu(st->ts_low), le32_to_cpu(st->ts_high));
+
+	netdev->stats.rx_packets++;
+	netdev->stats.rx_bytes += cf->can_dlc;
+
+	return 0;
+}
+
+/* handle uCAN error message */
+static int pcan_usb_fd_decode_error(struct pcan_usb_fd_if *usb_if,
+				    struct pucan_msg *rx_msg)
+{
+	struct pucan_error_msg *er = (struct pucan_error_msg *)rx_msg;
+	struct peak_usb_device *dev = usb_if->dev[PUCAN_ERMSG_CHANNEL(er)];
+	struct pcan_usb_fd_device *pdev =
+			container_of(dev, struct pcan_usb_fd_device, dev);
+
+	/* keep a trace of tx and rx error counters for later use */
+	pdev->tx_error_counter = er->tx_err_cnt;
+	pdev->rx_error_counter = er->rx_err_cnt;
+
+	return 0;
+}
+
+/* handle uCAN overrun message */
+static int pcan_usb_fd_decode_overrun(struct pcan_usb_fd_if *usb_if,
+				      struct pucan_msg *rx_msg)
+{
+	struct pcan_ufd_ovr_msg *ov = (struct pcan_ufd_ovr_msg *)rx_msg;
+	struct peak_usb_device *dev = usb_if->dev[PCAN_UFD_OVMSG_CHANNEL(ov)];
+	struct net_device *netdev = dev->netdev;
+	struct can_frame *cf;
+	struct sk_buff *skb;
+
+	/* allocate an skb to store the error frame */
+	skb = alloc_can_err_skb(netdev, &cf);
+	if (!skb)
+		return -ENOMEM;
+
+	cf->can_id |= CAN_ERR_CRTL;
+	cf->data[1] |= CAN_ERR_CRTL_RX_OVERFLOW;
+
+	peak_usb_netif_rx(skb, &usb_if->time_ref,
+			  le32_to_cpu(ov->ts_low), le32_to_cpu(ov->ts_high));
+
+	netdev->stats.rx_over_errors++;
+	netdev->stats.rx_errors++;
+
+	return 0;
+}
+
+/* handle USB calibration message */
+static void pcan_usb_fd_decode_ts(struct pcan_usb_fd_if *usb_if,
+				  struct pucan_msg *rx_msg)
+{
+	struct pcan_ufd_ts_msg *ts = (struct pcan_ufd_ts_msg *)rx_msg;
+
+	/* should wait until clock is stabilized */
+	if (usb_if->cm_ignore_count > 0)
+		usb_if->cm_ignore_count--;
+	else
+		peak_usb_set_ts_now(&usb_if->time_ref, le32_to_cpu(ts->ts_low));
+}
+
+/* callback for bulk IN urb */
+static int pcan_usb_fd_decode_buf(struct peak_usb_device *dev, struct urb *urb)
+{
+	struct pcan_usb_fd_if *usb_if = pcan_usb_fd_dev_if(dev);
+	struct net_device *netdev = dev->netdev;
+	struct pucan_msg *rx_msg;
+	u8 *msg_ptr, *msg_end;
+	int err = 0;
+
+	/* loop reading all the records from the incoming message */
+	msg_ptr = urb->transfer_buffer;
+	msg_end = urb->transfer_buffer + urb->actual_length;
+	for (; msg_ptr < msg_end;) {
+		u16 rx_msg_type, rx_msg_size;
+
+		rx_msg = (struct pucan_msg *)msg_ptr;
+		if (!rx_msg->size) {
+			/* null packet found: end of list */
+			break;
+		}
+
+		rx_msg_size = le16_to_cpu(rx_msg->size);
+		rx_msg_type = le16_to_cpu(rx_msg->type);
+
+		/* check if the record goes out of current packet */
+		if (msg_ptr + rx_msg_size > msg_end) {
+			netdev_err(netdev,
+				   "got frag rec: should inc usb rx buf sze\n");
+			err = -EBADMSG;
+			break;
+		}
+
+		switch (rx_msg_type) {
+		case PUCAN_MSG_CAN_RX:
+			err = pcan_usb_fd_decode_canmsg(usb_if, rx_msg);
+			if (err < 0)
+				goto fail;
+			break;
+
+		case PCAN_UFD_MSG_CALIBRATION:
+			pcan_usb_fd_decode_ts(usb_if, rx_msg);
+			break;
+
+		case PUCAN_MSG_ERROR:
+			err = pcan_usb_fd_decode_error(usb_if, rx_msg);
+			if (err < 0)
+				goto fail;
+			break;
+
+		case PUCAN_MSG_STATUS:
+			err = pcan_usb_fd_decode_status(usb_if, rx_msg);
+			if (err < 0)
+				goto fail;
+			break;
+
+		case PCAN_UFD_MSG_OVERRUN:
+			err = pcan_usb_fd_decode_overrun(usb_if, rx_msg);
+			if (err < 0)
+				goto fail;
+			break;
+
+		default:
+			netdev_err(netdev,
+				   "unhandled msg type 0x%02x (%d): ignored\n",
+				   rx_msg_type, rx_msg_type);
+			break;
+		}
+
+		msg_ptr += rx_msg_size;
+	}
+
+fail:
+	if (err)
+		pcan_dump_mem("received msg",
+			      urb->transfer_buffer, urb->actual_length);
+	return err;
+}
+
+/* CAN/CANFD frames encoding callback */
+static int pcan_usb_fd_encode_msg(struct peak_usb_device *dev,
+				  struct sk_buff *skb, u8 *obuf, size_t *size)
+{
+	struct pucan_tx_msg *tx_msg = (struct pucan_tx_msg *)obuf;
+	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
+	u16 tx_msg_size;
+	u8 can_dlc;
+
+	tx_msg_size = ALIGN32(sizeof(struct pucan_tx_msg) + cfd->len);
+	tx_msg->size = cpu_to_le16(tx_msg_size);
+	tx_msg->type = cpu_to_le16(PUCAN_MSG_CAN_TX);
+
+	tx_msg->flags = 0;
+	if (cfd->can_id & CAN_EFF_FLAG) {
+		tx_msg->flags |= PUCAN_MSG_EXT_ID;
+		tx_msg->can_id = cpu_to_le32(cfd->can_id & CAN_EFF_MASK);
+	} else {
+		tx_msg->can_id = cpu_to_le32(cfd->can_id & CAN_SFF_MASK);
+	}
+
+	if (skb->len == CANFD_MTU) {
+		/* considering a CANFD frame */
+		can_dlc = can_len2dlc(cfd->len);
+
+		tx_msg->flags |= PUCAN_MSG_EXT_DATA_LEN;
+
+		if (cfd->flags & CANFD_BRS)
+			tx_msg->flags |= PUCAN_MSG_BITRATE_SWITCH;
+
+		if (cfd->flags & CANFD_ESI)
+			tx_msg->flags |= PUCAN_MSG_ERROR_STATE_IND;
+	} else {
+		/* CAND 2.0 frames */
+		can_dlc = cfd->len;
+
+		if (cfd->can_id & CAN_RTR_FLAG)
+			tx_msg->flags |= PUCAN_MSG_RTR;
+	}
+
+	tx_msg->channel_dlc = PUCAN_MSG_CHANNEL_DLC(dev->ctrl_idx, can_dlc);
+	memcpy(tx_msg->d, cfd->data, cfd->len);
+
+	/* add null size message to tag the end (messages are 32-bits aligned)*/
+	tx_msg = (struct pucan_tx_msg *)(obuf + tx_msg_size);
+
+	tx_msg->size = 0;
+
+	/* set the whole size of the USB packet to send */
+	*size = tx_msg_size + sizeof(u32);
+
+	return 0;
+}
+
+/* start the interface (last chance before set bus on) */
+static int pcan_usb_fd_start(struct peak_usb_device *dev)
+{
+	struct pcan_usb_fd_device *pdev =
+			container_of(dev, struct pcan_usb_fd_device, dev);
+	int err;
+
+	/* set filter mode: all acceptance */
+	err = pcan_usb_fd_set_filter_std(dev, -1, 0xffffffff);
+	if (err)
+		return err;
+
+	/* opening first device: */
+	if (pdev->usb_if->dev_opened_count == 0) {
+		/* reset time_ref */
+		peak_usb_init_time_ref(&pdev->usb_if->time_ref,
+				       &pcan_usb_pro_fd);
+
+		/* enable USB calibration messages */
+		err = pcan_usb_fd_set_filter_ext(dev, 1,
+						 PUCAN_FLTEXT_ERROR,
+						 PCAN_UFD_FLTEXT_CALIBRATION);
+	}
+
+	pdev->usb_if->dev_opened_count++;
+
+	/* reset cached error counters */
+	pdev->tx_error_counter = 0;
+	pdev->rx_error_counter = 0;
+
+	return err;
+}
+
+/* stop interface (last chance before set bus off) */
+static int pcan_usb_fd_stop(struct peak_usb_device *dev)
+{
+	struct pcan_usb_fd_device *pdev =
+			container_of(dev, struct pcan_usb_fd_device, dev);
+
+	/* turn off special msgs for that interface if no other dev opened */
+	if (pdev->usb_if->dev_opened_count == 1)
+		pcan_usb_fd_set_filter_ext(dev, 0,
+					   PUCAN_FLTEXT_ERROR,
+					   PCAN_UFD_FLTEXT_CALIBRATION);
+	pdev->usb_if->dev_opened_count--;
+
+	return 0;
+}
+
+/* called when probing, to initialize a device object */
+static int pcan_usb_fd_init(struct peak_usb_device *dev)
+{
+	struct pcan_usb_fd_device *pdev =
+			container_of(dev, struct pcan_usb_fd_device, dev);
+	int i, err = -ENOMEM;
+
+	/* do this for 1st channel only */
+	if (!dev->prev_siblings) {
+		struct pcan_ufd_fw_info *fi;
+
+		/* allocate netdevices common structure attached to first one */
+		pdev->usb_if = kzalloc(sizeof(*pdev->usb_if), GFP_KERNEL);
+		if (!pdev->usb_if)
+			goto err_out;
+
+		/* allocate command buffer once for all for the interface */
+		pdev->cmd_buffer_addr = kmalloc(PCAN_UFD_CMD_BUFFER_SIZE,
+						GFP_KERNEL);
+		if (!pdev->cmd_buffer_addr)
+			goto err_out_1;
+
+		/* number of ts msgs to ignore before taking one into account */
+		pdev->usb_if->cm_ignore_count = 5;
+
+		/*
+		 * explicit use of dev_xxx() instead of netdev_xxx() here:
+		 * information displayed are related to the device itself, not
+		 * to the canx netdevices.
+		 */
+		fi = (struct pcan_ufd_fw_info *)pdev->cmd_buffer_addr;
+		err = pcan_usb_pro_send_req(dev, PCAN_USBPRO_REQ_INFO,
+					    PCAN_USBPRO_INFO_FW,
+					    fi, sizeof(*fi));
+		if (err) {
+			dev_err(dev->netdev->dev.parent,
+				"unable to read %s firmware info (err %d)\n",
+				dev->adapter->name, err);
+			goto err_out_2;
+		}
+
+		dev_info(dev->netdev->dev.parent,
+			 "PEAK-System %s v%u fw v%u.%u.%u (%u channels)\n",
+			 dev->adapter->name, fi->hw_version,
+			 fi->fw_version[0], fi->fw_version[1],
+			 fi->fw_version[2], dev->adapter->ctrl_count);
+
+		/* tell the device the can driver is running */
+		err = pcan_usb_fd_drv_loaded(dev, 1);
+		if (err) {
+			dev_err(dev->netdev->dev.parent,
+				"unable to tell %s driver is loaded (err %d)\n",
+				dev->adapter->name, err);
+			goto err_out_2;
+		}
+
+	} else {
+		/* otherwise, simply copy previous sibling's values */
+		struct pcan_usb_fd_device *ppdev =
+			container_of(dev->prev_siblings,
+				     struct pcan_usb_fd_device, dev);
+
+		pdev->usb_if = ppdev->usb_if;
+		pdev->cmd_buffer_addr = ppdev->cmd_buffer_addr;
+	}
+
+	pdev->usb_if->dev[dev->ctrl_idx] = dev;
+
+	/* set clock domain */
+	for (i = 0; i < ARRAY_SIZE(pcan_usb_fd_clk_freq); i++)
+		if (dev->adapter->clock.freq == pcan_usb_fd_clk_freq[i])
+			break;
+
+	if (i >= ARRAY_SIZE(pcan_usb_fd_clk_freq)) {
+		dev_warn(dev->netdev->dev.parent,
+			 "incompatible clock frequencies\n");
+		err = -EINVAL;
+		goto err_out_2;
+	}
+
+	pcan_usb_fd_set_clock_domain(dev, i);
+
+	/* set LED in default state (end of init phase) */
+	pcan_usb_fd_set_can_led(dev, PCAN_UFD_LED_DEF);
+
+	return 0;
+
+err_out_2:
+	kfree(pdev->cmd_buffer_addr);
+err_out_1:
+	kfree(pdev->usb_if);
+err_out:
+	return err;
+}
+
+/* called when driver module is being unloaded */
+static void pcan_usb_fd_exit(struct peak_usb_device *dev)
+{
+	struct pcan_usb_fd_device *pdev =
+			container_of(dev, struct pcan_usb_fd_device, dev);
+
+	/*
+	 * when rmmod called before unplug and if down, should reset things
+	 * before leaving
+	 */
+	if (dev->can.state != CAN_STATE_STOPPED) {
+		/* set bus off on the corresponding channel */
+		pcan_usb_fd_set_bus(dev, 0);
+	}
+
+	/* switch off corresponding CAN LEDs */
+	pcan_usb_fd_set_can_led(dev, PCAN_UFD_LED_OFF);
+
+	/* if channel #0 (only) */
+	if (dev->ctrl_idx == 0) {
+		/* turn off calibration message if any device were opened */
+		if (pdev->usb_if->dev_opened_count > 0)
+			pcan_usb_fd_set_filter_ext(dev, 0,
+						   PUCAN_FLTEXT_ERROR,
+						   PCAN_UFD_FLTEXT_CALIBRATION);
+
+		/* tell USB adapter that the driver is being unloaded */
+		pcan_usb_fd_drv_loaded(dev, 0);
+	}
+}
+
+/* called when the USB adapter is unplugged */
+static void pcan_usb_fd_free(struct peak_usb_device *dev)
+{
+	/* last device: can free shared objects now */
+	if (!dev->prev_siblings && !dev->next_siblings) {
+		struct pcan_usb_fd_device *pdev =
+			container_of(dev, struct pcan_usb_fd_device, dev);
+
+		/* free commands buffer */
+		kfree(pdev->cmd_buffer_addr);
+
+		/* free usb interface object */
+		kfree(pdev->usb_if);
+	}
+}
+
+/* describes the PCAN-USB FD adapter */
+struct peak_usb_adapter pcan_usb_fd = {
+	.name = "PCAN-USB FD",
+	.device_id = PCAN_USBFD_PRODUCT_ID,
+	.ctrl_count = PCAN_USBFD_CHANNEL_COUNT,
+	.ctrlmode_supported = CAN_CTRLMODE_FD |
+			CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY,
+	.clock = {
+		.freq = PCAN_UFD_CRYSTAL_HZ,
+	},
+	.bittiming_const = {
+		.name = "pcan_usb_fd",
+		.tseg1_min = 1,
+		.tseg1_max = 64,
+		.tseg2_min = 1,
+		.tseg2_max = 16,
+		.sjw_max = 16,
+		.brp_min = 1,
+		.brp_max = 1024,
+		.brp_inc = 1,
+	},
+	.data_bittiming_const = {
+		.name = "pcan_usb_fd",
+		.tseg1_min = 1,
+		.tseg1_max = 16,
+		.tseg2_min = 1,
+		.tseg2_max = 8,
+		.sjw_max = 4,
+		.brp_min = 1,
+		.brp_max = 1024,
+		.brp_inc = 1,
+	},
+
+	/* size of device private data */
+	.sizeof_dev_private = sizeof(struct pcan_usb_fd_device),
+
+	/* timestamps usage */
+	.ts_used_bits = 32,
+	.ts_period = 1000000, /* calibration period in ts. */
+	.us_per_ts_scale = 1, /* us = (ts * scale) >> shift */
+	.us_per_ts_shift = 0,
+
+	/* give here messages in/out endpoints */
+	.ep_msg_in = PCAN_USBPRO_EP_MSGIN,
+	.ep_msg_out = {PCAN_USBPRO_EP_MSGOUT_0},
+
+	/* size of rx/tx usb buffers */
+	.rx_buffer_size = PCAN_UFD_RX_BUFFER_SIZE,
+	.tx_buffer_size = PCAN_UFD_TX_BUFFER_SIZE,
+
+	/* device callbacks */
+	.intf_probe = pcan_usb_pro_probe,	/* same as PCAN-USB Pro */
+	.dev_init = pcan_usb_fd_init,
+
+	.dev_exit = pcan_usb_fd_exit,
+	.dev_free = pcan_usb_fd_free,
+	.dev_set_bus = pcan_usb_fd_set_bus,
+	.dev_set_bittiming = pcan_usb_fd_set_bittiming_slow,
+	.dev_set_data_bittiming = pcan_usb_fd_set_bittiming_fast,
+	.dev_decode_buf = pcan_usb_fd_decode_buf,
+	.dev_start = pcan_usb_fd_start,
+	.dev_stop = pcan_usb_fd_stop,
+	.dev_restart_async = pcan_usb_fd_restart_async,
+	.dev_encode_msg = pcan_usb_fd_encode_msg,
+};
+
+/* describes the PCAN-USB Pro FD adapter */
+struct peak_usb_adapter pcan_usb_pro_fd = {
+	.name = "PCAN-USB Pro FD",
+	.device_id = PCAN_USBPROFD_PRODUCT_ID,
+	.ctrl_count = PCAN_USBPROFD_CHANNEL_COUNT,
+	.ctrlmode_supported = CAN_CTRLMODE_FD |
+			CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY,
+	.clock = {
+		.freq = PCAN_UFD_CRYSTAL_HZ,
+	},
+	.bittiming_const = {
+		.name = "pcan_usb_pro_fd",
+		.tseg1_min = 1,
+		.tseg1_max = 64,
+		.tseg2_min = 1,
+		.tseg2_max = 16,
+		.sjw_max = 16,
+		.brp_min = 1,
+		.brp_max = 1024,
+		.brp_inc = 1,
+	},
+	.data_bittiming_const = {
+		.name = "pcan_usb_pro_fd",
+		.tseg1_min = 1,
+		.tseg1_max = 16,
+		.tseg2_min = 1,
+		.tseg2_max = 8,
+		.sjw_max = 4,
+		.brp_min = 1,
+		.brp_max = 1024,
+		.brp_inc = 1,
+	},
+
+	/* size of device private data */
+	.sizeof_dev_private = sizeof(struct pcan_usb_fd_device),
+
+	/* timestamps usage */
+	.ts_used_bits = 32,
+	.ts_period = 1000000, /* calibration period in ts. */
+	.us_per_ts_scale = 1, /* us = (ts * scale) >> shift */
+	.us_per_ts_shift = 0,
+
+	/* give here messages in/out endpoints */
+	.ep_msg_in = PCAN_USBPRO_EP_MSGIN,
+	.ep_msg_out = {PCAN_USBPRO_EP_MSGOUT_0, PCAN_USBPRO_EP_MSGOUT_1},
+
+	/* size of rx/tx usb buffers */
+	.rx_buffer_size = PCAN_UFD_RX_BUFFER_SIZE,
+	.tx_buffer_size = PCAN_UFD_TX_BUFFER_SIZE,
+
+	/* device callbacks */
+	.intf_probe = pcan_usb_pro_probe,	/* same as PCAN-USB Pro */
+	.dev_init = pcan_usb_fd_init,
+
+	.dev_exit = pcan_usb_fd_exit,
+	.dev_free = pcan_usb_fd_free,
+	.dev_set_bus = pcan_usb_fd_set_bus,
+	.dev_set_bittiming = pcan_usb_fd_set_bittiming_slow,
+	.dev_set_data_bittiming = pcan_usb_fd_set_bittiming_fast,
+	.dev_decode_buf = pcan_usb_fd_decode_buf,
+	.dev_start = pcan_usb_fd_start,
+	.dev_stop = pcan_usb_fd_stop,
+	.dev_restart_async = pcan_usb_fd_restart_async,
+	.dev_encode_msg = pcan_usb_fd_encode_msg,
+};
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.h b/drivers/net/can/usb/peak_usb/pcan_usb_fd.h
new file mode 100644
index 0000000..2f66ef9
--- /dev/null
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.h
@@ -0,0 +1,108 @@
+/*
+ * CAN driver for PEAK System PCAN-USB FD / PCAN-USB Pro FD adapter
+ *
+ * Copyright (C) 2003-2011 PEAK System-Technik GmbH
+ * Copyright (C) 2011-2013 Stephane Grosjean <s.grosjean@peak-system.com>
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
+#ifndef PCAN_UFD_H
+#define PCAN_UFD_H
+
+#include "pcan_usb_pro.h"
+#include "pcan_ucan.h"
+
+/* Extended commands (non uCAN commands) */
+
+/* Clock Modes command */
+#define PCAN_UFD_CMD_CLK_SET	0x80
+
+#define PCAN_UFD_CLK_80MHZ	0x0
+#define PCAN_UFD_CLK_60MHZ	0x1
+#define PCAN_UFD_CLK_40MHZ	0x2
+#define PCAN_UFD_CLK_30MHZ	0x3
+#define PCAN_UFD_CLK_24MHZ	0x4
+#define PCAN_UFD_CLK_20MHZ	0x5
+#define PCAN_UFD_CLK_DEF	PCAN_UFD_CLK_80MHZ
+
+struct __packed pcan_ufd_clock {
+	u16	opcode_channel;
+
+	u8	mode;
+	u8	unused[5];
+};
+
+/* LED control command */
+#define PCAN_UFD_CMD_LED_SET	0x86
+
+#define PCAN_UFD_LED_DEV	0x00
+#define PCAN_UFD_LED_FAST	0x01
+#define PCAN_UFD_LED_SLOW	0x02
+#define PCAN_UFD_LED_ON		0x03
+#define PCAN_UFD_LED_OFF	0x04
+#define PCAN_UFD_LED_DEF	PCAN_UFD_LED_DEV
+
+struct __packed pcan_ufd_led {
+	u16	opcode_channel;
+
+	u8	mode;
+	u8	unused[5];
+};
+
+/* Extended usage of uCAN commands CMD_RX_FRAME_xxxABLE for PCAN-USB Pro FD */
+#define PCAN_UFD_FLTEXT_CALIBRATION	0x8000
+
+struct __packed pcan_ufd_filter_ext {
+	u16	opcode_channel;
+
+	u16	ext_mask;
+	u16	unused;
+	u16	usb_mask;
+};
+
+/* Extended usage of uCAN messages for PCAN-USB Pro FD */
+#define PCAN_UFD_MSG_CALIBRATION	0x100
+
+struct __packed pcan_ufd_ts_msg {
+	__le16	size;
+	__le16	type;
+	__le32	ts_low;
+	__le32	ts_high;
+	__le16	usb_frame_index;
+	u16	unused;
+};
+
+#define PCAN_UFD_MSG_OVERRUN		0x101
+
+#define PCAN_UFD_OVMSG_CHANNEL(o)	((o)->channel & 0xf)
+
+struct __packed pcan_ufd_ovr_msg {
+	__le16	size;
+	__le16	type;
+	__le32	ts_low;
+	__le32	ts_high;
+	u8	channel;
+	u8	unused[3];
+};
+
+/* read some versions info from the hw devcie */
+struct __packed pcan_ufd_fw_info {
+	u16	size_of;	/* sizeof this */
+	u16	type;		/* type of thsi structure */
+	u8	hw_type;	/* Type of hardware (HW_TYPE_xxx) */
+	u8	bl_version[3];	/* Bootloader version */
+	u8	hw_version;	/* Hardware version (PCB) */
+	u8	fw_version[3];	/* Firmware version */
+	u32	dev_id[2];	/* "device id" per CAN */
+	u32	ser_no;		/* S/N */
+	u32	flags;		/* special functions */
+};
+
+#endif
-- 
1.9.1

