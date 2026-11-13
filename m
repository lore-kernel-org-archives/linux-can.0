Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794566003;
	b=URCrqGWYqwQcG6qbwuYr5bFAarigZQt/d1B7gYCUKUoxnhfeJi3T1LZaqgtNx2xjuKqD
	 trelJO5X1AeiEmYfcx7/sScG8D9b35A9dgOdYdQWBOSfks/D/S6xdp4hoQqkFqLpaz5J9
	 kTZnbEBohy+1O8Af8+RYKq3XHPIGR+ocQTpFNI0PGmUFqXHnBkWqlc4QOID6AkrlhcVCM
	 3oRKcYFShPh4y94ld3D8zva8MNaRZrMTW6htSeyjnUciyt41wlCO4GZ5URxfw1byKtxk5
	 FXZNCdXHSxMpxHzhqGX+eyVHAe9JSUAcVkNTiFYlxg1t6U8dyWemNayXT1WBwLv+ynQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566003;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=1FHIHpCaCEVfRZ5BmjJ7+sqJUvjdWXKzuNTsR/pzL0g=;
	b=GF+DQUwBjN+jJoWE8DBDnlZtOTkNoQw+sRu/TgucOIdU60+/4JoEOCuMbzY+ngCOkSgV
	 zaGa0wOWrsFsZfCb1gHEZqkGw0tdltjV80kW9yY3pW5wb7FwI5mYS0JgY0E8oeSz96L1e
	 C+yHvD55t03EdkLgZ+6+I6HoGbNy6o9Q1EHhem2RsnpcLmgw2UnFGvxW7zUKNsZSokWwh
	 6AAz9/F2YwvQ0Wz1fw8svOdZiDdP+EqPHQl+eG7SCI3Lltvu0T5EktjsL5oT6LfaXx2S/
	 /kaDMPxxZECdGnHuCv97zlYKNTcmMbbeKdHmy9M8nMF/7C0gokmd4anj9I6FX0xpkrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=cQ37j9Lu;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=nCKhN1ZR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.50
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D122A606A323
	for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 10:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D122A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=cQ37j9Lu;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=nCKhN1ZR
