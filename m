From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can/peak_usb: mark current PEAK USB FD as non-ISO
Date: Tue, 27 Jan 2015 18:58:04 +0100
Message-ID: <1422381484-3804-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:45279 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754735AbbA0R6Z (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 27 Jan 2015 12:58:25 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

The current PCAN USB FD (pro) adapters support the non-ISO CAN FD protocol.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index e4d9354..962c3f0 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -860,6 +860,9 @@ static int pcan_usb_fd_init(struct peak_usb_device *dev)
 			 pdev->usb_if->fw_info.fw_version[2],
 			 dev->adapter->ctrl_count);
 
+		/* the currently supported hw is non-ISO */
+		dev->can.ctrlmode = CAN_CTRLMODE_FD_NON_ISO;
+
 		/* tell the hardware the can driver is running */
 		err = pcan_usb_fd_drv_loaded(dev, 1);
 		if (err) {
-- 
2.1.4

