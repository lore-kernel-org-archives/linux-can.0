Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C764BD344;
	Fri,  9 Oct 2026 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553420; cv=pass; b=nHWn0gjqKnJ9lAIQssny7sm8ihpHdXAK+Ag+Uy84Ljvpha6Im5MFE4G9wAtA8Aayp/lkWKJLpO6KoxjrVo9lif8AVHZZYaX2jlO34i0kEvJ7tx1MaGDPDTUoytp6zNDbgS/ABbhjjctffltJSCrJ9SU6EtSzCWXDodKi3+D1+cM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553420; c=relaxed/simple;
	bh=t+O3x9PZs4NcTnE+UAIKGNew+ij++n1GtEk449ylM2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IkTfwiKLZwAXVoK/oRM42xIeUtfh9OJ9N4N0fyQz8/nuQMV5NxDjISmduOpxIsxAmtmmqMsYrygovXD7d6ha7Y1Yq5vPLkOLrGTLUHIV3/5sj3svEA6q7R9FMl/jNnWcLoBWsdMVF5abWPtnRtTVrPuEOoqqYNqeOrYgSdeNf1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=aEs2poeO; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="aEs2poeO"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id DAD87202607;
	Fri, 09 Oct 2026 15:43:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QiyTFqV9mgYbxIUogXXiiKTkeYwUg4+E4qSUmnKJvAM=;
	b=aEs2poeOG8nGbRkNychrD5aAVfDw3Q5BkzVhVVqnug42jKhFxz+KofbgC3Pkp22WFxpOzF
	j9TxRFxfZmFzSetOlcRrdqgUrQOtI1Gue6X+tGY4P6rdRCLTXMQtlOCWod5TOELN+eYL0S
	zd5cPd5L6LQ1/h+q1jKth7e+i5zPnC9A8PXH3TEoaJGVP1Yj2usOdsRbCxGbLcnMpSgtiI
	THdnXEtUx1b7KGJ1dMnURmnpZbhnrzmLzt7YRhBrULaPMf804jTRfL+ldyM0XJGAQE/NGa
	bJ8f6lDTOS6rjvPxTVmL/rdokgNPOCoAvA9JXb85+5RXZbW7Ca6oPdQAOwoEQQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553412; a=rsa-sha256;
	cv=none;
	b=a3Ex7/c+66qAc1fpq5sSl2G8l8L9FFmqSJr15O5TIn2QqyEnB+TnI1pG5ediNGzKZvoFUQ
	CG6CsabqDTZ3DnuUN3kNJ2UnxpepDw9e77UOEOdF+88SeefycS6LAIdXrFWKgDrMo7tBKr
	byJ1j79uMh1nDgvIRo7cnnoMy4T1aMltIHMUW/NyYqLZnGHwW1J6pxy0hqsTu+V3IjqkiZ
	8sY2Y1lnbN7uxjobHL0/baaNvdXO/z4Z2JzYk39zm/q5dHFyLNXwQQSchgRmw0LuBk9gLH
	6fDWiN7BM2tgg+26yn3bFn9D9hC157q/GqkZS3EEQ835plhsO/YJDEh3fXXKhA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QiyTFqV9mgYbxIUogXXiiKTkeYwUg4+E4qSUmnKJvAM=;
	b=glbPq/OpHAtoh/gVY9QOgOleL3OFbBBwUjuUz5F8eNebUpcuyWyp1Z+BcbVnL/FARWuhrC
	sQ8o77FFDxsXHw+vzLzMA53FuAIn46WNJh7Ut99sFTk6CG5XZxjYqfNM/fQK9W5arITF5a
	s1c7FzAVLfuLlFQKA2SSjn1afGPcKcsGwfwhTETTfU3pZtevj37XCBGI3FD2MI/aZy/U3s
	u5Fk7pGq809EqQ8ETp3jEWeeBy5CTro8b1MbR+b2dCZILjT7WG2OubLk5ng6jZ5N5KO9G5
	VRHIcXL5PyO/+NE++aRJKiKWhVvyTYg2fjeRPIk6CWxp7CUl981Crnd1gnMzaQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAsm-0053Ro-2Y;
	Fri, 09 Oct 2026 15:43:32 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5E9FA5BD8A0;
	Fri, 09 Oct 2026 13:43:32 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 05/37] can: proc: remove pointers from CAN specific proc output
Date: Fri,  9 Oct 2026 15:27:37 +0200
Message-ID: <20261009134323.64064-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009134323.64064-1-mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Oliver Hartkopp <socketcan@hartkopp.net>

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
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://patch.msgid.link/20260815103400.117175-1-socketcan@hartkopp.net
[mkl: fix checkpatch warning]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
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
@@ -1042,15 +1042,15 @@ receive lists, their filters and the count of filter matches can be
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
 
