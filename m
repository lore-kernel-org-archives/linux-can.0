From: "Max S." <max@schneidersoft.net>
Subject: (unknown)
Date: Wed, 02 Oct 2013 19:45:37 +0000
Message-ID: <1380743137.3501.7.camel@blackbox>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-xA0fqbWyYs5hSgcODtSb"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.schneidersoft.net ([173.45.248.65]:42440 "EHLO
	mail.schneidersoft.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281Ab3JBTe3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Oct 2013 15:34:29 -0400
Received: from [192.168.1.13] (unknown [177.119.223.194])
	by mail.schneidersoft.net (Postfix) with ESMTPSA id 2DD171A2F2
	for <linux-can@vger.kernel.org>; Wed,  2 Oct 2013 14:36:14 -0500 (CDT)
Subject: 
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>


--=-xA0fqbWyYs5hSgcODtSb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hello All,

Whats the protocol for getting a driver into the mainline kernel?
I've reached a working and fairly stable state with the CAN adapter I'm
working on, and would like to get its driver mainlined.

Attached is a patch.

Thanks,
Max Schneider.

--=-xA0fqbWyYs5hSgcODtSb
Content-Disposition: attachment; filename="0001-GS_USB-CAN-Driver.patch"
Content-Type: text/x-patch; name="0001-GS_USB-CAN-Driver.patch"; charset="UTF-8"
Content-Transfer-Encoding: 8bit

From 2e4c4df9aae119279eb0913db0b7bc1d1025879a Mon Sep 17 00:00:00 2001
From: Maximilian Schneider <max@schneidersoft.net>
Date: Wed, 2 Oct 2013 18:48:26 +0000
Subject: [PATCH] GS_USB CAN Driver.


