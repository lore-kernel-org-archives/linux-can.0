From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Subject: [PATCH] can: ucan: add driver for Theobroma Systems UCAN devices
Date: Fri,  2 Feb 2018 11:59:49 +0100
Message-ID: <20180202105949.35468-1-jakob.unterwurzacher@theobroma-systems.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vegas.theobroma-systems.com ([144.76.126.164]:36795 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750795AbeBBLaI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 2 Feb 2018 06:30:08 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>, Martin Elshuber <martin.elshuber@theobroma-systems.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>

UCAN is an microcontroller-based USB-CAN interface that is
integrated on System-on-Modules from Theobroma Systems
like the A31-uQ7 and the RK3399-Q7
( https://www.theobroma-systems.com/rk3399-q7/overview ).

The USB wire protocol has been designed to be as generic
and hardware-indendent as possible in the hope of being useful
for implementations on other microcontrollers.

Signed-off-by: Martin Elshuber <martin.elshuber@theobroma-systems.com>
Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>

Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
---
 Documentation/networking/can_ucan_protocol.txt | 131 ++++
 drivers/net/can/usb/Kconfig                    |  10 +
 drivers/net/can/usb/Makefile                   |   1 +
 drivers/net/can/usb/ucan.c                     | 953 +++++++++++++++++++++++++
 drivers/net/can/usb/ucan.h                     | 235 ++++++
 5 files changed, 1330 insertions(+)
 create mode 100644 Documentation/networking/can_ucan_protocol.txt
 create mode 100644 drivers/net/can/usb/ucan.c
 create mode 100644 drivers/net/can/usb/ucan.h

diff --git a/Documentation/networking/can_ucan_protocol.txt b/Documentation/networking/can_ucan_protocol.txt
new file mode 100644
index 000000000000..bf0c2180322a
--- /dev/null
+++ b/Documentation/networking/can_ucan_protocol.txt
@@ -0,0 +1,131 @@
+The UCAN Protocol
+-----------------
+
+UCAN is an microcontroller-based USB-CAN interface that is
+integrated on System-on-Modules from Theobroma Systems and that
+is also available as a standalone USB stick.
+
+The UCAN protocol has been designed to be hardware-independent.
+It is modeled closely after how Linux represents CAN devices
+internally. All multi-byte integers are encoded as Little Endian.
+
+All structures mentioned in this document are defined in
+drivers/net/can/usb/ucan.h .
+
+
+USB Endpoints
+-------------
+
+An UCAN device uses three USB endpoints:
+
+Interrupt endpoint: Once the device is started the device sends
+its TX FIFO status (space left) on this endpoint. The driver uses
+this information for flow control.
+
+IN enpoint: The device sends CAN frames and device
+information on the IN endpoint.
+
+OUT endpoint: The driver sends CAN frames and configuration requests
+on the out endpoint.
+
+
+CAN Error Handling
+------------------
+
+If error reporting is turned on the device encodes error into CAN
+error frames (see uapi/linux/can/error.h) and sends it using the
+IN endpoint. The driver updates its error statistics and forwards
+it.
+
+
+INTR Message Format
+-------------------
+
+A single u32 showing the current free space in the tx fifo.
+
+
+IN Message Format
+-----------------
+
+A data packet on the USB IN endpoint contains one or more
+
+	struct ucan_message_in
+
+values. If multiple messages are batched in a USB data packet,
+the "len" field can be used to jump to the next ucan_message_in
+value (take care to sanity-check the "len" value against the
+actual data size).
+
+Each ucan_message_in must be aligned to a 4-byte boundary (relative
+to the start of the start of the data buffer). That means that there
+may be padding bytes between multiple "ucan_message_in" values:
+
+
+    +----------------------------+ < 0
+    |                            |
+    |   struct ucan_message_in   |
+    |                            |
+    +----------------------------+ < len
+              [padding]
+    +----------------------------+ < round_up(len, 4)
+    |                            |
+    |   struct ucan_message_in   |
+    |                            |
+    +----------------------------+
+                [...]
+
+The "type" field specifies the type of the message. Two types are
+defined:
+
+* UCAN_IN_DEVICE_INFO: Reports device capabilities. See the "device_info"
+  field for details, and uapi/linux/can/netlink.h for an explaination of
+  the can_bittiming fields.
+* UCAN_IN_RX: Data received from the CAN bus (ID + payload).
+
+
+OUT Message Format
+------------------
+
+A data packet on the USB OUT endpoint contains one or more
+
+	struct ucan_message_out
+
+values. If multiple messages are batched into one data packet,
+the device uses the "len" field to jump to the next
+ucan_message_out value. Each ucan_message_out must be aliged
+to 4 bytes (relative to the start of the data buffer):
+
+    +----------------------------+ < 0
+    |                            |
+    |   struct ucan_message_out  |
+    |                            |
+    +----------------------------+ < len
+              [padding]
+    +----------------------------+ < round_up(len, 4)
+    |                            |
+    |   struct ucan_message_out  |
+    |                            |
+    +----------------------------+
+                [...]
+
+The "type" field specifies the type of the message. Four types
+are defined:
+
+* UCAN_OUT_COMMAND: Send a simple command to the device (parameters: cmd,
+  subcmd, val). See the comments in drivers/net/can/usb/ucan.h for details.
+* UCAN_OUT_SET_BITTIMING: Set the CAN bit timing parameters. (parameters: see
+  struct bittiming)
+* UCAN_OUT_TX: Transmit a CAN frame. (parameters: id, data)
+* UCAN_OUT_ENABLE_FILTER: Enable the hardware ID filter. (parameters: see
+  enable_filter struct)
+
+
+Example Conversation
+--------------------
+
+1) Device is connected to USB
+2) Host sends command: cmd=UCAN_COMMAND_RESET, subcmd=0, val=0
+3) Host sends command: cmd=UCAN_COMMAND_GET, subcmd=UCAN_COMMAND_GET_INFO, val=0
+4) Device sends UCAN_IN_DEVICE_INFO
+5) Host sends UCAN_OUT_SET_BITTIMING
+6) Host sends command: cmd=UCAN_COMMAND_START, subcmd=0, val=0
diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index c36f4bdcbf4f..490cdce1f1da 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -89,4 +89,14 @@ config CAN_MCBA_USB
 	  This driver supports the CAN BUS Analyzer interface
 	  from Microchip (http://www.microchip.com/development-tools/).
 
+config CAN_UCAN
+	tristate "Theobroma Systems UCAN interface"
+	---help---
+	  This driver supports the Theobroma Systems
+	  UCAN USB-CAN interface.
+
+	  UCAN is an microcontroller-based USB-CAN interface that
+	  is integrated on System-on-Modules made by Theobroma Systems
+	  (https://www.theobroma-systems.com/som-products).
+
 endmenu
diff --git a/drivers/net/can/usb/Makefile b/drivers/net/can/usb/Makefile
index 49ac7b99ba32..4176e8358232 100644
--- a/drivers/net/can/usb/Makefile
+++ b/drivers/net/can/usb/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_CAN_KVASER_USB) += kvaser_usb.o
 obj-$(CONFIG_CAN_PEAK_USB) += peak_usb/
 obj-$(CONFIG_CAN_8DEV_USB) += usb_8dev.o
 obj-$(CONFIG_CAN_MCBA_USB) += mcba_usb.o
+obj-$(CONFIG_CAN_UCAN) += ucan.o
diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
new file mode 100644
index 000000000000..a8a3add109a5
--- /dev/null
+++ b/drivers/net/can/usb/ucan.c
@@ -0,0 +1,953 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Driver for Theobroma Systems UCAN devices
+ *
+ * Copyright (C) 2015 Theobroma Systems Design und Consulting GmbH
+ *
+ * This driver is inspired by the 4.0.0 version of drivers/net/can/usb/ems_usb.c
+ *
+ *
+ * General Description:
+ *
+ * The USB Device uses three Endpoints:
+ *
+ *   Interrupt Endpoint: Once the device is started the device sends
+ *   its TX FIFO status (space left) on this endpoint. The driver uses
+ *   this information for flow control.
+ *
+ *   IN Enpoint: The device sends CAN Frame Messages and Device
+ *   Information using the IN endpoint.
+ *
+ *   OUT Endpoint: The driver sends configuration requests, and CAN
+ *   Frames on the out endpoint.
+ *
+ *   Error Handling: If error reporting is turned on the device
+ *   encodes error into CAN error frames (see uapi/linux/can/error.h)
+ *   and sends it using the IN Endpoint. The driver updates statistics
+ *   and forward it.
+ */
+
+#include <linux/can.h>
+#include <linux/can/dev.h>
+#include <linux/can/error.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/signal.h>
+#include <linux/skbuff.h>
+#include <linux/slab.h>
+#include <linux/usb.h>
+
+#include "ucan.h"
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Martin Elshuber, Theobroma Systems Design und Consulting GmbH <martin.elshuber@theobroma-systems.com>");
+MODULE_DESCRIPTION("Driver for Theobroma Systems UCAN devices");
+
+#define MAX_TX_URBS 8
+#define MAX_RX_URBS 8
+#define TX_QUEUE_STOP_THRESHOLD 1
+
+static struct usb_device_id ucan_table[] = {
+	{USB_DEVICE(0x2294, 0x425a)},
+	{} /* Terminating entry */
+};
+
+MODULE_DEVICE_TABLE(usb, ucan_table);
+
+struct ucan;
+
+/* Context Information for transmission URBs */
+struct ucan_urb_context {
+	struct ucan *up;
+	u32 echo_index;
+	int size;
+	u8 dlc;
+};
+
+/* Information reported by the USB device */
+struct ucan_device_info {
+	struct can_bittiming_const bittiming_const;
+	int tx_fifo;
+};
+
+/* Driver private data */
+struct ucan {
+	struct can_priv can; /* must be the first member */
+
+	struct usb_device *udev;
+	struct net_device *netdev;
+
+	struct usb_endpoint_descriptor *out_ep;
+	struct usb_endpoint_descriptor *in_ep;
+	struct usb_endpoint_descriptor *irq_ep;
+
+	struct usb_anchor rx_urbs;
+	struct usb_anchor tx_urbs;
+	struct urb *irq_urb;
+	u32 *irq_data;
+
+	u8 *tx_msg_buffer;
+	u8 *rx_msg_buffer;
+
+	struct ucan_device_info device_info;
+
+	atomic_t active_tx_urbs;
+	struct ucan_urb_context tx_urb_contexts[MAX_TX_URBS];
+	int free_slots;
+};
+
+/* Sends a command to the device */
+static int ucan_command(struct ucan *up, u8 cmd, u8 subcmd, u16 value)
+{
+	int len;
+	struct ucan_message_out *m =
+	    (struct ucan_message_out *)up->tx_msg_buffer;
+	dev_dbg(&up->udev->dev, "%s\n", __func__);
+
+	m->type = __cpu_to_le16(UCAN_OUT_COMMAND);
+	m->len = __cpu_to_le16(UCAN_OUT_LEN(m->msg.command));
+	m->msg.command.cmd = cmd;
+	m->msg.command.subcmd = subcmd;
+	m->msg.command.val = __cpu_to_le16(value);
+
+	return usb_bulk_msg(up->udev,
+	    usb_sndbulkpipe(up->udev, up->out_ep->bEndpointAddress &
+					  USB_ENDPOINT_NUMBER_MASK),
+	    m, __le16_to_cpu(m->len), &len, 1000);
+}
+
+/* Request the device Information */
+static int ucan_get_device_info(struct ucan *up)
+{
+	int ret;
+	int len;
+	struct can_bittiming_const *bittiming =
+		&up->device_info.bittiming_const;
+	struct ucan_message_in *m = (struct ucan_message_in *)up->rx_msg_buffer;
+
+	dev_dbg(&up->udev->dev, "%s\n", __func__);
+
+	/* send the request command */
+	ret = ucan_command(up, UCAN_COMMAND_GET, UCAN_COMMAND_GET_INFO, 0);
+	if (ret)
+		return ret;
+
+	/* retrieve the information */
+	ret = usb_bulk_msg(up->udev,
+	    usb_rcvbulkpipe(up->udev, up->in_ep->bEndpointAddress &
+					  USB_ENDPOINT_NUMBER_MASK),
+	    m, up->in_ep->wMaxPacketSize, &len, 1000);
+	if (ret)
+		return ret;
+
+	/* check sanity */
+	if (m->type != __cpu_to_le16(UCAN_IN_DEVICE_INFO))
+		return -EINVAL;
+
+	if (__le16_to_cpu(m->len) != UCAN_IN_LEN(m->msg.device_info))
+		return -EINVAL;
+
+	/* store the data */
+	up->can.clock.freq = __le32_to_cpu(m->msg.device_info.freq);
+	up->device_info.tx_fifo = m->msg.device_info.tx_fifo;
+	strcpy(bittiming->name, "ucan");
+	bittiming->tseg1_min = m->msg.device_info.tseg1_min;
+	bittiming->tseg1_max = m->msg.device_info.tseg1_max;
+	bittiming->tseg2_min = m->msg.device_info.tseg2_min;
+	bittiming->tseg2_max = m->msg.device_info.tseg2_max;
+	bittiming->sjw_max   = m->msg.device_info.sjw_max;
+	bittiming->brp_min   = __le32_to_cpu(m->msg.device_info.brp_min);
+	bittiming->brp_max   = __le32_to_cpu(m->msg.device_info.brp_max);
+	bittiming->brp_inc   = __le16_to_cpu(m->msg.device_info.brp_inc);
+
+	up->can.ctrlmode_supported = 0;
+
+	if (__le16_to_cpu(m->msg.device_info.ctrlmodes) & UCAN_MODE_LOOPBACK)
+		up->can.ctrlmode_supported |= CAN_CTRLMODE_LOOPBACK;
+	if (__le16_to_cpu(m->msg.device_info.ctrlmodes) & UCAN_MODE_SILENT)
+		up->can.ctrlmode_supported |= CAN_CTRLMODE_LISTENONLY;
+	if (__le16_to_cpu(m->msg.device_info.ctrlmodes) & UCAN_MODE_3_SAMPLES)
+		up->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
+	if (__le16_to_cpu(m->msg.device_info.ctrlmodes) & UCAN_MODE_ONE_SHOT)
+		up->can.ctrlmode_supported |= CAN_CTRLMODE_ONE_SHOT;
+	if (__le16_to_cpu(m->msg.device_info.ctrlmodes) & UCAN_MODE_BERR_REPORT)
+		up->can.ctrlmode_supported |= CAN_CTRLMODE_BERR_REPORTING;
+
+	return 0;
+}
+
+/* Callback when the device sends the IRQ sate *
+ *
+ * This function simply stores the current TX fifo state for flow
+ * control
+ */
+static void ucan_read_irq_callback(struct urb *urb)
+{
+	int ret;
+	struct ucan *up = urb->context;
+	struct net_device *netdev = up->netdev;
+
+	dev_dbg(&up->udev->dev, "%s %d\n", __func__, urb->status);
+
+	switch (urb->status) {
+	case 0:
+		WRITE_ONCE(up->free_slots, __le32_to_cpu(*up->irq_data));
+		break;
+	case -ECONNRESET:
+	case -ENOENT:
+	case -ESHUTDOWN:
+	case -ETIME:
+		dev_dbg(&up->udev->dev, "%s ENOENT|ESHUTDOWN|ETIME\n",
+			__func__);
+		return;
+	default:
+		dev_warn(&up->udev->dev, "%s error (%d)\n", __func__,
+			 urb->status);
+		break;
+	}
+
+	usb_fill_int_urb(urb, up->udev,
+			 usb_rcvintpipe(up->udev, up->irq_ep->bEndpointAddress &
+						      USB_ENDPOINT_NUMBER_MASK),
+			 urb->transfer_buffer, up->irq_ep->wMaxPacketSize,
+			 ucan_read_irq_callback, up, up->irq_ep->bInterval);
+
+	ret = usb_submit_urb(urb, GFP_KERNEL);
+
+	if (ret == -ENODEV)
+		netif_device_detach(netdev);
+	else if (ret)
+		dev_err(&up->udev->dev, "failed resubmitting urb: %d\n", ret);
+}
+
+/* Callback on reception of a can frame via the IN endpoint
+ *
+ * This function allocates an skb and transferres it to the Linux
+ * network stack
+ */
+static void ucan_rx_can_msg(struct ucan *up, struct ucan_message_in *m)
+{
+	int len;
+	struct can_frame *cf;
+	struct sk_buff *skb;
+	struct net_device_stats *stats = &up->netdev->stats;
+
+	dev_dbg(&up->udev->dev, "%s\n", __func__);
+
+	/* get the contents of the length field */
+	len = __le16_to_cpu(m->len);
+
+	/* check sanity */
+	if (len < UCAN_IN_HDR_SIZE + sizeof(m->msg.can_msg.id)) {
+		dev_warn(&up->udev->dev, "invalid input message len\n");
+		return;
+	}
+
+	/* allocate skb */
+	skb = alloc_can_skb(up->netdev, &cf);
+	if (!skb)
+		return;
+
+	/* fill the can frame */
+	cf->can_id = __le32_to_cpu(m->msg.can_msg.id);
+	cf->can_dlc = len - (UCAN_IN_HDR_SIZE + sizeof(m->msg.can_msg.id));
+
+	if (cf->can_dlc > sizeof(m->msg.can_msg.data))
+		goto err_freeskb;
+
+	if (cf->can_dlc < 0)
+		goto err_freeskb;
+
+	if (cf->can_id & CAN_EFF_FLAG)
+		cf->can_id &=
+		    (CAN_EFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG | CAN_ERR_FLAG);
+	else
+		cf->can_id &= (CAN_SFF_MASK | CAN_RTR_FLAG | CAN_ERR_FLAG);
+
+	if (cf->can_id & CAN_RTR_FLAG) {
+		cf->can_id |= CAN_RTR_FLAG;
+		cf->can_dlc = m->msg.can_rtr_msg.dlc;
+	} else {
+		memcpy(cf->data, m->msg.can_msg.data, cf->can_dlc);
+	}
+
+	/* handle can error frames */
+	if (cf->can_id & CAN_ERR_FLAG) {
+		if (cf->can_id & CAN_ERR_BUSOFF) {
+			up->can.can_stats.bus_off++;
+			can_bus_off(up->netdev);
+		}
+
+		if (cf->data[1] &
+		    (CAN_ERR_CRTL_RX_WARNING | CAN_ERR_CRTL_TX_WARNING)) {
+			up->can.can_stats.error_warning++;
+		}
+
+		if (cf->data[1] &
+		    (CAN_ERR_CRTL_RX_WARNING | CAN_ERR_CRTL_TX_WARNING)) {
+			up->can.can_stats.error_passive++;
+		}
+
+		if (cf->data[1] & CAN_ERR_CRTL_RX_OVERFLOW)
+			stats->rx_over_errors++;
+
+		if (cf->can_id & CAN_ERR_LOSTARB)
+			up->can.can_stats.arbitration_lost++;
+
+		if (cf->can_id & CAN_ERR_BUSERROR)
+			up->can.can_stats.bus_error++;
+
+		if (cf->data[2] & CAN_ERR_PROT_TX)
+			stats->tx_errors++;
+		else
+			stats->rx_errors++;
+
+		cf->can_id |= CAN_ERR_FLAG;
+	}
+
+	/* pass it to Linux */
+	netif_receive_skb(skb);
+
+	stats->rx_packets++;
+	stats->rx_bytes += cf->can_dlc;
+
+	return;
+err_freeskb:
+	kfree_skb(skb);
+}
+
+/* callback on reception of a USB message */
+static void ucan_read_bulk_callback(struct urb *urb)
+{
+	int ret;
+	int len;
+	int pos;
+	struct ucan *up = urb->context;
+	struct net_device *netdev = up->netdev;
+	struct ucan_message_in m;
+
+	dev_dbg(&up->udev->dev, "%s %p\n", __func__, up);
+
+	/* check URB status */
+	switch (urb->status) {
+	case 0:
+		break;
+	case -ENOENT:
+	case -EPIPE:
+	case -EPROTO:
+	case -ESHUTDOWN:
+	case -ETIME:
+		dev_dbg(&up->udev->dev, "%s ENOENT|ESHUTDOWN|ETIME\n",
+			__func__);
+		return;
+	default:
+		goto resubmit;
+	}
+
+	/* iterate over input */
+	pos = 0;
+	while (pos < urb->actual_length) {
+		/* check sanity (length of header) */
+		if ((urb->actual_length - pos) < UCAN_IN_HDR_SIZE) {
+			dev_warn(&up->udev->dev, "invalid input message %d; too short (no header)\n",
+				 urb->actual_length);
+			goto resubmit;
+		}
+
+		/* copy the message header */
+		memcpy(&m, urb->transfer_buffer, UCAN_IN_HDR_SIZE);
+		len = __le16_to_cpu(m.len);
+
+		/* check sanity (length of content) */
+		if (urb->actual_length - pos < len) {
+			dev_warn(&up->udev->dev, "invalid input message %d; too short (no doata)\n",
+				 urb->actual_length);
+			goto resubmit;
+		}
+
+		// copy remainder of packet
+		memcpy(&m.msg, urb->transfer_buffer + UCAN_IN_HDR_SIZE,
+			len - UCAN_IN_HDR_SIZE);
+
+		switch (__le16_to_cpu(m.type)) {
+		case UCAN_IN_RX:
+			ucan_rx_can_msg(up, &m);
+			break;
+		default:
+			dev_warn(&up->udev->dev,
+				 "invalid input message type\n");
+			break;
+		}
+
+		/* proceed to next message */
+		pos += len;
+		/* align to 4 byte boundary */
+		pos = round_up(pos, 4);
+	}
+
+resubmit:
+	/* resubmit urb when done */
+	usb_fill_bulk_urb(urb, up->udev,
+	    usb_rcvbulkpipe(up->udev, up->in_ep->bEndpointAddress &
+					  USB_ENDPOINT_NUMBER_MASK),
+	    urb->transfer_buffer, up->in_ep->wMaxPacketSize,
+	    ucan_read_bulk_callback, up);
+
+	ret = usb_submit_urb(urb, GFP_KERNEL);
+
+	if (ret == -ENODEV)
+		netif_device_detach(netdev);
+	else if (ret)
+		dev_err(&up->udev->dev,
+			"failed resubmitting read bulk urb: %d\n", ret);
+}
+
+/* callback after transmission of a USB message */
+static void ucan_write_bulk_callback(struct urb *urb)
+{
+	struct ucan_urb_context *context = urb->context;
+	struct ucan *up;
+
+	/* get the urb context */
+	if (WARN_ON(!context))
+		return;
+
+	up = context->up;
+
+	/* free up our allocated buffer */
+	usb_free_coherent(urb->dev, context->size, urb->transfer_buffer,
+			  urb->transfer_dma);
+
+	atomic_dec(&up->active_tx_urbs);
+
+	/* sanity check */
+	if (!netif_device_present(up->netdev))
+		return;
+
+	/* urb state check */
+	if (urb->status)
+		netdev_info(up->netdev, "Tx URB aborted (%d)\n", urb->status);
+
+	netif_trans_update(up->netdev);
+
+	/* update statistics */
+	up->netdev->stats.tx_packets++;
+	up->netdev->stats.tx_bytes += context->dlc;
+
+	/* echo can frame */
+	can_get_echo_skb(up->netdev, context->echo_index);
+
+	/* Release context */
+	context->echo_index = -1;
+
+	/* restart the queue if necessary */
+	if (netif_queue_stopped(up->netdev))
+		netif_wake_queue(up->netdev);
+}
+
+/* Open the network device */
+static int ucan_open(struct net_device *netdev)
+{
+	int i;
+	int ret;
+	void *buf;
+	u16 ctrlmode;
+	struct urb *urb;
+	struct ucan *up = netdev_priv(netdev);
+
+	dev_dbg(&up->udev->dev, "%s\n", __func__);
+
+	/* call CAN layer open */
+	ret = open_candev(netdev);
+	if (ret)
+		goto err;
+
+	ret = -ENOMEM;
+
+	/* set the queue state as empty */
+	up->free_slots = up->device_info.tx_fifo;
+
+	/* initialize IRQ endpoint */
+	up->irq_urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!up->irq_urb)
+		goto err;
+
+	up->irq_data = kzalloc(up->irq_ep->wMaxPacketSize, GFP_KERNEL);
+	if (!up->irq_data) {
+		usb_free_urb(up->irq_urb);
+		goto err;
+	}
+
+	usb_fill_int_urb(up->irq_urb, up->udev,
+			 usb_rcvintpipe(up->udev, up->irq_ep->bEndpointAddress &
+						      USB_ENDPOINT_NUMBER_MASK),
+			 up->irq_data, up->irq_ep->wMaxPacketSize,
+			 ucan_read_irq_callback, up, up->irq_ep->bInterval);
+
+	ret = usb_submit_urb(up->irq_urb, GFP_KERNEL);
+	if (ret) {
+		kfree(up->irq_data);
+		usb_free_urb(up->irq_urb);
+		goto err;
+	}
+
+	/* initialize IN enpoint */
+	for (i = 0; i < MAX_RX_URBS; i++) {
+		ret = -ENOMEM;
+
+		urb = usb_alloc_urb(0, GFP_KERNEL);
+		if (!urb)
+			goto err;
+
+		buf = usb_alloc_coherent(up->udev, up->in_ep->wMaxPacketSize,
+					 GFP_KERNEL, &urb->transfer_dma);
+		if (!buf) {
+			usb_free_urb(urb);
+			goto err;
+		}
+
+		usb_fill_bulk_urb(urb, up->udev,
+		    usb_rcvbulkpipe(up->udev, up->in_ep->bEndpointAddress &
+						  USB_ENDPOINT_NUMBER_MASK),
+		    buf, up->in_ep->wMaxPacketSize, ucan_read_bulk_callback,
+		    up);
+		urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+		usb_anchor_urb(urb, &up->rx_urbs);
+
+		ret = usb_submit_urb(urb, GFP_KERNEL);
+
+		if (ret) {
+			usb_unanchor_urb(urb);
+			usb_free_coherent(up->udev, up->in_ep->wMaxPacketSize,
+					  buf, urb->transfer_dma);
+			usb_free_urb(urb);
+			goto err;
+		}
+
+		/* Drop reference, USB core will take care of freeing it */
+		usb_free_urb(urb);
+	}
+
+	/* check the control mode */
+	ctrlmode = 0;
+	if (up->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
+		ctrlmode |= UCAN_MODE_LOOPBACK;
+	if (up->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
+		ctrlmode |= UCAN_MODE_SILENT;
+	if (up->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
+		ctrlmode |= UCAN_MODE_3_SAMPLES;
+	if (up->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
+		ctrlmode |= UCAN_MODE_ONE_SHOT;
+	if (up->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
+		ctrlmode |= UCAN_MODE_BERR_REPORT;
+
+	/* start the USB device */
+	ret = ucan_command(up, UCAN_COMMAND_START, 0, __cpu_to_le16(ctrlmode));
+	if (ret)
+		goto err;
+
+	/* start the network queue */
+	netif_start_queue(netdev);
+
+	return 0;
+
+err:
+	usb_kill_anchored_urbs(&up->rx_urbs);
+	return ret;
+}
+
+/* callback when Linux needs to send a can frame */
+static netdev_tx_t ucan_start_xmit(struct sk_buff *skb,
+				   struct net_device *netdev)
+{
+	int i, ret;
+	struct urb *urb;
+	struct ucan_urb_context *context;
+	struct ucan *up = netdev_priv(netdev);
+	struct can_frame *cf = (struct can_frame *)skb->data;
+	struct ucan_message_out *m =
+	    (struct ucan_message_out *)up->tx_msg_buffer;
+	size_t size = UCAN_OUT_HDR_SIZE + cf->can_dlc;
+
+	dev_dbg(&up->udev->dev, "%s\n", __func__);
+
+	/* check skb */
+	if (can_dropped_invalid_skb(netdev, skb))
+		return NETDEV_TX_OK;
+
+	/* create a URB, and a buffer for it, and copy the data to the URB */
+	urb = usb_alloc_urb(0, GFP_ATOMIC);
+	if (!urb) {
+		netdev_err(netdev, "No memory left for URBs\n");
+		goto drop;
+	}
+
+	m = usb_alloc_coherent(up->udev, size, GFP_ATOMIC, &urb->transfer_dma);
+	if (!m) {
+		netdev_err(netdev, "No memory left for USB buffer\n");
+		usb_free_urb(urb);
+		goto drop;
+	}
+
+	/* build the USB message */
+	if (cf->can_dlc > sizeof(m->msg.can_msg.data))
+		cf->can_dlc = sizeof(m->msg.can_msg.data);
+
+	m->type = __cpu_to_le16(UCAN_OUT_TX);
+	m->msg.can_msg.id = __cpu_to_le32(cf->can_id);
+
+	if (cf->can_id & CAN_RTR_FLAG) {
+		m->len = __cpu_to_le16(UCAN_OUT_LEN(m->msg.can_rtr_msg));
+		m->msg.can_rtr_msg.dlc = cf->can_dlc;
+	} else {
+		m->len = __cpu_to_le16(UCAN_OUT_HDR_SIZE +
+				       sizeof(m->msg.can_msg.id) + cf->can_dlc);
+		memcpy(m->msg.can_msg.data, cf->data, cf->can_dlc);
+	}
+
+	/* allocate a context */
+	context = NULL;
+	for (i = 0; i < MAX_TX_URBS; i++) {
+		if (up->tx_urb_contexts[i].echo_index == -1) {
+			context = &up->tx_urb_contexts[i];
+			context->up = up;
+			context->echo_index = i;
+			context->size = size;
+			context->dlc = cf->can_dlc;
+			atomic_inc(&up->active_tx_urbs);
+			break;
+		}
+	}
+
+	WARN_ON_ONCE(!context);
+	if (!context) {
+		usb_free_coherent(up->udev, size, m, urb->transfer_dma);
+		usb_free_urb(urb);
+		goto drop;
+	}
+
+	/* build the urb */
+	usb_fill_bulk_urb(urb, up->udev,
+	    usb_sndbulkpipe(up->udev, up->out_ep->bEndpointAddress &
+					  USB_ENDPOINT_NUMBER_MASK),
+	    m, __le16_to_cpu(m->len), ucan_write_bulk_callback, context);
+	urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+	usb_anchor_urb(urb, &up->tx_urbs);
+	can_put_echo_skb(skb, up->netdev, context->echo_index);
+
+	/* transmit it */
+	ret = usb_submit_urb(urb, GFP_ATOMIC);
+	if (ret) {
+		/* on error, clean up */
+		can_free_echo_skb(up->netdev, context->echo_index);
+
+		usb_unanchor_urb(urb);
+		usb_free_coherent(up->udev, size, m, urb->transfer_dma);
+		dev_kfree_skb(skb);
+
+		context->echo_index = -1;
+		atomic_dec(&up->active_tx_urbs);
+
+		if (ret == -ENODEV) {
+			netif_device_detach(up->netdev);
+		} else {
+			netdev_warn(up->netdev, "failed tx_urb %d\n", ret);
+			up->netdev->stats.tx_dropped++;
+		}
+	} else {
+		netif_trans_update(netdev);
+
+		/* Slow down tx path, if fifo state is low */
+		if ((atomic_read(&up->active_tx_urbs) >= MAX_TX_URBS) ||
+		    (READ_ONCE(up->free_slots) < TX_QUEUE_STOP_THRESHOLD)) {
+			netif_stop_queue(netdev);
+		}
+	}
+
+	/* release ref, as we do not need the urb anymore */
+	usb_free_urb(urb);
+
+	return 0;
+drop:
+	dev_kfree_skb(skb);
+	up->netdev->stats.tx_dropped++;
+
+	return NETDEV_TX_OK;
+}
+
+/* Device goes down
+ *
+ * Clean up used resources
+ */
+static int ucan_close(struct net_device *netdev)
+{
+	int ret;
+	struct ucan *up = netdev_priv(netdev);
+
+	dev_dbg(&up->udev->dev, "%s\n", __func__);
+
+	netif_stop_queue(netdev);
+
+	ret = ucan_command(up, UCAN_COMMAND_STOP, 0, 0);
+	if (ret)
+		dev_warn(&up->udev->dev,
+			 "Could not stop UCAN device, code: %d\n", ret);
+
+	usb_kill_urb(up->irq_urb);
+	usb_kill_anchored_urbs(&up->rx_urbs);
+	usb_kill_anchored_urbs(&up->tx_urbs);
+	atomic_set(&up->active_tx_urbs, 0);
+
+	kfree(up->irq_data);
+
+	close_candev(up->netdev);
+	return 0;
+}
+
+/* CAN driver callbacks */
+static const struct net_device_ops ucan_netdev_ops = {
+	.ndo_open = ucan_open,
+	.ndo_stop = ucan_close,
+	.ndo_start_xmit = ucan_start_xmit,
+	.ndo_change_mtu = can_change_mtu,
+};
+
+/* Request to set bittiming
+ *
+ * This function generates an USB set bittiming message and transmits
+ * it to the device
+ */
+static int ucan_set_bittiming(struct net_device *netdev)
+{
+	int len;
+	struct ucan *up = netdev_priv(netdev);
+	struct ucan_message_out *m =
+	    (struct ucan_message_out *)up->tx_msg_buffer;
+
+	dev_dbg(&up->udev->dev, "%s\n", __func__);
+
+	m->type = __cpu_to_le16(UCAN_OUT_SET_BITTIMING);
+	m->len = __cpu_to_le16(UCAN_OUT_LEN(m->msg.bittiming));
+	m->msg.bittiming.tq = __cpu_to_le32(up->can.bittiming.tq);
+	m->msg.bittiming.brp = __cpu_to_le16(up->can.bittiming.brp);
+	m->msg.bittiming.sample_point =
+	    __cpu_to_le32(up->can.bittiming.sample_point);
+	m->msg.bittiming.prop_seg = up->can.bittiming.prop_seg;
+	m->msg.bittiming.phase_seg1 = up->can.bittiming.phase_seg1;
+	m->msg.bittiming.phase_seg2 = up->can.bittiming.phase_seg2;
+	m->msg.bittiming.sjw = up->can.bittiming.sjw;
+
+	dev_dbg(&up->udev->dev,
+		"Setup bittiming\n"
+		"  bitrate: %d\n"
+		"  sample-point: %d\n"
+		"  tq: %d\n"
+		"  prop_seg: %d\n"
+		"  phase_seg1 %d\n"
+		"  phase_seg2 %d\n"
+		"  sjw %d\n"
+		"  brp %d\n",
+		up->can.bittiming.bitrate, up->can.bittiming.sample_point,
+		up->can.bittiming.tq, up->can.bittiming.prop_seg,
+		up->can.bittiming.phase_seg1, up->can.bittiming.phase_seg2,
+		up->can.bittiming.sjw, up->can.bittiming.brp);
+
+	return usb_bulk_msg(up->udev,
+	    usb_sndbulkpipe(up->udev, up->out_ep->bEndpointAddress &
+					  USB_ENDPOINT_NUMBER_MASK),
+	    m, __le16_to_cpu(m->len), &len, 1000);
+}
+
+/* Probe the device, reset it and gather general device information */
+static int ucan_probe(struct usb_interface *intf,
+		      const struct usb_device_id *id)
+{
+	int ret;
+	int i;
+	struct usb_device *udev;
+	struct net_device *netdev;
+	struct usb_host_interface *iface_desc;
+	struct ucan *up;
+	struct usb_endpoint_descriptor *ep;
+
+	udev = interface_to_usbdev(intf);
+
+	dev_dbg(&udev->dev, "%s\n", __func__);
+
+	/* check if the interface is sane */
+	ret = -ENODEV;
+	iface_desc = intf->cur_altsetting;
+	if (!iface_desc)
+		goto err;
+
+	/* Infvalid interface Settings */
+	if (iface_desc->desc.bNumEndpoints != 3)
+		goto err;
+
+	dev_info(&udev->dev, "Found UCAN device on interface #%d\n",
+		 iface_desc->desc.iInterface);
+
+	/* allocate driver resources */
+	ret = -ENOMEM;
+	netdev = alloc_candev(sizeof(struct ucan), MAX_TX_URBS);
+	if (!netdev)
+		goto err;
+
+	up = netdev_priv(netdev);
+
+	/* get interface descriptors */
+	for (i = 0; i < iface_desc->desc.bNumEndpoints; i++) {
+		ep = &iface_desc->endpoint[i].desc;
+
+		if (((ep->bEndpointAddress & USB_ENDPOINT_DIR_MASK) != 0) &&
+		    ((ep->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) ==
+		     USB_ENDPOINT_XFER_BULK)) {
+			/* In Endpoint */
+			up->in_ep = ep;
+		} else if (((ep->bEndpointAddress & USB_ENDPOINT_DIR_MASK) ==
+			    0) &&
+			   ((ep->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) ==
+			    USB_ENDPOINT_XFER_BULK)) {
+			/* Out Endpoint */
+			up->out_ep = ep;
+		} else if (((ep->bEndpointAddress & USB_ENDPOINT_DIR_MASK) !=
+			    0) &&
+			   ((ep->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) ==
+			    USB_ENDPOINT_XFER_INT)) {
+			/* Out Endpoint */
+			up->irq_ep = ep;
+		}
+	}
+
+	/* check if all interfaces are sane */
+	if (!up->in_ep || !up->out_ep || !up->irq_ep) {
+		dev_err(&udev->dev, "Invalid endpoint configuration\n");
+		goto err_free_candev;
+	}
+
+	if (up->in_ep->wMaxPacketSize < sizeof(struct ucan_message_in))
+		goto err_free_candev;
+	if (up->out_ep->wMaxPacketSize < sizeof(struct ucan_message_out))
+		goto err_free_candev;
+	if (up->irq_ep->wMaxPacketSize < sizeof(u32))
+		goto err_free_candev;
+
+	dev_dbg(&udev->dev,
+		 " using EP %02x for input with max packet size 0x%x\n",
+		 up->in_ep->bEndpointAddress, up->in_ep->wMaxPacketSize);
+	dev_dbg(&udev->dev,
+		 " using EP %02x for output with max packet size 0x%x\n",
+		 up->out_ep->bEndpointAddress, up->out_ep->wMaxPacketSize);
+	dev_dbg(&udev->dev,
+		 " using EP %02x for irq input with max packet size 0x%x\n",
+		 up->irq_ep->bEndpointAddress, up->irq_ep->wMaxPacketSize);
+
+	/* initialze data */
+	up->udev = udev;
+	up->netdev = netdev;
+
+	up->can.state = CAN_STATE_STOPPED;
+	up->can.bittiming_const = &up->device_info.bittiming_const;
+	up->can.do_set_bittiming = ucan_set_bittiming;
+	netdev->netdev_ops = &ucan_netdev_ops;
+
+	usb_set_intfdata(intf, up);
+	SET_NETDEV_DEV(netdev, &intf->dev);
+
+	/* allocate memory for command messages */
+	up->tx_msg_buffer =
+	    devm_kzalloc(&udev->dev, up->out_ep->wMaxPacketSize, GFP_KERNEL);
+	if (!up->tx_msg_buffer)
+		goto err_free_candev;
+	up->rx_msg_buffer =
+	    devm_kzalloc(&udev->dev, up->in_ep->wMaxPacketSize, GFP_KERNEL);
+	if (!up->rx_msg_buffer)
+		goto err_free_candev;
+
+	/* reset the device */
+	ret = ucan_command(up, UCAN_COMMAND_RESET, 0, 0);
+	if (ret)
+		goto err_free_candev;
+
+	/* gather device information */
+	ret = ucan_get_device_info(up);
+	if (ret)
+		goto err_free_candev;
+
+	dev_info(&up->udev->dev,
+	    "Device Reports:\n"
+	    "  Frequency [Hz]           : %d\n"
+	    "  TX Fifo [length]         : %d\n"
+	    "  Time Segment 1 [min,max] : %d - %d\n"
+	    "  Time Segment 2 [min,max] : %d - %d\n"
+	    "  SWJ [max]                : %d\n"
+	    "  Prescale [min-max,step]  : %d - %d, %d\n"
+	    "  Supported modes          :%s%s%s%s%s [%x]\n",
+	    up->can.clock.freq, up->device_info.tx_fifo,
+	    up->can.bittiming_const->tseg1_min,
+	    up->can.bittiming_const->tseg1_max,
+	    up->can.bittiming_const->tseg2_min,
+	    up->can.bittiming_const->tseg2_max,
+	    up->can.bittiming_const->sjw_max, up->can.bittiming_const->brp_min,
+	    up->can.bittiming_const->brp_max, up->can.bittiming_const->brp_inc,
+	    (up->can.ctrlmode_supported & CAN_CTRLMODE_LOOPBACK) ? " Loopback"
+								 : "",
+	    (up->can.ctrlmode_supported & CAN_CTRLMODE_LISTENONLY) ? " Silent"
+								   : "",
+	    (up->can.ctrlmode_supported & CAN_CTRLMODE_3_SAMPLES)
+		? " 3-Sampling"
+		: "",
+	    (up->can.ctrlmode_supported & CAN_CTRLMODE_ONE_SHOT) ? " OneShot"
+								 : "",
+	    (up->can.ctrlmode_supported & CAN_CTRLMODE_BERR_REPORTING)
+		? " BusErrReport"
+		: "",
+	    up->can.ctrlmode_supported);
+
+	atomic_set(&up->active_tx_urbs, 0);
+	for (i = 0; i < MAX_TX_URBS; i++)
+		up->tx_urb_contexts[i].echo_index = -1;
+
+	init_usb_anchor(&up->rx_urbs);
+	init_usb_anchor(&up->tx_urbs);
+
+	/* register the device */
+	ret = register_candev(netdev);
+	if (ret)
+		goto err_free_candev;
+
+	/* success */
+	return 0;
+
+err_free_candev:
+	free_candev(netdev);
+err:
+	return ret;
+}
+
+/* disconnect the device */
+static void ucan_disconnect(struct usb_interface *intf)
+{
+	struct usb_device *udev;
+	struct ucan *up = usb_get_intfdata(intf);
+
+	udev = interface_to_usbdev(intf);
+	dev_dbg(&udev->dev, "%s\n", __func__);
+
+	usb_set_intfdata(intf, NULL);
+
+	if (up) {
+		unregister_netdev(up->netdev);
+		free_candev(up->netdev);
+	}
+}
+
+/* driver callbacks */
+static struct usb_driver ucan_driver = {
+	.name = "ucan",
+	.probe = ucan_probe,
+	.disconnect = ucan_disconnect,
+	.id_table = ucan_table,
+};
+
+module_usb_driver(ucan_driver);
diff --git a/drivers/net/can/usb/ucan.h b/drivers/net/can/usb/ucan.h
new file mode 100644
index 000000000000..7e070776148a
--- /dev/null
+++ b/drivers/net/can/usb/ucan.h
@@ -0,0 +1,235 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __UCAN_H__
+
+/* Header file for Theobroma Systems UCAN driver
+ *
+ * Copyright (C) 2015 Theobroma Systems Design und Consulting GmbH
+ *
+ * This driver was inspired by the Linux 4.0.0 version of
+ * drivers/net/can/usb/ems_usb.c .
+ */
+
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/signal.h>
+#include <linux/slab.h>
+#include <linux/usb.h>
+
+#include <linux/can.h>
+#include <linux/can/dev.h>
+#include <linux/can/error.h>
+
+/* UCAN Message Definitions --------------------------------------------
+ *
+ *  ucan_message_out_t and ucan_message_in_t define the messages
+ *  transmitted on the OUT and IN endpoint.
+ *
+ *  Multibyte fields are transmitted with little endianness
+ *
+ *  INTR Endpoint: a single uint32_t storing the current space in the fifo
+ *
+ *  OUT Enpoint: single message of type ucan_message_out_t is
+ *    transmitted on the out endpoint
+ *
+ *  IN Endpoint: multiple messages ucan_message_in_t concateted in
+ *    the following way:
+ *
+ *      m[n].len <=> the length if message n(including the header in bytes)
+ *      m[n] is is aligned to a 4 byte boundary, hence
+ *        offset(m[0])   := 0;
+ *        offset(m[n+1]) := offset(m[n]) + (m[n].len + 3) & 3
+ *
+ *      this implies that
+ *        offset(m[n]) % 4 <=> 0
+ */
+
+/* UCAN Commands */
+enum {
+	/* start the can transceiver - val defines the operation mode */
+	UCAN_COMMAND_START    = 0,
+	/* cancel pending transmissions and stop the can transceiver */
+	UCAN_COMMAND_STOP     = 1,
+	/* send can transceiver into low-power sleep mode */
+	UCAN_COMMAND_SLEEP    = 2,
+	/* wake up can transceiver from low-power sleep mode */
+	UCAN_COMMAND_WAKEUP   = 3,
+	/* reset the can transceiver */
+	UCAN_COMMAND_RESET    = 4,
+	/* get piece of info from the can transceiver - subcmd defines what
+	 * piece
+	 */
+	UCAN_COMMAND_GET      = 5,
+	/* clear or disable hardware filter - subcmd defines which of the two */
+	UCAN_COMMAND_FILTER   = 6,
+};
+
+/* UCAN_COMMAND_START and UCAN_COMMAND_GET_INFO operation modes (bitmap).
+ * Undefined bits must be set to 0.
+ */
+enum {
+	UCAN_MODE_LOOPBACK    = (1 << 0),
+	UCAN_MODE_SILENT      = (1 << 1),
+	UCAN_MODE_3_SAMPLES   = (1 << 2),
+	UCAN_MODE_ONE_SHOT    = (1 << 3),
+	UCAN_MODE_BERR_REPORT = (1 << 4),
+};
+
+/* UCAN_COMMAND_GET subcommands */
+enum {
+	UCAN_COMMAND_GET_INFO = 0,
+};
+
+/* UCAN_COMMAND_FILTER subcommands */
+enum {
+	UCAN_FILTER_CLEAR     = 0,
+	UCAN_FILTER_DISABLE   = 1,
+};
+
+/* OUT endpoint message types */
+enum {
+	UCAN_OUT_COMMAND       = 0, /* send a simple command to the device */
+	UCAN_OUT_SET_BITTIMING = 1, /* set the CAN bit timing parameters */
+	UCAN_OUT_TX            = 2, /* transmit a CAN frame */
+	UCAN_OUT_ENABLE_FILTER = 3, /* enable hardare id filter */
+};
+
+/* IN endpoint message types */
+enum {
+	UCAN_IN_DEVICE_INFO = 0,
+	UCAN_IN_RX = 2,
+};
+
+/* OUT Enpoint, outbound messages */
+struct ucan_message_out {
+	u16 len;  /* Length of the content include header */
+	u16 type; /* UCAN_OUT_COMMAND and friends */
+	union {
+		/***************************************************
+		 * Device Command
+		 * (type == UCAN_OUT_COMMAND)
+		 ***************************************************/
+		struct {
+			u8 cmd; /* UCAN_COMMAND_START and friends */
+			u8 subcmd;
+			u16 val;
+		} __packed command;
+
+		/***************************************************
+		 * Set Bittiming
+		 * (type == UCAN_OUT_SET_BITTIMING)
+		 ***************************************************/
+		struct {
+			u32 tq;		  /* Time quanta (TQ) in nanoseconds */
+			u16 brp;	  /* TQ Prescaler */
+			u16 sample_point; /* Samplepoint on tenth percent */
+			u8 prop_seg;      /* Propagation segment in TQs */
+			u8 phase_seg1;    /* Phase buffer segment 1 in TQs */
+			u8 phase_seg2;    /* Phase buffer segment 2 in TQs */
+			u8 sjw; /* Synchronisation jump width in TQs */
+		} __packed bittiming;
+
+		/***************************************************
+		 * Transmit CAN frame
+		 * (type == UCAN_TX) && ((msg.can_msg.id & CAN_RTR_FLAG) == 0)
+		 ***************************************************/
+		struct {
+			 /* note DLC is computed by
+			  *    msg.len - sizeof (msg.len)
+			  *            - sizeof (msg.type)
+			  *            - sizeof (msg.can_msg.id)
+			  */
+			u32 id;
+			u8 data[8];
+			/* ensure data alignment to 4
+			 * by moving dlc after data
+			 */
+		} __packed can_msg;
+
+		/***************************************************
+		 * Transmit RTR CAN frame
+		 * (type == UCAN_TX) && ((msg.can_msg.id & CAN_RTR_FLAG) != 0)
+		 ***************************************************/
+		struct {
+			u32 id;
+			u8 dlc;
+		} __packed can_rtr_msg;
+
+		/***************************************************
+		 * Enable Filter
+		 * (type == UCAN_OUT_ENABLE_FILTER)
+		 * Not yet used by the driver.
+		 ***************************************************/
+		struct {
+			u32 id;
+			u32 mask;
+			u16 mbox;
+		} enable_filter;
+	} __aligned(0x4) msg;
+} __packed;
+
+/* IN Enpoint, inbound messages */
+struct ucan_message_in {
+	u16 len;  /* Length of the content include header */
+	u16 type; /* UCAN_IN_DEVICE_INFO and friends */
+
+	union {
+		/***************************************************
+		 * Device Information
+		 * (type == UCAN_IN_DEVICE_INFO)
+		 ***************************************************/
+		struct {
+			u32 freq;   /* Clock Frequency for tq generation */
+			u8 tx_fifo; /* Size of the transmission fifo */
+			u8 sjw_max;   /* can_bittiming fields... */
+			u8 tseg1_min;
+			u8 tseg1_max;
+			u8 tseg2_min;
+			u8 tseg2_max;
+			u16 brp_inc;
+			u32 brp_min;
+			u32 brp_max; /* ...can_bittiming fields */
+			u16 ctrlmodes; /* supported control modes */
+			u16 hwfilter;  /* Number of HW filter banks */
+			u16 rxmboxes;  /* Number of receive Mailboxes */
+		} __packed device_info;
+
+		/***************************************************
+		 * CAN Frame received
+		 * (type == UCAN_IN_RX)
+		 * && ((msg.can_msg.id & CAN_RTR_FLAG) == 0)
+		 ***************************************************/
+		struct {
+			 /* note DLC is computed by
+			  *    msg.len - sizeof (msg.len)
+			  *            - sizeof (msg.type)
+			  *            - sizeof (msg.can_msg.id)
+			  */
+			u32 id;
+			u8 data[8];
+			/* ensure data alignment to 4
+			 * by moving dlc after data
+			 */
+		} __packed can_msg;
+
+		/***************************************************
+		 * CAN RTR Frame received
+		 * (type == UCAN_IN_RX)
+		 * && ((msg.can_msg.id & CAN_RTR_FLAG) != 0)
+		 ***************************************************/
+		struct {
+			u32 id;
+			u8 dlc;
+		} __packed can_rtr_msg;
+
+	} __aligned(0x4) msg;
+} __packed;
+
+/* Macros to calculate message lengths */
+#define UCAN_OUT_HDR_SIZE offsetof(struct ucan_message_out, msg)
+#define UCAN_OUT_LEN(member) (UCAN_OUT_HDR_SIZE + sizeof(member))
+
+#define UCAN_IN_HDR_SIZE offsetof(struct ucan_message_in, msg)
+#define UCAN_IN_LEN(member) (UCAN_OUT_HDR_SIZE + sizeof(member))
+
+#endif
-- 
2.11.0

