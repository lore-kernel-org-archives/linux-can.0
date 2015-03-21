From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: [PATCH -stable 2/3] can: kvaser_usb: Read all messages in a bulk-in URB buffer
Date: Sat, 21 Mar 2015 04:03:23 +0200
Message-ID: <1426903404-22925-3-git-send-email-ahmed.darwish@valeo.com>
References: <1426903404-22925-1-git-send-email-ahmed.darwish@valeo.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:34964 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbbCUCEP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Mar 2015 22:04:15 -0400
Received: by webcq43 with SMTP id cq43so94850138web.2
        for <linux-can@vger.kernel.org>; Fri, 20 Mar 2015 19:04:14 -0700 (PDT)
In-Reply-To: <1426903404-22925-1-git-send-email-ahmed.darwish@valeo.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Olivier Sobrie <olivier@sobrie.be>
Cc: Linux-CAN <linux-can@vger.kernel.org>, "Ahmed S. Darwish" <ahmed.darwish@valeo.com>

From: "Ahmed S. Darwish" <ahmed.darwish@valeo.com>

The Kvaser firmware can only read and write messages that are
not crossing the USB endpoint's wMaxPacketSize boundary. While
receiving commands from the CAN device, if the next command in
the same URB buffer crossed that max packet size boundary, the
firmware puts a zero-length placeholder command in its place
then moves the real command to the next boundary mark.

The driver did not recognize such behavior, leading to missing
a good number of rx events during a heavy rx load session.

Moreover, a tx URB context only gets freed upon receiving its
respective tx ACK event. Over time, the free tx URB contexts
pool gets depleted due to the missing ACK events. Consequently,
the netif transmission queue gets __permanently__ stopped; no
frames could be sent again except after restarting the CAN
newtwork interface.

This is a backport of upstream commit: 2fec5104f9c61d

Signed-off-by: Ahmed S. Darwish <ahmed.darwish@valeo.com>
---
 drivers/net/can/usb/kvaser_usb.c |   28 +++++++++++++++++++++++-----
 1 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
index db43c5a..ba651a2 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -12,6 +12,7 @@
  * Copyright (C) 2012 Olivier Sobrie <olivier@sobrie.be>
  */
 
+#include <linux/kernel.h>
 #include <linux/completion.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
@@ -403,8 +404,15 @@ static int kvaser_usb_wait_msg(const struct kvaser_usb *dev, u8 id,
 		while (pos <= actual_len - MSG_HEADER_LEN) {
 			tmp = buf + pos;
 
-			if (!tmp->len)
-				break;
+			/* Handle messages crossing the USB endpoint max packet
+			 * size boundary. Check kvaser_usb_read_bulk_callback()
+			 * for further details.
+			 */
+			if (tmp->len == 0) {
+				pos = round_up(pos,
+					       dev->bulk_in->wMaxPacketSize);
+				continue;
+			}
 
 			if (pos + tmp->len > actual_len) {
 				dev_err(dev->udev->dev.parent,
@@ -979,8 +987,19 @@ static void kvaser_usb_read_bulk_callback(struct urb *urb)
 	while (pos <= urb->actual_length - MSG_HEADER_LEN) {
 		msg = urb->transfer_buffer + pos;
 
-		if (!msg->len)
-			break;
+		/* The Kvaser firmware can only read and write messages that
+		 * does not cross the USB's endpoint wMaxPacketSize boundary.
+		 * If a follow-up command crosses such boundary, firmware puts
+		 * a placeholder zero-length command in its place then aligns
+		 * the real command to the next max packet size.
+		 *
+		 * Handle such cases or we're going to miss a significant
+		 * number of events in case of a heavy rx load on the bus.
+		 */
+		if (msg->len == 0) {
+			pos = round_up(pos, dev->bulk_in->wMaxPacketSize);
+			continue;
+		}
 
 		if (pos + msg->len > urb->actual_length) {
 			dev_err(dev->udev->dev.parent, "Format error\n");
@@ -988,7 +1007,6 @@ static void kvaser_usb_read_bulk_callback(struct urb *urb)
 		}
 
 		kvaser_usb_handle_message(dev, msg);
-
 		pos += msg->len;
 	}
 
-- 
1.7.7.6

