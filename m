Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.167
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794410516;
	b=ap1zzOpAnGlbjCXsrwTk/VlVrzjuObyoFuxX0n4jH7tL/sx+4lXbHdyJ462jjdpTxH8V
	 ANxMaXPdKvAT2e2BNaEWdFG1/hZIwTWraxA/FOWAq/OGB3q7r3BvBGRqdBqVmho+4Wykm
	 DIPffPNLqakuF59qh2Bln7Mzg0YMqwRSlSGFo8e8esJZKAM/m7SOJnztbijdOSEb6119h
	 a5IDHsPMEGVv0yBaacUFXOrNRW6Q42d+Kf9yjV9qyFbm0sphKpJKFBBnugD5DturYnqBM
	 VLgau9HAX7eYQ1rG+DNkVUYsC8QnxpNVYLGH5pOmxVsB4wS3QSyf5SpT76ECA1HEJjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410516;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=+IeXe643mpc4UBW19N31ISRBCUIz0+7S3Ih2SbPg2f4=;
	b=DBoMTmvCbYoRsZlD4Cr1TpPC1kyQYnJkGlKPj+p6u3jII5TwVBPHCILVdXFpWWoCnesS
	 rgzXcD/CbPmn3V8CO7k2B2QldW4+86MYyY8TdmsqG1jB4h8Xyes1x079We8J2AhDKzHk2
	 smsBF0XPnEmFam2tj5Kazw65UL+oxNBf7PnvjIzuCU4LS0z+4J/b2bNOlXaFatgCGM4nm
	 d37HP9Q6YcGXko5YcEr/nONM/RRQPSPPQKE3AnsxYMcmcTSuC0ZhVz+786lbPhkRu9umC
	 0JvyI2bgn1TwYmxYdLAONuD0JnK3zhz1+KfoonqB79NWjK0tDP9bOgzIEiI4hUSA/PQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=ZczAMqvs;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=4SxZT7SA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.167
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1F3606A337
	for <linux-can@vger.kernel.org>; Wed, 11 Nov 2026 15:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F1F3606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=ZczAMqvs;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=4SxZT7SA
ARC-Seal: i=1; a=rsa-sha256; t=1794410513; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=nI3okDIEwXoG4opGIFZHuBKlv3KN8XDuRMEnX8UT5Ktbk4havAmGbG5+889854r0mk
    /nAGFz5wU6hkSw9MYdRk1QNHFzjoy//fSVPpdj1RUE74fCdMUoWqQQDofAWVvESXUQUe
    5KjiBR/eci+C2UudYUugIl0qZGFjmFRxiheAdrWO8ZsIRfJUvHvT1nmIrWQ0iedGJEnq
    n6+oE7xLw78tgt6z6l/Lfea2fjjlpfEYhA8UUC9ELKEpcf0eXfB6JKF73b4StgDARQLv
    qZ1y8oCMV1YHhVqK5yAHJ5lqnPJe42qGKoZQ0YrWIp8a75udwpip3qxcns+Ot2C/xxMZ
    +lnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794410513;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=+IeXe643mpc4UBW19N31ISRBCUIz0+7S3Ih2SbPg2f4=;
    b=Iu3cLKs9B5qILoclMdC9lPbNScLdjYANvQmDLTFqXEf93GOAxdmxBrRXd29epIjfyv
    PkWyv8BBCIY97v+dfOox2Aeznq4QwUMoLAP3LHS9mL6qb3bk2Pgz1yPWGlqzOHPdDjuO
    iRFOiUnVQTd/t3BDhN9xYkK1XYyLyuFpQfUnpSa2+k165d2gblkimnoqVBT/Y8F9z3Mm
    vAkExbiBk+49owQlzjerWYNTuthbnU3+Wr+8XNYkxJ47+9FM8SKxlBTxpaH8hcJvqnKt
    RhPvZhih6PdvyaC83Tsqdpx6wxqPte97yWR4gUBjr23ehOeqxYHqJkd5uXjfjbna+ILq
    kSaA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794410513;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=+IeXe643mpc4UBW19N31ISRBCUIz0+7S3Ih2SbPg2f4=;
    b=ZczAMqvssa8kXSxoBvtEeuZhhX0PL1pHImxgXrf+iJjqoZYuLl/mb3Pt60h7whumvp
    wGXBoNC7/vCK97Az8M/FkEkMla6VUIh66yo65hV8cEAXkdIeUfDM0B7oM5k2AR/jenUv
    hSMBr3yvgR8S1QjN8hcoOfJw3c0cBosr2oVoUmwY+uVIfidldyQDK2hqv3Ow+eVMUynB
    Oe0H63/p9NNuGwSfza3WqZgVoZ0wHwLiiExv5k1dBotd/+dhPM5X6iDM8pIVCVnsGZup
    LWngnYvMSTTZmMCl4qpfbZpqXtzaO+Fi8x5OY+dBzPatyQhEUVYh2rO1PeW7TVXEdBVJ
    wGfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794410513;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=+IeXe643mpc4UBW19N31ISRBCUIz0+7S3Ih2SbPg2f4=;
    b=4SxZT7SAylabbpo9vIJn1I7MDYKAK+V+hXS+trOGBwVs+vJpfbSOqTn22bb9z+tbgw
    t62NFpU5xKIRrGX3IQDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2ABFLr9M0
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 11 Nov 2026 16:21:53 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Wed, 11 Nov 2026 16:21:48 +0100
Subject: [PATCH v4 3/6] can: raw: use a private mutex instead of
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
Message-Id: <20261111-can-bcmlock-memcg-v4-3-5428607a608f@hartkopp.net>
References: <20261111-can-bcmlock-memcg-v4-0-5428607a608f@hartkopp.net>
In-Reply-To: <20261111-can-bcmlock-memcg-v4-0-5428607a608f@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794410512; l=8564;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=JqfQFZHNkFoEInmhpNI3J21r3qY6KqkLY8nML1NdM1U=;
 b=8IiuUW2HCNzTSav+V/CgXpJoLGRJYsV0oycPCfUQDO4pXpdDPY4G6PHYzQ1NVmaRc9YO1CDMe
 OQkyEaX4RxtD0N9KPUFDRZFsq0w94hVDYmFYzciqgSLZRcdjxS0NLe/
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

Fixes: c18ce101f2e4 ("[CAN]: Add raw protocol")
Cc: stable@vger.kernel.org # depends on "can: raw, isotp: copy socket options outside of lock_sock()"
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/raw.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index f14270b56f52..641661ef4399 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -101,10 +101,11 @@ struct raw_sock {
 	can_err_mask_t err_mask;
 	int count;                 /* number of active filters */
 	struct can_filter dfilter; /* default/single filter */
 	struct can_filter *filter; /* pointer to filter(s) */
 	struct uniqframe __percpu *uniq;
+	struct mutex conf_lock; /* protects bind, filters and sockopts */
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

