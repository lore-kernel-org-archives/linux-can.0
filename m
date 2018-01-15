From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH v2] can: peak/usb: fix potential bug in packet fragmentation
Date: Mon, 15 Jan 2018 16:31:19 +0100
Message-ID: <20180115153119.18847-1-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:8742 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932887AbeAOPb3 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 15 Jan 2018 10:31:29 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can Mailing List <linux-can@vger.kernel.org>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>

In some rare conditions when running one PEAK USB-FD interface over
a non high-speed USB controller, one useless USB fragment might be sent.
This patch fixes the way a USB command is fragmented when its length is
greater than 64 bytes and when the underlying USB controller is not a
high-speed one.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 7ccdc3e30c98..53d6bb045e9e 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -184,7 +184,7 @@ static int pcan_usb_fd_send_cmd(struct peak_usb_device *dev, void *cmd_tail)
 	void *cmd_head = pcan_usb_fd_cmd_buffer(dev);
 	int err = 0;
 	u8 *packet_ptr;
-	int i, n = 1, packet_len;
+	int packet_len;
 	ptrdiff_t cmd_len;
 
 	/* usb device unregistered? */
@@ -201,17 +201,13 @@ static int pcan_usb_fd_send_cmd(struct peak_usb_device *dev, void *cmd_tail)
 	}
 
 	packet_ptr = cmd_head;
+	packet_len = cmd_len;
 
 	/* firmware is not able to re-assemble 512 bytes buffer in full-speed */
-	if ((dev->udev->speed != USB_SPEED_HIGH) &&
-	    (cmd_len > PCAN_UFD_LOSPD_PKT_SIZE)) {
-		packet_len = PCAN_UFD_LOSPD_PKT_SIZE;
-		n += cmd_len / packet_len;
-	} else {
-		packet_len = cmd_len;
-	}
+	if (unlikely(dev->udev->speed != USB_SPEED_HIGH))
+		packet_len = min(packet_len, PCAN_UFD_LOSPD_PKT_SIZE);
 
-	for (i = 0; i < n; i++) {
+	do {
 		err = usb_bulk_msg(dev->udev,
 				   usb_sndbulkpipe(dev->udev,
 						   PCAN_USBPRO_EP_CMDOUT),
@@ -224,7 +220,12 @@ static int pcan_usb_fd_send_cmd(struct peak_usb_device *dev, void *cmd_tail)
 		}
 
 		packet_ptr += packet_len;
-	}
+		cmd_len -= packet_len;
+
+		if (cmd_len < PCAN_UFD_LOSPD_PKT_SIZE)
+			packet_len = cmd_len;
+
+	} while (packet_len > 0);
 
 	return err;
 }
-- 
2.14.1

