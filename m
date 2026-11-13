Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590041;
	b=v7gGXwnbkkr94wlgU9+PPE6U3rszuuTBLlrx9dzCtxA9cEyYHXsHNmFUKY67XdqsG0Vc
	 7CFqXLbCyXUoX3f/Y0fvGJvNUCbN+RaWaVQPbLKWZmTqlrScNa47qDRQyrGJ6agqBodDj
	 fYSgh+0ttyIWJkIotGziWkq7NsWQc8++OB0WjvKCuybKO1e6X0x8QUbploBzWgu4fjN6/
	 Q59rGYQ0x1q7YxWmEXqx4dSHzfTHwG2e3EJic7K3/LUD+J+aVz1+CCWB1eptCdDlCElsQ
	 FG+UkGLwv2o8RdJOwoG9bW8Y9J8R47e45AU7VF0SbYxOYNvbasikGrMi/76xDQnNs3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590041;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Virus-Status:
	 X-Anti-Virus-Server;
	bh=RERJ1QNk56fHeLZGCqRbnHvkmOcJetMX+rZi5LjhUuw=;
	b=pC2h/6Np2yiVWp/R9grRp/j0wGhZjZJBBRw8SDIP9EqUYtlWHPqlWY2f+wCWu988+nTa
	 ZgE5WFh4epA/zdcR0SBCwkD32ojJJ0cQjC+K0lmR3mgoPT6XI63GanrYiD5KCgieiLHIc
	 Oq+2qbibRodEgCunlur6cGJKWE/5c9ozoWJRMPieZKK/2HaHnD44eQJk1oK2w6a1kqxXW
	 8Yf8raVm1YV5y8sIYRBi1m4QOLuD7iAB/XJ432Xzbeqj7GR3vePya1W/HtupNn9SRknkJ
	 H2F/UsGfUP/NyXtixKcl8auvT3xu/wMbMbvB/AmrkG2HhxE7HZBqPqBYavupYl+3e2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF2360A2618
	for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 17:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FF2360A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6ADHDhjZ088876;
	Sat, 14 Nov 2026 02:13:43 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6ADHDhrp088872
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 14 Nov 2026 02:13:43 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <60b30b7c-91dc-4138-bc92-be922ffd6215@I-love.SAKURA.ne.jp>
Date: Sat, 14 Nov 2026 02:13:42 +0900
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v12 3/3] can: j1939: fix "struct j1939_ecu" refcount leak
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>
References: <8de287d7-b4e1-4062-b40e-b193f5ec68ca@I-love.SAKURA.ne.jp>
 <ba3e6880-6dff-4fa6-a2e4-629c3d35b8d5@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <ba3e6880-6dff-4fa6-a2e4-629c3d35b8d5@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav412.rs.sakura.ne.jp

syzbot is reporting "struct j1939_ecu" refcount leak, for

  j1939_ecu_get(ecu);
  priv->ents[ecu->addr] = ecu;

in j1939_ecu_map_locked() from j1939_ecu_timer_handler() can succeed
even after

  priv->ents[ecu->addr] = NULL;
  j1939_ecu_put(ecu);

in j1939_ecu_unmap_locked() from j1939_ecu_unmap_all() from
__j1939_rx_release() from j1939_netdev_stop() has completed.

Fix this problem by

  (1) canceling ecu->ac_timer from j1939_ecu_unmap_all()

unconditionally and

  (2) preventing ecu->ac_timer from re-arming in j1939_ecu_timer_start()
  (3) making j1939_ecu_map_locked() no-op

when a netdev which is associated with j1939_priv is no longer registered
(indicated by ecu->priv->ndev->reg_state != NETREG_REGISTERED) or
__j1939_rx_release() was called (indicated by ecu->priv->rx_kref == 0).

Reported-by: syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 net/can/j1939/bus.c    | 52 +++++++++++++++++++++++++++++++++++++++---
 net/can/j1939/socket.c | 10 +++++++-
 2 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index 8cbf8716d286..a0120567bb8f 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -58,6 +58,17 @@ static bool __must_check j1939_ecu_get(struct j1939_ecu *ecu)
 	return kref_get_unless_zero(&ecu->kref);
 }
 
