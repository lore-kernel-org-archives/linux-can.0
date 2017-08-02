From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 02/14] can: give structs holding the CAN statistics a sensible name
Date: Wed,  2 Aug 2017 19:44:22 +0200
Message-ID: <20170802174434.4689-3-mkl@pengutronix.de>
References: <20170802174434.4689-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:43223 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752232AbdHBRoj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Aug 2017 13:44:39 -0400
In-Reply-To: <20170802174434.4689-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

This patch renames both "struct s_stats" and "struct s_pstats" by
replacing the leading "s" by "can" to better reflect their meaning and
improve code readability.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/net/netns/can.h |  8 ++++----
 net/can/af_can.c        | 18 +++++++++---------
 net/can/af_can.h        |  4 ++--
 net/can/proc.c          | 16 ++++++++--------
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/net/netns/can.h b/include/net/netns/can.h
index b106e6ae2e5b..5ee0f88ebbac 100644
--- a/include/net/netns/can.h
+++ b/include/net/netns/can.h
@@ -8,8 +8,8 @@
 #include <linux/spinlock.h>
 
 struct dev_rcv_lists;
-struct s_stats;
-struct s_pstats;
+struct can_stats;
+struct can_pstats;
 
 struct netns_can {
 #if IS_ENABLED(CONFIG_PROC_FS)
@@ -30,8 +30,8 @@ struct netns_can {
 	struct dev_rcv_lists *can_rx_alldev_list;
 	spinlock_t can_rcvlists_lock;
 	struct timer_list can_stattimer;/* timer for statistics update */
-	struct s_stats *can_stats;	/* packet statistics */
-	struct s_pstats *can_pstats;	/* receive list statistics */
+	struct can_stats *can_stats; /* packet statistics */
+	struct can_pstats *can_pstats; /* receive list statistics */
 
 	/* CAN GW per-net gateway jobs */
 	struct hlist_head cgw_list;
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 0896e2facd50..bbd8a9bcf28d 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -217,7 +217,7 @@ int can_send(struct sk_buff *skb, int loop)
 {
 	struct sk_buff *newskb = NULL;
 	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
-	struct s_stats *can_stats = dev_net(skb->dev)->can.can_stats;
+	struct can_stats *can_stats = dev_net(skb->dev)->can.can_stats;
 	int err = -EINVAL;
 
 	if (skb->len == CAN_MTU) {
@@ -321,8 +321,8 @@ EXPORT_SYMBOL(can_send);
  * af_can rx path
  */
 
-static struct dev_rcv_lists *find_dev_rcv_lists(struct net *net,
-						struct net_device *dev)
+static struct dev_rcv_lists *can_dev_rcv_lists_find(struct net *net,
+						    struct net_device *dev)
 {
 	if (!dev)
 		return net->can.can_rx_alldev_list;
@@ -465,7 +465,7 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 	struct receiver *r;
 	struct hlist_head *rl;
 	struct dev_rcv_lists *d;
-	struct s_pstats *can_pstats = net->can.can_pstats;
+	struct can_pstats *can_pstats = net->can.can_pstats;
 	int err = 0;
 
 	/* insert new receiver  (dev,canid,mask) -> (func,data) */
@@ -482,7 +482,7 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 
 	spin_lock(&net->can.can_rcvlists_lock);
 
-	d = find_dev_rcv_lists(net, dev);
+	d = can_dev_rcv_lists_find(net, dev);
 	if (d) {
 		rl = find_rcv_list(&can_id, &mask, d);
 
@@ -541,7 +541,7 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 {
 	struct receiver *r = NULL;
 	struct hlist_head *rl;
-	struct s_pstats *can_pstats = net->can.can_pstats;
+	struct can_pstats *can_pstats = net->can.can_pstats;
 	struct dev_rcv_lists *d;
 
 	if (dev && dev->type != ARPHRD_CAN)
@@ -552,7 +552,7 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 
 	spin_lock(&net->can.can_rcvlists_lock);
 
-	d = find_dev_rcv_lists(net, dev);
+	d = can_dev_rcv_lists_find(net, dev);
 	if (!d) {
 		pr_err("BUG: receive list not found for "
 		       "dev %s, id %03X, mask %03X\n",
@@ -684,7 +684,7 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 {
 	struct dev_rcv_lists *d;
 	struct net *net = dev_net(dev);
-	struct s_stats *can_stats = net->can.can_stats;
+	struct can_stats *can_stats = net->can.can_stats;
 	int matches;
 
 	/* update statistics */
@@ -701,7 +701,7 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 	matches = can_rcv_filter(net->can.can_rx_alldev_list, skb);
 
 	/* find receive list for this device */
-	d = find_dev_rcv_lists(net, dev);
+	d = can_dev_rcv_lists_find(net, dev);
 	if (d)
 		matches += can_rcv_filter(d, skb);
 
diff --git a/net/can/af_can.h b/net/can/af_can.h
index d0ef45bb2a72..4e2cb14c1af7 100644
--- a/net/can/af_can.h
+++ b/net/can/af_can.h
@@ -78,7 +78,7 @@ struct dev_rcv_lists {
 /* statistic structures */
 
 /* can be reset e.g. by can_init_stats() */
-struct s_stats {
+struct can_stats {
 	unsigned long jiffies_init;
 
 	unsigned long rx_frames;
@@ -103,7 +103,7 @@ struct s_stats {
 };
 
 /* persistent statistics */
-struct s_pstats {
+struct can_pstats {
 	unsigned long stats_reset;
 	unsigned long user_reset;
 	unsigned long rcv_entries;
diff --git a/net/can/proc.c b/net/can/proc.c
index 83045f00c63c..559fca8035aa 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -77,14 +77,14 @@ static const char rx_list_name[][8] = {
 
 static void can_init_stats(struct net *net)
 {
-	struct s_stats *can_stats = net->can.can_stats;
-	struct s_pstats *can_pstats = net->can.can_pstats;
+	struct can_stats *can_stats = net->can.can_stats;
+	struct can_pstats *can_pstats = net->can.can_pstats;
 	/*
 	 * This memset function is called from a timer context (when
 	 * can_stattimer is active which is the default) OR in a process
 	 * context (reading the proc_fs when can_stattimer is disabled).
 	 */
-	memset(can_stats, 0, sizeof(struct s_stats));
+	memset(can_stats, 0, sizeof(struct can_stats));
 	can_stats->jiffies_init = jiffies;
 
 	can_pstats->stats_reset++;
@@ -118,7 +118,7 @@ static unsigned long calc_rate(unsigned long oldjif, unsigned long newjif,
 void can_stat_update(unsigned long data)
 {
 	struct net *net = (struct net *)data;
-	struct s_stats *can_stats = net->can.can_stats;
+	struct can_stats *can_stats = net->can.can_stats;
 	unsigned long j = jiffies; /* snapshot */
 
 	/* restart counting in timer context on user request */
@@ -211,8 +211,8 @@ static void can_print_recv_banner(struct seq_file *m)
 static int can_stats_proc_show(struct seq_file *m, void *v)
 {
 	struct net *net = m->private;
-	struct s_stats *can_stats = net->can.can_stats;
-	struct s_pstats *can_pstats = net->can.can_pstats;
+	struct can_stats *can_stats = net->can.can_stats;
+	struct can_pstats *can_pstats = net->can.can_pstats;
 
 	seq_putc(m, '\n');
 	seq_printf(m, " %8ld transmitted frames (TXF)\n", can_stats->tx_frames);
@@ -286,8 +286,8 @@ static const struct file_operations can_stats_proc_fops = {
 static int can_reset_stats_proc_show(struct seq_file *m, void *v)
 {
 	struct net *net = m->private;
-	struct s_pstats *can_pstats = net->can.can_pstats;
-	struct s_stats *can_stats = net->can.can_stats;
+	struct can_pstats *can_pstats = net->can.can_pstats;
+	struct can_stats *can_stats = net->can.can_stats;
 
 	user_reset = 1;
 
-- 
2.13.2

