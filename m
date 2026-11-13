Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590021;
	b=ofCOG7mjdlHdc/saiRnErRJNiHpm764Os4qkuoTSpK9LAd9TiHa3b3DEZfUPr+xhwoBo
	 /3lRcr07olKXquuNI97lV+sslMIltgcaH8Jta1QARPEA8BjuNqfTw0repN8dy6doInzTw
	 qjeFSnwCVHdYaj7BEUHZbl3EP6f+KFoWpLK/5/iFCo0LPimiz2yu3CSR3sLZDX0mqBvqt
	 vLf8Q4Y58nZlJn6DIhHfbKzI0yt6cEG00E+JeGKz5tVbudUSB1ekW4Jcnbm4b53w7XWCS
	 RNiXSpQPy3nI8O/8nSnbXwVkDDfKaEEd7wPrKq7ZxAtRny1XGDt7X0Wn/6WZ/DwD1nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590021;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Content-Language:To:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-Virus-Status:X-Anti-Virus-Server;
	bh=h/tFEssfOzBG/tMjHgNR0r9qa9bqRR7TkjG4z5r0Gps=;
	b=wDK0A6ErwMoNTNToTJezlaPrd+//mG62FH/4GgYhhnnpKMOjDnxSq489lXmcO9qC7gLD
	 zcVo5f8TppWQ/D39f9e3XZCtgElhuOy9W9wxxXudcD7yPnx6dH6WBxC5eRjA6HEP6rO2Z
	 RXkXNg9imgmwnPstpR1baarf41vH8BUDRRdLtMRCW+HB6h9iyJXIOvJVCECzqZQYXY6eE
	 wBu4xNC6F5eUzuQMOWUuKw8Rr+OJYQdyW3e1OwC+abI/ZFTnukRkcefhvv9ILE8NNwyH7
	 av+1RWCodtmfiTiVtFjGhuqpjd8ANIUNVbxk7nuZfSh2EoQ+0+A1KI60IWpBxdekbbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DE5606A8AE
	for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 17:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97DE5606A8AE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6ADHD6K1088800;
	Sat, 14 Nov 2026 02:13:06 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6ADHD6Zb088797
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 14 Nov 2026 02:13:06 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8de287d7-b4e1-4062-b40e-b193f5ec68ca@I-love.SAKURA.ne.jp>
Date: Sat, 14 Nov 2026 02:13:05 +0900
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
Subject: [PATCH v12 1/3] can: j1939: fix possibility of UAF in
 __j1939_ecu_release()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav311.rs.sakura.ne.jp

Since j1939_ac_recv() and j1939_ac_fixup() are calling j1939_ecu_put()
without priv->lock held for write, list corruption and/or UAF might happen
if the last user called j1939_ecu_put() without priv->lock held for write.

Fix this problem by deferring release steps to WQ context where we can
unconditionally hold priv->lock for write.

By deferring to WQ context, readers might find ECUs which have already
reached __j1939_ecu_release(). Therefore, allow using an ECU only when
__j1939_ecu_release() is not yet called (indicated by ecu->kref > 0).

Since pending ecu->ac_timer is not canceled during j1939_ecu_unmap_all()
or __j1939_rx_release(), ecu->ac_timer can call j1939_ecu_timer_handler()
after __j1939_ecu_release() or j1939_module_exit().

Fix this problem by explicitly canceling ecu->ac_timer before kfree().

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 net/can/j1939/bus.c        | 68 ++++++++++++++++++++++++++++----------
 net/can/j1939/j1939-priv.h |  4 +++
 net/can/j1939/main.c       | 13 ++++++++
 3 files changed, 67 insertions(+), 18 deletions(-)

diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index cdc3c0a71937..c49c96dea796 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -14,25 +14,54 @@
 
 #include "j1939-priv.h"
 
