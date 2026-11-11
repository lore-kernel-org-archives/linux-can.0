Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.165
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794410516;
	b=EM79gQQXwrKnK5D4mHKg4cj2CDuZD1GUSeqSUuNnw0fWCWJU9ATnRQpxdXjgTRxsMoMS
	 bjzVyIRsMIZ9jECWdlIB0eTC3vtuBmpmmO62CNJzExxnHKkVd8a9zcLIZtk+LuoLJApjg
	 fxoraTZ+fMiF3x+rm8nNlCHPeRrW9daoSLH/JTbqT3KeFMeQA84vicGbQ+57oVDcPORAo
	 316/lCkFJVb+pMxASFUObPAumeKhWFhQ75+9dWCOvB/WTKLNrdOjfPnqRsrQFcmiLi34z
	 e4wYy24YLZbSoBsteFc2LZOkyf/uNRy6HkMahk15ieFwGfNz520ZpDEIp/Z5L9+U3RQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410516;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=dwL8e8ZYoeRdPXKcUDRoORoiKt+eQzy0KuzmFC2OD1k=;
	b=WdD66L2gYKztJDnijNMzYaX22PkVw0/F7Uf+x9HfJwlC0emLUrX1MPqHkPYfb1I+jC0C
	 3BlLhXSSr03bqbTN8EjRWl3/JLKcAMpDMRVWubJiGhu/GzfGTJ6zZpBgE1LL1gKdJDrW1
	 lRERnsBrxjX1EJAGfcSEtz+x2DcnCVXbgZVOXj+0nKLo4LfVCf2gpSJHgU8jpJbcs8j8v
	 /gLPCV1BibR1FjbyqweXF0VFpmp1sjgBPJrkkpGQUCttuLJ/oQew2h/mZai6rEWfSI3LU
	 nl0+rVH0ALxcdREl9vuiCZyRy44hvsLanhkkg/zhhJa2VH1nZGeep+cXcR8DZ2Eg77g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=nlvCWuCl;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=pfaCiVk2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.165
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536A6606A33B
	for <linux-can@vger.kernel.org>; Wed, 11 Nov 2026 15:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 536A6606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=nlvCWuCl;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=pfaCiVk2
ARC-Seal: i=1; a=rsa-sha256; t=1794410513; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=C3XGMa81vwpVnjcz+LkLFyenWQUHWW6FT44oc3aZvVXiQQzywRmroNQtr0eKK+iW5j
    F6hI0kfux2JLRtveThywVuvGy7R13RBu5a97dSj9J4Z92Ng2tDNv8pEzHQl3ZTs0d2kR
    nhya+xZwsxHvHs739OJuMg4/61x8tKF8lDbwD6N/WVtQWv3QTghYSWKqS9EY1VCucv7a
    0DuRt1z5ezDpOopRV917p0jj99hY/H5LvqJFAIHh2rEDRCmox9a8uRQlPe7pf5YjflVd
    2y1ja4EOgwaqJMvQIcr5PiZzgU2bl3PaElcqWvPlRyDs1wqgAaXGtpGE3Cn9OnoRsmbd
    HHJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794410513;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=dwL8e8ZYoeRdPXKcUDRoORoiKt+eQzy0KuzmFC2OD1k=;
    b=eWPK1wz/KUI5EniWYIZavBMZ0bkho4a/7ZG42EHixKNGEETLtax5+3r7OhDrrAy9tZ
    cJ8349M/kQKFfZx7J0TEKS1yyAR7BACHqbwpjNhwztq0imawPC81lx1fVBApwK95HkP7
    0GJMgKTRQO+Dza69/kaeonZPT3QLFKJsrN1an9slyTcaQe3xKNkaFazdCMaXcX7XN/aG
    FvA48o8NukwgMUFn1JVwRUOBnPbwCba1OiFwQOkqiAaLdeZgix6jFyZcjHP2oxxHvdfA
    P07R9pTdhqs8U41wMaKFQJF/Ync7QTJPnCameRwTKyfdjzQK7igNeGqfpHBeiQFdl86g
    Y5HA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794410513;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=dwL8e8ZYoeRdPXKcUDRoORoiKt+eQzy0KuzmFC2OD1k=;
    b=nlvCWuClqGeb9rRjLM+xcEKyDg09x+I6QRuJcrmP15XSBMu3DHzcU2rn5rp+Pn4EhM
    cDAq1e7CrAqNCVcfwdBAoKvBFncx3uho2NZepp0iRCaX/n4lvK3+b0xxi8Q/QJSWpV8l
    ACHYglphLmJc8qoCvaBhB3yPIq+N2ACD5wyxturX4Zch3qbSaW3ZbKEM0larZSqWtXyu
    M8x0CyQIiXXUu6G6OZyFyxKzZ95B5yg+tYSjzWSzoNmYcVEKtX0fjstKWHDqup9lhtSQ
    qZ2YNI+Y/gVGfQ5J9l87Zlx9mTEZRxP+3+mx2CYTiAygQqudNn3UJ570nBLhsgjReijr
    9tCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794410513;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=dwL8e8ZYoeRdPXKcUDRoORoiKt+eQzy0KuzmFC2OD1k=;
    b=pfaCiVk2du+X7NYWHasfpOahbyWZEDYu0QG/6OhbleFSMt6UGfuJJ1j8QkQOVtOzpG
    JPIYL7dIdE7VL5BSTjBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2ABFLr9M2
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 11 Nov 2026 16:21:53 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Wed, 11 Nov 2026 16:21:50 +0100
Subject: [PATCH v4 5/6] can: bcm: use a private mutex instead of
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
Message-Id: <20261111-can-bcmlock-memcg-v4-5-5428607a608f@hartkopp.net>
References: <20261111-can-bcmlock-memcg-v4-0-5428607a608f@hartkopp.net>
In-Reply-To: <20261111-can-bcmlock-memcg-v4-0-5428607a608f@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794410512; l=6587;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=NsSTAcCXqug+1NL+zpjagdnrp+Nx8tCOPs7KWC0ZgUg=;
 b=U73E6czs9n2pEbPJJSYAALGGFNmpKC7oquyBM3hkRGCAvodRTLXYD9YaXXeBVyedac246OOce
 sNQJcwWo4l6DWyMgbDlNksFx7IkpZWrgYUGPobgahr4VHDSCD7fYc2e
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

