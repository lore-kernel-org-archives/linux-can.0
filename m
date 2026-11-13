Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794566005;
	b=jniX9zbdpxwFmH8PZp0OMIPJEp2C9UDsfp4OJ8eO8R93CDV64kPFeTjDcMGtHc97behM
	 +gs2DgQZO6j9PuokZEbVa+ND+J5GVFs5lT5S+iN3ymOLRqu0IhwtYnS4PMzl/9q5H2tiF
	 HcrnSiHi4KEWSssWVRrdIZWl+R7yuFTTud/+GMVAEo6Z/mQuJFVhmKuVOiPWqe8NqENGI
	 ESV8Fbd4lmTxLVeilaKelTWESKPEiBbNlGzM5Q0Y1Wiq9dy2dS4b0y09iL1KCyGF5EqFJ
	 1IuOBpd4sOcdSsPRNEV7gN+bdVax8VLAWKnRpJM0WmvynSu01zDm9wxCOdIvcyLQIIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566005;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=3/R4csJXt6ljWbkgcfHRlsJkyP0Ri0rFldTcrvrzZMU=;
	b=rDpzUzl+aLhmnHRsVpVAlKq2RyyTTCdO/93AKwtcr4r4woMTwH1qL4/vVGFRkPLDRBfj
	 T+WnVtCpDXN2N4irBNAHd/YJ/Id4+DbNOdXiSWt1ix/kUqWbbtjd1regNZV0OHY3n1SOX
	 xHpfTuPfFVgDk2iyIR3Ftd92VKPNW+nz+4aQLCRP8Za/OMQfZp6i6RaojhLr6Ab9uK5Co
	 qdLIdFfg/qdJxb7rUlMVo/WXytKXUw6qVJcyN51sCKnH+IQFhSgIfQ+/TNgOBCzVT8sfl
	 0pmfZ47S6qy6026txEsGKvWr6nkozGLXq3KAKwoF8LHdHvBstyfZ3iqUUYTWU7FcXkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=oYS8xyOq;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=f2pNVM21;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.52
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95799606A333
	for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 10:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95799606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=oYS8xyOq;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=f2pNVM21
ARC-Seal: i=1; a=rsa-sha256; t=1794565995; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Rn/dRRjjRsGlsaLz82xQAUGpE0IBYKVOGLvkrfwJVWiBcbLbzscatxmmv1WaywAZNL
    P8Q1+BhDuGL0nrxu1rI1J/hUlT8dOR1pyjWjn7oHxXQPex+61HOVKNv5kAR51NFEHC36
    0NjONSrrIPkwhvVpiW2V/Pv2rcgdv0qShjt8OQUrsr6RcfsotviQ9LE78bCZxsyKHCt2
    QJlVUnMtB1AVbioUyzN4B9uf50svi2XHwsb9PoTPTJoUcE0051KBSVK8FFWhbZenT3oa
    /e+BRQLY6WSzmb8TxBhcqsrVdZDXmmFgCCsfarJYkoiJJOg/CxExw8HzzdVcVmvU195N
    waiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794565995;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=3/R4csJXt6ljWbkgcfHRlsJkyP0Ri0rFldTcrvrzZMU=;
    b=dYNwddddpOOqCUR/h8Hio+6oahpDQdD1f4KAOxYLIGiaLTrtCQjWA0tmqUXE844l5I
    eySmhGmHA2tLFigVyfI/YJlScP5WIpioucx2LvXHtnrl3vI6XWe45dZR7fG8J+1qUOVG
    b9mbqksziWH6IvpquNVz1hp10t16Eo+gkA7SE1g77PqP9B2Ukkrn7HzZ4xDkl6jcWf66
    cnjENU6x+Nux65LcGet14ocXKuZfw+SEnHV4VetgJT+eHh/HUnN+P0KmB1jNA1cxMUit
    ZG3FdoFNiM2jz2DCCWCZlnxC120y4ewgoD2Y7L9uytT6n8gMNYkPsKhubCO7AFCFWEck
    lekw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794565995;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=3/R4csJXt6ljWbkgcfHRlsJkyP0Ri0rFldTcrvrzZMU=;
    b=oYS8xyOq3zgjLPR7RykZws3Ud6mSZdCffEVSxmke2BeCNplxO0b+rAzVBW7RbsmAhq
    V/agY9KvkzMTOuRXOtcODX5fvYF0R/1Rklf6skwdsiPsBlZWjWCvF8qURgM5KjSF1RZ5
    PiRoYv0azrZjzcX2aSSzIgsB9mQTyKkgf9HwzXQsJS0LJzWBs3ZhpmL4PL+V8OaJsxZG
    ZdpzF0WPzR8L5wX+PaPlmvKB70pepjfbPMOS7xZweQs1PrcVCawcrb2/7u0AUYx5S44g
    w5qh2pxHDFCYxNl1e3R2xqaOaElRqsUfZ3Ln6qsqquSdCph45r5eex1zXPkDJ+cDGjIE
    s5XA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794565995;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=3/R4csJXt6ljWbkgcfHRlsJkyP0Ri0rFldTcrvrzZMU=;
    b=f2pNVM21TUH5PTaJ0AnnOogOaRdPBBBE1DHOjWnxVG9G1oLPP4uaEf9FYjre9XU3w6
    87BM9icyM7adGEoVxWCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2ADAXFIsA
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 13 Nov 2026 11:33:15 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Fri, 13 Nov 2026 11:33:12 +0100
Subject: [PATCH v5 5/5] can: bcm: use a private mutex instead of
 lock_sock()
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
Message-Id: <20261113-can-bcmlock-memcg-v5-5-634c0e04bc72@hartkopp.net>
References: <20261113-can-bcmlock-memcg-v5-0-634c0e04bc72@hartkopp.net>
In-Reply-To: <20261113-can-bcmlock-memcg-v5-0-634c0e04bc72@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794565994; l=6640;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=0fPGC/xxkkmtbXdS9A17N9QM2akwp0rkpZRZMjupUII=;
 b=tB4NO6JNw8HLGS0m8mv8zgy+3Y7LT1iZunSOMT6amfap+XjuyNSMemeQkbBi18yIchjzkBivD
 +F1JrNmC4JPB48oAXUuADd9WsSMllZNv1uXLZOqSE2pcxbFjB4HmMCa
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

