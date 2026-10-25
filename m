Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792963989;
	b=JsRAQUUZRr930sSLfPo87qmBO1je3ZHZV0Dvt64ZsPpqvUvDzr0pyCuirhwbuZ9fNRMq
	 7L1C6d1LQn8LrmiJ9R5FWCdqw/LuVjrW78C7poCmA1QWnezxGg0HFKUUaAzLjRovG3CDd
	 ohTyvsNZ9P8DSx2GcxmjLujhN4R9MZ/IjblIWRlYYn2nVKHtFZRBbqZs/G5T1mFr1i1cM
	 HnPO3SuHoJKQD3m2CJ6h0L4a8++FuwgjekTkkfsC2+jRpJyxxmm3nIyg3RgtVEn32sM39
	 c/eSn9vdfCupEhjRsKGV/BBxfuYoiwydwTVKg5bFgPJbTRE010gQOu9aArsVyercmUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792963989;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=qGB93MIjoqDJQwksXOqPZ/oAeso80hHV+e8xEpv/sO8=;
	b=RfAYwCyvziDX/LiLA3SKCpLZG7+Xjesp5DjO7EhOLN24TQqJqVe2OLZE3T415QopZdS4
	 7E4m+0DSzcyEssqBsQHn4cPdtR4ipdobIdEIJlXmE9axSVt8XVeaYBfafQ84Z/36tL4XN
	 T1WR8FZ0ts9tiHReNPRRRdZu9rsRkJ6ycxpefMmPZjdD30xrrKJJsRD9ey2baAPMqr5QY
	 6NnGfflA98I0w9vGRB3ZvmS+VDnHa0rHuLmcRgBT3GEn5sk+aKxeJlXpNMgA2VkZAxKDk
	 x17GgLYzLeO9rVndOo3Z1Aek+zdo0qbgQRcCvEaxBVXqMPk/7elkpkWGaiEFEA4N5FQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b="XFOhjR+/";
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=dmvsgZuK;
	arc=fail smtp.remote-ip=85.215.255.52
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C74606A321
	for <linux-can@vger.kernel.org>; Sun, 25 Oct 2026 21:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85C74606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=XFOhjR+/;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=dmvsgZuK
ARC-Seal: i=1; a=rsa-sha256; t=1792963980; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Q9e/EBmoHSg64PDLRwqlRzmSd2kxqBud0KyZQglbuDBgEPVIBCnY/pMI6qKqDVg8U/
    2DEwZorF65s57nPqQk1PJ4KjgQjMAM73cz5o1SgML/Psh/h56OKulj658PPeEKgC5LkL
    SZKKrxjN7pfMt8oxU+wTC0XCrIFBy6JiZq6IxGJJXKlEo6HNVEXKrbBRGDkv32XNXK7w
    Bxk7yMcfuTdT2pZ6t4zt5NRnAeikzm/Nu9o7EWLDUXbV9l8vjf1sHytkyghO+DNlcS1v
    7JeSfy2uxkdZLIWgXZ9gNQNhQ566TitncKnHEX2v9w/+9y1o2OoFYI5ksmPTNdeJdd0F
    f92A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792963980;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=qGB93MIjoqDJQwksXOqPZ/oAeso80hHV+e8xEpv/sO8=;
    b=Wb2LfH+afhvbd6sUUvJrZTPMPDHWXGNC1S/Y+8xgZLByKu49mb3atCngLf6MtjKuZI
    NXnKSJIXp9Oj2v/IRr/sSkJpbn9yYprv6wkQzajpL4bLc9CRDYeoEMtRbt7vqDXvPpAB
    pOoB719+LbaoZr5tbQ5A3FaqrzzHq4KUCR15FyhqU3VDNY7akLjZ7xzr74mU8rU4cE+D
    K9s7scd4kRDFgFaTmUN/dcHI+JxUOl1XAfyBoFmjNQdxaapRhLi2Lis7YVL0P6ctLE8o
    z1f894g8FJ7MIepZJGTevGOr6mwY4bvP6kfebsxIq37g/9+hMng5CdHZtb18BStPMlH+
    bkmQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792963980;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=qGB93MIjoqDJQwksXOqPZ/oAeso80hHV+e8xEpv/sO8=;
    b=XFOhjR+/mEytlb465rFnHEER+A9V6nvZY+EQ3YkYzyWNb13/bGDa8c6L1Mwkqs8FiO
    TxHkV1Nx4EmPK8bqVgyCR8B7tVAEYkyJvU7ch/dS2j9CStUQb86QMM94Bu2tMd51Gw6V
    oBxFICJ+Hf8oHG7lTs11b4vyDi7UpI6T0IJ31AtlxMSZeLwJGQt6XdXrxp3vHJ9eHuJo
    B/i7WsMgFEJfbB5Va9l42nVaXd2Xf6gQviahtN3qIJRmdLrooWSWpmD9/BLDbwvbUXe0
    k56aiHJCYBM8qEiUxMIoINn8bnGe1XOqjkzfhoAJbBM3cuHaZWt8LudN6SN1X11IJIou
    gisA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792963980;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=qGB93MIjoqDJQwksXOqPZ/oAeso80hHV+e8xEpv/sO8=;
    b=dmvsgZuKTpXhTPy5c4BT9sNuoigHP4i91iDjOATuGP+n8AwEqQjcO0eitCkHOnQO9V
    Jgd4aTZ03/HU4HSmQ+CA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29PLX0z7z
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 25 Oct 2026 22:33:00 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Sun, 25 Oct 2026 22:32:45 +0100
Subject: [PATCH v9 3/7] can: proc: remove pointers from CAN specific proc
 output
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-can-rx-lock-v9-3-7ef2a2b5c2b4@hartkopp.net>
References: <20261025-can-rx-lock-v9-0-7ef2a2b5c2b4@hartkopp.net>
In-Reply-To: <20261025-can-rx-lock-v9-0-7ef2a2b5c2b4@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792963979; l=13279;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=gniehF4iNJiYlWGWgqCRHz1KKAjOrgX9TGbnFoJ98w4=;
 b=WPs4jfncHdSs22CsiopTdokCZ+kO+xYlAkDEjkdgVNBKB6jEQcRAbJhLMcteC2cVXWDWjhR+g
 cJfp9dbCm2lC+xQxh4RQAC5NQ9Z3eR6iZK1qk6DWBoJ2v6AcXzYiKvg
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

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
index 34fe3b28d576..6ebe9d3689ac 100644
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
index 3d637a1e0ac1..6c85a76477c3 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
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
+			 "%llu", sock_i_ino(sk));
 		bo->bcm_proc_read = proc_create_net_single(bo->procname, 0644,
 						     net->can.bcmproc_dir,
 						     bcm_proc_show, sk);
 		if (!bo->bcm_proc_read) {
 			ret = -ENOMEM;
diff --git a/net/can/gw.c b/net/can/gw.c
index 5793cb2420ed..36f9aa0f7026 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -577,11 +577,11 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 
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
index f5dc9d04bd68..b239f4b45518 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1623,18 +1623,18 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 
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
index fb144d2adc35..b7496d2a37cd 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -202,30 +202,36 @@ static void can_print_rcvlist(struct seq_file *m, struct hlist_head *rx_list,
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
index 6944ebab3feb..3e57f72a3afe 100644
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

