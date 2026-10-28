Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793195016;
	b=fcMiwhc/fj9O0TvSlwIYUK6GXTadPdyADvC3N/Ce/GT5dm/z39PIDBTtr30Be4SXR8Nl
	 DduRz+vZTGsbpp4U3cqW1zhbarPs+Ox/MT0VFj5ztNbPZD8qhNNEzBsZTmFi5BM1rWdyh
	 6R/L6vkP3oJQWXD0pdFYbCziE0XLwgIaje39ECJJnB+4JlEk9EsJdF/QwqTfJyTyqm5j/
	 0yGmlKSc3gQqawuooBkPyAbOohPDayo9TUzf+aNe90mjwpV0G5ce5uVAR+SwslAwbsn4r
	 6Ywgjsaa7x/MVy4zBZDxCBd0EkVOY3OAjzIvygvGbx4juUxlscYwZcVKoyBg45N4w6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195016;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=16rlEnNc5kg+SD8amlGgoHSqkzjV8IujvpbAUK97pFA=;
	b=qn2LsSCVTMVIRSwi6n1VreeNnhx0DcLSwwcMI1hCq+iJykE7ueFTNuHUG1YBtArV+6Hz
	 XQmIwCUHbQtqW9n4Yz1oO2RczHep671yReoarxGYIv5yEjEWfZ85NT2iASR9ly/MNvGc8
	 NvkuaUa0QiH7FBwkSCp67yqsm4yYeBwfEaTfbPFXymT0k46c6uLP5zT0qjOG0C3SMLZaI
	 yqMYyPmvdSozypS26uk6NvmxE9a72S6iivwr+yixA0v6LFQsjv4tGOyN8SWxviqTLSEpI
	 sDbmdN+9OmOjAIDWfR1QQGgrk3cT2VY5Bgyskv+5+XVbYjSH2dz1QydRNOPnE4Q1dLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=DEZreKlw;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574B0606A31F
	for <linux-can@vger.kernel.org>; Wed, 28 Oct 2026 13:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 574B0606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=DEZreKlw
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so811631a91.3
        for <linux-can@vger.kernel.org>; Wed, 28 Oct 2026 06:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1793195016; x=1793799816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=16rlEnNc5kg+SD8amlGgoHSqkzjV8IujvpbAUK97pFA=;
        b=DEZreKlwe39/W/TiZoer2Y7TAuusaADyOKsO2NQW+f9WMBkJsgGwOu4EiYHQ3uBrz/
         rqsxZHXTfbkjgzpb4Moiwpa2E6bqJpAKZS6kEX2szjMHd75u6LnJ7kAsjS6Uu/dicysj
         8SYxd8VCe/IZAvyGCtOtR9OqFMg5tg3H7L9tgSRKlrGRnOdBKZsW047fORdq+9UWgXzs
         qnZx0ZQRKcjJLwyG8+Sl3lD1Y6nLf5yI9cOlVqy+wm7Qa0TJfG1jzfNzDMUEcegTCIMg
         KOcgJyNKEaaVrRUsIODH+86Mq7czN13EXgmAXVKYhZ184pi5QiLuKhKPAB/G3zmLbbpV
         /9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793195016; x=1793799816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=16rlEnNc5kg+SD8amlGgoHSqkzjV8IujvpbAUK97pFA=;
        b=OXyqDTYqLEB795ZXhhfECq59WCGG4LOL0lSvBz2IGq6oewEQOK1ik22Kywe1qtd6Lc
         7r09uj4tHsOSzk0YSSOGsInXPaus755nuW/Blvv51JtBqRdeKkk7aLESWs9oMI959xgv
         d52tXk7CW1oMyVP9pk+20bI/lFtYVQ1rv33POHg+L8DCZtGIYxk9ojFrCqS9rKSKcJpR
         kR/dxHJIJi5cJIxc+Y0+RIbTcQwgfQEaMrttqPcrTr6AS63/foxKgl+YgWUdoVy8KNcL
         ZIQRE/jkS3Xpg0CCGkmQkH44GT6PIsZmkDo8t7CqASXCIwMU9ecX8aDDrIxkcf79tPgQ
         aOJg==
X-Gm-Message-State: AFq9FYIuPAKE4/c641hH8Ltb9QlvzTH3s/1HuJk7blK6z9s4+ms0ejGI
	gLkcn/Jc9P22UdhbvhSL6MqtLN9gmST7JXR5gRSWaMFi/i0aFs98K2mX5GoztTkjlEu6z162OuQ
	w3kvcHQ==
