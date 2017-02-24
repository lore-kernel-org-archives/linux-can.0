From: Ethan Zonca <e@ethanzonca.com>
Subject: [PATCH] gs_usb driver was performing USB transfers using buffers allocated on the stack
Date: Fri, 24 Feb 2017 11:27:36 -0500
Message-ID: <20170224162736.14688-1-e@ethanzonca.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:36018 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbdBXQ1w (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 24 Feb 2017 11:27:52 -0500
Received: by mail-it0-f67.google.com with SMTP id w185so4396273ita.3
        for <linux-can@vger.kernel.org>; Fri, 24 Feb 2017 08:27:52 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Ethan Zonca <e@ethanzonca.com>

This causes the driver to not function with vmapped stacks. Instead, allocate memory for the transfer buffers.

Signed-off-by: Ethan Zonca <e@ethanzonca.com>
---
 drivers/net/can/usb/gs_usb.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 77e3cc06a30c..3f064f5a8633 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -908,10 +908,13 @@ static int gs_usb_probe(struct usb_interface *intf,
 	struct gs_usb *dev;
 	int rc = -ENOMEM;
 	unsigned int icount, i;
-	struct gs_host_config hconf = {
-		.byte_order = 0x0000beef,
-	};
-	struct gs_device_config dconf;
+	struct gs_host_config *hconf;
+	struct gs_device_config *dconf;
+
+	hconf = kmalloc(sizeof(*hconf), GFP_KERNEL);
+	hconf->byte_order = 0x0000beef;
+
+	dconf = kmalloc(sizeof(*dconf), GFP_KERNEL);
 
 	/* send host config */
 	rc = usb_control_msg(interface_to_usbdev(intf),
@@ -920,10 +923,12 @@ static int gs_usb_probe(struct usb_interface *intf,
 			     USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
 			     1,
 			     intf->altsetting[0].desc.bInterfaceNumber,
-			     &hconf,
-			     sizeof(hconf),
+			     hconf,
+			     sizeof(*hconf),
 			     1000);
 
+	kfree(hconf);
+
 	if (rc < 0) {
 		dev_err(&intf->dev, "Couldn't send data format (err=%d)\n",
 			rc);
@@ -937,28 +942,33 @@ static int gs_usb_probe(struct usb_interface *intf,
 			     USB_DIR_IN|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
 			     1,
 			     intf->altsetting[0].desc.bInterfaceNumber,
-			     &dconf,
-			     sizeof(dconf),
+			     dconf,
+			     sizeof(*dconf),
 			     1000);
 	if (rc < 0) {
 		dev_err(&intf->dev, "Couldn't get device config: (err=%d)\n",
 			rc);
+		kfree(dconf);
 		return rc;
 	}
 
-	icount = dconf.icount + 1;
+	icount = dconf->icount + 1;
 	dev_info(&intf->dev, "Configuring for %d interfaces\n", icount);
 
 	if (icount > GS_MAX_INTF) {
 		dev_err(&intf->dev,
 			"Driver cannot handle more that %d CAN interfaces\n",
 			GS_MAX_INTF);
+		kfree(dconf);
 		return -EINVAL;
 	}
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev)
+	if (!dev) {
+		kfree(dconf);
 		return -ENOMEM;
+	}
+
 	init_usb_anchor(&dev->rx_submitted);
 
 	atomic_set(&dev->active_channels, 0);
@@ -967,7 +977,7 @@ static int gs_usb_probe(struct usb_interface *intf,
 	dev->udev = interface_to_usbdev(intf);
 
 	for (i = 0; i < icount; i++) {
-		dev->canch[i] = gs_make_candev(i, intf, &dconf);
+		dev->canch[i] = gs_make_candev(i, intf, dconf);
 		if (IS_ERR_OR_NULL(dev->canch[i])) {
 			/* save error code to return later */
 			rc = PTR_ERR(dev->canch[i]);
@@ -978,12 +988,15 @@ static int gs_usb_probe(struct usb_interface *intf,
 				gs_destroy_candev(dev->canch[i]);
 
 			usb_kill_anchored_urbs(&dev->rx_submitted);
+			kfree(dconf);
 			kfree(dev);
 			return rc;
 		}
 		dev->canch[i]->parent = dev;
 	}
 
+	kfree(dconf);
+
 	return 0;
 }
 
-- 
2.11.1

