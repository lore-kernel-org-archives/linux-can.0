Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6776D435AAA
	for <linux-can@vger.kernel.org>; Wed, 26 Aug 2026 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787753976; cv=none; b=DynI+FJcQc2MZTsbHvO4Q+EEfYlT0u6yGlr4n+QZq/23MfL/6fNQW24/az1eoowlq5cQFIKXUgZ23RNAPmoVwKbpuX+BjHn7Yp5SXYgmhWjUNE+D88O9ezixogP5m9hg93Fz60EuvdsSjiqd0DNJWLWVg0o0bTLs6xBSeJjvNiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787753976; c=relaxed/simple;
	bh=TsD8XsOnqunvck5ydKj3fbuO967CS25LBEUSG1vCZsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=omM8h/p65fAz3bv2nwDR8sb9gmZilPMjajSzeYcBoYaXpYICvrRgeV7+i4U5eUhicDUqDFYz071mjC3K82F3WOIUEgMGTOuKsxKZIB3AUD1IFQTx6/PkXP4HwgcOWX8tFo1aDp2ZYa3Aiv7PyiK8aICD5W3ht7wYkOgojF0FFIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 67QEIxM0091403;
	Wed, 26 Aug 2026 23:18:59 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 67QEIx2Z091400
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 26 Aug 2026 23:18:59 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <45b82053-7f32-43fc-b37b-067058a72c98@I-love.SAKURA.ne.jp>
Date: Wed, 26 Aug 2026 23:18:57 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] can: j1939: j1939_sk_bind(): fix j1939_ecu leak when
 re-bind failed
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
References: <8063b5c1-6171-4350-a7d1-6ccd079fb0ff@I-love.SAKURA.ne.jp>
 <20260826-zealous-wandering-giraffe-3fb7ce-mkl@pengutronix.de>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260826-zealous-wandering-giraffe-3fb7ce-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav415.rs.sakura.ne.jp
X-Virus-Status: clean

syzbot is reporting "struct j1939_ecu" refcount leak, which occurs when
netdev_hold() is called during ECU creation but the corresponding
netdev_put() is never executed because the parent "struct j1939_ecu"
object is leaked.

  unregister_netdevice: waiting for vxcan1 to become free. Usage count = 3
  ref_tracker: netdev@ffff8880710f0700 has 1/2 users at
       __netdev_tracker_alloc include/linux/netdevice.h:4496 [inline]
       netdev_hold include/linux/netdevice.h:4525 [inline]
       j1939_ecu_create_locked+0x1c9/0x400 net/can/j1939/bus.c:159
       j1939_local_ecu_get+0xeb/0x220 net/can/j1939/bus.c:293
       j1939_sk_bind+0x70a/0xc60 net/can/j1939/socket.c:529
       __sys_bind_socket net/socket.c:1920 [inline]
       __sys_bind+0x2e3/0x410 net/socket.c:1951
       __do_sys_bind net/socket.c:1956 [inline]
       __se_sys_bind net/socket.c:1954 [inline]
       __x64_sys_bind+0x7a/0x90 net/socket.c:1954
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

  ref_tracker: netdev@ffff8880710f0700 has 1/2 users at
       __netdev_tracker_alloc include/linux/netdevice.h:4496 [inline]
       netdev_hold include/linux/netdevice.h:4525 [inline]
       j1939_priv_create net/can/j1939/main.c:140 [inline]
       j1939_netdev_start+0x387/0xb20 net/can/j1939/main.c:268
       j1939_sk_bind+0x946/0xc60 net/can/j1939/socket.c:506
       __sys_bind_socket net/socket.c:1920 [inline]
       __sys_bind+0x2e3/0x410 net/socket.c:1951
       __do_sys_bind net/socket.c:1956 [inline]
       __se_sys_bind net/socket.c:1954 [inline]
       __x64_sys_bind+0x7a/0x90 net/socket.c:1954
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

