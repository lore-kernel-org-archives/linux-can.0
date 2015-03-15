From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: [PATCH v5 2/2] can: kvaser_usb: Fix sparse warning __le16 degrades
 to integer
Date: Sun, 15 Mar 2015 11:10:49 -0400
Message-ID: <20150315151049.GB4492@linux>
References: <20150226152011.GA6075@linux>
 <20150315150338.GA4492@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34023 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564AbbCOPKy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 15 Mar 2015 11:10:54 -0400
Content-Disposition: inline
In-Reply-To: <20150315150338.GA4492@linux>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Olivier Sobrie <olivier@sobrie.be>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

From: Ahmed S. Darwish <ahmed.darwish@valeo.com>

USB endpoint's wMaxPacketSize field is an le16 entity. Use
appropriate le16_to_cpu macros to maintain endian independence.

Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Ahmed S. Darwish <ahmed.darwish@valeo.com>
---
 drivers/net/can/usb/kvaser_usb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

I wasn't successful in making sparse trigger the warning, even
while using the latest version from the git repos and doing:

make C=2 M=drivers/net/can/usb

So, Marc, I hope this patch fixes the issue reported; it should.

thanks,

diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
index 60eadf5..d924016 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -596,8 +596,8 @@ static int kvaser_usb_wait_msg(const struct kvaser_usb *dev, u8 id,
 			 * for further details.
 			 */
 			if (tmp->len == 0) {
-				pos = round_up(pos,
-					       dev->bulk_in->wMaxPacketSize);
+				pos = round_up(pos, le16_to_cpu(dev->bulk_in->
+								wMaxPacketSize));
 				continue;
 			}
 
@@ -1337,7 +1337,8 @@ static void kvaser_usb_read_bulk_callback(struct urb *urb)
 		 * number of events in case of a heavy rx load on the bus.
 		 */
 		if (msg->len == 0) {
-			pos = round_up(pos, dev->bulk_in->wMaxPacketSize);
+			pos = round_up(pos, le16_to_cpu(dev->bulk_in->
+							wMaxPacketSize));
 			continue;
 		}
 
-- 
1.9.1

