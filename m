From: Jimmy Assarsson <jimmyassarsson@gmail.com>
Subject: [PATCH 3/3] can: kvaser_usb: ratelimit errors if incomplete messages are received
Date: Tue, 21 Nov 2017 08:22:28 +0100
Message-ID: <20171121072228.7570-4-jimmyassarsson@gmail.com>
References: <20171121072228.7570-1-jimmyassarsson@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44146 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753156AbdKUHWu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 21 Nov 2017 02:22:50 -0500
Received: by mail-lf0-f68.google.com with SMTP id w23so12884508lfd.11
        for <linux-can@vger.kernel.org>; Mon, 20 Nov 2017 23:22:49 -0800 (PST)
In-Reply-To: <20171121072228.7570-1-jimmyassarsson@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>

Avoid flooding the kernel log with "Formate error", if incomplete message
are received.

Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
---
 drivers/net/can/usb/kvaser_usb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
index d87e330a20b3..f95945915d20 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -609,8 +609,8 @@ static int kvaser_usb_wait_msg(const struct kvaser_usb *dev, u8 id,
 			}
 
 			if (pos + tmp->len > actual_len) {
-				dev_err(dev->udev->dev.parent,
-					"Format error\n");
+				dev_err_ratelimited(dev->udev->dev.parent,
+						    "Format error\n");
 				break;
 			}
 
@@ -1353,7 +1353,8 @@ static void kvaser_usb_read_bulk_callback(struct urb *urb)
 		}
 
 		if (pos + msg->len > urb->actual_length) {
-			dev_err(dev->udev->dev.parent, "Format error\n");
+			dev_err_ratelimited(dev->udev->dev.parent,
+					    "Format error\n");
 			break;
 		}
 
-- 
2.15.0

