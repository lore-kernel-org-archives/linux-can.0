Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099944;
	b=o2yVdqjbttKjFXvsNfCQaBj709vsTk8Z5VBxfXXIo277jJa+/ud7B1tkJHp1MEdzYrx9
	 Rfx9lm6Bxu+OXN6Ss9V1YU/ruDPMSx+WT6zTI4Pmre94UG5YTy1SekggqsZ7kgB7iUZHE
	 1IdslrDnBKv57QbGUZkqL3a+ReROVKbQcNyx7COWQDjXTuf3aEjSW6oFRrjNcpCXb/E4R
	 60f8rew6oBuMDnMMbhhjObw+WUTu22tsn7wUwbFEhhY/TFRkuOZpd11fEbYyT5AFh9zqP
	 7RSIXrQbpJY+A6Wl16bood4uXx68CEYAYPhJC8oeoCjM4eLc8+EtYSHHEEIh5npBD4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099944;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uksFJPZjhI7Oob4eye8L4T40mNdNkLOwYTNKRQqI65I=;
	b=tbBaUGzHfEwMv0vJDGJYfHoXdBHpnSKH+O/Phu2vbofzzLFhAfK1HUxQ+q7Nt2p/2HOC
	 VMK0S2k2TeMICuL2MzAMf1KFNpVa1dv+B2KHDZB8OT8RUSOnv/oSei4H6G+z8JiQaeJ4F
	 t9lGXnZFKpCD/Alve/1TGGRMxCN7r6HwB1qivdo5dtOAX5yJuztzw0ZY6gBwyFwlo0zR4
	 3Dbumoi18fwGyA8SKTzeze6XRg0IgnuLzeTMAzjjGO2a2jymyhjoo/XaLsNwMcqhLDQUz
	 HUKpZ3UFJGoktzLan+6cNhpGQdE/LQIMnn7r45JUF1FFjbngwrbY/TLnFTTZQF0PWFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=UkcNZdJR;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D94606A31D
	for <linux-can@vger.kernel.org>; Tue, 27 Oct 2026 11:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4D94606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=UkcNZdJR
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-ccca948203aso1267964a12.3
        for <linux-can@vger.kernel.org>; Tue, 27 Oct 2026 04:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1793099943; x=1793704743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uksFJPZjhI7Oob4eye8L4T40mNdNkLOwYTNKRQqI65I=;
        b=UkcNZdJRlksj/7suyXbcluVVndOHGCN1I72ZVZ9tg4jq1QZjOJcpM8xHxh5TQXbcFN
         4h6NoTf1juiXdEZFs1twNYIFnXg31I3YqKkWqWalWMTP7aM+vMKfGByCCJBgnHfXGDgM
         L1Hbo7tD/jSezSK6YHFDrbyOnfw1buPcHmOlCRC1OQttxyngGNgE105W2/bdKbv7Ke0v
         vDXRSwKRyUkBoU48appnmr7BdwvNqzRefNKHiXfgMC7/ZKsclxAu12aGECSOaaNwBpaw
         8+Iym4LdKTwY27csPuor8G6nSp6XA41LIJmplUM/VXf+AlRpfMMAXnSBttBSX4JPjpIE
         PojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793099943; x=1793704743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uksFJPZjhI7Oob4eye8L4T40mNdNkLOwYTNKRQqI65I=;
        b=wvG7pMwnqOtbgcJIr3xydYMFCihWCnWhZWOhTG5JYTvIZ7z2EvHjsumcz17B/t3eN+
         tuPCTiXF8wFOKVxlcnhuu/kSqlqX6scdej/3wUTzPL/6cVvFeP+8r4GAJai1FWfyPN9r
         eh1l0A8y2ilXEJ3DFutlOOBgMk+XPYQe8AiqPHvu3BRPeGTiE+RWtQ4z8KGLqnVl6Tgr
         74vWsPht+m80nmU8sFVfleuMosuUUF2xuLeVEr5tRPatqVtkiywqJdYBsW2CTBIJAQ5q
         hmT5udwwkHKZEckM9qOY0gDLkYzFrlFlkq95MJwK9tIhLBErQyyUyGhQ43NF6ne65OVA
         ts5Q==
