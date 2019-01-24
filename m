From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] [stable pre-4.8] can: bcm: check timer values before ktime conversion
Date: Thu, 24 Jan 2019 10:08:42 +0100
Message-ID: <20190124090842.2938-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: davem@davemloft.net, netdev@vger.kernel.org, stable@vger.kernel.org
Cc: linux-can@vger.kernel.org, lifeasageek@gmail.com, threeearcat@gmail.com, syzkaller@googlegroups.com, nautsch2@gmail.com, Oliver Hartkopp <socketcan@hartkopp.net>, Kyungtae Kim <kt0755@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

Kyungtae Kim detected a potential integer overflow in bcm_[rx|tx]_setup()
when the conversion into ktime multiplies the given value with NSEC_PER_USEC
(1000).

Reference: https://marc.info/?l=linux-can&m=154732118819828&w=2

Add a check for the given tv_usec, so that the value stays below one second.
Additionally limit the tv_sec value to a reasonable value for CAN related
use-cases of 400 days and ensure all values to be positive.

This patch is the pre-4.8 version of upstream commit 93171ba6f1deffd8

Reported-by: Kyungtae Kim <kt0755@gmail.com>
Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-stable <stable@vger.kernel.org> # versions 2.6.26 to 4.7
Tested-by: Kyungtae Kim <kt0755@gmail.com>
Acked-by: Andre Naujoks <nautsch2@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/bcm.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 6863310d6973..01d489d0a3de 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -67,6 +67,9 @@
  */
 #define MAX_NFRAMES 256
 
+/* limit timers to 400 days for sending/timeouts */
+#define BCM_TIMER_SEC_MAX (400 * 24 * 60 * 60)
+
 /* use of last_frames[index].can_dlc */
 #define RX_RECV    0x40 /* received data for this element */
 #define RX_THR     0x80 /* element not been sent due to throttle feature */
@@ -136,6 +139,22 @@ static inline ktime_t bcm_timeval_to_ktime(struct bcm_timeval tv)
 	return ktime_set(tv.tv_sec, tv.tv_usec * NSEC_PER_USEC);
 }
 
+/* check limitations for timeval provided by user */
+static bool bcm_is_invalid_tv(struct bcm_msg_head *msg_head)
+{
+	if ((msg_head->ival1.tv_sec < 0) ||
+	    (msg_head->ival1.tv_sec > BCM_TIMER_SEC_MAX) ||
+	    (msg_head->ival1.tv_usec < 0) ||
+	    (msg_head->ival1.tv_usec >= USEC_PER_SEC) ||
+	    (msg_head->ival2.tv_sec < 0) ||
+	    (msg_head->ival2.tv_sec > BCM_TIMER_SEC_MAX) ||
+	    (msg_head->ival2.tv_usec < 0) ||
+	    (msg_head->ival2.tv_usec >= USEC_PER_SEC))
+		return true;
+
+	return false;
+}
+
 #define CFSIZ sizeof(struct can_frame)
 #define OPSIZ sizeof(struct bcm_op)
 #define MHSIZ sizeof(struct bcm_msg_head)
@@ -846,6 +865,10 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 	if (msg_head->nframes < 1 || msg_head->nframes > MAX_NFRAMES)
 		return -EINVAL;
 
+	/* check timeval limitations */
+	if ((msg_head->flags & SETTIMER) && bcm_is_invalid_tv(msg_head))
+		return -EINVAL;
+
 	/* check the given can_id */
 	op = bcm_find_op(&bo->tx_ops, msg_head->can_id, ifindex);
 
@@ -1011,6 +1034,10 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 	     (!(msg_head->can_id & CAN_RTR_FLAG))))
 		return -EINVAL;
 
+	/* check timeval limitations */
+	if ((msg_head->flags & SETTIMER) && bcm_is_invalid_tv(msg_head))
+		return -EINVAL;
+
 	/* check the given can_id */
 	op = bcm_find_op(&bo->rx_ops, msg_head->can_id, ifindex);
 	if (op) {
-- 
2.20.1
