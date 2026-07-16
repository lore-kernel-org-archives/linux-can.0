Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732593F54AE;
	Thu, 16 Jul 2026 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784217411; cv=none; b=QxMsm51hPHdynF4qbE8KUCHxPcMFOh/l+kv3uG+8QkFam2bq1wx1kwE0cwt8jqjJvu7EmWnuaYVYm26t7hB44UDgOl0Ti1/ugQRGmTqskBIaI9NtsxkjSEbqn6WC2WXSi+Vuz3kXdoRsLZ5bwbYgQfc3u0a+stLoxbeYVBR1K60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784217411; c=relaxed/simple;
	bh=su8cSw53AkFNbdQsEmUisJTsHuWROEJ+0e4euFWTsls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UiGC25jT05zYDZgNPns8CxZOJm6bSj7/6pvS4A9TaF6roPXCpMC9lKvk+6CQsrKAeEhts7Pes6zEK2l0HEKyJrPQ8GoO7E7XTf4rEhOgbTJFr9g/i0iMByG5Xh1E9JRlmt1hXhJFOZ+nU1uBYuqM7+xLX66waVKTbSaTJbw631A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9740D202289;
	Thu, 16 Jul 2026 17:56:24 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wkORk-0027ot-14;
	Thu, 16 Jul 2026 17:56:24 +0200
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9DBC856C3DD;
	Thu, 16 Jul 2026 15:55:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Ginger <ginger.jzllee@gmail.com>,
	stable@kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 07/19] can: bcm: fix lockless bound/ifindex race and silent RX_SETUP failure
Date: Thu, 16 Jul 2026 17:47:32 +0200
Message-ID: <20260716155528.809908-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716155528.809908-1-mkl@pengutronix.de>
References: <20260716155528.809908-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Oliver Hartkopp <socketcan@hartkopp.net>

bcm_sendmsg() reads bo->ifindex and checks bo->bound before taking
lock_sock(), while bcm_notify(), bcm_connect() and bcm_release() all
mutate both fields under that same lock. Because the lockless reads
and the locked writes are unordered with respect to each other, a
racing bcm_notify() (device unregister) or bcm_connect() (concurrent
bind on another thread sharing the socket) can make bcm_sendmsg()
observe an inconsistent combination, e.g. a stale bound=1 together
with the now-cleared ifindex=0, silently turning a socket bound to a
specific CAN interface into one that also matches "any" interface.

Keep the lockless bo->bound check purely as a fast-path reject, and
move the ifindex read (and a bo->bound re-check) into the locked
section, where every writer already serializes. This removes the
possibility of observing the two fields torn against each other,
rather than trying to fix it with more READ_ONCE()/WRITE_ONCE() pairs
on two independently updated fields. Annotate the now-purely-lockless
bo->bound accesses consistently across all its write sites.

Also fix bcm_rx_setup() silently returning success when the target
device disappears concurrently instead of reporting -ENODEV, so a
broken RX op is no longer left registered as if it had succeeded.

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Reported-by: Ginger <ginger.jzllee@gmail.com>
Closes: https://lore.kernel.org/linux-can/CAGp+u1aBK8QVjsvAxM2Ldzep4rEbsP9x_pV3At4g=h1kVEtyhA@mail.gmail.com/
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20260714-bcm_fixes-v15-2-562f7e3e42da@hartkopp.net
Cc: stable@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/bcm.c | 65 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 14 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index bdf53241bd7b..b612135b017d 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1323,6 +1323,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
 				op->rx_reg_dev = dev;
 				dev_put(dev);
+			} else {
+				/* the requested device is gone - do not
+				 * silently succeed without registering
+				 */
+				err = -ENODEV;
 			}
 
 		} else
