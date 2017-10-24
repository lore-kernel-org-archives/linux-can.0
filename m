From: Jimmy Assarsson <jimmyassarsson@gmail.com>
Subject: [PATCH 2/2] can: kvaser_usb: Ignore CMD_FLUSH_QUEUE_REPLY messages
Date: Tue, 24 Oct 2017 12:23:29 +0200
Message-ID: <20171024102329.28526-3-jimmyassarsson@gmail.com>
References: <20171024102329.28526-1-jimmyassarsson@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:49765 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932306AbdJXKY1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 24 Oct 2017 06:24:27 -0400
Received: by mail-lf0-f65.google.com with SMTP id w21so23429296lfc.6
        for <linux-can@vger.kernel.org>; Tue, 24 Oct 2017 03:24:26 -0700 (PDT)
In-Reply-To: <20171024102329.28526-1-jimmyassarsson@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>

To avoid kernel warning "Unhandled message (68)", ignore the
CMD_FLUSH_QUEUE_REPLY message for now.

As of Leaf v2 firmware version v4.1.844 (2017-02-15), flush tx queue is
synchronous. There is a capability bit indicating whether flushing tx queue
is synchronous or asynchronous.

A proper solution would be to query the device for capabilities. If the
synchronous tx flush capability bit is set, we should wait for
CMD_FLUSH_QUEUE_REPLY message, while flushing the tx queue.

Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
---
 drivers/net/can/usb/kvaser_usb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
index 861e90efab86..9b18d96ef526 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -137,6 +137,7 @@ static inline bool kvaser_is_usbcan(const struct usb_device_id *id)
 #define CMD_RESET_ERROR_COUNTER		49
 #define CMD_TX_ACKNOWLEDGE		50
 #define CMD_CAN_ERROR_EVENT		51
+#define CMD_FLUSH_QUEUE_REPLY		68
 
 #define CMD_LEAF_USB_THROTTLE		77
 #define CMD_LEAF_LOG_MESSAGE		106
@@ -1301,6 +1302,11 @@ static void kvaser_usb_handle_message(const struct kvaser_usb *dev,
 			goto warn;
 		break;
 
+	case CMD_FLUSH_QUEUE_REPLY:
+		if (dev->family != KVASER_LEAF)
+			goto warn;
+		break;
+
 	default:
 warn:		dev_warn(dev->udev->dev.parent,
 			 "Unhandled message (%d)\n", msg->id);
-- 
2.14.2

