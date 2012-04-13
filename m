From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH] can: usb: PCAN-USB Pro: fix mem leaks in pcan_usb_pro_init() on error paths
Date: Fri, 13 Apr 2012 09:44:56 +0200
Message-ID: <1334303096-26880-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from delay-2d.bbox.fr ([194.158.122.62]:63286 "EHLO delay-2d.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754741Ab2DMIIx (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 13 Apr 2012 04:08:53 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can Mailing List <linux-can@vger.kernel.org>
Cc: linux-usb Mailing List <linux-usb@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>, Jesper Juhl <jj@chaosbits.net>

If either call to pcan_usb_pro_send_req() in
drivers/net/can/usb/peak_usb/pcan_usb_pro.c::pcan_usb_pro_init()
fails, we'll leak the memory we allocated to 'usb_if' with kzalloc()
when the 'usb_if' variable goes out of scope without having been
assigned to anything as we 'return err;'.
Fix this by adding appropriate kfree(usb_if) calls to the error paths.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
Acked-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 5234586..629c4ba 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -875,6 +875,7 @@ static int pcan_usb_pro_init(struct peak_usb_device *dev)
 					    PCAN_USBPRO_INFO_FW,
 					    &fi, sizeof(fi));
 		if (err) {
+			kfree(usb_if);
 			dev_err(dev->netdev->dev.parent,
 				"unable to read %s firmware info (err %d)\n",
 				pcan_usb_pro.name, err);
@@ -885,6 +886,7 @@ static int pcan_usb_pro_init(struct peak_usb_device *dev)
 					    PCAN_USBPRO_INFO_BL,
 					    &bi, sizeof(bi));
 		if (err) {
+			kfree(usb_if);
 			dev_err(dev->netdev->dev.parent,
 				"unable to read %s bootloader info (err %d)\n",
 				pcan_usb_pro.name, err);
-- 
1.7.5.4

