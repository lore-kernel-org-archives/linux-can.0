From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 5/6] sllin: If length is unknown read until timer occurs or break is received
Date: Tue, 10 Dec 2013 18:16:16 +0100
Message-ID: <1386695777-18463-6-git-send-email-alexander.stein@systec-electronic.com>
References: <1386695777-18463-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:60303 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754565Ab3LJR2U (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Dec 2013 12:28:20 -0500
In-Reply-To: <1386695777-18463-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: =?UTF-8?q?Rostislav=20Lisov=C3=BD?= <lisovy@gmail.com>, Michal Sojka <sojkam1@fel.cvut.cz>, Oliver Hartkopp <oliver.hartkopp@volkswagen.de>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

If the length is unknown stop waiting for new data until the tty rx queue
is empty once is not working on fast systems where sllin_receive_buf is
called for each byte received. Instead wait up to 8 bytes, when the
timeout occurs or when a new break is received.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 sllin/sllin.c | 54 ++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 10 deletions(-)

diff --git a/sllin/sllin.c b/sllin/sllin.c
index e8aca08..36f23a5 100644
--- a/sllin/sllin.c
+++ b/sllin/sllin.c
@@ -670,6 +670,23 @@ static int sllin_rx_validate(struct sllin *sl)
 	return 0;
 }
 
+static void sllin_slave_finish_rx_msg(struct sllin *sl)
+{
+	if (sllin_rx_validate(sl) == -1) {
+		netdev_dbg(sl->dev, "sllin: RX validation failed.\n");
+		sllin_report_error(sl, LIN_ERR_CHECKSUM);
+	} else {
+		/* Send CAN non-RTR frame with data */
+		netdev_dbg(sl->dev, "sllin: sending NON-RTR CAN frame with LIN payload.");
+		sll_bump(sl); /* send packet to the network layer */
+	}
+	/* Prepare for reception of new header */
+	sl->rx_cnt = 0;
+	sl->rx_expect = SLLIN_BUFF_ID + 1;
+	sl->rx_len_unknown = false; /* We do know exact length of the header */
+	sl->header_received = false;
+}
+
 static void sllin_slave_receive_buf(struct tty_struct *tty,
 			      const unsigned char *cp, char *fp, int count)
 {
@@ -681,6 +698,20 @@ static void sllin_slave_receive_buf(struct tty_struct *tty,
 	/* Read the characters out of the buffer */
 	while (count--) {
 		if (fp && *fp++) {
+			/*
+			 * If we don't know the length of the current message
+			 * we received the break of the next message.
+			 * Evaluate the previous one before continuing
+			 */
+			if (sl->rx_len_unknown == true)
+			{
+				hrtimer_cancel(&sl->rx_timer);
+				sllin_slave_finish_rx_msg(sl);
+
+				set_bit(SLF_RXEVENT, &sl->flags);
+				wake_up(&sl->kwt_wq);
+			}
+
 			netdev_dbg(sl->dev, "sllin_slave_receive_buf char 0x%02x ignored "
 				"due marker 0x%02x, flags 0x%lx\n",
 				*cp, *(fp-1), sl->flags);
@@ -736,25 +767,23 @@ static void sllin_slave_receive_buf(struct tty_struct *tty,
 
 			sl->header_received = true;
 
+			hrtimer_start(&sl->rx_timer,
+				ktime_add(ktime_get(), sl->rx_timer_timeout),
+				HRTIMER_MODE_ABS);
 			sll_send_rtr(sl);
 			continue;
 		}
 
 		/* Response received */
 		if ((sl->header_received == true) &&
-			((sl->rx_cnt >= sl->rx_expect) ||
-			((sl->rx_len_unknown == true) && (count == 0)))) {
+			((sl->rx_cnt >= sl->rx_expect))) {
 
-			sll_bump(sl);
+			hrtimer_cancel(&sl->rx_timer);
 			netdev_dbg(sl->dev, "Received LIN header & LIN response. "
 					"rx_cnt = %u, rx_expect = %u\n", sl->rx_cnt,
 					sl->rx_expect);
+			sllin_slave_finish_rx_msg(sl);
 
-			/* Prepare for reception of new header */
-			sl->rx_cnt = 0;
-			sl->rx_expect = SLLIN_BUFF_ID + 1;
-			sl->rx_len_unknown = false; /* We do know exact length of the header */
-			sl->header_received = false;
 		}
 	}
 }
@@ -905,8 +934,13 @@ static enum hrtimer_restart sllin_rx_timeout_handler(struct hrtimer *hrtimer)
 {
 	struct sllin *sl = container_of(hrtimer, struct sllin, rx_timer);
 
-	sllin_report_error(sl, LIN_ERR_RX_TIMEOUT);
-	set_bit(SLF_TMOUTEVENT, &sl->flags);
+	if (sl->lin_master) {
+		sllin_report_error(sl, LIN_ERR_RX_TIMEOUT);
+		set_bit(SLF_TMOUTEVENT, &sl->flags);
+	} else {
+		sllin_slave_finish_rx_msg(sl);
+		set_bit(SLF_RXEVENT, &sl->flags);
+	}
 	wake_up(&sl->kwt_wq);
 
 	return HRTIMER_NORESTART;
-- 
1.8.3.2

