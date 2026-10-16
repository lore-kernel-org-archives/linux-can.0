Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0593890F8
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 10:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792147060; cv=pass; b=rlfN7str3OmAMJVqvhNiuQY9K40wnu9diGVePDVkTThAyStJngnbJe1JYTshYOYr+O3rM7bQTt8kjx2RsEsW9oHWwy9atY5LPPhR//zgVHNwUsJ3n2i4AzUK+PDx9GYl1R49eK+WiSIURm3lUgXvuyn00qTjdYxAmkMxngbDEB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792147060; c=relaxed/simple;
	bh=2jmAo3/NhJEWvPHy+o70ulscCJjLivIF3lEGHw8H9t0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PlFJcce372liBfk1/fIU8zWaQ/u+dA+VtpPx20ro4shg2CO5av8CfjUq5asSYWN2tvqjOLRFOfJI0OCTeJm6c9lUsnPoq/I7nT90zHPugrI15uOS4YHLoh8ueMuzy/H84Vx94Tv1+sfwz2Z5zaph0ize65zsOo3hM9kFiV4PXrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=gLjvl2wt; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=uxhb5sF/; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="gLjvl2wt";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="uxhb5sF/"
ARC-Seal: i=1; a=rsa-sha256; t=1792147036; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LVJkhOsDoSM/BIRcbPk7c1od4oUbwDi9j8UTXYw4Bk6Q6P5FGYY+2XE9pUbpABoqTY
    Gla7XdkvpSv8j82zK9mKboXGyW+J+6cVsFIfs6kKUZ8E7WsIk/Qe0em1legGoqwFCypk
    wskJ120PtMOKjvkrolIuPlOLfKyu1Gsxu+b6rVAIXesseAWvaritXEduf4g/msFQdM85
    nLREH+iFaCdd6ezLo3tJNVr+r12vBF05OUj8pLG72Vv/Y/O3yEObPaj0blgsH6etbY+o
    2aNiQXTiuX7C2MDEm9ErQ/c3rRpD6K+Sq87uZihZKwxii+m6eEstNBtyr2A3fCpv/+S3
    hKMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792147036;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=PHYEK6g244pqdBGw9llFWhyDdxuXHy08K1Cb1W45DR8=;
    b=N6XAf9hOg3jHJ+rndCNuJU7b+AdOpmo5InTRFaa4XrQ2k9tCCm1s5QzyF3E3VObx12
    OVCn4dBpJ0kU/DFkQlN6vIjkMN465CW9JpPSTGgVsGnELgbQX+DJ4mJPvmRfdNicBxna
    DPMus/VkAT2C2kAn69hc2aa8Hm/KLyeRG3VqE/kQ41324Boy0RgmMClsx9gHDlgYAGYY
    OP3L0KjKhhJcWChmWUn1cbKYhuI/6tYLAVx1FRpErOfZ9+3s0LyP0e13XLdEiLwBXI0q
    11svQgv4YXGTqavK9m9oGytlOeV0mgwjR20FeP2XJSqhNW0yjGIlP5wJ5JrtL4d+MXRA
    oj8A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792147036;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=PHYEK6g244pqdBGw9llFWhyDdxuXHy08K1Cb1W45DR8=;
    b=gLjvl2wtcBhhnLSW4+dKpCFBumwMsGE3plk+giHGg5nAYM+33QWZBOKvbEuT9Z/ZHK
    FrlCInoGBfCvu5NuU8LbL4nT9Fp0JxT+vD/S87Pl6o5macgvevN8p0oArW5xLtVyvD53
    rD6OPXyHaBFIxnKIglLHf6doXM76Ldxs9dzSbs7UwhNkg1gIf45b6Fo8YJY4RtnUD5zV
    pIkXMPQf2afGRDoECyAZhuQ4bUSMLAftMN7PcClgnn1U4e7uyoUsYiY2pTB/HereCrcX
    UcMtRsk3jdk557Tl778x6LuzLwpqNN5xqLHi0TCdSJFpSr6KZhFKfacTb4/agyh7jM9n
    gOBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792147036;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=PHYEK6g244pqdBGw9llFWhyDdxuXHy08K1Cb1W45DR8=;
    b=uxhb5sF/ukUcXGCklmZLbwGSdJTLV93J+OKKKt5/LyhpgteLbT5H2VEXs+YMiPHp6g
    YraLs2WhWns0WpA2vXDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29GAbGLnx
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 16 Oct 2026 12:37:16 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH can-next v3] can: proc: remove pointers from CAN specific proc output
Date: Fri, 16 Oct 2026 12:37:06 +0200
Message-ID: <20261016103706.410678-1-socketcan@hartkopp.net>
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
functionality of can_bcm jobs. While exposing kernel addresses was
acceptable when this code was written the times have changed and multiple
attempts have been made to hash or remove such now sensitive data.

This patch removes the disclosure of pointers and instead provides the
function names and sock inode numbers when available. When the function
name can not be resolved (e.g. KALLSYMS=n or stripped module symbols)
%ps would fall back to the raw text address. Therefore (unknown) is
printed instead in this case. As there's no known tooling around the CAN
specific proc output breaking the ABI with this rework creates no issue.

Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 Documentation/networking/can.rst | 16 ++++++++++------
 include/linux/can/core.h         |  2 +-
 net/can/af_can.c                 |  6 +++---
 net/can/af_can.h                 |  2 +-
 net/can/bcm.c                    | 14 +++++++-------
 net/can/gw.c                     |  2 +-
 net/can/isotp.c                  |  4 ++--
 net/can/j1939/main.c             |  2 +-
 net/can/proc.c                   | 26 ++++++++++++++++----------
 net/can/raw.c                    |  4 ++--
 10 files changed, 44 insertions(+), 34 deletions(-)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index 536ff411da1d..51bc70748f75 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -1038,21 +1038,25 @@ procfs content
 
 As described in :ref:`socketcan-receive-lists` the SocketCAN core uses several filter
 lists to deliver received CAN frames to CAN protocol modules. These
 receive lists, their filters and the count of filter matches can be
 checked in the appropriate receive list. All entries contain the
