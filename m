From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 6/6] sllin: Add first support for LIN slave task on slave node
Date: Tue, 10 Dec 2013 18:16:17 +0100
Message-ID: <1386695777-18463-7-git-send-email-alexander.stein@systec-electronic.com>
References: <1386695777-18463-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:60307 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755010Ab3LJR2U (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Dec 2013 12:28:20 -0500
In-Reply-To: <1386695777-18463-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: =?UTF-8?q?Rostislav=20Lisov=C3=BD?= <lisovy@gmail.com>, Michal Sojka <sojkam1@fel.cvut.cz>, Oliver Hartkopp <oliver.hartkopp@volkswagen.de>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 sllin/sllin.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 3 deletions(-)

diff --git a/sllin/sllin.c b/sllin/sllin.c
index 36f23a5..3e020b1 100644
--- a/sllin/sllin.c
+++ b/sllin/sllin.c
@@ -113,6 +113,7 @@ enum slstate {
 	SLSTATE_RESPONSE_WAIT_BUS, /* Wait for response from LIN bus
 				only (CAN frames from network stack
 				are not processed in this moment) */
+	SLSTATE_ID_RECEIVED,
 	SLSTATE_RESPONSE_SENT,
 };
 
@@ -755,10 +756,13 @@ static void sllin_slave_receive_buf(struct tty_struct *tty,
 
 			spin_lock_irqsave(&sl->linfr_lock, flags);
 
+			sl->lin_state = SLSTATE_ID_RECEIVED;
 			/* Is the length of data set in frame cache? */
 			if (sce->frame_fl & LIN_CACHE_RESPONSE) {
 				sl->rx_expect += sce->dlc + 1; /* + checksum */
 				sl->rx_len_unknown = false;
+				set_bit(SLF_MSGEVENT, &sl->flags);
+				wake_up(&sl->kwt_wq);
 			} else {
 				sl->rx_expect += SLLIN_DATA_MAX + 1; /* + checksum */
 				sl->rx_len_unknown = true;
@@ -784,6 +788,8 @@ static void sllin_slave_receive_buf(struct tty_struct *tty,
 					sl->rx_expect);
 			sllin_slave_finish_rx_msg(sl);
 
+			set_bit(SLF_RXEVENT, &sl->flags);
+			wake_up(&sl->kwt_wq);
 		}
 	}
 }
@@ -956,7 +962,9 @@ static int sllin_kwthread(void *ptr)
 	struct tty_struct *tty = sl->tty;
 	struct sched_param schparam = { .sched_priority = 40 };
 	int tx_bytes = 0; /* Used for Network statistics */
-
+	unsigned long flags;
+	int lin_id;
+	struct sllin_conf_entry *sce;
 
 	netdev_dbg(sl->dev, "sllin_kwthread started.\n");
 	sched_setscheduler(current, SCHED_FIFO, &schparam);
@@ -984,7 +992,8 @@ static int sllin_kwthread(void *ptr)
 			test_bit(SLF_TMOUTEVENT, &sl->flags) ||
 			test_bit(SLF_ERROR, &sl->flags) ||
 			(((sl->lin_state == SLSTATE_IDLE) ||
-				(sl->lin_state == SLSTATE_RESPONSE_WAIT))
+				(sl->lin_state == SLSTATE_RESPONSE_WAIT) ||
+				(sl->lin_state == SLSTATE_ID_RECEIVED))
 				&& test_bit(SLF_MSGEVENT, &sl->flags)));
 
 		if (test_and_clear_bit(SLF_RXEVENT, &sl->flags)) {
@@ -1028,7 +1037,6 @@ static int sllin_kwthread(void *ptr)
 
 			/* SFF RTR CAN frame -> LIN header */
 			if (cf->can_id & CAN_RTR_FLAG) {
-				unsigned long flags;
 				struct sllin_conf_entry *sce;
 
 				netdev_dbg(sl->dev, "%s: RTR SFF CAN frame, ID = %x\n",
@@ -1177,6 +1185,56 @@ slstate_response_wait:
 			sl->lin_state = SLSTATE_IDLE;
 			break;
 
+		case SLSTATE_ID_RECEIVED:
+			lin_id = sl->rx_buff[SLLIN_BUFF_ID] & LIN_ID_MASK;
+			sce = &sl->linfr_cache[lin_id];
+			spin_lock_irqsave(&sl->linfr_lock, flags);
+
+			if ((sce->frame_fl & LIN_CACHE_RESPONSE)
+					&& (sce->dlc > 0)
+					&& (test_bit(SLF_MSGEVENT, &sl->flags))) {
+				int mode;
+
+				netdev_dbg(sl->dev, "Sending LIN response from linfr_cache\n");
+
+				lin_data = sce->data;
+				lin_dlc = sce->dlc;
+				if (lin_dlc > SLLIN_DATA_MAX)
+					lin_dlc = SLLIN_DATA_MAX;
+				memcpy(lin_data_buff, lin_data, lin_dlc);
+				lin_data = lin_data_buff;
+				tx_bytes = lin_dlc;
+
+				mode = SLLIN_STPMSG_RESPONLY;
+				if (sl->rx_buff[SLLIN_BUFF_ID] & LIN_CHECKSUM_EXTENDED)
+					mode |= SLLIN_STPMSG_CHCKSUM_ENH;
+
+				if (sllin_setup_msg(sl, mode, lin_id & LIN_ID_MASK,
+					lin_data, lin_dlc) != -1) {
+
+					sl->rx_expect = sl->tx_lim;
+					sl->data_to_send = true;
+					sl->dev->stats.tx_packets++;
+					sl->dev->stats.tx_bytes += tx_bytes;
+					sl->resp_len_known = true;
+
+					if (!sl->lin_master) {
+						sl->tx_cnt = SLLIN_BUFF_DATA;
+					}
+					sllin_send_tx_buff(sl);
+				}
+
+				clear_bit(SLF_MSGEVENT, &sl->flags);
+				kfree_skb(sl->tx_req_skb);
+				netif_wake_queue(sl->dev);
+				hrtimer_start(&sl->rx_timer,
+					ktime_add(ktime_get(), sl->rx_timer_timeout),
+					HRTIMER_MODE_ABS);
+			}
+			spin_unlock_irqrestore(&sl->linfr_lock, flags);
+			sl->lin_state = SLSTATE_IDLE;
+			break;
+
 		case SLSTATE_RESPONSE_SENT:
 slstate_response_sent:
 			if (sl->rx_cnt < sl->tx_lim)
-- 
1.8.3.2

