From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH] can/peak_usb: export ctrlmode_supported to adapter specific
Date: Mon, 19 Jan 2015 17:15:26 +0100
Message-ID: <1421684127-12764-2-git-send-email-s.grosjean@peak-system.com>
References: <1421684127-12764-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:50855 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbbASQXh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 19 Jan 2015 11:23:37 -0500
In-Reply-To: <1421684127-12764-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Stephane Grosjean <s.grosjean@peak-system.com>

Export the ctrlmode_supported value from the core file to each adapter
specific file. This has been mandatory for supporting the new CANFD
extension.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c      | 1 +
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 3 +--
 drivers/net/can/usb/peak_usb/pcan_usb_core.h | 1 +
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  | 1 +
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 4e1659d..5972c7a 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -858,6 +858,7 @@ struct peak_usb_adapter pcan_usb = {
 	.name = "PCAN-USB",
 	.device_id = PCAN_USB_PRODUCT_ID,
 	.ctrl_count = 1,
+	.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY,
 	.clock = {
 		.freq = PCAN_USB_CRYSTAL_HZ / 2 ,
 	},
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index be267af..c23609a 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -794,8 +794,7 @@ static int peak_usb_create_dev(struct peak_usb_adapter *peak_usb_adapter,
 	dev->can.data_bittiming_const = &peak_usb_adapter->data_bittiming_const;
 	dev->can.do_set_data_bittiming = peak_usb_set_data_bittiming;
 	dev->can.do_set_mode = peak_usb_set_mode;
-	dev->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES |
-				      CAN_CTRLMODE_LISTENONLY;
+	dev->can.ctrlmode_supported = peak_usb_adapter->ctrlmode_supported;
 
 	netdev->netdev_ops = &peak_usb_netdev_ops;
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index 928012f..a58d971 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -44,6 +44,7 @@ struct peak_usb_device;
 struct peak_usb_adapter {
 	char *name;
 	u32 device_id;
+	u32 ctrlmode_supported;
 	struct can_clock clock;
 	const struct can_bittiming_const bittiming_const;
 	const struct can_bittiming_const data_bittiming_const;
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 4cfa3b8..a2fc94a 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -1015,6 +1015,7 @@ struct peak_usb_adapter pcan_usb_pro = {
 	.name = "PCAN-USB Pro",
 	.device_id = PCAN_USBPRO_PRODUCT_ID,
 	.ctrl_count = PCAN_USBPRO_CHANNEL_COUNT,
+	.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY,
 	.clock = {
 		.freq = PCAN_USBPRO_CRYSTAL_HZ,
 	},
-- 
1.9.1

