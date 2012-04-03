From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH RFC] can: add hash table for single EFF id filter list
Date: Tue, 03 Apr 2012 21:56:30 +0200
Message-ID: <4F7B55EE.7080404@hartkopp.net>
References: <1318506157-10329-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:28786 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753415Ab2DCT4c (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 3 Apr 2012 15:56:32 -0400
Received: from [192.168.178.40] (p5B0B091E.dip0.t-ipconnect.de [91.11.9.30])
	by post.strato.de (mrclete mo11) (RZmta 28.5 DYNA|AUTH)
	with ESMTPA id 00295eo33IDhiB for <linux-can@vger.kernel.org>;
	Tue, 3 Apr 2012 21:56:30 +0200 (MEST)
In-Reply-To: <1318506157-10329-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

To reduce the linear traversal in one linked list of _single_ EFF CAN
frame subscriptions the 29 bit identifier is hashed to 10 bits.
The hash function maps the three sections of the 29 bit can_id via XOR which
produces uniformly distributed entries in a 10 bit array of hlists.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

---

Hi all,

this idea was in my mind for a long time now. The question is:

Are single EFF id subscriptions used widely in real-world use cases? 

Of course this hash table approach adds a list of 1024 pointers to the struct
which is attached to each CAN netdevice. But when single EFF id subscriptions
are used, the filter is performed with heavily reduced cpu load at runtime.

Any thoughts and/or feedback?

Tnx,
Oliver


diff --git a/net/can/af_can.c b/net/can/af_can.c
index 0ce2ad0..df32073 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -316,6 +316,28 @@ static struct dev_rcv_lists *find_dev_rcv_lists(struct net_device *dev)
 }
 
 /**
+ * effhash - hash function for 29 bit CAN identifier reduction
+ * @can_id: 29 bit CAN identifier
+ *
+ * Description:
+ *  To reduce the linear traversal in one linked list of _single_ EFF CAN
+ *  frame subscriptions the 29 bit identifier is mapped to 10 bits.
+ *
+ * Return:
+ *  Hash value from 0x000 - 0x3FF
+ */
+static unsigned int effhash(canid_t can_id)
+{
+	unsigned int hash;
+
+	hash = (can_id>>20) & 0x3FF;
+	hash ^= (can_id>>10) & 0x3FF;
+	hash ^= can_id & 0x3FF;
+
+	return hash;
+}
+
+/**
  * find_rcv_list - determine optimal filterlist inside device filter struct
  * @can_id: pointer to CAN identifier of a given can_filter
  * @mask: pointer to CAN mask of a given can_filter
@@ -378,10 +400,8 @@ static struct hlist_head *find_rcv_list(canid_t *can_id, canid_t *mask,
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
@@ -615,7 +635,7 @@ static int can_rcv_filter(struct dev_rcv_lists *d, struct sk_buff *skb)
 		return matches;
 
 	if (can_id & CAN_EFF_FLAG) {
-		hlist_for_each_entry_rcu(r, n, &d->rx[RX_EFF], list) {
+		hlist_for_each_entry_rcu(r, n, &d->rx_eff[effhash(can_id)], list) {
 			if (r->can_id == can_id) {
 				deliver(skb, r);
 				matches++;
diff --git a/net/can/af_can.h b/net/can/af_can.h
index fd882db..3631399 100644
--- a/net/can/af_can.h
+++ b/net/can/af_can.h
@@ -59,12 +59,13 @@ struct receiver {
 	char *ident;
 };
 
-enum { RX_ERR, RX_ALL, RX_FIL, RX_INV, RX_EFF, RX_MAX };
+enum { RX_ERR, RX_ALL, RX_FIL, RX_INV, RX_MAX };
 
 /* per device receive filters linked at dev->ml_priv */
 struct dev_rcv_lists {
 	struct hlist_head rx[RX_MAX];
 	struct hlist_head rx_sff[0x800];
+	struct hlist_head rx_eff[0x400];
 	int remove_on_zero_entries;
 	int entries;
 };
diff --git a/net/can/proc.c b/net/can/proc.c
index ba873c3..419d349 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -80,7 +80,6 @@ static const char rx_list_name[][8] = {
 	[RX_ALL] = "rx_all",
 	[RX_FIL] = "rx_fil",
 	[RX_INV] = "rx_inv",
-	[RX_EFF] = "rx_eff",
 };
 
 /* receive filters subscribed for 'all' CAN devices */
@@ -456,6 +455,69 @@ static const struct file_operations can_rcvlist_sff_proc_fops = {
 	.release	= single_release,
 };
 
+static inline void can_rcvlist_eff_proc_show_one(struct seq_file *m,
+						 struct net_device *dev,
+						 struct dev_rcv_lists *d)
+{
+	int i;
+	int all_empty = 1;
+
+	/* check wether at least one list is non-empty */
+	for (i = 0; i < 0x400; i++)
+		if (!hlist_empty(&d->rx_eff[i])) {
+			all_empty = 0;
+			break;
+		}
+
+	if (!all_empty) {
+		can_print_recv_banner(m);
+		for (i = 0; i < 0x400; i++) {
+			if (!hlist_empty(&d->rx_eff[i]))
+				can_print_rcvlist(m, &d->rx_eff[i], dev);
+		}
+	} else
+		seq_printf(m, "  (%s: no entry)\n", DNAME(dev));
+}
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
+	can_rcvlist_eff_proc_show_one(m, NULL, d);
+
+	/* eff receive list for registered CAN devices */
+	for_each_netdev_rcu(&init_net, dev) {
+		if (dev->type == ARPHRD_CAN && dev->ml_priv)
+			can_rcvlist_eff_proc_show_one(m, dev, dev->ml_priv);
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
@@ -495,8 +557,8 @@ void can_init_proc(void)
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


