From: Sebastian Haas <dev@sebastianhaas.info>
Subject: [PATCH 2/2] ems_usb: Improved memory handling on ems_usb_start
Date: Thu, 22 Dec 2011 23:58:34 +0100
Message-ID: <4EF3B61A.5010404@sebastianhaas.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtprelay01.ispgateway.de ([80.67.31.24]:39093 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528Ab1LVW7j (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Dec 2011 17:59:39 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Linux-can Mailing List <linux-can@vger.kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

 From 9d0d92d279255eed7f14b9fd70d1f0d181d4b301 Mon Sep 17 00:00:00 2001
From: Sebastian Haas <dev@sebastianhaas.info>
Date: Thu, 22 Dec 2011 23:27:47 +0100
Subject: [PATCH 2/2] ems_usb: Improved memory handling on ems_usb_start

Do not return from ems_usb_start if allocation fails. If not all URBs
could be allocated use the one already submitted.

Signed-off-by: Sebastian Haas <dev@sebastianhaas.info>
---
  drivers/net/can/usb/ems_usb.c |    6 ++++--
  1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 55ab0c4..c91c9b6 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -607,7 +607,8 @@ static int ems_usb_start(struct ems_usb *dev)
  		if (!urb) {
  			dev_err(netdev->dev.parent,
  				"No memory left for URBs\n");
-			return -ENOMEM;
+			err = -ENOMEM;
+			break;
  		}

  		buf = usb_alloc_coherent(dev->udev, RX_BUFFER_SIZE, GFP_KERNEL,
@@ -616,7 +617,8 @@ static int ems_usb_start(struct ems_usb *dev)
  			dev_err(netdev->dev.parent,
  				"No memory left for USB buffer\n");
  			usb_free_urb(urb);
-			return -ENOMEM;
+			err = -ENOMEM;
+			break;
  		}

  		usb_fill_bulk_urb(urb, dev->udev, usb_rcvbulkpipe(dev->udev, 2),
-- 
1.7.5.4

