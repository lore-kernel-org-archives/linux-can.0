From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 2/2] can: bcm: limit minimum gap of tx cycle time
Date: Thu, 24 Aug 2017 13:59:03 +0200
Message-ID: <20170824115903.3661-2-socketcan@hartkopp.net>
References: <20170824115903.3661-1-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:8677 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbdHXL7Y (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Aug 2017 07:59:24 -0400
In-Reply-To: <20170824115903.3661-1-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

The cyclic TX message creation is intended for automotive use-cases to
implement high precision CAN frame transmissions from kernel space.
Usual applications send CAN frames in a cycle time ranging from 1000ms
down to 5ms. This patch implements a reasonable minimum gap of 500us.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index f1a8d9a5b1cb..b0dbe7a389ee 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -67,6 +67,9 @@
  */
 #define MAX_NFRAMES 256
 
+/* minimum gap between two frame transmissions for TX_SETUP : 500 usecs */
+#define BCM_TX_MIN_NS 500000
+
 /* use of last_frames[index].flags */
 #define RX_RECV    0x40 /* received data for this element */
 #define RX_THR     0x80 /* element not been sent due to throttle feature */
@@ -1020,6 +1023,12 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		op->kt_ival1 = bcm_timeval_to_ktime(msg_head->ival1);
 		op->kt_ival2 = bcm_timeval_to_ktime(msg_head->ival2);
 
+		if (op->kt_ival1 && ktime_to_ns(op->kt_ival1) < BCM_TX_MIN_NS)
+			op->kt_ival1 = BCM_TX_MIN_NS;
+
+		if (op->kt_ival2 && ktime_to_ns(op->kt_ival2) < BCM_TX_MIN_NS)
+			op->kt_ival2 = BCM_TX_MIN_NS;
+
 		/* disable an active timer due to zero values? */
 		if (!op->kt_ival1 && !op->kt_ival2)
 			hrtimer_cancel(&op->timer);
-- 
2.11.0

