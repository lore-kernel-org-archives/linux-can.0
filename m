Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794410521;
	b=bEoYI+7UNF90CKhUldrKf4oY4ii4TWtp0Gd4MTC0fy7tDRN49HYRKUnqJrq1ElWfqaYn
	 JwirikChJMpWqREZMm8QbHuvjQoF2C8WRlSHlgnPCD4e/ot1Be6s8XACmbW5G87CTjHKQ
	 YjztjkQqFWqOF8mfUEYuI2aUmZRhnssxfajRqvGA4svjwuHT4NeMYLyhASjcDTwfMqFfb
	 PwPG225SngwUlOgvbHKGFNBM6voOZMH3+ekBmmwBRVjPWeHWJSRCkoWiRSYWI5aO2ALIb
	 EeoAjfQMmsOvjnxxG0YNssWlSxMalTJiB1UZ0nBYKM0xrJ11536OHi0ASTY7bWEUkmQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410521;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ah+OEFaDvIjHwZYIq4QSkPNsMpOX6LYJXSbTwfDpjqU=;
	b=dHARzhZNebmvZTK0aSBbQaBNwZfkKyA1RwCXvLJTwNiMm8OYFF4XPmgMvbLMH5T++vJe
	 Jo2NmFyfEytBDgK0K22J24Wp9GYxC3tbSvSSQ7ANviq5HtXV/JCG3fXd13QpQM4B62Swe
	 Gw9huAQy12qVk6ZfRGUs/YmeD55A0psZ5oATQO3kS/DEf15ShsG5e7SOJB+M5k7a5W+wL
	 H/HqlNEPDqWw4oKtV2RjvdIkQhtLNlnO9LWAPPQWpAAxh6Q9RPBlDdjjSkV6VZOspUroV
	 fPryQuRqZUlqxhUh7EIeu+yUjDdfdmN2+pgGEGBsnsCgduP/j6xdrrpaNPNMAoZGt0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=lSH2IIrP;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=I4bztVGz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.52
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CB5606A32E
	for <linux-can@vger.kernel.org>; Wed, 11 Nov 2026 15:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3CB5606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=lSH2IIrP;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=I4bztVGz
ARC-Seal: i=1; a=rsa-sha256; t=1794410513; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LasUjR302O1gyrLk1Iy77HTfJr9bwG1hf9iMGyXrlTVITC2o5djMic6+2MMG7wUsdx
    x81fHQ83Z7xDD3ENk78xi2XgqgSLpoSlOuXON9boR/cNV72FNowlSaFWi9rO+muDkP5Q
    GmIMRE662Owl+9HNwtjWjRGxBx1JoDq9LIDUMHjyyhLJMhXxGt5YxQU/IMpuz6QwGdB/
    IlQkXAPwhirdBgljYnZVAe0dnLNNtpaB5m4suQ6mkKEEFqF87ZcS+9FBoC8lN5yWsChI
    q64iNDu0Sg/bCU9L63FCUDH5pNd/jivhsIGzwxfXf9Otm257Zx9vibAHi/Yj2ixPIafb
    2nvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794410513;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=ah+OEFaDvIjHwZYIq4QSkPNsMpOX6LYJXSbTwfDpjqU=;
    b=j9iSIikOw96H0iCXMbCKSKZG9af8ipbOOQPVBXF5ySq8qjdXg1D5wZvhwch61VyKFL
    BwyJj3hTzhCGyT+EbHSZ4hGT3jrgaiERiRWdCxrVK0mOSva3nWiKemoT8gasSHNmW+Ka
    Tzlaj5jNQiE3jtVMEmVAb/pkac32rz0D/Zbfn1GtKYzFDnykyX3PPFCfNN8S1z+7Gkne
    1DG8O/P1099LaH+wUT6dCSjcRELqsjXDtF2nSZMm71yqJoUL+rfFlk/cWaIGdWHGY08W
    Z52JYJwIQ2aEz5EO/kA1OKvGcMKFgrFvN5oc0lFDrN7TPoh17bHOUDNik0dSU2bSPrAH
    omng==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794410513;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=ah+OEFaDvIjHwZYIq4QSkPNsMpOX6LYJXSbTwfDpjqU=;
    b=lSH2IIrP1yYE+yVOVobVjgPA3k9pq7SydXlPOoCvpuO5n9Tzh/J6XGddeuCVjkNHgJ
    I74r75yd3JC38jgmzzDfSSX6fGqwEC0rZ03l6QfgaZx6CUmjkpfnxBH0FIpD4CiXpAbk
    eiZLypoXqKhneDTkXuCEl5BuGO1zaHFLsnpgytMkC6RZHMmvlM0eXLmaEPXEUrXKl/rl
    RJjyGf/e/JypPToszknxfpv+JQ1xnFKXnUwgb7X7lqS5dIZzZfCgRHVyvi6QbQuj1jMG
    sTEIHsIYR7DsCw+m9oGAH9bOlYo88OU+XYCPgp2tuTzEtsoop6tgPqtgxznKIYCvgajh
    B+Pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794410513;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=ah+OEFaDvIjHwZYIq4QSkPNsMpOX6LYJXSbTwfDpjqU=;
    b=I4bztVGzjVNruAZDoXJcP9mu2QPG3/k5IWLJsJmMXWs+YbRkoVnsGz/Yj6zUA8hOgS
    pdyr4koa3LyJCseXj7Bw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2ABFLr9M1
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 11 Nov 2026 16:21:53 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Wed, 11 Nov 2026 16:21:49 +0100
Subject: [PATCH v4 4/6] can: isotp: use a private mutex instead of
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
Message-Id: <20261111-can-bcmlock-memcg-v4-4-5428607a608f@hartkopp.net>
References: <20261111-can-bcmlock-memcg-v4-0-5428607a608f@hartkopp.net>
In-Reply-To: <20261111-can-bcmlock-memcg-v4-0-5428607a608f@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794410512; l=7209;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=lI7cqEfAf7weN6arHhuFlxiK0Jc0AXCIRYAejejQ5r4=;
 b=GBGJ1M1wXJr9zfNfsaPVRFAhjPbqBzFiqI1zX2dk/6StVNC6F0XZo+N7J3hxdGUcL7bWbSL/Z
 TdexQrAasaYDBhfCRyKs9rhTkvpQpRHeucuINLjuBQMQxVWGNGrx/uh
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

