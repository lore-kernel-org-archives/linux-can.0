From: Maximilain Schneider <max@schneidersoft.net>
Subject: [PATCH 1/1] Fixed disconnect bug by removing erroneous use of
 kfree()
Date: Tue, 23 Feb 2016 01:17:28 +0000
Message-ID: <1456190248.10201.2.camel@schneidersoft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from h2448646.stratoserver.net ([85.214.222.201]:45496 "EHLO
	h2448646.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755974AbcBWBVb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 22 Feb 2016 20:21:31 -0500
Received: from blackbox (unknown [179.101.15.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: max@schneidersoft.net)
	by h2448646.stratoserver.net (Postfix) with ESMTPSA id 7244BD94129C
	for <linux-can@vger.kernel.org>; Tue, 23 Feb 2016 01:12:20 +0000 (UTC)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

From b0a5029680d544faf07bcf636084b3fcafe59953 Mon Sep 17 00:00:00 2001
From: Maximilian Schneider <max@schneidersoft.net>
Date: Tue, 23 Feb 2016 01:03:53 +0000
Subject: [PATCH 1/1] Fixed disconnect bug by removing erroneous use of kfree()
 and revised disconnect routine.

Signed-off-by: Maximilian Schneider <max@schneidersoft.net>
---
 drivers/net/can/usb/gs_usb.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 5eee62b..dcb3473 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -826,9 +826,8 @@ static struct gs_can *gs_make_candev(unsigned int channel, struct usb_interface
 static void gs_destroy_candev(struct gs_can *dev)
 {
 	unregister_candev(dev->netdev);
-	free_candev(dev->netdev);
 	usb_kill_anchored_urbs(&dev->tx_submitted);
-	kfree(dev);
+	free_candev(dev->netdev);
 }
 
 static int gs_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
@@ -913,12 +912,15 @@ static int gs_usb_probe(struct usb_interface *intf, const struct usb_device_id *
 	for (i = 0; i < icount; i++) {
 		dev->canch[i] = gs_make_candev(i, intf);
 		if (IS_ERR_OR_NULL(dev->canch[i])) {
+			/* save error code to return later */
+			rc = PTR_ERR(dev->canch[i]);
+
 			/* on failure destroy previously created candevs */
 			icount = i;
-			for (i = 0; i < icount; i++) {
+			for (i = 0; i < icount; i++)
 				gs_destroy_candev(dev->canch[i]);
-				dev->canch[i] = NULL;
-			}
+
+			usb_kill_anchored_urbs(&dev->rx_submitted);
 			kfree(dev);
 			return rc;
 		}
@@ -939,16 +941,12 @@ static void gs_usb_disconnect(struct usb_interface *intf)
 		return;
 	}
 
-	for (i = 0; i < GS_MAX_INTF; i++) {
-		struct gs_can *can = dev->canch[i];
-
-		if (!can)
-			continue;
-
-		gs_destroy_candev(can);
-	}
+	for (i = 0; i < GS_MAX_INTF; i++)
+		if (dev->canch[i])
+			gs_destroy_candev(dev->canch[i]);
 
 	usb_kill_anchored_urbs(&dev->rx_submitted);
+	kfree(dev);
 }
 
 static const struct usb_device_id gs_usb_table[] = {
@@ -972,3 +970,4 @@ MODULE_DESCRIPTION(
 "Socket CAN device driver for Geschwister Schneider Technologie-, "
 "Entwicklungs- und Vertriebs UG. USB2.0 to CAN interfaces.");
 MODULE_LICENSE("GPL v2");
+
-- 
2.1.4

