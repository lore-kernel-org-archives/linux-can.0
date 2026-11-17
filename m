Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.81
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794933358;
	b=1ffpoBVt7QNjMi1qF1r5X8lQEI8vai0wLG8xv8abM7cm6JS/BEApHGSJk0FRNi8pWYAC
	 +4WGWZqIw3yTT30/0jsQtfV+ZzHh9qwnoOCcOCTpymeSKCurvlJ32MsmZBOIMTzYEnMly
	 yP+JGW8ohDs5mtAw0TY3/XQ8KUt1GSLkkj8rxPuzy3k3cL6x5e6iPbmn1jNjV+cG0Gazq
	 rJfqfXVWt3TsV0FFsJHoaRrQOAWYWxMZcM+QDN/mj4TGWJxKxUNhUEgeoTvgVSAKg0hoJ
	 wAHGyzw9nw1qjiep/7M5vrehdGz6nUBMcLzhmKJU+9gY85tlLloOcw71Ip2A+mxDyvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933358;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=1FHIHpCaCEVfRZ5BmjJ7+sqJUvjdWXKzuNTsR/pzL0g=;
	b=X4ILEhm9MkH1UGo+Ax2bR4l4/eE9d+Gt9ACs8gztvFveLkiFXR/cSl2EcSpqxp53/jBZ
	 hNPHVfHhqyW6tgucsrJaM4opSeXcoqkw8DoZn9TPCkn3GRsQXzhdhvg1fmVN8qAmmQLJr
	 lL2P+svZC45z3b0MXmkSrSJRqHxjO4ziBlFmprWjhSMyDLKvHIhBwwzsN+MOeELazPCkp
	 upH6qZDpHx0boDMC9y4paliDmrp3EtFlZQem4PIcocMjGtHixYxrbmVJcLy3rebVVto95
	 1BO/czyaGQehgqy40aGmVsCkJ7Nr1Q9+9TIasP5UXjhgpDCHrhx9M9iKkJYllwXkOHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=bEnKzDkS;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=qxrawUWu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.81
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA30D606A32C
	for <linux-can@vger.kernel.org>; Tue, 17 Nov 2026 16:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA30D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=bEnKzDkS;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=qxrawUWu
ARC-Seal: i=1; a=rsa-sha256; t=1794933348; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kLk7mEjQqg/XQdX+evhr/pihvwvbPf0Luof3YEJUcgG2OEIs5GDzl1EM3kGuqBAjMV
    N/R58gEwVsInxgqVHA1x01+DaRt5OYUabac0P6v+1BuH/kUUx45aALzafB4ru1PNy7Zv
    y+JFYW7e5OAduHeG8Ox/4IhWWYuxY5Pzw5lI9yge9lZ9dKK5RaeKVM3uhr+EDog531BZ
    AOWmWioMfdoDeldgAtU3OKbzK2biptZkSFaa512M1fG7LRYestdY030Dqi+6SrFdwtBD
    yIPxRLRXWbD7nYlunGHr5xe66tQ1ce0mMw0bF8Qygobz5F/6w8yvCuACiaTVmd+iAQBm
    bBTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794933348;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=1FHIHpCaCEVfRZ5BmjJ7+sqJUvjdWXKzuNTsR/pzL0g=;
    b=JtDlRukh/PWFXv9uMz5g5An43WmNIzvcx1z3ShmkMAYYQQXpb6lLftNEcrSjkh38o4
    HEnzwvjkxKj6PIeKh3pvW5nCOBXnDkO9P7IJpfq4Bouz89fzsb4RCRCCl8ipPluC2vIZ
    4g9PRuqowYdNlYCS6qtBBtoE2MXHi2JOL2FLPpADmX2PGCsHs8gEo6LOwmNTmnUs8zyN
    wi2lxs42gEjSCDsTSmDZGRAk6/4UwqWdgcvVp8QRCbz6gyjaRv92GZuo7WHbL86+icQh
    lp/AWV2dxhkkpvwnmmQq6S+aOuTYdu2jSF24aayMagupgaZR5BU5cgNkrBjUWzxI8BYx
    57yg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794933348;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=1FHIHpCaCEVfRZ5BmjJ7+sqJUvjdWXKzuNTsR/pzL0g=;
    b=bEnKzDkSS+4bXl0/PI6kXEcVj76780kz7roM4nEfEZZc08fs8ollyVruZqkvwM3tM5
    rccXhUxkorLzcyuK6Y1kMYbZ6RKZPczQ9hivHFA3gcr1lInJLp3Ct10qpfuFkTG0W29L
    yMcc8pd/GagKwLiJVXPGRRkE+TjnHBzciehAWE4HwK2I0ZkUh1RaUzP14T8jaBQw1Jvg
    ZZxzctgQijT/jS2LW/wuLoAOZ2x+SsqwrAyJUNWk0IoqNz5rinU+jr2u/DaxlI6BiysF
    fzrx5Hfn3Ab1e/AfWB+AfIX4sNRiEjekwC9ZJzxgL4vSWwLmMJw40S5lbSuri6TIc5qg
    pi8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794933348;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=1FHIHpCaCEVfRZ5BmjJ7+sqJUvjdWXKzuNTsR/pzL0g=;
    b=qxrawUWuzvgzWKjh29UJqNF/lRaDX6xZg5pLKl/ZiJZzIBWFdf5S+w1/Ba7layKgrc
    mrPXCismStAkO01p49BQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AHGZmceZ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 17 Nov 2026 17:35:48 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Tue, 17 Nov 2026 17:35:44 +0100
Subject: [PATCH v6 3/8] can: raw: use a private mutex instead of
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
Message-Id: <20261117-can-bcmlock-memcg-v6-3-6826a6227d36@hartkopp.net>
References: <20261117-can-bcmlock-memcg-v6-0-6826a6227d36@hartkopp.net>
In-Reply-To: <20261117-can-bcmlock-memcg-v6-0-6826a6227d36@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Zhu Ling <zhuling0805@qq.com>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794933347; l=8881;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=7+rEmCiMAjOMxtXCQ0bFLedvifh5J+j26OvVU1tkb0c=;
 b=XPRmw4ixSMVXBpqls3J3LmbwmeXlI0/A6Zo14N88PpJC94IkPaR+30brUk3v/rUp4V+MLBWVW
 y2HG1Raw1DgBP6CDSs7FXxLlFBmLgB/vZuC1FAae7SALS3pn5ejuJKh
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

