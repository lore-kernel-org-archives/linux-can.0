Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794931038;
	b=F+maBcIvO56LZOyHn8xj/UGNBl30h5QRdc8A24yAEFC21ReJKb/Ya6FCrqcHYK9ABn85
	 GcXWomeCxJ0fdScFrb/tWoPEQnUMOMA1PwRepbH8j6KxjO4mVeDTce4mCFiBu4P7Pquzs
	 PGiDcZ0mE00tlOU2ftdD5Yu0uqkDmcQnZ2pcyU3hwPKHdcbCdbr3lBUqasU/USBUeIxtO
	 39I51EUQaHJvB5imDG1yIftMIBhK77d6N5CVk0vR+7MMcUuXKEJqqA1QOEGA2v2hguGpX
	 dwYJJQlp0POxkF2rNo3hAiAPrOxpJUCppy1Wp5oD/TyWHVZt5LSHNTBBqWsOh1aWpRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794931038;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Anti-Virus-Server:
	 X-Virus-Status;
	bh=QGBOySQgiBV1dhu0QUw6gjQ7r545lODN2npxyicG+dY=;
	b=JZ03XZqfutsKAcYO8JYu9P5Au2qsIWq6SO80gjuGjrPZaGOO8+1PUi6Xv1/jv5Tv9PQ4
	 hbNIpbguxU94IT1NzVFliUQOMsQ9eFf1vdtmmEl+fWZPxO6KeZp0KAhNUBsDEkB9NLpg9
	 2H00m/4mv9kLetuEh1A6GBJ5U8xKP4kchWhiZ+7ZXY9+o9/aDRzAgfL3sXyddFdjlAhD5
	 hl3BR590FD5gOyIFvfM1bOU4ahXfCoJFrP9oNXqxSMaJiTP+Zq8yFuKHX9Ku+nZH/M548
	 itda5mSYXzLfpJvA2oKkObfUgk/owMCuqS8aT/dTCJ8y0k4+T3UWvkwcC5uFboSgv5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FD6606A31C
	for <linux-can@vger.kernel.org>; Tue, 17 Nov 2026 15:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39FD6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6AHFuxgL029872;
	Wed, 18 Nov 2026 00:56:59 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6AHFuxgY029867
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 18 Nov 2026 00:56:59 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <486cfc57-667b-42c8-9a49-67c496522702@I-love.SAKURA.ne.jp>
Date: Wed, 18 Nov 2026 00:56:58 +0900
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
Subject: [PATCH v15 1/3] can: j1939: fix possibility of UAF
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>
References: <98c16a74-5ea7-476e-ab36-c98fb77b6be4@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <98c16a74-5ea7-476e-ab36-c98fb77b6be4@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav314.rs.sakura.ne.jp
X-Virus-Status: clean

## Problems

# Problem 1

Since module refcount is currently associated with lifecycle of j1939
sockets, we need to make sure that all resources associated with socket
("struct j1939_priv", "struct j1939_ecu", "struct j1939_session") are
synchronously destructed before socket is destructed. Otherwise,
j1939_module_exit() can complete and memory for this module is unmapped
and cause UAF.

# Problem 2

This module takes a refcount upon arming an hrtimer and drops that refcount
when the hrtimer is fired or canceled, but nothing guarantees that the
callback is no longer running when the last refcount is dropped. We need
to make sure that hrtimer callbacks are no longer running before calling
kfree(). But we can't use hrtimer_cancel() from atomic context.

# Problem 3

Since j1939_ac_recv() and j1939_ac_fixup() are calling j1939_ecu_put()
without priv->lock held for write, list corruption might happen if the
last user called j1939_ecu_put() without priv->lock held for write. But
requiring all j1939_ecu_put() callers to hold priv->lock for write might
be a difficult change.

## Approach

Calling module_put(THIS_MODULE) from a module function whose completion
cannot be waited for from that module's exit function is a source of UAF.
But calling module_put(THIS_MODULE) from a WQ function whose completion
can be waited for from that module's exit function using flush_workqueue()
etc. is fine.

Fix problem 1 by deferring release steps of "struct j1939_priv" to WQ
context where we can call module_put(THIS_MODULE) while allowing
j1939_module_exit() to wait for completion using destroy_workqueue().

Fix problem 2 by deferring timer cancellation and final freeing of
"struct j1939_ecu" and "struct j1939_session" to WQ context where we can
call hrtimer_cancel() before calling kfree().

