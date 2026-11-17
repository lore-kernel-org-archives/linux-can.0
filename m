Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794933364;
	b=McDPEOrDmuqvDxo7lYESxPuSFCaXw6k982apgJp6tsGAEg1ibRl6j5C6br4WeJf6Go/h
	 rluw9ehAWaBc5Owl6VLiMrTnd6dIH1Uz3KOIEhgNCGjhiRjEmBcMn/ozo0tYmfL6WZjnq
	 qMRUoLS8OayEfJRrehi2Pxje9pTYbRiOHQjTCyRoQN3aQbTbf+yDfER2vvppvk/fdjxYX
	 1Da4yb+qRiN/6jedAhvBYjPuKmRsyvEAFyY2vpivElL6wlE3bzXMned2963Dtc/o3bvXm
	 3BzgR6ucokP5VjZQJFq36ImAPZHXMk0vI6xvslAHCEzvzXM6SFwgD8LX4f1HdfiILog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933364;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=OVNJRys4IbYiVLSXOzekP0iB0XhruBTmVGSFYU5kl/M=;
	b=b0CTfrrGo1H/csoxBYOVNb1pOh2zYEgu2Jt96p4dRR3pMbu20+ksMMh8Cnc6sBLzJC0k
	 5XZfTh2Tq7Z/nIcInRO/eQ7tSj1JR/1r3Wf7Uzn/6Aq5mnh0hqGQ7Hi8AeS7PfeX5CXUM
	 oM1K4F0KaXFJ7bK5gpMxgwFNo2rYmpEywmMttdb5TlAYpKnThtKP8RnS2Y0Gnct1d0gNl
	 8bySLA4kozdL4Jlw8BSNtGAJ3IcdMj3YNQmFR5IRPuNiIJWADKQDBAdHQBAJhdXYsxuwW
	 RoHnAJuZ9bAz2V+USCTDHgPieriqKxEDmBkcQR0Df7cCTXqo+IRU0VPLzXLlEP9T7yw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=WNxFYiLz;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Pmyawvc1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.170
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF563606A332
	for <linux-can@vger.kernel.org>; Tue, 17 Nov 2026 16:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF563606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=WNxFYiLz;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Pmyawvc1
ARC-Seal: i=1; a=rsa-sha256; t=1794933348; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=E6UZUJyfFpYJlM5H5CMOg7OJU2ILK6Z+Rl32nS5xm96GDaW/5k90gL4hfUcTl4s8ph
    JssCgMD9T8AXorosVXGJFBgIC8ghC3lrUfqRIBNMgRPm5dNMXxWPKy2KVQJtKYd9Q9Ag
    EcaD271sjQdcn3IRxoLBR2V1NwkjyJ57r7e8Q7XzoBcD6VHunTWVVwvak1EH8E0tWsGR
    fp0xPcf76MBzvAylmnzWe2QJprbwPFvUCz5v8kA+rgS3S5TBEMwMO/MCoSV3hh/rupgz
    ApBk4duupkr4XahvODGCtDsW6ZMHK9+P8fUc/ThA0CPoHrOWJf+0nPg/NQQIN0xQKeF1
    XMoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794933348;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=OVNJRys4IbYiVLSXOzekP0iB0XhruBTmVGSFYU5kl/M=;
    b=tEDZstHqz2wI+6b493gHhwcM5AXmkOVu0npQEPems+yC3YGV4u4jxS3sYphac0OgdS
    MmZM8BFTjt0zhqzPGrKQ6dblyRmfWF0u70xF4TYnIHb4I8zhhDbrX5hkKOKqpmXVEDFW
    CvDIlUpHj+SSiPWycEQX9Fltu72uWVqCUZj12jyZ0p7nQWLwQr5IAMOm0pplhqy78ls2
    h1A5wBZdCUhwASPqiV6Frew/WuUhynevOrNErUUAAXo3WPo8zteKb8DubRXB5I99BJqW
    eR5Uzxy+uB/WNqd4HbJSibWFVvSqWrn/5ugG9rBuSmZETYneqBIADNm9XBQ5Sdq8ywRq
    7MQA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794933348;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=OVNJRys4IbYiVLSXOzekP0iB0XhruBTmVGSFYU5kl/M=;
    b=WNxFYiLzTh1WBBEfppZN6v5JnUEY1E2pWKqqPFLUnlyratlmAlfEBFcc2I2mcqcZ7B
    ds0FLjrDBPIEy/J9jJB5oUGhiXqSMhGI5Z/7tF0I2U4C5CzXv6wmk057P0E0tYC/isdd
    WCi8DL6996J5f99VYYLSRR9yJNp+qqnpsQyRc3Mp5VvOJGPS1E2U0m9ujgnjQqdvBcEk
    F48FOR2BWMO90xvZ1AvqEzcMiyT82R2V/ez6o7eZNc9o6Aye8DLPiKwIXaJUaobhvWSU
    oTwmAUfYnjKznI8GqmDLHEBZAIJOJpZ8riNRMKItrTopgUBTHZyzJBh1POTUwHJWiNuk
    iRTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794933348;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=OVNJRys4IbYiVLSXOzekP0iB0XhruBTmVGSFYU5kl/M=;
    b=Pmyawvc1vQ8zw2Y4ffavHuFAup+KzS6TkrgNiLqXQBu8Ww6FpMUp/Hi7JywNmcBo6f
    QJ7sUETJtFv2L8ej+KCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AHGZmcea
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 17 Nov 2026 17:35:48 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Tue, 17 Nov 2026 17:35:45 +0100
Subject: [PATCH v6 4/8] can: isotp: use a private mutex instead of
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
Message-Id: <20261117-can-bcmlock-memcg-v6-4-6826a6227d36@hartkopp.net>
References: <20261117-can-bcmlock-memcg-v6-0-6826a6227d36@hartkopp.net>
In-Reply-To: <20261117-can-bcmlock-memcg-v6-0-6826a6227d36@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Zhu Ling <zhuling0805@qq.com>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794933347; l=7524;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=LzREcHis030hMdIGjsMovZQZPfS+OgBmYjMlE+yThHg=;
 b=g6ruU8EUVMVFj+ZsFcf+Z62fvt6mNquZJaHMWoJOSvZCkAflmBNbgvwADQiQOEXiC0hwnthdd
 UMEttM/cL6nDPZ+pnJLSdO9CcYhxpyJvcwxlPmtfKA7ziQ8s0t8j43c
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

