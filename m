Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793617051;
	b=1Yv5G9pmQEo/UuXR6/3zEXvoc1UXD07Ovpxc4qdoU8F91jHc8uXrOW13u88f1l7yiQwT
	 vRzx5WwJdYfzOTft3Jd5dKORDW1Q0CCuAd20vIStxt1TSB9DbO6QogJXRk1A2pi1l+fS7
	 BCGWdoHEfWLNZXPoIFTZHDjSVsUSwjzLRgXl2L0G8TMW43FGJjRwAEMWNISA4wWN1hbjP
	 N0JdwOjfTM43acZd7/DmyFK+PXAOp/XkRo6gt7+1ikgy3F8DKW+prbDhLU5JvgrCCCLQR
	 dULO3pL1XCOvTTbGzotUhGaKkje7zi6OxFlVMeUrV3bsNaOxn5Lb7BUyTGJSGrpLYpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793617051;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Content-Language:To:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-Virus-Status:X-Anti-Virus-Server;
	bh=WjrqARqw6Los9ofHsXjBs32+YEJBxdf5r2PYdCGG7v0=;
	b=g6aa46GIU4ZwEKU1JdRrZjFSfjvqctomRelr7IRKhc1olMrsnnc8M0XBulCPMx/ZHEOH
	 sSoOBD6/ZvcUq1NUSvZlJnzPDZUDxngngE56OqumMGslsV+tkJc3VwbAXW6l6wEh3kKiL
	 N3hTJBah1+59ATpaNy2KV1nynCUfSQGhUycpRxTD1h0+WUHtE14IDD6F8yZRF6Ja/4fkh
	 hj9/dHxoCOr7iK0t6fUk3g9kc0d5VShv9kaixle/4CoP++G0t6fLC1bjkArnbdiq7CVSc
	 NVHN0fgRzVBrzaAp0tEsV2wy+0fgRB14PSd+we4VzeYMoh7UfebmTW4gquj8dmL9qJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E9460A2611
	for <linux-can@vger.kernel.org>; Mon,  2 Nov 2026 10:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2E9460A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6A2AvSl3054480
	for <linux-can@vger.kernel.org>; Mon, 2 Nov 2026 19:57:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6A2AvSeu054476
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
	for <linux-can@vger.kernel.org>; Mon, 2 Nov 2026 19:57:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <cd646674-a0d6-4f00-b24b-99746ece7e43@I-love.SAKURA.ne.jp>
Date: Mon, 2 Nov 2026 19:57:27 +0900
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
To: linux-can@vger.kernel.org
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] can: j1939: fix possibility of list corruption in
 __j1939_ecu_release()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav211.rs.sakura.ne.jp

Since not all callers are calling j1939_ecu_put() with priv->lock held
for write, list corruption might happen if the last user called
j1939_ecu_put() without priv->lock held for write.

Fix this problem by deferring release steps to RCU context where we can
unconditionally hold priv->lock for write.

By deferring to RCU context, readers might find ECUs which have already
reached __j1939_ecu_release(). Therefore, allow using an ECU only when
__j1939_ecu_release() is not yet called (indicated by ecu->kref > 0).

Note that despite using RCU, rcu_read_lock()/rcu_read_unlock() are not
added because write_lock_bh(&priv->lock) in __j1939_ecu_release_rcu()
serves as a barrier after an RCU grace period has elapsed.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 net/can/j1939/bus.c        | 61 +++++++++++++++++++++++++++-----------
 net/can/j1939/j1939-priv.h |  2 ++
 net/can/j1939/main.c       |  5 ++++
 3 files changed, 50 insertions(+), 18 deletions(-)

diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index cdc3c0a71937..ed60258619e6 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -14,25 +14,47 @@
 
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
+{
+	/* Don't get an ECU ref if __j1939_ecu_release() was called. */
+	return kref_get_unless_zero(&ecu->kref);
+}
+
+static __must_check bool j1939_ecu_valid(struct j1939_ecu *ecu)
 {
-	kref_get(&ecu->kref);
+	/* Treat an ECU as invalid if __j1939_ecu_release() was called. */
+	return kref_read(&ecu->kref);
 }
 
 static bool j1939_ecu_is_mapped_locked(struct j1939_ecu *ecu)
@@ -56,15 +78,17 @@ static void j1939_ecu_map_locked(struct j1939_ecu *ecu)
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
@@ -109,10 +133,11 @@ void j1939_ecu_unmap_all(struct j1939_priv *priv)
 
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
@@ -122,6 +147,7 @@ void j1939_ecu_timer_start(struct j1939_ecu *ecu)
 void j1939_ecu_timer_cancel(struct j1939_ecu *ecu)
 {
 	if (hrtimer_cancel(&ecu->ac_timer))
+		/* The corresponding j1939_ecu_get() is in j1939_ecu_timer_start(). */
 		j1939_ecu_put(ecu);
 }
 
@@ -137,9 +163,7 @@ static enum hrtimer_restart j1939_ecu_timer_handler(struct hrtimer *hrtimer)
 	 */
 	j1939_ecu_map_locked(ecu);
 
-	/* The corresponding j1939_ecu_get() is in
-	 * j1939_ecu_timer_start().
-	 */
+	/* The corresponding j1939_ecu_get() is in j1939_ecu_timer_start(). */
 	j1939_ecu_put(ecu);
 	write_unlock_bh(&priv->lock);
 
@@ -189,8 +213,8 @@ struct j1939_ecu *j1939_ecu_get_by_addr_locked(struct j1939_priv *priv, u8 addr)
 		return NULL;
 
 	ecu = j1939_ecu_find_by_addr_locked(priv, addr);
-	if (ecu)
-		j1939_ecu_get(ecu);
+	if (ecu && !j1939_ecu_get(ecu))
+		ecu = NULL;
 
 	return ecu;
 }
@@ -215,7 +239,7 @@ static struct j1939_ecu *j1939_ecu_find_by_name_locked(struct j1939_priv *priv,
 	lockdep_assert_held(&priv->lock);
 
 	list_for_each_entry(ecu, &priv->ecus, list) {
-		if (ecu->name == name)
+		if (ecu->name == name && j1939_ecu_valid(ecu))
 			return ecu;
 	}
 
@@ -232,11 +256,12 @@ struct j1939_ecu *j1939_ecu_get_by_name_locked(struct j1939_priv *priv,
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
index cf26352d1d8c..ee85b36e122d 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -42,6 +42,8 @@ struct j1939_ecu {
 
 	/* count users, to help transport protocol decide for interaction */
 	int nusers;
+
+	struct rcu_head rcu;
 };
 
 struct j1939_priv {
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 5e5e6c228f22..bdf536440ade 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -424,6 +424,11 @@ static __exit void j1939_module_exit(void)
 	can_proto_unregister(&j1939_can_proto);
 
 	unregister_netdevice_notifier(&j1939_netdev_notifier);
+
+	/* We need to make sure that __j1939_ecu_release_rcu() is
+	 * no longer running before unmapping memory for this module.
+	 */
+	rcu_barrier();
 }
 
 module_init(j1939_module_init);
-- 
2.56.0