bcm_notify() takes lock_sock() of every CAN_BCM socket in the namespace
of a vanishing CAN device while holding RTNL. Any path that holds the
socket lock while accessing user space can therefore block RTNL. With
"can: bcm: copy the CAN frames outside of lock_sock()" the CAN frames
of bcm_sendmsg() are copied outside of the socket lock, but the generic
SOL_SOCKET options in sk_setsockopt() and sk_getsockopt() still access
user space under sockopt_lock_sock(), e.g. for SO_ATTACH_FILTER,
SO_LINGER or SO_TXTIME.

CAN_BCM only uses lock_sock() to serialize the binding and the bcm_op
lists. It does not use the socket backlog, as the BCM messages are
queued directly to the socket.

Replace lock_sock() with the mutex conf_lock in struct bcm_sock. The
generic socket options do not take this mutex, so they can not block
bcm_notify() anymore. No user space access happens while the mutex is
held. The memory allocations for the bcm_ops and the CAN receivers are
still done under the mutex, as they have been under lock_sock() before.

bcm_release() removes the procfs entry before taking the mutex, as
remove_proc_entry() waits for readers that may stall in their copy to
user space. The socket has already left the notifier list at this
point.

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Cc: stable@vger.kernel.org # depends on "can: bcm: copy the CAN frames outside of lock_sock()"
Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 1595b7720c98..dc9e2890490a 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -143,10 +143,11 @@ struct bcm_sock {
 	struct list_head rx_ops;
 	struct list_head tx_ops;
 	unsigned long dropped_usr_msgs;
 	struct proc_dir_entry *bcm_proc_read;
 	char procname [32]; /* inode number in decimal with \0 */
+	struct mutex conf_lock; /* protects bind and the bcm_op lists */
 };
 
 static LIST_HEAD(bcm_notifier_list);
 static DEFINE_SPINLOCK(bcm_notifier_lock);
 static struct bcm_sock *bcm_busy_notifier;
@@ -1671,12 +1672,12 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 	cfsiz = CFSIZ(msg_head.flags);
 	if ((size - MHSIZ) % cfsiz)
 		return -EINVAL;
 