isotp_notify() takes lock_sock() of a socket that is bound to a
vanishing CAN device while holding RTNL. Any path that holds the socket
lock while accessing user space can therefore block RTNL. Since
commit 43c973a0887d ("can: raw, isotp: copy socket options outside of
lock_sock()") the CAN_RAW specific socket options copy their values
outside of the socket lock, but the generic SOL_SOCKET options in
sk_setsockopt() and sk_getsockopt() still access user space under
sockopt_lock_sock(), e.g. for SO_ATTACH_FILTER, SO_LINGER or SO_TXTIME.

CAN_ISOTP only uses lock_sock() to serialize the binding and the
CAN_ISOTP socket options. It does not use the socket backlog, as the
received PDUs are queued directly to the socket.

Replace lock_sock() with the mutex conf_lock in struct isotp_sock. The
generic socket options do not take this mutex, so they can not block
isotp_notify() anymore. No user space access happens while the mutex is
held. The memory allocations for the CAN receivers in isotp_bind() are
still done under the mutex, as they have been under lock_sock() before.
isotp_release() drops the mutex before synchronize_rcu() and the
hrtimer cancellation, as the socket has already left the notifier list
at this point.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Cc: stable@vger.kernel.org # depends on "can: raw, isotp: copy socket options outside of lock_sock()"
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 7a90ba3f1cf1..50a3f4cd2b31 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -180,10 +180,11 @@ struct isotp_sock {
 	u32 tx_result[ISOTP_TX_RESULT_SLOTS]; /* per-generation result slots */
 	struct tpcon rx, tx;
 	struct list_head notifier;
 	wait_queue_head_t wait;
 	spinlock_t rx_lock; /* protect single thread state machine */
+	struct mutex conf_lock; /* protects bind and sockopts */
 };
 
 static LIST_HEAD(isotp_notifier_list);
 static DEFINE_SPINLOCK(isotp_notifier_lock);
 static struct isotp_sock *isotp_busy_notifier;
@@ -1495,11 +1496,11 @@ static int isotp_release(struct socket *sock)
 		spin_lock(&isotp_notifier_lock);
 	}
 	list_del(&so->notifier);
 	spin_unlock(&isotp_notifier_lock);
 
-	lock_sock(sk);
+	mutex_lock(&so->conf_lock);
 
 	/* remove current filters & unregister
 	 * the tracked reference so->dev keeps the device's receive lists
 	 * accessible, even after a namespace change
 	 */
@@ -1517,10 +1518,12 @@ static int isotp_release(struct socket *sock)
 
 	so->ifindex = 0;
 	WRITE_ONCE(so->bound, 0);
 	so->dev = NULL;
 
