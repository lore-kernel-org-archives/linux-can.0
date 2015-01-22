From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 6/7 v8] can/peak_usb: add peak_usb_netif_rx() new function
Date: Thu, 22 Jan 2015 16:24:25 +0100
Message-ID: <1421940266-6088-7-git-send-email-s.grosjean@peak-system.com>
References: <1421940266-6088-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:58295 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbbAVP0V (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Jan 2015 10:26:21 -0500
In-Reply-To: <1421940266-6088-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Stephane Grosjean <s.grosjean@peak-system.com>, Marc Kleine-Budde <mkl@pengutronix.de>

Add a common function that pushes the skb in the network queue with adding
timestamps information, converted from time values read from the
PEAK USB adapters.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 15 +++++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  4 +++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 49004aa..7138433 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -165,6 +165,21 @@ void peak_usb_get_ts_tv(struct peak_time_ref *time_ref, u32 ts,
 }
 
 /*
+ * post received skb after having set any hw timestamp
+ */
+int peak_usb_netif_rx(struct sk_buff *skb,
+		      struct peak_time_ref *time_ref, u32 ts_low, u32 ts_high)
+{
+	struct skb_shared_hwtstamps *hwts = skb_hwtstamps(skb);
+	struct timeval tv;
+
+	peak_usb_get_ts_tv(time_ref, ts_low, &tv);
+	hwts->hwtstamp = timeval_to_ktime(tv);
+
+	return netif_rx(skb);
+}
+
+/*
  * callback for bulk Rx urb
  */
 static void peak_usb_read_bulk_callback(struct urb *urb)
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index 34e24c6..00b881b 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -145,7 +145,9 @@ void peak_usb_update_ts_now(struct peak_time_ref *time_ref, u32 ts_now);
 void peak_usb_set_ts_now(struct peak_time_ref *time_ref, u32 ts_now);
 void peak_usb_get_ts_tv(struct peak_time_ref *time_ref, u32 ts,
 			struct timeval *tv);
-
+int peak_usb_netif_rx(struct sk_buff *skb,
+		      struct peak_time_ref *time_ref, u32 ts_low, u32 ts_high);
 void peak_usb_async_complete(struct urb *urb);
 void peak_usb_restart_complete(struct peak_usb_device *dev);
+
 #endif
-- 
1.9.1

