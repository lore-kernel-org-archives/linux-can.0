From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] net: can: esd_usb2: check index of array before accessing
Date: Wed,  3 Jul 2013 10:33:29 +0200
Message-ID: <1372840409-13481-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41553 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521Ab3GCIde (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 3 Jul 2013 04:33:34 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Maximilian Schneider <max@schneidersoft.net>, Matthias Fuchs <matthias.fuchs@esd.eu>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Maximilian Schneider <max@schneidersoft.net>

The esd_usb2_read_bulk_callback() function is parsing the data that comes from
the USB CAN adapter. One datum is used as an index to access the dev->nets[]
array. This patch adds the missing bounds checking.

Cc: Matthias Fuchs <matthias.fuchs@esd.eu>
Signed-off-by: Maximilian Schneider <max@schneidersoft.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello,

Maximilian, I've added a more detailed patch description and the error message
printing. What do you think.

Marc

 drivers/net/can/usb/esd_usb2.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/can/usb/esd_usb2.c b/drivers/net/can/usb/esd_usb2.c
index 6aa7b32..ac6177d 100644
--- a/drivers/net/can/usb/esd_usb2.c
+++ b/drivers/net/can/usb/esd_usb2.c
@@ -412,10 +412,20 @@ static void esd_usb2_read_bulk_callback(struct urb *urb)
 
 		switch (msg->msg.hdr.cmd) {
 		case CMD_CAN_RX:
+			if (msg->msg.rx.net >= dev->net_count) {
+				dev_err(dev->udev->dev.parent, "format error\n");
+				break;
+			}
+
 			esd_usb2_rx_can_msg(dev->nets[msg->msg.rx.net], msg);
 			break;
 
 		case CMD_CAN_TX:
+			if (msg->msg.txdone.net >= dev->net_count) {
+				dev_err(dev->udev->dev.parent, "format error\n");
+				break;
+			}
+
 			esd_usb2_tx_done_msg(dev->nets[msg->msg.txdone.net],
 					     msg);
 			break;
-- 
1.8.3.1

