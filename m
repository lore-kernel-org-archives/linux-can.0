Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795174154;
	b=PShOWtOyW8oKR51SyOlNLsDw/ctdJTg9y7nTRoNOzQL+D1/V08H1meZFV07If394ct5B
	 /8rYBwkMyBiiRvE8SfFHcTJKiXycfSjmaAc2BWpENTZh2jtVEMT2r/cqu+ifb3odtROJd
	 TiU46Au5SZFsWkaC8B8yTdlehUpktDA5J7y+VE/RxvoyfyGLJtWZrFGaf9LAID8kgWxuv
	 w/3p1mvmmqRxeBFS91M1jIQPOy33dvtb00sH/T13nDp50MuX2XeQmjr4ZQSSYSyCZSx0k
	 OGjGO7hTXlYIu11Fzlo+czni4hYqFq8j1I0ASPOO0VihGjy9xwZ/+/yqJlCWaM98oMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795174154;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=OVNJRys4IbYiVLSXOzekP0iB0XhruBTmVGSFYU5kl/M=;
	b=njU1HXM8XqC5O9XbAEHzb9kBvRlq7iMHrP5ckL2U0FBexw8ctzZ11BgyU8wMNfi1+ovc
	 3uszNSZO3Nhjg2ijaP/wzs/WP8cm+WdZ97wiAISDxktmluNYZ9uYtI6P6JfZAz34/ePuv
	 lcKTEjFNW3R+VAK3wLrOVmZZVCKkRkQLDC3u4hzcMNDi9Q3b/aM5fBDWx8RZmXTjCEg9V
	 Ho7FGaYUUXaftdeWVVRvCJn14Zh+5+rqHziK2Jl/LOkMYVtthEx5SK8TrnRq1z5ptyErB
	 bTpmnuuFRqcLhgsfA+q3CpVGc/TV6ReV23XUD/pZ5DYwPHFin6v5RM7Ug+y2T7PEqMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=aLjO6N3h;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Y84OlPT5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.170
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C64606A339
	for <linux-can@vger.kernel.org>; Fri, 20 Nov 2026 11:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9C64606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=aLjO6N3h;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Y84OlPT5
ARC-Seal: i=1; a=rsa-sha256; t=1795174142; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pJR7wUJtH4AAgch/4LC05S6HPcAiy7jD7dfLCnfM7+4SqUJX8IPb9ou5Fl6cjMeCCI
    qrnIKYuPMQheyO3JYDuCLikEtGsBzm4b0ddw3NBV907+miaQ4krgr+THFzlpih4MFNtZ
    AlrrugPRc5D1bv6+TzBN7tzkUE8hyo9Mizd3nKt2MdGQrNNum/QaWaoP+K2mGoM0ZQ85
    w2HQ+wo3W1Y04l8G4yKhFL2Q6BAmx0UT6eTijMuBofaD3jmMAvrR7LYoClR8KN8Mfe9o
    3CIk2qOZf5bNNX1O9cd0XRgMJFdm3LkYotOdnYKO8qrmbrPrde2hF69Dc/Ie8eObuLmh
    yIlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795174142;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=OVNJRys4IbYiVLSXOzekP0iB0XhruBTmVGSFYU5kl/M=;
    b=gAK2so8NXdcpDKkZEI0tRA05AfCNpRS1ErY9LPfdokRmfgvMS6EKEEfnMiOFfsh5i1
    KXL/gLFR6hvr/8m2iSQIKFtcQQ8XUOOVlbyZwy4YSVpkS6TLjgivMaK5y0c61KZaCBiS
    dYE4aR5/oVJ9Iu1s/EF48VlSge02z++qCuUEXaRrbfVk/QeoZcOssQrmveXAkIpeYM5U
    xVreDJWIOr2b6I6pyAXb8oxPRiKlA/zK5yHnF4jHyltaAGKzMcU8kyzcZc2diZ5ENSM0
    spFPmDFNLvUD75T6hyG5NmaDgZkRNMrIGonJXfcO5QQ+3VgTVmnS5Dql4iwYFOffqktg
    g8ng==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795174142;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=OVNJRys4IbYiVLSXOzekP0iB0XhruBTmVGSFYU5kl/M=;
    b=aLjO6N3hbzN8raKpKhm9j1prklcKuarzVcT9xznTFYVpErQDE5KDnrUoPuz/5MbK+n
    H2pQNYgPD2jKJ6wKyuw7j8zCBH2FEh/yf1BNA72wzqtsz1SGM0mDNT6wEp1NmgrxgK5U
    noXU99ipXUVWn79GJtpLzq0pJ1UYqnsEmhpnq6GyddPbMVTSbDLNhXqa+SmsG1hpSbSn
    MApgCi/qo1PXEhOREp325kdyBWqhsajqpUDGSsLHgPUWN6zwO8aOnCDXYZxg8HCqdfPC
    bLUv/YeEZmJvgbMjEMp5PMjL06ArEtUgKlqraR+NCiiK7J918FNpzh79YRmmdNewdtEL
    XP2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795174142;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=OVNJRys4IbYiVLSXOzekP0iB0XhruBTmVGSFYU5kl/M=;
    b=Y84OlPT5PFI4mlxBi+1+mMPzpm2jjo0KWEoXBAtf2RLAv7pxWOHiYSKOLfqwBSGleP
    cJX25OfBAQ+/Sc3GIABw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AKBT2QMA
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 20 Nov 2026 12:29:02 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Fri, 20 Nov 2026 12:28:58 +0100
Subject: [PATCH v7 4/8] can: isotp: use a private mutex instead of
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
Message-Id: <20261120-can-bcmlock-memcg-v7-4-f6b84f5257b1@hartkopp.net>
References: <20261120-can-bcmlock-memcg-v7-0-f6b84f5257b1@hartkopp.net>
In-Reply-To: <20261120-can-bcmlock-memcg-v7-0-f6b84f5257b1@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Zhu Ling <zhuling0805@qq.com>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795174141; l=7524;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=LzREcHis030hMdIGjsMovZQZPfS+OgBmYjMlE+yThHg=;
 b=eywapPKWFLeFXIVIj4bnuXttFnOIwmC9bnaaFJLqt6VBSKWMcxyQlQxsMGr/6x9Krj3/jX550
 o11Vx1FrO1AB+0+bjRXuzL0a2aMnP8VXcPJM8+zHPuCsk6nUQurydCy
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

isotp_notify() takes lock_sock() of a socket that is bound to a
vanishing CAN device while holding RTNL. Any path that holds the socket
lock while accessing user space can therefore block RTNL. Since
commit 43c973a0887d ("can: raw, isotp: copy socket options outside of
lock_sock()") the CAN_ISOTP specific socket options copy their values
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

Following a Sashiko feedback for raw.c it would make sense to copy the
content in isotp_getsockopt() under the new conf_lock mutex too.
This change will be addressed in a follow-up patch as it goes beyond a
simple lock replacement intended for stable.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Cc: stable@vger.kernel.org # depends on "can: raw, isotp: copy socket options outside of lock_sock()"
Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 7a90ba3f1cf1..8229b6a69ecd 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -180,10 +180,11 @@ struct isotp_sock {
 	u32 tx_result[ISOTP_TX_RESULT_SLOTS]; /* per-generation result slots */
 	struct tpcon rx, tx;
 	struct list_head notifier;
 	wait_queue_head_t wait;
 	spinlock_t rx_lock; /* protect single thread state machine */
+	struct mutex conf_lock; /* protects bind and setsockopt */
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

