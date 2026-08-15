Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E3425B091
	for <linux-can@vger.kernel.org>; Sat, 15 Aug 2026 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.160
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786790424; cv=pass; b=X1FdmdWswWWKzbAgFpVx0OXXqImzDdM+BQ7M1rcEzPNm60EHneZLkVXmM4BRnMM/VT7fy4rlLHxFeqDNr4h0J3akURh2AETQrp8HjbTKD+hKltjvHDSq7lUmJYPbtrN60PRe92p3+0MzP4/1Yu/0awlnHRSuYIb94MPmScjmI94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786790424; c=relaxed/simple;
	bh=+MMBYeYfwwpGYpADH3tKmaLyS8wvs65FfT2caBLL8LM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h6/EJTwVtl+pWzc1Al0jueAi8dNBSZL0q/BBTvHgUlY7Cvre9u/W86Fht+cObmNlPIa8VEsQOg0Bx1xP0L5otBa42iynrV2LafiumJYVh9DiMkqqYOwc+9AIETUdzZoJDIVEp5UA4UTnnjapakw/5/AzZBqRZvIg5SBQ7Tu7jCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=QlNvf+XL; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=DbBNV6yy; arc=pass smtp.client-ip=81.169.146.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="QlNvf+XL";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="DbBNV6yy"
ARC-Seal: i=1; a=rsa-sha256; t=1786790051; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JHkykoWPR0nhRMY04noN6gX5VGoic3NnVc0eHpyDj/8b9g9mzapHucvRMlD6jto2yr
    4N4xW0Da81Rw1LsGHRL3Uiyju4r2X2/2P5+ClY1iPKogp2LqC11dcC9O9jLZu1xjEEjN
    JWA3N3lKQa8o2yns2NG2zJMEolfD+vhlapak5q0w7KVGYwKG4hFANFd6jQY1sVyoY4rc
    yZWjLtOEdVgkneGgkBs7beDbG9lTUT6m6ZuxglXg7VQ5dxyYMh1IfUyJtxUBLZJC8F+d
    JXGMX0kJDPeZnfIWbs2UdY6NBfTtnCopYh+oJr8jBYsKa9lA3hFi+44xYGuYmcZ0E7KC
    O+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1786790051;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=X5VCXOPUCV7IDh+/HRzpTxL2E92MhQVM4aZvWmsKhWY=;
    b=FA0ZeLXs+IDlncvabRmEGV3ReTlWcKP/KwgI75Tj4YnudjYxzlr7HkGdg4tGfiEfJN
    dqGkmjFokoGhk4YrObDrG0JenC/njm+4mm473H+//dZMYAS5tLhdXQAUr/Y+5Oc3VNJ/
    7iEBtthUEU3+hGYXhYel+XU1qMrtP4Qtt8NUk0xUvuIrvxKKxSuzaYPian6lG5OJ7mZI
    uUeNzd91u16O9okkTeW4l9iEfUCd6THP9we0jPk7mAq3XeGbcFD94rHfLkdmw5eMv2bf
    E9Q2EeeonPwW3Rz7j0+VTEs7NYeAG0WgibMhRT7q/jS0zablMOGWmxh1aXtfQ0E+E1+S
    GrBA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1786790051;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=X5VCXOPUCV7IDh+/HRzpTxL2E92MhQVM4aZvWmsKhWY=;
    b=QlNvf+XLb0k1izZ5jjc3can2liRiWjcc84nq31wl1sp1gpwdFoSDToCEk2tqrHaWyX
    1gwU294tRRljJIj/duCHgM3L95cEVMxbobKW78n2C15YqKgxHgFKaHKHOve6vImWrMZ+
    LnPeKetRTb8ALeVqdO4Ot/20gq2j+bToCJrPkACME3PnPT7bRPpGsFhtTas7NAUqx2Y2
    GsfBLu9NECl5u+hICR/Yb1gpfivruXmXkkQLU5AnX207HvZCHXW+eCkzgJybOk4LYUKR
    pKlwcttuSlIlOriJDtQw+ho8h6cHUs+FuUv262Xwvm+6jhBY3gCL3xYQ8aF05l8PUIPI
    Go3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1786790051;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=X5VCXOPUCV7IDh+/HRzpTxL2E92MhQVM4aZvWmsKhWY=;
    b=DbBNV6yyVwLmphQ8ysYk/owkyI7wJnjZZfj7yZGiTcEngSUbHL6e1iKjhWCRraYht3
    WZHZ41PHEyEMWDbN4zBg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDvx0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b727FAYB5Oe
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 15 Aug 2026 12:34:11 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [can-next v2] can: proc: remove pointers from CAN specific proc output
Date: Sat, 15 Aug 2026 12:34:00 +0200
Message-ID: <20260815103400.117175-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

