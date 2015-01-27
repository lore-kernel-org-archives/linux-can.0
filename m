From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v10 7/9] can/peak_usb: export pcan_usb_pro functions
Date: Tue, 27 Jan 2015 17:41:48 +0100
Message-ID: <1422376910-23754-8-git-send-email-mkl@pengutronix.de>
References: <1422376910-23754-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34185 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758096AbbA0QmB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 27 Jan 2015 11:42:01 -0500
In-Reply-To: <1422376910-23754-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

From: Stephane Grosjean <s.grosjean@peak-system.com>

Add support for the following new PEAK-System technik CANFD USB adapters:

PCAN-USB FD             single CANFD channel USB adapter
PCAN-USB Pro FD         dual CANFD channels USB adapter

The communication protocol has been developed using some mechanisms that
did exist in the PCAN-USB Pro, thus, this patch also changes some
previously static functions and data into global ones.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 16 ++++------------
 drivers/net/can/usb/peak_usb/pcan_usb_pro.h | 13 +++++++++++++
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 03f517160a67..dec51717635e 100644
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
@@ -475,7 +467,7 @@ static int pcan_usb_pro_set_bittiming(struct peak_usb_device *dev,
 	return pcan_usb_pro_set_bitrate(dev, ccbt);
 }
 
-static void pcan_usb_pro_restart_complete(struct urb *urb)
+void pcan_usb_pro_restart_complete(struct urb *urb)
 {
 	/* can delete usb resources */
 	peak_usb_async_complete(urb);
@@ -978,7 +970,7 @@ static void pcan_usb_pro_free(struct peak_usb_device *dev)
 /*
  * probe function for new PCAN-USB Pro usb interface
  */
-static int pcan_usb_pro_probe(struct usb_interface *intf)
+int pcan_usb_pro_probe(struct usb_interface *intf)
 {
 	struct usb_host_interface *if_desc;
 	int i;
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.h b/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
index 837cee267132..a62f7ab8980f 100644
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
@@ -176,4 +184,9 @@ union pcan_usb_pro_rec {
 	struct pcan_usb_pro_txmsg	tx_msg;
 };
 
+int pcan_usb_pro_probe(struct usb_interface *intf);
+int pcan_usb_pro_send_req(struct peak_usb_device *dev, int req_id,
+			  int req_value, void *req_addr, int req_size);
+void pcan_usb_pro_restart_complete(struct urb *urb);
+
 #endif
-- 
2.1.4