Signed-off-by: Maximilian Schneider <max@schneidersoft.net>
---
 drivers/net/can/usb/Kconfig  |    8 +
 drivers/net/can/usb/Makefile |    1 +
 drivers/net/can/usb/gs_usb.c | 1121 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1130 insertions(+)
 create mode 100644 drivers/net/can/usb/gs_usb.c

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index fc96a3d..f5e3e8c 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -54,4 +54,12 @@ config CAN_8DEV_USB
 	  This driver supports the USB2CAN interface
 	  from 8 devices (http://www.8devices.com).
 
+config CAN_GS_USB
+	tristate "Geschwister Schneider UG interfaces"
+	---help---
+	  This driver supports the Geschwister Schneider USB/CAN devices.
+	  If unsure choose N,
+	  choose Y for built in support,
+	  M to compile as module (module will be named: gs_usb).
+
 endmenu
diff --git a/drivers/net/can/usb/Makefile b/drivers/net/can/usb/Makefile
index becef46..c21a521 100644
--- a/drivers/net/can/usb/Makefile
+++ b/drivers/net/can/usb/Makefile
@@ -7,5 +7,6 @@ obj-$(CONFIG_CAN_ESD_USB2) += esd_usb2.o
 obj-$(CONFIG_CAN_KVASER_USB) += kvaser_usb.o
 obj-$(CONFIG_CAN_PEAK_USB) += peak_usb/
 obj-$(CONFIG_CAN_8DEV_USB) += usb_8dev.o
+obj-$(CONFIG_CAN_GS_USB) += gs_usb.o
 
 ccflags-$(CONFIG_CAN_DEBUG_DEVICES) := -DDEBUG
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
new file mode 100644
index 0000000..558fc23
--- /dev/null
+++ b/drivers/net/can/usb/gs_usb.c
@@ -0,0 +1,1121 @@
+/* CAN driver for Geschwister Schneider USB/CAN devices.
+ *
+ * Copyright (C) 2013 Geschwister Schneider Technologie-,
+ * Entwicklungs- und Vertriebs UG (Haftungsbeschränkt).
+ *
+ * Many thanks to all socketcan devs!
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ */
+
+#include <linux/init.h>
+#include <linux/signal.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/usb.h>
+
+#include <linux/can.h>
+#include <linux/can/dev.h>
+#include <linux/can/error.h>
+
+/* Device specific constants */
+#define USB_GSUSB_1_VENDOR_ID      0x1d50
+#define USB_GSUSB_1_PRODUCT_ID     0x606f
+
+#define GSUSB_ENDPOINT_IN          1
+#define GSUSB_ENDPOINT_OUT         2
+
+/* Device specific constants */
+enum gs_usb_breq {
+	GS_USB_BREQ_HOST_FORMAT = 0,
+	GS_USB_BREQ_BITTIMING,
+	GS_USB_BREQ_MODE,
+	GS_USB_BREQ_BERR,
+	GS_USB_BREQ_BT_CONST,
+	GS_USB_BREQ_DEVICE_CONFIG
+};
+
+enum gs_can_mode {
+	GS_CAN_MODE_RESET = 0,
+	GS_CAN_MODE_START
+};
+
+enum gs_can_state {
+	GS_CAN_STATE_ERROR_ACTIVE = 0,
+	GS_CAN_STATE_ERROR_WARNING,
+	GS_CAN_STATE_ERROR_PASSIVE,
+	GS_CAN_STATE_BUS_OFF,
+	GS_CAN_STATE_STOPPED,
+	GS_CAN_STATE_SLEEPING
+};
+
+/* data types passed between host and device */
+struct __packed gs_host_config {
+	u32 byte_order;
+};
+
+struct __packed gs_device_config {
+	u8 reserved1;
+	u8 reserved2;
+	u8 reserved3;
+	u8 icount;
+	u32 sw_version;
+	u32 hw_version;
+};
+
+#define GS_CAN_MODE_NORMAL               0
+#define GS_CAN_MODE_LISTEN_ONLY          (1<<0)
+#define GS_CAN_MODE_LOOP_BACK            (1<<1)
+#define GS_CAN_MODE_TRIPLE_SAMPLE        (1<<2)
+#define GS_CAN_MODE_ONE_SHOT             (1<<3)
+
+struct __packed gs_device_mode {
+	u32 mode;
+	u32 flags;
+};
+
+struct __packed gs_device_state {
+	u32 state;
+	u32 rxerr;
+	u32 txerr;
+};
+
+struct __packed gs_device_bittiming {
+	u32 prop_seg;
+	u32 phase_seg1;
+	u32 phase_seg2;
+	u32 sjw;
+	u32 brp;
+};
+
+#define GS_CAN_FEATURE_LISTEN_ONLY      (1<<0)
+#define GS_CAN_FEATURE_LOOP_BACK        (1<<1)
+#define GS_CAN_FEATURE_TRIPLE_SAMPLE    (1<<2)
+#define GS_CAN_FEATURE_ONE_SHOT         (1<<3)
+
+struct __packed gs_device_bt_const {
+	u32 feature;
+	u32 fclk_can;
+	u32 tseg1_min;
+	u32 tseg1_max;
+	u32 tseg2_min;
+	u32 tseg2_max;
+	u32 sjw_max;
+	u32 brp_min;
+	u32 brp_max;
+	u32 brp_inc;
+};
+
+#define GS_CAN_FLAG_OVERFLOW 1
+
+struct __packed gs_host_frame {
+	u32 echo_id;
+	u32 can_id;
+
+	u8 can_dlc;
+	u8 channel;
+	u8 flags;
+	u8 reserved;
+
+	u8 data[8];
+};
+
+#define GS_RX_BUFFER_SIZE sizeof(struct __packed gs_host_frame)
+
+/* Special address description flags for the CAN_ID */
+#define GS_EFF_FLAG 0x80000000U /* EFF/SFF is set in the MSB */
+#define GS_RTR_FLAG 0x40000000U /* remote transmission request */
+#define GS_ERR_FLAG 0x20000000U /* error frame */
+
+/* Valid bits in CAN ID for frame formats */
+#define GS_SFF_MASK 0x000007FFU /* standard frame format (SFF) */
+#define GS_EFF_MASK 0x1FFFFFFFU /* extended frame format (EFF) */
+#define GS_ERR_MASK 0x1FFFFFFFU /* omit EFF, RTR, ERR flags */
+
+/* FIXME: this macro is only a placeholder for a better function */
+#define CONVERT_FLAGS(x) x
+
+/* Only send a max of MAX_TX_URBS frames per channel to the device at a time. */
+#define MAX_TX_URBS 10
+/* Only launch a max of MAX_RX_URBS usb requests at a time. */
+#define MAX_RX_URBS 30
+/* Maximum number of interfaces the driver supports per device.
+ * Current hardware only supports 2 interfaces. The future may vary.
+ */
+#define MAX_INTF 2
+
+struct gs_tx_context {
+	struct gs_can *dev;
+	unsigned int echo_id;
+};
+
+struct gs_can {
+	struct can_priv can; /* must be the first member */
+
+	struct gs_usb *parent;
+
+	struct net_device *netdev;
+	struct usb_device *udev;
+	struct usb_interface *iface;
+
+	struct can_bittiming_const bt_const;
+	unsigned int channel;	/* channel number */
+
+	spinlock_t tx_ctx_lock;
+	struct gs_tx_context tx_context[MAX_TX_URBS];
+
+	struct usb_anchor tx_submitted;
+	atomic_t active_tx_urbs;
+};
+
+/* usb interface struct */
+struct gs_usb {
+	struct gs_can *canch[MAX_INTF];
+
+	struct usb_anchor rx_submitted;
+
+	atomic_t active_channels;
+};
+
+/* 'allocate' a tx context.
+ * returns a valid tx context or NULL if there is no space.
+ */
+static struct gs_tx_context *gs_alloc_tx_context(struct gs_can *dev)
+{
+	int i = 0;
+	unsigned long flags;
+	spin_lock_irqsave(&dev->tx_ctx_lock, flags);
+
+	for (; i < MAX_TX_URBS; i++) {
+		if (dev->tx_context[i].echo_id == MAX_TX_URBS) {
+			dev->tx_context[i].echo_id = i;
+			spin_unlock_irqrestore(&dev->tx_ctx_lock, flags);
+			return &dev->tx_context[i];
+		}
+	}
+
+	spin_unlock_irqrestore(&dev->tx_ctx_lock, flags);
+	return NULL;
+}
+
+/* releases a tx context
+ */
+static void gs_free_tx_context(struct gs_tx_context *txc)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&txc->dev->tx_ctx_lock, flags);
+	txc->echo_id = MAX_TX_URBS;
+	spin_unlock_irqrestore(&txc->dev->tx_ctx_lock, flags);
+}
+
+/* Get a tx context by id.
+ */
+static struct gs_tx_context *gs_get_tx_context(
+	struct gs_can *dev,
+	unsigned int id)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&dev->tx_ctx_lock, flags);
+	if (id < MAX_TX_URBS) {
+		if (dev->tx_context[id].echo_id == id) {
+			spin_unlock_irqrestore(&dev->tx_ctx_lock, flags);
+			return &dev->tx_context[id];
+		}
+	}
+	spin_unlock_irqrestore(&dev->tx_ctx_lock, flags);
+	return NULL;
+}
+
+/* Get a tx contexts id.
+ */
+static unsigned int gs_tx_context_id(struct gs_tx_context *txc)
+{
+	unsigned int id;
+	unsigned long flags;
+	spin_lock_irqsave(&txc->dev->tx_ctx_lock, flags);
+	id = txc->echo_id;
+	spin_unlock_irqrestore(&txc->dev->tx_ctx_lock, flags);
+	return id;
+}
+
+#define BUFFER_SIZE sizeof(struct gs_host_frame)
+
+static int gs_cmd_reset(struct gs_usb *gsusb, struct gs_can *gsdev)
+{
+	struct gs_device_mode *dm;
+	struct usb_interface *intf = gsdev->iface;
+	int rc;
+
+	dm = kzalloc(sizeof(*dm), GFP_KERNEL);
+	if (!dm)
+		return -ENOMEM;
+
+	dm->mode = GS_CAN_MODE_RESET;
+
+	rc = usb_control_msg(interface_to_usbdev(intf),
+			usb_sndctrlpipe(interface_to_usbdev(intf), 0),
+			GS_USB_BREQ_MODE,
+			USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
+			gsdev->channel,
+			0,
+			dm,
+			sizeof(*dm),
+			1000);
+
+	return rc;
+}
+
+/**************************** USB CALLBACKS **************************/
+static void gs_usb_recieve_bulk_callback(struct urb *urb)
+{
+	struct gs_usb *usbcan = urb->context;
+	struct gs_can *dev;
+	struct net_device *netdev;
+	int rc;
+	struct net_device_stats *stats;
+	struct gs_host_frame *hf = urb->transfer_buffer;
+	struct gs_tx_context *txc;
+
+	struct can_frame *cf;
+	struct sk_buff *skb;
+
+	BUG_ON(!usbcan);
+
+	switch (urb->status) {
+	case 0: /* success */
+		break;
+	case -ENOENT:
+	case -ESHUTDOWN:
+		return;
+	default:
+		/* printk(KERN_INFO "Rx URB aborted (%d)\n", urb->status); */
+		/* do not resubmit aborted urbs. eg: when device goes down */
+		return;
+	}
+
+	/* device reports out of range channel id */
+	if (hf->channel >= MAX_INTF)
+		/* printk(KERN_INFO "%d] strange channel #\n", hf->channel); */
+		goto resubmit_urb;
+
+	/* device reports bad channel id */
+	dev = usbcan->canch[hf->channel];
+	BUG_ON(!dev);
+
+	netdev = dev->netdev;
+	BUG_ON(!netdev);
+
+	if (!netif_device_present(netdev))
+		return;
+
+	stats = &dev->netdev->stats;
+
+	if (hf->echo_id == -1) { /* normal rx */
+		skb = alloc_can_skb(dev->netdev, &cf);
+		if (skb == NULL)
+			return;
+
+		cf->can_id = CONVERT_FLAGS(hf->can_id);
+		/* is it necessary to use get_can_dlc? */
+		cf->can_dlc = get_can_dlc(hf->can_dlc);
+		memcpy(cf->data, hf->data, 8);
+
+		netif_rx(skb);
+
+		netdev->stats.rx_packets++;
+		netdev->stats.rx_bytes += hf->can_dlc;
+	} else { /* echo_id = hf->echo_id */
+		if (hf->echo_id >= MAX_TX_URBS) {
+			netdev_info(netdev, "BAD echo %d\n", hf->echo_id);
+			goto resubmit_urb;
+		}
+
+		netdev->stats.tx_packets++;
+		netdev->stats.tx_bytes += hf->can_dlc;
+
+		txc = gs_get_tx_context(dev, hf->echo_id);
+
+		/* bad devices send bad echo_ids. */
+		if (!txc) {
+			netdev_info(netdev, "bad echo %d\n", hf->echo_id);
+			goto resubmit_urb;
+		}
+
+		can_get_echo_skb(netdev, gs_tx_context_id(txc));
+
+		gs_free_tx_context(txc);
+
+		netif_wake_queue(netdev);
+	}
+
+	if (hf->flags & GS_CAN_FLAG_OVERFLOW)
+		netdev_info(netdev, "overflow\n");
+
+
+resubmit_urb:
+	/* note: no urb refill... works for me */
+
+	rc = usb_submit_urb(urb, GFP_ATOMIC);
+
+	/* USB failure take down all interfaces */
+	if (rc == -ENODEV) {
+		for (rc = 0; rc < MAX_INTF; rc++) {
+			if (usbcan->canch[rc])
+				netif_device_detach(usbcan->canch[rc]->netdev);
+		}
+	}
+}
+
+static int gs_usb_set_bittiming(struct net_device *netdev)
+{
+	struct gs_can *dev = netdev_priv(netdev);
+	struct can_bittiming *bt = &dev->can.bittiming;
+	struct usb_interface *intf = dev->iface;
+	int rc;
+	struct gs_device_bittiming *dbt;
+
+	dbt = kmalloc(sizeof(*dbt), GFP_KERNEL);
+	if (!dbt)
+		return -ENOMEM;
+
+	dbt->prop_seg = bt->prop_seg;
+	dbt->phase_seg1 = bt->phase_seg1;
+	dbt->phase_seg2 = bt->phase_seg2;
+	dbt->sjw = bt->sjw;
+	dbt->brp = bt->brp;
+
+	rc = usb_control_msg(interface_to_usbdev(intf),
+			usb_sndctrlpipe(interface_to_usbdev(intf), 0),
+			GS_USB_BREQ_BITTIMING,
+			USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
+			dev->channel,
+			0,
+			dbt,
+			sizeof(*dbt),
+			1000);
+	if (rc < 0)
+		dev_warn(netdev->dev.parent, "Couldn't set bittimings %d", rc);
+
+	kfree(dbt);
+
+	return rc;
+}
+
+static int gs_usb_set_mode(struct net_device *netdev, enum can_mode mode)
+{
+	if (mode == CAN_MODE_START) {
+		netif_wake_queue(netdev);
+		return 0;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static int gs_usb_get_state(const struct net_device *netdev,
+enum can_state *state)
+{
+
+	struct gs_can *dev = netdev_priv(netdev);
+	struct usb_interface *intf = dev->iface;
+	int rc;
+	struct gs_device_state *dstate;
+
+	dev_warn(netdev->dev.parent, "CAN state");
+
+	dstate = kmalloc(sizeof(*dstate), GFP_KERNEL);
+	if (!dstate)
+		return -ENOMEM;
+
+	rc = usb_control_msg(interface_to_usbdev(intf),
+			usb_rcvctrlpipe(interface_to_usbdev(intf), 0),
+			GS_USB_BREQ_BERR,
+			USB_DIR_IN|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
+			dev->channel,
+			0,
+			dstate,
+			sizeof(*dstate),
+			1000);
+
+	if (rc < 0) {
+		dev_warn(netdev->dev.parent, "Couldn't get state %d", rc);
+		kfree(dstate);
+		return rc;
+	}
+
+	switch (dstate->state) {
+	/* RX/TX error count < 96 */
+	case GS_CAN_STATE_ERROR_ACTIVE:
+		*state = CAN_STATE_ERROR_ACTIVE;
+		break;
+	/* RX/TX error count < 128 */
+	case GS_CAN_STATE_ERROR_WARNING:
+		*state = CAN_STATE_ERROR_WARNING;
+		break;
+	/* RX/TX error count < 256 */
+	case GS_CAN_STATE_ERROR_PASSIVE:
+		*state = CAN_STATE_ERROR_PASSIVE;
+		break;
+	/* RX/TX error count >= 256 */
+	case GS_CAN_STATE_BUS_OFF:
+		*state = CAN_STATE_BUS_OFF;
+		break;
+	/* Device is stopped */
+	case GS_CAN_STATE_STOPPED:
+		*state = CAN_STATE_STOPPED;
+		break;
+	/* Device is sleeping */
+	case GS_CAN_STATE_SLEEPING:
+		*state = CAN_STATE_SLEEPING;
+		break;
+	default:
+		kfree(dstate);
+		return -ENOTSUPP;
+	}
+
+	kfree(dstate);
+	return 0;
+}
+
+static int gs_usb_get_berr_counter(const struct net_device *netdev,
+struct can_berr_counter *bec)
+{
+	struct gs_can *dev = netdev_priv(netdev);
+	struct usb_interface *intf = dev->iface;
+	int rc;
+	struct gs_device_state *dstate;
+
+	dstate = kmalloc(sizeof(*dstate), GFP_KERNEL);
+	if (!dstate)
+		return -ENOMEM;
+
+	rc = usb_control_msg(interface_to_usbdev(intf),
+			usb_rcvctrlpipe(interface_to_usbdev(intf), 0),
+			GS_USB_BREQ_BERR,
+			USB_DIR_IN|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
+			dev->channel,
+			0,
+			dstate,
+			sizeof(*dstate),
+			1000);
+	if (rc < 0) {
+		dev_warn(netdev->dev.parent, "Couldn't get error counters %d",
+			rc);
+		kfree(dstate);
+		return rc;
+	}
+
+	bec->txerr = dstate->txerr;
+	bec->rxerr = dstate->rxerr;
+
+	kfree(dstate);
+	return 0;
+}
+
+static void gs_usb_xmit_callback(struct urb *urb)
+{
+	struct gs_tx_context *txc = urb->context;
+	struct gs_can *dev;
+	struct net_device *netdev;
+
+	BUG_ON(!txc);
+
+	dev = txc->dev;
+	BUG_ON(!dev);
+
+	netdev = dev->netdev;
+	BUG_ON(!netdev);
+
+	if (urb->status) {
+		dev_info(netdev->dev.parent, "%d] xmit err %d\n",
+			dev->channel, txc->echo_id);
+	}
+
+	usb_free_coherent(urb->dev,
+		urb->transfer_buffer_length,
+		urb->transfer_buffer,
+		urb->transfer_dma);
+
+	atomic_dec(&dev->active_tx_urbs);
+
+	if (!netif_device_present(netdev))
+		return;
+
+	if (netif_queue_stopped(netdev))
+		netif_wake_queue(netdev);
+}
+
+static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
+struct net_device *netdev)
+{
+	struct gs_can *dev = netdev_priv(netdev);
+	struct net_device_stats *stats = &dev->netdev->stats;
+	struct urb *urb;
+	struct gs_host_frame *hf;
+	struct can_frame *cf;
+	int rc;
+	unsigned int idx;
+	struct gs_tx_context *txc;
+
+	if (dev->can.ctrlmode&CAN_CTRLMODE_LISTENONLY)
+		return NETDEV_TX_BUSY;
+
+	if (can_dropped_invalid_skb(netdev, skb))
+		return NETDEV_TX_OK;
+
+	/* find an empty context to keep track of transmission */
+	txc = gs_alloc_tx_context(dev);
+	if (!txc)
+		return NETDEV_TX_BUSY;
+
+	/* create a URB, and a buffer for it */
+	urb = usb_alloc_urb(0, GFP_ATOMIC);
+	if (!urb) {
+		gs_free_tx_context(txc);
+		dev_err(netdev->dev.parent, "No memory left for URBs\n");
+		goto nomem;
+	}
+
+	hf = usb_alloc_coherent(dev->udev, sizeof(*hf), GFP_ATOMIC,
+		&urb->transfer_dma);
+	if (!hf) {
+		gs_free_tx_context(txc);
+		dev_err(netdev->dev.parent, "No memory left for USB buffer\n");
+		usb_free_urb(urb);
+		goto nomem;
+	}
+
+	cf = (struct can_frame *)skb->data;
+
+	idx = gs_tx_context_id(txc);
+
+	if (idx >= MAX_TX_URBS) {
+		dev_err(netdev->dev.parent, "Invalid tx context %d\n", idx);
+		usb_free_urb(urb);
+		usb_free_coherent(dev->udev,
+					sizeof(*hf),
+					hf,
+					urb->transfer_dma);
+		goto nomem;
+	}
+
+	hf->echo_id = idx;
+	hf->channel = dev->channel;
+
+	hf->can_id = CONVERT_FLAGS(cf->can_id);
+	hf->can_dlc = cf->can_dlc;
+	memcpy(hf->data, cf->data, 8);
+
+	usb_fill_bulk_urb(urb, dev->udev,
+			usb_sndbulkpipe(dev->udev, GSUSB_ENDPOINT_OUT),
+			hf,
+			sizeof(*hf),
+			gs_usb_xmit_callback,
+			txc);
+
+	urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+	usb_anchor_urb(urb, &dev->tx_submitted);
+
+	can_put_echo_skb(skb, netdev, idx);
+
+	atomic_inc(&dev->active_tx_urbs);
+
+	rc = usb_submit_urb(urb, GFP_ATOMIC);
+	if (unlikely(rc)) {			/* usb send failed */
+		dev_err(netdev->dev.parent, "usb_submit failed %d\n", rc);
+
+		can_free_echo_skb(netdev, gs_tx_context_id(txc));
+		gs_free_tx_context(txc);
+
+		usb_unanchor_urb(urb);
+		usb_free_coherent(dev->udev,
+			sizeof(*hf),
+			hf,
+			urb->transfer_dma);
+
+		atomic_dec(&dev->active_tx_urbs);
+
+		if (rc == -ENODEV) {
+			netif_device_detach(netdev);
+		} else {
+			dev_warn(netdev->dev.parent, "Failed tx_urb %d\n", rc);
+
+			stats->tx_dropped++;
+		}
+	} else {
+		netdev->trans_start = jiffies;
+
+		/* Slow down tx path */
+		if (atomic_read(&dev->active_tx_urbs) >= MAX_TX_URBS)
+			netif_stop_queue(netdev);
+	}
+
+	/* let usb core take care of this urb */
+	usb_free_urb(urb);
+
+	return NETDEV_TX_OK;
+
+nomem:
+	dev_kfree_skb(skb);
+	stats->tx_dropped++;
+	return NETDEV_TX_OK;
+}
+
+static int gs_can_open(struct net_device *netdev)
+{
+	struct gs_can *dev = netdev_priv(netdev);
+	struct gs_usb *parent = dev->parent;
+	int rc, i;
+	struct gs_device_mode *dm;
+	u32 ctrlmode;
+
+	/* common open */
+	rc = open_candev(netdev);
+	if (rc)
+		return rc;
+
+	if (atomic_add_return(1, &parent->active_channels) == 1) {
+		dev_info(netdev->dev.parent, "Allocating rx URBs\n");
+		for (i = 0; i < MAX_RX_URBS; i++) {
+			struct urb *urb = NULL;
+			u8 *buf = NULL;
+
+			/* alloc rx urb */
+			urb = usb_alloc_urb(0, GFP_KERNEL);
+			if (!urb) {
+				dev_err(netdev->dev.parent,
+					"No memory left for URBs\n");
+				return -ENOMEM;
+			}
+
+			/* alloc rx buffer */
+			buf = usb_alloc_coherent(dev->udev,
+				BUFFER_SIZE,
+				GFP_KERNEL,
+				&urb->transfer_dma);
+			if (!buf) {
+				dev_err(netdev->dev.parent,
+					"No memory left for USB buffer\n");
+				usb_free_urb(urb);
+				return -ENOMEM;
+			}
+
+
+			/* fill, anchor, and submit rx urb */
+			usb_fill_bulk_urb(urb,
+					dev->udev,
+					usb_rcvbulkpipe(dev->udev,
+						GSUSB_ENDPOINT_IN),
+					buf,
+					BUFFER_SIZE,
+					gs_usb_recieve_bulk_callback,
+					parent
+					);
+			urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+
+			usb_anchor_urb(urb, &parent->rx_submitted);
+
+			rc = usb_submit_urb(urb, GFP_KERNEL);
+			if (rc) {
+				if (rc == -ENODEV)
+					netif_device_detach(dev->netdev);
+
+				usb_unanchor_urb(urb);
+				break;
+			}
+
+			/* Drop reference,
+			 * USB core will take care of freeing it
+			 */
+			usb_free_urb(urb);
+		}
+	}
+
+	dm = kmalloc(sizeof(*dm), GFP_KERNEL);
+	if (!dm)
+		return -ENOMEM;
+
+	/* flags */
+	ctrlmode = dev->can.ctrlmode;
+	dm->flags = 0;
+
+	if (ctrlmode & CAN_CTRLMODE_LOOPBACK)
+		dm->flags |= GS_CAN_MODE_LOOP_BACK;
+
+	else if (ctrlmode & CAN_CTRLMODE_LISTENONLY)
+		dm->flags |= GS_CAN_MODE_LISTEN_ONLY;
+
+
+	/* Controller is not allowed to retry TX
+	 * this mode is unavailable on atmels uc3c hardware
+	 */
+	if (ctrlmode & CAN_CTRLMODE_ONE_SHOT) {
+		dm->flags |= GS_CAN_MODE_ONE_SHOT;
+		dev_warn(netdev->dev.parent, "GS_USB_ONE_SHOT\n");
+	}
+
+	if (ctrlmode & CAN_CTRLMODE_3_SAMPLES) {
+		dm->flags |= GS_CAN_MODE_TRIPLE_SAMPLE;
+		dev_warn(netdev->dev.parent, "GS_USB_TRIPLE_SAMPLE\n");
+	}
+
+
+	/* finally start device */
+	dm->mode = GS_CAN_MODE_START;
+	rc = usb_control_msg(interface_to_usbdev(dev->iface),
+			usb_sndctrlpipe(interface_to_usbdev(dev->iface), 0),
+			GS_USB_BREQ_MODE,
+			USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
+			dev->channel,
+			0,
+			dm,
+			sizeof(*dm),
+			1000);
+
+	kfree(dm);
+
+	if (rc < 0) {
+		dev_warn(netdev->dev.parent, "Couldn't start device %d\n", rc);
+		return rc;
+	}
+
+	/* check mode... */
+	dm = kmalloc(sizeof(*dm), GFP_KERNEL);
+	if (!dm)
+		return -ENOMEM;
+
+	rc = usb_control_msg(interface_to_usbdev(dev->iface),
+			usb_rcvctrlpipe(interface_to_usbdev(dev->iface), 0),
+			GS_USB_BREQ_MODE,
+			USB_DIR_IN|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
+			dev->channel,
+			0,
+			dm,
+			sizeof(*dm),
+			1000);
+
+	if (rc < 0) {
+		dev_warn(netdev->dev.parent, "Couldn't get device mode %d\n",
+			rc);
+		kfree(dm);
+		return rc;
+	}
+
+	kfree(dm);
+
+	dev->can.state = CAN_STATE_ERROR_ACTIVE;
+
+	netif_start_queue(netdev);
+
+	netdev_info(netdev, "CAN open\n");
+	return 0;
+}
+
+/* think: ip link set canx down */
+static int gs_can_close(struct net_device *netdev)
+{
+	int rc;
+	struct gs_can *dev = netdev_priv(netdev);
+	struct gs_usb *parent = dev->parent;
+
+	netif_stop_queue(netdev);
+
+	/* Stop polling */
+	if (atomic_dec_and_test(&parent->active_channels)) {
+		dev_info(netdev->dev.parent,
+			"Freeing rx usb memory\n");
+
+		usb_kill_anchored_urbs(&parent->rx_submitted);
+	}
+
+	rc = gs_cmd_reset(parent, dev);
+	if (rc < 0)
+		dev_warn(netdev->dev.parent, "Couldn't shutdown device %d", rc);
+
+	close_candev(netdev);
+
+	netdev_info(netdev, "CAN close\n");
+	return 0;
+}
+
+/******************************** USB ********************************/
+
+static const struct net_device_ops gs_usb_netdev_ops = {
+	.ndo_open = gs_can_open,
+	.ndo_stop = gs_can_close,
+	.ndo_start_xmit = gs_can_start_xmit,
+};
+
+static int gs_make_candev(struct gs_can **out, unsigned int channel,
+struct usb_interface *intf)
+{
+	struct gs_can *dev;
+	struct net_device *netdev;
+	int rc;
+	struct gs_device_bt_const *bt_const;
+
+	bt_const = kmalloc(sizeof(*bt_const), GFP_KERNEL);
+	if (!bt_const)
+		return -ENOMEM;
+
+	/* fetch bit timing constants */
+	rc = usb_control_msg(interface_to_usbdev(intf),
+			usb_rcvctrlpipe(interface_to_usbdev(intf), 0),
+			GS_USB_BREQ_BT_CONST,
+			USB_DIR_IN|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
+			channel,
+			0,
+			bt_const,
+			sizeof(*bt_const),
+			1000);
+
+	if (rc < 0) {
+		dev_err(&intf->dev,
+			"Couldn't get bit timing const for channel %d\n",
+			rc);
+		kfree(bt_const);
+		return rc;
+	}
+
+	dev_info(&intf->dev, "fclock: %d\n", bt_const->fclk_can);
+
+	/* create netdev */
+	netdev = alloc_candev(sizeof(struct gs_can), MAX_TX_URBS);
+	if (!netdev) {
+		dev_err(&intf->dev, "Couldn't alloc candev\n");
+		kfree(bt_const);
+		return -ENOMEM;
+	}
+
+	dev = netdev_priv(netdev);
+
+	netdev->netdev_ops = &gs_usb_netdev_ops;
+
+	netdev->flags |= IFF_ECHO; /* we support full roundtrip echo */
+
+	/* dev settup */
+	strcpy(dev->bt_const.name, "gs_usb");
+	dev->bt_const.tseg1_min = bt_const->tseg1_min;
+	dev->bt_const.tseg1_max = bt_const->tseg1_max;
+	dev->bt_const.tseg2_min = bt_const->tseg2_min;
+	dev->bt_const.tseg2_max = bt_const->tseg2_max;
+	dev->bt_const.sjw_max = bt_const->sjw_max;
+	dev->bt_const.brp_min = bt_const->brp_min;
+	dev->bt_const.brp_max = bt_const->brp_max;
+	dev->bt_const.brp_inc = bt_const->brp_inc;
+
+	dev->udev = interface_to_usbdev(intf);
+	dev->iface = intf;
+	dev->netdev = netdev;
+	dev->channel = channel;
+
+	init_usb_anchor(&dev->tx_submitted);
+	atomic_set(&dev->active_tx_urbs, 0);
+	spin_lock_init(&dev->tx_ctx_lock);
+	for (rc = 0; rc < MAX_TX_URBS; rc++) {
+		dev->tx_context[rc].dev = dev;
+		dev->tx_context[rc].echo_id = MAX_TX_URBS;
+	}
+
+	/* can settup */
+	dev->can.state = CAN_STATE_STOPPED;
+	dev->can.clock.freq = bt_const->fclk_can;
+	dev->can.bittiming_const = &dev->bt_const;
+	dev->can.do_set_bittiming = gs_usb_set_bittiming;
+	dev->can.do_set_mode = gs_usb_set_mode;
+	dev->can.do_get_state = gs_usb_get_state;
+	dev->can.do_get_berr_counter = gs_usb_get_berr_counter;
+
+	dev->can.ctrlmode_supported = 0;
+
+	if (bt_const->feature & GS_CAN_FEATURE_LISTEN_ONLY)
+		dev->can.ctrlmode_supported |= CAN_CTRLMODE_LISTENONLY;
+
+	if (bt_const->feature & GS_CAN_FEATURE_LOOP_BACK)
+		dev->can.ctrlmode_supported |= CAN_CTRLMODE_LOOPBACK;
+
+	if (bt_const->feature & GS_CAN_FEATURE_TRIPLE_SAMPLE)
+		dev->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
+
+	if (bt_const->feature & GS_CAN_FEATURE_ONE_SHOT)
+		dev->can.ctrlmode_supported |= CAN_CTRLMODE_ONE_SHOT;
+
+	kfree(bt_const);
+
+	SET_NETDEV_DEV(netdev, &intf->dev);
+
+	rc = register_candev(dev->netdev);
+	if (rc) {
+		free_candev(dev->netdev);
+		dev_err(&intf->dev, "Couldn't register candev\n");
+		return rc;
+	}
+
+	*out = dev;
+	return 0;
+}
+
+static void gs_destroy_candev(struct gs_can *dev)
+{
+	unregister_candev(dev->netdev);
+	free_candev(dev->netdev);
+	usb_kill_anchored_urbs(&dev->tx_submitted);
+}
+
+static int gs_usb_probe(struct usb_interface *intf,
+const struct usb_device_id *id)
+{
+	struct gs_usb *dev;
+	int rc = -ENOMEM;
+	unsigned int icount, i;
+	struct gs_host_config *hconf;
+	struct gs_device_config *dconf;
+
+	hconf = kmalloc(sizeof(*hconf), GFP_KERNEL);
+	if (!hconf)
+		return -ENOMEM;
+
+	hconf->byte_order = 0x0000beef;
+
+
+	/* send host config */
+	rc = usb_control_msg(interface_to_usbdev(intf),
+			usb_sndctrlpipe(interface_to_usbdev(intf), 0),
+			GS_USB_BREQ_HOST_FORMAT,
+			USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
+			1,
+			intf->altsetting[0].desc.bInterfaceNumber,
+			hconf,
+			sizeof(*hconf),
+			1000);
+
+	kfree(hconf);
+
+	if (rc < 0) {
+		dev_err(&intf->dev, "Couldn't send data format: %d\n",
+			rc);
+		return rc;
+	}
+
+
+	dconf = kmalloc(sizeof(*dconf), GFP_KERNEL);
+	if (!dconf)
+		return -ENOMEM;
+
+	/* read device config */
+	rc = usb_control_msg(interface_to_usbdev(intf),
+			usb_rcvctrlpipe(interface_to_usbdev(intf), 0),
+			GS_USB_BREQ_DEVICE_CONFIG,
+			USB_DIR_IN|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
+			1,
+			intf->altsetting[0].desc.bInterfaceNumber,
+			dconf,
+			sizeof(*dconf),
+			1000);
+	if (rc < 0) {
+		dev_err(&intf->dev, "Couldn't recieve device config: %d\n",
+			rc);
+		return rc;
+	}
+
+	icount = dconf->icount+1;
+	kfree(dconf);
+
+	dev_info(&intf->dev, "Configuring for %d interfaces\n", icount);
+
+	if (icount > MAX_INTF) {
+		dev_err(&intf->dev,
+			"Driver cannot handle more that %d Can interfaces\n",
+			MAX_INTF);
+		return -EINVAL;
+	}
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	init_usb_anchor(&dev->rx_submitted);
+
+	atomic_set(&dev->active_channels, 0);
+
+	usb_set_intfdata(intf, dev);
+
+	for (i = 0; i < icount; i++) {
+		rc = gs_make_candev(&dev->canch[i], i, intf);
+		if (rc) {
+			/* on failure destroy previously created candevs */
+			icount = i;
+			for (i = 0; i < icount; i++) {
+				gs_destroy_candev(dev->canch[i]);
+				dev->canch[icount] = NULL;
+			}
+			return rc;
+		}
+		dev->canch[i]->parent = dev;
+	}
+
+	dev_info(&intf->dev, "Probe\n");
+	return 0;
+}
+
+static void gs_usb_disconnect(struct usb_interface *intf)
+{
+	unsigned i;
+	struct gs_usb *dev = usb_get_intfdata(intf);
+	usb_set_intfdata(intf, NULL);
+
+	if (!dev) {
+		dev_info(&intf->dev, "Disconnect (nodata)\n");
+		return;
+	}
+
+	for (i = 0; i < MAX_INTF; i++) {
+		struct gs_can *can = dev->canch[i];
+
+		if (!can)
+			continue;
+
+		gs_destroy_candev(can);
+	}
+
+	usb_kill_anchored_urbs(&dev->rx_submitted);
+
+	dev_info(&intf->dev, "Disconnect\n");
+}
+
+MODULE_DEVICE_TABLE(usb, gs_usb_table);
+
+static struct usb_device_id gs_usb_table[] = {
+	{USB_DEVICE(USB_GSUSB_1_VENDOR_ID, USB_GSUSB_1_PRODUCT_ID)},
+	{} /* Terminating entry */
+};
+
+static struct usb_driver gs_usb_driver = {
+	.name       = "gs_usb",
+	.probe      = gs_usb_probe,
+	.disconnect = gs_usb_disconnect,
+	.id_table   = gs_usb_table
+};
+
+static int __init gs_usb_init(void)
+{
+	return usb_register(&gs_usb_driver);
+}
+
+static void __exit gs_usb_exit(void)
+{
+	usb_deregister(&gs_usb_driver);
+}
+
+module_init(gs_usb_init);
+module_exit(gs_usb_exit);
+
+MODULE_AUTHOR("Maximilian Schneider <mws@schneidersoft.net>");
+MODULE_DESCRIPTION(
+"Socket CAN device driver for Geschwister Schneider Technologie-, "
+"Entwicklungs- und Vertriebs UG. USB2.0 to CAN interfaces.");
+MODULE_LICENSE("GPL v2");
+
-- 
1.7.10.4


--=-xA0fqbWyYs5hSgcODtSb--

