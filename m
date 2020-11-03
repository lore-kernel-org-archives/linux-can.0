Return-Path: <SRS0=Fclt=EJ=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272FEC388F7
	for <linux-can@archiver.kernel.org>; Tue,  3 Nov 2020 22:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E99EE20665
	for <linux-can@archiver.kernel.org>; Tue,  3 Nov 2020 22:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbgKCWHJ (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 3 Nov 2020 17:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731440AbgKCWG4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 3 Nov 2020 17:06:56 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677CAC061A4F
        for <linux-can@vger.kernel.org>; Tue,  3 Nov 2020 14:06:54 -0800 (PST)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ka4S1-0006Ui-4o; Tue, 03 Nov 2020 23:06:49 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Fabian Inostroza <fabianinostrozap@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net 19/27] can: peak_usb: peak_usb_get_ts_time(): fix timestamp wrapping
Date:   Tue,  3 Nov 2020 23:06:28 +0100
Message-Id: <20201103220636.972106-20-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103220636.972106-1-mkl@pengutronix.de>
References: <20201103220636.972106-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Stephane Grosjean <s.grosjean@peak-system.com>

Fabian Inostroza <fabianinostrozap@gmail.com> has discovered a potential
problem in the hardware timestamp reporting from the PCAN-USB USB CAN interface
(only), related to the fact that a timestamp of an event may precede the
timestamp used for synchronization when both records are part of the same USB
packet. However, this case was used to detect the wrapping of the time counter.

This patch details and fixes the two identified cases where this problem can
occur.

Reported-by: Fabian Inostroza <fabianinostrozap@gmail.com>
Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Link: https://lore.kernel.org/r/20201014085631.15128-1-s.grosjean@peak-system.com
Fixes: bb4785551f64 ("can: usb: PEAK-System Technik USB adapters driver core")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 51 ++++++++++++++++++--
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index d91df34e7fa8..c2764799f9ef 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -130,14 +130,55 @@ void peak_usb_get_ts_time(struct peak_time_ref *time_ref, u32 ts, ktime_t *time)
 	/* protect from getting time before setting now */
 	if (ktime_to_ns(time_ref->tv_host)) {
 		u64 delta_us;
+		s64 delta_ts = 0;
+
+		/* General case: dev_ts_1 < dev_ts_2 < ts, with:
+		 *
+		 * - dev_ts_1 = previous sync timestamp
+		 * - dev_ts_2 = last sync timestamp
+		 * - ts = event timestamp
+		 * - ts_period = known sync period (theoretical)
+		 *             ~ dev_ts2 - dev_ts1
+		 * *but*:
+		 *
+		 * - time counters wrap (see adapter->ts_used_bits)
+		 * - sometimes, dev_ts_1 < ts < dev_ts2
+		 *
+		 * "normal" case (sync time counters increase):
+		 * must take into account case when ts wraps (tsw)
+		 *
+		 *      < ts_period > <          >
+		 *     |             |            |
+		 *  ---+--------+----+-------0-+--+-->
+		 *     ts_dev_1 |    ts_dev_2  |
+		 *              ts             tsw
+		 */
+		if (time_ref->ts_dev_1 < time_ref->ts_dev_2) {
+			/* case when event time (tsw) wraps */
+			if (ts < time_ref->ts_dev_1)
+				delta_ts = 1 << time_ref->adapter->ts_used_bits;
+
+		/* Otherwise, sync time counter (ts_dev_2) has wrapped:
+		 * handle case when event time (tsn) hasn't.
+		 *
+		 *      < ts_period > <          >
+		 *     |             |            |
+		 *  ---+--------+--0-+---------+--+-->
+		 *     ts_dev_1 |    ts_dev_2  |
+		 *              tsn            ts
+		 */
+		} else if (time_ref->ts_dev_1 < ts) {
+			delta_ts = -(1 << time_ref->adapter->ts_used_bits);
+		}
 
-		delta_us = ts - time_ref->ts_dev_2;
-		if (ts < time_ref->ts_dev_2)
-			delta_us &= (1 << time_ref->adapter->ts_used_bits) - 1;
+		/* add delay between last sync and event timestamps */
+		delta_ts += (signed int)(ts - time_ref->ts_dev_2);
 
-		delta_us += time_ref->ts_total;
+		/* add time from beginning to last sync */
+		delta_ts += time_ref->ts_total;
 
-		delta_us *= time_ref->adapter->us_per_ts_scale;
+		/* convert ticks number into microseconds */
+		delta_us = delta_ts * time_ref->adapter->us_per_ts_scale;
 		delta_us >>= time_ref->adapter->us_per_ts_shift;
 
 		*time = ktime_add_us(time_ref->tv_host_0, delta_us);
-- 
2.28.0

