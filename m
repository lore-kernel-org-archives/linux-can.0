From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH 4/4] j1939: remove proc support
Date: Wed, 24 Jan 2018 12:06:59 +0100
Message-ID: <20180124110659.438-4-o.rempel@pengutronix.de>
References: <20180124110659.438-1-o.rempel@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34155 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933080AbeAXLHK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 24 Jan 2018 06:07:10 -0500
In-Reply-To: <20180124110659.438-1-o.rempel@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org, mkl@pengutronix.de
Cc: Oleksij Rempel <o.rempel@pengutronix.de>

to make upstreaming more simple, remove procfs support.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 Documentation/networking/j1939.txt |  82 +----------------------
 net/can/j1939/main.c               | 101 ----------------------------
 net/can/j1939/transport.c          | 131 +------------------------------------
 3 files changed, 5 insertions(+), 309 deletions(-)

diff --git a/Documentation/networking/j1939.txt b/Documentation/networking/j1939.txt
index 08f7b035d821..d0e74df97baa 100644
--- a/Documentation/networking/j1939.txt
+++ b/Documentation/networking/j1939.txt
@@ -36,18 +36,7 @@ This file contains
     5.3 SO_J1939_RECV_OWN
     5.4 SO_J1939_SEND_PRIO
 
-  6 can-j1939 procfs interface
-    6.1 /proc/net/can-j1939/ecu
-    6.2 /proc/net/can-j1939/filter
-    6.3 /proc/net/can-j1939/sock
-    6.4 /proc/net/can-j1939/transport
-
-  7 can-j1939 SYSCTL
-    7.1 /proc/sys/net/can-j1939/transport_max_payload_in_bytes
-    7.2 /proc/sys/net/can-j1939/transport_cts_nr_of_frames
-    7.3 /proc/sys/net/can-j1939/transport_tx_retry_ms
-
-  8 Credits
+  6 Credits
 
 ============================================================================
 
@@ -471,74 +460,7 @@ This file contains
   for you.
 
 
-6. /proc/net/can-j1939 Interface.
---------------------------------
-
-  Files giving you a view on the in-kernel operation of J1939 are located at:
-  /proc/net/j1939.
-
-6.1 /proc/net/can-j1939/ecu
-
-  This file gives an overview of the known ECU's to the kernel.
-  - iface : network interface they operate on.
-  - SA : current address.
-  - name : 64bit NAME
-  - flags : 'L' = local, 'R' = remote
-
-6.2 /proc/net/can-j1939/filter
-
-6.3 /proc/net/can-j1939/sock
-
-  This file gives a list of all j1939 sockets currently open.
-  - iface : network interface
-  - flags :
-    'b' : bound
-    'c' : connected
-    'P' : PROMISC
-    'o' : RECV_OWN
-    'd' : RECV_DEST
-    'p' : RECV_PRIO
-  - local: [NAME],SA
-  - remote: [NAME]/MASK,DA
-  - pgn : PGN
-  - prio : priority
-  - pending : # packets pending (see MSG_SYN on 4.2.1)
-
-6.4 /proc/net/can-j1939/transport
-
-  This file shows a list of pending transport sessions
-  - iface
-  - src : XX (addr) or XXXXXXXXXXXXXXXX (name)
-  - dst : XX or XXXXXXXXXXXXXXXX or '-' (broadcast)
-  - pgn :
-  - done/total : current # transferred bytes / total
-
-
-7. /proc/sys/net/can-j1939 - SYSCTL
---------------------------------
-
-  Via these sysctl files, some parameters of the j1939 module can be tuned.
-
-7.1 /proc/sys/net/can-j1939/transport_max_payload_in_bytes [int]
-
-  Is the maximum packet size to accept on both transmit & receive side.
-  Bigger packets will be rejected (local sender), aborted (local receiver)
-  or ignored (broadcasts & remote recievers in PROMISC).
-
-7.2 /proc/sys/net/can-j1939/transport_cts_nr_frames [int]
-
-  Controls the number of packets to allow between consecutive CTS frames
-  (default 255).
-  This number is communicated within the CTS frame from receiver to transmitter.
-  Setting this has effect on received transport sessions only.
-
-7.3 /proc/sys/net/can-j1939/transport_tx_retry_ms [int]
-
-  Controls how many time to wait before retrying to send an individual TP
-  flow or data packet after transmission failure (default 20).
-
-
-8. Credits
+6. Credits
 --------------------------------
 
   Kurt Van Dijck (j1939 core, transport protocol, API)
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 36ceedb2e403..3dc0d1e5a2c4 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -30,9 +30,6 @@ MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("EIA Electronics (Kurt Van Dijck & Pieter Beyens)");
 MODULE_ALIAS("can-proto-" __stringify(CAN_J1939));
 
-static const char j1939_procname[] = "can-j1939";
-struct proc_dir_entry *j1939_procdir;
-
 /* LOWLEVEL CAN interface */
 
 /* CAN_HDR: #bytes before can_frame data part */
@@ -351,84 +348,6 @@ static struct notifier_block j1939_netdev_notifier = {
 	.notifier_call = j1939_netdev_notify,
 };
 