Fix problem 3 by deferring release steps of "struct j1939_ecu" to WQ
context where we can unconditionally hold priv->lock for write.
By deferring to WQ context, readers might find ECUs which have already
reached __j1939_ecu_release(). Therefore, allow using an ECU only when
__j1939_ecu_release() is not yet called (indicated by ecu->kref > 0).

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 net/can/j1939/bus.c        | 66 +++++++++++++++++++++++++++-----------
 net/can/j1939/j1939-priv.h |  8 +++++
 net/can/j1939/main.c       | 47 +++++++++++++++++++++++----
 net/can/j1939/transport.c  | 23 +++++++++++--
 4 files changed, 116 insertions(+), 28 deletions(-)

diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index cdc3c0a71937..3924404152a2 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -14,25 +14,52 @@
 
 #include "j1939-priv.h"
 
-static void __j1939_ecu_release(struct kref *kref)
+static void __j1939_ecu_release_work(struct work_struct *work)
 {
-	struct j1939_ecu *ecu = container_of(kref, struct j1939_ecu, kref);
+	struct j1939_ecu *ecu = container_of(work, struct j1939_ecu, release_work);
 	struct j1939_priv *priv = ecu->priv;
 
+	write_lock_bh(&priv->lock);
 	list_del(&ecu->list);
+	write_unlock_bh(&priv->lock);
+	/* There can't be any ref on this ECU because __j1939_ecu_release()
+	 * was already called. But we need to make sure that
+	 * j1939_ecu_timer_handler() is no longer running before kfree().
+	 */
+	WARN_ON(hrtimer_cancel(&ecu->ac_timer));
 	netdev_put(priv->ndev, &ecu->priv_dev_tracker);
 	kfree(ecu);
 	j1939_priv_put(priv);
 }
 
+static void __j1939_ecu_release(struct kref *kref)
+{
+	struct j1939_ecu *ecu = container_of(kref, struct j1939_ecu, kref);
+
+	/* Since not all callers are calling j1939_ecu_put() with priv->lock
+	 * held for write, defer actual release to WQ context. By deferring to
+	 * WQ context, readers might find ECUs with ecu->kref == 0. Therefore,
+	 * readers must validate with j1939_ecu_valid() or j1939_ecu_get().
+	 */
+	INIT_WORK(&ecu->release_work, __j1939_ecu_release_work);
+	queue_work(j1939_wq, &ecu->release_work);
+}
+
 void j1939_ecu_put(struct j1939_ecu *ecu)
 {
 	kref_put(&ecu->kref, __j1939_ecu_release);
 }
 
-static void j1939_ecu_get(struct j1939_ecu *ecu)
+static bool __must_check j1939_ecu_get(struct j1939_ecu *ecu)
 {
-	kref_get(&ecu->kref);
+	/* Don't get an ECU ref if __j1939_ecu_release() was called. */
+	return kref_get_unless_zero(&ecu->kref);
+}
+
+static bool __must_check j1939_ecu_valid(struct j1939_ecu *ecu)
+{
+	/* Treat an ECU as invalid if __j1939_ecu_release() was called. */
+	return kref_read(&ecu->kref);
 }
 
 static bool j1939_ecu_is_mapped_locked(struct j1939_ecu *ecu)
@@ -56,15 +83,17 @@ static void j1939_ecu_map_locked(struct j1939_ecu *ecu)
 	if (!j1939_address_is_unicast(ecu->addr))
 		return;
 
+	if (!j1939_ecu_get(ecu))
+		return;
+
 	ent = &priv->ents[ecu->addr];
 
 	if (ent->ecu) {
 		netdev_warn(priv->ndev, "Trying to map already mapped ECU, addr: 0x%02x, name: 0x%016llx. Skip it.\n",
 			    ecu->addr, ecu->name);
+		j1939_ecu_put(ecu);
 		return;
 	}
-
-	j1939_ecu_get(ecu);
 	ent->ecu = ecu;
 	ent->nusers += ecu->nusers;
 }
