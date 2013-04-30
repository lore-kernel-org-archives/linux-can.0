From: Olivier Sobrie <olivier@sobrie.be>
Subject: [PATCH] can: kvaser_usb: handle rx msg correctly
Date: Tue, 30 Apr 2013 23:40:44 +0200
Message-ID: <20130430214044.GA22921@thinkoso.home>
References: <CAJW3KNWxa_a727sgi_EO7nMBVbyVrCz0V3wCJBfvhz0ubbqCfA@mail.gmail.com>
 <517A968D.20508@pengutronix.de>
Reply-To: Olivier Sobrie <olivier@sobrie.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:38768 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933706Ab3D3Vkt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 30 Apr 2013 17:40:49 -0400
Received: by mail-wg0-f48.google.com with SMTP id f11so895601wgh.3
        for <linux-can@vger.kernel.org>; Tue, 30 Apr 2013 14:40:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <517A968D.20508@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Jonas Peterson <jonas.peterson@gmail.com>
Cc: linux-can@vger.kernel.org

From: Jonas Peterson <jonas.peterson@gmail.com>

Unlike Kvaser Leaf light devices, some other Kvaser devices (like USBcan
Pro, USBcan R) receive CAN messages in CMD_LOG_MESSAGE frames. This
patch adds support for it.

Signed-off-by: Jonas Peterson <jonas.peterson@gmail.com>
Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
---
Hi Jonas and Marc,

I tested Jonas' patch with my devices and it looks to be good.
The Kvaser UsbCAN R had the same problem. When I wrote the driver I
didn't had this device and I never tested it... This patch was a good
reason for that :-)
However I modified the patch of Jonas in order to not duplicate
functions.

Thanks again to Jonas for the fix!

Olivier

 drivers/net/can/usb/kvaser_usb.c | 53 +++++++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
index 45cb9f3..0870529 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -834,22 +834,51 @@ static void kvaser_usb_rx_can_msg(const struct kvaser_usb *dev,
 		return;
 	}
 
-	cf->can_id = ((msg->u.rx_can.msg[0] & 0x1f) << 6) |
-		     (msg->u.rx_can.msg[1] & 0x3f);
-	cf->can_dlc = get_can_dlc(msg->u.rx_can.msg[5]);
+	switch (msg->id) {
+	case CMD_LOG_MESSAGE:
+		cf->can_id = msg->u.log_message.id;
+		cf->can_dlc = get_can_dlc(msg->u.log_message.dlc);
+
+		if (msg->u.log_message.flags & MSG_FLAG_REMOTE_FRAME)
+			cf->can_id |= CAN_RTR_FLAG;
+		else
+			memcpy(cf->data, &msg->u.log_message.data,
+			       cf->can_dlc);
+		break;
 
-	if (msg->id == CMD_RX_EXT_MESSAGE) {
+	case CMD_RX_EXT_MESSAGE:
 		cf->can_id <<= 18;
 		cf->can_id |= ((msg->u.rx_can.msg[2] & 0x0f) << 14) |
 			      ((msg->u.rx_can.msg[3] & 0xff) << 6) |
 			      (msg->u.rx_can.msg[4] & 0x3f);
 		cf->can_id |= CAN_EFF_FLAG;
-	}
+		cf->can_dlc = get_can_dlc(msg->u.rx_can.msg[5]);
 
-	if (msg->u.rx_can.flag & MSG_FLAG_REMOTE_FRAME)
-		cf->can_id |= CAN_RTR_FLAG;
-	else
-		memcpy(cf->data, &msg->u.rx_can.msg[6], cf->can_dlc);
+		if (msg->u.rx_can.flag & MSG_FLAG_REMOTE_FRAME)
+			cf->can_id |= CAN_RTR_FLAG;
+		else
+			memcpy(cf->data, &msg->u.rx_can.msg[6],
+			       cf->can_dlc);
+		break;
+
+	case CMD_RX_STD_MESSAGE:
+		cf->can_id = ((msg->u.rx_can.msg[0] & 0x1f) << 6) |
+			     (msg->u.rx_can.msg[1] & 0x3f);
+		cf->can_dlc = get_can_dlc(msg->u.rx_can.msg[5]);
+
+		if (msg->u.rx_can.flag & MSG_FLAG_REMOTE_FRAME)
+			cf->can_id |= CAN_RTR_FLAG;
+		else
+			memcpy(cf->data, &msg->u.rx_can.msg[6],
+			       cf->can_dlc);
+		break;
+
+	default:
+		netdev_warn(priv->netdev,
+			    "Unhandled message (%d)\n", msg->id);
+		dev_kfree_skb(skb);
+		return;
+	}
 
 	netif_rx(skb);
 
@@ -911,6 +940,7 @@ static void kvaser_usb_handle_message(const struct kvaser_usb *dev,
 
 	case CMD_RX_STD_MESSAGE:
 	case CMD_RX_EXT_MESSAGE:
+	case CMD_LOG_MESSAGE:
 		kvaser_usb_rx_can_msg(dev, msg);
 		break;
 
@@ -919,11 +949,6 @@ static void kvaser_usb_handle_message(const struct kvaser_usb *dev,
 		kvaser_usb_rx_error(dev, msg);
 		break;
 
-	case CMD_LOG_MESSAGE:
-		if (msg->u.log_message.flags & MSG_FLAG_ERROR_FRAME)
-			kvaser_usb_rx_error(dev, msg);
-		break;
-
 	case CMD_TX_ACKNOWLEDGE:
 		kvaser_usb_tx_acknowledge(dev, msg);
 		break;
-- 
1.8.1.5

