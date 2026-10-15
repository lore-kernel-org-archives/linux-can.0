Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46059377EBF;
	Thu, 15 Oct 2026 01:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029227; cv=pass; b=HRNyYe6ddkvkewC5N3i1lXMkjXD3Hb+sKwYo7gm191JjxwGq82xcw0sP5xJDRQi4aVQUSfpoOgw3sNLjxwGVSxb5WHISURklaj7HLyxTLHTOkAIQ5txL2VajjCSqd2kfnCEKWu8Wseu8IKn3cD3fdFncxxlTlRVw1xD7uPYRYds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029227; c=relaxed/simple;
	bh=CEdym0jVAMj0rdNxcy+HRX3l3JvD2WQ3+eR18nS3BgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=keKBnRqtlKF2YJLXKkdppJadsjue5nBK7DDg03Zj/7uJAWIco/In9f2nlt25LWCMVnyugxwiVeahKjJR3hCvG1r2WGaOPTKUP88HIAXffmi2H7mkyrQTCgh98dKXfnfZGNa4fgtmHcPMWBoApWp9nHua7Ty2I2iWwYwqBG/n1Dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=azckQd3q; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="azckQd3q"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id EB0B3201B55;
	Thu, 15 Oct 2026 03:53:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8EC6JOK6pKoNg/MrNZwR0AoRPGt5ydpx0EPRP7uqCHE=;
	b=azckQd3qIjauuP9eYQIlp+5+/S545bMhGd0wOsjb7s42kt8VZjcNaQfwFNIAP5RGtaKcAZ
	rfLy9sWoCO1n5WQWJsEwhrPIJPgux7pqJ1nS9wF+JNzF+0aaPQZUkbg5esgw0HEfK3dYH+
	pn3dxQelGqKqBlZF7atmANb1BYMvL/q/uPj2aG3/7r4AJNLY4PnZUttwYWIaP2dwg/dbvC
	REe0QEk1ej5ZByVsIKEj1bV0j7/+gAWRVHyfomux3TTlZnBqYwVScgnBwGLsASw0BX7BOL
	SUfjEc9tNxhOhNAhePM5JDRc6WVzCBUY4ITtcqMSS3zoIj5u5IH30q+PG9Yfuw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792029219; a=rsa-sha256;
	cv=none;
	b=aBMlyMPQPae/qcEXU1S3RgTKjMqVuA8SdTU4MVW5ZUfr9jCbw1fpH1vAgbUD9KcQqz/hsj
	b/aEIZIxJ4iskcQuGrJdUKk9Bz5fcqu5/M6yQzky5dqGUgU7CTCsAMkZHwt6Tdh12D73xo
	eiknBA4jCH6pbOL6UxQ8u8f4Q4UVf+JwAdkTzUq8X68rWFRTNjKFK8tOtSKnEB5sNDbmK9
	DSnfyUf2vocwbCo5tiTikQH478QL2UhNsDo0NbGMoJxr9sDRDlhtgbhkrr+apBEJMt3D4J
	DpiXXzMDvHILAB71wA08rTwp2HxDiiUR0dCN8x2OB06ceqduF4qqFC5F8iS1Kg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8EC6JOK6pKoNg/MrNZwR0AoRPGt5ydpx0EPRP7uqCHE=;
	b=P4YhNimrwabHeN/S6ELROzObZ0cmoYS/x1XF7Fv3S3LM+VgIKvs4nUbJz2Y6CCkMl6zlUn
	puk6d1V3fONNGoIpLyScN4Lpp+t8cvksQX97ILSEW/W6SS1cdUIir4qOjie4dtlKfh6g32
	Tg37g0u++oZtYAfErKsmNL5rZyKcDWeYvkdLDHpWxgIjikc4pgBNBhJlc0GsV/Kl+uEdzX
	I3T0BL6JmNcqne3VTVFKCa41k38OFksRzb3O0BkHk5aMllmJExV60mFkUAPn6nI1TbDQA3
	oh2obvTvFhUAjS5I8VQ8EPBMszfUFb/AImhLM4JTszNkwpiWP1LAbGggeuT4OA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAf5-005wpq-2h;
	Thu, 15 Oct 2026 03:53:39 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8A0695C4778;
	Thu, 15 Oct 2026 01:53:39 +0000 (UTC)
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
Date: Thu, 15 Oct 2026 03:40:03 +0200
Message-ID: <20261015015336.816543-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015015336.816543-1-mkl@pengutronix.de>
References: <20261015015336.816543-1-mkl@pengutronix.de>
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
functionality of can_bcm jobs. While exposing kernel addresses was
acceptable when this code was written the times have changed and multiple
attempts have been made to hash or remove such now sensitive data.

This patch removes the disclosure of pointers and instead provides the
function names and sock inode numbers when available. In the case of
KALLSYMS=n (EXPERT setting) the function names can not be resolved and
(unknown) is printed instead. As there's no known tooling around the CAN
specific proc output breaking the ABI with this rework creates no issue.

Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20261012115851.3412-1-socketcan@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/networking/can.rst | 12 ++++++------
 include/linux/can/core.h         |  2 +-
 net/can/af_can.c                 |  6 +++---
 net/can/af_can.h                 |  2 +-
 net/can/bcm.c                    | 14 +++++++-------
 net/can/gw.c                     |  2 +-
 net/can/isotp.c                  |  4 ++--
 net/can/j1939/main.c             |  2 +-
 net/can/proc.c                   | 22 ++++++++++++----------
 net/can/raw.c                    |  4 ++--
 10 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index 536ff411da1d..908c199cf6ad 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -1040,17 +1040,17 @@ As described in :ref:`socketcan-receive-lists` the SocketCAN core uses several f
 lists to deliver received CAN frames to CAN protocol modules. These
 receive lists, their filters and the count of filter matches can be
 checked in the appropriate receive list. All entries contain the
-device and a protocol module identifier::
+CAN network device and the subscribed function name::
 
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
index 60406439a13f..6759662e024c 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
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
+			 "%llu", sock_i_ino(sk));
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
index 64b3bdc2fa7e..64994ab48541 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -215,25 +215,27 @@ static void can_print_rcvlist(struct seq_file *m, struct hlist_head *rx_list,
 
 	hlist_for_each_entry_rcu(r, rx_list, list) {
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
+		/* without kallsyms %ps would print the raw text address */
+		if (IS_ENABLED(CONFIG_KALLSYMS))
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

