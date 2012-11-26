From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5/5] can: pcan_usb_core: remove obsolete variable open_time
Date: Mon, 26 Nov 2012 15:24:47 +0100
Message-ID: <1353939887-19552-6-git-send-email-mkl@pengutronix.de>
References: <1353939887-19552-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56484 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754015Ab2KZOYu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Nov 2012 09:24:50 -0500
In-Reply-To: <1353939887-19552-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

The variable open_time in the struct peak_usb_device was used to protect
peak_usb_set_mode() only to be called, if the interface is up. Now the CAN
device infrastructure takes care of this.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c |    5 -----
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |    1 -
 2 files changed, 6 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index c4643c4..d9290ea 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -520,7 +520,6 @@ static int peak_usb_ndo_open(struct net_device *netdev)
 		return err;
 	}
 
-	dev->open_time = jiffies;
 	netif_start_queue(netdev);
 
 	return 0;
@@ -576,7 +575,6 @@ static int peak_usb_ndo_stop(struct net_device *netdev)
 
 	close_candev(netdev);
 
-	dev->open_time = 0;
 	dev->can.state = CAN_STATE_STOPPED;
 
 	/* can set bus off now */
@@ -661,9 +659,6 @@ static int peak_usb_set_mode(struct net_device *netdev, enum can_mode mode)
 	struct peak_usb_device *dev = netdev_priv(netdev);
 	int err = 0;
 
-	if (!dev->open_time)
-		return -EINVAL;
-
 	switch (mode) {
 	case CAN_MODE_START:
 		err = peak_usb_restart(dev);
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index c8e5e91..073b47f 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -104,7 +104,6 @@ struct peak_usb_device {
 	struct can_priv can;
 	struct peak_usb_adapter *adapter;
 	unsigned int ctrl_idx;
-	int open_time;
 	u32 state;
 
 	struct sk_buff *echo_skb[PCAN_USB_MAX_TX_URBS];
-- 
1.7.10.4