-/* proc access to the addr+name database */
-static int j1939_proc_show_addr(struct seq_file *sqf, void *v)
-{
-	struct net_device *netdev;
-	struct j1939_priv *priv;
-	int j;
-
-	seq_puts(sqf, "iface\tsa\t#users\n");
-	rcu_read_lock();
-	for_each_netdev_rcu(&init_net, netdev) {
-		priv = j1939_priv_get(netdev);
-		if (!priv)
-			continue;
-		read_lock_bh(&priv->lock);
-		for (j = 0; j < 0xfe; ++j) {
-			if (!priv->ents[j].nusers)
-				continue;
-			seq_printf(sqf, "%s\t%02x\t%i\n",
-				   netdev->name, j, priv->ents[j].nusers);
-		}
-		read_unlock_bh(&priv->lock);
-		j1939_priv_put(priv);
-	}
-	rcu_read_unlock();
-	return 0;
-}
-
-static int j1939_proc_show_name(struct seq_file *sqf, void *v)
-{
-	struct net_device *netdev;
-	struct j1939_priv *priv;
-	struct j1939_ecu *ecu;
-
-	seq_puts(sqf, "iface\tname\tsa\t#users\n");
-	rcu_read_lock();
-	for_each_netdev_rcu(&init_net, netdev) {
-		priv = j1939_priv_get(netdev);
-		if (!priv)
-			continue;
-		read_lock_bh(&priv->lock);
-		list_for_each_entry(ecu, &priv->ecus, list)
-			seq_printf(sqf, "%s\t%016llx\t%02x%s\t%i\n",
-				   netdev->name, ecu->name, ecu->sa,
-				   (priv->ents[ecu->sa].ecu == ecu) ? "" : "?",
-				   ecu->nusers);
-		read_unlock_bh(&priv->lock);
-		j1939_priv_put(priv);
-	}
-	rcu_read_unlock();
-	return 0;
-}
-
-static int j1939_proc_open_addr(struct inode *inode, struct file *file)
-{
-	return single_open(file, j1939_proc_show_addr, NULL);
-}
-
-static int j1939_proc_open_name(struct inode *inode, struct file *file)
-{
-	return single_open(file, j1939_proc_show_name, NULL);
-}
-
-static const struct file_operations j1939_proc_ops_addr = {
-	.owner		= THIS_MODULE,
-	.open		= j1939_proc_open_addr,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static const struct file_operations j1939_proc_ops_name = {
-	.owner		= THIS_MODULE,
-	.open		= j1939_proc_open_name,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 /* MODULE interface */
 static __init int j1939_module_init(void)
 {
@@ -436,11 +355,6 @@ static __init int j1939_module_init(void)
 
 	pr_info("can: SAE J1939\n");
 
-	/* create /proc/net/can directory */
-	j1939_procdir = proc_mkdir(j1939_procname, init_net.proc_net);
-	if (!j1939_procdir)
-		return -EINVAL;
-
 	ret = register_netdevice_notifier(&j1939_netdev_notifier);
 	if (ret)
 		goto fail_notifier;
@@ -454,38 +368,23 @@ static __init int j1939_module_init(void)
 	if (ret < 0)
 		goto fail_tp;
 
-	if (!proc_create("addr", 0444, j1939_procdir, &j1939_proc_ops_addr))
-		goto fail_addr;
-	if (!proc_create("name", 0444, j1939_procdir, &j1939_proc_ops_name))
-		goto fail_name;
 	return 0;
 
- fail_name:
-	remove_proc_entry("addr", j1939_procdir);
- fail_addr:
-	j1939tp_module_exit();
  fail_tp:
 	can_proto_unregister(&j1939_can_proto);
  fail_sk:
 	unregister_netdevice_notifier(&j1939_netdev_notifier);
  fail_notifier:
-	proc_remove(j1939_procdir);
-	j1939_procdir = NULL;
 	return ret;
 }
 
 static __exit void j1939_module_exit(void)
 {
-	remove_proc_entry("name", j1939_procdir);
-	remove_proc_entry("addr", j1939_procdir);
 	j1939tp_module_exit();
 
 	can_proto_unregister(&j1939_can_proto);
 
 	unregister_netdevice_notifier(&j1939_netdev_notifier);
-
-	proc_remove(j1939_procdir);
-	j1939_procdir = NULL;
 }
 
 module_init(j1939_module_init);
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 6001901c8db3..a0a5c8a1298b 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -51,21 +51,6 @@
 
 static unsigned int block = 255;
 static unsigned int max_packet_size = MAX_ETP_PACKET_SIZE;
-static unsigned int retry_ms = 20;
-static unsigned int packet_delay;
-static unsigned int padding = 1;
-
-/* the limit values for sysctl */
-static int block_min = 1;
-static int block_max = 255;
-static int max_size_min = 8;
-static int max_size_max = MAX_ETP_PACKET_SIZE;
-static int retry_min = 1;
-static int retry_max = 1250;
-static int packet_delay_min = 0;
-static int packet_delay_max = 1250;
-static int padding_min = 0;
-static int padding_max = 1;
 
 struct session {
 	struct list_head list;
@@ -382,7 +367,7 @@ static int j1939tp_tx_dat(struct sk_buff *related, bool extd,
 
 	skdat = skb_put(skb, len);
 	memcpy(skdat, dat, len);
-	if (padding && len < 8)
+	if (len < 8)
 		memset(skb_put(skb, 8 - len), 0xff, 8 - len);
 	return j1939_send(skb);
 }
@@ -1065,8 +1050,7 @@ static int j1939tp_txnext(struct session *session)
 			session->last_txcmd = 0xff;
 			++pkt_done;
 			++session->pkt.tx;
-			pdelay = j1939cb_is_broadcast(session->cb) ?  50 :
-				packet_delay;
+			pdelay = j1939cb_is_broadcast(session->cb) ?  50 : 0;
 			if ((session->pkt.tx < session->pkt.total) && pdelay) {
 				j1939tp_schedule_txtimer(session, pdelay);
 				break;
@@ -1093,7 +1077,7 @@ static void j1939tp_txtask(unsigned long val)
 	j1939_session_get(session);
 	ret = j1939tp_txnext(session);
 	if (ret < 0)
-		j1939tp_schedule_txtimer(session, retry_ms ?: 20);
+		j1939tp_schedule_txtimer(session, 20);
 	j1939_session_put(session);
 }
 
@@ -1349,116 +1333,9 @@ int j1939tp_rmdev_notifier(struct net_device *netdev)
 	return NOTIFY_DONE;
 }
 
-/* PROC */
-static int j1939tp_proc_show_session(struct seq_file *sqf,
-				     struct session *session)
-{
-	seq_printf(sqf, "%i", session->skb_iif);
-	if (session->cb->addr.src_name)
-		seq_printf(sqf, "\t%016llx", session->cb->addr.src_name);
-	else
-		seq_printf(sqf, "\t%02x", session->cb->addr.sa);
-	if (session->cb->addr.dst_name)
-		seq_printf(sqf, "\t%016llx", session->cb->addr.dst_name);
-	else if (j1939_address_is_unicast(session->cb->addr.da))
-		seq_printf(sqf, "\t%02x", session->cb->addr.da);
-	else
-		seq_puts(sqf, "\t-");
-	seq_printf(sqf, "\t%05x\t%u/%u\n", session->cb->addr.pgn,
-		   session->pkt.done * 7, session->skb->len);
-	return 0;
-}
-
-static int j1939tp_proc_show(struct seq_file *sqf, void *v)
-{
-	struct session *session;
-
-	seq_puts(sqf, "iface\tsrc\tdst\tpgn\tdone/total\n");
-	j1939_sessionlist_lock();
-	list_for_each_entry(session, &tp_sessionq, list)
-		j1939tp_proc_show_session(sqf, session);
-	list_for_each_entry(session, &tp_extsessionq, list)
-		j1939tp_proc_show_session(sqf, session);
-	j1939_sessionlist_unlock();
-	return 0;
-}
-
-static int j1939tp_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, j1939tp_proc_show, NULL);
-}
-
-static const struct file_operations j1939tp_proc_ops = {
-	.owner = THIS_MODULE,
-	.open = j1939tp_proc_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static struct ctl_table canj1939_sysctl_table[] = {
-	{
-		.procname	= "transport_burst_count",
-		.data		= &block,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &block_min,
-		.extra2		= &block_max,
-	},
-	{
-		.procname	= "transport_max_size",
-		.data		= &max_packet_size,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &max_size_min,
-		.extra2		= &max_size_max,
-	},
-	{
-		.procname	= "transport_retry_time",
-		.data		= &retry_ms,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &retry_min,
-		.extra2		= &retry_max,
-	},
-	{
-		.procname	= "transport_packet_delay",
-		.data		= &packet_delay,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &packet_delay_min,
-		.extra2		= &packet_delay_max,
-	},
-	{
-		.procname	= "transport_padding",
-		.data		= &padding,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &padding_min,
-		.extra2		= &padding_max,
-	},
-	{},
-};
-
-static struct ctl_table_header *sysctl_hdr;
-
 /* module init */
 int __init j1939tp_module_init(void)
 {
-	if (!proc_create("transport", 0444, j1939_procdir, &j1939tp_proc_ops))
-		return -ENOMEM;
-
-	sysctl_hdr = register_net_sysctl(&init_net, "net/can-j1939",
-					 canj1939_sysctl_table);
-	if (!sysctl_hdr) {
-		remove_proc_entry("transport", j1939_procdir);
-		return -ENOMEM;
-	}
 	return 0;
 }
 
@@ -1468,8 +1345,6 @@ void j1939tp_module_exit(void)
 
 	wake_up_all(&tp_wait);
 
-	unregister_net_sysctl_table(sysctl_hdr);
-	remove_proc_entry("transport", j1939_procdir);
 	j1939_sessionlist_lock();
 	list_for_each_entry_safe(session, saved, &tp_extsessionq, list) {
 		list_del_init(&session->list);
-- 
2.15.1