diff --git a/include/linux/can/core.h b/include/linux/can/core.h
index 2de74c2b78b6..effb5c31ef40 100644
--- a/include/linux/can/core.h
+++ b/include/linux/can/core.h
@@ -51,7 +51,7 @@ extern void can_proto_unregister(const struct can_proto *cp);
 int can_rx_register(struct net *net, struct net_device *dev,
 		    canid_t can_id, canid_t mask,
 		    void (*func)(struct sk_buff *, void *),
-		    void *data, char *ident, struct sock *sk);
+		    void *data, u64 ino, struct sock *sk);
 
 extern void can_rx_unregister(struct net *net, struct net_device *dev,
 			      canid_t can_id, canid_t mask,
diff --git a/net/can/af_can.c b/net/can/af_can.c
index dc27ace43719..d97f85fc3232 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -418,7 +418,7 @@ static struct hlist_head *can_rcv_list_find(canid_t *can_id, canid_t *mask,
  * @mask: CAN mask (see description)
  * @func: callback function on filter match
  * @data: returned parameter for callback function
- * @ident: string for calling module identification
+ * @ino: inode number of sock (0 = unknown)
  * @sk: socket pointer (might be NULL)
  *
  * Description:
@@ -443,7 +443,7 @@ static struct hlist_head *can_rcv_list_find(canid_t *can_id, canid_t *mask,
  */
 int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 		    canid_t mask, void (*func)(struct sk_buff *, void *),
-		    void *data, char *ident, struct sock *sk)
+		    void *data, u64 ino, struct sock *sk)
 {
 	struct receiver *rcv;
 	struct hlist_head *rcv_list;
@@ -472,7 +472,7 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 	atomic_long_set(&rcv->matches, 0);
 	rcv->func = func;
 	rcv->data = data;
-	rcv->ident = ident;
+	rcv->ino = ino;
 	rcv->sk = sk;
 
 	hlist_add_head_rcu(&rcv->list, rcv_list);
diff --git a/net/can/af_can.h b/net/can/af_can.h
index 87887014f562..6e593ed5db5f 100644
--- a/net/can/af_can.h
+++ b/net/can/af_can.h
@@ -55,7 +55,7 @@ struct receiver {
 	atomic_long_t matches;
 	void (*func)(struct sk_buff *skb, void *data);
 	void *data;
-	char *ident;
+	u64 ino;
 	struct sock *sk;
 	struct rcu_head rcu;
 };
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 60406439a13f..cb6a3d4cb076 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -144,7 +144,7 @@ struct bcm_sock {
 	struct list_head tx_ops;
 	unsigned long dropped_usr_msgs;
 	struct proc_dir_entry *bcm_proc_read;
-	char procname [32]; /* inode number in decimal with \0 */
+	char procname[18]; /* inode number in hex with \0 */
 };
 
 static LIST_HEAD(bcm_notifier_list);
@@ -221,9 +221,7 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 	struct bcm_sock *bo = bcm_sk(sk);
 	struct bcm_op *op;
 
-	seq_printf(m, ">>> socket %pK", sk->sk_socket);
-	seq_printf(m, " / sk %pK", sk);
-	seq_printf(m, " / bo %pK", bo);
+	seq_printf(m, ">>> sock inode %s", bo->procname);
 	seq_printf(m, " / dropped %lu", bo->dropped_usr_msgs);
 	seq_printf(m, " / bound %s", bcm_proc_getifname(net, ifname, bo->ifindex));
 	seq_printf(m, " <<<\n");
@@ -1537,7 +1535,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 						      op->can_id,
 						      REGMASK(op->can_id),
 						      bcm_rx_handler, op,
-						      "bcm", sk);
+						      sock_i_ino(sk), sk);
 
 				/* keep a tracked reference so that a later
 				 * unregister can safely reach the device even
@@ -1561,7 +1559,8 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		} else {
 			err = can_rx_register(sock_net(sk), NULL, op->can_id,
 					      REGMASK(op->can_id),
-					      bcm_rx_handler, op, "bcm", sk);
+					      bcm_rx_handler, op,
+					      sock_i_ino(sk), sk);
 		}
 
 		if (err) {
@@ -2041,8 +2040,9 @@ static int bcm_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int
 
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
diff --git a/net/can/gw.c b/net/can/gw.c
index 54bb5bd3242a..8a5327d8a00e 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -580,7 +580,7 @@ static inline int cgw_register_filter(struct net *net, struct cgw_job *gwj)
 {
 	return can_rx_register(net, gwj->src.dev, gwj->ccgw.filter.can_id,
 			       gwj->ccgw.filter.can_mask, can_can_gw_rcv,
-			       gwj, "gw", NULL);
+			       gwj, 0, NULL);
 }
 
 static inline void cgw_unregister_filter(struct net *net, struct cgw_job *gwj)
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 6c28802c0605..1a272ce6a2bd 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1626,14 +1626,14 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 
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
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 5e5e6c228f22..d9384cf0e356 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -184,7 +184,7 @@ static int j1939_can_rx_register(struct j1939_priv *priv)
 
 	j1939_priv_get(priv);
 	ret = can_rx_register(dev_net(ndev), ndev, J1939_CAN_ID, J1939_CAN_MASK,
-			      j1939_can_recv, priv, "j1939", NULL);
+			      j1939_can_recv, priv, 0, NULL);
 	if (ret < 0) {
 		j1939_priv_put(priv);
 		return ret;
diff --git a/net/can/proc.c b/net/can/proc.c
index 64b3bdc2fa7e..33d99543e3fe 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -215,25 +215,21 @@ static void can_print_rcvlist(struct seq_file *m, struct hlist_head *rx_list,
 
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
diff --git a/net/can/raw.c b/net/can/raw.c
index ad611906b308..dfea48768b23 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -226,7 +226,7 @@ static int raw_enable_filters(struct net *net, struct net_device *dev,
 	for (i = 0; i < count; i++) {
 		err = can_rx_register(net, dev, filter[i].can_id,
 				      filter[i].can_mask,
-				      raw_rcv, sk, "raw", sk);
+				      raw_rcv, sk, sock_i_ino(sk), sk);
 		if (err) {
 			/* clean up successfully registered filters */
 			while (--i >= 0)
@@ -247,7 +247,7 @@ static int raw_enable_errfilter(struct net *net, struct net_device *dev,
 
 	if (err_mask)
 		err = can_rx_register(net, dev, 0, err_mask | CAN_ERR_FLAG,
-				      raw_rcv, sk, "raw", sk);
+				      raw_rcv, sk, sock_i_ino(sk), sk);
 
 	return err;
 }
-- 
2.53.0

