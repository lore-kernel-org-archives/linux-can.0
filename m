From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v10 4/9] can/peak_usb: add adapter BEC callback definition
Date: Tue, 27 Jan 2015 17:41:45 +0100
Message-ID: <1422376910-23754-5-git-send-email-mkl@pengutronix.de>
References: <1422376910-23754-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34177 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754908AbbA0Ql6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 27 Jan 2015 11:41:58 -0500
In-Reply-To: <1422376910-23754-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

From: Stephane Grosjean <s.grosjean@peak-system.com>

Add the definition of a new callback that enable any PEAK-System CAN USB
adapter to grant read access to its Bus Error Counters value. This ability is
not supported by all the PEAK-System adapters, thus, for those, the callback
pointer will be initiaized to NULL, which is correct regarding the linux-can
device driver specs.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 1 +
 drivers/net/can/usb/peak_usb/pcan_usb_core.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 2768399a52fa..38634323ec51 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -750,6 +750,7 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	dev->can.bittiming_const = &peak_usb_adapter->bittiming_const;
 	dev->can.do_set_bittiming = peak_usb_set_bittiming;
 	dev->can.do_set_mode = peak_usb_set_mode;
+	dev->can.do_get_berr_counter = peak_usb_adapter->do_get_berr_counter;
 	dev->can.ctrlmode_supported = peak_usb_adapter->ctrlmode_supported;
 
 	netdev->netdev_ops = &peak_usb_netdev_ops;
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index 54fdb5978a05..739a344427a2 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -67,6 +67,8 @@ struct peak_usb_adapter {
 	int (*dev_stop)(struct peak_usb_device *dev);
 	int (*dev_restart_async)(struct peak_usb_device *dev, struct urb *urb,
 					u8 *buf);
+	int (*do_get_berr_counter)(const struct net_device *netdev,
+				   struct can_berr_counter *bec);
 	u8 ep_msg_in;
 	u8 ep_msg_out[PCAN_USB_MAX_CHANNEL];
 	u8 ts_used_bits;
-- 
2.1.4

