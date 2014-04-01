From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 1/3] can: proc: make array printing function indenpendent from sff frames
Date: Tue,  1 Apr 2014 20:57:10 +0200
Message-ID: <1396378632-5413-2-git-send-email-socketcan@hartkopp.net>
References: <1396378632-5413-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:32002 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbaDAS5i (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Apr 2014 14:57:38 -0400
In-Reply-To: <1396378632-5413-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

The can_rcvlist_sff_proc_show_one() function which prints the array of filters
for the single SFF CAN identifiers is prepared to be used by a second caller.
Therefore it is also renamed to properly describe its future functionality.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/af_can.h |  4 +++-
 net/can/proc.c   | 28 ++++++++++++++++------------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/net/can/af_can.h b/net/can/af_can.h
index 6de58b4..989e695 100644
--- a/net/can/af_can.h
+++ b/net/can/af_can.h
@@ -59,12 +59,14 @@ struct receiver {
 	char *ident;
 };
 
+#define CAN_SFF_RCV_ARRAY_SZ (1<<CAN_SFF_ID_BITS)
+
 enum { RX_ERR, RX_ALL, RX_FIL, RX_INV, RX_EFF, RX_MAX };
 
 /* per device receive filters linked at dev->ml_priv */
 struct dev_rcv_lists {
 	struct hlist_head rx[RX_MAX];
-	struct hlist_head rx_sff[0x800];
+	struct hlist_head rx_sff[CAN_SFF_RCV_ARRAY_SZ];
 	int remove_on_zero_entries;
 	int entries;
 };
diff --git a/net/can/proc.c b/net/can/proc.c
index b543470..1f8e1e6 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -389,25 +389,26 @@ static const struct file_operations can_rcvlist_proc_fops = {
 	.release	= single_release,
 };
 
-static inline void can_rcvlist_sff_proc_show_one(struct seq_file *m,
-						 struct net_device *dev,
-						 struct dev_rcv_lists *d)
+static inline void can_rcvlist_proc_show_array(struct seq_file *m,
+					       struct net_device *dev,
+					       struct hlist_head *rcv_array,
+					       unsigned int rcv_array_sz)
 {
-	int i;
+	unsigned int i;
 	int all_empty = 1;
 
 	/* check whether at least one list is non-empty */
-	for (i = 0; i < 0x800; i++)
-		if (!hlist_empty(&d->rx_sff[i])) {
+	for (i = 0; i < rcv_array_sz; i++)
+		if (!hlist_empty(&rcv_array[i])) {
 			all_empty = 0;
 			break;
 		}
 
 	if (!all_empty) {
 		can_print_recv_banner(m);
-		for (i = 0; i < 0x800; i++) {
-			if (!hlist_empty(&d->rx_sff[i]))
-				can_print_rcvlist(m, &d->rx_sff[i], dev);
+		for (i = 0; i < rcv_array_sz; i++) {
+			if (!hlist_empty(&rcv_array[i]))
+				can_print_rcvlist(m, &rcv_array[i], dev);
 		}
 	} else
 		seq_printf(m, "  (%s: no entry)\n", DNAME(dev));
@@ -425,12 +426,15 @@ static int can_rcvlist_sff_proc_show(struct seq_file *m, void *v)
 
 	/* sff receive list for 'all' CAN devices (dev == NULL) */
 	d = &can_rx_alldev_list;
-	can_rcvlist_sff_proc_show_one(m, NULL, d);
+	can_rcvlist_proc_show_array(m, NULL, d->rx_sff, CAN_SFF_RCV_ARRAY_SZ);
 
 	/* sff receive list for registered CAN devices */
 	for_each_netdev_rcu(&init_net, dev) {
-		if (dev->type == ARPHRD_CAN && dev->ml_priv)
-			can_rcvlist_sff_proc_show_one(m, dev, dev->ml_priv);
+		if (dev->type == ARPHRD_CAN && dev->ml_priv) {
+			d = dev->ml_priv;
+			can_rcvlist_proc_show_array(m, dev, d->rx_sff,
+						    CAN_SFF_RCV_ARRAY_SZ);
+		}
 	}
 
 	rcu_read_unlock();
-- 
1.9.1