ARC-Seal: i=1; a=rsa-sha256; t=1794565995; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZyN8Rimc8zxr2n7pg41DZgFjxDmHRbi03H36dBOjwBYD5wsZ3tNlVtVZiud1KHBz8s
    DBvhkU3rK42yIaf1enYm2YAaqg9lyeD8mA8t54M40gHdwK30EKvqqVDVhclCAB1mp56f
    kVMbWms8RV0X8CMfXOlWx6Wz6hxNUce2TaAeZWEypH9jdEBG6DiPIJTWnaZhmnr4vydK
    9CwbAJg4fqR+eKRqp7O3wW6ptuYk1AOlnheikMohTQKsVFRZbM6hsXGxYdHg/VYG3Tcg
    8z4EQWRtZFMOrmJR6XkrfCdGXaKS8t+dsdAgxJ7ESHSeubxYyWORxUs1A6IObwBSi3By
    rqHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794565995;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=1FHIHpCaCEVfRZ5BmjJ7+sqJUvjdWXKzuNTsR/pzL0g=;
    b=ghK1HeroQ8eS99iO+qh2ewB8zGCBzQZ/dLaGWb2Kkoka9PWrBQAopOu7evfOBYDN2R
    G0zuCXrvqz53MxuIBPvMoaw0WT9/euw+laNr24tGIu3IwKKA5ziRG0aM/d/QVH8KDxIM
    1s57g27p+OI1XlcgeSIHWIOGCjJXyf79VU5xQAZrg1cIbGZ8FJ8vIwrjLBl5vvIi82+O
    1Y7qfIrZrZcI55JI9OYqjALzoHMKFkL/bqZtRbvKoHkX0aHle8LbKBX5mhIAy/c0BxGS
    EjR9oCILupiYoEncGI/GH282ogUHCbI/DU4N3rT3+T52mA81ioIs7aajeeq0zLHomuMa
    nmog==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794565995;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=1FHIHpCaCEVfRZ5BmjJ7+sqJUvjdWXKzuNTsR/pzL0g=;
    b=cQ37j9Lu3a6eW8BywGJcFp61SkwyebiUrjC9BNrWEd28X6j3KCi8DMzrzQeBPlcoIB
    LbXuoHiB3uhn7PXlMXPiTahRpTuhRyLVa1yPI0/VRjzugmP5B7bR0wir9O36qoMjiv0r
    QEiepGoWH0GmmFztV0CcQY4QbCJ0s6gVedX+bptaYW5W2F3bIcNZHTtZn6ERZs7lOIBc
    8W4bktTqXXauuq4isveju3erQcwWl+9c2BdVL/zOq59QE2n3bv0e1I3QqZzWE/yw4NNt
    T9ZJ3asAFk8tLXBC+UKiiNVhn8ymfwaQbGPxw/W1YQQUJIKd1XUyCBTAFIVVDb1ZRtTM
    O1Zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794565995;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=1FHIHpCaCEVfRZ5BmjJ7+sqJUvjdWXKzuNTsR/pzL0g=;
    b=nCKhN1ZRKWH87lbCsCDegCg51NVNgiyGWqHW7pORaBrzmlLKoWAsAaCFMwLzRl2je2
    Qa295TF2QsP5ZjDMu4Dw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2ADAXFIs8
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 13 Nov 2026 11:33:15 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Fri, 13 Nov 2026 11:33:10 +0100
Subject: [PATCH v5 3/5] can: raw: use a private mutex instead of
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
Message-Id: <20261113-can-bcmlock-memcg-v5-3-634c0e04bc72@hartkopp.net>
References: <20261113-can-bcmlock-memcg-v5-0-634c0e04bc72@hartkopp.net>
In-Reply-To: <20261113-can-bcmlock-memcg-v5-0-634c0e04bc72@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794565994; l=8881;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=7+rEmCiMAjOMxtXCQ0bFLedvifh5J+j26OvVU1tkb0c=;
 b=hrkfxEydc034zfZJGr80GZNlCCNKP24+BFs4EoTKQA6r7c3k7iVaZarA8zds8yshza1hn2ABY
 i0QthL2iaLZBpUufgPy7A9xybkX0OGpw7NEn15N7Nz8zN0LwAd3OxBc
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

