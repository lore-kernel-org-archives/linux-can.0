From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] can: peak_usb: remove some 'struct timeval' users
Date: Fri,  3 Nov 2017 17:31:36 +0100
Message-ID: <20171103163220.3799742-1-arnd@arndb.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:62219 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755977AbdKCQdB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 3 Nov 2017 12:33:01 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>, Allen Pais <allen.lkml@gmail.com>, Stephane Grosjean <s.grosjean@peak-system.com>, Johan Hovold <johan@kernel.org>, =?UTF-8?q?=EC=B6=94=EC=A7=80=ED=98=B8?= <jiho.chu@samsung.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

We want to remove 'struct timeval' and related interfaces since this is
generally not safe for use beyond 2038.

For peak_usb, we can simplify the internal interface by using ktime_t
directly. This should not change any behavior, but it avoids a few
conversions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c      |  9 +++------
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 15 +++++++--------
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  3 +--
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  |  9 +++------
 4 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 25a9b79cc42d..f530a80f5051 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -408,7 +408,6 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 {
 	struct sk_buff *skb;
 	struct can_frame *cf;
-	struct timeval tv;
 	enum can_state new_state;
 
 	/* ignore this error until 1st ts received */
@@ -525,8 +524,8 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 	if (status_len & PCAN_USB_STATUSLEN_TIMESTAMP) {
 		struct skb_shared_hwtstamps *hwts = skb_hwtstamps(skb);
 
-		peak_usb_get_ts_tv(&mc->pdev->time_ref, mc->ts16, &tv);
-		hwts->hwtstamp = timeval_to_ktime(tv);
+		peak_usb_get_ts_time(&mc->pdev->time_ref, mc->ts16,
+				     &hwts->hwtstamp);
 	}
 
 	mc->netdev->stats.rx_packets++;
@@ -610,7 +609,6 @@ static int pcan_usb_decode_data(struct pcan_usb_msg_context *mc, u8 status_len)
 	u8 rec_len = status_len & PCAN_USB_STATUSLEN_DLC;
 	struct sk_buff *skb;
 	struct can_frame *cf;
-	struct timeval tv;
 	struct skb_shared_hwtstamps *hwts;
 
 	skb = alloc_can_skb(mc->netdev, &cf);
@@ -658,9 +656,8 @@ static int pcan_usb_decode_data(struct pcan_usb_msg_context *mc, u8 status_len)
 	}
 
 	/* convert timestamp into kernel time */
-	peak_usb_get_ts_tv(&mc->pdev->time_ref, mc->ts16, &tv);
 	hwts = skb_hwtstamps(skb);
-	hwts->hwtstamp = timeval_to_ktime(tv);
+	peak_usb_get_ts_time(&mc->pdev->time_ref, mc->ts16, &hwts->hwtstamp);
 
 	/* update statistics */
 	mc->netdev->stats.rx_packets++;
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 1ca76e03e965..695a75a9b4bb 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -148,11 +148,11 @@ void peak_usb_set_ts_now(struct peak_time_ref *time_ref, u32 ts_now)
 /*
  * compute timeval according to current ts and time_ref data
  */
