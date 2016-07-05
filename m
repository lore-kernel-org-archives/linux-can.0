From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: add missing initialization of CAN statistics
Date: Tue,  5 Jul 2016 19:29:27 +0200
Message-ID: <1467739767-7696-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:26281 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbcGERaC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 5 Jul 2016 13:30:02 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

The total rx/tx rate (TXR and RXR) only start working after a statistic reset.
This fix initializes the statistic data structures and the timer init value to
provide proper values directly from the start.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

---

The issue can be fixed by resetting the statistics by hand:
cat /proc/net/can/reset_stats

As nobody discovered the missing values so far there's no need to put this
patch to linux stable tree IMO.
---
 net/can/af_can.c |  1 +
 net/can/af_can.h |  1 +
 net/can/proc.c   | 21 ++++++++++++++-------
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 166d436..df8dcc3 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -911,6 +911,7 @@ static __init int can_init(void)
 	if (!rcv_cache)
 		return -ENOMEM;
 
+	can_init_stats();
 	if (stats_timer) {
 		/* the statistics are updated every second (timer triggered) */
 		setup_timer(&can_stattimer, can_stat_update, 0);
diff --git a/net/can/af_can.h b/net/can/af_can.h
index fca0fe9..8361047 100644
--- a/net/can/af_can.h
+++ b/net/can/af_can.h
@@ -115,6 +115,7 @@ extern struct dev_rcv_lists can_rx_alldev_list;
 /* function prototypes for the CAN networklayer procfs (proc.c) */
 void can_init_proc(void);
 void can_remove_proc(void);
+void can_init_stats(void);
 void can_stat_update(unsigned long data);
 
 /* structures and variables from af_can.c needed in proc.c for reading */
diff --git a/net/can/proc.c b/net/can/proc.c
index 1a19b98..438c196 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -86,7 +86,7 @@ static const char rx_list_name[][8] = {
  * af_can statistics stuff
  */
 
-static void can_init_stats(void)
+static void can_reset_stats(void)
 {
 	/*
 	 * This memset function is called from a timer context (when
@@ -104,6 +104,13 @@ static void can_init_stats(void)
 	}
 }
 
+void can_init_stats(void)
+{
+	memset(&can_pstats, 0, sizeof(can_pstats));
+	memset(&can_stats, 0, sizeof(can_stats));
+	can_stats.jiffies_init = jiffies;
+}
+
 static unsigned long calc_rate(unsigned long oldjif, unsigned long newjif,
 			       unsigned long count)
 {
@@ -130,23 +137,23 @@ void can_stat_update(unsigned long data)
 
 	/* restart counting in timer context on user request */
 	if (user_reset)
-		can_init_stats();
+		can_reset_stats();
 
 	/* restart counting on jiffies overflow */
 	if (j < can_stats.jiffies_init)
-		can_init_stats();
+		can_reset_stats();
 
 	/* prevent overflow in calc_rate() */
 	if (can_stats.rx_frames > (ULONG_MAX / HZ))
-		can_init_stats();
+		can_reset_stats();
 
 	/* prevent overflow in calc_rate() */
 	if (can_stats.tx_frames > (ULONG_MAX / HZ))
-		can_init_stats();
+		can_reset_stats();
 
 	/* matches overflow - very improbable */
 	if (can_stats.matches > (ULONG_MAX / 100))
-		can_init_stats();
+		can_reset_stats();
 
 	/* calc total values */
 	if (can_stats.rx_frames)
@@ -296,7 +303,7 @@ static int can_reset_stats_proc_show(struct seq_file *m, void *v)
 
 	} else {
 		if (can_stats.jiffies_init != jiffies)
-			can_init_stats();
+			can_reset_stats();
 
 		seq_printf(m, "Performed statistic reset #%ld.\n",
 				can_pstats.stats_reset);
-- 
2.8.1

