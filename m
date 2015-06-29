From: Nik Nyby <nikolas@gnu.org>
Subject: [PATCH] can: gs_usb: Fix typo in function name
Date: Mon, 29 Jun 2015 19:09:57 -0400
Message-ID: <1435619397-9333-1-git-send-email-nikolas@gnu.org>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from eggs.gnu.org ([208.118.235.92]:46498 "EHLO eggs.gnu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751080AbbF2XK0 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 29 Jun 2015 19:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikolas@gnu.org>)
	id 1Z9iBv-0002fP-Iz
	for linux-can@vger.kernel.org; Mon, 29 Jun 2015 19:10:25 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org, trivial@kernel.org
Cc: Nik Nyby <nikolas@gnu.org>

This fixes typos in gs_usb.c where 'receive' is misspelled
as 'recieve'.

Signed-off-by: Nik Nyby <nikolas@gnu.org>
---
 drivers/net/can/usb/gs_usb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 8b4d3e6..5eee62b 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -162,7 +162,7 @@ struct gs_can {
 	struct can_bittiming_const bt_const;
 	unsigned int channel;	/* channel number */
 
-	/* This lock prevents a race condition between xmit and recieve. */
+	/* This lock prevents a race condition between xmit and receive. */
 	spinlock_t tx_ctx_lock;
 	struct gs_tx_context tx_context[GS_MAX_TX_URBS];
 
@@ -274,7 +274,7 @@ static void gs_update_state(struct gs_can *dev, struct can_frame *cf)
 	}
 }
 
-static void gs_usb_recieve_bulk_callback(struct urb *urb)
+static void gs_usb_receive_bulk_callback(struct urb *urb)
 {
 	struct gs_usb *usbcan = urb->context;
 	struct gs_can *dev;
@@ -376,7 +376,7 @@ static void gs_usb_recieve_bulk_callback(struct urb *urb)
 			  usb_rcvbulkpipe(usbcan->udev, GSUSB_ENDPOINT_IN),
 			  hf,
 			  sizeof(struct gs_host_frame),
-			  gs_usb_recieve_bulk_callback,
+			  gs_usb_receive_bulk_callback,
 			  usbcan
 			  );
 
@@ -605,7 +605,7 @@ static int gs_can_open(struct net_device *netdev)
 							  GSUSB_ENDPOINT_IN),
 					  buf,
 					  sizeof(struct gs_host_frame),
-					  gs_usb_recieve_bulk_callback,
+					  gs_usb_receive_bulk_callback,
 					  parent);
 			urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 
-- 
2.1.4

