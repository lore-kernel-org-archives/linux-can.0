From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/9] can: kvaser_usb: Fix comparison bug in kvaser_usb_read_bulk_callback()
Date: Fri,  1 Dec 2017 15:17:32 +0100
Message-ID: <20171201141739.5816-3-mkl@pengutronix.de>
References: <20171201141739.5816-1-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171201141739.5816-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Jimmy Assarsson <jimmyassarsson@gmail.com>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Jimmy Assarsson <jimmyassarsson@gmail.com>

The conditon in the while-loop becomes true when actual_length is less than
2 (MSG_HEADER_LEN). In best case we end up with a former, already
dispatched msg, that got msg->len greater than actual_length. This will
result in a "Format error" error printout.

Problem seen when unplugging a Kvaser USB device connected to a vbox guest.

warning: comparison between signed and unsigned integer expressions
[-Wsign-compare]

Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
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
