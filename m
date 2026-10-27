Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108890;
	b=wykYuxnueEIl+3/NfrSJegwPAFc9XWkIdOU5EfhHwWXK6bkczfBhicRZ9xJaPnVHUNRn
	 MvJxnhI8H7JEVpLpEyJRVwGyrZP4cz0cx3AbKsGqhq5dXFDmykV7IKeurkRiFgdHwtECm
	 VIArm4mJ0oPH+/B/fVmjeO/tmJq2AP1uDXIDpUGzKodg1ZrwUpk38Bddi25EdMAEHg1fb
	 Ho8PUQ09YV/k9S9CYMor+PzyeXFNUnIH6Twdur8x/YrMIeLQiQMy/p+YklIQVBz6xNQty
	 XDR1Ps4pCxHFb1LBKsOHYJxiBMisKS9fRZuUkGOgd7aoKFETI+QRCDhCtV8gA3x2uhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108890;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Content-Language:To:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-Anti-Virus-Server:X-Virus-Status;
	bh=0UBuPJ7sAn8Nu32Y8lCAzlrTPqwF7ZWfjIxQ1W8Rwx8=;
	b=UwI0GM28QeniQogbCw6XG3RxJZ9TFJqUeEHnbDQxBuR7Vo6aXMmdGKJlVjUckLkijkyz
	 8p2w51iJf8OYOWda4fC3UyAx3kK5FrNdWFiLFqK4CcLbifTOb5dnMWs1Wp5n08MBXQ6r/
	 UZZutd7N8iAaCFgCMhUmigF+3JpS1GQYlB4rbmPGety83KQmP/+ehSlA0v4ALZJPSMg1g
	 nsJeY8AGVegLlHWa8DPXEBgoQ6pOfxox0DUv1F+6Rfd2C6NSnmDVU310YY6dRS+xr+xbk
	 iJuwCfayZtSq8OxVhDxkXYqPhS0CgO2wNfjK1gsGsIlpCCbeUOQH+kWRDXpdt5UbClA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18102606A31A
	for <linux-can@vger.kernel.org>; Tue, 27 Oct 2026 13:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18102606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 69RDlj94011584;
	Tue, 27 Oct 2026 22:47:45 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 69RDljm0011580
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 27 Oct 2026 22:47:45 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <4b2c8d95-d17e-4f36-a340-abf84693d24a@I-love.SAKURA.ne.jp>
Date: Tue, 27 Oct 2026 22:47:44 +0900
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
Content-Language: en-US
To: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v4] can: j1939: fix j1939_ecu refcount leak
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav113.rs.sakura.ne.jp
X-Virus-Status: clean

Fix a struct j1939_ecu refcount leak and related race conditions by
canceling address claim timers during unmap, deferring ECU list removal to
RCU context, and gating ECU reference acquisition on netdev registration
and j1939_priv/j1939_ecu reference states. Details are explained below.

(1) syzbot is reporting "struct j1939_ecu" refcount leak, for

      j1939_ecu_get(ecu);
      priv->ents[ecu->addr] = ecu;

    in j1939_ecu_map_locked() from j1939_ecu_timer_handler() can succeed
    even after

      priv->ents[ecu->addr] = NULL;
      j1939_ecu_put(ecu);

    in j1939_ecu_unmap_locked() from j1939_ecu_unmap_all() from
    __j1939_rx_release() from j1939_netdev_stop() has completed.

    Fix this race condition by canceling address claim timers from
    j1939_ecu_unmap_all().

(2) gpt-6-astra, opus-5-5, opus-5 and sashiko-gemini are reporting that
    the fix for (1) above is not sufficient for closing the race condition.

    Fix remaining race condition by allow getting a ref on an ECU only when
    three conditions listed below are met.

      (a) A netdev which is associated with j1939_priv is still registered
          (indicated by priv->ndev->reg_state == NETREG_REGISTERED).

      (b) __j1939_rx_release() is not yet called (indicated by
          priv->rx_kref > 0), for j1939_ecu_unmap_all() won't be called
          again after __j1939_rx_release() from j1939_netdev_stop() from
          j1939_netdev_notify(NETDEV_UNREGISTER) is once triggered.

      (c) __j1939_ecu_release() is not yet called (indicated by
          ecu->kref > 0), for the fix for (3) below makes ECUs which
          already reached __j1939_ecu_release() to remain on the ECU list.

