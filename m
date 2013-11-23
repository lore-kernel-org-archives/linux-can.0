From: "Max S." <max@schneidersoft.net>
Subject: Re: GS_USB
Date: Sat, 23 Nov 2013 16:05:52 +0000
Message-ID: <1385222752.3602.6.camel@blackbox>
References: <1380889887.22484.2.camel@blackbox>
	 <52507832.8000709@grandegger.com> <1381155720.21207.7.camel@blackbox>
	 <5e3f6029b128db63c69664deed10c5d6@grandegger.com>
	 <1381175546.21207.37.camel@blackbox> <525319E6.4020505@grandegger.com>
	 <1383498724.4208.4.camel@blackbox> <527EC310.5010003@grandegger.com>
	 <1384135835.3749.31.camel@blackbox>
	 <3370f1eba56bbe04176f4d14808c1dc0@grandegger.com>
	 <5280FAB2.3030600@hartkopp.net> <1384199350.3483.20.camel@blackbox>
	 <528150F3.8090406@hartkopp.net> <1384511999.3561.8.camel@blackbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.schneidersoft.net ([173.45.248.65]:44589 "EHLO
	mail.schneidersoft.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753922Ab3KWPwq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 23 Nov 2013 10:52:46 -0500
Received: from [192.168.1.13] (unknown [179.245.114.204])
	by mail.schneidersoft.net (Postfix) with ESMTPSA id 6AFA51A191
	for <linux-can@vger.kernel.org>; Sat, 23 Nov 2013 09:55:06 -0600 (CST)
In-Reply-To: <1384511999.3561.8.camel@blackbox>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

OK.

Here's the latest progress.

no line wrap this time :)

=46rom 74b99fe4e949a53d05ac35dc413e3ec3f9e352f6 Mon Sep 17 00:00:00 200=
1
=46rom: Maximilian Schneider <max@schneidersoft.net>
Date: Sun, 3 Nov 2013 16:57:06 +0000
Subject: [PATCH] Added support for the GS_USB CAN devices. The Geschwis=
ter
 Schneider Family of devices are galvanically isolated
 USB2.0 to CAN2.0A/B adapters. Currently two form factors
 are available, a tethered dongle in a rugged enclosure, and
 mini-pci-e card.


