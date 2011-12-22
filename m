From: Sebastian Haas <dev@sebastianhaas.info>
Subject: [PATCH 1/2] ems_usb: Removed double netif_device_detach
Date: Thu, 22 Dec 2011 23:57:49 +0100
Message-ID: <4EF3B5ED.3040202@sebastianhaas.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtprelay02.ispgateway.de ([80.67.31.36]:36153 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753502Ab1LVW5y (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Dec 2011 17:57:54 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Linux-can Mailing List <linux-can@vger.kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

 From fc832ed7b4c824007f73dc8618915bdfd6375e07 Mon Sep 17 00:00:00 2001
From: Sebastian Haas <dev@sebastianhaas.info>
Date: Thu, 22 Dec 2011 22:48:27 +0100
Subject: [PATCH 1/2] ems_usb: Removed double netif_device_detach

netif_device_attched is called twice when ems_usb_start fails with -ENODEV

Signed-off-by: Sebastian Haas <dev@sebastianhaas.info>
---
  drivers/net/can/usb/ems_usb.c |   10 ----------
  1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index a72c7bf..55ab0c4 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -627,9 +627,6 @@ static int ems_usb_start(struct ems_usb *dev)

  		err = usb_submit_urb(urb, GFP_KERNEL);
  		if (err) {
-			if (err == -ENODEV)
-				netif_device_detach(dev->netdev);
-
  			usb_unanchor_urb(urb);
  			usb_free_coherent(dev->udev, RX_BUFFER_SIZE, buf,
  					  urb->transfer_dma);
@@ -659,12 +656,8 @@ static int ems_usb_start(struct ems_usb *dev)

  	err = usb_submit_urb(dev->intr_urb, GFP_KERNEL);
  	if (err) {
-		if (err == -ENODEV)
-			netif_device_detach(dev->netdev);
-
  		dev_warn(netdev->dev.parent, "intr URB submit failed: %d\n",
  			 err);
-
  		return err;
  	}

@@ -692,9 +685,6 @@ static int ems_usb_start(struct ems_usb *dev)
  	return 0;

  failed:
-	if (err == -ENODEV)
-		netif_device_detach(dev->netdev);
-
  	dev_warn(netdev->dev.parent, "couldn't submit control: %d\n", err);

  	return err;
-- 
1.7.5.4