-static void __j1939_ecu_release(struct kref *kref)
+struct workqueue_struct *j1939_ecu_wq;
+
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
+	queue_work(j1939_ecu_wq, &ecu->release_work);
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
@@ -56,15 +85,17 @@ static void j1939_ecu_map_locked(struct j1939_ecu *ecu)
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
@@ -109,10 +140,11 @@ void j1939_ecu_unmap_all(struct j1939_priv *priv)
 
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
@@ -122,6 +154,7 @@ void j1939_ecu_timer_start(struct j1939_ecu *ecu)
 void j1939_ecu_timer_cancel(struct j1939_ecu *ecu)
 {
 	if (hrtimer_cancel(&ecu->ac_timer))
+		/* Drop the ref from j1939_ecu_timer_start(). */
 		j1939_ecu_put(ecu);
 }
 
@@ -137,9 +170,7 @@ static enum hrtimer_restart j1939_ecu_timer_handler(struct hrtimer *hrtimer)
 	 */
 	j1939_ecu_map_locked(ecu);
 
-	/* The corresponding j1939_ecu_get() is in
-	 * j1939_ecu_timer_start().
-	 */
+	/* Drop the ref from j1939_ecu_timer_start(). */
 	j1939_ecu_put(ecu);
 	write_unlock_bh(&priv->lock);
 
@@ -189,8 +220,8 @@ struct j1939_ecu *j1939_ecu_get_by_addr_locked(struct j1939_priv *priv, u8 addr)
 		return NULL;
 
 	ecu = j1939_ecu_find_by_addr_locked(priv, addr);
-	if (ecu)
-		j1939_ecu_get(ecu);
+	if (ecu && !j1939_ecu_get(ecu))
+		ecu = NULL;
 
 	return ecu;
 }
@@ -215,7 +246,7 @@ static struct j1939_ecu *j1939_ecu_find_by_name_locked(struct j1939_priv *priv,
 	lockdep_assert_held(&priv->lock);
 
 	list_for_each_entry(ecu, &priv->ecus, list) {
-		if (ecu->name == name)
+		if (ecu->name == name && j1939_ecu_valid(ecu))
 			return ecu;
 	}
 
@@ -232,11 +263,12 @@ struct j1939_ecu *j1939_ecu_get_by_name_locked(struct j1939_priv *priv,
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
index cf26352d1d8c..623aeb2e54e1 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -42,6 +42,8 @@ struct j1939_ecu {
 
 	/* count users, to help transport protocol decide for interaction */
 	int nusers;
+
+	struct work_struct release_work;
 };
 
 struct j1939_priv {
@@ -345,4 +347,6 @@ void j1939_session_timers_cancel(struct j1939_session *session);
 /* CAN protocol */
 extern const struct can_proto j1939_can_proto;
 
+extern struct workqueue_struct *j1939_ecu_wq;
+
 #endif /* _J1939_PRIV_H_ */
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 5e5e6c228f22..22c272f8dfde 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -401,6 +401,12 @@ static __init int j1939_module_init(void)
 
 	pr_info("can: SAE J1939\n");
 
+	j1939_ecu_wq = alloc_workqueue("j1939_ecu", WQ_HIGHPRI | WQ_PERCPU, 0);
+	if (!j1939_ecu_wq) {
+		ret = -ENOMEM;
+		goto fail_wq;
+	}
+
 	ret = register_netdevice_notifier(&j1939_netdev_notifier);
 	if (ret)
 		goto fail_notifier;
@@ -416,6 +422,8 @@ static __init int j1939_module_init(void)
  fail_sk:
 	unregister_netdevice_notifier(&j1939_netdev_notifier);
  fail_notifier:
+	destroy_workqueue(j1939_ecu_wq);
+ fail_wq:
 	return ret;
 }
 
@@ -424,6 +432,11 @@ static __exit void j1939_module_exit(void)
 	can_proto_unregister(&j1939_can_proto);
 
 	unregister_netdevice_notifier(&j1939_netdev_notifier);
+
+	/* We need to make sure that __j1939_ecu_release_work() is
+	 * no longer running before unmapping memory for this module.
+	 */
+	destroy_workqueue(j1939_ecu_wq);
 }
 
 module_init(j1939_module_init);
-- 
2.56.0