+	mutex_unlock(&so->conf_lock);
+
 	/* Always wait for a grace period before touching the timers below.
 	 * A concurrent NETDEV_UNREGISTER may have already unregistered our
 	 * filters and cleared so->bound in isotp_notify() without waiting
 	 * for in-flight isotp_rcv() callers to finish, so this call must not
 	 * be skipped just because so->bound is already 0 here.
@@ -1533,11 +1536,10 @@ static int isotp_release(struct socket *sock)
 	hrtimer_cancel(&so->rxtimer);
 
 	sock_orphan(sk);
 	sock->sk = NULL;
 
-	release_sock(sk);
 	sock_prot_inuse_add(net, sk->sk_prot, -1);
 	sock_put(sk);
 
 	return 0;
 }
@@ -1583,22 +1585,22 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 	}
 
 	if (!addr->can_ifindex)
 		return -ENODEV;
 
-	/* lock_sock() serializes the binding with isotp_notify() */
-	lock_sock(sk);
+	/* so->conf_lock serializes the binding with isotp_notify() */
+	mutex_lock(&so->conf_lock);
 
 	if (so->bound) {
 		err = -EINVAL;
 		goto out;
 	}
 
 	/* A transmission or reception that outlived a previous binding
 	 * (unbound by NETDEV_UNREGISTER) may still be draining; the FC/echo
 	 * and RX watchdog timers bound how long this takes. Checked together
-	 * with so->bound in the same lock_sock() section above, so there is
+	 * with so->bound in the same so->conf_lock section above, so there is
 	 * no window in which a concurrent isotp_notify() could be missed.
 	 */
 	if (READ_ONCE(so->tx.state) != ISOTP_IDLE ||
 	    READ_ONCE(so->rx.state) != ISOTP_IDLE) {
 		err = -EAGAIN;
@@ -1684,11 +1686,11 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 		sk->sk_err = ENETDOWN;
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
 	}
 
-	release_sock(sk);
+	mutex_unlock(&so->conf_lock);
 
 	return err;
 }
 
 static int isotp_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
@@ -1788,10 +1790,11 @@ static int isotp_setsockopt_locked(struct socket *sock, int optname,
 static int isotp_setsockopt(struct socket *sock, int level, int optname,
 			    sockptr_t optval, unsigned int optlen)
 
 {
 	struct sock *sk = sock->sk;
+	struct isotp_sock *so = isotp_sk(sk);
 	union {
 		struct can_isotp_options opt;
 		struct can_isotp_fc_options rxfc;
 		struct can_isotp_ll_options ll;
 		u32 stmin;
@@ -1800,11 +1803,11 @@ static int isotp_setsockopt(struct socket *sock, int level, int optname,
 	int ret;
 
 	if (level != SOL_CAN_ISOTP)
 		return -EINVAL;
 
-	/* copy the option values from user space before lock_sock() */
+	/* copy the option values from user space before taking so->conf_lock */
 	switch (optname) {
 	case CAN_ISOTP_OPTS:
 		size = sizeof(val.opt);
 		break;
 
@@ -1829,13 +1832,13 @@ static int isotp_setsockopt(struct socket *sock, int level, int optname,
 		return -EINVAL;
 
 	if (copy_from_sockptr(&val, optval, size))
 		return -EFAULT;
 
-	lock_sock(sk);
+	mutex_lock(&so->conf_lock);
 	ret = isotp_setsockopt_locked(sock, optname, &val);
-	release_sock(sk);
+	mutex_unlock(&so->conf_lock);
 	return ret;
 }
 
 static int isotp_getsockopt(struct socket *sock, int level, int optname,
 			    char __user *optval, int __user *optlen)
@@ -1904,13 +1907,13 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 	if (READ_ONCE(so->dev) != dev)
 		return;
 
 	switch (msg) {
 	case NETDEV_UNREGISTER:
-		lock_sock(sk);
+		mutex_lock(&so->conf_lock);
 		if (so->dev != dev) {
-			release_sock(sk);
+			mutex_unlock(&so->conf_lock);
 			break;
 		}
 
 		/* remove current filters & unregister */
 		if (so->bound) {
@@ -1930,11 +1933,11 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 		WRITE_ONCE(so->dev, NULL);
 
 		sk->sk_err = ENODEV;
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
-		release_sock(sk);
+		mutex_unlock(&so->conf_lock);
 		break;
 
 	case NETDEV_DOWN:
 		if (!READ_ONCE(so->bound))
 			break;
@@ -1989,10 +1992,11 @@ static int isotp_init(struct sock *sk)
 	struct isotp_sock *so = isotp_sk(sk);
 
 	so->ifindex = 0;
 	so->bound = 0;
 	so->dev = NULL;
+	mutex_init(&so->conf_lock);
 
 	so->opt.flags = CAN_ISOTP_DEFAULT_FLAGS;
 	so->opt.ext_address = CAN_ISOTP_DEFAULT_EXT_ADDRESS;
 	so->opt.rx_ext_address = CAN_ISOTP_DEFAULT_EXT_ADDRESS;
 	so->opt.rxpad_content = CAN_ISOTP_DEFAULT_PAD_CONTENT;

-- 
2.53.0

