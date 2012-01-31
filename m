From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 11/12] ems_usb: Removed double netif_device_detach
Date: Tue, 31 Jan 2012 22:46:49 +0100
Message-ID: <1328046410-21392-12-git-send-email-mkl@pengutronix.de>
References: <1328046410-21392-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44867 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755370Ab2AaVrE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 31 Jan 2012 16:47:04 -0500
In-Reply-To: <1328046410-21392-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Sebastian Haas <dev@sebastianhaas.info>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Sebastian Haas <dev@sebastianhaas.info>

netif_device_attched is called twice when ems_usb_start fails with -ENODEV

Signed-off-by: Sebastian Haas <dev@sebastianhaas.info>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/ems_usb.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index cb37c00..3af3059 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -621,9 +621,6 @@ static int ems_usb_start(struct ems_usb *dev)
 
 		err = usb_submit_urb(urb, GFP_KERNEL);
 		if (err) {
-			if (err == -ENODEV)
-				netif_device_detach(dev->netdev);
-
 			usb_unanchor_urb(urb);
 			usb_free_coherent(dev->udev, RX_BUFFER_SIZE, buf,
 					  urb->transfer_dma);
@@ -653,9 +650,6 @@ static int ems_usb_start(struct ems_usb *dev)
 
 	err = usb_submit_urb(dev->intr_urb, GFP_KERNEL);
 	if (err) {
-		if (err == -ENODEV)
-			netif_device_detach(dev->netdev);
-
 		netdev_warn(netdev, "intr URB submit failed: %d\n", err);
 
 		return err;
@@ -685,9 +679,6 @@ static int ems_usb_start(struct ems_usb *dev)
 	return 0;
 
 failed:
-	if (err == -ENODEV)
-		netif_device_detach(dev->netdev);
-
 	netdev_warn(netdev, "couldn't submit control: %d\n", err);
 
 	return err;
-- 
1.7.4.1

