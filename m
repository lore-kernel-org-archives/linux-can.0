From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v6 1/7] can: peak_usb: export ctrlmode_supported to adapter specific
Date: Tue, 20 Jan 2015 15:15:23 +0100
Message-ID: <1421763329-21915-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53239 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081AbbATOPd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 20 Jan 2015 09:15:33 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

From: Stephane Grosjean <s.grosjean@peak-system.com>

Export the ctrlmode_supported value from the core file to each adapter specific
file. This has been mandatory for supporting the new CANFD extension.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c      | 1 +
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 3 +--
 drivers/net/can/usb/peak_usb/pcan_usb_core.h | 1 +
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  | 1 +
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 4e1659d07979..5972c7af4a76 100644
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
index c62f48a1161d..7a9098cd3914 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -751,8 +751,7 @@ static int peak_usb_create_dev(struct peak_usb_adapter *peak_usb_adapter,
 	dev->can.bittiming_const = &peak_usb_adapter->bittiming_const;
 	dev->can.do_set_bittiming = peak_usb_set_bittiming;
 	dev->can.do_set_mode = peak_usb_set_mode;
-	dev->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES |
-				      CAN_CTRLMODE_LISTENONLY;
+	dev->can.ctrlmode_supported = peak_usb_adapter->ctrlmode_supported;
 
 	netdev->netdev_ops = &peak_usb_netdev_ops;
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index 073b47ff8eee..6dcea649a825 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -44,6 +44,7 @@ struct peak_usb_device;
 struct peak_usb_adapter {
 	char *name;
 	u32 device_id;
+	u32 ctrlmode_supported;
 	struct can_clock clock;
 	const struct can_bittiming_const bittiming_const;
 	unsigned int ctrl_count;
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 4cfa3b8605b1..a2fc94ab3f9a 100644
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
2.1.4

