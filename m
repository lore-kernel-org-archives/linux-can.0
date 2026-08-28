Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0704353A60
	for <linux-can@vger.kernel.org>; Fri, 28 Aug 2026 06:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787899599; cv=none; b=J0rqu25tqVg+ohES5vKHdcGYdwIiIoh5C2VuLog3K8CJujTDt/OGYRYy31ji7dGE+27FdWh9GUbaDSMULre37vvNx94Pa0lyB92B5jMJw21ctCOGIvyNM8rhoTSgvw1icEeZoEr/DTnDuqVg6KZMJIhtBkGTGAxVrK0zS70pZKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787899599; c=relaxed/simple;
	bh=TKhYtYBZYsAUYz6AEDz34wRSM36MHYBNyHzeaJMwNEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R2eISfOCyzbPhSPToV+l8kOK6w3FRN4JA0AtwZHpCyDOt9CYgLO/MTNZu+hPmHG7WO1rKuylhjqXeoWD+FMSBdiTzndZKqfIRvew8ERP39dR6ejJevzlouP4B5DrRwUeCWYi7e39D9sl+SG1TjGabTQyXcLElEhX33O+Y3res0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=rs8D3m3H; arc=none smtp.client-ip=178.154.239.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="rs8D3m3H"
Received: from mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:25c9:0:640:b4bd:0])
	by forward102b.mail.yandex.net (postfix) with ESMTPS id 09DCEC03ED;
	Fri, 28 Aug 2026 09:46:32 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (smtp) with ESMTPSA id UkYJTrHfKmI0-mdmtgdEh;
	Fri, 28 Aug 2026 09:46:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1787899591; bh=bxoQHMfpMxjQHIwqs9gyUhXJ9gcAAQSVy6NMRG7/W7A=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=rs8D3m3HcLZFh7eYY8L3voRS2b7xN+IhVQxYiUSP8rw2P9K0JLEIHwqKggSc6MOjg
	 jK3xwig9qgzTvj0aFjh26+QTBPW7BbzjHOFcxV+/LqEFWRzKa/w9nBjXapagJjLjxB
	 izslBGk1zv3m1i9jFt2t4GvEBqX/Hfk+VdipBvtI=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v3 1/2] can: j1939: make hrtimer callback lockless and free ECUs asyncronously
Date: Fri, 28 Aug 2026 09:46:20 +0300
Message-ID: <20260828064621.91364-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In j1939_ecu_map_locked(), it is not needed to lock 'struct j1939_priv'
just to claim ECU slot. This may be accomplished by using cmpxchg() on
ECU slot pointer. This way, convert j1939_ecu_map_locked() to
j1939_ecu_map_atomic() and make j1939_ecu_timer_handler() lockless.

Now, if hrtimer handler is lockless, the following calls from multiple
handlers may trigger concurrent modifications of ECU list:

-> j1939_ecu_timer_handler()
   -> j1939_ecu_put()
      -> __j1939_ecu_release()
         -> list_del()

To avoid this, offload actual ECU removal to schedule_work(). Since
the work handler runs in process context, this is a way better place
to perform an operation which requires 'struct j1939_priv' locking
(and suits PREEMPT_RT better as well).

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v3: initial version to join the series
---
 net/can/j1939/bus.c        | 27 ++++++++++++++++-----------
 net/can/j1939/j1939-priv.h |  1 +
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index cdc3c0a71937..a347594b8c1c 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -14,17 +14,27 @@
 
 #include "j1939-priv.h"
 
-static void __j1939_ecu_release(struct kref *kref)
+static void __j1939_ecu_work(struct work_struct *work)
 {
-	struct j1939_ecu *ecu = container_of(kref, struct j1939_ecu, kref);
+	struct j1939_ecu *ecu = container_of(work, struct j1939_ecu, work);
 	struct j1939_priv *priv = ecu->priv;
 
+	write_lock(&priv->lock);
 	list_del(&ecu->list);
 	netdev_put(priv->ndev, &ecu->priv_dev_tracker);
 	kfree(ecu);
+	write_unlock(&priv->lock);
+
 	j1939_priv_put(priv);
 }
 
+static void __j1939_ecu_release(struct kref *kref)
+{
+	struct j1939_ecu *ecu = container_of(kref, struct j1939_ecu, kref);
+
+	schedule_work(&ecu->work);
+}
+
 void j1939_ecu_put(struct j1939_ecu *ecu)
 {
 	kref_put(&ecu->kref, __j1939_ecu_release);
@@ -46,26 +56,23 @@ static bool j1939_ecu_is_mapped_locked(struct j1939_ecu *ecu)
 
 /* ECU device interface */
 /* map ECU to a bus address space */
-static void j1939_ecu_map_locked(struct j1939_ecu *ecu)
+static void j1939_ecu_map_atomic(struct j1939_ecu *ecu)
 {
 	struct j1939_priv *priv = ecu->priv;
 	struct j1939_addr_ent *ent;
 
-	lockdep_assert_held(&priv->lock);
-
 	if (!j1939_address_is_unicast(ecu->addr))
 		return;
 
 	ent = &priv->ents[ecu->addr];
 
-	if (ent->ecu) {
+	if (cmpxchg(&ent->ecu, NULL, ecu)) {
 		netdev_warn(priv->ndev, "Trying to map already mapped ECU, addr: 0x%02x, name: 0x%016llx. Skip it.\n",
 			    ecu->addr, ecu->name);
 		return;
 	}
 
 	j1939_ecu_get(ecu);
-	ent->ecu = ecu;
 	ent->nusers += ecu->nusers;
 }
 
@@ -129,19 +136,16 @@ static enum hrtimer_restart j1939_ecu_timer_handler(struct hrtimer *hrtimer)
 {
 	struct j1939_ecu *ecu =
 		container_of(hrtimer, struct j1939_ecu, ac_timer);
-	struct j1939_priv *priv = ecu->priv;
 
-	write_lock_bh(&priv->lock);
 	/* TODO: can we test if ecu->addr is unicast before starting
 	 * the timer?
 	 */
-	j1939_ecu_map_locked(ecu);
+	j1939_ecu_map_atomic(ecu);
 
 	/* The corresponding j1939_ecu_get() is in
 	 * j1939_ecu_timer_start().
 	 */
 	j1939_ecu_put(ecu);
-	write_unlock_bh(&priv->lock);
 
 	return HRTIMER_NORESTART;
 }
@@ -156,6 +160,7 @@ struct j1939_ecu *j1939_ecu_create_locked(struct j1939_priv *priv, name_t name)
 	if (!ecu)
 		return ERR_PTR(-ENOMEM);
 	kref_init(&ecu->kref);
+	INIT_WORK(&ecu->work, __j1939_ecu_work);
 	netdev_hold(priv->ndev, &ecu->priv_dev_tracker, gfp_any());
 	ecu->addr = J1939_IDLE_ADDR;
 	ecu->name = name;
diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index cf26352d1d8c..080d5b4c8c23 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -37,6 +37,7 @@ struct j1939_ecu {
 	/* indicates that this ecu successfully claimed @sa as its address */
 	struct hrtimer ac_timer;
 	struct kref kref;
+	struct work_struct work;
 	struct j1939_priv *priv;
 	netdevice_tracker priv_dev_tracker;
 
-- 
2.55.0

