From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: pcan_usb: don't provide CAN FD bittimings by non-FD adapters
Date: Thu, 30 Jul 2015 23:53:48 +0200
Message-ID: <1438293228-20185-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:8399 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbbG3VyQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 30 Jul 2015 17:54:16 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: s.grosjean@peak-system.com, Oliver Hartkopp <socketcan@hartkopp.net>

The CAN FD data bittiming constants are provided via netlink only when there
are valid CAN FD constants available in priv->data_bittiming_const.

Due to the indirection of pointer assignments in the peak_usb driver the
priv->data_bittiming_const never becomes NULL - not even for non-FD adapters.

The data_bittiming_const points to zero'ed data which leads to this result
when running 'ip -details link show can0':

35: can0: <NOARP,ECHO> mtu 16 qdisc noop state DOWN mode DEFAULT group default qlen 10
    link/can  promiscuity 0
    can state STOPPED restart-ms 0
	  pcan_usb: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
	  : dtseg1 0..0 dtseg2 0..0 dsjw 1..0 dbrp 0..0 dbrp-inc 0  <== BROKEN!
	  clock 8000000

This patch sets the dev_set_data_bittiming in struct peak_adapter to NULL to
be able to disable the CAN FD specific information on non-FD adapters.

Relevant for stable kernels 4.0+

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c      | 1 +
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 9 +++++++--
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 6b94007..5c4b270 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -896,6 +896,7 @@ const struct peak_usb_adapter pcan_usb = {
 	.dev_init = pcan_usb_init,
 	.dev_set_bus = pcan_usb_write_mode,
 	.dev_set_bittiming = pcan_usb_set_bittiming,
+	.dev_set_data_bittiming = NULL,
 	.dev_get_device_id = pcan_usb_get_device_id,
 	.dev_decode_buf = pcan_usb_decode_buf,
 	.dev_encode_msg = pcan_usb_encode_msg,
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 7921cff..76c0624 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -794,8 +794,13 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	dev->can.clock = peak_usb_adapter->clock;
 	dev->can.bittiming_const = &peak_usb_adapter->bittiming_const;
 	dev->can.do_set_bittiming = peak_usb_set_bittiming;
-	dev->can.data_bittiming_const = &peak_usb_adapter->data_bittiming_const;
-	dev->can.do_set_data_bittiming = peak_usb_set_data_bittiming;
+	if (peak_usb_adapter->dev_set_data_bittiming) {
+		dev->can.data_bittiming_const = &peak_usb_adapter->data_bittiming_const;
+		dev->can.do_set_data_bittiming = peak_usb_set_data_bittiming;
+	} else {
+		dev->can.data_bittiming_const = NULL;
+		dev->can.do_set_data_bittiming = NULL;
+	}
 	dev->can.do_set_mode = peak_usb_set_mode;
 	dev->can.do_get_berr_counter = peak_usb_adapter->do_get_berr_counter;
 	dev->can.ctrlmode_supported = peak_usb_adapter->ctrlmode_supported;
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 7d61b32..9111a54 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -1048,6 +1048,7 @@ const struct peak_usb_adapter pcan_usb_pro = {
 	.dev_free = pcan_usb_pro_free,
 	.dev_set_bus = pcan_usb_pro_set_bus,
 	.dev_set_bittiming = pcan_usb_pro_set_bittiming,
+	.dev_set_data_bittiming = NULL,
 	.dev_get_device_id = pcan_usb_pro_get_device_id,
 	.dev_decode_buf = pcan_usb_pro_decode_buf,
 	.dev_encode_msg = pcan_usb_pro_encode_msg,
-- 
2.1.4