@@ -109,10 +138,11 @@ void j1939_ecu_unmap_all(struct j1939_priv *priv)
 
 void j1939_ecu_timer_start(struct j1939_ecu *ecu)
 {
-	/* The ECU is held here and released in the
+	/* The corresponding j1939_ecu_put() is in
 	 * j1939_ecu_timer_handler() or j1939_ecu_timer_cancel().
 	 */
-	j1939_ecu_get(ecu);
+	if (!j1939_ecu_get(ecu))
+		return;
 
 	/* Schedule timer in 250 msec to commit address change. */
 	hrtimer_start(&ecu->ac_timer, ms_to_ktime(250),
@@ -122,6 +152,7 @@ void j1939_ecu_timer_start(struct j1939_ecu *ecu)
 void j1939_ecu_timer_cancel(struct j1939_ecu *ecu)
 {
 	if (hrtimer_cancel(&ecu->ac_timer))
+		/* Drop the ref from j1939_ecu_timer_start(). */
 		j1939_ecu_put(ecu);
 }
 
@@ -137,9 +168,7 @@ static enum hrtimer_restart j1939_ecu_timer_handler(struct hrtimer *hrtimer)
 	 */
 	j1939_ecu_map_locked(ecu);
 
-	/* The corresponding j1939_ecu_get() is in
-	 * j1939_ecu_timer_start().
-	 */
+	/* Drop the ref from j1939_ecu_timer_start(). */
 	j1939_ecu_put(ecu);
 	write_unlock_bh(&priv->lock);
 
@@ -189,8 +218,8 @@ struct j1939_ecu *j1939_ecu_get_by_addr_locked(struct j1939_priv *priv, u8 addr)
 		return NULL;
 
 	ecu = j1939_ecu_find_by_addr_locked(priv, addr);
-	if (ecu)
-		j1939_ecu_get(ecu);
+	if (ecu && !j1939_ecu_get(ecu))
+		ecu = NULL;
 
 	return ecu;
 }
@@ -215,7 +244,7 @@ static struct j1939_ecu *j1939_ecu_find_by_name_locked(struct j1939_priv *priv,
 	lockdep_assert_held(&priv->lock);
 
 	list_for_each_entry(ecu, &priv->ecus, list) {
-		if (ecu->name == name)
+		if (ecu->name == name && j1939_ecu_valid(ecu))
 			return ecu;
 	}
 
@@ -232,11 +261,12 @@ struct j1939_ecu *j1939_ecu_get_by_name_locked(struct j1939_priv *priv,
 	if (!name)
 		return NULL;
 
-	ecu = j1939_ecu_find_by_name_locked(priv, name);
-	if (ecu)
-		j1939_ecu_get(ecu);
+	list_for_each_entry(ecu, &priv->ecus, list) {
+		if (ecu->name == name && j1939_ecu_get(ecu))
+			return ecu;
+	}
 
-	return ecu;
+	return NULL;
 }
 
 struct j1939_ecu *j1939_ecu_get_by_name(struct j1939_priv *priv, name_t name)
diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index cf26352d1d8c..af179eb44b15 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -42,6 +42,8 @@ struct j1939_ecu {
 
 	/* count users, to help transport protocol decide for interaction */
 	int nusers;
+
+	struct work_struct release_work;
 };
 
 struct j1939_priv {
@@ -93,6 +95,8 @@ struct j1939_priv {
 
 	struct kref rx_kref;
 	u32 rx_tskey;
+
+	struct work_struct release_work;
 };
 
 void j1939_ecu_put(struct j1939_ecu *ecu);
@@ -290,6 +294,8 @@ struct j1939_session {
 		unsigned int dpo;
 	} pkt;
 	struct hrtimer txtimer, rxtimer;
+
+	struct work_struct release_work;
 };
 
 struct j1939_sock {
@@ -345,4 +351,6 @@ void j1939_session_timers_cancel(struct j1939_session *session);
 /* CAN protocol */
 extern const struct can_proto j1939_can_proto;
 
+extern struct workqueue_struct *j1939_wq;
+
 #endif /* _J1939_PRIV_H_ */
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index d9384cf0e356..b76037f89a80 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -20,6 +20,8 @@
 
 #include "j1939-priv.h"
 
+struct workqueue_struct *j1939_wq __ro_after_init;
+
 MODULE_DESCRIPTION("PF_CAN SAE J1939");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("EIA Electronics (Kurt Van Dijck & Pieter Beyens)");
@@ -132,6 +134,11 @@ static struct j1939_priv *j1939_priv_create(struct net_device *ndev)
 	if (!priv)
 		return NULL;
 
+	if (!try_module_get(THIS_MODULE)) {
+		kfree(priv);
+		return NULL;
+	}
+
 	rwlock_init(&priv->lock);
 	INIT_LIST_HEAD(&priv->ecus);
 	priv->ndev = ndev;
@@ -152,9 +159,9 @@ static inline void j1939_priv_set(struct net_device *ndev,
 	can_ml->j1939_priv = priv;
 }
 
-static void __j1939_priv_release(struct kref *kref)
+static void __j1939_priv_release_work(struct work_struct *work)
 {
-	struct j1939_priv *priv = container_of(kref, struct j1939_priv, kref);
+	struct j1939_priv *priv = container_of(work, struct j1939_priv, release_work);
 	struct net_device *ndev = priv->ndev;
 
 	netdev_dbg(priv->ndev, "%s: 0x%p\n", __func__, priv);
@@ -165,6 +172,21 @@ static void __j1939_priv_release(struct kref *kref)
 
 	netdev_put(ndev, &priv->dev_tracker);
 	kfree(priv);
+	/* This is safe, for j1939_module_exit() waits for completion of
+	 * this callback using destroy_workqueue().
+	 */
+	module_put(THIS_MODULE);
+}
+
+static void __j1939_priv_release(struct kref *kref)
+{
+	struct j1939_priv *priv = container_of(kref, struct j1939_priv, kref);
+
+	/* Since synchronously dropping module refcount of self is not safe,
+	 * defer actual release to WQ context.
+	 */
+	INIT_WORK(&priv->release_work, __j1939_priv_release_work);
+	queue_work(j1939_wq, &priv->release_work);
 }
 
 void j1939_priv_put(struct j1939_priv *priv)
@@ -281,8 +303,7 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
 		 */
 		kref_get(&priv_new->rx_kref);
 		mutex_unlock(&j1939_netdev_lock);
-		netdev_put(ndev, &priv->dev_tracker);
-		kfree(priv);
+		j1939_priv_put(priv);
 		return priv_new;
 	}
 	j1939_priv_set(ndev, priv);
@@ -297,9 +318,7 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
  out_priv_put:
 	j1939_priv_set(ndev, NULL);
 	mutex_unlock(&j1939_netdev_lock);
-
-	netdev_put(ndev, &priv->dev_tracker);
-	kfree(priv);
+	j1939_priv_put(priv);
 
 	return ERR_PTR(ret);
 }
@@ -401,6 +420,12 @@ static __init int j1939_module_init(void)
 
 	pr_info("can: SAE J1939\n");
 
+	j1939_wq = alloc_workqueue("j1939_wq", WQ_HIGHPRI | WQ_PERCPU, 0);
+	if (!j1939_wq) {
+		ret = -ENOMEM;
+		goto fail_wq;
+	}
+
 	ret = register_netdevice_notifier(&j1939_netdev_notifier);
 	if (ret)
 		goto fail_notifier;
@@ -416,6 +441,8 @@ static __init int j1939_module_init(void)
  fail_sk:
 	unregister_netdevice_notifier(&j1939_netdev_notifier);
  fail_notifier:
+	destroy_workqueue(j1939_wq);
+ fail_wq:
 	return ret;
 }
 