X-Gm-Message-State: AFq9FYKaz40TezOiz2H2WtpjR5nA7Ig+VhLNe9RTrKGhoAvB2eumO3jQ
	ep5HHK7UmFvEAllmHvbW+CBZd1zHPuAuIah80kVJwtmlRIKImOBC5RJrcMkiCH9Dx3uWYxaNXqE
	gl66+Xw==
X-Gm-Gg: AYBFou3Lsy7jSWJOqfMHAbdCUzdx6VFBl45Vd8f5SpJ9Ie1lvTNKkjZCIbzh2kQZtfj
	YmMDJuf7FNLQkaxQ4wXMXh3/HAU3YqWka3b1lhB/J7nk+FueTcCsPBeTCSVCIL3+9T1HibPWHPS
	XrhQ7jBuIbFPYjyMLH2qGhhKA3XRsSAM+69L0KAGh6tOaDfl/HHyvXOztiT9CvZDQYAAMz3islG
	gsk32xBXkYYYv41aeUVCawNXP2mMl3DnkSb3VdK8gBnDwx53qZbuIVACNiwpkjA7A5oA2PTowqh
	JzQrm4MvmXFFOxsgS+b3Y69TM+Un2abbQE7n88Sr6I8xY0DwuATMmfhMu6H1WCcW4nCOKASu13M
	UaNJlpIARwTkI62xMCIP4fjUyoIYtjOT+gaQRzCMBN9iijvbjMENzV7D5OWilqJusk1GHztM56X
	ap29yWWcpdTVQe0GsTw8dB5eLs8ZnF/r/I726aADmp5XadknaTdzjohlGQ4mJeSa2f9KJ2PpPzA
	C0GFprzPs5flNFvyTp9ExpMTBsoudXZblMyfs1AGlSFpecWasVqmYLjBq7HU2MLN2A3HYXzGTs/
	nM1qbvH2iC0=
X-Received: by 2002:a17:90b:2e8c:b0:3ac:8897:7b9f with SMTP id 98e67ed59e1d1-3adeae77a16mr7543413a91.43.1793099942816;
        Tue, 27 Oct 2026 04:19:02 -0700 (PDT)
Received: from 24c857d0c3be.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae404276e6sm3555163a91.3.2026.10.27.04.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 04:19:02 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net,
	mkl@pengutronix.de,
	davem@davemloft.net,
	urs.thuermann@volkswagen.de,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net 1/1] can: bcm: limit RX operation resource usage per socket
Date: Tue, 27 Oct 2026 11:18:49 +0000
Message-ID: <92fe9d7fe3a7daa2cc7de740b15ec7eaa0638b98.1793089479.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1793089479.git.zihanx@nebusec.ai>
References: <cover.1793089479.git.zihanx@nebusec.ai>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BCM sockets can create an unbounded number of RX operations. Each
operation allocates memory outside of the socket buffer accounting,
so a single unprivileged socket can exhaust kernel memory.

Bound the number and aggregate allocation size of RX operations per
socket. Keep the charge until the operation and its frame arrays are
freed. Also keep a receiver count charged until the CAN core releases
the receiver after its RCU grace period, so repeated setup/delete
requests cannot bypass the limits while callbacks are pending.

Return -ENOBUFS when a socket reaches either limit. Existing operations
can still be updated without additional charges.

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Link: https://bugtracker.nebusec.ai/f/11134
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 include/linux/can/core.h |   7 +++
 net/can/af_can.c         |  34 +++++++++-
 net/can/af_can.h         |   1 +
 net/can/bcm.c            | 131 ++++++++++++++++++++++++++++++++-------
 4 files changed, 147 insertions(+), 26 deletions(-)

diff --git a/include/linux/can/core.h b/include/linux/can/core.h
index 2de74c2b78b6..89b9d0a2dcc1 100644
--- a/include/linux/can/core.h
+++ b/include/linux/can/core.h
@@ -53,6 +53,13 @@ int can_rx_register(struct net *net, struct net_device *dev,
 		    void (*func)(struct sk_buff *, void *),
 		    void *data, char *ident, struct sock *sk);
 
