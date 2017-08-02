From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 05/14] can: proc: give variable holding the CAN per device receive lists a sensible name
Date: Wed,  2 Aug 2017 19:44:25 +0200
Message-ID: <20170802174434.4689-6-mkl@pengutronix.de>
References: <20170802174434.4689-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:34795 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752265AbdHBRol (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Aug 2017 13:44:41 -0400
In-Reply-To: <20170802174434.4689-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

This patch gives the variables holding the CAN per device receive filter lists
a better name by renaming them from "d" to "dev_rcv_lists".

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/proc.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/net/can/proc.c b/net/can/proc.c
index b06ea3823b07..966dd53f8fa4 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -338,11 +338,11 @@ static const struct file_operations can_version_proc_fops = {
 
 static inline void can_rcvlist_proc_show_one(struct seq_file *m, int idx,
 					     struct net_device *dev,
-					     struct can_dev_rcv_lists *d)
+					     struct can_dev_rcv_lists *dev_rcv_lists)
 {
-	if (!hlist_empty(&d->rx[idx])) {
+	if (!hlist_empty(&dev_rcv_lists->rx[idx])) {
 		can_print_recv_banner(m);
-		can_print_rcvlist(m, &d->rx[idx], dev);
+		can_print_rcvlist(m, &dev_rcv_lists->rx[idx], dev);
 	} else
 		seq_printf(m, "  (%s: no entry)\n", DNAME(dev));
 
@@ -353,7 +353,7 @@ static int can_rcvlist_proc_show(struct seq_file *m, void *v)
 	/* double cast to prevent GCC warning */
 	int idx = (int)(long)PDE_DATA(m->file->f_inode);
 	struct net_device *dev;
-	struct can_dev_rcv_lists *d;
+	struct can_dev_rcv_lists *dev_rcv_lists;
 	struct net *net = m->private;
 
 	seq_printf(m, "\nreceive list '%s':\n", rx_list_name[idx]);
@@ -361,8 +361,8 @@ static int can_rcvlist_proc_show(struct seq_file *m, void *v)
 	rcu_read_lock();
 
 	/* receive list for 'all' CAN devices (dev == NULL) */
-	d = net->can.can_rx_alldev_list;
-	can_rcvlist_proc_show_one(m, idx, NULL, d);
+	dev_rcv_lists = net->can.can_rx_alldev_list;
+	can_rcvlist_proc_show_one(m, idx, NULL, dev_rcv_lists);
 
 	/* receive list for registered CAN devices */
 	for_each_netdev_rcu(net, dev) {
@@ -417,7 +417,7 @@ static inline void can_rcvlist_proc_show_array(struct seq_file *m,
 static int can_rcvlist_sff_proc_show(struct seq_file *m, void *v)
 {
 	struct net_device *dev;
-	struct can_dev_rcv_lists *d;
+	struct can_dev_rcv_lists *dev_rcv_lists;
 	struct net *net = m->private;
 
 	/* RX_SFF */
@@ -426,15 +426,16 @@ static int can_rcvlist_sff_proc_show(struct seq_file *m, void *v)
 	rcu_read_lock();
 
 	/* sff receive list for 'all' CAN devices (dev == NULL) */
-	d = net->can.can_rx_alldev_list;
-	can_rcvlist_proc_show_array(m, NULL, d->rx_sff, ARRAY_SIZE(d->rx_sff));
+	dev_rcv_lists = net->can.can_rx_alldev_list;
+	can_rcvlist_proc_show_array(m, NULL, dev_rcv_lists->rx_sff,
+				    ARRAY_SIZE(dev_rcv_lists->rx_sff));
 
 	/* sff receive list for registered CAN devices */
 	for_each_netdev_rcu(net, dev) {
 		if (dev->type == ARPHRD_CAN && dev->ml_priv) {
-			d = dev->ml_priv;
-			can_rcvlist_proc_show_array(m, dev, d->rx_sff,
-						    ARRAY_SIZE(d->rx_sff));
+			dev_rcv_lists = dev->ml_priv;
+			can_rcvlist_proc_show_array(m, dev, dev_rcv_lists->rx_sff,
+						    ARRAY_SIZE(dev_rcv_lists->rx_sff));
 		}
 	}
 
@@ -461,7 +462,7 @@ static const struct file_operations can_rcvlist_sff_proc_fops = {
 static int can_rcvlist_eff_proc_show(struct seq_file *m, void *v)
 {
 	struct net_device *dev;
-	struct can_dev_rcv_lists *d;
+	struct can_dev_rcv_lists *dev_rcv_lists;
 	struct net *net = m->private;
 
 	/* RX_EFF */
@@ -470,15 +471,16 @@ static int can_rcvlist_eff_proc_show(struct seq_file *m, void *v)
 	rcu_read_lock();
 
 	/* eff receive list for 'all' CAN devices (dev == NULL) */
-	d = net->can.can_rx_alldev_list;
-	can_rcvlist_proc_show_array(m, NULL, d->rx_eff, ARRAY_SIZE(d->rx_eff));
+	dev_rcv_lists = net->can.can_rx_alldev_list;
+	can_rcvlist_proc_show_array(m, NULL, dev_rcv_lists->rx_eff,
+				    ARRAY_SIZE(dev_rcv_lists->rx_eff));
 
 	/* eff receive list for registered CAN devices */
 	for_each_netdev_rcu(net, dev) {
 		if (dev->type == ARPHRD_CAN && dev->ml_priv) {
-			d = dev->ml_priv;
-			can_rcvlist_proc_show_array(m, dev, d->rx_eff,
-						    ARRAY_SIZE(d->rx_eff));
+			dev_rcv_lists = dev->ml_priv;
+			can_rcvlist_proc_show_array(m, dev, dev_rcv_lists->rx_eff,
+						    ARRAY_SIZE(dev_rcv_lists->rx_eff));
 		}
 	}
 
-- 
2.13.2