@@ -424,6 +451,12 @@ static __exit void j1939_module_exit(void)
 	can_proto_unregister(&j1939_can_proto);
 
 	unregister_netdevice_notifier(&j1939_netdev_notifier);
+
+	/* We need to make sure that __j1939_priv_release_work() and
+	 * __j1939_ecu_release_work() and j1939_session_destroy_work()
+	 * are no longer running before unmapping memory for this module.
+	 */
+	destroy_workqueue(j1939_wq);
 }
 
 module_init(j1939_module_init);
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5e6f..60cb6b602b09 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -259,6 +259,24 @@ static void __j1939_session_drop(struct j1939_session *session)
 	sock_put(session->sk);
 }
 
+static void j1939_session_destroy_work(struct work_struct *work)
+{
+	struct j1939_session *session = container_of(work, struct j1939_session,
+						     release_work);
+	struct j1939_priv *priv = session->priv;
+
+	/* There can't be any ref on this session because __j1939_session_release()
+	 * was already called. But we need to make sure that j1939_tp_txtimer() and
+	 * j1939_tp_rxtimer() are no longer running before kfree().
+	 */
+	WARN_ON(hrtimer_cancel(&session->txtimer));
+	WARN_ON(hrtimer_cancel(&session->rxtimer));
+
+	netdev_put(priv->ndev, &session->priv_dev_tracker);
+	kfree(session);
+	j1939_priv_put(priv);
+}
+
 static void j1939_session_destroy(struct j1939_session *session)
 {
 	struct sk_buff *skb;
@@ -283,9 +301,8 @@ static void j1939_session_destroy(struct j1939_session *session)
 		kfree_skb(skb);
 	}
 	__j1939_session_drop(session);
-	netdev_put(session->priv->ndev, &session->priv_dev_tracker);
-	j1939_priv_put(session->priv);
-	kfree(session);
+	INIT_WORK(&session->release_work, j1939_session_destroy_work);
+	queue_work(j1939_wq, &session->release_work);
 }
 
 static void __j1939_session_release(struct kref *kref)
-- 
2.56.1

