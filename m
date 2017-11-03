From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2] can: peak_usb: use ktime_t consistently
Date: Fri,  3 Nov 2017 17:31:37 +0100
Message-ID: <20171103163220.3799742-2-arnd@arndb.de>
References: <20171103163220.3799742-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171103163220.3799742-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Stephane Grosjean <s.grosjean@peak-system.com>, =?UTF-8?q?=EC=B6=94=EC=A7=80=ED=98=B8?= <jiho.chu@samsung.com>, Johan Hovold <johan@kernel.org>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This changes the calculation of the timestamps to use ktime_t
instead of struct timeval as the base. This gets rid of one
of the few remaining users of the deprecated ktime_to_timeval()
and timeval_to_ktime() helpers.

The code should also get more efficient, as we have now removed
all of the divisions.

I have left the cut-off for resetting the counters as 4.200
seconds, in order to leave the behavior unchanged otherwise.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 46 +++++++++-------------------
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  2 +-
 2 files changed, 15 insertions(+), 33 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 695a75a9b4bb..8f699ee6a528 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -80,21 +80,6 @@ void peak_usb_init_time_ref(struct peak_time_ref *time_ref,
 	}
 }
 
-static void peak_usb_add_us(struct timeval *tv, u32 delta_us)
-{
-	/* number of s. to add to final time */
-	u32 delta_s = delta_us / 1000000;
-
-	delta_us -= delta_s * 1000000;
-
-	tv->tv_usec += delta_us;
-	if (tv->tv_usec >= 1000000) {
-		tv->tv_usec -= 1000000;
-		delta_s++;
-	}
-	tv->tv_sec += delta_s;
-}
-
 /*
  * sometimes, another now may be  more recent than current one...
  */
@@ -103,7 +88,7 @@ void peak_usb_update_ts_now(struct peak_time_ref *time_ref, u32 ts_now)
 	time_ref->ts_dev_2 = ts_now;
 
 	/* should wait at least two passes before computing */
-	if (time_ref->tv_host.tv_sec > 0) {
+	if (ktime_to_ns(time_ref->tv_host) > 0) {
 		u32 delta_ts = time_ref->ts_dev_2 - time_ref->ts_dev_1;
 
 		if (time_ref->ts_dev_2 < time_ref->ts_dev_1)
@@ -118,26 +103,26 @@ void peak_usb_update_ts_now(struct peak_time_ref *time_ref, u32 ts_now)
  */
 void peak_usb_set_ts_now(struct peak_time_ref *time_ref, u32 ts_now)
 {
-	if (time_ref->tv_host_0.tv_sec == 0) {
+	if (ktime_to_ns(time_ref->tv_host_0) == 0) {
 		/* use monotonic clock to correctly compute further deltas */
-		time_ref->tv_host_0 = ktime_to_timeval(ktime_get());
-		time_ref->tv_host.tv_sec = 0;
+		time_ref->tv_host_0 = ktime_get();
+		time_ref->tv_host = ktime_set(0, 0);
 	} else {
 		/*
-		 * delta_us should not be >= 2^32 => delta_s should be < 4294
+		 * delta_us should not be >= 2^32 => delta should be < 4294s
 		 * handle 32-bits wrapping here: if count of s. reaches 4200,
 		 * reset counters and change time base
 		 */
-		if (time_ref->tv_host.tv_sec != 0) {
-			u32 delta_s = time_ref->tv_host.tv_sec
-						- time_ref->tv_host_0.tv_sec;
-			if (delta_s > 4200) {
+		if (ktime_to_ns(time_ref->tv_host)) {
+			ktime_t delta = ktime_sub(time_ref->tv_host,
+						  time_ref->tv_host_0);
+			if (ktime_to_ns(delta) > (4200ull * NSEC_PER_SEC)) {
 				time_ref->tv_host_0 = time_ref->tv_host;
 				time_ref->ts_total = 0;
 			}
 		}
 
-		time_ref->tv_host = ktime_to_timeval(ktime_get());
+		time_ref->tv_host = ktime_get();
 		time_ref->tick_count++;
 	}
 
@@ -146,13 +131,12 @@ void peak_usb_set_ts_now(struct peak_time_ref *time_ref, u32 ts_now)
 }
 
 /*
- * compute timeval according to current ts and time_ref data
+ * compute time according to current ts and time_ref data
  */
 void peak_usb_get_ts_time(struct peak_time_ref *time_ref, u32 ts, ktime_t *time)
 {
-	/* protect from getting timeval before setting now */
-	if (time_ref->tv_host.tv_sec > 0) {
-		struct timeval tv;
+	/* protect from getting time before setting now */
+	if (ktime_to_ns(time_ref->tv_host)) {
 		u64 delta_us;
 
 		delta_us = ts - time_ref->ts_dev_2;
@@ -164,9 +148,7 @@ void peak_usb_get_ts_time(struct peak_time_ref *time_ref, u32 ts, ktime_t *time)
 		delta_us *= time_ref->adapter->us_per_ts_scale;
 		delta_us >>= time_ref->adapter->us_per_ts_shift;
 
-		tv = time_ref->tv_host_0;
-		peak_usb_add_us(&tv, (u32)delta_us);
-		*time = timeval_to_ktime(tv);
+		*time = ktime_add_us(time_ref->tv_host_0, delta_us);
 	} else {
 		*time = ktime_get();
 	}
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index b9a221ea7e5c..29f03dccca10 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -96,7 +96,7 @@ extern const struct peak_usb_adapter pcan_usb_pro_fd;
 extern const struct peak_usb_adapter pcan_usb_x6;
 
 struct peak_time_ref {
-	struct timeval tv_host_0, tv_host;
+	ktime_t tv_host_0, tv_host;
 	u32 ts_dev_1, ts_dev_2;
 	u64 ts_total;
 	u32 tick_count;
-- 
2.9.0
