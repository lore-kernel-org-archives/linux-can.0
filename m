Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794720923;
	b=NluUjxcLnbxpLP7pZ1FJU+7FiSHrcxq3HyLvokCv1rl5oF8OIIQc30NhrkXSygmaNkwb
	 RAqSTwOoAJjG04QFTnXTJrSyFxvHEmLNEBwGvoU9ou+e4o7FmEx+lf3w6eI5XJUKqkZQ/
	 iUwR8NjoW+KHbdThDKg3j7CyunUaAR8HtKmlChpSXRNEVM7m9Xbdpr2ZEio3C60wjRR8P
	 rSTo5E9gqoO6aLE/cSp/ohtU5VbxsDAChHeuZMNoHHiL9i2knpR8KVVZqBI1xEaN4aX5l
	 5PiwIRZA6OxZQfMuIResvuYIHoK59eQkbs5Zm4JQNzmkDdKb5PSYfASfWJJPhGyyuFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794720923;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Virus-Status:
	 X-Anti-Virus-Server;
	bh=grs/bRaUTt7PJuEQdqpe1ZdKSA7rcQ68j2KP37K8RUY=;
	b=jCRTui3NW/YHp/0I2dZmERtWQgkVTe/FmOmwo4xB1XYAXwBK94qc85nlvfJeitzRAam3
	 KxuSbypZlT+bIYjxuOMY8/lhsL4Y6TUtViVxPFXVDb7y6VC83D2HffxETPLfebCY6yCQt
	 295CEicHQhm+5eEliLDbyajFq8wQzwdIlWBYHvllKBSCTmUjPyETBUkxD1YnaldR1aMWq
	 RZKG+SK01CfBR7VFss4DTDKGNrzwB0DA7SZp/gFT7YgB8xJ+cT5+fS/w81ngOr9uMAwvM
	 eWJ/2uwNC49vMAsjq6mNIcXFNsseAT3AZISy4JdYavkhSQBMQbj0nJ5NigA21tppkPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D69A606A323
	for <linux-can@vger.kernel.org>; Sun, 15 Nov 2026 05:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D69A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6AF5ZA4E072175;
	Sun, 15 Nov 2026 14:35:10 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6AF5ZAQd072171
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 15 Nov 2026 14:35:10 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1885f3ed-e560-4cbf-aa0e-96cb1718b394@I-love.SAKURA.ne.jp>
Date: Sun, 15 Nov 2026 14:35:10 +0900
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
Subject: [PATCH v13 3/6] can: j1939: fix possibility of list corruption in
 __j1939_ecu_release()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>
References: <7cc08b0f-290e-464b-ab13-0a5ce3c57f4f@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <7cc08b0f-290e-464b-ab13-0a5ce3c57f4f@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav112.rs.sakura.ne.jp

Since j1939_ac_recv() and j1939_ac_fixup() are calling j1939_ecu_put()
without priv->lock held for write, list corruption might happen if the
last user called j1939_ecu_put() without priv->lock held for write.

Instead of requiring all j1939_ecu_put() callers to hold priv->lock for
write, fix this problem by deferring release steps of "struct j1939_ecu"
to WQ context where we can unconditionally hold priv->lock for write.

By deferring to WQ context, readers might find ECUs which have already
reached __j1939_ecu_release(). Therefore, allow using an ECU only when
__j1939_ecu_release() is not yet called (indicated by ecu->kref > 0).

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 net/can/j1939/bus.c        | 61 +++++++++++++++++++++++++++-----------
 net/can/j1939/j1939-priv.h |  2 ++
 net/can/j1939/main.c       |  5 ++--
 3 files changed, 48 insertions(+), 20 deletions(-)

diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index cdc3c0a71937..0aeeee1491e4 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -14,25 +14,47 @@
 
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
+{
+	/* Don't get an ECU ref if __j1939_ecu_release() was called. */
+	return kref_get_unless_zero(&ecu->kref);
+}
+
+static bool __must_check j1939_ecu_valid(struct j1939_ecu *ecu)
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
+		/* Drop the ref from j1939_ecu_timer_start(). */
 		j1939_ecu_put(ecu);
 }
 
@@ -137,9 +163,7 @@ static enum hrtimer_restart j1939_ecu_timer_handler(struct hrtimer *hrtimer)
 	 */
 	j1939_ecu_map_locked(ecu);
 
-	/* The corresponding j1939_ecu_get() is in
-	 * j1939_ecu_timer_start().
-	 */
+	/* Drop the ref from j1939_ecu_timer_start(). */
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
index ff90683f33f4..55ded221cd82 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -42,6 +42,8 @@ struct j1939_ecu {
 
 	/* count users, to help transport protocol decide for interaction */
 	int nusers;
+
+	struct work_struct release_work;
 };
 
 struct j1939_priv {
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index a28216021020..d5e06b1beff5 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -476,8 +476,9 @@ static __exit void j1939_module_exit(void)
 
 	unregister_netdevice_notifier(&j1939_netdev_notifier);
 
-	/* We need to make sure that __j1939_priv_release_work() is
-	 * no longer running before unmapping memory for this module.
+	/* We need to make sure that __j1939_priv_release_work() and
+	 * __j1939_ecu_release_work() are no longer running before
+	 * unmapping memory for this module.
 	 */
 	destroy_workqueue(j1939_wq);
 }
-- 
2.56.0