raw_notify() takes lock_sock() of the sockets that are bound to a
vanishing CAN device while holding RTNL. Any path that holds the socket
lock while accessing user space can therefore block RTNL. Since
commit 43c973a0887d ("can: raw, isotp: copy socket options outside of
lock_sock()") the CAN_RAW specific socket options copy their values
outside of the socket lock, but the generic SOL_SOCKET options in
sk_setsockopt() and sk_getsockopt() still access user space under
sockopt_lock_sock(), e.g. for SO_ATTACH_FILTER, SO_LINGER or SO_TXTIME.
A stalled copy, e.g. on a FUSE backed mapping, then blocks raw_notify()
and RTNL on the unregistration or namespace change of the bound CAN
device.

CAN_RAW only uses lock_sock() to serialize its own state: the binding,
the filters and the CAN_RAW socket options. It does not use the socket
backlog, as raw_rcv() queues the frames directly to the socket.

Replace lock_sock() with the mutex conf_lock in struct raw_sock. The
generic socket options do not take this mutex, so they can not block
raw_notify() anymore. No user space access happens while the mutex is
held. The memory allocations for the CAN receivers in can_rx_register()
are still done under the mutex, as they have been under lock_sock()
before.

Sashiko suggested to hold not only the filter copy in raw_getsockopt()
under the new conf_lock mutex but to also protect ro->raw_vcid_opts.
This change will be addressed in a follow-up patch as it goes beyond a
simple lock replacement intended for stable.

Fixes: c18ce101f2e4 ("[CAN]: Add raw protocol")
Cc: stable@vger.kernel.org # depends on "can: raw, isotp: copy socket options outside of lock_sock()"
Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/raw.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index f14270b56f52..b69eaadc5e93 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -101,10 +101,11 @@ struct raw_sock {
 	can_err_mask_t err_mask;
 	int count;                 /* number of active filters */
 	struct can_filter dfilter; /* default/single filter */
 	struct can_filter *filter; /* pointer to filter(s) */
 	struct uniqframe __percpu *uniq;
+	struct mutex conf_lock; /* protects bind, filters and setsockopt */
 };
 
 static LIST_HEAD(raw_notifier_list);
 static DEFINE_SPINLOCK(raw_notifier_lock);
 static struct raw_sock *raw_busy_notifier;
@@ -317,22 +318,22 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
 	if (msg == NETDEV_DOWN)
 		smp_mb(); /* IFF_UP is cleared before, pairs with raw_bind() */
 
 	/* Lockless fast path, ro->bind_dev covers a concurrent bind().
 	 * Read it before ro->dev, pairs with smp_store_release() in
-	 * raw_bind(). A stale ro->bind_dev only costs a lock_sock().
+	 * raw_bind(). A stale ro->bind_dev only costs a mutex_lock().
 	 */
 	bind_dev = smp_load_acquire(&ro->bind_dev);
 	if (READ_ONCE(ro->dev) != dev &&
 	    (msg != NETDEV_UNREGISTER || bind_dev != dev))
 		return;
 
 	switch (msg) {
 	case NETDEV_UNREGISTER:
-		lock_sock(sk);
+		mutex_lock(&ro->conf_lock);
 		if (ro->dev != dev) {
-			release_sock(sk);
+			mutex_unlock(&ro->conf_lock);
 			break;
 		}
 
 		/* remove current filters & unregister */
 		if (ro->bound) {
@@ -349,11 +350,11 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
 		ro->count = 0;
 
 		sk->sk_err = ENODEV;
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
-		release_sock(sk);
+		mutex_unlock(&ro->conf_lock);
 		break;
 
 	case NETDEV_DOWN:
 		sk->sk_err = ENETDOWN;
 		if (!sock_flag(sk, SOCK_DEAD))
@@ -399,10 +400,11 @@ static int raw_init(struct sock *sk)
 
 	ro->bound            = 0;
 	ro->ifindex          = 0;
 	ro->dev              = NULL;
 	ro->bind_dev         = NULL;
+	mutex_init(&ro->conf_lock);
 
 	/* set default filter to single entry dfilter */
 	ro->dfilter.can_id   = 0;
 	ro->dfilter.can_mask = MASK_ALL;
 	ro->filter           = &ro->dfilter;
@@ -449,11 +451,11 @@ static int raw_release(struct socket *sock)
 		spin_lock(&raw_notifier_lock);
 	}
 	list_del(&ro->notifier);
 	spin_unlock(&raw_notifier_lock);
 
-	lock_sock(sk);
+	mutex_lock(&ro->conf_lock);
 
 	/* remove current filters & unregister
 	 * the tracked reference ro->dev keeps the device's receive lists
 	 * accessible, even after a namespace change
 	 */
@@ -472,15 +474,15 @@ static int raw_release(struct socket *sock)
 	ro->ifindex = 0;
 	ro->bound = 0;
 	ro->dev = NULL;
 	ro->count = 0;
 
+	mutex_unlock(&ro->conf_lock);
+
 	sock_orphan(sk);
 	sock->sk = NULL;
 
-	release_sock(sk);
-
 	sock_prot_inuse_add(net, sk->sk_prot, -1);
 	sock_put(sk);
 
 	return 0;
 }
@@ -498,12 +500,12 @@ static int raw_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len
 	if (len < RAW_MIN_NAMELEN)
 		return -EINVAL;
 	if (addr->can_family != AF_CAN)
 		return -EINVAL;
 
-	/* lock_sock() serializes the binding with raw_notify() */
-	lock_sock(sk);
+	/* ro->conf_lock serializes the binding with raw_notify() */
+	mutex_lock(&ro->conf_lock);
 
 	if (ro->bound && addr->can_ifindex == ro->ifindex)
 		goto out;
 
 	if (addr->can_ifindex) {
@@ -579,11 +581,11 @@ static int raw_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len
 		sk->sk_err = ENETDOWN;
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
 	}
 
-	release_sock(sk);
+	mutex_unlock(&ro->conf_lock);
 
 	return err;
 }
 
 static int raw_getname(struct socket *sock, struct sockaddr *uaddr,
@@ -619,11 +621,11 @@ static int raw_setsockopt_locked(struct socket *sock, int optname,
 		/* @filter has been copied by raw_setsockopt(). It is linked
 		 * to the socket on success and freed by the caller on error.
 		 *
 		 * The reg_state check is only a shortcut: On a concurrent
 		 * unregistration or namespace change raw_notify() waits for
-		 * lock_sock() and removes the filters set here.
+		 * ro->conf_lock and removes the filters set here.
 		 */
 		dev = ro->dev;
 		if (ro->bound && dev &&
 		    READ_ONCE(dev->reg_state) != NETREG_REGISTERED)
 			return -ENODEV;
@@ -728,10 +730,11 @@ static int raw_setsockopt_locked(struct socket *sock, int optname,
 
 static int raw_setsockopt(struct socket *sock, int level, int optname,
 			  sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
+	struct raw_sock *ro = raw_sk(sk);
 	struct can_filter *filter = NULL;  /* dyn. alloc'ed filters */
 	struct can_filter sfilter;         /* single filter */
 	union {
 		can_err_mask_t err_mask;
 		int flag;
@@ -742,13 +745,13 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 	int err;
 
 	if (level != SOL_CAN_RAW)
 		return -EINVAL;
 
-	/* Copy the option values from user space before lock_sock(), so a
-	 * stalled copy can not block raw_notify() waiting for lock_sock()
-	 * under RTNL.
+	/* Copy the option values from user space before taking ro->conf_lock,
+	 * so a stalled copy can not block raw_notify() waiting for
+	 * ro->conf_lock under RTNL.
 	 */
 	switch (optname) {
 	case CAN_RAW_FILTER:
 		if (optlen % sizeof(struct can_filter) != 0)
 			return -EINVAL;
@@ -796,15 +799,15 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 
 		if (copy_from_sockptr(&val, optval, size))
 			return -EFAULT;
 	}
 
-	lock_sock(sk);
+	mutex_lock(&ro->conf_lock);
 
 	err = raw_setsockopt_locked(sock, optname, &val, filter, count);
 
-	release_sock(sk);
+	mutex_unlock(&ro->conf_lock);
 
 	/* on error free the filters allocated for CAN_RAW_FILTER above */
 	if (err && count > 1)
 		kfree(filter);
 
@@ -829,11 +832,11 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 	switch (optname) {
 	case CAN_RAW_FILTER: {
 		struct can_filter *filter = NULL;
 		int err = 0;
 
-		lock_sock(sk);
+		mutex_lock(&ro->conf_lock);
 		if (ro->count > 0) {
 			int fsize = ro->count * sizeof(struct can_filter);
 
 			/* user space buffer to small for filter list? */
 			if (len < fsize) {
@@ -841,19 +844,19 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 				err = -ERANGE;
 				opt->optlen = fsize;
 			} else {
 				if (len > fsize)
 					len = fsize;
-				/* copy to user space after release_sock() */
+				/* copy to user space after mutex_unlock() */
 				filter = kmemdup(ro->filter, len, GFP_KERNEL);
 				if (!filter)
 					err = -ENOMEM;
 			}
 		} else {
 			len = 0;
 		}
-		release_sock(sk);
+		mutex_unlock(&ro->conf_lock);
 
 		if (filter) {
 			if (copy_to_iter(filter, len, &opt->iter_out) != len)
 				err = -EFAULT;
 			kfree(filter);

-- 
2.53.0