@@ -1396,12 +1401,13 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 {
 	struct sock *sk = sock->sk;
 	struct bcm_sock *bo = bcm_sk(sk);
-	int ifindex = bo->ifindex; /* default ifindex for this bcm_op */
+	int ifindex;
 	struct bcm_msg_head msg_head;
 	int cfsiz;
 	int ret; /* read bytes or error codes as return value */
 
-	if (!bo->bound)
+	/* Lockless fast-path check for bound socket */
+	if (!READ_ONCE(bo->bound))
 		return -ENOTCONN;
 
 	/* check for valid message length from userspace */
@@ -1417,17 +1423,38 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if ((size - MHSIZ) % cfsiz)
 		return -EINVAL;
 
+	lock_sock(sk);
+
+	/* Re-validate under the socket lock: a concurrent bcm_notify()
+	 * may have unbound this socket (device removal) after the
+	 * lockless fast-path check above. bo->ifindex is only ever
+	 * mutated under lock_sock(), so reading it here - instead of
+	 * before taking the lock - guarantees it can't be observed
+	 * torn against bo->bound.
+	 */
+	if (!bo->bound) {
+		ret = -ENOTCONN;
+		goto out_release;
+	}
+
+	/* default ifindex for this bcm_op */
+	ifindex = bo->ifindex;
+
 	/* check for alternative ifindex for this bcm_op */
 
 	if (!ifindex && msg->msg_name) {
 		/* no bound device as default => check msg_name */
 		DECLARE_SOCKADDR(struct sockaddr_can *, addr, msg->msg_name);
 
-		if (msg->msg_namelen < BCM_MIN_NAMELEN)
-			return -EINVAL;
+		if (msg->msg_namelen < BCM_MIN_NAMELEN) {
+			ret = -EINVAL;
+			goto out_release;
+		}
 
-		if (addr->can_family != AF_CAN)
-			return -EINVAL;
+		if (addr->can_family != AF_CAN) {
+			ret = -EINVAL;
+			goto out_release;
+		}
 
 		/* ifindex from sendto() */
 		ifindex = addr->can_ifindex;
@@ -1436,20 +1463,21 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			struct net_device *dev;
 
 			dev = dev_get_by_index(sock_net(sk), ifindex);
-			if (!dev)
-				return -ENODEV;
+			if (!dev) {
+				ret = -ENODEV;
+				goto out_release;
+			}
 
 			if (dev->type != ARPHRD_CAN) {
 				dev_put(dev);
-				return -ENODEV;
+				ret = -ENODEV;
+				goto out_release;
 			}
 
 			dev_put(dev);
 		}
 	}
 
-	lock_sock(sk);
-
 	switch (msg_head.opcode) {
 
 	case TX_SETUP:
@@ -1499,6 +1527,7 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		break;
 	}
 
+out_release:
 	release_sock(sk);
 
 	return ret;
@@ -1535,7 +1564,12 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 				bo->bcm_proc_read = NULL;
 			}
 #endif
-			bo->bound   = 0;
+			/* Paired with the lockless fast-path check in
+			 * bcm_sendmsg(); bo->ifindex itself is only ever
+			 * accessed under lock_sock() so it needs no
+			 * annotation.
+			 */
+			WRITE_ONCE(bo->bound, 0);
 			bo->ifindex = 0;
 			notify_enodev = 1;
 		}
@@ -1676,7 +1710,7 @@ static int bcm_release(struct socket *sock)
 
 	/* remove device reference */
 	if (bo->bound) {
-		bo->bound   = 0;
+		WRITE_ONCE(bo->bound, 0);
 		bo->ifindex = 0;
 	}
 
@@ -1746,7 +1780,10 @@ static int bcm_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int
 	}
 #endif /* CONFIG_PROC_FS */
 
-	bo->bound = 1;
+	/* bo->ifindex above is fully assigned before this point; pairs
+	 * with the lockless fast-path check in bcm_sendmsg()
+	 */
+	WRITE_ONCE(bo->bound, 1);
 
 fail:
 	release_sock(sk);
-- 
2.53.0