The proc content in /proc/net/can/ and /proc/net/can-bcm/ is intended to
check the internal filter lists (af_can, can_raw) and the efficiency and
functionality of can_bcm jobs. While it was ok to leak kernel internal
addresses at time of writing the times have changed and multiple attempts
have been taken to hash or remove such now sensible data.

This patch removes the disclosure of pointers and instead provides the
function names and sock inode numbers when available. As there's no known
tooling around the CAN specific proc output breaking the ABI with this
rework creates no issue.

Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

---
v2: - make use if snprintf() when creating the bcm procname
    - remove CONFIG_KALLSYMS dependency: %ps is changed to solve it
---
 Documentation/networking/can.rst | 14 +++++++-------
 include/linux/can/core.h         |  2 +-
 net/can/af_can.c                 |  6 +++---
 net/can/af_can.h                 |  2 +-
 net/can/bcm.c                    | 16 ++++++++--------
 net/can/gw.c                     |  2 +-
 net/can/isotp.c                  |  4 ++--
 net/can/j1939/main.c             |  2 +-
 net/can/proc.c                   | 16 ++++++----------
 net/can/raw.c                    |  4 ++--
 10 files changed, 32 insertions(+), 36 deletions(-)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index 536ff411da1d..7bdb27a22a0e 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -1040,19 +1040,19 @@ As described in :ref:`socketcan-receive-lists` the SocketCAN core uses several f
 lists to deliver received CAN frames to CAN protocol modules. These
 receive lists, their filters and the count of filter matches can be
 checked in the appropriate receive list. All entries contain the
 device and a protocol module identifier::
 
-    foo@bar:~$ cat /proc/net/can/rcvlist_all
+    foo@bar:~$ cat /proc/net/can/rcvlist_fil
 
-    receive list 'rx_all':
-      (vcan3: no entry)
-      (vcan2: no entry)
-      (vcan1: no entry)
-      device   can_id   can_mask  function  userdata   matches  ident
-       vcan0     000    00000000  f88e6370  f6c6f400         0  raw
+    receive list 'rx_fil':
       (any: no entry)
+      device   can_id   can_mask   matches     sock_inode     function
+       vcan0  80000123  c00007ff         0  000000000000f862  raw_rcv [can_raw]
+      (vcan1: no entry)
+      (vcan2: no entry)
+      (vcan3: no entry)
 
 In this example an application requests any CAN traffic from vcan0::
 
     rcvlist_all - list for unfiltered entries (no filter operations)
     rcvlist_eff - list for single extended frame (EFF) entries