(3) sashiko-gemini is reporting that there is a possibility of list
    corruption in __j1939_ecu_release(), for not all callers are calling
    j1939_ecu_put() with priv->lock held for write.

    Fix this problem by deferring release steps to RCU context where we can
    unconditionally hold priv->lock for write.

    By deferring to RCU context, readers might find ECUs which have already
    reached __j1939_ecu_release(). Therefore, allow getting a ref on an ECU
    only when three conditions in (2) above are met.

(4) gpt-6-astra, opus-5-5, opus-5 and sonnet-5 are reporting that there is
    a possibility of deadlock between j1939_ecu_timer_handler() and
    j1939_ecu_timer_cancel(), for the former holds priv->lock while the
    latter calls hrtimer_cancel() (which synchronously waits for the former
    to complete) with priv->lock already held.

    Fix this problem by using hrtimer_try_to_cancel() with "release
    priv->lock, call hrtimer_cancel(), hold priv->lock again and restart
    from the beginning" fallback.

Reported-by: syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd
Link: https://lkml.kernel.org/r/179202402875.794844.18141702206663586949.b4-review@b4
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Previous version is "[PATCH v3] can: j1939: cancel pending address claim timers from j1939_ecu_unmap_all()"
at https://lkml.kernel.org/r/9ba38419-967a-4d47-bcdf-bbb2fa7d3e9f@I-love.SAKURA.ne.jp .

 net/can/j1939/address-claim.c |  10 ++-
 net/can/j1939/bus.c           | 112 ++++++++++++++++++++++++++++------
 net/can/j1939/j1939-priv.h    |   4 +-
 net/can/j1939/main.c          |   3 +
 4 files changed, 110 insertions(+), 19 deletions(-)

diff --git a/net/can/j1939/address-claim.c b/net/can/j1939/address-claim.c
index ca4ad6cdd5cb..2f27948d6e87 100644
--- a/net/can/j1939/address-claim.c
+++ b/net/can/j1939/address-claim.c
@@ -147,6 +147,7 @@ static void j1939_ac_process(struct j1939_priv *priv, struct sk_buff *skb)
 		return;
 	}
 
+restart:
 	write_lock_bh(&priv->lock);
 
 	/* Few words on the ECU ref counting:
@@ -212,7 +213,14 @@ static void j1939_ac_process(struct j1939_priv *priv, struct sk_buff *skb)
 		goto out_unlock_bh;
 
 	/* cancel pending (previous) address claim */