Signed-off-by: Maximilian Schneider <max@schneidersoft.net>
---
 drivers/net/can/usb/Kconfig  |    8 +
 drivers/net/can/usb/Makefile |    1 +
 drivers/net/can/usb/gs_usb.c | 1005 ++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 1014 insertions(+)
 create mode 100644 drivers/net/can/usb/gs_usb.c

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index fc96a3d..f5e3e8c 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -54,4 +54,12 @@ config CAN_8DEV_USB
 	  This driver supports the USB2CAN interface
 	  from 8 devices (http://www.8devices.com).
=20
+config CAN_GS_USB
+	tristate "Geschwister Schneider UG interfaces"
+	---help---
+	  This driver supports the Geschwister Schneider USB/CAN devices.
+	  If unsure choose N,
+	  choose Y for built in support,
+	  M to compile as module (module will be named: gs_usb).
+
 endmenu
diff --git a/drivers/net/can/usb/Makefile b/drivers/net/can/usb/Makefil=
e
index becef46..c21a521 100644
--- a/drivers/net/can/usb/Makefile
+++ b/drivers/net/can/usb/Makefile
@@ -7,5 +7,6 @@ obj-$(CONFIG_CAN_ESD_USB2) +=3D esd_usb2.o
 obj-$(CONFIG_CAN_KVASER_USB) +=3D kvaser_usb.o
 obj-$(CONFIG_CAN_PEAK_USB) +=3D peak_usb/
 obj-$(CONFIG_CAN_8DEV_USB) +=3D usb_8dev.o
+obj-$(CONFIG_CAN_GS_USB) +=3D gs_usb.o
=20
 ccflags-$(CONFIG_CAN_DEBUG_DEVICES) :=3D -DDEBUG
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.=
c
new file mode 100644
index 0000000..732f3cf
--- /dev/null
+++ b/drivers/net/can/usb/gs_usb.c
@@ -0,0 +1,1005 @@
+/* CAN driver for Geschwister Schneider USB/CAN devices.
+ *
+ * Copyright (C) 2013 Geschwister Schneider Technologie-,
+ * Entwicklungs- und Vertriebs UG (Haftungsbeschr=C3=A4nkt).
+ *
+ * Many thanks to all socketcan devs!
+ *
+ * This program is free software; you can redistribute it and/or modif=
y it
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
+	GS_USB_BREQ_HOST_FORMAT =3D 0,
+	GS_USB_BREQ_BITTIMING,
+	GS_USB_BREQ_MODE,
+	GS_USB_BREQ_BERR,
+	GS_USB_BREQ_BT_CONST,
+	GS_USB_BREQ_DEVICE_CONFIG
+};
+
+enum gs_can_mode {
+	/* reset a channel. turns it off */
+	GS_CAN_MODE_RESET =3D 0,
+	/* starts a channel */
+	GS_CAN_MODE_START
+};
+
+enum gs_can_state {
+	GS_CAN_STATE_ERROR_ACTIVE =3D 0,
+	GS_CAN_STATE_ERROR_WARNING,
+	GS_CAN_STATE_ERROR_PASSIVE,
+	GS_CAN_STATE_BUS_OFF,
+	GS_CAN_STATE_STOPPED,
+	GS_CAN_STATE_SLEEPING
+};
+
+/* data types passed between host and device */
+struct gs_host_config {
+	u32 byte_order;
+} __packed;
+
+struct gs_device_config {
+	u8 reserved1;
+	u8 reserved2;
+	u8 reserved3;
+	u8 icount;
+	u32 sw_version;
+	u32 hw_version;
+} __packed;
+
+#define GS_CAN_MODE_NORMAL               0
+#define GS_CAN_MODE_LISTEN_ONLY          (1<<0)
+#define GS_CAN_MODE_LOOP_BACK            (1<<1)
+#define GS_CAN_MODE_TRIPLE_SAMPLE        (1<<2)
+#define GS_CAN_MODE_ONE_SHOT             (1<<3)
+
+struct gs_device_mode {
+	u32 mode;
+	u32 flags;
+} __packed;
+
+struct gs_device_state {
+	u32 state;
+	u32 rxerr;
+	u32 txerr;
+} __packed;
+
+struct gs_device_bittiming {
+	u32 prop_seg;
+	u32 phase_seg1;
+	u32 phase_seg2;
+	u32 sjw;
+	u32 brp;
+} __packed;
+
+#define GS_CAN_FEATURE_LISTEN_ONLY      (1<<0)
+#define GS_CAN_FEATURE_LOOP_BACK        (1<<1)
+#define GS_CAN_FEATURE_TRIPLE_SAMPLE    (1<<2)
+#define GS_CAN_FEATURE_ONE_SHOT         (1<<3)
+
+struct gs_device_bt_const {
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
+} __packed;
+
+#define GS_CAN_FLAG_OVERFLOW 1
+
+struct gs_host_frame {
+	u32 echo_id;
+	u32 can_id;
+
+	u8 can_dlc;
+	u8 channel;
+	u8 flags;
+	u8 reserved;
+
+	u8 data[8];
+} __packed;
+
+/* Only send a max of GS_MAX_TX_URBS frames per channel at a time. */
+#define GS_MAX_TX_URBS 10
+/* Only launch a max of GS_MAX_RX_URBS usb requests at a time. */
+#define GS_MAX_RX_URBS 30
+/* Maximum number of interfaces the driver supports per device.
+ * Current hardware only supports 2 interfaces. The future may vary.
+ */
+#define GS_MAX_INTF 2
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
+	/* This lock prevents a race condition between xmit and recieve. */
+	spinlock_t tx_ctx_lock;
+	struct gs_tx_context tx_context[GS_MAX_TX_URBS];
+
+	struct usb_anchor tx_submitted;
+	atomic_t active_tx_urbs;
+};
+
+/* usb interface struct */
+struct gs_usb {
+	struct gs_can *canch[GS_MAX_INTF];
+	struct usb_anchor rx_submitted;
+	atomic_t active_channels;
+	struct usb_device *udev;
+};
+
+/* 'allocate' a tx context.
+ * returns a valid tx context or NULL if there is no space.
+ */
+static struct gs_tx_context *gs_alloc_tx_context(struct gs_can *dev)
+{
+	int i =3D 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->tx_ctx_lock, flags);
+
+	for (; i < GS_MAX_TX_URBS; i++) {
+		if (dev->tx_context[i].echo_id =3D=3D GS_MAX_TX_URBS) {
+			dev->tx_context[i].echo_id =3D i;
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
+
+	spin_lock_irqsave(&txc->dev->tx_ctx_lock, flags);
+	txc->echo_id =3D GS_MAX_TX_URBS;
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
+
+	spin_lock_irqsave(&dev->tx_ctx_lock, flags);
+	if (id < GS_MAX_TX_URBS) {
+		if (dev->tx_context[id].echo_id =3D=3D id) {
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
+	id =3D txc->echo_id;
+	return id;
+}
+
+static int gs_cmd_reset(struct gs_usb *gsusb, struct gs_can *gsdev)
+{
+	struct gs_device_mode *dm;
+	struct usb_interface *intf =3D gsdev->iface;
+	int rc;
+
+	dm =3D kzalloc(sizeof(*dm), GFP_KERNEL);
+	if (!dm)
+		return -ENOMEM;
+
+	dm->mode =3D GS_CAN_MODE_RESET;
+
+	rc =3D usb_control_msg(interface_to_usbdev(intf),
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
+static void gs_update_state(struct gs_can *dev, struct can_frame *cf)
+{
+	struct can_device_stats *can_stats =3D &dev->can.can_stats;
+
+	if (cf->can_id & CAN_ERR_RESTARTED) {
+		dev->can.state =3D CAN_STATE_ERROR_ACTIVE;
+		can_stats->restarts++;
+	} else if (cf->can_id & CAN_ERR_BUSOFF) {
+		dev->can.state =3D CAN_STATE_BUS_OFF;
+		can_stats->bus_off++;
+	} else if (cf->can_id & CAN_ERR_CRTL) {
+		if ((cf->data[1] & CAN_ERR_CRTL_TX_WARNING) ||
+			(cf->data[1] & CAN_ERR_CRTL_RX_WARNING)) {
+			dev->can.state =3D CAN_STATE_ERROR_WARNING;
+			can_stats->error_warning++;
+		} else if ((cf->data[1] & CAN_ERR_CRTL_TX_PASSIVE) ||
+			(cf->data[1] & CAN_ERR_CRTL_RX_PASSIVE)) {
+			dev->can.state =3D CAN_STATE_ERROR_PASSIVE;
+			can_stats->error_passive++;
+		} else {
+			dev->can.state =3D CAN_STATE_ERROR_ACTIVE;
+		}
+	}
+}
+
+static void gs_usb_recieve_bulk_callback(struct urb *urb)
+{
+	struct gs_usb *usbcan =3D urb->context;
+	struct gs_can *dev;
+	struct net_device *netdev;
+	int rc;
+	struct net_device_stats *stats;
+	struct gs_host_frame *hf =3D urb->transfer_buffer;
+	struct gs_tx_context *txc;
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
+		/* do not resubmit aborted urbs. eg: when device goes down */
+		return;
+	}
+
+	/* device reports out of range channel id */
+	if (hf->channel >=3D GS_MAX_INTF)
+		goto resubmit_urb;
+
+	/* device reports bad channel id */
+	dev =3D usbcan->canch[hf->channel];
+
+	netdev =3D dev->netdev;
+	stats =3D &netdev->stats;
+
+	if (!netif_device_present(netdev))
+		return;
+
+	if (hf->echo_id =3D=3D -1) { /* normal rx */
+		skb =3D alloc_can_skb(dev->netdev, &cf);
+		if (skb =3D=3D NULL)
+			return;
+
+		cf->can_id =3D hf->can_id;
+		/* is it necessary to use get_can_dlc? */
+		cf->can_dlc =3D get_can_dlc(hf->can_dlc);
+		memcpy(cf->data, hf->data, 8);
+
+		/* ERROR frames tell us information about the controller */
+		if (hf->can_id & CAN_ERR_FLAG)
+			gs_update_state(dev, cf);
+
+		netif_rx(skb);
+
+		netdev->stats.rx_packets++;
+		netdev->stats.rx_bytes +=3D hf->can_dlc;
+	} else { /* echo_id =3D=3D hf->echo_id */
+		if (hf->echo_id >=3D GS_MAX_TX_URBS) {
+			netdev_err(netdev,
+				"Device sent an out of range echo id %d\n",
+				hf->echo_id);
+			goto resubmit_urb;
+		}
+
+		netdev->stats.tx_packets++;
+		netdev->stats.tx_bytes +=3D hf->can_dlc;
+
+		txc =3D gs_get_tx_context(dev, hf->echo_id);
+
+		/* bad devices send bad echo_ids. */
+		if (!txc) {
+			netdev_err(netdev,
+				"Device sent a bad echo id %d\n",
+				hf->echo_id);
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
+	if (hf->flags & GS_CAN_FLAG_OVERFLOW) {
+		skb =3D alloc_can_err_skb(netdev, &cf);
+		if (skb =3D=3D NULL)
+			goto resubmit_urb;
+
+		cf->can_id |=3D CAN_ERR_CRTL;
+		cf->data[1] =3D CAN_ERR_CRTL_RX_OVERFLOW;
+		stats->rx_over_errors++;
+		stats->rx_errors++;
+		netif_rx(skb);
+	}
+
+resubmit_urb:
+	/* note: no urb refill... works for me */
+	usb_fill_bulk_urb(urb,
+			usbcan->udev,
+			usb_rcvbulkpipe(usbcan->udev, GSUSB_ENDPOINT_IN),
+			hf,
+			sizeof(struct gs_host_frame),
+			gs_usb_recieve_bulk_callback,
+			usbcan
+			);
+
+	rc =3D usb_submit_urb(urb, GFP_ATOMIC);
+
+	/* USB failure take down all interfaces */
+	if (rc =3D=3D -ENODEV) {
+		for (rc =3D 0; rc < GS_MAX_INTF; rc++) {
+			if (usbcan->canch[rc])
+				netif_device_detach(usbcan->canch[rc]->netdev);
+		}
+	}
+}
+
+static int gs_usb_set_bittiming(struct net_device *netdev)
+{
+	struct gs_can *dev =3D netdev_priv(netdev);
+	struct can_bittiming *bt =3D &dev->can.bittiming;
+	struct usb_interface *intf =3D dev->iface;
+	int rc;
+	struct gs_device_bittiming *dbt;
+
+	dbt =3D kmalloc(sizeof(*dbt), GFP_KERNEL);
+	if (!dbt)
+		return -ENOMEM;
+
+	dbt->prop_seg =3D bt->prop_seg;
+	dbt->phase_seg1 =3D bt->phase_seg1;
+	dbt->phase_seg2 =3D bt->phase_seg2;
+	dbt->sjw =3D bt->sjw;
+	dbt->brp =3D bt->brp;
+
+	rc =3D usb_control_msg(interface_to_usbdev(intf),
+			usb_sndctrlpipe(interface_to_usbdev(intf), 0),
+			GS_USB_BREQ_BITTIMING,
+			USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
+			dev->channel,
+			0,
+			dbt,
+			sizeof(*dbt),
+			1000);
+	if (rc < 0)
+		dev_err(netdev->dev.parent, "Couldn't set bittimings %d", rc);
+
+	kfree(dbt);
+
+	return rc;
+}
+
+static void gs_usb_xmit_callback(struct urb *urb)
+{
+	struct gs_tx_context *txc =3D urb->context;
+	struct gs_can *dev =3D txc->dev;
+	struct net_device *netdev =3D dev->netdev;
+
+	if (urb->status) {
+		netdev_info(netdev, "%d] xmit err %d\n",
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
+	struct net_device *netdev)
+{
+	struct gs_can *dev =3D netdev_priv(netdev);
+	struct net_device_stats *stats =3D &dev->netdev->stats;
+	struct urb *urb;
+	struct gs_host_frame *hf;
+	struct can_frame *cf;
+	int rc;
+	unsigned int idx;
+	struct gs_tx_context *txc;
+
+	if (dev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
+		return NETDEV_TX_BUSY;
+
+	if (can_dropped_invalid_skb(netdev, skb))
+		return NETDEV_TX_OK;
+
+	/* find an empty context to keep track of transmission */
+	txc =3D gs_alloc_tx_context(dev);
+	if (!txc)
+		return NETDEV_TX_BUSY;
+
+	/* create a URB, and a buffer for it */
+	urb =3D usb_alloc_urb(0, GFP_ATOMIC);
+	if (!urb) {
+		netdev_err(netdev, "No memory left for URBs\n");
+		goto nomem_urb;
+	}
+
+	hf =3D usb_alloc_coherent(dev->udev, sizeof(*hf), GFP_ATOMIC,
+		&urb->transfer_dma);
+	if (!hf) {
+		netdev_err(netdev, "No memory left for USB buffer\n");
+		goto nomem_hf;
+	}
+
+	idx =3D gs_tx_context_id(txc);
+
+	if (idx >=3D GS_MAX_TX_URBS) {
+		netdev_err(netdev, "Invalid tx context %d\n", idx);
+		goto badidx;
+	}
+
+	hf->echo_id =3D idx;
+	hf->channel =3D dev->channel;
+
+	cf =3D (struct can_frame *)skb->data;
+
+	hf->can_id =3D cf->can_id;
+	hf->can_dlc =3D cf->can_dlc;
+	memcpy(hf->data, cf->data, 8);
+
+	usb_fill_bulk_urb(urb, dev->udev,
+			usb_sndbulkpipe(dev->udev, GSUSB_ENDPOINT_OUT),
+			hf,
+			sizeof(*hf),
+			gs_usb_xmit_callback,
+			txc);
+
+	urb->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
+	usb_anchor_urb(urb, &dev->tx_submitted);
+
+	can_put_echo_skb(skb, netdev, idx);
+
+	atomic_inc(&dev->active_tx_urbs);
+
+	rc =3D usb_submit_urb(urb, GFP_ATOMIC);
+	if (unlikely(rc)) {			/* usb send failed */
+		atomic_dec(&dev->active_tx_urbs);
+
+		netdev_err(netdev, "usb_submit failed %d\n", rc);
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
+
+		if (rc =3D=3D -ENODEV) {
+			netif_device_detach(netdev);
+		} else {
+			netdev_err(netdev, "Failed tx_urb %d\n", rc);
+			stats->tx_dropped++;
+		}
+	} else {
+		netdev->trans_start =3D jiffies;
+
+		/* Slow down tx path */
+		if (atomic_read(&dev->active_tx_urbs) >=3D GS_MAX_TX_URBS)
+			netif_stop_queue(netdev);
+	}
+
+	/* let usb core take care of this urb */
+	usb_free_urb(urb);
+
+	return NETDEV_TX_OK;
+
+badidx:
+	usb_free_coherent(dev->udev,
+				sizeof(*hf),
+				hf,
+				urb->transfer_dma);
+nomem_hf:
+	usb_free_urb(urb);
+
+nomem_urb:
+	gs_free_tx_context(txc);
+	dev_kfree_skb(skb);
+	stats->tx_dropped++;
+	return NETDEV_TX_OK;
+}
+
+static int gs_can_open(struct net_device *netdev)
+{
+	struct gs_can *dev =3D netdev_priv(netdev);
+	struct gs_usb *parent =3D dev->parent;
+	int rc, i;
+	struct gs_device_mode *dm;
+	u32 ctrlmode;
+
+	rc =3D open_candev(netdev);
+	if (rc)
+		return rc;
+
+	if (atomic_add_return(1, &parent->active_channels) =3D=3D 1) {
+		for (i =3D 0; i < GS_MAX_RX_URBS; i++) {
+			struct urb *urb =3D NULL;
+			u8 *buf =3D NULL;
+
+			/* alloc rx urb */
+			urb =3D usb_alloc_urb(0, GFP_KERNEL);
+			if (!urb) {
+				netdev_err(netdev,
+					"No memory left for URBs\n");
+				return -ENOMEM;
+			}
+
+			/* alloc rx buffer */
+			buf =3D usb_alloc_coherent(dev->udev,
+				sizeof(struct gs_host_frame),
+				GFP_KERNEL,
+				&urb->transfer_dma);
+			if (!buf) {
+				netdev_err(netdev,
+					"No memory left for USB buffer\n");
+				usb_free_urb(urb);
+				return -ENOMEM;
+			}
+
+			/* fill, anchor, and submit rx urb */
+			usb_fill_bulk_urb(urb,
+					dev->udev,
+					usb_rcvbulkpipe(dev->udev,
+						GSUSB_ENDPOINT_IN),
+					buf,
+					sizeof(struct gs_host_frame),
+					gs_usb_recieve_bulk_callback,
+					parent
+					);
+			urb->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
+
+			usb_anchor_urb(urb, &parent->rx_submitted);
+
+			rc =3D usb_submit_urb(urb, GFP_KERNEL);
+			if (rc) {
+				if (rc =3D=3D -ENODEV)
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
+	dm =3D kmalloc(sizeof(*dm), GFP_KERNEL);
+	if (!dm)
+		return -ENOMEM;
+
+	/* flags */
+	ctrlmode =3D dev->can.ctrlmode;
+	dm->flags =3D 0;
+
+	if (ctrlmode & CAN_CTRLMODE_LOOPBACK)
+		dm->flags |=3D GS_CAN_MODE_LOOP_BACK;
+	else if (ctrlmode & CAN_CTRLMODE_LISTENONLY)
+		dm->flags |=3D GS_CAN_MODE_LISTEN_ONLY;
+
+	/* Controller is not allowed to retry TX
+	 * this mode is unavailable on atmels uc3c hardware
+	 */
+	if (ctrlmode & CAN_CTRLMODE_ONE_SHOT)
+		dm->flags |=3D GS_CAN_MODE_ONE_SHOT;
+
+	if (ctrlmode & CAN_CTRLMODE_3_SAMPLES)
+		dm->flags |=3D GS_CAN_MODE_TRIPLE_SAMPLE;
+
+	/* finally start device */
+	dm->mode =3D GS_CAN_MODE_START;
+	rc =3D usb_control_msg(interface_to_usbdev(dev->iface),
+			usb_sndctrlpipe(interface_to_usbdev(dev->iface), 0),
+			GS_USB_BREQ_MODE,
+			USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
+			dev->channel,
+			0,
+			dm,
+			sizeof(*dm),
+			1000);
+
+	if (rc < 0) {
+		netdev_err(netdev, "Couldn't start device (err=3D%d)\n", rc);
+		kfree(dm);
+		return rc;
+	}
+
+	rc =3D usb_control_msg(interface_to_usbdev(dev->iface),
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
+		netdev_err(netdev, "Couldn't get device mode (err=3D%d)\n",
+			rc);
+		kfree(dm);
+		return rc;
+	}
+
+	kfree(dm);
+
+	dev->can.state =3D CAN_STATE_ERROR_ACTIVE;
+
+	netif_start_queue(netdev);
+
+	return 0;
+}
+
+static int gs_can_close(struct net_device *netdev)
+{
+	int rc;
+	struct gs_can *dev =3D netdev_priv(netdev);
+	struct gs_usb *parent =3D dev->parent;
+
+	netif_stop_queue(netdev);
+
+	/* Stop polling */
+	if (atomic_dec_and_test(&parent->active_channels))
+		usb_kill_anchored_urbs(&parent->rx_submitted);
+
+	rc =3D gs_cmd_reset(parent, dev);
+
+	if (rc < 0)
+		netdev_warn(netdev, "Couldn't shutdown device (err=3D%d)", rc);
+
+	close_candev(netdev);
+
+	return 0;
+}
+
+/******************************** USB ********************************=
/
+
+static const struct net_device_ops gs_usb_netdev_ops =3D {
+	.ndo_open =3D gs_can_open,
+	.ndo_stop =3D gs_can_close,
+	.ndo_start_xmit =3D gs_can_start_xmit,
+};
+
+static struct gs_can *gs_make_candev(unsigned int channel,
+	struct usb_interface *intf)
+{
+	struct gs_can *dev;
+	struct net_device *netdev;
+	int rc;
+	struct gs_device_bt_const *bt_const;
+
+	bt_const =3D kmalloc(sizeof(*bt_const), GFP_KERNEL);
+	if (!bt_const)
+		return ERR_PTR(-ENOMEM);
+
+	/* fetch bit timing constants */
+	rc =3D usb_control_msg(interface_to_usbdev(intf),
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
+			"Couldn't get bit timing const for channel (err=3D%d)\n",
+			rc);
+		kfree(bt_const);
+		return ERR_PTR(rc);
+	}
+
+	/* create netdev */
+	netdev =3D alloc_candev(sizeof(struct gs_can), GS_MAX_TX_URBS);
+	if (!netdev) {
+		dev_err(&intf->dev, "Couldn't alloc candev\n");
+		kfree(bt_const);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	dev =3D netdev_priv(netdev);
+
+	netdev->netdev_ops =3D &gs_usb_netdev_ops;
+
+	netdev->flags |=3D IFF_ECHO; /* we support full roundtrip echo */
+
+	/* dev settup */
+	strcpy(dev->bt_const.name, "gs_usb");
+	dev->bt_const.tseg1_min =3D bt_const->tseg1_min;
+	dev->bt_const.tseg1_max =3D bt_const->tseg1_max;
+	dev->bt_const.tseg2_min =3D bt_const->tseg2_min;
+	dev->bt_const.tseg2_max =3D bt_const->tseg2_max;
+	dev->bt_const.sjw_max =3D bt_const->sjw_max;
+	dev->bt_const.brp_min =3D bt_const->brp_min;
+	dev->bt_const.brp_max =3D bt_const->brp_max;
+	dev->bt_const.brp_inc =3D bt_const->brp_inc;
+
+	dev->udev =3D interface_to_usbdev(intf);
+	dev->iface =3D intf;
+	dev->netdev =3D netdev;
+	dev->channel =3D channel;
+
+	init_usb_anchor(&dev->tx_submitted);
+	atomic_set(&dev->active_tx_urbs, 0);
+	spin_lock_init(&dev->tx_ctx_lock);
+	for (rc =3D 0; rc < GS_MAX_TX_URBS; rc++) {
+		dev->tx_context[rc].dev =3D dev;
+		dev->tx_context[rc].echo_id =3D GS_MAX_TX_URBS;
+	}
+
+	/* can settup */
+	dev->can.state =3D CAN_STATE_STOPPED;
+	dev->can.clock.freq =3D bt_const->fclk_can;
+	dev->can.bittiming_const =3D &dev->bt_const;
+	dev->can.do_set_bittiming =3D gs_usb_set_bittiming;
+
+	dev->can.ctrlmode_supported =3D 0;
+
+	if (bt_const->feature & GS_CAN_FEATURE_LISTEN_ONLY)
+		dev->can.ctrlmode_supported |=3D CAN_CTRLMODE_LISTENONLY;
+
+	if (bt_const->feature & GS_CAN_FEATURE_LOOP_BACK)
+		dev->can.ctrlmode_supported |=3D CAN_CTRLMODE_LOOPBACK;
+
+	if (bt_const->feature & GS_CAN_FEATURE_TRIPLE_SAMPLE)
+		dev->can.ctrlmode_supported |=3D CAN_CTRLMODE_3_SAMPLES;
+
+	if (bt_const->feature & GS_CAN_FEATURE_ONE_SHOT)
+		dev->can.ctrlmode_supported |=3D CAN_CTRLMODE_ONE_SHOT;
+
+	kfree(bt_const);
+
+	SET_NETDEV_DEV(netdev, &intf->dev);
+
+	rc =3D register_candev(dev->netdev);
+	if (rc) {
+		free_candev(dev->netdev);
+		dev_err(&intf->dev, "Couldn't register candev\n");
+		return ERR_PTR(rc);
+	}
+
+	return dev;
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
+	const struct usb_device_id *id)
+{
+	struct gs_usb *dev;
+	int rc =3D -ENOMEM;
+	unsigned int icount, i;
+	struct gs_host_config *hconf;
+	struct gs_device_config *dconf;
+
+	hconf =3D kmalloc(sizeof(*hconf), GFP_KERNEL);
+	if (!hconf)
+		return -ENOMEM;
+
+	hconf->byte_order =3D 0x0000beef;
+
+	/* send host config */
+	rc =3D usb_control_msg(interface_to_usbdev(intf),
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
+	dconf =3D kmalloc(sizeof(*dconf), GFP_KERNEL);
+	if (!dconf)
+		return -ENOMEM;
+
+	/* read device config */
+	rc =3D usb_control_msg(interface_to_usbdev(intf),
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
+
+		kfree(dconf);
+
+		return rc;
+	}
+
+	icount =3D dconf->icount+1;
+
+	kfree(dconf);
+
+	dev_info(&intf->dev, "Configuring for %d interfaces\n", icount);
+
+	if (icount > GS_MAX_INTF) {
+		dev_err(&intf->dev,
+			"Driver cannot handle more that %d CAN interfaces\n",
+			GS_MAX_INTF);
+		return -EINVAL;
+	}
+
+	dev =3D kzalloc(sizeof(*dev), GFP_KERNEL);
+	init_usb_anchor(&dev->rx_submitted);
+
+	atomic_set(&dev->active_channels, 0);
+
+	usb_set_intfdata(intf, dev);
+	dev->udev =3D interface_to_usbdev(intf);
+
+	for (i =3D 0; i < icount; i++) {
+		dev->canch[i] =3D gs_make_candev(i, intf);
+		if (IS_ERR_OR_NULL(dev->canch[i])) {
+			/* on failure destroy previously created candevs */
+			icount =3D i;
+			for (i =3D 0; i < icount; i++) {
+				gs_destroy_candev(dev->canch[i]);
+				dev->canch[icount] =3D NULL;
+			}
+			return rc;
+		}
+		dev->canch[i]->parent =3D dev;
+	}
+
+	dev_info(&intf->dev, "Probe\n");
+	return 0;
+}
+
+static void gs_usb_disconnect(struct usb_interface *intf)
+{
+	unsigned i;
+	struct gs_usb *dev =3D usb_get_intfdata(intf);
+	usb_set_intfdata(intf, NULL);
+
+	if (!dev) {
+		dev_err(&intf->dev, "Disconnect (nodata)\n");
+		return;
+	}
+
+	for (i =3D 0; i < GS_MAX_INTF; i++) {
+		struct gs_can *can =3D dev->canch[i];
+
+		if (!can)
+			continue;
+
+		gs_destroy_candev(can);
+	}
+
+	usb_kill_anchored_urbs(&dev->rx_submitted);
+}
+
+MODULE_DEVICE_TABLE(usb, gs_usb_table);
+
+static struct usb_device_id gs_usb_table[] =3D {
+	{USB_DEVICE(USB_GSUSB_1_VENDOR_ID, USB_GSUSB_1_PRODUCT_ID)},
+	{} /* Terminating entry */
+};
+
+static struct usb_driver gs_usb_driver =3D {
+	.name       =3D "gs_usb",
+	.probe      =3D gs_usb_probe,
+	.disconnect =3D gs_usb_disconnect,
+	.id_table   =3D gs_usb_table
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
--=20
1.7.10.4


