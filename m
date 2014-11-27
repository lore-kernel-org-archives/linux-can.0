From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 1/3] can/peak_usb: CAN-FD: existing source files modifications
Date: Thu, 27 Nov 2014 11:32:07 +0100
Message-ID: <1417084329-8997-2-git-send-email-s.grosjean@peak-system.com>
References: <1417084329-8997-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:60961 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbaK0Kem (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 27 Nov 2014 05:34:42 -0500
In-Reply-To: <1417084329-8997-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Stephane Grosjean <s.grosjean@peak-system.com>

This patch does some modifications to the existing files that support the
PEAK-System Technik CAN 2.0b USB adapters, for preparing the support of CAN-FD.

In particular, this patch changes some static identifiers into global ones, to
share common functionalities with the further incoming CAN-FD specific source
files.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c     |  1 +
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 22 +++++++---------------
 drivers/net/can/usb/peak_usb/pcan_usb_pro.h |  8 ++++++++
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 925ab8e..10a4ceb 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -858,6 +858,7 @@ struct peak_usb_adapter pcan_usb = {
 	.name = "PCAN-USB",
 	.device_id = PCAN_USB_PRODUCT_ID,
 	.ctrl_count = 1,
+	.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY,
 	.clock = {
 		.freq = PCAN_USB_CRYSTAL_HZ / 2 ,
 	},
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 263dd92..10887b0 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -27,14 +27,6 @@
 
 MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB Pro adapter");
 
-/* PCAN-USB Pro Endpoints */
-#define PCAN_USBPRO_EP_CMDOUT		1
-#define PCAN_USBPRO_EP_CMDIN		(PCAN_USBPRO_EP_CMDOUT | USB_DIR_IN)
-#define PCAN_USBPRO_EP_MSGOUT_0		2
-#define PCAN_USBPRO_EP_MSGIN		(PCAN_USBPRO_EP_MSGOUT_0 | USB_DIR_IN)
-#define PCAN_USBPRO_EP_MSGOUT_1		3
-#define PCAN_USBPRO_EP_UNUSED		(PCAN_USBPRO_EP_MSGOUT_1 | USB_DIR_IN)
-
 #define PCAN_USBPRO_CHANNEL_COUNT	2
 
 /* PCAN-USB Pro adapter internal clock (MHz) */
@@ -322,8 +314,8 @@ static int pcan_usb_pro_wait_rsp(struct peak_usb_device *dev,
 	return (i >= PCAN_USBPRO_RSP_SUBMIT_MAX) ? -ERANGE : err;
 }
 
-static int pcan_usb_pro_send_req(struct peak_usb_device *dev, int req_id,
-				 int req_value, void *req_addr, int req_size)
+int pcan_usb_pro_send_req(struct peak_usb_device *dev, int req_id,
+			  int req_value, void *req_addr, int req_size)
 {
 	int err;
 	u8 req_type;
@@ -333,8 +325,6 @@ static int pcan_usb_pro_send_req(struct peak_usb_device *dev, int req_id,
 	if (!(dev->state & PCAN_USB_STATE_CONNECTED))
 		return 0;
 
-	memset(req_addr, '\0', req_size);
-
 	req_type = USB_TYPE_VENDOR | USB_RECIP_OTHER;
 
 	switch (req_id) {
@@ -345,6 +335,7 @@ static int pcan_usb_pro_send_req(struct peak_usb_device *dev, int req_id,
 	default:
 		p = usb_rcvctrlpipe(dev->udev, 0);
 		req_type |= USB_DIR_IN;
+		memset(req_addr, '\0', req_size);
 		break;
 	}
 
@@ -476,7 +467,7 @@ static int pcan_usb_pro_set_bittiming(struct peak_usb_device *dev,
 	return pcan_usb_pro_set_bitrate(dev, ccbt);
 }
 
-static void pcan_usb_pro_restart_complete(struct urb *urb)
+void pcan_usb_pro_restart_complete(struct urb *urb)
 {
 	/* can delete usb resources */
 	peak_usb_async_complete(urb);
@@ -932,7 +923,7 @@ static int pcan_usb_pro_init(struct peak_usb_device *dev)
 
 	return 0;
 
- err_out:
+err_out:
 	kfree(bi);
 	kfree(fi);
 	kfree(usb_if);
@@ -978,7 +969,7 @@ static void pcan_usb_pro_free(struct peak_usb_device *dev)
 /*
  * probe function for new PCAN-USB Pro usb interface
  */
-static int pcan_usb_pro_probe(struct usb_interface *intf)
+int pcan_usb_pro_probe(struct usb_interface *intf)
 {
 	struct usb_host_interface *if_desc;
 	int i;
@@ -1016,6 +1007,7 @@ struct peak_usb_adapter pcan_usb_pro = {
 	.name = "PCAN-USB Pro",
 	.device_id = PCAN_USBPRO_PRODUCT_ID,
 	.ctrl_count = PCAN_USBPRO_CHANNEL_COUNT,
+	.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY,
 	.clock = {
 		.freq = PCAN_USBPRO_CRYSTAL_HZ,
 	},
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.h b/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
index 32275af..1101c9c 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
@@ -27,6 +27,14 @@
 #define PCAN_USBPRO_INFO_BL		0
 #define PCAN_USBPRO_INFO_FW		1
 
+/* PCAN-USB Pro (FD) Endpoints */
+#define PCAN_USBPRO_EP_CMDOUT		1
+#define PCAN_USBPRO_EP_CMDIN		(PCAN_USBPRO_EP_CMDOUT | USB_DIR_IN)
+#define PCAN_USBPRO_EP_MSGOUT_0		2
+#define PCAN_USBPRO_EP_MSGIN		(PCAN_USBPRO_EP_MSGOUT_0 | USB_DIR_IN)
+#define PCAN_USBPRO_EP_MSGOUT_1		3
+#define PCAN_USBPRO_EP_UNUSED		(PCAN_USBPRO_EP_MSGOUT_1 | USB_DIR_IN)
+
 /* Vendor Request value for XXX_FCT */
 #define PCAN_USBPRO_FCT_DRVLD		5 /* tell device driver is loaded */
 #define PCAN_USBPRO_FCT_DRVLD_REQ_LEN	16
-- 
1.9.1

