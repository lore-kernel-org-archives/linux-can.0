From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: usb_8dev: unregister netdev before free()ing
Date: Tue, 18 Jun 2013 14:57:23 +0200
Message-ID: <1371560243-24316-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58429 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab3FRM50 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Jun 2013 08:57:26 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

The usb_8dev hardware has problems on some xhci USB hosts. The driver fails to
read the firmware revision in the probe function. This leads to the following
Oops:

    [ 3356.635912] kernel BUG at net/core/dev.c:5701!

The driver tries to free the netdev, which has already been registered, without
unregistering it.

This patch fixes the problem by unregistering the netdev in the error path.

Reported-by: <m.olbrich@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/usb_8dev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/usb_8dev.c b/drivers/net/can/usb/usb_8dev.c
index 6e15ef0..cbd388e 100644
--- a/drivers/net/can/usb/usb_8dev.c
+++ b/drivers/net/can/usb/usb_8dev.c
@@ -977,7 +977,7 @@ static int usb_8dev_probe(struct usb_interface *intf,
 	err = usb_8dev_cmd_version(priv, &version);
 	if (err) {
 		netdev_err(netdev, "can't get firmware version\n");
-		goto cleanup_cmd_msg_buffer;
+		goto cleanup_unregister_candev;
 	} else {
 		netdev_info(netdev,
 			 "firmware: %d.%d, hardware: %d.%d\n",
@@ -989,6 +989,9 @@ static int usb_8dev_probe(struct usb_interface *intf,
 
 	return 0;
 
+cleanup_unregister_candev:
+	unregister_netdev(priv->netdev);
+
 cleanup_cmd_msg_buffer:
 	kfree(priv->cmd_msg_buffer);
 
-- 
1.8.3.1