-device and a protocol module identifier::
+CAN network device, the filter (can_id/can_mask), the number of filter
+matches, the inode number of the subscribing socket and the name of the
+receive function. A sock_inode of 0 denotes a kernel internal subscriber
+without a socket (e.g. CAN gateway or J1939). When the function name can
+not be resolved (e.g. with CONFIG_KALLSYMS=n) "(unknown)" is printed::
 
     foo@bar:~$ cat /proc/net/can/rcvlist_all
 
     receive list 'rx_all':
-      (vcan3: no entry)
-      (vcan2: no entry)
-      (vcan1: no entry)
-      device   can_id   can_mask  function  userdata   matches  ident
-       vcan0     000    00000000  f88e6370  f6c6f400         0  raw
       (any: no entry)
+      device   can_id   can_mask   matches  sock_inode  function
+       vcan0     000    00000000         0       63586  raw_rcv [can_raw]
+      (vcan1: no entry)
+      (vcan2: no entry)
+      (vcan3: no entry)
 
 In this example an application requests any CAN traffic from vcan0::
 
     rcvlist_all - list for unfiltered entries (no filter operations)
     rcvlist_eff - list for single extended frame (EFF) entries
diff --git a/include/linux/can/core.h b/include/linux/can/core.h
index 2de74c2b78b6..effb5c31ef40 100644
--- a/include/linux/can/core.h
+++ b/include/linux/can/core.h
@@ -49,11 +49,11 @@ extern int  can_proto_register(const struct can_proto *cp);
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
index dc27ace43719..d97f85fc3232 100644
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
index 60406439a13f..6759662e024c 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -219,13 +219,11 @@ static int bcm_proc_show(struct seq_file *m, void *v)
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
@@ -1535,11 +1533,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
@@ -1559,11 +1557,12 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
@@ -2039,12 +2038,13 @@ static int bcm_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int
 		bo->ifindex = 0;
 	}
 
 #if IS_ENABLED(CONFIG_PROC_FS)
 	if (net->can.bcmproc_dir) {
-		/* unique socket address as filename */
-		sprintf(bo->procname, "%llu", sock_i_ino(sk));
+		/* use unique socket inode number as filename */
+		snprintf(bo->procname, sizeof(bo->procname),
+			 "%llu", sock_i_ino(sk));
 		bo->bcm_proc_read = proc_create_net_single(bo->procname, 0644,
 						     net->can.bcmproc_dir,
 						     bcm_proc_show, sk);
 		if (!bo->bcm_proc_read) {
 			ret = -ENOMEM;
diff --git a/net/can/gw.c b/net/can/gw.c
index 54bb5bd3242a..8a5327d8a00e 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -578,11 +578,11 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 
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
index 6c28802c0605..1a272ce6a2bd 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1624,18 +1624,18 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 
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
index de4d05ae3459..ba330dd8731d 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -189,30 +189,36 @@ static void can_print_rcvlist(struct seq_file *m, struct hlist_head *rx_list,
 			      struct net_device *dev)
 {
 	struct receiver *r;
 
 	hlist_for_each_entry_rcu(r, rx_list, list) {
+		char symcheck[4];
 		char *fmt = (r->can_id & CAN_EFF_FLAG)?
-			"   %-5s  %08x  %08x  %pK  %pK  %8ld  %s\n" :
-			"   %-5s     %03x    %08x  %pK  %pK  %8ld  %s\n";
+			"  %6s  %08x  %08x  %8ld  %10llu" :
+			"  %6s     %03x    %08x  %8ld  %10llu";
 
 		seq_printf(m, fmt, DNAME(dev), r->can_id, r->mask,
-			   r->func, r->data, atomic_long_read(&r->matches),
-			   r->ident);
+			   atomic_long_read(&r->matches), r->ino);
+
+		/* %ps falls back to the raw text address when the symbol
+		 * can not be resolved (KALLSYMS=n, stripped module symbols)
+		 */
+		snprintf(symcheck, sizeof(symcheck), "%ps", r->func);
+		if (strncmp(symcheck, "0x", 2))
+			seq_printf(m, "  %ps\n", r->func);
+		else
+			seq_puts(m, "  (unknown)\n");
 	}
 }
 
 static void can_print_recv_banner(struct seq_file *m)
 {
 	/*
-	 *                  can1.  00000000  00000000  00000000
-	 *                 .......          0  tp20
+	 *    device   can_id   can_mask   matches  sock_inode  function
+	 *     vcan0     000    00000000         0       43798  raw_rcv [can_raw]
 	 */
-	if (IS_ENABLED(CONFIG_64BIT))
-		seq_puts(m, "  device   can_id   can_mask      function          userdata       matches  ident\n");
-	else
-		seq_puts(m, "  device   can_id   can_mask  function  userdata   matches  ident\n");
+	seq_puts(m, "  device   can_id   can_mask   matches  sock_inode  function\n");
 }
 
 static int can_stats_proc_show(struct seq_file *m, void *v)
 {
 	struct net *net = m->private;
diff --git a/net/can/raw.c b/net/can/raw.c
index e1d741a25be3..09a5c0275ae6 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -224,11 +224,11 @@ static int raw_enable_filters(struct net *net, struct net_device *dev,
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
@@ -245,11 +245,11 @@ static int raw_enable_errfilter(struct net *net, struct net_device *dev,
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