The root cause lies in the error handling of j1939_sk_bind() during a
re-bind operation (binding an already bound socket to the same interface).
Currently, the function prematurely drops the old ECU references by calling
j1939_local_ecu_put() before verifying whether the new configuration can be
successfully acquired via j1939_local_ecu_get().

If j1939_local_ecu_get() subsequently fails, the function unconditionally
calls j1939_netdev_stop() and clears jsk->priv. This leaves the socket in a
half-broken state where the old ECU's refcount has already been decremented
incompletely, but the socket destruct pathway (j1939_sk_sock_destruct) can
no longer perform proper cleanup because jsk->priv is NULL. As a result,
the old "struct j1939_ecu" remains orphaned on the priv->ecus list,
permanently leaking both the ECU object and the net_device reference held
inside it.

Fix this by deferring the removal and release of the old ECU references
until after j1939_local_ecu_get() has successfully acquired the new
resources. As a side effect of this change, the socket's state no longer
changes when the re-bind operation failed.

Reported-by: syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd
Assisted-by: Gemini-Pro
Fixes: f214744c8a27 ("can: j1939: j1939_sk_bind(): call j1939_priv_put() immediately when j1939_local_ecu_get() failed")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Changes in v2:
  Replace "Analyzed-by:" with "Assisted-by:".

 net/can/j1939/socket.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 50a598ef5fd4..24efb25c58c3 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -450,6 +450,7 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr_unsized *uaddr, in
 	struct sock *sk;
 	struct net *net;
 	int ret = 0;
+	bool was_bound;
 
 	ret = j1939_sk_sanity_check(addr, len);
 	if (ret)
@@ -462,7 +463,8 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr_unsized *uaddr, in
 	net = sock_net(sk);
 
 	/* Already bound to an interface? */
-	if (jsk->state & J1939_SOCK_BOUND) {
+	was_bound = (jsk->state & J1939_SOCK_BOUND);
+	if (was_bound) {
 		/* A re-bind() to a different interface is not
 		 * supported.
 		 */
@@ -470,10 +472,6 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr_unsized *uaddr, in
 			ret = -EINVAL;
 			goto out_release_sock;
 		}
-
-		/* drop old references */
-		j1939_jsk_del(priv, jsk);
-		j1939_local_ecu_put(priv, jsk->addr.src_name, jsk->addr.sa);
 	} else {
 		struct can_ml_priv *can_ml;
 		struct net_device *ndev;
@@ -519,22 +517,31 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr_unsized *uaddr, in
 		jsk->priv = priv;
 	}
 
+	/* get new references without dropping old references */
+	ret = j1939_local_ecu_get(priv, addr->can_addr.j1939.name, addr->can_addr.j1939.addr);
+	if (ret) {
+		/* nothing to undo if re-bind() failed */
+		if (!was_bound) {
+			j1939_netdev_stop(priv);
+			jsk->priv = NULL;
+			synchronize_rcu();
+			j1939_priv_put(priv);
+		}
+		goto out_release_sock;
+	}
+
+	/* drop old references after re-bind() succeeded */
+	if (was_bound) {
+		j1939_jsk_del(priv, jsk);
+		j1939_local_ecu_put(priv, jsk->addr.src_name, jsk->addr.sa);
+	}
+
 	/* set default transmit pgn */
 	if (j1939_pgn_is_valid(addr->can_addr.j1939.pgn))
 		jsk->pgn_rx_filter = addr->can_addr.j1939.pgn;
 	jsk->addr.src_name = addr->can_addr.j1939.name;
 	jsk->addr.sa = addr->can_addr.j1939.addr;
 
-	/* get new references */
-	ret = j1939_local_ecu_get(priv, jsk->addr.src_name, jsk->addr.sa);
-	if (ret) {
-		j1939_netdev_stop(priv);
-		jsk->priv = NULL;
-		synchronize_rcu();
-		j1939_priv_put(priv);
-		goto out_release_sock;
-	}
-
 	j1939_jsk_add(priv, jsk);
 
  out_release_sock: /* fall through */
-- 
2.55.0
