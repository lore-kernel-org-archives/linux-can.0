From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: [PATCH 2/5] can: kvaser_usb: Read all messages in a bulk-in URB
 buffer
Date: Thu, 26 Feb 2015 10:22:02 -0500
Message-ID: <20150226152202.GB6075@linux>
References: <20150226152011.GA6075@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150226152011.GA6075@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: Olivier Sobrie <olivier@sobrie.be>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>, Linux-USB <linux-usb@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

From: Ahmed S. Darwish <ahmed.darwish@valeo.com>

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

Signed-off-by: Ahmed S. Darwish <ahmed.darwish@valeo.com>
---
 drivers/net/can/usb/kvaser_usb.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
index d986fe8..a316fa4 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -14,6 +14,7 @@
  * Copyright (C) 2015 Valeo S.A.
  */
 
+#include <linux/kernel.h>
 #include <linux/completion.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
@@ -584,8 +585,15 @@ static int kvaser_usb_wait_msg(const struct kvaser_usb *dev, u8 id,
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
@@ -1316,8 +1324,19 @@ static void kvaser_usb_read_bulk_callback(struct urb *urb)
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
@@ -1325,7 +1344,6 @@ static void kvaser_usb_read_bulk_callback(struct urb *urb)
 		}
 
 		kvaser_usb_handle_message(dev, msg);
-
 		pos += msg->len;
 	}
 
-- 
1.9.1
