From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 1/6] sllin: Replace pr_* with netdev_* where approriate
Date: Tue, 10 Dec 2013 18:16:12 +0100
Message-ID: <1386695777-18463-2-git-send-email-alexander.stein@systec-electronic.com>
References: <1386695777-18463-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:60304 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754848Ab3LJR2U (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Dec 2013 12:28:20 -0500
In-Reply-To: <1386695777-18463-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: =?UTF-8?q?Rostislav=20Lisov=C3=BD?= <lisovy@gmail.com>, Michal Sojka <sojkam1@fel.cvut.cz>, Oliver Hartkopp <oliver.hartkopp@volkswagen.de>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 sllin/sllin.c | 70 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/sllin/sllin.c b/sllin/sllin.c
index 58e59e4..c1cdcd1 100644
--- a/sllin/sllin.c
+++ b/sllin/sllin.c
@@ -319,7 +319,7 @@ static void sllin_write_wakeup(struct tty_struct *tty)
 	} while (unlikely(test_bit(SLF_TXBUFF_RQ, &sl->flags)));
 
 	if ((remains > 0) && (actual >= 0)) {
-		pr_debug("sllin: sllin_write_wakeup sent %d, remains %d, waiting\n",
+		netdev_dbg(sl->dev, "sllin_write_wakeup sent %d, remains %d, waiting\n",
 			sl->tx_cnt, sl->tx_lim - sl->tx_cnt);
 		return;
 	}
@@ -328,7 +328,7 @@ static void sllin_write_wakeup(struct tty_struct *tty)
 	set_bit(SLF_TXEVENT, &sl->flags);
 	wake_up(&sl->kwt_wq);
 
-	pr_debug("sllin: sllin_write_wakeup sent %d, wakeup\n", sl->tx_cnt);
+	netdev_dbg(sl->dev, "sllin_write_wakeup sent %d, wakeup\n", sl->tx_cnt);
 }
 
 /**
@@ -347,11 +347,11 @@ static netdev_tx_t sll_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	spin_lock(&sl->lock);
 	if (!netif_running(dev))  {
-		pr_warn("%s: xmit: iface is down\n", dev->name);
+		netdev_warn(sl->dev, "xmit: iface is down\n");
 		goto err_out_unlock;
 	}
 	if (sl->tty == NULL) {
-		pr_warn("%s: xmit: no tty device connected\n", dev->name);
+		netdev_warn(sl->dev, "xmit: no tty device connected\n");
 		goto err_out_unlock;
 	}
 
@@ -405,7 +405,7 @@ static int sll_open(struct net_device *dev)
 {
 	struct sllin *sl = netdev_priv(dev);
 
-	pr_debug("sllin: %s() invoked\n", __func__);
+	netdev_dbg(sl->dev, "%s() invoked\n", __func__);
 
 	if (sl->tty == NULL)
 		return -ENODEV;
@@ -457,7 +457,7 @@ static void sllin_master_receive_buf(struct tty_struct *tty,
 	/* Read the characters out of the buffer */
 	while (count--) {
 		if (fp && *fp++) {
-			pr_debug("sllin: sllin_receive_buf char 0x%02x ignored "
+			netdev_dbg(sl->dev, "sllin_master_receive_buf char 0x%02x ignored "
 				"due marker 0x%02x, flags 0x%lx\n",
 				*cp, *(fp-1), sl->flags);
 
@@ -472,13 +472,13 @@ static void sllin_master_receive_buf(struct tty_struct *tty,
 #ifndef BREAK_BY_BAUD
 		/* We didn't receive Break character -- fake it! */
 		if ((sl->rx_cnt == SLLIN_BUFF_BREAK) && (*cp == 0x55)) {
-			pr_debug("sllin: LIN_RX[%d]: 0x00\n", sl->rx_cnt);
+			netdev_dbg(sl->dev, "LIN_RX[%d]: 0x00\n", sl->rx_cnt);
 			sl->rx_buff[sl->rx_cnt++] = 0x00;
 		}
 #endif /* BREAK_BY_BAUD */
 
 		if (sl->rx_cnt < SLLIN_BUFF_LEN) {
-			pr_debug("sllin: LIN_RX[%d]: 0x%02x\n", sl->rx_cnt, *cp);
+			netdev_dbg(sl->dev, "LIN_RX[%d]: 0x%02x\n", sl->rx_cnt, *cp);
 			sl->rx_buff[sl->rx_cnt++] = *cp++;
 		}
 	}
@@ -487,9 +487,9 @@ static void sllin_master_receive_buf(struct tty_struct *tty,
 	if (sl->rx_cnt >= sl->rx_expect) {
 		set_bit(SLF_RXEVENT, &sl->flags);
 		wake_up(&sl->kwt_wq);
-		pr_debug("sllin: sllin_receive_buf count %d, wakeup\n",	sl->rx_cnt);
+		netdev_dbg(sl->dev, "sllin_receive_buf count %d, wakeup\n", sl->rx_cnt);
 	} else {
-		pr_debug("sllin: sllin_receive_buf count %d, waiting\n", sl->rx_cnt);
+		netdev_dbg(sl->dev, "sllin_receive_buf count %d, waiting\n", sl->rx_cnt);
 	}
 }
 
@@ -505,7 +505,7 @@ static void sllin_slave_receive_buf(struct tty_struct *tty,
 	/* Read the characters out of the buffer */
 	while (count--) {
 		if (fp && *fp++) {
-			pr_debug("sllin: sllin_receive_buf char 0x%02x ignored "
+			netdev_dbg(sl->dev, "sllin_slave_receive_buf char 0x%02x ignored "
 				"due marker 0x%02x, flags 0x%lx\n",
 				*cp, *(fp-1), sl->flags);
 
@@ -517,7 +517,7 @@ static void sllin_slave_receive_buf(struct tty_struct *tty,
 		}
 
 		if (sl->rx_cnt < SLLIN_BUFF_LEN) {
-			pr_debug("sllin: LIN_RX[%d]: 0x%02x\n", sl->rx_cnt, *cp);
+			netdev_dbg(sl->dev, "LIN_RX[%d]: 0x%02x\n", sl->rx_cnt, *cp);
 
 			/* We did not receive break (0x00) character */
 			if ((sl->rx_cnt == SLLIN_BUFF_BREAK) && (*cp == 0x55)) {
@@ -547,6 +547,7 @@ static void sllin_slave_receive_buf(struct tty_struct *tty,
 			sce = &sl->linfr_cache[lin_id];
 
 			spin_lock_irqsave(&sl->linfr_lock, flags);
+
 			/* Is the length of data set in frame cache? */
 			if (sce->frame_fl & LIN_CACHE_RESPONSE) {
 				sl->rx_expect += sce->dlc;
@@ -558,6 +559,7 @@ static void sllin_slave_receive_buf(struct tty_struct *tty,
 			spin_unlock_irqrestore(&sl->linfr_lock, flags);
 
 			sl->header_received = true;
+
 			sll_send_rtr(sl);
 			continue;
 		}
@@ -568,7 +570,7 @@ static void sllin_slave_receive_buf(struct tty_struct *tty,
 			((sl->rx_len_unknown == true) && (count == 0)))) {
 
 			sll_bump(sl);
-			pr_debug("sllin: Received LIN header & LIN response. "
+			netdev_dbg(sl->dev, "Received LIN header & LIN response. "
 					"rx_cnt = %u, rx_expect = %u\n", sl->rx_cnt,
 					sl->rx_expect);
 
@@ -585,7 +587,7 @@ static void sllin_receive_buf(struct tty_struct *tty,
 			      const unsigned char *cp, char *fp, int count)
 {
 	struct sllin *sl = (struct sllin *) tty->disc_data;
-	pr_debug("sllin: sllin_receive_buf invoked, count = %u\n", count);
+	netdev_dbg(sl->dev, "sllin_receive_buf invoked, count = %u\n", count);
 
 	if (!sl || sl->magic != SLLIN_MAGIC || !netif_running(sl->dev))
 		return;
@@ -643,7 +645,7 @@ static int sllin_configure_frame_cache(struct sllin *sl, struct can_frame *cf)
 		return -1;
 
 	sce = &sl->linfr_cache[cf->can_id & LIN_ID_MASK];
-	pr_debug("sllin: Setting frame cache with EFF CAN frame. LIN ID = %d\n",
+	netdev_dbg(sl->dev, "Setting frame cache with EFF CAN frame. LIN ID = %d\n",
 		cf->can_id & LIN_ID_MASK);
 
 	spin_lock_irqsave(&sl->linfr_lock, flags);
@@ -776,7 +778,7 @@ int sllin_send_tx_buff(struct sllin *sl)
 			sl->tx_cnt += res;
 		}
 
-		pr_debug("sllin: sllin_send_tx_buff sent %d, remains %d\n",
+		netdev_dbg(sl->dev, "sllin_send_tx_buff sent %d, remains %d\n",
 				sl->tx_cnt, remains);
 
 		clear_bit(SLF_TXBUFF_INPR, &sl->flags);
@@ -851,7 +853,7 @@ int sllin_send_break(struct sllin *sl)
 
 	sl->tx_cnt = SLLIN_BUFF_SYNC;
 
-	pr_debug("sllin: Break sent.\n");
+	netdev_dbg(sl->dev, "Break sent.\n");
 	set_bit(SLF_RXEVENT, &sl->flags);
 	wake_up(&sl->kwt_wq);
 
@@ -922,7 +924,7 @@ int sllin_kwthread(void *ptr)
 	int tx_bytes = 0; /* Used for Network statistics */
 
 
-	pr_debug("sllin: sllin_kwthread started.\n");
+	netdev_dbg(sl->dev, "sllin_kwthread started.\n");
 	sched_setscheduler(current, SCHED_FIFO, &schparam);
 
 	clear_bit(SLF_ERROR, &sl->flags);
@@ -952,14 +954,14 @@ int sllin_kwthread(void *ptr)
 				&& test_bit(SLF_MSGEVENT, &sl->flags)));
 
 		if (test_and_clear_bit(SLF_RXEVENT, &sl->flags)) {
-			pr_debug("sllin: sllin_kthread RXEVENT\n");
+			netdev_dbg(sl->dev, "sllin_kthread RXEVENT\n");
 		}
 
 		if (test_and_clear_bit(SLF_ERROR, &sl->flags)) {
 			unsigned long usleep_range_min;
 			unsigned long usleep_range_max;
 			hrtimer_cancel(&sl->rx_timer);
-			pr_debug("sllin: sllin_kthread ERROR\n");
+			netdev_dbg(sl->dev, "sllin_kthread ERROR\n");
 
 			if (sl->lin_state != SLSTATE_IDLE)
 				sllin_report_error(sl, LIN_ERR_FRAMING);
@@ -973,11 +975,11 @@ int sllin_kwthread(void *ptr)
 		}
 
 		if (test_and_clear_bit(SLF_TXEVENT, &sl->flags)) {
-			pr_debug("sllin: sllin_kthread TXEVENT\n");
+			netdev_dbg(sl->dev, "sllin_kthread TXEVENT\n");
 		}
 
 		if (test_and_clear_bit(SLF_TMOUTEVENT, &sl->flags)) {
-			pr_debug("sllin: sllin_kthread TMOUTEVENT\n");
+			netdev_dbg(sl->dev, "sllin_kthread TMOUTEVENT\n");
 			sllin_reset_buffs(sl);
 
 			sl->lin_state = SLSTATE_IDLE;
@@ -995,7 +997,7 @@ int sllin_kwthread(void *ptr)
 				unsigned long flags;
 				struct sllin_conf_entry *sce;
 
-				pr_debug("sllin: %s: RTR SFF CAN frame, ID = %x\n",
+				netdev_dbg(sl->dev, "%s: RTR SFF CAN frame, ID = %x\n",
 					__func__, cf->can_id & LIN_ID_MASK);
 
 				sce = &sl->linfr_cache[cf->can_id & LIN_ID_MASK];
@@ -1005,7 +1007,7 @@ int sllin_kwthread(void *ptr)
 				if ((sce->frame_fl & LIN_CACHE_RESPONSE)
 					&& (sce->dlc > 0)) {
 
-					pr_debug("sllin: Sending LIN response from linfr_cache\n");
+					netdev_dbg(sl->dev, "Sending LIN response from linfr_cache\n");
 
 					lin_data = sce->data;
 					lin_dlc = sce->dlc;
@@ -1020,7 +1022,7 @@ int sllin_kwthread(void *ptr)
 				spin_unlock_irqrestore(&sl->linfr_lock, flags);
 
 			} else { /* SFF NON-RTR CAN frame -> LIN header + LIN response */
-				pr_debug("sllin: %s: NON-RTR SFF CAN frame, ID = %x\n",
+				netdev_dbg(sl->dev, "%s: NON-RTR SFF CAN frame, ID = %x\n",
 					__func__, (int)cf->can_id & LIN_ID_MASK);
 
 				lin_data = cf->data;
@@ -1092,7 +1094,7 @@ slstate_response_wait:
 				lin_buff = (sl->lin_master) ? sl->tx_buff : sl->rx_buff;
 				if (cf->can_id == (lin_buff[SLLIN_BUFF_ID] & LIN_ID_MASK)) {
 					hrtimer_cancel(&sl->rx_timer);
-					pr_debug("sllin: received LIN response in a CAN frame.\n");
+					netdev_dbg(sl->dev, "received LIN response in a CAN frame.\n");
 					if (sllin_setup_msg(sl, SLLIN_STPMSG_RESPONLY,
 						cf->can_id & LIN_ID_MASK,
 						cf->data, cf->can_dlc) != -1) {
@@ -1125,15 +1127,15 @@ slstate_response_wait:
 				continue;
 
 			hrtimer_cancel(&sl->rx_timer);
-			pr_debug("sllin: response received ID %d len %d\n",
+			netdev_dbg(sl->dev, "response received ID %d len %d\n",
 				sl->rx_buff[SLLIN_BUFF_ID], sl->rx_cnt - SLLIN_BUFF_DATA - 1);
 
 			if (sllin_rx_validate(sl) == -1) {
-				pr_debug("sllin: RX validation failed.\n");
+				netdev_dbg(sl->dev, "RX validation failed.\n");
 				sllin_report_error(sl, LIN_ERR_CHECKSUM);
 			} else {
 				/* Send CAN non-RTR frame with data */
-				pr_debug("sllin: sending NON-RTR CAN frame with LIN payload.");
+				netdev_dbg(sl->dev, "sending NON-RTR CAN frame with LIN payload.");
 				sll_bump(sl); /* send packet to the network layer */
 			}
 
@@ -1148,7 +1150,7 @@ slstate_response_sent:
 
 			hrtimer_cancel(&sl->rx_timer);
 			sll_bump(sl); /* send packet to the network layer */
-			pr_debug("sllin: response sent ID %d len %d\n",
+			netdev_dbg(sl->dev, "response sent ID %d len %d\n",
 				sl->rx_buff[SLLIN_BUFF_ID], sl->rx_cnt - SLLIN_BUFF_DATA - 1);
 
 			sl->id_to_send = false;
@@ -1158,7 +1160,7 @@ slstate_response_sent:
 	}
 
 	hrtimer_cancel(&sl->rx_timer);
-	pr_debug("sllin: sllin_kwthread stopped.\n");
+	netdev_dbg(sl->dev, "sllin_kwthread stopped.\n");
 
 	return 0;
 }
@@ -1253,6 +1255,7 @@ static int sllin_open(struct tty_struct *tty)
 {
 	struct sllin *sl;
 	int err;
+
 	pr_debug("sllin: %s() invoked\n", __func__);
 
 	if (!capable(CAP_NET_ADMIN))
@@ -1290,12 +1293,10 @@ static int sllin_open(struct tty_struct *tty)
 	if (!test_bit(SLF_INUSE, &sl->flags)) {
 		/* Perform the low-level SLLIN initialization. */
 		sl->lin_master = master;
-#ifdef DEBUG
 		if (master)
 			pr_debug("sllin: Configured as MASTER\n");
 		else
 			pr_debug("sllin: Configured as SLAVE\n");
-#endif
 
 		sllin_reset_buffs(sl);
 
@@ -1492,8 +1493,7 @@ static void __exit sllin_exit(void)
 
 		sl = netdev_priv(dev);
 		if (sl->tty) {
-			pr_err("%s: tty discipline still running\n",
-			       dev->name);
+			netdev_dbg(sl->dev, "tty discipline still running\n");
 			/* Intentionally leak the control block. */
 			dev->destructor = NULL;
 		}
-- 
1.8.3.2