-	j1939_ecu_timer_cancel(ecu);
+	if (!j1939_ecu_timer_stopped(ecu)) {
+		write_unlock_bh(&priv->lock);
+		if (hrtimer_cancel(&ecu->ac_timer))
+			j1939_ecu_put(ecu);
+		/* Drop ref from j1939_ecu_get_by_name_locked() and retry. */
+		j1939_ecu_put(ecu);
+		goto restart;
+	}
 
 	if (j1939_address_is_idle(skcb->addr.sa)) {
 		j1939_ecu_unmap_locked(ecu);
diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index cdc3c0a71937..63210da8b7a8 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -14,25 +14,52 @@
 
 #include "j1939-priv.h"
 
-static void __j1939_ecu_release(struct kref *kref)
+static void __j1939_ecu_release_rcu(struct rcu_head *rcu)
 {
-	struct j1939_ecu *ecu = container_of(kref, struct j1939_ecu, kref);
+	struct j1939_ecu *ecu = container_of(rcu, struct j1939_ecu, rcu);
 	struct j1939_priv *priv = ecu->priv;
 
+	write_lock_bh(&priv->lock);
 	list_del(&ecu->list);
+	write_unlock_bh(&priv->lock);
 	netdev_put(priv->ndev, &ecu->priv_dev_tracker);
 	kfree(ecu);
 	j1939_priv_put(priv);
 }
 
+static void __j1939_ecu_release(struct kref *kref)
+{
+	struct j1939_ecu *ecu = container_of(kref, struct j1939_ecu, kref);
+
+	/* Since not all callers are calling j1939_ecu_put() with priv->lock
+	 * held for write, defer actual release to RCU context. By deferring to
+	 * RCU context, priv->ecus readers might find ECUs with ecu->kref == 0.
+	 * Therefore, priv->ecus readers must validate with j1939_ecu_valid() or
+	 * j1939_ecu_get().
+	 */
+	call_rcu(&ecu->rcu, __j1939_ecu_release_rcu);
+}
+
 void j1939_ecu_put(struct j1939_ecu *ecu)
 {
 	kref_put(&ecu->kref, __j1939_ecu_release);
 }
 
-static void j1939_ecu_get(struct j1939_ecu *ecu)
+static __must_check bool j1939_ecu_get(struct j1939_ecu *ecu)
 {
-	kref_get(&ecu->kref);
+	struct j1939_priv *priv = ecu->priv;
+
+	/* Don't get an ECU ref if netdev is no longer registered or
+	 * __j1939_rx_release() was called or __j1939_ecu_release() was called.
+	 */
+	return priv->ndev->reg_state == NETREG_REGISTERED &&
+		kref_read(&priv->rx_kref) && kref_get_unless_zero(&ecu->kref);
+}
+
+static __must_check bool j1939_ecu_valid(struct j1939_ecu *ecu)
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
@@ -99,8 +128,36 @@ void j1939_ecu_unmap(struct j1939_ecu *ecu)
 void j1939_ecu_unmap_all(struct j1939_priv *priv)
 {
 	int i;
+	struct j1939_ecu *ecu;
 
+restart:
 	write_lock_bh(&priv->lock);
+	/* Cancel all pending address claim timers before unmapping.
+	 * This prevents an orphaned late-firing timer from re-mapping
+	 * an ECU after the spaces are cleared. Since j1939_ecu_put()
+	 * might make , we need to skip invalid ECUs.
+	 */
+	list_for_each_entry(ecu, &priv->ecus, list) {
+		/* It is OK to call j1939_ecu_timer_stopped() even if there is
+		 * no ref on this ECU, for __j1939_ecu_release_rcu() has not
+		 * removed this ECU from priv->ecus list due to priv->lock.
+		 */
+		if (j1939_ecu_timer_stopped(ecu))
+			continue;
+		/* Keep this ECU valid while calling hrtimer_cancel(). But
+		 * don't use j1939_ecu_get() here, for we want to wait for
+		 * completion of timer callback regardless of netdev's state.
+		 */
+		if (!kref_get_unless_zero(&ecu->kref))
+			continue;
+		write_unlock_bh(&priv->lock);
+		if (hrtimer_cancel(&ecu->ac_timer))
+			j1939_ecu_put(ecu);
+		/* OK to release this ECU. */
+		j1939_ecu_put(ecu);
+		goto restart;
+	}
+	/* Unmap any remaining mapped ECUs */
 	for (i = 0; i < ARRAY_SIZE(priv->ents); i++)
 		if (priv->ents[i].ecu)
 			j1939_ecu_unmap_locked(priv->ents[i].ecu);
@@ -109,20 +166,33 @@ void j1939_ecu_unmap_all(struct j1939_priv *priv)
 
 void j1939_ecu_timer_start(struct j1939_ecu *ecu)
 {
+	lockdep_assert_held(&ecu->priv->lock);
+
 	/* The ECU is held here and released in the
-	 * j1939_ecu_timer_handler() or j1939_ecu_timer_cancel().
+	 * j1939_ecu_timer_handler() or j1939_ecu_timer_stopped()
+	 * or j1939_ecu_unmap_all() or j1939_ac_process().
 	 */
-	j1939_ecu_get(ecu);
+	if (!j1939_ecu_get(ecu))
+		return;
 
 	/* Schedule timer in 250 msec to commit address change. */
 	hrtimer_start(&ecu->ac_timer, ms_to_ktime(250),
 		      HRTIMER_MODE_REL_SOFT);
 }
 
-void j1939_ecu_timer_cancel(struct j1939_ecu *ecu)
+bool j1939_ecu_timer_stopped(struct j1939_ecu *ecu)
 {
-	if (hrtimer_cancel(&ecu->ac_timer))
+	switch (hrtimer_try_to_cancel(&ecu->ac_timer)) {
+	case 0: /* Not active or already finished. */
+		return true;
+	case 1: /* Successfully canceled. */
+		/* Drop a ref from j1939_ecu_timer_start(). */
 		j1939_ecu_put(ecu);
+		return true;
+	default: /* Currently executing. */
+		/* Leave how to handle to the caller. */
+		return false;
+	}
 }
 
 static enum hrtimer_restart j1939_ecu_timer_handler(struct hrtimer *hrtimer)
@@ -152,6 +222,13 @@ struct j1939_ecu *j1939_ecu_create_locked(struct j1939_priv *priv, name_t name)
 
 	lockdep_assert_held(&priv->lock);
 
+	/* Don't create a new ECU if netdev is no longer registered or
+	 * __j1939_rx_release() was called.
+	 */
+	if (priv->ndev->reg_state != NETREG_REGISTERED ||
+	    !kref_read(&priv->rx_kref))
+		return ERR_PTR(-ENOMEM);
+
 	ecu = kzalloc_obj(*ecu, gfp_any());
 	if (!ecu)
 		return ERR_PTR(-ENOMEM);
@@ -189,8 +266,8 @@ struct j1939_ecu *j1939_ecu_get_by_addr_locked(struct j1939_priv *priv, u8 addr)
 		return NULL;
 
 	ecu = j1939_ecu_find_by_addr_locked(priv, addr);
-	if (ecu)
-		j1939_ecu_get(ecu);
+	if (ecu && !j1939_ecu_get(ecu))
+		ecu = NULL;
 
 	return ecu;
 }
@@ -215,7 +292,7 @@ static struct j1939_ecu *j1939_ecu_find_by_name_locked(struct j1939_priv *priv,
 	lockdep_assert_held(&priv->lock);
 
 	list_for_each_entry(ecu, &priv->ecus, list) {
-		if (ecu->name == name)
+		if (ecu->name == name && j1939_ecu_valid(ecu))
 			return ecu;
 	}
 
@@ -232,11 +309,12 @@ struct j1939_ecu *j1939_ecu_get_by_name_locked(struct j1939_priv *priv,
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
index cf26352d1d8c..0cfb48eb61fe 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -42,6 +42,8 @@ struct j1939_ecu {
 
 	/* count users, to help transport protocol decide for interaction */
 	int nusers;
+
+	struct rcu_head rcu;
 };
 
 struct j1939_priv {
@@ -203,7 +205,7 @@ void j1939_simple_recv(struct j1939_priv *priv, struct sk_buff *skb);
 struct j1939_ecu *j1939_ecu_create_locked(struct j1939_priv *priv, name_t name);
 
 void j1939_ecu_timer_start(struct j1939_ecu *ecu);
-void j1939_ecu_timer_cancel(struct j1939_ecu *ecu);
+bool __must_check j1939_ecu_timer_stopped(struct j1939_ecu *ecu);
 void j1939_ecu_unmap_all(struct j1939_priv *priv);
 
 struct j1939_priv *j1939_netdev_start(struct net_device *ndev);
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 5e5e6c228f22..90a925a5c123 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -424,6 +424,9 @@ static __exit void j1939_module_exit(void)
 	can_proto_unregister(&j1939_can_proto);
 
 	unregister_netdevice_notifier(&j1939_netdev_notifier);
+
+	/* Wait for __j1939_ecu_release_rcu() to complete. */
+	rcu_barrier();
 }
 
 module_init(j1939_module_init);
-- 
2.55.0

