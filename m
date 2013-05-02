From: Olivier Sobrie <olivier@sobrie.be>
Subject: [PATCH v2] can: kvaser_usb: handle rx msg correctly
Date: Thu, 2 May 2013 20:57:10 +0200
Message-ID: <20130502185710.GA1041@thinkoso.home>
References: <CAJW3KNWxa_a727sgi_EO7nMBVbyVrCz0V3wCJBfvhz0ubbqCfA@mail.gmail.com>
 <517A968D.20508@pengutronix.de>
 <20130430214044.GA22921@thinkoso.home>
 <51824189.8090402@pengutronix.de>
 <20130502180610.GA14242@thinkoso.home>
Reply-To: Olivier Sobrie <olivier@sobrie.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:42575 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756653Ab3EBS5O (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 2 May 2013 14:57:14 -0400
Received: by mail-wg0-f44.google.com with SMTP id z12so903341wgg.11
        for <linux-can@vger.kernel.org>; Thu, 02 May 2013 11:57:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130502180610.GA14242@thinkoso.home>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Jonas Peterson <jonas.peterson@gmail.com>, linux-can@vger.kernel.org

From: Jonas Peterson <jonas.peterson@gmail.com>

Unlike Kvaser Leaf light devices, some other Kvaser devices (like USBcan
Pro, USBcan R) receive CAN messages in CMD_LOG_MESSAGE frames. This
patch adds support for it.

Signed-off-by: Jonas Peterson <jonas.peterson@gmail.com>
Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
---
 drivers/net/can/usb/kvaser_usb.c | 49 ++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
index 45cb9f3..6c89360 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -834,22 +834,35 @@ static void kvaser_usb_rx_can_msg(const struct kvaser_usb *dev,
 		return;
 	}
 
-	cf->can_id = ((msg->u.rx_can.msg[0] & 0x1f) << 6) |
-		     (msg->u.rx_can.msg[1] & 0x3f);
-	cf->can_dlc = get_can_dlc(msg->u.rx_can.msg[5]);
-
-	if (msg->id == CMD_RX_EXT_MESSAGE) {
-		cf->can_id <<= 18;
-		cf->can_id |= ((msg->u.rx_can.msg[2] & 0x0f) << 14) |
-			      ((msg->u.rx_can.msg[3] & 0xff) << 6) |
-			      (msg->u.rx_can.msg[4] & 0x3f);
-		cf->can_id |= CAN_EFF_FLAG;
-	}
+	if (msg->id == CMD_LOG_MESSAGE) {
+		cf->can_id = le32_to_cpu(msg->u.log_message.id);
+		cf->can_dlc = get_can_dlc(msg->u.log_message.dlc);
 
-	if (msg->u.rx_can.flag & MSG_FLAG_REMOTE_FRAME)
-		cf->can_id |= CAN_RTR_FLAG;
-	else
-		memcpy(cf->data, &msg->u.rx_can.msg[6], cf->can_dlc);
+		if (msg->u.log_message.flags & MSG_FLAG_REMOTE_FRAME)
+			cf->can_id |= CAN_RTR_FLAG;
+		else
+			memcpy(cf->data, &msg->u.log_message.data,
+			       cf->can_dlc);
+	} else {
+		cf->can_id = ((msg->u.rx_can.msg[0] & 0x1f) << 6) |
+			     (msg->u.rx_can.msg[1] & 0x3f);
+
+		if (msg->id == CMD_RX_EXT_MESSAGE) {
+			cf->can_id <<= 18;
+			cf->can_id |= ((msg->u.rx_can.msg[2] & 0x0f) << 14) |
+				      ((msg->u.rx_can.msg[3] & 0xff) << 6) |
+				      (msg->u.rx_can.msg[4] & 0x3f);
+			cf->can_id |= CAN_EFF_FLAG;
+		}
+
+		cf->can_dlc = get_can_dlc(msg->u.rx_can.msg[5]);
+
+		if (msg->u.rx_can.flag & MSG_FLAG_REMOTE_FRAME)
+			cf->can_id |= CAN_RTR_FLAG;
+		else
+			memcpy(cf->data, &msg->u.rx_can.msg[6],
+			       cf->can_dlc);
+	}
 
 	netif_rx(skb);
 
@@ -911,6 +924,7 @@ static void kvaser_usb_handle_message(const struct kvaser_usb *dev,
 
 	case CMD_RX_STD_MESSAGE:
 	case CMD_RX_EXT_MESSAGE:
+	case CMD_LOG_MESSAGE:
 		kvaser_usb_rx_can_msg(dev, msg);
 		break;
 
@@ -919,11 +933,6 @@ static void kvaser_usb_handle_message(const struct kvaser_usb *dev,
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