+/* release runs from an RCU callback and must not sleep. */
+int can_rx_register_with_release(struct net *net, struct net_device *dev,
+				 canid_t can_id, canid_t mask,
+				 void (*func)(struct sk_buff *, void *),
+				 void *data, char *ident, struct sock *sk,
+				 void (*release)(struct sock *sk));
+
 extern void can_rx_unregister(struct net *net, struct net_device *dev,
 			      canid_t can_id, canid_t mask,
 			      void (*func)(struct sk_buff *, void *),
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 34fe3b28d576..a3f0ed35fbb5 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -441,15 +441,20 @@ static struct hlist_head *can_rcv_list_find(canid_t *can_id, canid_t *mask,
  *  -ENOMEM on missing cache mem to create subscription entry
  *  -ENODEV unknown device
  */
-int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
-		    canid_t mask, void (*func)(struct sk_buff *, void *),
-		    void *data, char *ident, struct sock *sk)
+static int can_rx_register_internal(struct net *net, struct net_device *dev,
+				    canid_t can_id, canid_t mask,
+				    void (*func)(struct sk_buff *, void *),
+				    void *data, char *ident, struct sock *sk,
+				    void (*release)(struct sock *sk))
 {
 	struct receiver *rcv;
 	struct hlist_head *rcv_list;
 	struct can_dev_rcv_lists *dev_rcv_lists;
 	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
 
+	if (release && !sk)
+		return -EINVAL;
+
 	/* insert new receiver  (dev,canid,mask) -> (func,data) */
 
 	if (dev && (dev->type != ARPHRD_CAN || !can_get_ml_priv(dev)))
@@ -474,6 +479,7 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 	rcv->data = data;
 	rcv->ident = ident;
 	rcv->sk = sk;
+	rcv->release = release;
 
 	hlist_add_head_rcu(&rcv->list, rcv_list);
 	dev_rcv_lists->entries++;
@@ -485,15 +491,37 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 
 	return 0;
 }
+
+int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
+		    canid_t mask, void (*func)(struct sk_buff *, void *),
+		    void *data, char *ident, struct sock *sk)
+{
+	return can_rx_register_internal(net, dev, can_id, mask, func, data,
+					ident, sk, NULL);
+}
 EXPORT_SYMBOL(can_rx_register);
 
+int can_rx_register_with_release(struct net *net, struct net_device *dev,
+				 canid_t can_id, canid_t mask,
+				 void (*func)(struct sk_buff *, void *),
+				 void *data, char *ident, struct sock *sk,
+				 void (*release)(struct sock *sk))
+{
+	return can_rx_register_internal(net, dev, can_id, mask, func, data,
+					ident, sk, release);
+}
+EXPORT_SYMBOL(can_rx_register_with_release);
+
 /* can_rx_delete_receiver - rcu callback for single receiver entry removal */
 static void can_rx_delete_receiver(struct rcu_head *rp)
 {
 	struct receiver *rcv = container_of(rp, struct receiver, rcu);
 	struct sock *sk = rcv->sk;
+	void (*release)(struct sock *sk) = rcv->release;
 
 	kmem_cache_free(rcv_cache, rcv);
+	if (release)
+		release(sk);
 	if (sk)
 		sock_put(sk);
 }
diff --git a/net/can/af_can.h b/net/can/af_can.h
index 87887014f562..2fa4cf8c1314 100644
--- a/net/can/af_can.h
+++ b/net/can/af_can.h
@@ -57,6 +57,7 @@ struct receiver {
 	void *data;
 	char *ident;
 	struct sock *sk;
+	void (*release)(struct sock *sk);
 	struct rcu_head rcu;
 };
 
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 3d637a1e0ac1..96d3f050dec5 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -58,6 +58,7 @@
 #include <linux/can/skb.h>
 #include <linux/can/bcm.h>
 #include <linux/slab.h>
+#include <linux/overflow.h>
 #include <linux/workqueue.h>
 #include <linux/spinlock.h>
 #include <net/can.h>
