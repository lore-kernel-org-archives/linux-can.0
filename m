From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 12/12] ems_usb: Improved memory handling on ems_usb_start
Date: Tue, 31 Jan 2012 22:46:50 +0100
Message-ID: <1328046410-21392-13-git-send-email-mkl@pengutronix.de>
References: <1328046410-21392-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44869 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755364Ab2AaVrE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 31 Jan 2012 16:47:04 -0500
In-Reply-To: <1328046410-21392-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Sebastian Haas <dev@sebastianhaas.info>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Sebastian Haas <dev@sebastianhaas.info>

Do not return from ems_usb_start if allocation fails. If not all URBs
could be allocated use the one already submitted.

Signed-off-by: Sebastian Haas <dev@sebastianhaas.info>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/ems_usb.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 3af3059..7ae65fc 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -602,7 +602,8 @@ static int ems_usb_start(struct ems_usb *dev)
 		urb = usb_alloc_urb(0, GFP_KERNEL);
 		if (!urb) {
 			netdev_err(netdev, "No memory left for URBs\n");
-			return -ENOMEM;
+			err = -ENOMEM;
+			break;
 		}
 
 		buf = usb_alloc_coherent(dev->udev, RX_BUFFER_SIZE, GFP_KERNEL,
@@ -610,7 +611,8 @@ static int ems_usb_start(struct ems_usb *dev)
 		if (!buf) {
 			netdev_err(netdev, "No memory left for USB buffer\n");
 			usb_free_urb(urb);
-			return -ENOMEM;
+			err = -ENOMEM;
+			break;
 		}
 
 		usb_fill_bulk_urb(urb, dev->udev, usb_rcvbulkpipe(dev->udev, 2),
-- 
1.7.4.1

