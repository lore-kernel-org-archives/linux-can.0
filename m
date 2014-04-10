From: Olivier Sobrie <olivier@sobrie.be>
Subject: [PATCH 1/3] can: kvaser_usb: add retries/timeout to kvaser_usb_wait_msg()
Date: Thu, 10 Apr 2014 21:44:21 +0200
Message-ID: <1397159063-12790-1-git-send-email-olivier@sobrie.be>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:41526 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935232AbaDJTqT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 10 Apr 2014 15:46:19 -0400
Received: by mail-ee0-f51.google.com with SMTP id c13so3366558eek.24
        for <linux-can@vger.kernel.org>; Thu, 10 Apr 2014 12:46:18 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Olivier Sobrie <olivier@sobrie.be>

On some Kvaser hardware, the firmware returns extra messages after the
request for card info. For instance on a Leaf Light v2:
  --> CMD_GET_CARD_INFO
  <-- CMD_USB_THROTTLE
  <-- CMD_GET_CARD_INFO2
  <-- CMD_GET_CARD_INFO_REQ
When it happens, the probing function fails because we only read
the first usb message.

To overcome this issue, we add a mechanism of retries to the
kvaser_usb_wait_msg() function.

I tested this patch with the following hardware:
 - Kvaser Leaf Light
 - Kvaser Leaf Light v2
 - Kvaser USBCan R

This patch is necessary for the Leaf Light v2 hardware.

Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
---
 drivers/net/can/usb/kvaser_usb.c | 49 ++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
index cc3df8a..cd5ec5b 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -380,38 +380,43 @@ static int kvaser_usb_wait_msg(const struct kvaser_usb *dev, u8 id,
 	void *buf;
 	int actual_len;
 	int err;
-	int pos = 0;
+	int pos;
+	unsigned long to = jiffies + msecs_to_jiffies(USB_RECV_TIMEOUT);
 
 	buf = kzalloc(RX_BUFFER_SIZE, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-	err = usb_bulk_msg(dev->udev,
-			   usb_rcvbulkpipe(dev->udev,
-					   dev->bulk_in->bEndpointAddress),
-			   buf, RX_BUFFER_SIZE, &actual_len,
-			   USB_RECV_TIMEOUT);
-	if (err < 0)
-		goto end;
+	do {
+		err = usb_bulk_msg(dev->udev,
+				   usb_rcvbulkpipe(dev->udev,
+					dev->bulk_in->bEndpointAddress),
+				   buf, RX_BUFFER_SIZE, &actual_len,
+				   USB_RECV_TIMEOUT);
+		if (err < 0)
+			goto end;
 
-	while (pos <= actual_len - MSG_HEADER_LEN) {
-		tmp = buf + pos;
+		pos = 0;
+		while (pos <= actual_len - MSG_HEADER_LEN) {
+			tmp = buf + pos;
 
-		if (!tmp->len)
-			break;
+			if (!tmp->len)
+				break;
 
-		if (pos + tmp->len > actual_len) {
-			dev_err(dev->udev->dev.parent, "Format error\n");
-			break;
-		}
+			if (pos + tmp->len > actual_len) {
+				dev_err(dev->udev->dev.parent,
+					"Format error\n");
+				break;
+			}
 
-		if (tmp->id == id) {
-			memcpy(msg, tmp, tmp->len);
-			goto end;
-		}
+			if (tmp->id == id) {
+				memcpy(msg, tmp, tmp->len);
+				goto end;
+			}
 
-		pos += tmp->len;
-	}
+			pos += tmp->len;
+		}
+	} while (time_before(jiffies, to));
 
 	err = -EINVAL;
 
-- 
1.9.0

