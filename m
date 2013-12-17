From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/2] can: ems_usb: fix urb leaks on failure paths
Date: Tue, 17 Dec 2013 11:44:48 +0100
Message-ID: <1387277089-25554-2-git-send-email-mkl@pengutronix.de>
References: <1387277089-25554-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50845 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544Ab3LQKpE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Dec 2013 05:45:04 -0500
In-Reply-To: <1387277089-25554-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Alexey Khoroshilov <khoroshilov@ispras.ru>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Alexey Khoroshilov <khoroshilov@ispras.ru>

There are a couple failure paths where urb leaks.
Is spare code within ems_usb_start_xmit(),
usb_free_urb() should be used to deallocate urb instead of usb_unanchor_urb().
In ems_usb_start() there is no usb_free_urb() if usb_submit_urb() fails.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Acked-by: Sebastian Haas <dev@sebastianhaas.info>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/ems_usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 5f9a7ad..8aeec0b 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -625,6 +625,7 @@ static int ems_usb_start(struct ems_usb *dev)
 			usb_unanchor_urb(urb);
 			usb_free_coherent(dev->udev, RX_BUFFER_SIZE, buf,
 					  urb->transfer_dma);
+			usb_free_urb(urb);
 			break;
 		}
 
@@ -798,8 +799,8 @@ static netdev_tx_t ems_usb_start_xmit(struct sk_buff *skb, struct net_device *ne
 	 * allowed (MAX_TX_URBS).
 	 */
 	if (!context) {
-		usb_unanchor_urb(urb);
 		usb_free_coherent(dev->udev, size, buf, urb->transfer_dma);
+		usb_free_urb(urb);
 
 		netdev_warn(netdev, "couldn't find free context\n");
 
-- 
1.8.5.1

