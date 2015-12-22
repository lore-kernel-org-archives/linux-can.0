From: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH 1/1]can:ems_usb:Fix possible tx overflow
Date: Tue, 22 Dec 2015 17:29:16 +0100
Message-ID: <1450801756-21426-1-git-send-email-uttenthaler@ems-wuensche.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.ems-wuensche.com ([85.214.92.62]:48566 "EHLO
	mail.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932079AbbLVQhR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 22 Dec 2015 11:37:17 -0500
Received: from localhost (localhost [127.0.0.1])
	by h559305.serverkompetenz.net (Postfix) with ESMTP id 138AD30803E
	for <linux-can@vger.kernel.org>; Tue, 22 Dec 2015 17:28:52 +0100 (CET)
Received: from mail.ems-wuensche.com ([127.0.0.1])
	by localhost (h559305.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HZE-2F93UuF4 for <linux-can@vger.kernel.org>;
	Tue, 22 Dec 2015 17:28:47 +0100 (CET)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>

This patch fixes the problem that more CAN messages could besent to 
the interface as could be send on the CAN bus. This was more likely
for slow baud rates. The sleeping _start_xmit was woken up in the
_write_bulk_callback. Under heavy TX load this produced another 
bulk transfer without checking the free_slots variable and hence
caused the overflow in the interface.

Signed-off-by: Gerhard uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/usb/ems_usb.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index fc5b756..eb7192f 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -117,6 +117,9 @@ MODULE_LICENSE("GPL v2");
  */
 #define EMS_USB_ARM7_CLOCK 8000000
 
+#define CPC_TX_QUEUE_TRIGGER_LOW	25
+#define CPC_TX_QUEUE_TRIGGER_HIGH	35
+
 /*
  * CAN-Message representation in a CPC_MSG. Message object type is
  * CPC_MSG_TYPE_CAN_FRAME or CPC_MSG_TYPE_RTR_FRAME or
@@ -278,6 +281,11 @@ static void ems_usb_read_interrupt_callback(struct urb *urb)
 	switch (urb->status) {
 	case 0:
 		dev->free_slots = dev->intr_in_buffer[1];
+		if(dev->free_slots > CPC_TX_QUEUE_TRIGGER_HIGH){
+			if (netif_queue_stopped(netdev)){
+				netif_wake_queue(netdev);
+			}
+		}
 		break;
 
 	case -ECONNRESET: /* unlink */
@@ -526,8 +534,6 @@ static void ems_usb_write_bulk_callback(struct urb *urb)
 	/* Release context */
 	context->echo_index = MAX_TX_URBS;
 
-	if (netif_queue_stopped(netdev))
-		netif_wake_queue(netdev);
 }
 
 /*
@@ -587,7 +593,7 @@ static int ems_usb_start(struct ems_usb *dev)
 	int err, i;
 
 	dev->intr_in_buffer[0] = 0;
-	dev->free_slots = 15; /* initial size */
+	dev->free_slots = 50; /* initial size */
 
 	for (i = 0; i < MAX_RX_URBS; i++) {
 		struct urb *urb = NULL;
@@ -835,7 +841,7 @@ static netdev_tx_t ems_usb_start_xmit(struct sk_buff *skb, struct net_device *ne
 
 		/* Slow down tx path */
 		if (atomic_read(&dev->active_tx_urbs) >= MAX_TX_URBS ||
-		    dev->free_slots < 5) {
+		    dev->free_slots < CPC_TX_QUEUE_TRIGGER_LOW) {
 			netif_stop_queue(netdev);
 		}
 	}
-- 
1.8.4.5

-- 
EMS Dr. Thomas Wuensche e.K.
Sonnenhang 3
85304 Ilmmuenster
HRA Neuburg a.d. Donau, HR-Nr. 70.106

Phone: +49-8441-490260
Fax  : +49-8441-81860
http://www.ems-wuensche.com
