From: Jimmy Assarsson <jimmyassarsson@gmail.com>
Subject: [PATCH 2/3] can: kvaser_usb: Fix comparison bug in kvaser_usb_read_bulk_callback()
Date: Tue, 21 Nov 2017 08:22:27 +0100
Message-ID: <20171121072228.7570-3-jimmyassarsson@gmail.com>
References: <20171121072228.7570-1-jimmyassarsson@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46704 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753156AbdKUHWr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 21 Nov 2017 02:22:47 -0500
Received: by mail-lf0-f67.google.com with SMTP id g35so12882088lfi.13
        for <linux-can@vger.kernel.org>; Mon, 20 Nov 2017 23:22:47 -0800 (PST)
In-Reply-To: <20171121072228.7570-1-jimmyassarsson@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>

The conditon in the while-loop becomes true when actual_length is less than
2 (MSG_HEADER_LEN). In best case we end up with a former, already
dispatched msg, that got msg->len greater than actual_length. This will
result in a "Format error" error printout.

Problem seen when unplugging a Kvaser USB device connected to a vbox guest.

warning: comparison between signed and unsigned integer expressions
[-Wsign-compare]

Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
---
 drivers/net/can/usb/kvaser_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
index 075644591498..d87e330a20b3 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -1334,7 +1334,7 @@ static void kvaser_usb_read_bulk_callback(struct urb *urb)
 		goto resubmit_urb;
 	}
 
-	while (pos <= urb->actual_length - MSG_HEADER_LEN) {
+	while (pos <= (int)(urb->actual_length - MSG_HEADER_LEN)) {
 		msg = urb->transfer_buffer + pos;
 
 		/* The Kvaser firmware can only read and write messages that
-- 
2.15.0

