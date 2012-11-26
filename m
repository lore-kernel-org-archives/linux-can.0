From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4/5] can: esd_usb2: remove obsolete variable open_time
Date: Mon, 26 Nov 2012 15:24:46 +0100
Message-ID: <1353939887-19552-5-git-send-email-mkl@pengutronix.de>
References: <1353939887-19552-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56483 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754286Ab2KZOYu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Nov 2012 09:24:50 -0500
In-Reply-To: <1353939887-19552-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

The variable open_time in the struct esd_usb2_net_priv was used to protect
esd_usb2_set_mode() only to be called, if the interface is up. Now the CAN
device infrastructure takes care of this.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/esd_usb2.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb2.c b/drivers/net/can/usb/esd_usb2.c
index 124e0dd..9b74d1e 100644
--- a/drivers/net/can/usb/esd_usb2.c
+++ b/drivers/net/can/usb/esd_usb2.c
@@ -217,7 +217,6 @@ struct esd_usb2_net_priv {
 	struct usb_anchor tx_submitted;
 	struct esd_tx_urb_context tx_contexts[MAX_TX_URBS];
 
-	int open_time;
 	struct esd_usb2 *usb2;
 	struct net_device *netdev;
 	int index;
@@ -695,8 +694,6 @@ static int esd_usb2_open(struct net_device *netdev)
 		return err;
 	}
 
-	priv->open_time = jiffies;
-
 	netif_start_queue(netdev);
 
 	return 0;
@@ -864,8 +861,6 @@ static int esd_usb2_close(struct net_device *netdev)
 
 	close_candev(netdev);
 
-	priv->open_time = 0;
-
 	return 0;
 }
 
@@ -941,11 +936,6 @@ static int esd_usb2_get_berr_counter(const struct net_device *netdev,
 
 static int esd_usb2_set_mode(struct net_device *netdev, enum can_mode mode)
 {
-	struct esd_usb2_net_priv *priv = netdev_priv(netdev);
-
-	if (!priv->open_time)
-		return -EINVAL;
-
 	switch (mode) {
 	case CAN_MODE_START:
 		netif_wake_queue(netdev);
-- 
1.7.10.4