-void peak_usb_get_ts_tv(struct peak_time_ref *time_ref, u32 ts,
-			struct timeval *tv)
+void peak_usb_get_ts_time(struct peak_time_ref *time_ref, u32 ts, ktime_t *time)
 {
 	/* protect from getting timeval before setting now */
 	if (time_ref->tv_host.tv_sec > 0) {
+		struct timeval tv;
 		u64 delta_us;
 
 		delta_us = ts - time_ref->ts_dev_2;
@@ -164,10 +164,11 @@ void peak_usb_get_ts_tv(struct peak_time_ref *time_ref, u32 ts,
 		delta_us *= time_ref->adapter->us_per_ts_scale;
 		delta_us >>= time_ref->adapter->us_per_ts_shift;
 
-		*tv = time_ref->tv_host_0;
-		peak_usb_add_us(tv, (u32)delta_us);
+		tv = time_ref->tv_host_0;
+		peak_usb_add_us(&tv, (u32)delta_us);
+		*time = timeval_to_ktime(tv);
 	} else {
-		*tv = ktime_to_timeval(ktime_get());
+		*time = ktime_get();
 	}
 }
 
@@ -178,10 +179,8 @@ int peak_usb_netif_rx(struct sk_buff *skb,
 		      struct peak_time_ref *time_ref, u32 ts_low, u32 ts_high)
 {
 	struct skb_shared_hwtstamps *hwts = skb_hwtstamps(skb);
-	struct timeval tv;
 
-	peak_usb_get_ts_tv(time_ref, ts_low, &tv);
-	hwts->hwtstamp = timeval_to_ktime(tv);
+	peak_usb_get_ts_time(time_ref, ts_low, &hwts->hwtstamp);
 
 	return netif_rx(skb);
 }
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index c01316cac354..b9a221ea7e5c 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -151,8 +151,7 @@ void peak_usb_init_time_ref(struct peak_time_ref *time_ref,
 			    const struct peak_usb_adapter *adapter);
 void peak_usb_update_ts_now(struct peak_time_ref *time_ref, u32 ts_now);
 void peak_usb_set_ts_now(struct peak_time_ref *time_ref, u32 ts_now);
-void peak_usb_get_ts_tv(struct peak_time_ref *time_ref, u32 ts,
-			struct timeval *tv);
+void peak_usb_get_ts_time(struct peak_time_ref *time_ref, u32 ts, ktime_t *tv);
 int peak_usb_netif_rx(struct sk_buff *skb,
 		      struct peak_time_ref *time_ref, u32 ts_low, u32 ts_high);
 void peak_usb_async_complete(struct urb *urb);
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index bbdd6058cd2f..0105fbfea273 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -531,7 +531,6 @@ static int pcan_usb_pro_handle_canmsg(struct pcan_usb_pro_interface *usb_if,
 	struct net_device *netdev = dev->netdev;
 	struct can_frame *can_frame;
 	struct sk_buff *skb;
-	struct timeval tv;
 	struct skb_shared_hwtstamps *hwts;
 
 	skb = alloc_can_skb(netdev, &can_frame);
@@ -549,9 +548,9 @@ static int pcan_usb_pro_handle_canmsg(struct pcan_usb_pro_interface *usb_if,
 	else
 		memcpy(can_frame->data, rx->data, can_frame->can_dlc);
 
-	peak_usb_get_ts_tv(&usb_if->time_ref, le32_to_cpu(rx->ts32), &tv);
 	hwts = skb_hwtstamps(skb);
-	hwts->hwtstamp = timeval_to_ktime(tv);
+	peak_usb_get_ts_time(&usb_if->time_ref, le32_to_cpu(rx->ts32),
+			     &hwts->hwtstamp);
 
 	netdev->stats.rx_packets++;
 	netdev->stats.rx_bytes += can_frame->can_dlc;
@@ -571,7 +570,6 @@ static int pcan_usb_pro_handle_error(struct pcan_usb_pro_interface *usb_if,
 	enum can_state new_state = CAN_STATE_ERROR_ACTIVE;
 	u8 err_mask = 0;
 	struct sk_buff *skb;
-	struct timeval tv;
 	struct skb_shared_hwtstamps *hwts;
 
 	/* nothing should be sent while in BUS_OFF state */
@@ -667,9 +665,8 @@ static int pcan_usb_pro_handle_error(struct pcan_usb_pro_interface *usb_if,
 
 	dev->can.state = new_state;
 
-	peak_usb_get_ts_tv(&usb_if->time_ref, le32_to_cpu(er->ts32), &tv);
 	hwts = skb_hwtstamps(skb);
-	hwts->hwtstamp = timeval_to_ktime(tv);
+	peak_usb_get_ts_time(&usb_if->time_ref, le32_to_cpu(er->ts32), &hwts->hwtstamp);
 	netdev->stats.rx_packets++;
 	netdev->stats.rx_bytes += can_frame->can_dlc;
 	netif_rx(skb);
-- 
2.9.0