@@ -127,6 +128,7 @@ struct bcm_op {
 	void *last_frames;
 	struct canfd_frame sframe;
 	struct canfd_frame last_sframe;
+	size_t rx_mem;
 	struct sock *sk;
 	struct net_device *rx_reg_dev;
 	netdevice_tracker rx_reg_dev_tracker;
@@ -141,6 +143,9 @@ struct bcm_sock {
 	struct list_head notifier;
 	struct list_head rx_ops;
 	struct list_head tx_ops;
+	unsigned int rx_op_count;
+	size_t rx_mem_used;
+	atomic_t rx_receiver_count;
 	unsigned long dropped_usr_msgs;
 	struct proc_dir_entry *bcm_proc_read;
 	char procname [32]; /* inode number in decimal with \0 */
@@ -190,6 +195,10 @@ static bool bcm_is_invalid_tv(struct bcm_msg_head *msg_head)
 #define OPSIZ sizeof(struct bcm_op)
 #define MHSIZ sizeof(struct bcm_msg_head)
 
+/* Bound the resources consumed by RX operations on one BCM socket. */
+#define BCM_MAX_RX_OPS 1024
+#define BCM_MAX_RX_MEM (16 * 1024 * 1024)
+
 /*
  * procfs functions
  */
@@ -922,9 +931,64 @@ static struct bcm_op *bcm_find_op(struct list_head *ops,
 	return NULL;
 }
 
+/* Called with the socket lock held. */
+static bool bcm_rx_op_charge(struct bcm_sock *bo, size_t rx_mem)
+{
+	if (bo->rx_op_count >= BCM_MAX_RX_OPS ||
+	    rx_mem > BCM_MAX_RX_MEM - bo->rx_mem_used)
+		return false;
+
+	bo->rx_op_count++;
+	bo->rx_mem_used += rx_mem;
+	return true;
+}
+
+/* Called with the socket lock held. */
+static void bcm_rx_op_uncharge(struct bcm_sock *bo, size_t rx_mem)
+{
+	if (!rx_mem)
+		return;
+
+	if (WARN_ON_ONCE(!bo->rx_op_count || bo->rx_mem_used < rx_mem))
+		return;
+
+	bo->rx_op_count--;
+	bo->rx_mem_used -= rx_mem;
+}
+
+static void bcm_rx_receiver_release(struct sock *sk)
+{
+	struct bcm_sock *bo = bcm_sk(sk);
+
+	WARN_ON_ONCE(atomic_dec_return(&bo->rx_receiver_count) < 0);
+}
+
+/* Called with the socket lock held. */
+static int bcm_rx_register(struct bcm_op *op, struct net_device *dev)
+{
+	struct bcm_sock *bo = bcm_sk(op->sk);
+	int err;
+
+	if (atomic_inc_return(&bo->rx_receiver_count) > BCM_MAX_RX_OPS) {
+		atomic_dec(&bo->rx_receiver_count);
+		return -ENOBUFS;
+	}
+
+	err = can_rx_register_with_release(sock_net(op->sk), dev, op->can_id,
+					   REGMASK(op->can_id), bcm_rx_handler,
+					   op, "bcm", op->sk,
+					   bcm_rx_receiver_release);
+	if (err)
+		atomic_dec(&bo->rx_receiver_count);
+
+	return err;
+}
+
 static void bcm_free_op_work(struct work_struct *work)
 {
 	struct bcm_op *op = container_of(work, struct bcm_op, work);
+	struct sock *sk = op->sk;
+	size_t rx_mem = op->rx_mem;
 
 	hrtimer_cancel(&op->timer);
 	hrtimer_cancel(&op->thrtimer);
@@ -935,13 +999,20 @@ static void bcm_free_op_work(struct work_struct *work)
 	if ((op->last_frames) && (op->last_frames != &op->last_sframe))
 		kfree(op->last_frames);
 
-	/* the last possible access to op->timer/op->thrtimer has now
-	 * happened above via hrtimer_cancel() - op->sk is no longer
-	 * needed by any pending timer callback, so drop our reference
+	kfree(op);
+	/*
+	 * Keep the RX budget charged until the operation and its frame arrays
+	 * have actually been freed. op->sk holds a reference while this work is
+	 * pending, so the socket remains valid while updating its accounting.
 	 */
-	sock_put(op->sk);
+	if (rx_mem) {
+		lock_sock(sk);
+		bcm_rx_op_uncharge(bcm_sk(sk), rx_mem);
+		release_sock(sk);
+	}
 
-	kfree(op);
+	/* Drop the reference held for the operation and any pending timer. */
+	sock_put(sk);
 }
 
 static void bcm_free_op_rcu(struct rcu_head *rcu_head)
@@ -1316,6 +1387,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 {
 	struct bcm_sock *bo = bcm_sk(sk);
 	struct bcm_op *op;
+	size_t rx_mem, frames_size, arrays_size;
 	int do_rx_register;
 	int new_op = 0;
 	int err = 0;
@@ -1414,10 +1486,31 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		do_rx_register = (ifindex && !op->rx_reg_dev) ? 1 : 0;
 
 	} else {
+		/*
+		 * Charge the operation and its frame arrays before allocating
+		 * them or registering a CAN receiver. nframes is already bounded
+		 * above, but keep the size arithmetic explicitly overflow-safe.
+		 */
+		rx_mem = sizeof(*op);
+		if (msg_head->nframes > 1) {
+			if (check_mul_overflow((size_t)msg_head->nframes,
+					       (size_t)CFSIZ(msg_head->flags),
+					       &frames_size) ||
+			    check_mul_overflow(frames_size, (size_t)2,
+					       &arrays_size) ||
+			    check_add_overflow(rx_mem, arrays_size, &rx_mem))
+				return -EOVERFLOW;
+		}
+
+		if (!bcm_rx_op_charge(bo, rx_mem))
+			return -ENOBUFS;
+
 		/* insert new BCM operation for the given can_id */
 		op = kzalloc(OPSIZ, GFP_KERNEL);
-		if (!op)
+		if (!op) {
+			bcm_rx_op_uncharge(bo, rx_mem);
 			return -ENOMEM;
+		}
 
 		spin_lock_init(&op->bcm_tx_lock);
 		spin_lock_init(&op->bcm_rx_update_lock);
@@ -1425,26 +1518,22 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		op->nframes = msg_head->nframes;
 		op->cfsiz = CFSIZ(msg_head->flags);
 		op->flags = msg_head->flags;
+		op->rx_mem = rx_mem;
 
 		if (msg_head->nframes > 1) {
 			/* create array for CAN frames and copy the data */
 			op->frames = kmalloc_array(msg_head->nframes,
 						   op->cfsiz,
 						   GFP_KERNEL);
-			if (!op->frames) {
-				kfree(op);
-				return -ENOMEM;
-			}
+			if (!op->frames)
+				goto free_op;
 
 			/* create and init array for received CAN frames */
 			op->last_frames = kcalloc(msg_head->nframes,
 						  op->cfsiz,
 						  GFP_KERNEL);
-			if (!op->last_frames) {
-				kfree(op->frames);
-				kfree(op);
-				return -ENOMEM;
-			}
+			if (!op->last_frames)
+				goto free_op;
 
 		} else {
 			op->frames = &op->sframe;
@@ -1532,11 +1621,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
 			dev = dev_get_by_index(sock_net(sk), ifindex);
 			if (dev) {
-				err = can_rx_register(sock_net(sk), dev,
-						      op->can_id,
-						      REGMASK(op->can_id),
-						      bcm_rx_handler, op,
-						      "bcm", sk);
+				err = bcm_rx_register(op, dev);
 
 				/* keep a tracked reference so that a later
 				 * unregister can safely reach the device even
@@ -1558,9 +1643,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			}
 
 		} else {
-			err = can_rx_register(sock_net(sk), NULL, op->can_id,
-					      REGMASK(op->can_id),
-					      bcm_rx_handler, op, "bcm", sk);
+			err = bcm_rx_register(op, NULL);
 		}
 
 		if (err) {
@@ -1593,6 +1676,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 	if (op->last_frames != &op->last_sframe)
 		kfree(op->last_frames);
 	kfree(op);
+	bcm_rx_op_uncharge(bo, rx_mem);
 	return err;
 }
 
@@ -1896,6 +1980,7 @@ static int bcm_init(struct sock *sk)
 	bo->ifindex          = 0;
 	bo->dropped_usr_msgs = 0;
 	bo->bcm_proc_read    = NULL;
+	atomic_set(&bo->rx_receiver_count, 0);
 
 	INIT_LIST_HEAD(&bo->tx_ops);
 	INIT_LIST_HEAD(&bo->rx_ops);
-- 
2.43.0

