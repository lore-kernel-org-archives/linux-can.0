From: "s.grosjean@peak-system.com" <s.grosjean@peak-system.com>
Subject: "[PATCH] Add support for PEAK-System GmbH CAN USB adapters (v2) "
Date: Fri, 16 Dec 2011 10:19:34 +0000
Message-ID: <301939.630738588-sendEmail@ubuntu-i386>
Mime-Version: 1.0
Content-Type: multipart/related; boundary="----MIME delimiter for sendEmail-703319.406676204"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from 4va54-1-87-88-247-106.dsl.sta.abo.bbox.fr ([87.88.247.106]:62710
	"EHLO ubuntu-i386" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932106Ab1LPKSt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 16 Dec 2011 05:18:49 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "socketcan@hartkopp.net" <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is a multi-part message in MIME format. To properly display this message you need a MIME-Version 1.0 compliant Email program.

------MIME delimiter for sendEmail-703319.406676204
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

From 1cee3be3875f27a2ee3942b00d611450f4369325 Mon Sep 17 00:00:00 2001
From: Stephane Grosjean <s.grosjean@peak-system.com>
Date: Fri, 16 Dec 2011 11:11:37 +0100
Subject: [PATCH] Add support for PEAK-System GmbH CAN USB adapters (v2)

v2 includes:
 change dev_xxx() into netdev_xxx() macros
 add missing include linux/module.h
 pre-allocate urbs and buffers for tx path at _open() and free them at _close()
  rather than into _start_xmit()
 remove some unused code and (boring) #ifdef/#endif
 use "menuconfig" in Kconfig rather than "config" entry
---
 drivers/net/can/usb/Kconfig         |   20 +
 drivers/net/can/usb/Makefile        |   12 +
 drivers/net/can/usb/pcan_usb.c      |  654 +++++++++++++++++++
 drivers/net/can/usb/pcan_usb_core.c |  895 ++++++++++++++++++++++++++
 drivers/net/can/usb/pcan_usb_pro.c  | 1207 +++++++++++++++++++++++++++++++++++
 drivers/net/can/usb/pcan_usb_pro.h  |  468 ++++++++++++++
 drivers/net/can/usb/peak_usb.h      |  148 +++++
 7 files changed, 3404 insertions(+), 0 deletions(-)
 create mode 100644 drivers/net/can/usb/pcan_usb.c
 create mode 100644 drivers/net/can/usb/pcan_usb_core.c
 create mode 100644 drivers/net/can/usb/pcan_usb_pro.c
 create mode 100644 drivers/net/can/usb/pcan_usb_pro.h
 create mode 100644 drivers/net/can/usb/peak_usb.h

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index 0452549..cb5f91c 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -13,4 +13,24 @@ config CAN_ESD_USB2
           This driver supports the CAN-USB/2 interface
           from esd electronic system design gmbh (http://www.esd.eu).
 
+menuconfig CAN_PEAK_USB
+	tristate "PEAK-System USB adapters"
+	---help---
+	  This driver is for PCAN USB interfaces from PEAK-System 
+	  (http://www.peak-system.com).
+
+config CAN_PCAN_USB
+	tristate "PEAK PCAN-USB adapter"
+	depends on CAN_PEAK_USB
+	---help---
+	  This driver is for the one channel PCAN-USB interface
+	  from PEAK-System (http://www.peak-system.com).
+
+config CAN_PCAN_USB_PRO
+	tristate "PEAK PCAN-USB Pro adapter"
+	depends on CAN_PEAK_USB
+	---help---
+	  This driver is for the two channels PCAN-USB Pro interface
+	  from PEAK-System (http://www.peak-system.com).
+
 endmenu
diff --git a/drivers/net/can/usb/Makefile b/drivers/net/can/usb/Makefile
index fce3cf1..a6f1cf6 100644
--- a/drivers/net/can/usb/Makefile
+++ b/drivers/net/can/usb/Makefile
@@ -5,4 +5,16 @@
 obj-$(CONFIG_CAN_EMS_USB) += ems_usb.o
 obj-$(CONFIG_CAN_ESD_USB2) += esd_usb2.o
 
+obj-$(CONFIG_CAN_PEAK_USB) += peak_usb.o
+peak_usb-y = pcan_usb_core.o
+
+ifneq ($(CONFIG_CAN_PCAN_USB),)
+peak_usb-y += pcan_usb.o
+endif
+
+ifneq ($(CONFIG_CAN_PCAN_USB_PRO),)
+peak_usb-y += pcan_usb_pro.o
+endif
+
+ccflags-$(CONFIG_CAN_DEBUG_DEVICES) := -DDEBUG
 ccflags-$(CONFIG_CAN_DEBUG_DEVICES) := -DDEBUG
diff --git a/drivers/net/can/usb/pcan_usb.c b/drivers/net/can/usb/pcan_usb.c
new file mode 100644
index 0000000..ec46da6
--- /dev/null
+++ b/drivers/net/can/usb/pcan_usb.c
@@ -0,0 +1,654 @@
+/*
+ * CAN driver for PEAK System PCAN-USB adapter
+ *
+ * Copyright (C) 2011-2012 PEAK-System GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+#include <linux/netdevice.h>
+#include <linux/usb.h>
+#include <linux/module.h>
+
+#include <linux/can.h>
+#include <linux/can/dev.h>
+#include <linux/can/error.h>
+
+#include "peak_usb.h"
+
+MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB adapter");
+
+/* PCAN-USB Endpoints */
+#define PCAN_USB_EP_CMDOUT   1
+#define PCAN_USB_EP_CMDIN    (PCAN_USB_EP_CMDOUT|USB_DIR_IN)
+#define PCAN_USB_EP_MSGOUT   2
+#define PCAN_USB_EP_MSGIN    (PCAN_USB_EP_MSGOUT|USB_DIR_IN)
+
+/* PCAN-USB parameter command */
+#define PCAN_USB_PARAMETER_LEN   14
+struct __packed pcan_usb_parameter {
+	u8 function;
+	u8	number;
+	u8 parameters[PCAN_USB_PARAMETER_LEN];
+};
+
+/* PCAN-USB command timeout (ms.) */
+#define PCAN_USB_COMMAND_TIMEOUT 1000
+
+/* PCAN-USB rx/tx buffers size */
+#define PCAN_USB_RX_BUFFER_SIZE  64
+#define PCAN_USB_TX_BUFFER_SIZE  64
+
+#define PCAN_USB_MSG_HEADER_LEN  2 /* Packet type information (1xbyte) 
+                                    + count of messages (1xbyte) */
+
+/* PCAN-USB adapter internal clock (MHz) */
+#define PCAN_USB_CRYSTAL_HZ      16000000
+
+/* PCAN-USB USB message record status/len field */
+#define PCAN_USB_STATUSLEN_TIMESTAMP (1 << 7)
+#define PCAN_USB_STATUSLEN_INTERNAL  (1 << 6)
+#define PCAN_USB_STATUSLEN_EXT_ID    (1 << 5)
+#define PCAN_USB_STATUSLEN_RTR       (1 << 4)
+#define PCAN_USB_STATUSLEN_DLC       (0xf)
+
+/* PCAN-USB error flags */
+#define PCAN_USB_ERROR_TXFULL    0x01
+#define PCAN_USB_ERROR_RXQOVR    0x02
+#define PCAN_USB_ERROR_BUS_LIGHT 0x04
+#define PCAN_USB_ERROR_BUS_HEAVY 0x08
+#define PCAN_USB_ERROR_BUS_OFF   0x10
+#define PCAN_USB_ERROR_RXQEMPTY  0x20
+#define PCAN_USB_ERROR_QOVR      0x40
+#define PCAN_USB_ERROR_TXQFULL   0x80
+
+/* SJA1000 modes */
+#define SJA1000_MODE_NORMAL 0x00
+#define SJA1000_MODE_INIT   0x01
+
+/* tick duration = 42.666 us => 
+ * (tick_number * 44739243) >> 20 ~ (tick_number * 42666) / 1000
+ *  accuracy = 10^-7
+ */
+#define PCAN_USB_TS_DIV_SHIFTER        20
+#define PCAN_USB_TS_US_PER_TICK        44739243
+
+struct pcan_usb {
+	struct peak_usb_device pcandev; /* must be the first member */
+	struct peak_time_ref time_ref;
+};
+
+/*
+ * Send the given PCAN-USB command synchronously
+ */
+static int pcan_usb_send_command(struct peak_usb_device *dev, u8 f, u8 n, u8 *p)
+{
+	int actual_length;
+	struct pcan_usb_parameter cmd;
+	int err;
+
+	/* usb device unregistered? */
+	if (!(dev->state & PCAN_USB_STATE_CONNECTED)) return 0;
+
+	cmd.function = f;
+	cmd.number = n;
+
+	if (p != NULL)
+		memcpy(&cmd.parameters[0], p, PCAN_USB_PARAMETER_LEN);
+	else
+		memset(&cmd.parameters[0], '\0', PCAN_USB_PARAMETER_LEN);
+
+	err = usb_bulk_msg(dev->udev, 
+	                   usb_sndbulkpipe(dev->udev, PCAN_USB_EP_CMDOUT),
+	                   &cmd, sizeof(struct pcan_usb_parameter),
+	                   &actual_length, PCAN_USB_COMMAND_TIMEOUT);
+	if (err) 
+		netdev_err(dev->netdev, 
+		           "sending command function=0x%x number=0x%x failure: %d\n",
+		           f, n, err);
+
+	return err;
+}
+
+static int pcan_usb_wait_response(struct peak_usb_device *dev, u8 f, u8 n, u8 *p)
+{
+	int actual_length;
+	struct pcan_usb_parameter cmd;
+	int err;
+
+	/* usb device unregistered? */
+	if (!(dev->state & PCAN_USB_STATE_CONNECTED)) return 0;
+
+	/* first, send command */
+	err = pcan_usb_send_command(dev, f, n, NULL);
+	if (err) {
+		return err;
+	}
+
+	cmd.function = f;
+	cmd.number = n;
+	memset(&cmd.parameters[0], '\0', PCAN_USB_PARAMETER_LEN);
+
+	/* then, wait for the response */
+	mdelay(5);
+	err = usb_bulk_msg(dev->udev, 
+	                   usb_rcvbulkpipe(dev->udev, PCAN_USB_EP_CMDIN),
+	                   &cmd, sizeof(struct pcan_usb_parameter),
+	                   &actual_length, PCAN_USB_COMMAND_TIMEOUT);
+	if (err)
+		netdev_err(dev->netdev, 
+		           "waiting response function=0x%x number=0x%x failure: %d\n",
+		           f, n, err);
+	else if (p) memcpy(p, &cmd.parameters[0], PCAN_USB_PARAMETER_LEN);
+
+	return err;
+}
+
+static int pcan_usb_set_sja1000(struct peak_usb_device *dev, u8 mode)
+{
+	u8 args[PCAN_USB_PARAMETER_LEN];
+
+	args[0] = 0;
+	args[1] = mode;
+	return pcan_usb_send_command(dev, 9, 2, args);
+}
+
+static int pcan_usb_set_bus(struct peak_usb_device *dev, u8 onoff)
+{
+	u8 args[PCAN_USB_PARAMETER_LEN];
+
+	args[0] = onoff ? 1 : 0;
+	return pcan_usb_send_command(dev, 3, 2, args);
+}
+
+static int pcan_usb_set_silent(struct peak_usb_device *dev, u8 onoff)
+{
+	u8 args[PCAN_USB_PARAMETER_LEN];
+
+	args[0] = onoff ? 1 : 0;
+	return pcan_usb_send_command(dev, 3, 3, args);
+}
+
+static int pcan_usb_set_ext_vcc(struct peak_usb_device *dev, u8 onoff)
+{
+	u8 args[PCAN_USB_PARAMETER_LEN];
+
+	args[0] = onoff ? 1 : 0;
+	return pcan_usb_send_command(dev, 10, 2, args);
+}
+
+/*
+ * This routine was stolen from drivers/net/can/sja1000/sja1000.c
+ */
+static int pcan_usb_set_bittiming(struct peak_usb_device *dev, struct can_bittiming *bt)
+{
+	u8 args[PCAN_USB_PARAMETER_LEN];
+	u8 btr0, btr1;
+
+	btr0 = ((bt->brp - 1) & 0x3f) | (((bt->sjw - 1) & 0x3) << 6);
+	btr1 = ((bt->prop_seg + bt->phase_seg1 - 1) & 0xf) \
+	     | (((bt->phase_seg2 - 1) & 0x7) << 4);
+	if (dev->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
+		btr1 |= 0x80;
+
+	args[0] = btr1;
+	args[1] = btr0;
+
+	printk("btr0=0x%02x btr1=0x%02x", btr0, btr1);
+
+	return pcan_usb_send_command(dev, 1, 2, args);
+}
+
+static int pcan_usb_write_mode(struct peak_usb_device *dev, u8 onoff)
+{
+	int err;
+
+	err = pcan_usb_set_bus(dev, onoff);
+	if (err) 
+		return err;
+
+	if (!onoff) {
+		err = pcan_usb_set_sja1000(dev, SJA1000_MODE_INIT);
+	}
+
+	return err;
+}
+
+static int pcan_usb_get_serial_number(struct peak_usb_device *dev, u32 *serial_number)
+{
+	u8 args[PCAN_USB_PARAMETER_LEN];
+	int err;
+
+	err = pcan_usb_wait_response(dev, 6, 1, args);
+	if (err) 
+		netdev_err(dev->netdev, "getting serial number failure: %d\n", err);
+	else {
+		if (serial_number) memcpy(serial_number, &args[0], 4);
+	}
+
+	return err;
+}
+
+static int pcan_usb_get_device_number(struct peak_usb_device *dev, u32 *device_number)
+{
+	u8 args[PCAN_USB_PARAMETER_LEN];
+	int err;
+
+	err = pcan_usb_wait_response(dev, 4, 1, args);
+	if (err) 
+		netdev_err(dev->netdev, "getting device number failure: %d\n", err);
+	else {
+		if (device_number) *device_number = args[0];
+	}
+
+	return err;
+}
+
+static void pcan_usb_update_time_word(struct pcan_usb *pdev, u16 ts16, u8 s)
+{
+
+	if (s == 0)
+		peak_usb_set_timestamp_now(&pdev->time_ref, ts16);
+	else 
+		peak_usb_update_timestamp_now(&pdev->time_ref, ts16);
+}
+
+/*
+ * callback for bulk IN urb
+ */
+static int pcan_usb_decode_msg(struct peak_usb_device *dev, struct urb *urb)
+{
+	struct pcan_usb *pdev = (struct pcan_usb *)dev;
+	struct net_device *netdev = dev->netdev;
+	int err = 0;
+
+	if (urb->actual_length > PCAN_USB_MSG_HEADER_LEN) {
+		struct net_device_stats *stats = &netdev->stats;
+
+		u8 *ibuf = urb->transfer_buffer;
+		const u8 msg_count = ibuf[1];
+		int frm_count = 0;
+		u8 i;
+
+		ibuf += PCAN_USB_MSG_HEADER_LEN;
+
+		for (i = 0; i < msg_count && !err; i++) {
+
+			struct sk_buff *skb;
+			struct can_frame *cf;
+			struct timeval tv;
+			u16 tmp16, ts16=0, dts=0, prev_ts8=0;
+			u8 sl = *ibuf++;
+			u8 rec_len = (sl & PCAN_USB_STATUSLEN_DLC);
+
+			/* handle error frames here */
+			if (sl & PCAN_USB_STATUSLEN_INTERNAL) {
+				u8 f = *ibuf++;
+				u8 n = *ibuf++;
+
+				if (sl & PCAN_USB_STATUSLEN_TIMESTAMP) {
+					/* only the first packet supplies a word timestamp */
+					if (i == 0) {
+						memcpy(&tmp16, ibuf, 2);
+						ibuf += 2;
+						ts16 = le16_to_cpu(tmp16);
+						dts = 0;
+					}
+					else {
+						u8 ts8 = *ibuf++;
+
+						if (dts) {
+							dts &= 0xff00;
+							if (ts8 < prev_ts8)
+								dts += 0x100;
+						}
+
+						dts |= ts8;
+						prev_ts8 = ts8;
+
+					}
+				}
+
+				switch (f) {
+
+				case 1:
+
+					/* allocate an skb to store the error frame */
+					skb = alloc_can_err_skb(netdev, &cf);
+					if (skb == NULL) {
+						err = -ENOMEM;
+						break;
+					}
+
+					if (n & (PCAN_USB_ERROR_RXQOVR|PCAN_USB_ERROR_QOVR)) {
+						cf->can_id |= CAN_ERR_CRTL;
+						cf->data[1] |= CAN_ERR_CRTL_RX_OVERFLOW;
+						stats->rx_over_errors++;
+						stats->rx_errors++;
+					}
+					if (n & PCAN_USB_ERROR_BUS_OFF) {
+						cf->can_id |= CAN_ERR_BUSOFF;
+						can_bus_off(netdev);
+					}
+					if (n & PCAN_USB_ERROR_BUS_HEAVY) {
+						cf->can_id |= CAN_ERR_CRTL;
+						cf->data[1] |= CAN_ERR_CRTL_RX_PASSIVE;
+						dev->can.can_stats.error_passive++;
+					}
+					if (n & PCAN_USB_ERROR_BUS_LIGHT) {
+						cf->can_id |= CAN_ERR_CRTL;
+						cf->data[1] |= CAN_ERR_CRTL_RX_WARNING;
+						dev->can.can_stats.error_warning++;
+					}
+
+					if (cf->can_id != CAN_ERR_FLAG) {
+						if (sl & PCAN_USB_STATUSLEN_TIMESTAMP) {
+							peak_usb_get_timestamp_tv(&pdev->time_ref, ts16+dts, &tv);
+							skb->tstamp = timeval_to_ktime(tv);
+						}
+						netif_rx(skb);
+						stats->rx_packets++;
+					}
+
+					/* v3: sometimes the telegram carries 3 additional data */
+					/* without note in ucStatusLen. */
+					ibuf += rec_len;
+					break;
+
+				case 2:
+					/* analog values (ignored) */
+					ibuf += 2;
+					break;
+
+				case 3:
+					/* bus load (ignored) */
+					ibuf++;
+					break;
+
+				case 4:
+					/* only timestamp */
+					memcpy(&tmp16, ibuf, 2);
+					ibuf += 2;
+					ts16 = le16_to_cpu(tmp16);
+					pcan_usb_update_time_word(pdev, ts16, i);
+					break;
+
+				case 5:
+					/* error frame/bus event */
+					if (n & PCAN_USB_ERROR_TXQFULL) {
+						netdev_info(netdev, "device Tx queue full)\n");
+					}
+					ibuf += rec_len;
+					break;
+
+				case 10:
+					/* future... */
+					break;
+
+				default:
+					netdev_err(netdev, "unexpected function %u\n", f);
+					break;
+				}
+			}
+
+			/* handle normal can frames here */
+			else {
+
+				u8 d = 0;
+
+				skb = alloc_can_skb(netdev, &cf);
+				if (skb == NULL) {
+					err = -ENOMEM;
+					break;
+				}
+
+				if (sl & PCAN_USB_STATUSLEN_EXT_ID) {
+					u32 tmp32;
+					memcpy(&tmp32, ibuf, 4);
+					ibuf += 4;
+					cf->can_id = le32_to_cpu(tmp32 >> 3) | CAN_EFF_FLAG;
+				}
+				else {
+					memcpy(&tmp16, ibuf, 2);
+					ibuf += 2;
+					cf->can_id = le16_to_cpu(tmp16 >> 5);
+				}
+
+				cf->can_dlc = get_can_dlc(rec_len);
+
+				/* first data packet timestamp is a word */
+				if (!frm_count++) {
+					memcpy(&tmp16, ibuf, 2);
+					ibuf += 2;
+					ts16 = le16_to_cpu(tmp16);
+					dts = 0;
+				}
+				else {
+					u8 ts8 = *ibuf++;
+
+					if (dts) {
+						dts &= 0xff00;
+						if (ts8 < prev_ts8)
+							dts += 0x100;
+					}
+
+					dts |= ts8;
+					prev_ts8 = ts8;
+
+				}
+
+				/* read data */
+				if (sl & PCAN_USB_STATUSLEN_RTR) {
+					cf->can_id |= CAN_RTR_FLAG;
+				}
+				else {
+					for (; d < rec_len; d++)
+						cf->data[d] = *ibuf++;
+				}
+
+				for (; d < 8; d++) {
+					cf->data[d] = 0;
+				}
+
+				peak_usb_get_timestamp_tv(&pdev->time_ref, ts16+dts, &tv);
+				skb->tstamp = timeval_to_ktime(tv);
+				netif_rx(skb);
+
+				stats->rx_packets++;
+				stats->rx_bytes += cf->can_dlc;
+			}
+
+			if ((ibuf - (u8 *)urb->transfer_buffer) > urb->transfer_buffer_length) {
+				netdev_err(netdev, "usb message format error\n");
+				err = -EINVAL;
+				break;
+			}
+		}
+	}
+	else if (urb->actual_length > 0) {
+		netdev_err(netdev, "usb message length error (%u)\n", urb->actual_length);
+		err = -EINVAL;
+	}
+
+	return err;
+}
+
+static int pcan_usb_encode_msg(struct peak_usb_device *dev, struct sk_buff *skb, u8 *obuf, size_t *size)
+{
+	struct net_device *netdev = dev->netdev;
+	struct net_device_stats *stats = &netdev->stats;
+	struct can_frame *cf = (struct can_frame *)skb->data;
+	u8 *pc;
+
+	obuf[0] = 2;
+	obuf[1] = 1;
+
+	pc = &obuf[PCAN_USB_MSG_HEADER_LEN];
+
+	/* status/len byte */
+	*pc = cf->can_dlc;
+	if (cf->can_id & CAN_RTR_FLAG) 
+		*pc |= PCAN_USB_STATUSLEN_RTR;
+	
+	/* can id */
+	if (cf->can_id & CAN_EFF_FLAG) {
+		u32 tmp32 = cpu_to_le32(cf->can_id & CAN_ERR_MASK);
+		tmp32 <<= 3;
+		*pc |= PCAN_USB_STATUSLEN_EXT_ID;
+		memcpy(++pc, &tmp32, 4);
+		pc += 4;
+	}
+	else {
+		u16 tmp16 = (u16 )cpu_to_le32(cf->can_id & CAN_ERR_MASK);
+		tmp16 <<= 5;
+		memcpy(++pc, &tmp16, 2);
+		pc += 2;
+	}
+
+	/* can data */
+	if ((cf->can_id & CAN_RTR_FLAG) == 0) {
+		memcpy(pc, &cf->data[0], cf->can_dlc);
+		pc += cf->can_dlc;
+	}
+
+	/* Hmm... pcan driver sets the count of messages sent in the last byte... */
+	obuf[(*size)-1] = (u8 )(stats->tx_packets & 0xff);
+
+	return 0;
+}
+
+/*
+ * Start interface
+ */
+static int pcan_usb_start(struct peak_usb_device *dev)
+{
+	struct pcan_usb *pdev = (struct pcan_usb *)dev; 
+	int err;
+
+	/* number of bits used in timestamps read from adapter struct */
+	peak_usb_init_time_ref(&pdev->time_ref, &pcan_usb);
+
+	/* If revision greater than 3, can put silent mode on/off*/
+	if (dev->device_rev > 3) {
+	
+		err = pcan_usb_set_silent(dev, 
+		                          (dev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY));
+		if (err)
+			goto failed;
+	}
+
+	err = pcan_usb_set_ext_vcc(dev, 0);
+	if (err)
+		goto failed;
+
+	return 0;
+
+failed:
+
+	return err;
+}
+
+static int pcan_usb_init(struct peak_usb_device *dev)
+{
+	u32 serial_number;
+	int err;
+
+	err = pcan_usb_get_serial_number(dev, &serial_number);
+	if (!err)
+		netdev_info(dev->netdev, "serial %08X\n", serial_number);
+
+	return err;
+}
+
+/*
+ * probe function for new PCAN-USB usb interface
+ */
+static int pcan_usb_probe(struct usb_interface *intf)
+{
+	struct usb_host_interface *iface_desc;
+	int i;
+
+	/* check endpoint addresses (numbers) and associated max data length */
+	/* (only from setting 0) */
+	iface_desc = &intf->altsetting[0];
+
+	/* check interface endpoint addresses */
+	for (i = 0; i < iface_desc->desc.bNumEndpoints; i++) {
+		struct usb_endpoint_descriptor *endpoint = &iface_desc->endpoint[i].desc;
+
+		/* Below is the list of valid ep addreses. All other ep address */
+		/* is considered as not-CAN interface address => no dev created */
+		switch (endpoint->bEndpointAddress) {
+		case PCAN_USB_EP_CMDOUT:
+		case PCAN_USB_EP_CMDIN:
+		case PCAN_USB_EP_MSGOUT:
+		case PCAN_USB_EP_MSGIN:
+			break;
+		default:
+			return -ENODEV;
+		}
+	}
+ 
+	return 0;
+}
+
+/* 
+ * Describe the PCAN-USB adapter 
+ */
+struct peak_usb_adapter pcan_usb = {
+	.name = "PCAN-USB",
+	.device_id = PCAN_USB_PRODUCT_ID,
+	.ctrl_count = 1,
+	.clock = {
+		.freq = PCAN_USB_CRYSTAL_HZ/2,
+	},
+	.bittiming_const = {
+		.name = "pcan_usb",
+		.tseg1_min = 1,
+		.tseg1_max = 16,
+		.tseg2_min = 1,
+		.tseg2_max = 8,
+		.sjw_max = 4,
+		.brp_min = 1,
+		.brp_max = 64,
+		.brp_inc = 1,
+	},
+
+	/* size of device private data */
+	.sizeof_dev_private = sizeof(struct pcan_usb),
+	
+	/* timestamps usage */
+	.ts_used_bits = 16,
+	.ts_period = 24575, /* calibration period in ts. */
+	.us_per_ts_scale = PCAN_USB_TS_US_PER_TICK, /* us = (ts * scale) >> shift */
+	.us_per_ts_shift = PCAN_USB_TS_DIV_SHIFTER,
+
+	/* give here commands/messages in/out endpoints */
+	.ep_msg_in = PCAN_USB_EP_MSGIN,
+	.ep_msg_out = {PCAN_USB_EP_MSGOUT},
+
+	/* size of rx/tx usb buffers */
+	.rx_buffer_size = PCAN_USB_RX_BUFFER_SIZE,
+	.tx_buffer_size = PCAN_USB_TX_BUFFER_SIZE,
+
+	/* device callbacks */
+	.intf_probe = pcan_usb_probe,
+	.device_init = pcan_usb_init,
+	.device_set_bus = pcan_usb_write_mode,
+	.device_set_bittiming = pcan_usb_set_bittiming,
+	.device_get_device_number = pcan_usb_get_device_number,
+	.device_decode_msg = pcan_usb_decode_msg,
+	.device_encode_msg = pcan_usb_encode_msg,
+	.device_start = pcan_usb_start,
+};
+
diff --git a/drivers/net/can/usb/pcan_usb_core.c b/drivers/net/can/usb/pcan_usb_core.c
new file mode 100644
index 0000000..745f3c9
--- /dev/null
+++ b/drivers/net/can/usb/pcan_usb_core.c
@@ -0,0 +1,895 @@
+/*
+ * CAN driver for PEAK System USB adapters
+ *
+ * Copyright (C) 2011-2012 PEAK-System GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+#include <linux/init.h>
+#include <linux/signal.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/usb.h>
+#include <linux/stringify.h>
+
+#include <linux/can.h>
+#include <linux/can/dev.h>
+#include <linux/can/error.h>
+
+#include "peak_usb.h"
+
+#define PCAN_USB_VERSION_STRING        __stringify(PCAN_USB_VERSION_MAJOR)"."\
+                                       __stringify(PCAN_USB_VERSION_MINOR)"."\
+                                       __stringify(PCAN_USB_VERSION_SUBMINOR) 
+
+MODULE_AUTHOR("Stephane Grosjean <s.grosjean@peak-system.com>");
+MODULE_DESCRIPTION("CAN driver for PEAK-System USB adapters");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION(PCAN_USB_VERSION_STRING); /* cat /sys/module/DRV_NAME/version */
+
+/*
+ * Table of devices that work with this driver
+ */
+static struct usb_device_id peak_usb_table[] = {
+#ifdef PCAN_USB_PRODUCT_ID
+	{USB_DEVICE(PCAN_USB_VENDOR_ID, PCAN_USB_PRODUCT_ID)},
+#endif
+#ifdef PCAN_USBPRO_PRODUCT_ID
+	{USB_DEVICE(PCAN_USB_VENDOR_ID, PCAN_USBPRO_PRODUCT_ID)},
+#endif
+	{} /* Terminating entry */
+};
+
+MODULE_DEVICE_TABLE(usb, peak_usb_table);
+
+/* List of supported PCAN-USB adapters (NULL terminated list) */
+static struct peak_usb_adapter *peak_usb_adapters_list[] = {
+#ifdef PCAN_USB_PRODUCT_ID
+	&pcan_usb,
+#endif
+#ifdef PCAN_USBPRO_PRODUCT_ID
+	&pcan_usb_pro,
+#endif
+	NULL,
+};
+
+/*
+ * Dump memory
+ */
+void dump_mem(char *prompt, void *p, int l)
+{
+#ifdef DEBUG
+	char *kern = KERN_DEBUG;
+#else
+	char *kern = KERN_INFO;
+#endif
+	u8 *pc = (u8 *)p;
+	int i;
+
+	printk("%s%s: dumping %s (%d bytes):\n", kern, 
+	       PCAN_USB_DRIVER_NAME, prompt?prompt:"memory", l);
+	for (i = 0; i < l; ) {
+		if ((i % 16) == 0) printk("%s%s ", kern, PCAN_USB_DRIVER_NAME);
+		printk("%02X ", *pc++);
+		if ((++i % 16) == 0) printk("\n");
+	}
+	if (i % 16) printk("\n");
+}
+
+/*
+ * used to simulate no device
+ */
+int peak_usb_no_dev(struct usb_interface *intf)
+{
+   return -ENODEV;
+}
+
+static void peak_usb_add_us(struct timeval *tv, u32 delta_us)
+{
+	/* number of s. to add to final time */
+	u32 delta_s = delta_us / 1000000;
+	delta_us -= (delta_s * 1000000);
+
+	tv->tv_usec += delta_us;
+	if (tv->tv_usec >= 1000000) {
+		tv->tv_usec -= 1000000;
+		delta_s++;
+	}
+	tv->tv_sec += delta_s;
+}
+
+/*
+ * sometimes, another now may be  more recent than current one...
+ */
+void peak_usb_update_timestamp_now(struct peak_time_ref *time_ref, u32 ts_now)
+{
+	time_ref->ts_dev_2 = ts_now;
+
+	/* should wait at least two passes before computing */
+	if (time_ref->tv_host.tv_sec > 0) {
+
+		u32 delta_ts = time_ref->ts_dev_2 - time_ref->ts_dev_1;
+		if (time_ref->ts_dev_2 < time_ref->ts_dev_1) 
+			delta_ts &= (1 << time_ref->adapter->ts_used_bits) - 1;
+
+		time_ref->ts_total += delta_ts;
+
+	}
+}
+
+/*
+ * initialize a time_ref object with usb adapter own settings
+ */
+void peak_usb_init_time_ref(struct peak_time_ref *time_ref, struct peak_usb_adapter *adapter)
+{
+	if (time_ref) {
+		memset(time_ref, '\0', sizeof(struct peak_time_ref));
+		time_ref->adapter = adapter;
+	}
+}
+
+/*
+ * register device timestamp as now
+ */
+void peak_usb_set_timestamp_now(struct peak_time_ref *time_ref, u32 ts_now)
+{
+	if (time_ref->tv_host_0.tv_sec == 0) {
+		do_gettimeofday(&time_ref->tv_host_0);
+		time_ref->tv_host.tv_sec = 0;
+	}
+	else {
+
+		/* delta_us should not be >= 2^32  => delta_s should be < 4294 */
+		/* handle 32-bits wrapping here: if number of s. reaches 4200, */
+		/* reset counters and change time base */
+		if (time_ref->tv_host.tv_sec != 0) {
+			u32 delta_s = time_ref->tv_host.tv_sec - time_ref->tv_host_0.tv_sec;
+			if (delta_s > 4200) {
+				time_ref->tv_host_0 = time_ref->tv_host;	
+				time_ref->ts_total = 0;
+			}
+		}
+
+		do_gettimeofday(&time_ref->tv_host);
+		time_ref->tick_count++;
+	}
+
+	time_ref->ts_dev_1 = time_ref->ts_dev_2;
+	peak_usb_update_timestamp_now(time_ref, ts_now);
+}
+
+/*
+ * compute timeval according to current ts and time_ref data
+ */
+void peak_usb_get_timestamp_tv(struct peak_time_ref *time_ref, u32 ts, struct timeval *tv)
+{
+	/* protect from getting timeval before setting now */
+	if (time_ref->tv_host.tv_sec > 0) {
+		u64 delta_us;
+
+		delta_us = ts - time_ref->ts_dev_2;
+		if (ts < time_ref->ts_dev_2) 
+			delta_us &= (1 << time_ref->adapter->ts_used_bits) - 1;
+	
+		delta_us += time_ref->ts_total;
+	
+		delta_us *= time_ref->adapter->us_per_ts_scale;
+		delta_us >>= time_ref->adapter->us_per_ts_shift;
+		
+		*tv = time_ref->tv_host_0;
+		peak_usb_add_us(tv, (u32 )delta_us);
+
+	}
+	else do_gettimeofday(tv);
+}
+
+/*
+ * callback for bulk IN urb
+ */
+static void peak_usb_read_bulk_callback(struct urb *urb)
+{
+	struct peak_usb_device *dev = urb->context;
+	struct net_device *netdev;
+	int err;
+
+	netdev = dev->netdev;
+
+	if (!netif_device_present(netdev))
+		return;
+
+	switch (urb->status) {
+	case 0: /* success */
+		break;
+
+	case -ENOENT:
+	case -ESHUTDOWN:
+		return;
+
+	default:
+		netdev_info(netdev, "Rx URB aborted (%d)\n", urb->status);
+		goto resubmit_urb;
+	}
+
+	/* protect from some incoming empty msgs */
+	if (urb->actual_length > 0) {
+		if (dev->adapter->device_decode_msg) {
+			err = dev->adapter->device_decode_msg(dev, urb);
+			if (err) {
+				dump_mem("received usb message", 
+				         urb->transfer_buffer, urb->transfer_buffer_length);
+			}
+		}
+	}
+
+resubmit_urb:
+	usb_fill_bulk_urb(urb, dev->udev, 
+	                  usb_rcvbulkpipe(dev->udev, dev->ep_msg_in),
+	                  urb->transfer_buffer, dev->adapter->rx_buffer_size,
+	                  peak_usb_read_bulk_callback, dev);
+
+	err = usb_submit_urb(urb, GFP_ATOMIC);
+
+	if (err == -ENODEV)
+		netif_device_detach(netdev);
+	else if (err)
+		netdev_err(netdev, "failed resubmitting read bulk urb: %d\n", err);
+}
+
+/*
+ * callback for bulk OUT urb
+ */
+static void peak_usb_write_bulk_callback(struct urb *urb)
+{
+	struct peak_tx_urb_context *context = urb->context;
+	struct peak_usb_device *dev;
+	struct net_device *netdev;
+
+	BUG_ON(!context);
+
+	dev = context->dev;
+	netdev = dev->netdev;
+
+	atomic_dec(&dev->active_tx_urbs);
+
+	if (!netif_device_present(netdev))
+		return;
+
+	if (urb->status)
+		netdev_info(netdev, "Tx URB aborted (%d)\n", urb->status);
+
+	netdev->trans_start = jiffies;
+
+	/* transmission complete interrupt */
+	netdev->stats.tx_packets++;
+	netdev->stats.tx_bytes += context->dlc;
+
+	can_get_echo_skb(netdev, context->echo_index);
+
+	/* Release context */
+	context->echo_index = PCAN_USB_MAX_TX_URBS;
+
+	if (netif_queue_stopped(netdev))
+		netif_wake_queue(netdev);
+}
+
+static void peak_usb_unlink_all_urbs(struct peak_usb_device *dev)
+{
+	int i;
+
+	usb_kill_anchored_urbs(&dev->rx_submitted);
+
+	usb_kill_anchored_urbs(&dev->tx_submitted);
+	atomic_set(&dev->active_tx_urbs, 0);
+
+	for (i = 0; i < PCAN_USB_MAX_TX_URBS; i++) {
+		struct urb *urb = dev->tx_contexts[i].urb;
+
+		if (urb) {
+			if (urb->transfer_buffer) {
+				usb_free_coherent(urb->dev, urb->transfer_buffer_length,
+			                  urb->transfer_buffer, urb->transfer_dma);
+			}
+			usb_free_urb(urb);
+			dev->tx_contexts[i].urb = NULL;
+		}
+		dev->tx_contexts[i].echo_index = PCAN_USB_MAX_TX_URBS;
+	}
+}
+
+/*
+ * Start interface
+ */
+static int peak_usb_start(struct peak_usb_device *dev)
+{
+	struct net_device *netdev = dev->netdev;
+	int err, i;
+
+	for (i = 0; i < PCAN_USB_MAX_RX_URBS; i++) {
+		struct urb *urb = NULL;
+		u8 *buf = NULL;
+
+		/* create a URB, and a buffer for it, to receive usb messages */
+		urb = usb_alloc_urb(0, GFP_KERNEL);
+		if (!urb) {
+			netdev_err(netdev, "No memory left for URBs\n");
+			return -ENOMEM;
+		}
+
+		buf = usb_alloc_coherent(dev->udev, dev->adapter->rx_buffer_size, 
+		                         GFP_KERNEL, &urb->transfer_dma);
+		if (!buf) {
+			netdev_err(netdev, "No memory left for USB buffer\n");
+			usb_free_urb(urb);
+			return -ENOMEM;
+		}
+
+		usb_fill_bulk_urb(urb, dev->udev, 
+		                  usb_rcvbulkpipe(dev->udev, dev->ep_msg_in),
+		                  buf, dev->adapter->rx_buffer_size,
+		                  peak_usb_read_bulk_callback, dev);
+		urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+		usb_anchor_urb(urb, &dev->rx_submitted);
+
+		err = usb_submit_urb(urb, GFP_KERNEL);
+		if (err) {
+			if (err == -ENODEV)
+				netif_device_detach(dev->netdev);
+
+			usb_unanchor_urb(urb);
+			usb_free_coherent(dev->udev, dev->adapter->rx_buffer_size, buf,
+					  urb->transfer_dma);
+			break;
+		}
+
+		/* Drop reference, USB core will take care of freeing it */
+		usb_free_urb(urb);
+	}
+
+	/* Did we submit any URBs */
+	if (i == 0) {
+		netdev_warn(netdev, "couldn't setup read URBs\n");
+		return err;
+	}
+
+	/* Warn if we've couldn't transmit all the URBs */
+	if (i < PCAN_USB_MAX_RX_URBS)
+		netdev_warn(netdev, "rx performance may be slow\n");
+
+	/* Pre-alloc tx buffers and corresponding urbs */
+	for (i = 0; i < PCAN_USB_MAX_TX_URBS; i++) {
+		 struct peak_tx_urb_context *context;
+		struct urb *urb = NULL;
+		u8 *buf = NULL;
+
+		/* create a URB, and a buffer for it, to trsmit usb messages */
+		urb = usb_alloc_urb(0, GFP_KERNEL);
+		if (!urb) {
+			netdev_err(netdev, "No memory left for URBs\n");
+			return -ENOMEM;
+		}
+
+		buf = usb_alloc_coherent(dev->udev, dev->adapter->tx_buffer_size, 
+		                         GFP_KERNEL, &urb->transfer_dma);
+		if (!buf) {
+			netdev_err(netdev, "No memory left for USB buffer\n");
+			usb_free_urb(urb);
+			return -ENOMEM;
+		}
+
+		context = &dev->tx_contexts[i];
+		context->dev = dev;
+		context->urb = urb;
+
+		usb_fill_bulk_urb(urb, dev->udev, 
+		                  usb_sndbulkpipe(dev->udev, dev->ep_msg_out),
+		                  buf, dev->adapter->tx_buffer_size,
+		                  peak_usb_write_bulk_callback, context);
+		urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+	}
+
+	/* Warn if we've couldn't transmit all the URBs */
+	if (i < PCAN_USB_MAX_TX_URBS)
+		netdev_warn(netdev, "tx performance may be slow\n");
+
+	if (dev->adapter->device_start) {
+		err = dev->adapter->device_start(dev);
+		if (err)
+			goto failed;
+	}
+
+	/* can set bus on now */
+	if (dev->adapter->device_set_bus) {
+		err = dev->adapter->device_set_bus(dev, 1);
+		if (err) 
+			goto failed;
+	}
+
+	dev->can.state = CAN_STATE_ERROR_ACTIVE;
+
+	return 0;
+
+failed:
+	if (err == -ENODEV)
+		netif_device_detach(dev->netdev);
+
+	netdev_warn(netdev, "couldn't submit control: %d\n", err);
+
+	return err;
+}
+
+
+static netdev_tx_t peak_usb_ndo_start_xmit(struct sk_buff *skb, struct net_device *netdev)
+{
+	struct peak_usb_device *dev = netdev_priv(netdev);
+	struct peak_tx_urb_context *context = NULL;
+	struct net_device_stats *stats = &netdev->stats;
+	struct can_frame *cf = (struct can_frame *)skb->data;
+	struct urb *urb;
+	u8 *obuf;
+	int i, err;
+	size_t size = dev->adapter->tx_buffer_size;
+
+	if (can_dropped_invalid_skb(netdev, skb))
+		return NETDEV_TX_OK;
+
+	if (!dev->adapter->device_encode_msg) 
+		return NETDEV_TX_OK;
+
+	for (i = 0; i < PCAN_USB_MAX_TX_URBS; i++) {
+		if (dev->tx_contexts[i].echo_index == PCAN_USB_MAX_TX_URBS) {
+			context = &dev->tx_contexts[i];
+			break;
+		}
+	}
+
+	if (!context) {
+		netdev_warn(netdev, "couldn't find free context\n");
+		return NETDEV_TX_BUSY;
+	}
+
+	urb = context->urb;
+	obuf = urb->transfer_buffer;
+	context->echo_index = i;
+	context->dlc = cf->can_dlc;
+
+	err = dev->adapter->device_encode_msg(dev, skb, obuf, &size);	
+	if (err) 
+		goto nomem;
+
+	usb_anchor_urb(urb, &dev->tx_submitted);
+
+	can_put_echo_skb(skb, netdev, context->echo_index);
+
+	atomic_inc(&dev->active_tx_urbs);
+
+	err = usb_submit_urb(urb, GFP_ATOMIC);
+	if (unlikely(err)) {
+		can_free_echo_skb(netdev, context->echo_index);
+
+		usb_unanchor_urb(urb);
+		dev_kfree_skb(skb);
+
+		atomic_dec(&dev->active_tx_urbs);
+
+		if (err == -ENODEV) {
+			netif_device_detach(netdev);
+		} else {
+			netdev_warn(netdev, "failed tx_urb %d\n", err);
+
+			stats->tx_dropped++;
+		}
+	} else {
+		netdev->trans_start = jiffies;
+
+		/* Slow down tx path */
+		if (atomic_read(&dev->active_tx_urbs) >= PCAN_USB_MAX_TX_URBS) {
+			netif_stop_queue(netdev);
+		}
+	}
+
+	return NETDEV_TX_OK;
+
+nomem:
+	netdev_err(netdev, "Packet dropped\n");
+	dev_kfree_skb(skb);
+	stats->tx_dropped++;
+
+	return NETDEV_TX_OK;
+}
+
+static int peak_usb_ndo_open(struct net_device *netdev)
+{
+	struct peak_usb_device *dev = netdev_priv(netdev);
+	int err;
+
+	/* common open */
+	err = open_candev(netdev);
+	if (err)
+		return err;
+
+	/* finally start device */
+	err = peak_usb_start(dev);
+	if (err) {
+		if (err == -ENODEV)
+			netif_device_detach(dev->netdev);
+
+		netdev_warn(netdev, "couldn't start device: %d\n", err);
+
+		close_candev(netdev);
+
+		return err;
+	}
+
+	dev->open_time = jiffies;
+
+	netif_start_queue(netdev);
+
+	return 0;
+}
+
+static int peak_usb_ndo_stop(struct net_device *netdev)
+{
+	struct peak_usb_device *dev = netdev_priv(netdev);
+
+	/* Stop polling */
+	peak_usb_unlink_all_urbs(dev);
+
+	netif_stop_queue(netdev);
+
+	if (dev->adapter->device_stop) {
+		dev->adapter->device_stop(dev);
+	}
+
+	close_candev(netdev);
+
+	dev->open_time = 0;
+
+	dev->can.state = CAN_STATE_STOPPED;
+
+	/* can set bus off now */
+	if (dev->adapter->device_set_bus) {
+		int err = dev->adapter->device_set_bus(dev, 0);
+		if (err) 
+			return err;
+	}
+
+	return 0;
+}
+
+static const struct net_device_ops peak_usb_netdev_ops = {
+	.ndo_open = peak_usb_ndo_open,
+	.ndo_stop = peak_usb_ndo_stop,
+	.ndo_start_xmit = peak_usb_ndo_start_xmit,
+};
+
+static int peak_usb_set_mode(struct net_device *netdev, enum can_mode mode)
+{
+	struct peak_usb_device *dev = netdev_priv(netdev);
+
+	if (!dev->open_time)
+		return -EINVAL;
+
+	switch (mode) {
+	case CAN_MODE_START:
+		if (dev->adapter->device_set_bus) {
+			int err = dev->adapter->device_set_bus(dev, 1);
+			if (err)
+				netdev_warn(netdev, "couldn't start devicei (err %d)", err);
+		}
+		if (netif_queue_stopped(netdev))
+			netif_wake_queue(netdev);
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int peak_usb_set_bittiming(struct net_device *netdev)
+{
+	struct peak_usb_device *dev = netdev_priv(netdev);
+	struct can_bittiming *bt = &dev->can.bittiming;
+	int err;
+
+	netdev_info(netdev, "set bitrate %u Kbps [sam=%d, phase_seg2=%d phase_seg1=%d prop_seg=%d sjw=%d brp=%d] ",
+	            bt->bitrate, bt->sample_point, bt->phase_seg2, bt->phase_seg1, bt->prop_seg, bt->sjw, bt->brp);
+
+	if (dev->adapter->device_set_bittiming) 
+		err = dev->adapter->device_set_bittiming(dev, bt);
+
+	else {
+		printk("not supported");
+		err = 0;
+	}
+
+	if (err)
+		printk(" failure (err %d)", err);
+	printk("\n");
+
+	return err;
+}
+
+/*
+ * called to create one device, atached to USB adapter's CAN controller 
+ * number 'ctrl_index'
+ */
+static int peak_usb_create_dev(struct peak_usb_adapter *peak_usb_adapter, 
+                               struct usb_interface *intf, int ctrl_index)
+{
+	struct usb_device *usb_dev = interface_to_usbdev(intf);
+	int sizeof_candev = peak_usb_adapter->sizeof_dev_private;
+	struct peak_usb_device *dev;
+	struct net_device *netdev;
+	int i, err;
+	u16 tmp16;
+
+	if (sizeof_candev < sizeof(struct peak_usb_device))
+		sizeof_candev = sizeof(struct peak_usb_device);
+
+	netdev = alloc_candev(sizeof_candev, PCAN_USB_MAX_TX_URBS);
+	if (!netdev) {
+		dev_err(&intf->dev, "%s: Couldn't alloc candev\n", 
+		        PCAN_USB_DRIVER_NAME);
+		return -ENOMEM;
+	}
+
+	dev = netdev_priv(netdev);
+
+	dev->udev = usb_dev;
+	dev->netdev = netdev;
+	dev->adapter = peak_usb_adapter;
+	dev->ctrl_index = ctrl_index;
+	dev->state = PCAN_USB_STATE_CONNECTED;
+
+	dev->ep_msg_in = peak_usb_adapter->ep_msg_in;
+	dev->ep_msg_out = peak_usb_adapter->ep_msg_out[ctrl_index];
+
+	dev->can.clock = peak_usb_adapter->clock;
+	dev->can.bittiming_const = &peak_usb_adapter->bittiming_const;
+	dev->can.do_set_bittiming = peak_usb_set_bittiming;
+	dev->can.do_set_mode = peak_usb_set_mode;
+	dev->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES \
+	                            | CAN_CTRLMODE_LISTENONLY;
+
+	netdev->netdev_ops = &peak_usb_netdev_ops;
+
+	netdev->flags |= IFF_ECHO; /* we support local echo */
+
+	init_usb_anchor(&dev->rx_submitted);
+
+	init_usb_anchor(&dev->tx_submitted);
+	atomic_set(&dev->active_tx_urbs, 0);
+
+	for (i = 0; i < PCAN_USB_MAX_TX_URBS; i++)
+		dev->tx_contexts[i].echo_index = PCAN_USB_MAX_TX_URBS;
+
+	dev->prev_siblings = usb_get_intfdata(intf);
+	usb_set_intfdata(intf, dev);
+
+	SET_NETDEV_DEV(netdev, &intf->dev);
+
+	err = register_candev(netdev);
+	if (err) {
+		dev_err(&intf->dev, 
+			"couldn't register CAN device: %d\n", err);
+		goto lbl_set_intf_data;
+	}
+
+	if (dev->prev_siblings) {
+		(dev->prev_siblings)->next_siblings = dev;
+	}
+
+	/* read some info from PCAN-USB device */
+	tmp16 = le16_to_cpu(usb_dev->descriptor.bcdDevice);
+	dev->device_num = (uint8_t)(tmp16 & 0xff);
+	dev->device_rev = (uint8_t)(tmp16 >> 8);
+
+	if (dev->adapter->device_init) {
+		err = dev->adapter->device_init(dev);
+		if (err) 
+			goto lbl_set_intf_data;
+	}
+
+	/* set bus off */
+	if (dev->adapter->device_set_bus) {
+		err = dev->adapter->device_set_bus(dev, 0);
+		if (err) 
+			goto lbl_set_intf_data;
+	}
+
+   /* get device number early */
+	if (dev->adapter->device_get_device_number)
+	   dev->adapter->device_get_device_number(dev, &dev->device_number);
+
+	dev_info(&intf->dev, "%s attached to %s can controller %u (device %u)\n",
+	         netdev->name, peak_usb_adapter->name, ctrl_index,
+	         dev->device_number);
+
+	return 0;
+
+lbl_set_intf_data:
+	usb_set_intfdata(intf, dev->prev_siblings);
+	free_candev(netdev);
+
+	return err;
+}
+
+/*
+ * called by the usb core when the device is removed from the system
+ */
+static void peak_usb_disconnect(struct usb_interface *intf)
+{
+	struct peak_usb_device *dev;
+
+	/* unregister as netdev devices as siblings */
+	for (dev = usb_get_intfdata(intf); dev; dev = dev->prev_siblings) {
+		struct net_device *netdev = dev->netdev;
+		char name[IFNAMSIZ];
+		
+		dev->state &= ~PCAN_USB_STATE_CONNECTED;
+		strcpy(&name[0], netdev->name);
+
+		unregister_netdev(netdev);
+		free_candev(netdev);
+
+		peak_usb_unlink_all_urbs(dev);
+
+		dev->next_siblings = NULL;
+		if (dev->adapter->device_free)
+			dev->adapter->device_free(dev);
+
+		dev_info(&intf->dev, "%s removed\n", name);
+	}
+
+	usb_set_intfdata(intf, NULL);
+}
+
+/*
+ * probe function for new PEAK-System devices
+ */
+static int peak_usb_probe(struct usb_interface *intf,
+                          const struct usb_device_id *id)
+{
+	struct usb_device *usb_dev = interface_to_usbdev(intf);
+	struct peak_usb_adapter *peak_usb_adapter, **pp;
+	int i, err = -ENOMEM;
+
+	usb_dev = interface_to_usbdev(intf);
+
+	/* get corresponding PCAN-USB adapter */
+	for (pp = peak_usb_adapters_list; *pp != NULL; pp++) {
+		if ((*pp)->device_id == usb_dev->descriptor.idProduct) {
+			break;
+		}
+	}
+	peak_usb_adapter = *pp;
+	if (peak_usb_adapter == NULL) {
+		/* what? should never come except device_id usage is wrong in this file!*/
+		pr_info("%s: %s(): didn't find usb device id. 0x%x in PEAK-System devices supported list\n",
+		        PCAN_USB_DRIVER_NAME, __func__, usb_dev->descriptor.idProduct);
+		return -ENODEV;
+	}
+
+	/* got the corresponding adapter: check if it handles current interface */
+	if (peak_usb_adapter->intf_probe) {
+		err = peak_usb_adapter->intf_probe(intf);
+		if (err) {
+			return err;
+		}
+	}
+
+	dev_info(&intf->dev, "new PEAK-System ");
+	if (usb_dev->speed == USB_SPEED_HIGH) printk("high speed ");
+	printk("usb adapter with %u CAN controller(s) detected:\n", peak_usb_adapter->ctrl_count);
+
+	dev_info(&intf->dev, "%s ", 
+	         (usb_dev->manufacturer) ? (usb_dev->manufacturer) : "PEAK-System");
+
+	printk("%s\n", peak_usb_adapter->name);
+
+	if (usb_dev->product) {
+		/* remove some non-printable characters from the product string */
+		char *pc;
+		for (pc = usb_dev->product; *pc != 0; pc++)
+			if (*pc < 32 || *pc > 127) *pc = '.';
+		dev_info(&intf->dev, "%s\n", usb_dev->product);
+	}
+
+	if (usb_dev->serial) {
+		dev_info(&intf->dev, "Serial: %s\n", usb_dev->serial);
+	}
+
+	for (i = 0; i < peak_usb_adapter->ctrl_count; i++) {
+		err = peak_usb_create_dev(peak_usb_adapter, intf, i);
+		if (err) {
+			/* deregister already created devices */
+			peak_usb_disconnect(intf);
+			break;
+		}
+	}
+
+	return err;
+}
+
+/* usb specific object needed to register this driver with the usb subsystem */
+static struct usb_driver peak_usb_driver = {
+	.name = PCAN_USB_DRIVER_NAME,
+	.disconnect = peak_usb_disconnect,
+	.probe = peak_usb_probe,
+	.id_table = peak_usb_table,
+};
+
+static int __init peak_usb_init(void)
+{
+	int err;
+
+	pr_info("%s: PCAN-USB kernel driver v%s loaded\n", 
+	        PCAN_USB_DRIVER_NAME, PCAN_USB_VERSION_STRING);
+
+	/* check whether at least ONE device is supported! */
+	if (peak_usb_table[0].idVendor != PCAN_USB_VENDOR_ID) {
+		pr_warn("%s: supported adapters list empty (check compilation options)!\n",
+              PCAN_USB_DRIVER_NAME);
+	}
+
+	/* register this driver with the USB subsystem */
+	err = usb_register(&peak_usb_driver);
+
+	if (err) {
+		err("usb_register failed. Error number %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int peak_usb_do_device_exit(struct device *d, void *arg)
+{
+	struct usb_interface *intf = to_usb_interface(d);
+	struct peak_usb_device *dev;
+
+	/* stop as netdev devices as siblings */
+	for (dev = usb_get_intfdata(intf); dev; dev = dev->prev_siblings) {
+		struct net_device *netdev = dev->netdev;
+
+		if (netif_device_present(netdev)) {
+
+			if (dev->adapter->device_exit)
+				dev->adapter->device_exit(dev);
+		}			
+	}
+
+	return 0;
+}
+
+static void __exit peak_usb_exit(void)
+{
+	int err;
+
+	/* Last chance do send some synchronous commands here */
+	err = driver_for_each_device(&peak_usb_driver.drvwrap.driver,
+	                             NULL, NULL, peak_usb_do_device_exit);
+	if (err) err = 0;
+
+	/* deregister this driver with the USB subsystem */
+	usb_deregister(&peak_usb_driver);
+
+	pr_info("%s: PCAN-USB kernel driver unloaded\n", PCAN_USB_DRIVER_NAME);
+}
+
+module_init(peak_usb_init);
+module_exit(peak_usb_exit);
diff --git a/drivers/net/can/usb/pcan_usb_pro.c b/drivers/net/can/usb/pcan_usb_pro.c
new file mode 100644
index 0000000..7a2cb7d
--- /dev/null
+++ b/drivers/net/can/usb/pcan_usb_pro.c
@@ -0,0 +1,1207 @@
+/*
+ * CAN driver for PEAK System PCAN-USB-PRO adapter
+ *
+ * Copyright (C) 2011-2012 PEAK-System GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+#include <linux/netdevice.h>
+#include <linux/usb.h>
+#include <linux/module.h>
+
+#include <linux/can.h>
+#include <linux/can/dev.h>
+#include <linux/can/error.h>
+
+#include "peak_usb.h"
+#include "pcan_usb_pro.h"
+
+MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB Pro adapter");
+
+/* PCAN-USB-PRO Endpoints */
+#define PCAN_USBPRO_EP_CMDOUT     1
+#define PCAN_USBPRO_EP_CMDIN      (PCAN_USBPRO_EP_CMDOUT|USB_DIR_IN)
+#define PCAN_USBPRO_EP_MSGOUT_0   2
+#define PCAN_USBPRO_EP_MSGIN      (PCAN_USBPRO_EP_MSGOUT_0|USB_DIR_IN)
+#define PCAN_USBPRO_EP_MSGOUT_1   3
+
+#define PCAN_USBPRO_CHANNEL_COUNT 2
+
+/* PCAN-USB-PRO adapter internal clock (MHz) */
+#define PCAN_USBPRO_CRYSTAL_HZ   56000000
+
+/* PCAN-USB command timeout (ms.) */
+#define PCAN_USBPRO_COMMAND_TIMEOUT 1000
+
+/* PCAN-USB-PRO rx/tx buffers size */
+#define PCAN_USBPRO_RX_BUFFER_SIZE  1024
+#define PCAN_USBPRO_TX_BUFFER_SIZE  64
+
+#define PCAN_USB_PRO_MSG_HEADER_LEN 4
+
+/* Some commands responses need to be re-submitted */
+#define PCAN_USBPRO_RSP_SUBMIT_MAX  2
+
+#define PCAN_USBPRO_RTR             0x01
+#define PCAN_USBPRO_EXT             0x02
+
+struct pcan_usb_pro_interface {
+	struct peak_usb_device *dev[PCAN_USBPRO_CHANNEL_COUNT];
+	struct peak_time_ref time_ref;
+	int cm_ignore_count;
+	int dev_opened_count;
+};
+
+struct pcan_usb_pro_device {
+   struct peak_usb_device peak_usb_device; /* must be the first member */
+	struct pcan_usb_pro_interface *usb_if;
+};
+
+/* Internal structure used to handle messages sent to bulk urb */
+
+#define PCAN_USB_PRO_CMD_BUFFER_SIZE   512
+
+struct pcan_usb_pro_msg_t {
+   u8 * rec_ptr;
+   int  rec_buffer_size;
+   int  rec_buffer_len;
+   union
+   {
+      u16 * rec_counter_read;
+      u32 * rec_counter;
+      u8 * rec_buffer;
+   } u;
+};
+
+static int pcan_usb_pro_sizeof_rec(u8 data_type)
+{
+	switch (data_type) {
+	case DATA_TYPE_USB2CAN_STRUCT_CANMSG_RX_8:
+		return sizeof(struct pcan_usb_pro_canmsg_rx_t);
+	case DATA_TYPE_USB2CAN_STRUCT_CANMSG_RX_4:
+		return sizeof(struct pcan_usb_pro_canmsg_rx_t) - 4;
+	case DATA_TYPE_USB2CAN_STRUCT_CANMSG_RX_0:
+	case DATA_TYPE_USB2CAN_STRUCT_CANMSG_RTR_RX:
+		return sizeof(struct pcan_usb_pro_canmsg_rx_t) - 8;
+
+	case DATA_TYPE_USB2CAN_STRUCT_CANMSG_STATUS_ERROR_RX:
+		return sizeof(struct pcan_usb_pro_canmsg_status_error_rx_t);
+
+	case DATA_TYPE_USB2CAN_STRUCT_CALIBRATION_TIMESTAMP_RX:
+		return sizeof(struct pcan_usb_pro_calibration_ts_rx_t);
+
+	case DATA_TYPE_USB2CAN_STRUCT_CANMSG_TX_8:
+		return sizeof(struct pcan_usb_pro_canmsg_tx_t);
+	case DATA_TYPE_USB2CAN_STRUCT_CANMSG_TX_4:
+		return sizeof(struct pcan_usb_pro_canmsg_tx_t) - 4;
+	case DATA_TYPE_USB2CAN_STRUCT_CANMSG_TX_0:
+		return sizeof(struct pcan_usb_pro_canmsg_tx_t) - 8;
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_GETBAUDRATE:
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SETBAUDRATE:
+		return sizeof(struct pcan_usb_pro_baudrate_t);
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_GETCANBUSACTIVATE:
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SETCANBUSACTIVATE:
+		return sizeof(struct pcan_usb_pro_bus_activity_t);
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SETSILENTMODE:
+		return sizeof(struct pcan_usb_pro_silent_mode_t);
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SETDEVICENR:
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_GETDEVICENR:
+		return sizeof(struct pcan_usb_pro_dev_nr_t);
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SETWARNINGLIMIT:
+		return sizeof(struct pcan_usb_pro_warning_limit_t);
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SETLOOKUP_EXPLICIT:
+		return sizeof(struct pcan_usb_pro_lookup_explicit_t);
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SETLOOKUP_GROUP:
+		return sizeof(struct pcan_usb_pro_lookup_group_t);
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SETFILTERMODE:
+		return sizeof(struct pcan_usb_pro_filter_mode_t);
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SETRESET_MODE:
+		return sizeof(struct pcan_usb_pro_reset_mode_t);
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SETERRORFRAME:
+		return sizeof(struct pcan_usb_pro_error_frame_t);
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_GETCANBUS_ERROR_STATUS:
+		return sizeof(struct pcan_usb_pro_error_status_t);
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SETREGISTER:
+		return sizeof(struct pcan_usb_pro_set_register_t);
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_GETREGISTER:
+		return sizeof(struct pcan_usb_pro_get_register_t);
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SETGET_CALIBRATION_MSG:
+		return sizeof(struct pcan_usb_pro_calibration_t);
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SETSTRING:
+		return sizeof(struct pcan_usb_pro_set_string_t);
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_GETSTRING:
+		return sizeof(struct pcan_usb_pro_get_string_t);
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_STRING:
+		return sizeof(struct pcan_usb_pro_string_t);
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SAVEEEPROM:
+		return sizeof(struct pcan_usb_pro_save_eeprom_t);
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_USB_IN_PACKET_DELAY:
+		return sizeof(struct pcan_usb_pro_packet_delay_t);
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_TIMESTAMP_PARAM:
+		return sizeof(struct pcan_usb_pro_timestamp_param_t);
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_ERROR_GEN_ID:
+		return sizeof(struct pcan_usb_pro_error_gen_id_t);
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_ERROR_GEN_NOW:
+		return sizeof(struct pcan_usb_pro_error_gen_now_t);
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SET_SOFTFILER:
+		return sizeof(struct pcan_usb_pro_softfiler_t);
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SET_CANLED:
+		return sizeof(struct pcan_usb_pro_set_can_led_t);
+
+	default:
+		pr_info("%s: %s(%d): unsupported data type\n",
+		       PCAN_USB_DRIVER_NAME, __func__, data_type);
+	}
+
+	return -1;
+}
+
+/*
+ * Initialize PCAN USB-PRO message data structure
+ */
+static u8 * pcan_usb_pro_msg_init(struct pcan_usb_pro_msg_t *pm,
+                                  void *buffer_addr, int buffer_size)
+{
+	if (buffer_size < PCAN_USB_PRO_MSG_HEADER_LEN) return NULL;
+	pm->u.rec_buffer = (u8 *)buffer_addr;
+	pm->rec_buffer_size = pm->rec_buffer_len = buffer_size;
+	pm->rec_ptr = pm->u.rec_buffer + PCAN_USB_PRO_MSG_HEADER_LEN;
+	return pm->rec_ptr;
+}
+
+static u8 * pcan_usb_pro_msg_init_empty(struct pcan_usb_pro_msg_t *pm,
+                                        void *buffer_addr, int buffer_size)
+{
+	u8 *pr = pcan_usb_pro_msg_init(pm, buffer_addr, buffer_size);
+	if (pr != NULL) {
+		pm->rec_buffer_len = PCAN_USB_PRO_MSG_HEADER_LEN;
+		*pm->u.rec_counter = 0;
+	}
+	return pr;
+}
+
+/*
+ * Add one record to a message being built.
+ */
+static int pcan_usb_pro_msg_add_rec(struct pcan_usb_pro_msg_t *pm, int id, ...)
+{
+	int l, i;
+	u8 *pc;
+	va_list ap;
+
+	va_start(ap, id);
+
+	pc = pm->rec_ptr + 1;
+
+	i = 0;
+	switch (id) {
+	case DATA_TYPE_USB2CAN_STRUCT_CANMSG_TX_8:
+		i += 4;
+	case DATA_TYPE_USB2CAN_STRUCT_CANMSG_TX_4:
+		i += 4;
+	case DATA_TYPE_USB2CAN_STRUCT_CANMSG_TX_0:
+		*pc++ = (u8 )va_arg(ap, int);	// client
+		*pc++ = (u8 )va_arg(ap, int);	// flags
+		*pc++ = (u8 )va_arg(ap, int);	// len
+		*(u32 *)pc = cpu_to_le32(va_arg(ap, u32));  // id
+		pc += 4;
+		memcpy(pc, va_arg(ap, int *), i);
+		pc += i;
+		break;
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_GETCANBUSACTIVATE:
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_GETCANBUS_ERROR_STATUS:
+		*pc++ = (u8 )va_arg(ap, int);	// channel
+		break;
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SETBAUDRATE:
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_GETBAUDRATE:
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SETDEVICENR:
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_GETDEVICENR:
+		*pc++ = (u8 )va_arg(ap, int);	// channel
+		pc += 2; // dummy
+		/* CCBT, devicenr */
+		*(u32 *)pc = cpu_to_le32(va_arg(ap, u32));
+		pc += 4;
+		break;
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SETCANBUSACTIVATE:
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SETSILENTMODE:
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SETWARNINGLIMIT:
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SETFILTERMODE:
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SETRESET_MODE:
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SETERRORFRAME:
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_TIMESTAMP_PARAM:
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_ERROR_GEN_NOW:
+		*pc++ = (u8 )va_arg(ap, int);	// channel
+		/* onoff, silentmode, warninglimit, filter_mode, reset, mode, */
+		/* start_or_end, bit_pos */
+		*(u16 *)pc = cpu_to_le16((u16 )va_arg(ap, int));
+		pc += 2;
+		break;
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SETLOOKUP_EXPLICIT:
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SET_CANLED:
+		*pc++ = (u8 )va_arg(ap, int);	// channel
+		*(u16 *)pc = cpu_to_le16((u16 )va_arg(ap, int)); // id_type,mode
+		pc += 2;
+		*(u32 *)pc = cpu_to_le32(va_arg(ap, u32)); // id, timeout
+		pc += 4;
+		break;
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SETLOOKUP_GROUP:
+		*pc++ = (u8 )va_arg(ap, int);	// channel
+		*(u16 *)pc = cpu_to_le16((u16 )va_arg(ap, int)); // id_type
+		pc += 2;
+		*(u32 *)pc = cpu_to_le32(va_arg(ap, u32)); // id_start
+		pc += 4;
+		*(u32 *)pc = cpu_to_le32(va_arg(ap, u32)); // id_end
+		pc += 4;
+		break;
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SETREGISTER:
+		*pc++ = (u8 )va_arg(ap, int);	// irq_off
+		pc += 2; // dummy
+		*(u32 *)pc = cpu_to_le32(va_arg(ap, u32)); // address
+		pc += 4;
+		*(u32 *)pc = cpu_to_le32(va_arg(ap, u32)); // value
+		pc += 4;
+		*(u32 *)pc = cpu_to_le32(va_arg(ap, u32)); // mask
+		pc += 4;
+		break;
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_GETREGISTER:
+		*pc++ = (u8 )va_arg(ap, int);	// irq_off
+		pc += 2; // dummy
+		*(u32 *)pc = cpu_to_le32(va_arg(ap, u32)); // address
+		pc += 4;
+		*(u32 *)pc = cpu_to_le32(va_arg(ap, u32)); // value
+		pc += 4;
+		break;
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SETGET_CALIBRATION_MSG:
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_USB_IN_PACKET_DELAY:
+		pc++;
+		/* mode, delay */
+		*(u16 *)pc = cpu_to_le16((u16 )va_arg(ap, int)); // mode
+		pc += 2;
+		break;
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SETGET_BUSLAST_MSG:
+		*pc++ = (u8 )va_arg(ap, int);	// channel
+		pc++; // dummy
+		*pc++ = (u8 )va_arg(ap, int);	// mode
+		//*(u16 *)pc = cpu_to_le16((u16 )va_arg(ap, int)); // prescaler
+		pc += 2; // prescale (readonly)
+		//*(u16 *)pc = cpu_to_le32((u16 )va_arg(ap, int)); // sampletimequanta
+		*(u16 *)pc = cpu_to_le16(4096); // sampletimequanta
+		pc += 2;
+		break;
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SETSTRING:
+		*pc++ = (u8 )va_arg(ap, int);	// channel
+		*pc++ = (u8 )va_arg(ap, int);	// offset
+		*pc++ = (u8 )va_arg(ap, int);	// len
+		memcpy(pc, va_arg(ap, u8 *), 60);
+		pc += 60;
+		break;
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_GETSTRING:
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SAVEEEPROM:
+		*pc++ = (u8 )va_arg(ap, int);	// channel
+		pc += 2; // dummy
+		break;
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_STRING:
+		*pc++ = (u8 )va_arg(ap, int);	// channel
+		pc += 2; // dummy
+		memcpy(pc, va_arg(ap, u8 *), 250);
+		pc += 250;
+		break;
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_ERROR_GEN_ID:
+		*pc++ = (u8 )va_arg(ap, int);	// channel
+		*(u16 *)pc = cpu_to_le16((u16 )va_arg(ap, int)); // bit_pos
+		pc += 2;
+		*(u32 *)pc = cpu_to_le32(va_arg(ap, u32)); // id
+		pc += 4;
+		*(u16 *)pc = cpu_to_le16((u16 )va_arg(ap, int)); // ok_counter
+		pc += 2;
+		*(u16 *)pc = cpu_to_le16((u16 )va_arg(ap, int)); //error_counter
+		pc += 2;
+		break;
+
+	case DATA_TYPE_USB2CAN_STRUCT_FKT_SET_SOFTFILER:
+		*pc++ = (u8 )va_arg(ap, int);	// channel
+		pc += 2;
+		*(u32 *)pc = cpu_to_le32(va_arg(ap, u32)); // accmask
+		pc += 4;
+		*(u32 *)pc = cpu_to_le32(va_arg(ap, u32)); // acccode
+		pc += 4;
+		break;
+
+	default:
+		pr_info("%s: %s(): unknown data type %02Xh (%d)\n",
+		        PCAN_USB_DRIVER_NAME, __func__, id, id);
+		pc--;
+		break;
+	}
+
+	l = pc - pm->rec_ptr;
+	if (l > 0) {
+		*pm->u.rec_counter = cpu_to_le32(*pm->u.rec_counter+1);
+		*(pm->rec_ptr) = (u8 )id;
+
+		pm->rec_ptr = pc;
+		pm->rec_buffer_len += l;
+	}
+
+	va_end(ap);
+
+	return l;
+}
+
+/*
+ * Send the given PCAN-USB-PRO command synchronously
+ */
+static int pcan_usb_pro_send_command(struct peak_usb_device *dev, 
+                                     struct pcan_usb_pro_msg_t *pum)
+{
+	int actual_length;
+	int err;
+
+	/* usb device unregistered? */
+	if (!(dev->state & PCAN_USB_STATE_CONNECTED)) return 0;
+
+	err = usb_bulk_msg(dev->udev, 
+	                   usb_sndbulkpipe(dev->udev, PCAN_USBPRO_EP_CMDOUT),
+	                   &pum->u.rec_buffer[0], pum->rec_buffer_len,
+	                   &actual_length, PCAN_USBPRO_COMMAND_TIMEOUT);
+	if (err)
+		netdev_err(dev->netdev, "sending command failure: %d\n", err);
+
+	return err;
+}
+
+static int pcan_usb_pro_wait_response(struct peak_usb_device *dev, 
+                                      struct pcan_usb_pro_msg_t *pum)
+{
+	u8 req_data_type, req_channel;
+	int actual_length;
+	int i, err = 0;
+
+	/* usb device unregistered? */
+	if (!(dev->state & PCAN_USB_STATE_CONNECTED)) return 0;
+
+	/* first, keep in memory the request type and the eventual channel */
+	/* to filter received message */
+	req_data_type = pum->u.rec_buffer[4];
+	req_channel = pum->u.rec_buffer[5];
+
+	/* then, clear number of records to be sure to receive a real response */
+	/* from the device */
+	*pum->u.rec_counter = 0;
+	mdelay(5);
+
+	for (i = 0; !err && i < PCAN_USBPRO_RSP_SUBMIT_MAX; i++) {
+		struct pcan_usb_pro_msg_t rsp;
+		u32 r, rec_counter;
+		u8 *pc;
+
+		err = usb_bulk_msg(dev->udev, 
+		                   usb_rcvbulkpipe(dev->udev, PCAN_USBPRO_EP_CMDIN),
+		                   &pum->u.rec_buffer[0], pum->rec_buffer_len,
+		                   &actual_length, PCAN_USBPRO_COMMAND_TIMEOUT);
+		if (err) {
+			netdev_err(dev->netdev, "waiting response failure: %d\n", err);
+			break;
+		}
+
+		if (actual_length == 0) {
+			continue;
+		}
+
+		if (actual_length < PCAN_USB_PRO_MSG_HEADER_LEN) {
+			netdev_err(dev->netdev, "got abnormal too small response (len=%d)\n", 
+			           actual_length);
+			err = -EBADMSG;
+			break;
+		}
+	
+		pc = pcan_usb_pro_msg_init(&rsp, &pum->u.rec_buffer[0], actual_length);
+
+		rec_counter = le32_to_cpu(*rsp.u.rec_counter);
+
+		for (r = 0; r < rec_counter; r++) {
+			union pcan_usb_pro_rec_t *pr = (union pcan_usb_pro_rec_t *)pc;
+			int rec_size = pcan_usb_pro_sizeof_rec(pr->data_type);
+			if (rec_size <= 0) {
+				netdev_err(dev->netdev, "got unprocessed record in msg\n");
+				dump_mem("received response msg", 
+				         &pum->u.rec_buffer[0], actual_length);
+				err = -EBADMSG;
+				break;
+			}
+
+			/* check if the response corresponds to the request */
+			if (pr->data_type != req_data_type) {
+			}
+
+			/* check if the channel in the response corresponds to the request */
+			else if ((req_channel != 0xff) && (pr->bus_activity.channel != req_channel)) {
+			}
+
+			/* got the response */
+			else return 0;
+
+			/* otherwise, go on with next record in message */
+			pc += rec_size;	
+		}
+
+		if (r >= rec_counter) {
+		}
+	}
+
+	return (i >= PCAN_USBPRO_RSP_SUBMIT_MAX) ? -ERANGE : err;
+}
+
+static int pcan_usb_pro_request(struct peak_usb_device *dev, int req_id, int req_value, void *req_addr, int req_size)
+{
+	int err;
+	u8 req_type;
+	unsigned int p;
+
+	/* usb device unregistered? */
+	if (!(dev->state & PCAN_USB_STATE_CONNECTED)) return 0;
+
+	memset(req_addr, '\0', req_size);
+
+	req_type = USB_TYPE_VENDOR | USB_RECIP_OTHER;
+	switch (req_id) {
+	case USB_VENDOR_REQUEST_FKT:
+		/* Host to device */
+		p = usb_sndctrlpipe(dev->udev, 0);
+		break;
+
+	case USB_VENDOR_REQUEST_INFO:
+	default:
+		/* Device to host */
+		p = usb_rcvctrlpipe(dev->udev, 0);
+		req_type |= USB_DIR_IN;
+	}
+
+	err = usb_control_msg(dev->udev, 
+	                      p,
+	                      req_id,
+	                      req_type,
+	                      req_value,
+	                      0, req_addr, req_size,
+	                      2*USB_CTRL_GET_TIMEOUT);
+	if (err < 0)
+		netdev_info(dev->netdev,
+		            "unable to request usb[type=%d value=%d] err=%d\n", 
+		            req_id, req_value, err);
+	else {
+		//dump_mem("request content", req_addr, req_size);
+		err = 0;
+	}
+
+	return err;
+}
+
+/*
+ * Start/stop calibration messages periodically sent by the PCAN-USB-PRO device.
+ */
+static int pcan_usb_pro_set_calibration_msgs(struct peak_usb_device *dev, u16 onoff)
+{
+	struct pcan_usb_pro_msg_t um;
+	u8 tmp[32];
+
+	pcan_usb_pro_msg_init_empty(&um, tmp, sizeof(tmp));
+	pcan_usb_pro_msg_add_rec(&um,
+	                         DATA_TYPE_USB2CAN_STRUCT_FKT_SETGET_CALIBRATION_MSG,
+	                         onoff);
+
+	return pcan_usb_pro_send_command(dev, &um);
+}
+
+static int pcan_usb_pro_set_bus(struct peak_usb_device *dev, u8 onoff)
+{
+	struct pcan_usb_pro_msg_t um;
+	u8 tmp[32];
+
+	pcan_usb_pro_msg_init_empty(&um, tmp, sizeof(tmp));
+	pcan_usb_pro_msg_add_rec(&um,
+	                         DATA_TYPE_USB2CAN_STRUCT_FKT_SETCANBUSACTIVATE,
+	                         dev->ctrl_index,
+	                         (int )onoff);
+
+	return pcan_usb_pro_send_command(dev, &um);
+}
+
+static int pcan_usb_pro_set_silent(struct peak_usb_device *dev, u8 onoff)
+{
+	struct pcan_usb_pro_msg_t um;
+	u8 tmp[32];
+
+	pcan_usb_pro_msg_init_empty(&um, tmp, sizeof(tmp));
+	pcan_usb_pro_msg_add_rec(&um,
+	                         DATA_TYPE_USB2CAN_STRUCT_FKT_SETSILENTMODE,
+	                         dev->ctrl_index,
+	                         (int )onoff);
+
+	return pcan_usb_pro_send_command(dev, &um);
+}
+
+static int pcan_usb_pro_set_filter(struct peak_usb_device *dev, u16 filter_mode)
+{
+	struct pcan_usb_pro_msg_t um;
+	u8 tmp[32];
+
+	pcan_usb_pro_msg_init_empty(&um, tmp, sizeof(tmp));
+	pcan_usb_pro_msg_add_rec(&um,
+	                         DATA_TYPE_USB2CAN_STRUCT_FKT_SETFILTERMODE,
+	                         dev->ctrl_index,
+	                         filter_mode);
+
+	return pcan_usb_pro_send_command(dev, &um);
+}
+
+static int pcan_usb_pro_set_can_led(struct peak_usb_device *dev, u8 mode, u32 timeout)
+{
+	struct pcan_usb_pro_msg_t um;
+	u8 tmp[32];
+
+	pcan_usb_pro_msg_init_empty(&um, tmp, sizeof(tmp));
+	pcan_usb_pro_msg_add_rec(&um,
+	                         DATA_TYPE_USB2CAN_STRUCT_FKT_SET_CANLED,
+	                         dev->ctrl_index,
+	                         mode,
+	                         timeout);
+
+	return pcan_usb_pro_send_command(dev, &um);
+}
+
+static int pcan_usb_pro_get_device_number(struct peak_usb_device *dev, u32 *device_number)
+{
+	struct pcan_usb_pro_msg_t um;
+	u8 tmp[32], *pc;
+	int err;
+
+	pc = pcan_usb_pro_msg_init_empty(&um, tmp, sizeof(tmp));
+	pcan_usb_pro_msg_add_rec(&um,
+	                         DATA_TYPE_USB2CAN_STRUCT_FKT_GETDEVICENR,
+	                         dev->ctrl_index);
+
+	err =  pcan_usb_pro_send_command(dev, &um);
+	if (!err) {
+
+		err = pcan_usb_pro_wait_response(dev, &um);
+
+		if (!err) {
+			struct pcan_usb_pro_dev_nr_t *pdn = (struct pcan_usb_pro_dev_nr_t *)pc;
+			if (device_number)
+				*device_number = le32_to_cpu(pdn->serial_num);
+		}
+	}
+
+	return err;
+}
+
+static int pcan_usb_pro_set_bittiming(struct peak_usb_device *dev, struct can_bittiming *bt)
+{
+	struct pcan_usb_pro_msg_t um;
+	u8 tmp[32];
+	u32 ccbt;
+
+	ccbt = (dev->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES) ? 0x00800000 : 0;
+	ccbt |= (bt->sjw - 1) << 24;
+	ccbt |= (bt->phase_seg2 - 1) << 20;
+	ccbt |= (bt->prop_seg + bt->phase_seg1 - 1) << 16; /* = tseg1 */
+	ccbt |= bt->brp - 1;
+
+	printk("ccbt=0x%08x", ccbt);
+
+	pcan_usb_pro_msg_init_empty(&um, tmp, sizeof(tmp));
+	pcan_usb_pro_msg_add_rec(&um,
+	                         DATA_TYPE_USB2CAN_STRUCT_FKT_SETBAUDRATE,
+	                         dev->ctrl_index,
+	                         ccbt);
+
+	return pcan_usb_pro_send_command(dev, &um);
+}
+
+/* 
+ * Tell PCAN-USB-PRO that the CAN/LIN driver is loaded /unloaded.
+ */
+static void pcan_usb_pro_driver_loaded(struct peak_usb_device *dev, int can_lin, int loaded)
+{
+	u8 buffer[16];
+
+	buffer[0] = (u8 )can_lin; /* Interface CAN=0 LIN=1 */
+	buffer[1] = loaded ? 1 : 0;    /* Driver loaded 0/1 */
+
+	pcan_usb_pro_request(dev, 
+	                     USB_VENDOR_REQUEST_FKT, 
+	                     USB_VENDOR_REQUEST_wVALUE_SETFKT_INTERFACE_DRIVER_LOADED,
+	                     &buffer[0], sizeof(buffer));
+}
+
+static inline struct pcan_usb_pro_interface *pcan_usb_pro_dev_if(struct peak_usb_device *dev)
+{
+	return ((struct pcan_usb_pro_device *)dev)->usb_if;
+}
+
+static inline struct peak_usb_device *pcan_usb_pro_find_dev(struct peak_usb_device *head, unsigned int ctrl_index)
+{
+	for (; head; head = head->next_siblings)
+		if (head->ctrl_index == ctrl_index)
+			return head;
+
+	return NULL;
+}
+
+/*
+ * Handler of record types:
+ * - DATA_TYPE_USB2CAN_STRUCT_CANMSG_RX_x
+ * - DATA_TYPE_USB2CAN_STRUCT_CANMSG_RTR_RX
+ */
+static int pcan_usb_pro_handle_canmsg(struct pcan_usb_pro_interface *usb_if,
+                                      struct pcan_usb_pro_canmsg_rx_t *rx)
+{
+	const unsigned int ctrl_index = (rx->len >> 4) & 0x0f;
+	struct peak_usb_device *dev = usb_if->dev[ctrl_index];
+	struct net_device *netdev = dev->netdev;
+	struct can_frame *can_frame;
+	struct sk_buff *skb;
+	struct timeval tv;
+
+	skb = alloc_can_skb(netdev, &can_frame);
+	if (!skb)
+		return -ENOMEM;
+
+	can_frame->can_id = le32_to_cpu(rx->id);
+	can_frame->can_dlc = rx->len & 0x0f;
+
+	if (rx->flags & PCAN_USBPRO_RTR)
+		can_frame->can_id |= CAN_RTR_FLAG;
+	if (rx->flags & PCAN_USBPRO_EXT)
+		can_frame->can_id |= CAN_EFF_FLAG;
+
+	memcpy(can_frame->data, &rx->data[0], can_frame->can_dlc);
+
+	peak_usb_get_timestamp_tv(&usb_if->time_ref, le32_to_cpu(rx->timestamp32), &tv);
+	skb->tstamp = timeval_to_ktime(tv);
+
+	netif_rx(skb);
+	netdev->stats.rx_packets++;
+	netdev->stats.rx_bytes += can_frame->can_dlc;
+
+	return 0;
+}
+
+static int pcan_usb_pro_handle_error(struct pcan_usb_pro_interface *usb_if,
+                               struct pcan_usb_pro_canmsg_status_error_rx_t *er)
+{
+	const u32 raw_status = le32_to_cpu(er->status);
+	const unsigned int ctrl_index = (er->channel >> 4) & 0x0f;
+	struct peak_usb_device *dev = usb_if->dev[ctrl_index];
+	struct net_device *netdev = dev->netdev;
+	struct can_frame *can_frame;
+	struct sk_buff *skb;
+	struct timeval tv;
+
+	skb = alloc_can_err_skb(netdev, &can_frame);
+
+	memset(can_frame, '\0', sizeof(struct can_frame));
+
+	if (raw_status & FW_USBPRO_STATUS_MASK_BUS_S) {
+		/* Bus Off */
+		can_frame->can_id |= CAN_ERR_BUSOFF;
+		can_bus_off(netdev);
+	}
+
+	else if (raw_status & FW_USBPRO_STATUS_MASK_ERROR_S) {
+		u32 rx_error_counter = (le32_to_cpu(er->error_frame) & 0x00ff0000) >> 16;
+		u32 tx_error_counter = (le32_to_cpu(er->error_frame) & 0xff000000) >> 24;
+
+		if (rx_error_counter > 127) {
+			/* Bus Heavy */
+			can_frame->can_id |= CAN_ERR_CRTL;
+			can_frame->data[1] |= CAN_ERR_CRTL_RX_PASSIVE;
+			dev->can.can_stats.error_passive++;
+		}
+		else if (rx_error_counter > 96) {
+			/* Bus Light */
+			can_frame->can_id |= CAN_ERR_CRTL;
+			can_frame->data[1] |= CAN_ERR_CRTL_RX_WARNING;
+			dev->can.can_stats.error_warning++;
+		}
+
+		if (tx_error_counter > 127) {
+			/* Bus Heavy */
+			can_frame->can_id |= CAN_ERR_CRTL;
+			can_frame->data[1] |= CAN_ERR_CRTL_TX_PASSIVE;
+			dev->can.can_stats.error_passive++;
+		}
+
+		else if (tx_error_counter > 96) {
+			/* Bus Light */
+			can_frame->can_id |= CAN_ERR_CRTL;
+			can_frame->data[1] |= CAN_ERR_CRTL_TX_WARNING;
+			dev->can.can_stats.error_warning++;
+		}
+	}
+
+	if (raw_status & FW_USBPRO_STATUS_MASK_OVERRUN_S) {
+		can_frame->can_id |= CAN_ERR_PROT;
+		can_frame->data[2] |= CAN_ERR_PROT_OVERLOAD;
+	}
+
+	if (raw_status & FW_USBPRO_STATUS_MASK_QOVERRUN_S) {
+		can_frame->can_id |= CAN_ERR_CRTL;
+		can_frame->data[1] |= CAN_ERR_CRTL_RX_OVERFLOW;
+	}
+
+	if (can_frame->can_id != CAN_ERR_FLAG) {
+
+		peak_usb_get_timestamp_tv(&usb_if->time_ref, le32_to_cpu(er->timestamp32), &tv);
+		skb->tstamp = timeval_to_ktime(tv);
+		netif_rx(skb);
+		netdev->stats.rx_packets++;
+	}
+
+	return 0;
+}
+
+static int pcan_usb_pro_handle_cm(struct pcan_usb_pro_interface *usb_if,
+                                  struct pcan_usb_pro_calibration_ts_rx_t *ts)
+{
+
+	if (usb_if->cm_ignore_count > 0) {
+		/* should wait until clock is stabilized */
+		usb_if->cm_ignore_count--;
+	}
+	else {
+
+		peak_usb_set_timestamp_now(&usb_if->time_ref, 
+		                           le32_to_cpu(ts->timestamp64[1]));
+	}
+
+	return 0;
+}
+
+/*
+ * callback for bulk IN urb
+ *
+ * Warning: current 'dev' may not be the correct one (PCAN-USB-PRO defines 
+ *          only one endpoint for receiving messages from the two channels.
+ */
+static int pcan_usb_pro_decode_msg(struct peak_usb_device *dev, struct urb *urb)
+{
+	struct pcan_usb_pro_interface *usb_if = pcan_usb_pro_dev_if(dev);
+	struct net_device *netdev = dev->netdev;
+	struct pcan_usb_pro_msg_t usb_msg;
+	u8 *rec_ptr, *msg_end;
+	u16 rec_count;
+	int err = 0;
+
+	rec_ptr = pcan_usb_pro_msg_init(&usb_msg, urb->transfer_buffer, urb->actual_length);
+   if (rec_ptr == NULL) {
+		netdev_err(netdev, "bad msg header len %d\n", urb->actual_length);
+		return -EINVAL;
+   }
+
+	/* loop reading all the records from the incoming message */
+	msg_end = urb->transfer_buffer + urb->actual_length;
+	for (rec_count = le16_to_cpu(*usb_msg.u.rec_counter_read); rec_count > 0; rec_count--) {
+
+		union pcan_usb_pro_rec_t *pr = (union pcan_usb_pro_rec_t *)rec_ptr;
+		int sizeof_rec = pcan_usb_pro_sizeof_rec(pr->data_type);
+
+		if (sizeof_rec <= 0) {
+			netdev_err(netdev, "got unsupported record in received usb msg:\n");
+			err = -ENOTSUPP;
+			break;
+		}
+
+		/* Check if the record goes out of current packet */
+      if (rec_ptr + sizeof_rec > msg_end) {
+			/* Yes, it does: */
+			/* donot handle fragemtation => increas usb rx message size */
+			netdev_err(netdev,
+			        "got fragmented record: should increase usb rx buffer size\n");
+			err = -EBADMSG;
+			break;
+		}
+
+		switch (pr->data_type) {
+		case DATA_TYPE_USB2CAN_STRUCT_CANMSG_RX_8:
+		case DATA_TYPE_USB2CAN_STRUCT_CANMSG_RX_4:
+		case DATA_TYPE_USB2CAN_STRUCT_CANMSG_RX_0:
+		case DATA_TYPE_USB2CAN_STRUCT_CANMSG_RTR_RX:
+			err = pcan_usb_pro_handle_canmsg(usb_if, &pr->canmsg_rx);
+			if (err < 0) goto fail;
+			break;
+
+		case DATA_TYPE_USB2CAN_STRUCT_CANMSG_STATUS_ERROR_RX:
+			err = pcan_usb_pro_handle_error(usb_if, &pr->canmsg_status_error_rx);
+			if (err < 0) goto fail;
+			break;
+
+		case DATA_TYPE_USB2CAN_STRUCT_CALIBRATION_TIMESTAMP_RX:
+			err = pcan_usb_pro_handle_cm(usb_if, &pr->calibration_ts_rx);
+			break;
+
+		default:
+			netdev_err(netdev, "unhandled record type 0x%02x (%d): ignored\n",
+			           pr->data_type, pr->data_type);
+			break;
+		}
+
+		rec_ptr += sizeof_rec;
+	}
+
+fail:
+
+	if (err)
+		dump_mem("received msg", urb->transfer_buffer, urb->actual_length);
+
+	return err;
+}
+
+static int pcan_usb_pro_encode_msg(struct peak_usb_device *dev, struct sk_buff *skb, u8 *obuf, size_t *size)
+{
+	struct can_frame *cf = (struct can_frame *)skb->data;
+	u8 data_type, client, len, flags;
+	struct pcan_usb_pro_msg_t usb_msg;
+	int err = 0;
+
+	pcan_usb_pro_msg_init_empty(&usb_msg, obuf, *size);
+
+	if ((cf->can_id & CAN_RTR_FLAG) || (cf->can_dlc == 0)) {
+		data_type = DATA_TYPE_USB2CAN_STRUCT_CANMSG_TX_0;
+	}
+
+	else if (cf->can_dlc <= 4) {
+		data_type = DATA_TYPE_USB2CAN_STRUCT_CANMSG_TX_4;
+	}
+	else {
+		data_type = DATA_TYPE_USB2CAN_STRUCT_CANMSG_TX_8;
+	}
+
+	len = (dev->ctrl_index << 4) | (cf->can_dlc & 0x0f);
+
+	flags = 0;
+	if (cf->can_id & CAN_EFF_FLAG) flags |= 0x02;
+	if (cf->can_id & CAN_RTR_FLAG) flags |= 0x01;
+
+	client = 0;
+
+	err = pcan_usb_pro_msg_add_rec(&usb_msg, data_type, client, flags, 
+	                               len, cf->can_id, &cf->data[0]);
+
+	*size = usb_msg.rec_buffer_len;
+
+	return 0;
+}
+
+/*
+ * Start interface
+ * (last chance before set bus on)
+ */
+static int pcan_usb_pro_start(struct peak_usb_device *dev)
+{
+	struct pcan_usb_pro_device *pdev = (struct pcan_usb_pro_device *)dev;
+	int err;
+
+	err = pcan_usb_pro_set_silent(dev, 
+	                              (dev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY));
+	if (err)
+		goto failed;
+
+	/* Set filter mode: 0-> All OFF; 1->bypass */
+	err = pcan_usb_pro_set_filter(dev, 1);
+	if (err)
+		goto failed;
+
+	/* on opening first device, ask for calibration messages */
+	if (pdev->usb_if->dev_opened_count == 0) {
+
+		/* reset time_ref */
+		peak_usb_init_time_ref(&pdev->usb_if->time_ref, &pcan_usb_pro);
+
+		/* ask device to send calibration messages */
+		err = pcan_usb_pro_set_calibration_msgs(dev, 1);
+	}
+
+	pdev->usb_if->dev_opened_count++;
+
+failed:
+	return err;
+}
+
+/*
+ * Stop interface
+ * (last chance before set bus off)
+ */
+static int pcan_usb_pro_stop(struct peak_usb_device *dev)
+{
+	struct pcan_usb_pro_device *pdev = (struct pcan_usb_pro_device *)dev;
+
+	/* turn off calibration messages for that interface if no other dev opened */
+	if (pdev->usb_if->dev_opened_count == 1)
+		pcan_usb_pro_set_calibration_msgs(dev, 0);
+
+	pdev->usb_if->dev_opened_count--;
+
+	return 0;
+}
+
+/*
+ * called when probing to initialize a device object.
+ */
+static int pcan_usb_pro_init(struct peak_usb_device *dev)
+{
+	struct pcan_usb_pro_interface *usb_if;
+	struct pcan_usb_pro_device *pdev = (struct pcan_usb_pro_device *)dev;
+
+	/* Do this for 1st channel only */
+	if (!dev->prev_siblings) {
+
+		struct pcan_usb_pro_ext_firmware_info_t fi;
+		struct pcan_usb_pro_bootloader_info_t bi;
+
+		/* tell the device the can driver is running */
+		pcan_usb_pro_driver_loaded(dev, 0, 1);
+
+		if (pcan_usb_pro_request(dev, 
+		                         USB_VENDOR_REQUEST_INFO, 
+		                         USB_VENDOR_REQUEST_wVALUE_INFO_FIRMWARE,
+		                         &fi, sizeof(fi)) >= 0)
+		{
+			netdev_info(dev->netdev,
+			            "%s fw v%d.%d.%d (%02d/%02d/%02d) fw_type 0x%08x\n",
+			            pcan_usb_pro.name, 
+			            fi.version[0], fi.version[1], fi.version[2],
+			         fi.day, fi.month, fi.year, fi.fw_type);
+		}
+
+		if (pcan_usb_pro_request(dev, 
+		                         USB_VENDOR_REQUEST_INFO, 
+		                         USB_VENDOR_REQUEST_wVALUE_INFO_BOOTLOADER,
+		                         &bi, sizeof(bi)) >= 0)
+		{
+			netdev_info(dev->netdev, "bootloader v%d.%d.%d (%02d/%02d/%02d)\n",
+			            bi.version[0], bi.version[1], bi.version[2],
+			            bi.day, bi.month, bi.year);
+
+			netdev_info(dev->netdev,
+			            "serial %08X.%08X hw_type 0x%08x hw_rev 0x%08x\n",
+			            bi.serial_num_high, bi.serial_num_low,
+			            bi. hw_type, bi.hw_rev);
+
+			dev->device_rev = (u8)bi.hw_rev;
+		}
+
+		usb_if = kzalloc(sizeof(struct pcan_usb_pro_interface), GFP_KERNEL);
+		if (!usb_if)
+			return -ENOMEM;
+		
+		/* Count of CM to ignore before taking into account */
+		/* Note: windows driver says 3... */
+		usb_if->cm_ignore_count = 5;
+
+	}
+
+	else {
+		usb_if = pcan_usb_pro_dev_if(dev->prev_siblings);
+	}
+
+	pdev->usb_if = usb_if;
+	usb_if->dev[dev->ctrl_index] = dev;
+
+	/* set LED in default state (end of init phase) */
+	pcan_usb_pro_set_can_led(dev, 0, 1);
+
+	return 0;
+}
+
+/*
+ * called when driver module is being unloaded:
+ *
+ * rmmod when plugged  => module_exit => device_exit, then
+ *                                       usb_deregister(), then
+ *                                       device_stop, then
+ *                        module_disconnect => device_free
+ * rmmod but unplugged => module_exit
+ * unplug              => module_disconnect => device_free
+ *
+ * (last change to send something on usb)
+ */
+static void pcan_usb_pro_exit(struct peak_usb_device *dev)
+{
+	struct pcan_usb_pro_device *pdev = (struct pcan_usb_pro_device *)dev;
+
+	/* when rmmod called before unplug and ifconfig down, MUST reset things */
+	/* before leaving */
+	if (dev->can.state != CAN_STATE_STOPPED) {
+
+		/* set bus off on the corresponding channel */
+		pcan_usb_pro_set_bus(dev, 0);
+	}
+
+	/* if channel #0 (only) => tell PCAN-USB-PRO the can driver is being */
+	/* unloaded */
+	if (dev->ctrl_index == 0) {
+
+		/* turn off calibration message if any device were opened */
+		if (pdev->usb_if->dev_opened_count > 0)
+			pcan_usb_pro_set_calibration_msgs(dev, 0);
+
+		/* tell the PCAN-USB-PRO device that drive is being unloaded */
+		pcan_usb_pro_driver_loaded(dev, 0, 0);
+
+		/* this device needs also to be resetted when driver is unloaded */
+		/* TODO hangs when rmmod */
+		//if (dev->udev)
+		//	usb_reset_device(dev->udev);
+	}
+}
+
+/*
+ * called when PCAN-USB-PRO adapter is unplugged
+ */
+static void pcan_usb_pro_free(struct peak_usb_device *dev)
+{
+	/* last device: can free pcan_usb_pro_interafce object now */
+	if (!dev->prev_siblings && !dev->next_siblings) {
+		kfree(pcan_usb_pro_dev_if(dev));
+	}
+}
+
+/*
+ * probe function for new PCAN-USB-PRO usb interface
+ */
+static int pcan_usb_pro_probe(struct usb_interface *intf)
+{
+	struct usb_host_interface *iface_desc;
+	int i;
+
+	/* check endpoint addresses (numbers) and associated max data length */
+	/* (only from setting 0) */
+	/* Since USB-PRO defines also a LIN interface, should reject it when */
+	/* adapter plugged: make use of endpoint addresses (no other way...) */
+	iface_desc = &intf->altsetting[0];
+
+	/* check interface endpoint addresses */
+	for (i = 0; i < iface_desc->desc.bNumEndpoints; i++) {
+		struct usb_endpoint_descriptor *endpoint = &iface_desc->endpoint[i].desc;
+
+		/* Below is the list of valid ep addreses. All other ep address */
+		/* is considered as not-CAN interface address => no dev created */
+		switch (endpoint->bEndpointAddress) {
+		case PCAN_USBPRO_EP_CMDOUT:
+		case PCAN_USBPRO_EP_CMDIN:
+		case PCAN_USBPRO_EP_MSGOUT_0:
+		case PCAN_USBPRO_EP_MSGOUT_1:
+		case PCAN_USBPRO_EP_MSGIN:
+			/* CAN usb interface unused endpoint */
+		case 0x83:
+			break;
+		default:
+			/* PCAN-USB-PRO: other usb interface = LIN interface TBD */
+			return -ENODEV;
+		}
+	}
+ 
+	return 0;
+}
+
+/*
+ * Describe the PCAN-USB-PRO adapter
+ */
+struct peak_usb_adapter pcan_usb_pro = {
+	.name = "PCAN-USB Pro",
+	.device_id = PCAN_USBPRO_PRODUCT_ID,
+	.ctrl_count = PCAN_USBPRO_CHANNEL_COUNT,
+	.clock = {
+		.freq = PCAN_USBPRO_CRYSTAL_HZ,
+	},
+	.bittiming_const = {
+		.name = "pcan_usb_pro",
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
+	.sizeof_dev_private = sizeof(struct pcan_usb_pro_device),
+	
+   /* timestamps usage */
+   .ts_used_bits = 32,
+	.ts_period = 1000000, /* calibration period in ts. */
+	.us_per_ts_scale = 1, /* us = (ts * scale) >> shift */
+	.us_per_ts_shift = 0,
+
+	/* give here commands/messages in/out endpoints */
+	.ep_msg_in = PCAN_USBPRO_EP_MSGIN,
+	.ep_msg_out = {PCAN_USBPRO_EP_MSGOUT_0, PCAN_USBPRO_EP_MSGOUT_1},
+
+	/* size of rx/tx usb buffers */
+	.rx_buffer_size = PCAN_USBPRO_RX_BUFFER_SIZE,
+	.tx_buffer_size = PCAN_USBPRO_TX_BUFFER_SIZE,
+
+	/* device callbacks */
+	.intf_probe = pcan_usb_pro_probe,
+	.device_init = pcan_usb_pro_init,
+	.device_exit = pcan_usb_pro_exit,
+	.device_free = pcan_usb_pro_free,
+	.device_set_bus = pcan_usb_pro_set_bus,
+	.device_set_bittiming = pcan_usb_pro_set_bittiming,
+	.device_get_device_number = pcan_usb_pro_get_device_number,
+	.device_decode_msg = pcan_usb_pro_decode_msg,
+	.device_encode_msg = pcan_usb_pro_encode_msg,
+	.device_start = pcan_usb_pro_start,
+	.device_stop = pcan_usb_pro_stop,
+};
diff --git a/drivers/net/can/usb/pcan_usb_pro.h b/drivers/net/can/usb/pcan_usb_pro.h
new file mode 100644
index 0000000..5ca80f8
--- /dev/null
+++ b/drivers/net/can/usb/pcan_usb_pro.h
@@ -0,0 +1,468 @@
+/*
+ * CAN driver for PEAK System PCAN-USB-PRO adapter
+ *
+ * Copyright (C) 2011-2012 PEAK-System GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+#ifndef __pcan_usb_pro_h__
+#define __pcan_usb_pro_h__
+
+/* 
+ * USB Vendor Request Data Types
+ */
+
+/* Vendor (other) request */
+#define USB_VENDOR_REQUEST_INFO                   0
+#define USB_VENDOR_REQUEST_ZERO                   1
+#define USB_VENDOR_REQUEST_FKT                    2
+
+/* Vendor Request wValue for XXX_INFO */
+#define USB_VENDOR_REQUEST_wVALUE_INFO_BOOTLOADER  0
+#define USB_VENDOR_REQUEST_wVALUE_INFO_FIRMWARE    1
+#define USB_VENDOR_REQUEST_wVALUE_INFO_uC_CHIPID   2
+#define USB_VENDOR_REQUEST_wVALUE_INFO_USB_CHIPID  3
+#define USB_VENDOR_REQUEST_wVALUE_INFO_DEVICENR	   4	
+#define USB_VENDOR_REQUEST_wVALUE_INFO_CPLD        5
+#define USB_VENDOR_REQUEST_wVALUE_INFO_MODE			6	
+#define USB_VENDOR_REQUEST_wVALUE_INFO_TIMEMODE		7
+
+/* Vendor Request wValue for XXX_ZERO */
+/* Value is Endpoint Number 0-7 */
+
+/* Vendor Request wValue for XXX_FKT */
+#define USB_VENDOR_REQUEST_wVALUE_SETFKT_BOOT       0 // set Bootloader Mode
+#define USB_VENDOR_REQUEST_wVALUE_SETFKT_DEBUG_CAN  1 // not used
+#define USB_VENDOR_REQUEST_wVALUE_SETFKT_DEBUG_LIN  2 // not used
+#define USB_VENDOR_REQUEST_wVALUE_SETFKT_DEBUG1     3 // not used
+#define USB_VENDOR_REQUEST_wVALUE_SETFKT_DEBUG2     4 // not used
+#define USB_VENDOR_REQUEST_wVALUE_SETFKT_INTERFACE_DRIVER_LOADED 5
+
+/* ctrl_type value */
+#define INTERN_FIRMWARE_INFO_STRUCT_TYPE 	0x11223322
+#define EXT_FIRMWARE_INFO_STRUCT_TYPE 		0x11223344
+
+#define BOOTLOADER_INFO_STRUCT_TYPE 		0x11112222
+#define uC_CHIPID_STRUCT_TYPE 				0
+#define USB_CHIPID_STRUCT_TYPE 				0
+#define DEVICE_NR_STRUCT_TYPE 				0x3738393A
+#define CPLD_INFO_STRUCT_TYPE 				0x1A1A2277
+
+/* USB_VENDOR_REQUEST_wVALUE_INFO_BOOTLOADER vendor request record type */
+struct __packed pcan_usb_pro_bootloader_info_t
+{
+	u32 ctrl_type;
+	u8  version[4];		//[0] -> main [1]-> sub [2]-> debug
+	u8  day;
+	u8  month;
+	u8  year;
+	u8  dummy;
+	u32 serial_num_high;
+	u32 serial_num_low;
+	u32 hw_type;
+	u32 hw_rev;
+};
+
+struct __packed pcan_usb_pro_crc_block_t
+{
+	u32 address;
+	u32 len;
+	u32 crc;
+};
+
+/* USB_VENDOR_REQUEST_wVALUE_INFO_FIRMWARE vendor request record type */
+struct __packed pcan_usb_pro_ext_firmware_info_t
+{
+	u32 ctrl_type;
+	u8	 version[4];		//[0] -> main [1]-> sub [2]-> debug
+	u8  day;
+	u8  month;
+	u8  year;
+	u8  dummy;
+	u32 fw_type;
+};
+
+/* USB_VENDOR_REQUEST_wVALUE_INFO_uC_CHIPID vendor request record type */
+struct __packed pcan_usb_pro_uc_chipid_t
+{
+	u32 ctrl_type;
+	u32 chip_id;
+};
+
+/* USB_VENDOR_REQUEST_wVALUE_INFO_USB_CHIPID vendor request record type */
+struct __packed pcan_usb_pro_usb_chipid_t
+{
+	u32 ctrl_type;
+	u32 chip_id;
+};
+
+/* USB_VENDOR_REQUEST_wVALUE_INFO_DEVICENR vendor request record type */
+struct __packed pcan_usb_pro_device_nr_t
+{
+	u32 ctrl_type;
+	u32 device_nr;
+};
+
+/* USB_VENDOR_REQUEST_wVALUE_INFO_CPLD vendor request record type */
+struct __packed pcan_usb_pro_cpld_info_t
+{
+	u32 ctrl_type;
+	u32 cpld_nr;
+};
+
+/* USB_VENDOR_REQUEST_wVALUE_INFO_MODE vendor request record type */
+struct __packed pcan_usb_pro_info_mode_t
+{
+	u32 ctrl_type;
+	u8  mode[16];
+	u8  flags[16];
+};
+
+/* USB_VENDOR_REQUEST_wVALUE_INFO_TIMEMODE vendor request record type */
+struct __packed pcan_usb_pro_time_mode_t
+{
+	u32 ctrl_type;
+	u16 time_mode;
+	u16 flags;
+};
+
+/* 
+ * USB Command Record types 
+ */
+
+#define DATA_TYPE_USB2CAN_STRUCT_CANMSG_RX_8                0x80
+#define DATA_TYPE_USB2CAN_STRUCT_CANMSG_RX_4                0x81
+#define DATA_TYPE_USB2CAN_STRUCT_CANMSG_RX_0                0x82
+#define DATA_TYPE_USB2CAN_STRUCT_CANMSG_RTR_RX              0x83
+#define DATA_TYPE_USB2CAN_STRUCT_CANMSG_STATUS_ERROR_RX     0x84
+#define DATA_TYPE_USB2CAN_STRUCT_CALIBRATION_TIMESTAMP_RX   0x85
+#define DATA_TYPE_USB2CAN_STRUCT_BUSLAST_RX                 0x86
+#define DATA_TYPE_USB2CAN_STRUCT_CANMSG_TX_8                0x41
+#define DATA_TYPE_USB2CAN_STRUCT_CANMSG_TX_4                0x42
+#define DATA_TYPE_USB2CAN_STRUCT_CANMSG_TX_0                0x43
+#define DATA_TYPE_USB2CAN_STRUCT_FKT_GETBAUDRATE            0x01 
+#define DATA_TYPE_USB2CAN_STRUCT_FKT_SETBAUDRATE            0x02
+#define DATA_TYPE_USB2CAN_STRUCT_FKT_GETCANBUSACTIVATE      0x03
+#define DATA_TYPE_USB2CAN_STRUCT_FKT_SETCANBUSACTIVATE      0x04
+#define DATA_TYPE_USB2CAN_STRUCT_FKT_SETSILENTMODE          0x05 
+#define DATA_TYPE_USB2CAN_STRUCT_FKT_SETDEVICENR            0x06 
+#define DATA_TYPE_USB2CAN_STRUCT_FKT_SETWARNINGLIMIT        0x07 
+#define DATA_TYPE_USB2CAN_STRUCT_FKT_SETLOOKUP_EXPLICIT     0x08 
+#define DATA_TYPE_USB2CAN_STRUCT_FKT_SETLOOKUP_GROUP        0x09 
+#define DATA_TYPE_USB2CAN_STRUCT_FKT_SETFILTERMODE          0x0a 
+#define DATA_TYPE_USB2CAN_STRUCT_FKT_SETRESET_MODE          0x0b 
+#define DATA_TYPE_USB2CAN_STRUCT_FKT_SETERRORFRAME          0x0c 
+#define DATA_TYPE_USB2CAN_STRUCT_FKT_GETCANBUS_ERROR_STATUS 0x0D 
+#define DATA_TYPE_USB2CAN_STRUCT_FKT_SETREGISTER            0x0e 
+#define DATA_TYPE_USB2CAN_STRUCT_FKT_GETREGISTER            0x0f 
+#define DATA_TYPE_USB2CAN_STRUCT_FKT_SETGET_CALIBRATION_MSG 0x10 
+#define DATA_TYPE_USB2CAN_STRUCT_FKT_SETGET_BUSLAST_MSG     0x11 
+#define DATA_TYPE_USB2CAN_STRUCT_FKT_GETDEVICENR            0x12 
+#define DATA_TYPE_USB2CAN_STRUCT_FKT_SETSTRING              0x13 
+#define DATA_TYPE_USB2CAN_STRUCT_FKT_GETSTRING              0x14 
+#define DATA_TYPE_USB2CAN_STRUCT_FKT_STRING                 0x15
+#define DATA_TYPE_USB2CAN_STRUCT_FKT_SAVEEEPROM             0x16
+#define DATA_TYPE_USB2CAN_STRUCT_FKT_USB_IN_PACKET_DELAY    0x17
+#define DATA_TYPE_USB2CAN_STRUCT_FKT_TIMESTAMP_PARAM        0x18
+#define DATA_TYPE_USB2CAN_STRUCT_FKT_ERROR_GEN_ID           0x19
+#define DATA_TYPE_USB2CAN_STRUCT_FKT_ERROR_GEN_NOW          0x1A
+#define DATA_TYPE_USB2CAN_STRUCT_FKT_SET_SOFTFILER          0x1B
+#define DATA_TYPE_USB2CAN_STRUCT_FKT_SET_CANLED             0x1C
+
+/* Record structures */
+struct __packed pcan_usb_pro_canmsg_rx_t
+{
+	u8  data_type;
+	u8  client;
+	u8  flags;
+	u8  len;
+	u32 timestamp32;
+	u32 id;
+
+	u8  data[8];
+};
+
+/* Defines for status */
+#define FW_USBPRO_STATUS_MASK_ERROR_S     0x0001
+#define FW_USBPRO_STATUS_MASK_BUS_S       0x0002
+#define FW_USBPRO_STATUS_MASK_OVERRUN_S   0x0004
+#define FW_USBPRO_STATUS_MASK_QOVERRUN_S  0x0008
+
+struct __packed pcan_usb_pro_canmsg_status_error_rx_t
+{
+	u8  data_type;
+	u8  channel;
+	u16 status;
+	u32 timestamp32;
+	u32 error_frame;
+};
+
+struct __packed pcan_usb_pro_calibration_ts_rx_t
+{
+	u8  data_type;
+	u8  dummy[3];
+	u32 timestamp64[2];
+};
+
+struct __packed pcan_usb_pro_buslast_rx_t
+{
+	u8  data_type;
+	u8  channel;                   /* Bit(3..0)-> can channel */
+	u16 buslast_val;
+	u32 timestamp32;
+};
+
+struct __packed pcan_usb_pro_canmsg_tx_t
+{
+	u8  data_type;
+	u8  client;
+	u8  flags;
+	u8  len;
+	u32 id;
+	u8  data[8];
+};
+
+struct __packed pcan_usb_pro_baudrate_t
+{
+	u8  data_type;
+	u8  channel;                   /* Bit(3..0)-> can channel */
+	u16 dummy;
+	u32 CCBT;
+};
+
+struct __packed pcan_usb_pro_bus_activity_t
+{
+	u8  data_type;
+	u8  channel;                   /* Bit(3..0)-> can channel */
+	u16 onoff;                     /* 0->off  1->on */
+};
+
+struct __packed pcan_usb_pro_silent_mode_t
+{
+	u8  data_type;
+	u8  channel;                   /* Bit(3..0)-> can channel */
+	u16 onoff;                     /* 0->off  1->on */
+};
+
+struct __packed pcan_usb_pro_dev_nr_t
+{
+	u8  data_type;
+	u8  channel;                   /* Bit(3..0)-> can channel */
+	u16 dummy;
+	u32 serial_num;
+};
+
+struct __packed pcan_usb_pro_warning_limit_t
+{
+	u8  data_type;
+	u8  channel;                   /* Bit(3..0)-> can channel */
+	u16  warning_limit; 
+};
+
+struct __packed pcan_usb_pro_lookup_explicit_t
+{
+	u8  data_type;
+	u8  channel;                   /* Bit(3..0)-> can channel */
+	u16 id_type; 
+	u32 id; 
+};
+
+struct __packed pcan_usb_pro_lookup_group_t
+{
+	u8  data_type;
+	u8  channel;                   /* Bit(3..0)-> can channel */
+	u16 id_type; 
+	u32 id_start; 
+	u32 id_end; 
+};
+
+struct __packed pcan_usb_pro_filter_mode_t
+{
+	u8  data_type;
+	u8  dummy;
+	u16 filter_mode; 
+};
+
+struct __packed pcan_usb_pro_reset_mode_t
+{
+	u8  data_type;
+	u8  channel;                   /* Bit(3..0)-> can channel */
+	u16 reset; 
+};
+
+struct __packed pcan_usb_pro_error_frame_t
+{
+	u8  data_type;
+	u8  channel;                   /* Bit(3..0)-> can channel */
+	u16 mode; 
+};
+
+struct __packed pcan_usb_pro_error_status_t
+{
+	u8  data_type;
+	u8  channel;                   /* Bit(3..0)-> can channel */
+	u16 status; 
+};
+
+struct __packed pcan_usb_pro_set_register_t
+{
+	u8  data_type;
+	u8  irq_off;
+	u16 dummy;
+	u32 address;
+	u32 value;
+	u32 mask;
+};
+
+struct __packed pcan_usb_pro_get_register_t
+{
+	u8  data_type;
+	u8  irq_off;
+	u16 dummy;
+	u32 address;
+	u32 value;
+};
+
+struct __packed pcan_usb_pro_calibration_t
+{
+	u8  data_type;
+	u8  dummy;
+	u16 mode;
+};
+
+struct __packed pcan_usb_pro_buslast_t
+{
+	u8  data_type;
+	u8  channel;                   /* Bit(3..0)-> can channel */
+	u8  dummy; 
+	u8  mode;
+	u16 prescaler;
+	u16 sampletimequanta;
+};
+
+struct __packed pcan_usb_pro_set_string_t
+{
+	u8  data_type;
+	u8  channel;                   /* Bit(3..0)-> can channel */
+	u8  offset; 
+	u8  len;
+	u8  data[60];
+};
+
+struct __packed pcan_usb_pro_get_string_t
+{
+	u8  data_type;
+	u8  channel;                   /* Bit(3..0)-> can channel */
+	u16 dummy;
+};
+
+struct __packed pcan_usb_pro_string_t
+{
+	u8  data_type;
+	u8  channel;                   /* Bit(3..0)-> can channel */
+	u16 dummy;
+	u8  data[250];
+};
+
+struct __packed pcan_usb_pro_save_eeprom_t
+{
+	u8  data_type;
+	u8  channel;                   /* Bit(3..0)-> can channel */
+	u16 dummy;
+};
+
+struct __packed pcan_usb_pro_packet_delay_t
+{
+	u8	 data_type;
+	u8	 dummy;
+	u16 delay;
+};
+
+struct __packed pcan_usb_pro_timestamp_param_t
+{
+	u8  data_type;
+	u8  channel;                   /* Bit(3..0)-> can channel */
+	u16 start_or_end;
+};
+
+struct __packed pcan_usb_pro_error_gen_id_t
+{
+	u8  data_type;
+	u8  channel;                   /* Bit(3..0)-> can channel */
+	u16 bit_pos;
+	u32 id;
+	u16 ok_counter;
+	u16 error_counter;
+};
+
+struct __packed pcan_usb_pro_error_gen_now_t
+{
+	u8  data_type;
+	u8  channel;                   /* Bit(3..0)-> can channel */
+	u16 bit_pos;
+};
+
+struct __packed pcan_usb_pro_softfiler_t
+{
+	u8  data_type;
+	u8  channel;                   /* Bit(3..0)-> can channel */
+	u16 dummy;
+	u32 accmask;
+	u32 acccode;
+};
+
+struct __packed pcan_usb_pro_set_can_led_t
+{
+	u8  data_type;
+	u8  channel;                   /* Bit(3..0)-> can channel */
+	u16 mode;
+	u32 timeout;
+};
+
+union pcan_usb_pro_rec_t
+{
+	u8	                                  data_type;
+	struct pcan_usb_pro_canmsg_rx_t      canmsg_rx;
+	struct pcan_usb_pro_canmsg_status_error_rx_t canmsg_status_error_rx;
+	struct pcan_usb_pro_calibration_ts_rx_t calibration_ts_rx;
+	struct pcan_usb_pro_buslast_rx_t     buslast_rx;
+	struct pcan_usb_pro_canmsg_tx_t      canmsg_tx;
+	struct pcan_usb_pro_baudrate_t       baudrate;
+	struct pcan_usb_pro_bus_activity_t   bus_activity;
+	struct pcan_usb_pro_silent_mode_t    silent_mode;
+	struct pcan_usb_pro_dev_nr_t         dev_nr;
+	struct pcan_usb_pro_warning_limit_t  warning_limit;
+	struct pcan_usb_pro_lookup_explicit_t lookup_explicit;
+	struct pcan_usb_pro_lookup_group_t   lookup_group;
+	struct pcan_usb_pro_filter_mode_t    filer_mode;
+	struct pcan_usb_pro_reset_mode_t     reset_mode;
+	struct pcan_usb_pro_error_frame_t    error_frame;
+	struct pcan_usb_pro_error_status_t   error_status;
+	struct pcan_usb_pro_set_register_t	set_register;
+	struct pcan_usb_pro_get_register_t   get_register;
+	struct pcan_usb_pro_calibration_t    calibration;
+	struct pcan_usb_pro_buslast_t        buslast;
+	struct pcan_usb_pro_set_string_t     set_string;
+	struct pcan_usb_pro_get_string_t     get_string;
+	struct pcan_usb_pro_string_t         string;
+	struct pcan_usb_pro_save_eeprom_t    save_eeprom;
+	struct pcan_usb_pro_packet_delay_t   packet_delay;
+	struct pcan_usb_pro_timestamp_param_t timestamp_param;
+	struct pcan_usb_pro_error_gen_id_t   error_gen_id;
+	struct pcan_usb_pro_error_gen_now_t  error_gen_now;
+	struct pcan_usb_pro_softfiler_t      softfiler;
+	struct pcan_usb_pro_set_can_led_t    set_can_led;
+};
+
+#endif
diff --git a/drivers/net/can/usb/peak_usb.h b/drivers/net/can/usb/peak_usb.h
new file mode 100644
index 0000000..01ded93
--- /dev/null
+++ b/drivers/net/can/usb/peak_usb.h
@@ -0,0 +1,148 @@
+/*
+ * CAN driver for PEAK System USB adapters
+ *
+ * Copyright (C) 2011-2012 PEAK-System GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+#ifndef __peak_usb_h__
+#define __peak_usb_h__
+
+/* PEAK-System USB driver version */
+#define PCAN_USB_VERSION_MAJOR         0
+#define PCAN_USB_VERSION_MINOR         4
+#define PCAN_USB_VERSION_SUBMINOR      2
+
+/* PEAK-System vendor id. */
+#define PCAN_USB_VENDOR_ID    0x0c72
+
+/* Driver name */
+#define PCAN_USB_DRIVER_NAME  "peak_usb"
+
+/* Number of urbs that are submitted for rx/tx per channel */
+#define PCAN_USB_MAX_RX_URBS     4
+#define PCAN_USB_MAX_TX_URBS     10
+
+/* PEAK-System usb adapters maximum channels per usb interface */
+#define PCAN_USB_MAX_CHANNEL     2
+
+struct peak_usb_adapter; 
+struct peak_usb_device; 
+
+/* PEAK-System USB adapter descriptor */
+struct peak_usb_adapter {
+	char *name;
+	u32 device_id;
+	struct can_clock clock;
+	struct can_bittiming_const bittiming_const;
+	unsigned int ctrl_count;
+
+	int (*intf_probe)(struct usb_interface *intf);
+	int (*device_init)(struct peak_usb_device *);
+	void (*device_exit)(struct peak_usb_device *);
+	void (*device_free)(struct peak_usb_device *);
+	int (*device_open)(struct peak_usb_device *);
+	int (*device_close)(struct peak_usb_device *);
+	int (*device_set_bittiming)(struct peak_usb_device *, struct can_bittiming *bt);
+	int (*device_set_bus)(struct peak_usb_device *, u8 onoff);
+	int (*device_get_device_number)(struct peak_usb_device *, u32 *device_number);
+	int (*device_decode_msg)(struct peak_usb_device *dev, struct urb *);
+	int (*device_encode_msg)(struct peak_usb_device *dev, struct sk_buff *, u8 *obuf, size_t *size);
+	int (*device_start)(struct peak_usb_device *dev);
+	int (*device_stop)(struct peak_usb_device *dev);
+
+	u8 ep_msg_in;
+	u8 ep_msg_out[PCAN_USB_MAX_CHANNEL];
+	u8 ts_used_bits;
+	u32 ts_period;
+	u8 us_per_ts_shift;
+	u32 us_per_ts_scale;
+
+	int rx_buffer_size;
+	int tx_buffer_size;
+	int sizeof_dev_private;
+};
+
+struct peak_time_ref {
+	struct timeval tv_host_0, tv_host;
+	u32 ts_dev_1, ts_dev_2;
+	u64 ts_total;
+	u32 tick_count;
+	struct peak_usb_adapter *adapter;
+};
+
+struct peak_tx_urb_context {
+	struct peak_usb_device *dev;
+	u32 echo_index;
+	u8 dlc;
+	struct urb *urb;
+};
+
+#define PCAN_USB_STATE_CONNECTED   0x00000001
+
+/* PCAN-USB device */
+struct peak_usb_device {
+	struct can_priv can; /* must be the first member */
+	struct peak_usb_adapter *adapter;
+	unsigned int ctrl_index;
+	int open_time;
+	u32 state;
+
+	struct sk_buff *echo_skb[PCAN_USB_MAX_TX_URBS];
+
+	struct usb_device *udev;
+	struct net_device *netdev;
+
+	atomic_t active_tx_urbs;
+	struct usb_anchor tx_submitted;
+	struct peak_tx_urb_context tx_contexts[PCAN_USB_MAX_TX_URBS];
+
+	struct usb_anchor rx_submitted;
+
+	u32 device_number;
+	u8 device_num;
+	u8 device_rev;
+
+	u8 ep_msg_in;
+	u8 ep_msg_out;
+
+	u16 bus_load;
+
+	struct peak_usb_device *prev_siblings;
+	struct peak_usb_device *next_siblings;
+};
+
+/* supported device ids. */
+#if defined(CONFIG_CAN_PCAN_USB) || defined(CONFIG_CAN_PCAN_USB_MODULE)
+#define PCAN_USB_PRODUCT_ID    0x000c
+extern struct peak_usb_adapter pcan_usb;
+#endif
+
+#if defined(CONFIG_CAN_PCAN_USB_PRO) || defined(CONFIG_CAN_PCAN_USB_PRO_MODULE)
+#define PCAN_USBPRO_PRODUCT_ID 0x000d
+extern struct peak_usb_adapter pcan_usb_pro;
+#endif
+
+void dump_mem(char *prompt, void *p, int l);
+
+/* reject device usb interface */
+int peak_usb_no_dev(struct usb_interface *intf);
+
+/* timestamp management */
+void peak_usb_init_time_ref(struct peak_time_ref *, struct peak_usb_adapter *);
+void peak_usb_set_timestamp_now(struct peak_time_ref *, u32 ts_now);
+void peak_usb_update_timestamp_now(struct peak_time_ref *, u32 ts_now);
+void peak_usb_get_timestamp_tv(struct peak_time_ref *, u32 ts, struct timeval *);
+
+#endif
-- 
1.7.1



------MIME delimiter for sendEmail-703319.406676204--