diff --git a/include/linux/can/core.h b/include/linux/can/core.h
index 3287232e3cad..c7ad1d36b657 100644
--- a/include/linux/can/core.h
+++ b/include/linux/can/core.h
@@ -48,11 +48,11 @@ extern int  can_proto_register(const struct can_proto *cp);
 extern void can_proto_unregister(const struct can_proto *cp);
 
 int can_rx_register(struct net *net, struct net_device *dev,
 		    canid_t can_id, canid_t mask,
 		    void (*func)(struct sk_buff *, void *),
-		    void *data, char *ident, struct sock *sk);
+		    void *data, u64 ino, struct sock *sk);
 
 extern void can_rx_unregister(struct net *net, struct net_device *dev,
 			      canid_t can_id, canid_t mask,
 			      void (*func)(struct sk_buff *, void *),
 			      void *data);
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 7bc86b176b4d..be0661679ef8 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -416,11 +416,11 @@ static struct hlist_head *can_rcv_list_find(canid_t *can_id, canid_t *mask,
  * @dev: pointer to netdevice (NULL => subscribe from 'all' CAN devices list)
  * @can_id: CAN identifier (see description)
  * @mask: CAN mask (see description)
  * @func: callback function on filter match
  * @data: returned parameter for callback function
- * @ident: string for calling module identification
+ * @ino: inode number of sock (0 = unknown)
  * @sk: socket pointer (might be NULL)
  *
  * Description:
  *  Invokes the callback function with the received sk_buff and the given
  *  parameter 'data' on a matching receive filter. A filter matches, when
@@ -441,11 +441,11 @@ static struct hlist_head *can_rcv_list_find(canid_t *can_id, canid_t *mask,
  *  -ENOMEM on missing cache mem to create subscription entry
  *  -ENODEV unknown device
  */
 int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 		    canid_t mask, void (*func)(struct sk_buff *, void *),
-		    void *data, char *ident, struct sock *sk)
+		    void *data, u64 ino, struct sock *sk)
 {
 	struct receiver *rcv;
 	struct hlist_head *rcv_list;
 	struct can_dev_rcv_lists *dev_rcv_lists;
 	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
@@ -470,11 +470,11 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 	rcv->can_id = can_id;
 	rcv->mask = mask;
 	atomic_long_set(&rcv->matches, 0);
 	rcv->func = func;
 	rcv->data = data;
-	rcv->ident = ident;
+	rcv->ino = ino;
 	rcv->sk = sk;
 
 	hlist_add_head_rcu(&rcv->list, rcv_list);
 	dev_rcv_lists->entries++;
 
diff --git a/net/can/af_can.h b/net/can/af_can.h
index 87887014f562..6e593ed5db5f 100644
--- a/net/can/af_can.h
+++ b/net/can/af_can.h
@@ -53,11 +53,11 @@ struct receiver {
 	canid_t can_id;
 	canid_t mask;
 	atomic_long_t matches;
 	void (*func)(struct sk_buff *skb, void *data);
 	void *data;
-	char *ident;
+	u64 ino;
 	struct sock *sk;
 	struct rcu_head rcu;
 };
 
 /* statistic structures */
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 3d637a1e0ac1..dff8fab6b402 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -141,11 +141,11 @@ struct bcm_sock {
 	struct list_head notifier;
 	struct list_head rx_ops;
 	struct list_head tx_ops;
 	unsigned long dropped_usr_msgs;
 	struct proc_dir_entry *bcm_proc_read;
-	char procname [32]; /* inode number in decimal with \0 */
+	char procname [18]; /* inode number in hex with \0 */
 };
 
 static LIST_HEAD(bcm_notifier_list);
 static DEFINE_SPINLOCK(bcm_notifier_lock);
 static struct bcm_sock *bcm_busy_notifier;
@@ -218,13 +218,11 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 	struct net *net = m->private;
 	struct sock *sk = (struct sock *)pde_data(m->file->f_inode);
 	struct bcm_sock *bo = bcm_sk(sk);
 	struct bcm_op *op;
 
-	seq_printf(m, ">>> socket %pK", sk->sk_socket);
-	seq_printf(m, " / sk %pK", sk);
-	seq_printf(m, " / bo %pK", bo);
+	seq_printf(m, ">>> sock inode %s", bo->procname);
 	seq_printf(m, " / dropped %lu", bo->dropped_usr_msgs);
 	seq_printf(m, " / bound %s", bcm_proc_getifname(net, ifname, bo->ifindex));
 	seq_printf(m, " <<<\n");
 
 	rcu_read_lock();
@@ -1534,11 +1532,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			if (dev) {
 				err = can_rx_register(sock_net(sk), dev,
 						      op->can_id,
 						      REGMASK(op->can_id),
 						      bcm_rx_handler, op,
-						      "bcm", sk);
+						      sock_i_ino(sk), sk);
 
 				/* keep a tracked reference so that a later
 				 * unregister can safely reach the device even
 				 * if a concurrent NETDEV_UNREGISTER has
 				 * already unlisted it by ifindex
@@ -1558,11 +1556,12 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			}
 
 		} else {
 			err = can_rx_register(sock_net(sk), NULL, op->can_id,
 					      REGMASK(op->can_id),
-					      bcm_rx_handler, op, "bcm", sk);
+					      bcm_rx_handler, op,
+					      sock_i_ino(sk), sk);
 		}
 
 		if (err) {
 			/* newly created bcm rx op is broken -> remove it */
 			if (new_op) {
@@ -2038,12 +2037,13 @@ static int bcm_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int
 		bo->ifindex = 0;
 	}
 
 #if IS_ENABLED(CONFIG_PROC_FS)
 	if (net->can.bcmproc_dir) {
-		/* unique socket address as filename */
-		sprintf(bo->procname, "%llu", sock_i_ino(sk));
+		/* use unique socket inode number as filename */
+		snprintf(bo->procname, sizeof(bo->procname),
+			 "%016llx", sock_i_ino(sk));
 		bo->bcm_proc_read = proc_create_net_single(bo->procname, 0644,
 						     net->can.bcmproc_dir,
 						     bcm_proc_show, sk);
 		if (!bo->bcm_proc_read) {
 			ret = -ENOMEM;
diff --git a/net/can/gw.c b/net/can/gw.c
index 0ec99f68aa45..f1f59c0c6fd6 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -574,11 +574,11 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 
 static inline int cgw_register_filter(struct net *net, struct cgw_job *gwj)
 {
 	return can_rx_register(net, gwj->src.dev, gwj->ccgw.filter.can_id,
 			       gwj->ccgw.filter.can_mask, can_can_gw_rcv,
-			       gwj, "gw", NULL);
+			       gwj, 0, NULL);
 }
 
 static inline void cgw_unregister_filter(struct net *net, struct cgw_job *gwj)
 {
 	can_rx_unregister(net, gwj->src.dev, gwj->ccgw.filter.can_id,
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 155530aedce2..35ae4f51a525 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1619,18 +1619,18 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 
 	ifindex = dev->ifindex;
 
 	if (isotp_register_rxid(so))
 		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
-				isotp_rcv, sk, "isotp", sk);
+				isotp_rcv, sk, sock_i_ino(sk), sk);
 
 	/* no consecutive frame echo skb in flight */
 	WRITE_ONCE(so->cfecho, 0);
 
 	/* register for echo skb's */
 	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
-			isotp_rcv_echo, sk, "isotpe", sk);
+			isotp_rcv_echo, sk, sock_i_ino(sk), sk);
 
 	/* switch to new settings */
 	so->ifindex = ifindex;
 	so->rxid = rx_id;
 	so->txid = tx_id;
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 5e5e6c228f22..d9384cf0e356 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -182,11 +182,11 @@ static int j1939_can_rx_register(struct j1939_priv *priv)
 	struct net_device *ndev = priv->ndev;
 	int ret;
 
 	j1939_priv_get(priv);
 	ret = can_rx_register(dev_net(ndev), ndev, J1939_CAN_ID, J1939_CAN_MASK,
-			      j1939_can_recv, priv, "j1939", NULL);
+			      j1939_can_recv, priv, 0, NULL);
 	if (ret < 0) {
 		j1939_priv_put(priv);
 		return ret;
 	}
 
