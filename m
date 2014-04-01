From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 2/3] can: add hash based access to single EFF frame filters
Date: Tue,  1 Apr 2014 20:57:11 +0200
Message-ID: <1396378632-5413-3-git-send-email-socketcan@hartkopp.net>
References: <1396378632-5413-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:13244 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbaDAS5j (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Apr 2014 14:57:39 -0400
In-Reply-To: <1396378632-5413-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

In contrast to the direct access to the single SFF frame filters (which are
indexed by the SFF CAN ID itself) the single EFF frame filters are arranged
in a single linked hlist. To reduce the hlist traversal in the case of many
filter subscriptions a hash based access is introduced for single EFF filters.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/af_can.c | 31 ++++++++++++++++++++++++++-----
 net/can/af_can.h |  5 ++++-
 net/can/proc.c   | 48 +++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 75 insertions(+), 9 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index a27f8aa..56fd1e2 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -338,6 +338,29 @@ static struct dev_rcv_lists *find_dev_rcv_lists(struct net_device *dev)
 }
 
 /**
+ * effhash - hash function for 29 bit CAN identifier reduction
+ * @can_id: 29 bit CAN identifier
+ *
+ * Description:
+ *  To reduce the linear traversal in one linked list of _single_ EFF CAN
+ *  frame subscriptions the 29 bit identifier is mapped to 10 bits.
+ *  (see CAN_EFF_RCV_HASH_BITS definition)
+ *
+ * Return:
+ *  Hash value from 0x000 - 0x3FF ( enforced by CAN_EFF_RCV_HASH_BITS mask )
+ */
+static unsigned int effhash(canid_t can_id)
+{
+	unsigned int hash;
+
+	hash = can_id>>(2*CAN_EFF_RCV_HASH_BITS);
+	hash ^= can_id>>CAN_EFF_RCV_HASH_BITS;
+	hash ^= can_id;
+
+	return hash & ((1<<CAN_EFF_RCV_HASH_BITS) - 1);
+}
+
+/**
  * find_rcv_list - determine optimal filterlist inside device filter struct
  * @can_id: pointer to CAN identifier of a given can_filter
  * @mask: pointer to CAN mask of a given can_filter
@@ -400,10 +423,8 @@ static struct hlist_head *find_rcv_list(canid_t *can_id, canid_t *mask,
 	    !(*can_id & CAN_RTR_FLAG)) {
 
 		if (*can_id & CAN_EFF_FLAG) {
-			if (*mask == (CAN_EFF_MASK | CAN_EFF_RTR_FLAGS)) {
-				/* RFC: a future use-case for hash-tables? */
-				return &d->rx[RX_EFF];
-			}
+			if (*mask == (CAN_EFF_MASK | CAN_EFF_RTR_FLAGS))
+				return &d->rx_eff[effhash(*can_id)];
 		} else {
 			if (*mask == (CAN_SFF_MASK | CAN_EFF_RTR_FLAGS))
 				return &d->rx_sff[*can_id];
@@ -632,7 +653,7 @@ static int can_rcv_filter(struct dev_rcv_lists *d, struct sk_buff *skb)
 		return matches;
 
 	if (can_id & CAN_EFF_FLAG) {
-		hlist_for_each_entry_rcu(r, &d->rx[RX_EFF], list) {
+		hlist_for_each_entry_rcu(r, &d->rx_eff[effhash(can_id)], list) {
 			if (r->can_id == can_id) {
 				deliver(skb, r);
 				matches++;
diff --git a/net/can/af_can.h b/net/can/af_can.h
index 989e695..5796bc9 100644
--- a/net/can/af_can.h
+++ b/net/can/af_can.h
@@ -60,13 +60,16 @@ struct receiver {
 };
 
 #define CAN_SFF_RCV_ARRAY_SZ (1<<CAN_SFF_ID_BITS)
+#define CAN_EFF_RCV_HASH_BITS 10
+#define CAN_EFF_RCV_ARRAY_SZ (1<<CAN_EFF_RCV_HASH_BITS)
 
-enum { RX_ERR, RX_ALL, RX_FIL, RX_INV, RX_EFF, RX_MAX };
+enum { RX_ERR, RX_ALL, RX_FIL, RX_INV, RX_MAX };
 
 /* per device receive filters linked at dev->ml_priv */
 struct dev_rcv_lists {
 	struct hlist_head rx[RX_MAX];
 	struct hlist_head rx_sff[CAN_SFF_RCV_ARRAY_SZ];
+	struct hlist_head rx_eff[CAN_EFF_RCV_ARRAY_SZ];
 	int remove_on_zero_entries;
 	int entries;
 };
diff --git a/net/can/proc.c b/net/can/proc.c
index 1f8e1e6..e26499d 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -80,7 +80,6 @@ static const char rx_list_name[][8] = {
 	[RX_ALL] = "rx_all",
 	[RX_FIL] = "rx_fil",
 	[RX_INV] = "rx_inv",
-	[RX_EFF] = "rx_eff",
 };
 
 /*
@@ -456,6 +455,49 @@ static const struct file_operations can_rcvlist_sff_proc_fops = {
 	.release	= single_release,
 };
 
+
+static int can_rcvlist_eff_proc_show(struct seq_file *m, void *v)
+{
+	struct net_device *dev;
+	struct dev_rcv_lists *d;
+
+	/* RX_EFF */
+	seq_puts(m, "\nreceive list 'rx_eff':\n");
+
+	rcu_read_lock();
+
+	/* eff receive list for 'all' CAN devices (dev == NULL) */
+	d = &can_rx_alldev_list;
+	can_rcvlist_proc_show_array(m, NULL, d->rx_eff, CAN_EFF_RCV_ARRAY_SZ);
+
+	/* eff receive list for registered CAN devices */
+	for_each_netdev_rcu(&init_net, dev) {
+		if (dev->type == ARPHRD_CAN && dev->ml_priv) {
+			d = dev->ml_priv;
+			can_rcvlist_proc_show_array(m, dev, d->rx_eff,
+						    CAN_EFF_RCV_ARRAY_SZ);
+		}
+	}
+
+	rcu_read_unlock();
+
+	seq_putc(m, '\n');
+	return 0;
+}
+
+static int can_rcvlist_eff_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, can_rcvlist_eff_proc_show, NULL);
+}
+
+static const struct file_operations can_rcvlist_eff_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= can_rcvlist_eff_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 /*
  * proc utility functions
  */
@@ -495,8 +537,8 @@ void can_init_proc(void)
 					   &can_rcvlist_proc_fops, (void *)RX_FIL);
 	pde_rcvlist_inv = proc_create_data(CAN_PROC_RCVLIST_INV, 0644, can_dir,
 					   &can_rcvlist_proc_fops, (void *)RX_INV);
-	pde_rcvlist_eff = proc_create_data(CAN_PROC_RCVLIST_EFF, 0644, can_dir,
-					   &can_rcvlist_proc_fops, (void *)RX_EFF);
+	pde_rcvlist_eff = proc_create(CAN_PROC_RCVLIST_EFF, 0644, can_dir,
+				      &can_rcvlist_eff_proc_fops);
 	pde_rcvlist_sff = proc_create(CAN_PROC_RCVLIST_SFF, 0644, can_dir,
 				      &can_rcvlist_sff_proc_fops);
 }
-- 
1.9.1

