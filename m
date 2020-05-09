From: =?UTF-8?Q?Fabi=C3=A1n_Inostroza?= <fabian.inostroza.p@gmail.com>
Subject: PCAN USB hardware timestamps jumps forward
Date: Sat, 9 May 2020 15:05:54 -0400
Message-ID: <CAArkK-dJkWCfUoTfZeXDiKSKNeey6_CwAK_gNB5QoRs=kA2O5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728144AbgEITGG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 9 May 2020 15:06:06 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1CDC05BD09
        for <linux-can@vger.kernel.org>; Sat,  9 May 2020 12:06:06 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id q13so4524717qtp.7
        for <linux-can@vger.kernel.org>; Sat, 09 May 2020 12:06:06 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,

I have noticed that sometimes the hardware timestamps shown by candump
jump forward, look at the following candump extract:
(0000034679.461888) can0 123#7003000000000000
(0000034682.263253) can0 123#7103000000000000
(0000034679.472170) can0 123#7203000000000000

these messages are transported in the following usb packets:
Time        Data
7.436864  02 01 08 60 24 34 7b 70 03 00 00 00 00 00 00 ...
7.441998  02 03 42 04 01 c4 7b 40 01 00 08 60 24 ad 7b 71 03 00 00 00
00 00 00 ...
7.447143  02 01 08 60 24 25 7c 72 03 00 00 00 00 00 00 ...

The time column is the time shown in Wireshark and the CAN messages
where send approx
every 5 ms.

Reading the source code of the driver I concluded that the jump is
caused because the second
usb packet contains 3 records, the first with only a timestamp, the
second record is a error record and the third contains a data record
and the timestamp of the data record is before the first record and
the driver detects this as an overflow.

I've attached a patch that fixes this, I've only tested it with PCAN
USB ver 8.3 latter upgraded to v8.4.

From 34dccd02d430b8bbb68802ab304c7e2f9f184871 Mon Sep 17 00:00:00 2001
From: Fabian Inostroza <fabianinostrozap@gmail.com>
Date: Tue, 5 May 2020 01:06:40 -0400
Subject: [PATCH] can: peak_usb: fix hardware timestamp jumps

Sometimes the adapter sends an internal record with a timestamp
captured after the timestamp contained in the following data record.
The driver interprets this as an overflow in the timestamp and produces
a jump of some seconds for the messages contained in the usb packet.

Since the adapter periodically (~1s) sends records to sync the timestamp
then this delta computed in the driver cannot be bigger than this period.
Use this to detect real overflows.

Signed-off-by: Fabian Inostroza <fabianinostrozap@gmail.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 0b7766b71..77d734731 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -130,12 +130,16 @@ void peak_usb_get_ts_time(struct peak_time_ref
*time_ref, u32 ts, ktime_t *time)
     /* protect from getting time before setting now */
     if (ktime_to_ns(time_ref->tv_host)) {
         u64 delta_us;
+        s64 delta = (s64)ts - (s64)time_ref->ts_dev_2;

-        delta_us = ts - time_ref->ts_dev_2;
-        if (ts < time_ref->ts_dev_2)
-            delta_us &= (1 << time_ref->adapter->ts_used_bits) - 1;
+        if (delta < 0) {
+            delta_us = delta &
+                ((1 << time_ref->adapter->ts_used_bits) - 1);
+            if (delta_us < time_ref->adapter->ts_period)
+                delta = delta_us;
+        }

-        delta_us += time_ref->ts_total;
+        delta_us = delta + time_ref->ts_total;

         delta_us *= time_ref->adapter->us_per_ts_scale;
         delta_us >>= time_ref->adapter->us_per_ts_shift;
-- 
2.26.2