X-Gm-Gg: AYBFou2OqRSZmEkx/BI1qQn2nUZr2il4jJ3AXKweCE7XeQVOl/T9lOIBn5CvOxquY8p
	NTCjQnavEfe589HcncCTgsJpPAOs8GhHUGifwOW0y7wj1NXXRqNt1PuLjBcz/NLfbcTxiXon1pQ
	PAIM6SidxZdUk5utwDmi506Graj1dcUmznpkG0IDKbviZuO/EEh54HuifHezK2Fba81WHjiMrAD
	k26cDJpCayBNNDhsj8bZiJzuI2xEWAdlTpL4SbsgHqJUPZMLfOEkPvj5PHBQCJs/Etg6B2AzB78
	CLL90nnCWjeHWn1w5/sFS1+qeotVON03SL+IDZkNXLWrd/SA/+UL2S//z63/D6AjXuzw37SIi8A
	/pJGFm+gSOOEhy3O49syMcV5yoDycrmobgmOMYqJ4lxmGXBqx73rXWsGbPmzlHXx8+l2HO1Lnhf
	O4SbUDoQBJDTye/s0VGMGDS/WfGi8PiDXDhGNcvxUl1Z3+Zs7evmuWxIaV4zfhFzDAX/757UVsi
	Y+6IhGiZWNxC3F4NpmQgewXd65QRz1s1JZVJKdrD4Jlv4LP9fZhg5aIvf4q5/lmH4qFR1GX4RcL
	VDNTnrroaxRgiMzmXNaJyJ1SCrfwaJ58NOEyXkIujBcqz1KTTVPF+g1sj8sr
X-Received: by 2002:a17:90b:1c82:b0:3ab:1b19:78f4 with SMTP id 98e67ed59e1d1-3ae57df3d6fmr1910287a91.6.1793195015528;
        Wed, 28 Oct 2026 06:43:35 -0700 (PDT)
Received: from 24c857d0c3be.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a941a8bsm3179875a91.6.2026.10.28.06.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 06:43:34 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: linux-can@vger.kernel.org,
	mkl@pengutronix.de,
	socketcan@hartkopp.net
Cc: urs.thuermann@volkswagen.de,
	davem@davemloft.net,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net v2 1/1] can: bcm: limit RX operation resource usage per socket
Date: Wed, 28 Oct 2026 13:43:25 +0000
Message-ID: <50f8970ce7800947332f6203626abbe1933997eb.1793109154.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1793109154.git.zihanx@nebusec.ai>
References: <cover.1793089479.git.zihanx@nebusec.ai> <cover.1793109154.git.zihanx@nebusec.ai>
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
 net/can/af_can.c         |  34 ++++++++++-
 net/can/af_can.h         |   1 +
 net/can/bcm.c            | 127 +++++++++++++++++++++++++++++++++------
 4 files changed, 147 insertions(+), 22 deletions(-)

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
index 3d637a1e0ac1..477bdc1e8745 100644
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
@@ -1425,6 +1518,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		op->nframes = msg_head->nframes;
 		op->cfsiz = CFSIZ(msg_head->flags);
 		op->flags = msg_head->flags;
+		op->rx_mem = rx_mem;
 
 		if (msg_head->nframes > 1) {
 			/* create array for CAN frames and copy the data */
@@ -1432,8 +1526,8 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 						   op->cfsiz,
 						   GFP_KERNEL);
 			if (!op->frames) {
-				kfree(op);
-				return -ENOMEM;
+				err = -ENOMEM;
+				goto free_op;
 			}
 
 			/* create and init array for received CAN frames */
@@ -1441,9 +1535,8 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 						  op->cfsiz,
 						  GFP_KERNEL);
 			if (!op->last_frames) {
-				kfree(op->frames);
-				kfree(op);
-				return -ENOMEM;
+				err = -ENOMEM;
+				goto free_op;
 			}
 
 		} else {
@@ -1532,11 +1625,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
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
@@ -1558,9 +1647,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			}
 
 		} else {
-			err = can_rx_register(sock_net(sk), NULL, op->can_id,
-					      REGMASK(op->can_id),
-					      bcm_rx_handler, op, "bcm", sk);
+			err = bcm_rx_register(op, NULL);
 		}
 
 		if (err) {
@@ -1593,6 +1680,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 	if (op->last_frames != &op->last_sframe)
 		kfree(op->last_frames);
 	kfree(op);
+	bcm_rx_op_uncharge(bo, rx_mem);
 	return err;
 }
 
@@ -1896,6 +1984,7 @@ static int bcm_init(struct sock *sk)
 	bo->ifindex          = 0;
 	bo->dropped_usr_msgs = 0;
 	bo->bcm_proc_read    = NULL;
+	atomic_set(&bo->rx_receiver_count, 0);
 
 	INIT_LIST_HEAD(&bo->tx_ops);
 	INIT_LIST_HEAD(&bo->rx_ops);
-- 
2.43.0

