From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH] can/peak_usb: add adapter BEC callback definition
Date: Mon, 19 Jan 2015 17:15:27 +0100
Message-ID: <1421684127-12764-3-git-send-email-s.grosjean@peak-system.com>
References: <1421684127-12764-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:47723 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbbASQXn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 19 Jan 2015 11:23:43 -0500
In-Reply-To: <1421684127-12764-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Stephane Grosjean <s.grosjean@peak-system.com>

Add the definition of a new callback that enable any PEAK-System CAN USB
adapter to grant read access to its Bus Error Counters value.
This ability is not supported by all the PEAK-System adapters, thus,
for those, the callback pointer will be initiaized to NULL, which is
correct regarding the linux-can device driver specs.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 2 ++
 drivers/net/can/usb/peak_usb/pcan_usb_core.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index c23609a..7a73060 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -794,6 +794,8 @@ static int peak_usb_create_dev(struct peak_usb_adapter *peak_usb_adapter,
 	dev->can.data_bittiming_const = &peak_usb_adapter->data_bittiming_const;
 	dev->can.do_set_data_bittiming = peak_usb_set_data_bittiming;
 	dev->can.do_set_mode = peak_usb_set_mode;
+	dev->can.do_get_berr_counter =
+		peak_usb_adapter->candev_get_berr_counter;
 	dev->can.ctrlmode_supported = peak_usb_adapter->ctrlmode_supported;
 
 	netdev->netdev_ops = &peak_usb_netdev_ops;
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index a58d971..fb402d2 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -70,6 +70,8 @@ struct peak_usb_adapter {
 	int (*dev_stop)(struct peak_usb_device *dev);
 	int (*dev_restart_async)(struct peak_usb_device *dev, struct urb *urb,
 					u8 *buf);
+	int (*candev_get_berr_counter)(const struct net_device *netdev,
+				       struct can_berr_counter *bec);
 	u8 ep_msg_in;
 	u8 ep_msg_out[PCAN_USB_MAX_CHANNEL];
 	u8 ts_used_bits;
-- 
1.9.1

