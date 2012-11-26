From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3/5] can: ems_usb: remove obsolete variable open_time
Date: Mon, 26 Nov 2012 15:24:45 +0100
Message-ID: <1353939887-19552-4-git-send-email-mkl@pengutronix.de>
References: <1353939887-19552-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56480 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753492Ab2KZOYu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Nov 2012 09:24:50 -0500
In-Reply-To: <1353939887-19552-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

The variable open_time in the struct ems_usb was used to protect
ems_usb_set_mode() only to be called, if the interface is up. Now the CAN
device infrastructure takes care of this.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/ems_usb.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 086fa32..938924c 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -245,7 +245,6 @@ struct ems_tx_urb_context {
 
 struct ems_usb {
 	struct can_priv can; /* must be the first member */
-	int open_time;
 
 	struct sk_buff *echo_skb[MAX_TX_URBS];
 
@@ -728,7 +727,6 @@ static int ems_usb_open(struct net_device *netdev)
 		return err;
 	}
 
-	dev->open_time = jiffies;
 
 	netif_start_queue(netdev);
 
@@ -878,8 +876,6 @@ static int ems_usb_close(struct net_device *netdev)
 
 	close_candev(netdev);
 
-	dev->open_time = 0;
-
 	return 0;
 }
 
@@ -904,9 +900,7 @@ static const struct can_bittiming_const ems_usb_bittiming_const = {
 static int ems_usb_set_mode(struct net_device *netdev, enum can_mode mode)
 {
 	struct ems_usb *dev = netdev_priv(netdev);
-
-	if (!dev->open_time)
-		return -EINVAL;
+	int err = 0;
 
 	switch (mode) {
 	case CAN_MODE_START:
-- 
1.7.10.4

