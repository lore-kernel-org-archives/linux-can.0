From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/4] can: kvaser_usb: Send correct context to URB completion
Date: Tue, 27 Jan 2015 09:01:25 +0100
Message-ID: <1422345687-12839-3-git-send-email-mkl@pengutronix.de>
References: <1422345687-12839-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58352 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757666AbbA0IBg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 27 Jan 2015 03:01:36 -0500
In-Reply-To: <1422345687-12839-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, "Ahmed S. Darwish" <ahmed.darwish@valeo.com>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>

From: "Ahmed S. Darwish" <ahmed.darwish@valeo.com>

Send expected argument to the URB completion hander: a CAN
netdevice instead of the network interface private context
`kvaser_usb_net_priv'.

This was discovered by having some garbage in the kernel
log in place of the netdevice names: can0 and can1.

Signed-off-by: Ahmed S. Darwish <ahmed.darwish@valeo.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/kvaser_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
index 978a25e9cd3c..f0c62075df0a 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -587,7 +587,7 @@ static int kvaser_usb_simple_msg_async(struct kvaser_usb_net_priv *priv,
 			  usb_sndbulkpipe(dev->udev,
 					  dev->bulk_out->bEndpointAddress),
 			  buf, msg->len,
-			  kvaser_usb_simple_msg_callback, priv);
+			  kvaser_usb_simple_msg_callback, netdev);
 	usb_anchor_urb(urb, &priv->tx_submitted);
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
-- 
2.1.4

