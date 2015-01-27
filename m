From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v11 03/10] can: peak_usb: constify struct peak_usb_adapter
Date: Tue, 27 Jan 2015 19:30:31 +0100
Message-ID: <1422383438-7432-4-git-send-email-mkl@pengutronix.de>
References: <1422383438-7432-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44660 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757561AbbA0Sap (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 27 Jan 2015 13:30:45 -0500
In-Reply-To: <1422383438-7432-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

A "struct peak_usb_adapter" describes a certain USB adapter, as this doesn't
change during runtime, this patch marks all USB adapter definitions as const.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c      |  2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c |  8 ++++----
 drivers/net/can/usb/peak_usb/pcan_usb_core.h | 10 +++++-----
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 2a1c9ce53fae..d57d3f64a5bf 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -855,7 +855,7 @@ static int pcan_usb_probe(struct usb_interface *intf)
 /*
  * describe the PCAN-USB adapter
  */
-struct peak_usb_adapter pcan_usb = {
+const struct peak_usb_adapter pcan_usb = {
 	.name = "PCAN-USB",
 	.device_id = PCAN_USB_PRODUCT_ID,
 	.ctrl_count = 1,
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 26c0cc3ce3b2..729b80d78322 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -43,7 +43,7 @@ static struct usb_device_id peak_usb_table[] = {
 MODULE_DEVICE_TABLE(usb, peak_usb_table);
 
 /* List of supported PCAN-USB adapters (NULL terminated list) */
-static struct peak_usb_adapter *peak_usb_adapters_list[] = {
+static const struct peak_usb_adapter *const peak_usb_adapters_list[] = {
 	&pcan_usb,
 	&pcan_usb_pro,
 };
@@ -64,7 +64,7 @@ void pcan_dump_mem(char *prompt, void *p, int l)
  * initialize a time_ref object with usb adapter own settings
  */
 void peak_usb_init_time_ref(struct peak_time_ref *time_ref,
-			    struct peak_usb_adapter *adapter)
+			    const struct peak_usb_adapter *adapter)
 {
 	if (time_ref) {
 		memset(time_ref, 0, sizeof(struct peak_time_ref));
@@ -708,7 +708,7 @@ static const struct net_device_ops peak_usb_netdev_ops = {
  * create one device which is attached to CAN controller #ctrl_idx of the
  * usb adapter.
  */
-static int peak_usb_create_dev(struct peak_usb_adapter *peak_usb_adapter,
+static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 			       struct usb_interface *intf, int ctrl_idx)
 {
 	struct usb_device *usb_dev = interface_to_usbdev(intf);
@@ -856,7 +856,7 @@ static int peak_usb_probe(struct usb_interface *intf,
 {
 	struct usb_device *usb_dev = interface_to_usbdev(intf);
 	const u16 usb_id_product = le16_to_cpu(usb_dev->descriptor.idProduct);
-	struct peak_usb_adapter *peak_usb_adapter = NULL;
+	const struct peak_usb_adapter *peak_usb_adapter = NULL;
 	int i, err = -ENOMEM;
 
 	usb_dev = interface_to_usbdev(intf);
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index 073b47ff8eee..10f2fcac7c13 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -78,15 +78,15 @@ struct peak_usb_adapter {
 	int sizeof_dev_private;
 };
 
-extern struct peak_usb_adapter pcan_usb;
-extern struct peak_usb_adapter pcan_usb_pro;
+extern const struct peak_usb_adapter pcan_usb;
+extern const struct peak_usb_adapter pcan_usb_pro;
 
 struct peak_time_ref {
 	struct timeval tv_host_0, tv_host;
 	u32 ts_dev_1, ts_dev_2;
 	u64 ts_total;
 	u32 tick_count;
-	struct peak_usb_adapter *adapter;
+	const struct peak_usb_adapter *adapter;
 };
 
 struct peak_tx_urb_context {
@@ -102,7 +102,7 @@ struct peak_tx_urb_context {
 /* PEAK-System USB device */
 struct peak_usb_device {
 	struct can_priv can;
-	struct peak_usb_adapter *adapter;
+	const struct peak_usb_adapter *adapter;
 	unsigned int ctrl_idx;
 	u32 state;
 
@@ -134,7 +134,7 @@ void pcan_dump_mem(char *prompt, void *p, int l);
 
 /* common timestamp management */
 void peak_usb_init_time_ref(struct peak_time_ref *time_ref,
-			    struct peak_usb_adapter *adapter);
+			    const struct peak_usb_adapter *adapter);
 void peak_usb_update_ts_now(struct peak_time_ref *time_ref, u32 ts_now);
 void peak_usb_set_ts_now(struct peak_time_ref *time_ref, u32 ts_now);
 void peak_usb_get_ts_tv(struct peak_time_ref *time_ref, u32 ts,
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 145fa87c31b9..56855b2b1fa1 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -1012,7 +1012,7 @@ static int pcan_usb_pro_probe(struct usb_interface *intf)
 /*
  * describe the PCAN-USB Pro adapter
  */
-struct peak_usb_adapter pcan_usb_pro = {
+const struct peak_usb_adapter pcan_usb_pro = {
 	.name = "PCAN-USB Pro",
 	.device_id = PCAN_USBPRO_PRODUCT_ID,
 	.ctrl_count = PCAN_USBPRO_CHANNEL_COUNT,
-- 
2.1.4

