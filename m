From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 1/2] can: usb: Add support of PCAN-Chip USB stamp module
Date: Mon, 27 Mar 2017 14:36:10 +0200
Message-ID: <1490618171-3128-2-git-send-email-s.grosjean@peak-system.com>
References: <1490618171-3128-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:37076 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751813AbdC0Mgf (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 27 Mar 2017 08:36:35 -0400
In-Reply-To: <1490618171-3128-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>

This patch adds the support of the PCAN-Chip USB, a stamp module for
customer hardware designs, which communicates via USB 2.0 with the
hardware. The integrated CAN controller supports the protocols CAN 2.0 A/B
as well as CAN FD. The physical CAN connection is determined by external
wiring. The Stamp module with its single-sided mounting and plated
half-holes is suitable for automatic assembly.

Note that the chip is equipped with the same logic than the PCAN-USB FD.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/Kconfig                  |  1 +
 drivers/net/can/usb/peak_usb/pcan_usb_core.c |  2 +
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  2 +
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 72 ++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+)

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index 8483a40..3f8adc3 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -72,6 +72,7 @@ config CAN_PEAK_USB
 	  PCAN-USB Pro         dual CAN 2.0b channels USB adapter
 	  PCAN-USB FD          single CAN-FD channel USB adapter
 	  PCAN-USB Pro FD      dual CAN-FD channels USB adapter
+	  PCAN-Chip USB        CAN-FD to USB stamp module
 
 	  (see also http://www.peak-system.com).
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 0b0302a..57913db 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -39,6 +39,7 @@ static struct usb_device_id peak_usb_table[] = {
 	{USB_DEVICE(PCAN_USB_VENDOR_ID, PCAN_USBPRO_PRODUCT_ID)},
 	{USB_DEVICE(PCAN_USB_VENDOR_ID, PCAN_USBFD_PRODUCT_ID)},
 	{USB_DEVICE(PCAN_USB_VENDOR_ID, PCAN_USBPROFD_PRODUCT_ID)},
+	{USB_DEVICE(PCAN_USB_VENDOR_ID, PCAN_USBCHIP_PRODUCT_ID)},
 	{USB_DEVICE(PCAN_USB_VENDOR_ID, PCAN_USBX6_PRODUCT_ID)},
 	{} /* Terminating entry */
 };
@@ -51,6 +52,7 @@ static const struct peak_usb_adapter *const peak_usb_adapters_list[] = {
 	&pcan_usb_pro,
 	&pcan_usb_fd,
 	&pcan_usb_pro_fd,
+	&pcan_usb_chip,
 	&pcan_usb_x6,
 };
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index 3cbfb06..c01316ca 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -27,6 +27,7 @@
 #define PCAN_USBPRO_PRODUCT_ID		0x000d
 #define PCAN_USBPROFD_PRODUCT_ID	0x0011
 #define PCAN_USBFD_PRODUCT_ID		0x0012
+#define PCAN_USBCHIP_PRODUCT_ID		0x0013
 #define PCAN_USBX6_PRODUCT_ID		0x0014
 
 #define PCAN_USB_DRIVER_NAME		"peak_usb"
@@ -90,6 +91,7 @@ struct peak_usb_adapter {
 extern const struct peak_usb_adapter pcan_usb;
 extern const struct peak_usb_adapter pcan_usb_pro;
 extern const struct peak_usb_adapter pcan_usb_fd;
+extern const struct peak_usb_adapter pcan_usb_chip;
 extern const struct peak_usb_adapter pcan_usb_pro_fd;
 extern const struct peak_usb_adapter pcan_usb_x6;
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 175c205..b141204 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -1062,6 +1062,78 @@ const struct peak_usb_adapter pcan_usb_fd = {
 	.do_get_berr_counter = pcan_usb_fd_get_berr_counter,
 };
 
+/* describes the PCAN-CHIP USB */
+static const struct can_bittiming_const pcan_usb_chip_const = {
+	.name = "pcan_chip_usb",
+	.tseg1_min = 1,
+	.tseg1_max = (1 << PUCAN_TSLOW_TSGEG1_BITS),
+	.tseg2_min = 1,
+	.tseg2_max = (1 << PUCAN_TSLOW_TSGEG2_BITS),
+	.sjw_max = (1 << PUCAN_TSLOW_SJW_BITS),
+	.brp_min = 1,
+	.brp_max = (1 << PUCAN_TSLOW_BRP_BITS),
+	.brp_inc = 1,
+};
+
+static const struct can_bittiming_const pcan_usb_chip_data_const = {
+	.name = "pcan_chip_usb",
+	.tseg1_min = 1,
+	.tseg1_max = (1 << PUCAN_TFAST_TSGEG1_BITS),
+	.tseg2_min = 1,
+	.tseg2_max = (1 << PUCAN_TFAST_TSGEG2_BITS),
+	.sjw_max = (1 << PUCAN_TFAST_SJW_BITS),
+	.brp_min = 1,
+	.brp_max = (1 << PUCAN_TFAST_BRP_BITS),
+	.brp_inc = 1,
+};
+
+const struct peak_usb_adapter pcan_usb_chip = {
+	.name = "PCAN-Chip USB",
+	.device_id = PCAN_USBCHIP_PRODUCT_ID,
+	.ctrl_count = PCAN_USBFD_CHANNEL_COUNT,
+	.ctrlmode_supported = CAN_CTRLMODE_FD |
+			CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY,
+	.clock = {
+		.freq = PCAN_UFD_CRYSTAL_HZ,
+	},
+	.bittiming_const = &pcan_usb_chip_const,
+	.data_bittiming_const = &pcan_usb_chip_data_const,
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
+
+	.do_get_berr_counter = pcan_usb_fd_get_berr_counter,
+};
+
 /* describes the PCAN-USB Pro FD adapter */
 static const struct can_bittiming_const pcan_usb_pro_fd_const = {
 	.name = "pcan_usb_pro_fd",
-- 
2.7.4