-	/* Copy the CAN frames from user space before lock_sock(), so a
-	 * stalled copy can not block bcm_notify() waiting for lock_sock()
+	/* Copy the CAN frames from user space before taking bo->conf_lock, so a
+	 * stalled copy can not block bcm_notify() waiting for bo->conf_lock
 	 * under RTNL. Only the frames the opcode handler reads are copied.
 	 * The handlers keep their checks and read the frames from fmsg.
 	 */
 	switch (msg_head.opcode) {
 	case TX_SETUP:
@@ -1712,16 +1713,16 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 	kv.iov_base = frames;
 	kv.iov_len = flen;
 	iov_iter_kvec(&fmsg.msg_iter, ITER_SOURCE, &kv, 1, flen);
 
-	lock_sock(sk);
+	mutex_lock(&bo->conf_lock);
 
-	/* Re-validate under the socket lock: a concurrent bcm_notify()
+	/* Re-validate under bo->conf_lock: a concurrent bcm_notify()
 	 * may have unbound this socket (device removal) after the
 	 * lockless fast-path check above. bo->ifindex is only ever
-	 * mutated under lock_sock(), so reading it here - instead of
+	 * mutated under bo->conf_lock, so reading it here - instead of
 	 * before taking the lock - guarantees it can't be observed
 	 * torn against bo->bound.
 	 */
 	if (!bo->bound) {
 		ret = -ENOTCONN;
@@ -1817,11 +1818,11 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		ret = -EINVAL;
 		break;
 	}
 
 out_release:
-	release_sock(sk);
+	mutex_unlock(&bo->conf_lock);
 out_free:
 	if (frames != &sframe)
 		kvfree(frames);
 
 	return ret;
@@ -1841,11 +1842,11 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 		return;
 
 	switch (msg) {
 
 	case NETDEV_UNREGISTER:
-		lock_sock(sk);
+		mutex_lock(&bo->conf_lock);
 
 		/* rx_ops: remove device specific receive entries */
 		list_for_each_entry(op, &bo->rx_ops, list) {
 			if (op->rx_reg_dev == dev)
 				bcm_rx_unreg(dev, op);
@@ -1875,11 +1876,11 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 			WRITE_ONCE(bo->bound, 0);
 			WRITE_ONCE(bo->ifindex, 0);
 			notify_enodev = 1;
 		}
 
-		release_sock(sk);
+		mutex_unlock(&bo->conf_lock);
 
 		if (notify_enodev) {
 			sk->sk_err = ENODEV;
 			if (!sock_flag(sk, SOCK_DEAD))
 				sk_error_report(sk);
@@ -1928,10 +1929,11 @@ static int bcm_init(struct sock *sk)
 
 	bo->bound            = 0;
 	bo->ifindex          = 0;
 	bo->dropped_usr_msgs = 0;
 	bo->bcm_proc_read    = NULL;
+	mutex_init(&bo->conf_lock);
 
 	INIT_LIST_HEAD(&bo->tx_ops);
 	INIT_LIST_HEAD(&bo->rx_ops);
 
 	/* set notifier */
@@ -1967,19 +1969,18 @@ static int bcm_release(struct socket *sock)
 		spin_lock(&bcm_notifier_lock);
 	}
 	list_del(&bo->notifier);
 	spin_unlock(&bcm_notifier_lock);
 
-	/* bcm_notify() can not access this socket anymore */
-	lock_sock(sk);
-
 #if IS_ENABLED(CONFIG_PROC_FS)
 	/* remove procfs entry */
 	if (net->can.bcmproc_dir && bo->bcm_proc_read)
 		remove_proc_entry(bo->procname, net->can.bcmproc_dir);
 #endif /* CONFIG_PROC_FS */
 
+	mutex_lock(&bo->conf_lock);
+
 	list_for_each_entry_safe(op, next, &bo->tx_ops, list) {
 		list_del_rcu(&op->list);
 		bcm_remove_op(op);
 	}
 
@@ -2010,14 +2011,15 @@ static int bcm_release(struct socket *sock)
 	if (bo->bound) {
 		WRITE_ONCE(bo->bound, 0);
 		WRITE_ONCE(bo->ifindex, 0);
 	}
 
+	mutex_unlock(&bo->conf_lock);
+
 	sock_orphan(sk);
 	sock->sk = NULL;
 
-	release_sock(sk);
 	sock_prot_inuse_add(net, sk->sk_prot, -1);
 	sock_put(sk);
 
 	return 0;
 }
@@ -2032,11 +2034,11 @@ static int bcm_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int
 	int ret = 0;
 
 	if (len < BCM_MIN_NAMELEN)
 		return -EINVAL;
 
-	lock_sock(sk);
+	mutex_lock(&bo->conf_lock);
 
 	if (bo->bound) {
 		ret = -EISCONN;
 		goto fail;
 	}
@@ -2084,11 +2086,11 @@ static int bcm_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int
 	 * with the lockless fast-path check in bcm_sendmsg()
 	 */
 	WRITE_ONCE(bo->bound, 1);
 
 fail:
-	release_sock(sk);
+	mutex_unlock(&bo->conf_lock);
 
 	return ret;
 }
 
 static int bcm_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,

-- 
2.53.0