+static bool __must_check j1939_ecu_verify_get(struct j1939_ecu *ecu)
+{
+	struct j1939_priv *priv = ecu->priv;
+
+	/* Don't get an ECU ref if netdev is no longer registered or
+	 * __j1939_rx_release() was called or __j1939_ecu_release() was called.
+	 */
+	return READ_ONCE(priv->ndev->reg_state) == NETREG_REGISTERED &&
+		kref_read(&priv->rx_kref) && j1939_ecu_get(ecu);
+}
+
 static bool __must_check j1939_ecu_valid(struct j1939_ecu *ecu)
 {
 	/* Treat an ECU as invalid if __j1939_ecu_release() was called. */
@@ -85,7 +96,7 @@ static void j1939_ecu_map_locked(struct j1939_ecu *ecu)
 	if (!j1939_address_is_unicast(ecu->addr))
 		return;
 
-	if (!j1939_ecu_get(ecu))
+	if (!j1939_ecu_verify_get(ecu))
 		return;
 
 	ent = &priv->ents[ecu->addr];
@@ -130,8 +141,43 @@ void j1939_ecu_unmap(struct j1939_ecu *ecu)
 void j1939_ecu_unmap_all(struct j1939_priv *priv)
 {
 	int i;
+	struct j1939_ecu *ecu;
 
+rescan:
 	write_lock_bh(&priv->lock);
+	/* Need to shutdown timers now, for j1939_module_exit() might be called
+	 * relatively shortly after returning from j1939_ecu_unmap_all() from
+	 * __j1939_rx_release() from j1939_netdev_stop() from j1939_sk_release().
+	 */
+	list_for_each_entry(ecu, &priv->ecus, list) {
+		if (!j1939_ecu_valid(ecu))
+			continue;
+		switch (hrtimer_try_to_cancel(&ecu->ac_timer)) {
+		case 0:	/* Not active or already finished. */
+			continue;
+		case 1:	/* Successfully canceled. */
+			/* Drop the ref from j1939_ecu_timer_start(). */
+			j1939_ecu_put(ecu);
+			continue;
+		default: /* Currently executing. */
+			/* Get a ref, in order to call hrtimer_cancel() without priv->lock.
+			 * If we can't get a ref, __j1939_ecu_release_work() will call
+			 * hrtimer_cancel() without priv->lock, and j1939_module_exit()
+			 * will wait for completion of __j1939_ecu_release_work().
+			 */
+			if (!j1939_ecu_get(ecu))
+				continue;
+			break;
+		}
+		write_unlock_bh(&priv->lock);
+		if (hrtimer_cancel(&ecu->ac_timer))
+			/* Drop the ref from j1939_ecu_timer_start(). */
+			j1939_ecu_put(ecu);
+		/* Drop the ref from default: above. */
+		j1939_ecu_put(ecu);
+		goto rescan;
+	}
+	/* Unmap any remaining mapped ECUs */
 	for (i = 0; i < ARRAY_SIZE(priv->ents); i++)
 		if (priv->ents[i].ecu)
 			j1939_ecu_unmap_locked(priv->ents[i].ecu);
@@ -141,9 +187,9 @@ void j1939_ecu_unmap_all(struct j1939_priv *priv)
 void j1939_ecu_timer_start(struct j1939_ecu *ecu)
 {
 	/* The corresponding j1939_ecu_put() is in
-	 * j1939_ecu_timer_handler() or j1939_ecu_timer_cancel().
+	 * j1939_ecu_timer_handler() or j1939_ecu_timer_cancel() or j1939_ecu_unmap_all().
 	 */
-	if (!j1939_ecu_get(ecu))
+	if (!j1939_ecu_verify_get(ecu))
 		return;
 
 	/* Schedule timer in 250 msec to commit address change. */
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 50a598ef5fd4..6e22ec5e88f5 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -484,7 +484,15 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr_unsized *uaddr, in
 			goto out_release_sock;
 		}
 
-		if (ndev->reg_state != NETREG_REGISTERED) {
+		/* Do nothing and fail early if netdev is no longer registered.
+		 * This check is racy but we don't need to recheck after j1939_jsk_add()
+		 * is called, for either j1939_sk_netdev_event_unregister() from
+		 * j1939_netdev_notify(NETDEV_UNREGISTER) (which is retried by
+		 * netdev_wait_allrefs_any() as long as priv->rx_kref held by
+		 * j1939_netdev_start() is preventing j1939_priv_set(priv->ndev, NULL)
+		 * from being called) or j1939_sk_release() will take care of this race.
+		 */
+		if (READ_ONCE(ndev->reg_state) != NETREG_REGISTERED) {
 			dev_put(ndev);
 			ret = -ENODEV;
 			goto out_release_sock;
-- 
2.56.0

