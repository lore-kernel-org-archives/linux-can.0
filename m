From: zhongjie.shi@intel.com
Subject: [PATCH] Add TX limit for SocketCAN.
Date: Fri,  1 Sep 2017 10:14:39 +0800
Message-ID: <1504232079-2583-1-git-send-email-zhongjie.shi@intel.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:28398 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750762AbdIACND (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 31 Aug 2017 22:13:03 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: socketcan@hartkopp.net, mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: zhongjie.shi@intel.com

From: "Shi, Zhongjie" <zhongjie.shi@intel.com>

This will be used to prevent malicious or unintentional
flooding of messages via SocketCAN.

Change-Id: I6c2e122e12a594d9ad7dc4bdeebe15a1929eb893
Tracked-On: https://jira01.devtools.intel.com/browse/OAM-48496
Signed-off-by: Shi, Zhongjie <zhongjie.shi@intel.com>
---
 net/can/Kconfig  | 13 +++++++++++++
 net/can/af_can.c | 15 +++++++++++++++
 net/can/af_can.h |  5 +++++
 net/can/proc.c   | 13 +++++++++++++
 4 files changed, 46 insertions(+)

diff --git a/net/can/Kconfig b/net/can/Kconfig
index a15c0e0..aeba3d0 100644
--- a/net/can/Kconfig
+++ b/net/can/Kconfig
@@ -51,6 +51,19 @@ config CAN_GW
 	  They can be modified with AND/OR/XOR/SET operations as configured
 	  by the netlink configuration interface known e.g. from iptables.
 
+config CAN_TX_ATTEMPT_RATE_LIMIT
+	int "Tx attempt rate limit"
+	default "5"
+	---help---
+	  This TX attempt rate limit can be used to prevent flood of messages
+	  from user space. It's TX "attempt" rate here instead of the "actual"
+	  TX rate because we do the statistics for the TX attempt no matter if
+	  the message TX is actually sent successful or not. The current
+	  default value is "5" which means 5 messages per second that is proper
+	  for an in-vehicle infotainment (IVI) system. For the use cases other
+	  than IVI, this can be set to the value corresponding to the specific
+	  requirement.
+
 source "drivers/net/can/Kconfig"
 
 endif
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 88edac0..4981c15 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -83,6 +83,9 @@ static DEFINE_MUTEX(proto_tab_lock);
 
 static atomic_t skbcounter = ATOMIC_INIT(0);
 
+#define SOCK_TX_ATTEMPT_RATE_LIMIT    (CONFIG_CAN_TX_ATTEMPT_RATE_LIMIT)
+
+
 /*
  * af_can socket functions
  */
@@ -212,6 +215,7 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
  *  -EPERM when trying to send on a non-CAN interface
  *  -EMSGSIZE CAN frame size is bigger than CAN interface MTU
  *  -EINVAL when the skb->data does not contain a valid CAN frame
+ *  -EDQUOT when current tx rate reach its limit
  */
 int can_send(struct sk_buff *skb, int loop)
 {
@@ -251,6 +255,17 @@ int can_send(struct sk_buff *skb, int loop)
 		goto inval_skb;
 	}
 
+	/* update statistics */
+	can_stats->tx_attempt_frames++;
+	can_stats->tx_frames_attempt_delta++;
+
+	/* throttle if needed */
+	if (can_stats->current_tx_attempt_rate > SOCK_TX_ATTEMPT_RATE_LIMIT) {
+		printk_ratelimited(KERN_WARNING "can: inhibit tx due to "
+			"attempt rate: %lu\n", can_stats->current_tx_attempt_rate);
+		return EDQUOT;
+	}
+
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
 
 	skb_reset_mac_header(skb);
diff --git a/net/can/af_can.h b/net/can/af_can.h
index d0ef45b..6f50e82 100644
--- a/net/can/af_can.h
+++ b/net/can/af_can.h
@@ -83,22 +83,27 @@ struct s_stats {
 
 	unsigned long rx_frames;
 	unsigned long tx_frames;
+	unsigned long tx_attempt_frames;
 	unsigned long matches;
 
 	unsigned long total_rx_rate;
 	unsigned long total_tx_rate;
+	unsigned long total_tx_attempt_rate;
 	unsigned long total_rx_match_ratio;
 
 	unsigned long current_rx_rate;
 	unsigned long current_tx_rate;
+	unsigned long current_tx_attempt_rate;
 	unsigned long current_rx_match_ratio;
 
 	unsigned long max_rx_rate;
 	unsigned long max_tx_rate;
+	unsigned long max_tx_attempt_rate;
 	unsigned long max_rx_match_ratio;
 
 	unsigned long rx_frames_delta;
 	unsigned long tx_frames_delta;
+	unsigned long tx_frames_attempt_delta;
 	unsigned long matches_delta;
 };
 
diff --git a/net/can/proc.c b/net/can/proc.c
index 83045f0..96eb745 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -148,6 +148,8 @@ void can_stat_update(unsigned long data)
 
 	can_stats->total_tx_rate = calc_rate(can_stats->jiffies_init, j,
 					    can_stats->tx_frames);
+	can_stats->total_tx_attempt_rate = calc_rate(can_stats->jiffies_init, j,
+					    can_stats->tx_attempt_frames);
 	can_stats->total_rx_rate = calc_rate(can_stats->jiffies_init, j,
 					    can_stats->rx_frames);
 
@@ -158,12 +160,16 @@ void can_stat_update(unsigned long data)
 			can_stats->rx_frames_delta;
 
 	can_stats->current_tx_rate = calc_rate(0, HZ, can_stats->tx_frames_delta);
+	can_stats->current_tx_attempt_rate = calc_rate(0, HZ, can_stats->tx_frames_attempt_delta);
 	can_stats->current_rx_rate = calc_rate(0, HZ, can_stats->rx_frames_delta);
 
 	/* check / update maximum values */
 	if (can_stats->max_tx_rate < can_stats->current_tx_rate)
 		can_stats->max_tx_rate = can_stats->current_tx_rate;
 
+	if (can_stats->max_tx_attempt_rate < can_stats->current_tx_attempt_rate)
+		can_stats->max_tx_attempt_rate = can_stats->current_tx_attempt_rate;
+
 	if (can_stats->max_rx_rate < can_stats->current_rx_rate)
 		can_stats->max_rx_rate = can_stats->current_rx_rate;
 
@@ -172,6 +178,7 @@ void can_stat_update(unsigned long data)
 
 	/* clear values for 'current rate' calculation */
 	can_stats->tx_frames_delta = 0;
+	can_stats->tx_frames_attempt_delta = 0;
 	can_stats->rx_frames_delta = 0;
 	can_stats->matches_delta   = 0;
 
@@ -227,6 +234,8 @@ static int can_stats_proc_show(struct seq_file *m, void *v)
 
 		seq_printf(m, " %8ld frames/s total tx rate (TXR)\n",
 				can_stats->total_tx_rate);
+		seq_printf(m, " %8ld frames/s total attempt tx rate (ATXR)\n",
+				can_stats->total_tx_attempt_rate);
 		seq_printf(m, " %8ld frames/s total rx rate (RXR)\n",
 				can_stats->total_rx_rate);
 
@@ -237,6 +246,8 @@ static int can_stats_proc_show(struct seq_file *m, void *v)
 
 		seq_printf(m, " %8ld frames/s current tx rate (CTXR)\n",
 				can_stats->current_tx_rate);
+		seq_printf(m, " %8ld frames/s current attempt tx rate (CATXR)\n",
+				can_stats->current_tx_attempt_rate);
 		seq_printf(m, " %8ld frames/s current rx rate (CRXR)\n",
 				can_stats->current_rx_rate);
 
@@ -247,6 +258,8 @@ static int can_stats_proc_show(struct seq_file *m, void *v)
 
 		seq_printf(m, " %8ld frames/s max tx rate (MTXR)\n",
 				can_stats->max_tx_rate);
+		seq_printf(m, " %8ld frames/s max attempt tx rate (MATXR)\n",
+				can_stats->max_tx_attempt_rate);
 		seq_printf(m, " %8ld frames/s max rx rate (MRXR)\n",
 				can_stats->max_rx_rate);
 
-- 
2.7.4

