From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: peak: fix potential bug in packet fragmentation
Date: Tue, 16 Jan 2018 15:39:11 +0100
Message-ID: <20180116143911.20783-2-mkl@pengutronix.de>
References: <20180116143911.20783-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36323 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751256AbeAPOjg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 Jan 2018 09:39:36 -0500
In-Reply-To: <20180116143911.20783-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Stephane Grosjean <s.grosjean@peak-system.com>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Stephane Grosjean <s.grosjean@peak-system.com>

In some rare conditions when running one PEAK USB-FD interface over
a non high-speed USB controller, one useless USB fragment might be sent.
This patch fixes the way a USB command is fragmented when its length is
greater than 64 bytes and when the underlying USB controller is not a
high-speed one.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
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
2.15.1