diff --git a/net/can/proc.c b/net/can/proc.c
index de4d05ae3459..9e44002cea82 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -190,29 +190,25 @@ static void can_print_rcvlist(struct seq_file *m, struct hlist_head *rx_list,
 {
 	struct receiver *r;
 
 	hlist_for_each_entry_rcu(r, rx_list, list) {
 		char *fmt = (r->can_id & CAN_EFF_FLAG)?
-			"   %-5s  %08x  %08x  %pK  %pK  %8ld  %s\n" :
-			"   %-5s     %03x    %08x  %pK  %pK  %8ld  %s\n";
+			"  %6s  %08x  %08x  %8ld  %016llx  %ps\n" :
+			"  %6s     %03x    %08x  %8ld  %016llx  %ps\n";
 
 		seq_printf(m, fmt, DNAME(dev), r->can_id, r->mask,
-			   r->func, r->data, atomic_long_read(&r->matches),
-			   r->ident);
+			   atomic_long_read(&r->matches), r->ino, r->func);
 	}
 }
 
 static void can_print_recv_banner(struct seq_file *m)
 {
 	/*
-	 *                  can1.  00000000  00000000  00000000
-	 *                 .......          0  tp20
+	 *    device   can_id   can_mask   matches     sock_inode     function
+	 *     vcan0  80000123  c00007ff         0  000000000000ab16  raw_rcv [can_raw]
 	 */
-	if (IS_ENABLED(CONFIG_64BIT))
-		seq_puts(m, "  device   can_id   can_mask      function          userdata       matches  ident\n");
-	else
-		seq_puts(m, "  device   can_id   can_mask  function  userdata   matches  ident\n");
+	seq_puts(m, "  device   can_id   can_mask   matches     sock_inode     function\n");
 }
 
 static int can_stats_proc_show(struct seq_file *m, void *v)
 {
 	struct net *net = m->private;
diff --git a/net/can/raw.c b/net/can/raw.c
index 82d9c0499c95..0a8b7c2fb4c9 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -220,11 +220,11 @@ static int raw_enable_filters(struct net *net, struct net_device *dev,
 	int i;
 
 	for (i = 0; i < count; i++) {
 		err = can_rx_register(net, dev, filter[i].can_id,
 				      filter[i].can_mask,
-				      raw_rcv, sk, "raw", sk);
+				      raw_rcv, sk, sock_i_ino(sk), sk);
 		if (err) {
 			/* clean up successfully registered filters */
 			while (--i >= 0)
 				can_rx_unregister(net, dev, filter[i].can_id,
 						  filter[i].can_mask,
@@ -241,11 +241,11 @@ static int raw_enable_errfilter(struct net *net, struct net_device *dev,
 {
 	int err = 0;
 
 	if (err_mask)
 		err = can_rx_register(net, dev, 0, err_mask | CAN_ERR_FLAG,
-				      raw_rcv, sk, "raw", sk);
+				      raw_rcv, sk, sock_i_ino(sk), sk);
 
 	return err;
 }
 
 static void raw_disable_filters(struct net *net, struct net_device *dev,
-- 
2.53.0

