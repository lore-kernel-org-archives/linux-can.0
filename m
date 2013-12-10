From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 4/6] sllin: reorder functions
Date: Tue, 10 Dec 2013 18:16:15 +0100
Message-ID: <1386695777-18463-5-git-send-email-alexander.stein@systec-electronic.com>
References: <1386695777-18463-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:55786 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752892Ab3LJRXT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Dec 2013 12:23:19 -0500
In-Reply-To: <1386695777-18463-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: =?UTF-8?q?Rostislav=20Lisov=C3=BD?= <lisovy@gmail.com>, Michal Sojka <sojkam1@fel.cvut.cz>, Oliver Hartkopp <oliver.hartkopp@volkswagen.de>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

Needed for further commits

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 sllin/sllin.c | 288 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 144 insertions(+), 144 deletions(-)

diff --git a/sllin/sllin.c b/sllin/sllin.c
index b97219e..e8aca08 100644
--- a/sllin/sllin.c
+++ b/sllin/sllin.c
@@ -494,111 +494,6 @@ static void sllin_master_receive_buf(struct tty_struct *tty,
 }
 
 
-static void sllin_slave_receive_buf(struct tty_struct *tty,
-			      const unsigned char *cp, char *fp, int count)
-{
-	struct sllin *sl = (struct sllin *) tty->disc_data;
-	int lin_id;
-	struct sllin_conf_entry *sce;
-
-
-	/* Read the characters out of the buffer */
-	while (count--) {
-		if (fp && *fp++) {
-			netdev_dbg(sl->dev, "sllin_slave_receive_buf char 0x%02x ignored "
-				"due marker 0x%02x, flags 0x%lx\n",
-				*cp, *(fp-1), sl->flags);
-
-			/* Received Break */
-			sl->rx_cnt = 0;
-			sl->rx_expect = SLLIN_BUFF_ID + 1;
-			sl->rx_len_unknown = false; /* We do know exact length of the header */
-			sl->header_received = false;
-		}
-
-		if (sl->rx_cnt < SLLIN_BUFF_LEN) {
-			netdev_dbg(sl->dev, "LIN_RX[%d]: 0x%02x\n", sl->rx_cnt, *cp);
-
-			/* We did not receive break (0x00) character */
-			if ((sl->rx_cnt == SLLIN_BUFF_BREAK) && (*cp == 0x55)) {
-				sl->rx_buff[sl->rx_cnt++] = 0x00;
-			}
-
-			if (sl->rx_cnt == SLLIN_BUFF_SYNC) {
-				/* 'Duplicated' break character -- ignore */
-				if (*cp == 0x00) {
-					cp++;
-					continue;
-				}
-
-				/* Wrong sync character */
-				if (*cp != 0x55)
-					break;
-			}
-
-			sl->rx_buff[sl->rx_cnt++] = *cp++;
-		}
-
-		/* Header received */
-		if ((sl->header_received == false) && (sl->rx_cnt >= (SLLIN_BUFF_ID + 1))) {
-			unsigned long flags;
-
-			lin_id = sl->rx_buff[SLLIN_BUFF_ID] & LIN_ID_MASK;
-			sce = &sl->linfr_cache[lin_id];
-
-			spin_lock_irqsave(&sl->linfr_lock, flags);
-
-			/* Is the length of data set in frame cache? */
-			if (sce->frame_fl & LIN_CACHE_RESPONSE) {
-				sl->rx_expect += sce->dlc + 1; /* + checksum */
-				sl->rx_len_unknown = false;
-			} else {
-				sl->rx_expect += SLLIN_DATA_MAX + 1; /* + checksum */
-				sl->rx_len_unknown = true;
-			}
-			spin_unlock_irqrestore(&sl->linfr_lock, flags);
-
-			sl->header_received = true;
-
-			sll_send_rtr(sl);
-			continue;
-		}
-
-		/* Response received */
-		if ((sl->header_received == true) &&
-			((sl->rx_cnt >= sl->rx_expect) ||
-			((sl->rx_len_unknown == true) && (count == 0)))) {
-
-			sll_bump(sl);
-			netdev_dbg(sl->dev, "Received LIN header & LIN response. "
-					"rx_cnt = %u, rx_expect = %u\n", sl->rx_cnt,
-					sl->rx_expect);
-
-			/* Prepare for reception of new header */
-			sl->rx_cnt = 0;
-			sl->rx_expect = SLLIN_BUFF_ID + 1;
-			sl->rx_len_unknown = false; /* We do know exact length of the header */
-			sl->header_received = false;
-		}
-	}
-}
-
-static void sllin_receive_buf(struct tty_struct *tty,
-			      const unsigned char *cp, char *fp, int count)
-{
-	struct sllin *sl = (struct sllin *) tty->disc_data;
-	netdev_dbg(sl->dev, "sllin_receive_buf invoked, count = %u\n", count);
-
-	if (!sl || sl->magic != SLLIN_MAGIC || !netif_running(sl->dev))
-		return;
-
-	if (sl->lin_master)
-		sllin_master_receive_buf(tty, cp, fp, count);
-	else
-		sllin_slave_receive_buf(tty, cp, fp, count);
-
-}
-
 /*****************************************
  *  sllin message helper routines
  *****************************************/
