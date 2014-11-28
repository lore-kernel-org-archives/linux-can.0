From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH] can/peak_usb: fix memset() usage
Date: Fri, 28 Nov 2014 14:08:48 +0100
Message-ID: <1417180128-28509-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:25220 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbaK1NIa (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 28 Nov 2014 08:08:30 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Stephane Grosjean <s.grosjean@peak-system.com>

This patchs fixes a misplaced call to memset() that fills the request
buffer with 0. The problem was with sending PCAN_USBPRO_REQ_FCT
requests, the content set by the caller was thus lost.

With this patch, the memory area is zeroed only when requesting info
from the device.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 263dd92..f7f796a 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -333,8 +333,6 @@ static int pcan_usb_pro_send_req(struct peak_usb_device *dev, int req_id,
 	if (!(dev->state & PCAN_USB_STATE_CONNECTED))
 		return 0;
 
-	memset(req_addr, '\0', req_size);
-
 	req_type = USB_TYPE_VENDOR | USB_RECIP_OTHER;
 
 	switch (req_id) {
@@ -345,6 +343,7 @@ static int pcan_usb_pro_send_req(struct peak_usb_device *dev, int req_id,
 	default:
 		p = usb_rcvctrlpipe(dev->udev, 0);
 		req_type |= USB_DIR_IN;
+		memset(req_addr, '\0', req_size);
 		break;
 	}
 
-- 
1.9.1

