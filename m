From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH] can/peak_usb: fix missing ctrlmode_ init for every dev
Date: Mon,  2 Mar 2015 11:54:38 +0100
Message-ID: <1425293678-22217-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:49186 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278AbbCBKyi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 2 Mar 2015 05:54:38 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can Mailing List <linux-can@vger.kernel.org>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>

Fixes a missing initialization of ctrlmode and ctrlmode_supported fields,
for all other CAN devices than the first one. This fix only concerns
the PCAN-USB Pro FD dual-channels CAN-FD device made by PEAK-System.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 962c3f0..0bac0f1 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -879,6 +879,10 @@ static int pcan_usb_fd_init(struct peak_usb_device *dev)
 
 		pdev->usb_if = ppdev->usb_if;
 		pdev->cmd_buffer_addr = ppdev->cmd_buffer_addr;
+
+		/* do a copy of the ctrlmode[_supported] too */
+		dev->can.ctrlmode = ppdev->dev.can.ctrlmode;
+		dev->can.ctrlmode_supported = ppdev->dev.can.ctrlmode_supported;
 	}
 
 	pdev->usb_if->dev[dev->ctrl_idx] = dev;
-- 
1.9.1