@@ -736,6 +631,150 @@ static void sllin_reset_buffs(struct sllin *sl)
 	sl->data_to_send = false;
 }
 
+/**
+ * sllin_rx_validate() -- Validate received frame, i,e. check checksum
+ *
+ * @sl:
+ */
+static int sllin_rx_validate(struct sllin *sl)
+{
+	unsigned long flags;
+	int actual_id;
+	int ext_chcks_fl;
+	int lin_dlc;
+	unsigned char rec_chcksm = sl->rx_buff[sl->rx_cnt - 1];
+	struct sllin_conf_entry *sce;
+
+	actual_id = sl->rx_buff[SLLIN_BUFF_ID] & LIN_ID_MASK;
+	sce = &sl->linfr_cache[actual_id];
+
+	spin_lock_irqsave(&sl->linfr_lock, flags);
+	lin_dlc = sce->dlc;
+	ext_chcks_fl = sce->frame_fl & LIN_CHECKSUM_EXTENDED;
+	spin_unlock_irqrestore(&sl->linfr_lock, flags);
+
+	if (sllin_checksum(sl->rx_buff, sl->rx_cnt - 1, ext_chcks_fl) !=
+		rec_chcksm) {
+
+		/* Type of checksum is configured for particular frame */
+		if (lin_dlc > 0) {
+			return -1;
+		} else {
+			if (sllin_checksum(sl->rx_buff,	sl->rx_cnt - 1,
+				!ext_chcks_fl) != rec_chcksm) {
+				return -1;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static void sllin_slave_receive_buf(struct tty_struct *tty,
+			      const unsigned char *cp, char *fp, int count)
+{
+	struct sllin *sl = (struct sllin *) tty->disc_data;
+	int lin_id;
+	struct sllin_conf_entry *sce;
+
+
+	/* Read the characters out of the buffer */
+	while (count--) {
+		if (fp && *fp++) {
+			netdev_dbg(sl->dev, "sllin_slave_receive_buf char 0x%02x ignored "
+				"due marker 0x%02x, flags 0x%lx\n",
+				*cp, *(fp-1), sl->flags);
+
+			/* Received Break */
+			sl->rx_cnt = 0;
+			sl->rx_expect = SLLIN_BUFF_ID + 1;
+			sl->rx_len_unknown = false; /* We do know exact length of the header */
+			sl->header_received = false;
+		}
+
+		if (sl->rx_cnt < SLLIN_BUFF_LEN) {
+			netdev_dbg(sl->dev, "LIN_RX[%d]: 0x%02x\n", sl->rx_cnt, *cp);
+
+			/* We did not receive break (0x00) character */
+			if ((sl->rx_cnt == SLLIN_BUFF_BREAK) && (*cp == 0x55)) {
+				sl->rx_buff[sl->rx_cnt++] = 0x00;
+			}
+
+			if (sl->rx_cnt == SLLIN_BUFF_SYNC) {
+				/* 'Duplicated' break character -- ignore */
+				if (*cp == 0x00) {
+					cp++;
+					continue;
+				}
+
+				/* Wrong sync character */
+				if (*cp != 0x55)
+					break;
+			}
+
+			sl->rx_buff[sl->rx_cnt++] = *cp++;
+		}
+
+		/* Header received */
+		if ((sl->header_received == false) && (sl->rx_cnt >= (SLLIN_BUFF_ID + 1))) {
+			unsigned long flags;
+
+			lin_id = sl->rx_buff[SLLIN_BUFF_ID] & LIN_ID_MASK;
+			sce = &sl->linfr_cache[lin_id];
+
+			spin_lock_irqsave(&sl->linfr_lock, flags);
+
+			/* Is the length of data set in frame cache? */
+			if (sce->frame_fl & LIN_CACHE_RESPONSE) {
+				sl->rx_expect += sce->dlc + 1; /* + checksum */
+				sl->rx_len_unknown = false;
+			} else {
+				sl->rx_expect += SLLIN_DATA_MAX + 1; /* + checksum */
+				sl->rx_len_unknown = true;
+			}
+			spin_unlock_irqrestore(&sl->linfr_lock, flags);
+
+			sl->header_received = true;
+
+			sll_send_rtr(sl);
+			continue;
+		}
+
+		/* Response received */
+		if ((sl->header_received == true) &&
+			((sl->rx_cnt >= sl->rx_expect) ||
+			((sl->rx_len_unknown == true) && (count == 0)))) {
+
+			sll_bump(sl);
+			netdev_dbg(sl->dev, "Received LIN header & LIN response. "
+					"rx_cnt = %u, rx_expect = %u\n", sl->rx_cnt,
+					sl->rx_expect);
+
+			/* Prepare for reception of new header */
+			sl->rx_cnt = 0;
+			sl->rx_expect = SLLIN_BUFF_ID + 1;
+			sl->rx_len_unknown = false; /* We do know exact length of the header */
+			sl->header_received = false;
+		}
+	}
+}
+
+static void sllin_receive_buf(struct tty_struct *tty,
+			      const unsigned char *cp, char *fp, int count)
+{
+	struct sllin *sl = (struct sllin *) tty->disc_data;
+	netdev_dbg(sl->dev, "sllin_receive_buf invoked, count = %u\n", count);
+
+	if (!sl || sl->magic != SLLIN_MAGIC || !netif_running(sl->dev))
+		return;
+
+	if (sl->lin_master)
+		sllin_master_receive_buf(tty, cp, fp, count);
+	else
+		sllin_slave_receive_buf(tty, cp, fp, count);
+
+}
+
 static int sllin_send_tx_buff(struct sllin *sl)
 {
 	struct tty_struct *tty = sl->tty;
@@ -873,45 +912,6 @@ static enum hrtimer_restart sllin_rx_timeout_handler(struct hrtimer *hrtimer)
 	return HRTIMER_NORESTART;
 }
 
-/**
- * sllin_rx_validate() -- Validate received frame, i,e. check checksum
- *
- * @sl:
- */
-static int sllin_rx_validate(struct sllin *sl)
-{
-	unsigned long flags;
-	int actual_id;
-	int ext_chcks_fl;
-	int lin_dlc;
-	unsigned char rec_chcksm = sl->rx_buff[sl->rx_cnt - 1];
-	struct sllin_conf_entry *sce;
-
-	actual_id = sl->rx_buff[SLLIN_BUFF_ID] & LIN_ID_MASK;
-	sce = &sl->linfr_cache[actual_id];
-
-	spin_lock_irqsave(&sl->linfr_lock, flags);
-	lin_dlc = sce->dlc;
-	ext_chcks_fl = sce->frame_fl & LIN_CHECKSUM_EXTENDED;
-	spin_unlock_irqrestore(&sl->linfr_lock, flags);
-
-	if (sllin_checksum(sl->rx_buff, sl->rx_cnt - 1, ext_chcks_fl) !=
-		rec_chcksm) {
-
-		/* Type of checksum is configured for particular frame */
-		if (lin_dlc > 0) {
-			return -1;
-		} else {
-			if (sllin_checksum(sl->rx_buff,	sl->rx_cnt - 1,
-				!ext_chcks_fl) != rec_chcksm) {
-				return -1;
-			}
-		}
-	}
-
-	return 0;
-}
-
 /*****************************************
  *  sllin_kwthread - kernel worker thread
  *****************************************/
-- 
1.8.3.2

