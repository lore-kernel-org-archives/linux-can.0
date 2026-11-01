Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793545223;
	b=vmt0+Vlqye5TAufr51Gn9WmUc/7XXrJt4kbKDIYMUOSMEXKSqCynAjinWeon38S+IT7m
	 wvGytsCyzOScuOxK2GU8a8YpVF5q3kBeKLdwAaq++E5RL9u8YLWHtxycxqd6u4gdTxX1+
	 k2+DbetkoRW3bEWQt7MJ1Fd+GHJdJO2XnOD7K2WMiJoXII8Ds/TRtn7nGr4WrPNHjePuN
	 nuwhvdszbhUGpmjZN8L6+r2lQ/RhUFyXA/tg+tM+zsOuWzMjb7iPxVOAiYLbNdSimVNw3
	 0XYpS/9Qd0qKqclwBltBjeMwWGNCaFFS7NytnnOhHmr22pNY6obr0wT9SU3G9CpTC2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793545223;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Content-Language:To:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-Anti-Virus-Server:X-Virus-Status;
	bh=HTdEsZP5MJKaJSMQiP6htBKUGf88Bk9hXhNWpHNljxs=;
	b=tZlOB7b9D6H23RGcdBqOj8acggAVydrDc1rBJuv6sAmmmKaX6ZyLv8QTKNtK/xM3A+TD
	 iFwiVIzJRqQoSF7pxYEOGAKQJeNnsooWg/j0qQzdmysCSOvg2RmthhdkHa10j/HKBTeOC
	 cuwivF9sMOKGrBfOF9DFG2uyrdbge6It+oC2d9+NJopiASGEZiTUTLCchfErW0plof4si
	 BsBYGgaUQo4RUJw5zcJbwfGzOEIBTOsaBa/9tKAfOYQVzIgEBXQ8NIQW/VLXIug1PADaH
	 ItGjQ3/SAUTmCgfQQf6z2TzUqy2sdv1u1jaMWRJ87wC2UCgWxYhTwTp3HO7TFIhe0Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE2D606A326
	for <linux-can@vger.kernel.org>; Sun,  1 Nov 2026 15:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AE2D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6A1ExodM085263;
	Sun, 1 Nov 2026 23:59:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6A1ExoxR085259
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 1 Nov 2026 23:59:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d0590019-f0c9-4288-9653-a7b6056012af@I-love.SAKURA.ne.jp>
Date: Sun, 1 Nov 2026 23:59:46 +0900
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
Subject: [PATCH v5] can: j1939: fix j1939_ecu refcount leak and related race
 conditions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav413.rs.sakura.ne.jp
X-Virus-Status: clean

This is a squashed patch that fixes three bugs.

Step 1: Fix possibility of list corruption in __j1939_ecu_release().

  Since not all callers are calling j1939_ecu_put() with priv->lock held
  for write, list corruption might happen if the last user called
  j1939_ecu_put() without priv->lock held for write.

  Fix this problem by deferring release steps to RCU context where we can
  unconditionally hold priv->lock for write.

  By deferring to RCU context, readers might find ECUs which have already
  reached __j1939_ecu_release(). Therefore, allow using an ECU only when
  __j1939_ecu_release() is not yet called (indicated by ecu->kref > 0).

Step 2: Fix possibility of deadlock in j1939_ecu_timer_cancel().

  Since j1939_ecu_timer_handler() takes priv->lock whereas hrtimer_cancel()
  from j1939_ecu_timer_cancel() with priv->lock already held synchronously
  waits for j1939_ecu_timer_handler() to complete, an AB-BA deadlock can
  happen.

  Fix this problem by using two-stage hrtimer (ac_wait_timer waits for
  250ms timeout, and hands over to ac_map_timer for committing changes) and
  ecu->flags for tracking the state of handing over.

  The fix for step 1 makes it possible to call j1939_ecu_put() regardless
  of whether priv->lock is held for write, and also makes it possible to
  wait for ac_wait_timer/ac_map_timer to complete using hrtimer_cancel()
  before kfree(ecu).

Step 3: Fix "struct j1939_ecu" refcount leak.

  Since

    j1939_ecu_get(ecu);
    priv->ents[ecu->addr] = ecu;

  in j1939_ecu_map_locked() from j1939_ecu_timer_handler() can succeed
  even after

    priv->ents[ecu->addr] = NULL;
    j1939_ecu_put(ecu);

  in j1939_ecu_unmap_locked() from j1939_ecu_unmap_all() from
  __j1939_rx_release() from j1939_netdev_stop() has completed,
  syzbot is reporting "struct j1939_ecu" refcount leak.

    unregister_netdevice: waiting for vcan0 to become free. Usage count = 3
    ref_tracker: netdev@ffff888038720720 has 1/2 users at
         __netdev_tracker_alloc include/linux/netdevice.h:4554 [inline]
         netdev_hold include/linux/netdevice.h:4583 [inline]
         j1939_ecu_create_locked+0x1fc/0x4d0 net/can/j1939/bus.c:159
         j1939_local_ecu_get+0x1b8/0x250 net/can/j1939/bus.c:293
         j1939_sk_bind+0x89b/0xdb0 net/can/j1939/socket.c:529
         __sys_bind_socket net/socket.c:1947 [inline]
         __sys_bind_socket net/socket.c:1939 [inline]
         __sys_bind+0x1a9/0x260 net/socket.c:1978
         __do_sys_bind net/socket.c:1983 [inline]
         __se_sys_bind net/socket.c:1981 [inline]
         __x64_sys_bind+0x72/0xb0 net/socket.c:1981
         do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
         do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
         entry_SYSCALL_64_after_hwframe+0x77/0x7f

    ref_tracker: netdev@ffff888038720720 has 1/2 users at
         __netdev_tracker_alloc include/linux/netdevice.h:4554 [inline]
         netdev_hold include/linux/netdevice.h:4583 [inline]
         j1939_priv_create net/can/j1939/main.c:140 [inline]
         j1939_netdev_start+0x2b8/0x990 net/can/j1939/main.c:268
         j1939_sk_bind+0x479/0xdb0 net/can/j1939/socket.c:506
         __sys_bind_socket net/socket.c:1947 [inline]
         __sys_bind_socket net/socket.c:1939 [inline]
         __sys_bind+0x1a9/0x260 net/socket.c:1978
         __do_sys_bind net/socket.c:1983 [inline]
         __se_sys_bind net/socket.c:1981 [inline]
         __x64_sys_bind+0x72/0xb0 net/socket.c:1981
         do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
         do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
         entry_SYSCALL_64_after_hwframe+0x77/0x7f

  Fix this problem by canceling pending address claim timers from
  j1939_ecu_unmap_all() and making j1939_ecu_get() fail unless three
  conditions listed below are met.

    (a) A netdev which is associated with j1939_priv is still registered
        (indicated by priv->ndev->reg_state == NETREG_REGISTERED).

    (b) __j1939_rx_release() is not yet called (indicated by
        priv->rx_kref > 0), for j1939_ecu_unmap_all() won't be called
        again after __j1939_rx_release() from j1939_netdev_stop() from
        j1939_netdev_notify(NETDEV_UNREGISTER) is once triggered.

    (c) __j1939_ecu_release() is not yet called (indicated by
        ecu->kref > 0)

  The fix for step 1 makes it possible to call j1939_ecu_put() regardless
  of whether priv->lock is held for write.

Reported-by: syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd
Link: https://lkml.kernel.org/r/179202402875.794844.18141702206663586949.b4-review@b4
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Previous version is "[PATCH v4] can: j1939: fix j1939_ecu refcount leak"
at https://lkml.kernel.org/r/4b2c8d95-d17e-4f36-a340-abf84693d24a@I-love.SAKURA.ne.jp .

 net/can/j1939/address-claim.c |   8 +-
 net/can/j1939/bus.c           | 189 ++++++++++++++++++++++++++++------
 net/can/j1939/j1939-priv.h    |  11 +-
 net/can/j1939/main.c          |   5 +
 4 files changed, 174 insertions(+), 39 deletions(-)

diff --git a/net/can/j1939/address-claim.c b/net/can/j1939/address-claim.c
index ca4ad6cdd5cb..821af11e9be4 100644
--- a/net/can/j1939/address-claim.c
+++ b/net/can/j1939/address-claim.c
@@ -160,8 +160,8 @@ static void j1939_ac_process(struct j1939_priv *priv, struct sk_buff *skb)
 	 * but only if the ECU was mapped before. So "ecu" still
 	 * belongs to us.
 	 *
-	 * j1939_ecu_timer_start() will increment the ref counter
-	 * before it starts the timer, so we can put the ecu when
+	 * j1939_ecu_wait_timer_start() will increment the ref counter
+	 * before it starts the wait timer, so we can put the ecu when
 	 * leaving this function.
 	 */
 	ecu = j1939_ecu_get_by_name_locked(priv, name);
@@ -212,7 +212,7 @@ static void j1939_ac_process(struct j1939_priv *priv, struct sk_buff *skb)
 		goto out_unlock_bh;
 
 	/* cancel pending (previous) address claim */
-	j1939_ecu_timer_cancel(ecu);
+	j1939_ecu_wait_timer_cancel(ecu);
 
 	if (j1939_address_is_idle(skcb->addr.sa)) {
 		j1939_ecu_unmap_locked(ecu);
@@ -237,7 +237,7 @@ static void j1939_ac_process(struct j1939_priv *priv, struct sk_buff *skb)
 		}
 	}
 
-	j1939_ecu_timer_start(ecu);
+	j1939_ecu_wait_timer_start(ecu);
  out_ecu_put:
 	j1939_ecu_put(ecu);
  out_unlock_bh:
diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index cdc3c0a71937..7980c87e004f 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -14,25 +14,64 @@
 
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
+	/* There should be no ref on this ECU, but we need to make sure that neither
+	 * j1939_ecu_wait_timer_handler() or j1939_ecu_map_timer_handler() is running
+	 * before releasing this ECU.
+	 *
+	 * We can use hrtimer_cancel(&ecu->ac_wait_timer), for
+	 * j1939_ecu_wait_timer_handler() does not hold priv->lock.
+	 *
+	 * We can use hrtimer_cancel(&ecu->ac_map_timer), for
+	 * we are not holding priv->lock here.
+	 */
+	WARN_ON(hrtimer_cancel(&ecu->ac_wait_timer));
+	WARN_ON(hrtimer_cancel(&ecu->ac_map_timer));
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
+	struct j1939_priv *priv = ecu->priv;
+
+	/* Don't get an ECU ref if netdev is no longer registered or
+	 * __j1939_rx_release() was called or __j1939_ecu_release() was called.
+	 */
+	return READ_ONCE(priv->ndev->reg_state) == NETREG_REGISTERED &&
+		kref_read(&priv->rx_kref) && kref_get_unless_zero(&ecu->kref);
+}
+
+static __must_check bool j1939_ecu_valid(struct j1939_ecu *ecu)
 {
-	kref_get(&ecu->kref);
+	/* Treat an ECU as invalid if __j1939_ecu_release() was called. */
+	return kref_read(&ecu->kref);
 }
 
 static bool j1939_ecu_is_mapped_locked(struct j1939_ecu *ecu)
@@ -56,15 +95,17 @@ static void j1939_ecu_map_locked(struct j1939_ecu *ecu)
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
@@ -101,48 +142,122 @@ void j1939_ecu_unmap_all(struct j1939_priv *priv)
 	int i;
 
 	write_lock_bh(&priv->lock);
+	if (READ_ONCE(priv->ndev->reg_state) != NETREG_REGISTERED) {
+		struct j1939_ecu *ecu;
+
+		/* Although j1939_ecu_get() from j1939_ecu_map_locked() from
+		 * j1939_ecu_map_timer_handler_locked() will fail if netdev is
+		 * no longer registered, try to bail out early by dropping
+		 * the ref from j1939_ecu_wait_timer_start() now in order to
+		 * speed up teardown operation.
+		 */
+		list_for_each_entry(ecu, &priv->ecus, list)
+			if (j1939_ecu_valid(ecu))
+				j1939_ecu_wait_timer_cancel(ecu);
+	}
 	for (i = 0; i < ARRAY_SIZE(priv->ents); i++)
 		if (priv->ents[i].ecu)
 			j1939_ecu_unmap_locked(priv->ents[i].ecu);
 	write_unlock_bh(&priv->lock);
 }
 
-void j1939_ecu_timer_start(struct j1939_ecu *ecu)
+void j1939_ecu_wait_timer_start(struct j1939_ecu *ecu)
 {
-	/* The ECU is held here and released in the
-	 * j1939_ecu_timer_handler() or j1939_ecu_timer_cancel().
+	lockdep_assert_held(&ecu->priv->lock);
+
+	/* The corresponding j1939_ecu_put() is in j1939_ecu_map_timer_handler_locked()
+	 * or j1939_ecu_wait_timer_cancel() or j1939_ecu_wait_timer_handler().
 	 */
-	j1939_ecu_get(ecu);
+	if (!j1939_ecu_get(ecu))
+		return;
 
 	/* Schedule timer in 250 msec to commit address change. */
-	hrtimer_start(&ecu->ac_timer, ms_to_ktime(250),
+	hrtimer_start(&ecu->ac_wait_timer, ms_to_ktime(250),
 		      HRTIMER_MODE_REL_SOFT);
 }
 
-void j1939_ecu_timer_cancel(struct j1939_ecu *ecu)
+static void j1939_ecu_map_timer_handler_locked(struct j1939_ecu *ecu)
 {
-	if (hrtimer_cancel(&ecu->ac_timer))
+	if (!test_and_clear_bit(0, &ecu->flags))
+		return;
+	/* TODO: can we test if ecu->addr is unicast before starting
+	 * the timer?
+	 */
+	j1939_ecu_map_locked(ecu);
+
+	/* The corresponding j1939_ecu_get() is in j1939_ecu_wait_timer_start(). */
+	j1939_ecu_put(ecu);
+}
+
+void j1939_ecu_wait_timer_cancel(struct j1939_ecu *ecu)
+{
+	if (hrtimer_cancel(&ecu->ac_wait_timer))
+		/* The corresponding j1939_ecu_get() is in j1939_ecu_wait_timer_start(). */
 		j1939_ecu_put(ecu);
+	j1939_ecu_map_timer_handler_locked(ecu);
 }
 
-static enum hrtimer_restart j1939_ecu_timer_handler(struct hrtimer *hrtimer)
+static enum hrtimer_restart j1939_ecu_map_timer_handler(struct hrtimer *hrtimer)
 {
 	struct j1939_ecu *ecu =
-		container_of(hrtimer, struct j1939_ecu, ac_timer);
+		container_of(hrtimer, struct j1939_ecu, ac_map_timer);
 	struct j1939_priv *priv = ecu->priv;
 
 	write_lock_bh(&priv->lock);
-	/* TODO: can we test if ecu->addr is unicast before starting
-	 * the timer?
-	 */
-	j1939_ecu_map_locked(ecu);
-
-	/* The corresponding j1939_ecu_get() is in
-	 * j1939_ecu_timer_start().
-	 */
-	j1939_ecu_put(ecu);
+	j1939_ecu_map_timer_handler_locked(ecu);
 	write_unlock_bh(&priv->lock);
+	return HRTIMER_NORESTART;
+}
 
+static enum hrtimer_restart j1939_ecu_wait_timer_handler(struct hrtimer *hrtimer)
+{
+	struct j1939_ecu *ecu =
+		container_of(hrtimer, struct j1939_ecu, ac_wait_timer);
+
+	/*
+	 * Since we can't commit this address change from this context because we need to hold
+	 * priv->lock for write before committing while hrtimer_cancel() (which waits for this
+	 * context to complete) is called with priv->lock held for write, schedule
+	 * j1939_ecu_map_timer_handler_locked() (which is called from a different context with
+	 * priv->lock held for write) to commit this address change.
+	 *
+	 * The !test_and_set_bit() in j1939_ecu_wait_timer_handler() and
+	 * the test_and_clear_bit() in j1939_ecu_map_timer_handler_locked() pair guarantees that
+	 * the ref from j1939_ecu_wait_timer_start() is dropped for exactly once.
+	 *
+	 * The !test_and_set_bit() condition here is likely true due to reasons listed below.
+	 *
+	 *   (1) j1939_ecu_wait_timer_cancel(ecu) and j1939_ecu_wait_timer_start(ecu) are
+	 *       serialized by ecu->priv->lock
+	 *   (2) scheduling of ecu->ac_map_timer does not happen if
+	 *       hrtimer_cancel(&ecu->ac_wait_timer) from j1939_ecu_wait_timer_cancel(ecu) was
+	 *       called before j1939_ecu_wait_timer_handler(&ecu->ac_wait_timer) is fired
+	 *   (3) scheduling of ecu->ac_map_timer completes before
+	 *       hrtimer_cancel(&ecu->ac_wait_timer) from j1939_ecu_wait_timer_cancel(ecu) returns
+	 *       if j1939_ecu_wait_timer_handler(&ecu->ac_wait_timer) was fired before
+	 *       hrtimer_cancel(&ecu->ac_wait_timer) from j1939_ecu_wait_timer_cancel(ecu) is
+	 *       called
+	 *   (4) ecu->ac_map_timer has shorter expiry time than ecu->ac_wait_timer, which should
+	 *       fire j1939_ecu_map_timer_handler(&ecu->ac_map_timer) before
+	 *       j1939_ecu_wait_timer_handler(&ecu->ac_wait_timer) is fired as long as
+	 *       ecu->ac_map_timer is scheduled by previous j1939_ecu_wait_timer_handler()
+	 *       before ecu->ac_wait_timer is scheduled by current j1939_ecu_wait_timer_start()
+	 *
+	 * However, if something significantly delayed firing of j1939_ecu_map_timer_handler()
+	 * enough to fire j1939_ecu_wait_timer_handler() before j1939_ecu_map_timer_handler() is
+	 * fired, blindly scheduling ecu->ac_map_timer will fail to drop the ref from previous
+	 * j1939_ecu_wait_timer_start(). Therefore, drop the ref from current
+	 * j1939_ecu_wait_timer_start() if such race condition happened.
+	 */
+	if (likely(!test_and_set_bit(0, &ecu->flags))) {
+		hrtimer_start(&ecu->ac_map_timer, ms_to_ktime(0), HRTIMER_MODE_REL_SOFT);
+	} else {
+		netdev_warn(ecu->priv->ndev,
+			    "Skipped mapping ECU, addr: 0x%02x, name: 0x%016llx.\n",
+			    ecu->addr, ecu->name);
+		/* The corresponding j1939_ecu_get() is in j1939_ecu_wait_timer_start(). */
+		j1939_ecu_put(ecu);
+	}
 	return HRTIMER_NORESTART;
 }
 
@@ -152,6 +267,13 @@ struct j1939_ecu *j1939_ecu_create_locked(struct j1939_priv *priv, name_t name)
 
 	lockdep_assert_held(&priv->lock);
 
+	/* Don't create a new ECU if netdev is no longer registered or
+	 * __j1939_rx_release() was called.
+	 */
+	if (READ_ONCE(priv->ndev->reg_state) != NETREG_REGISTERED ||
+	    !kref_read(&priv->rx_kref))
+		return ERR_PTR(-ENODEV);
+
 	ecu = kzalloc_obj(*ecu, gfp_any());
 	if (!ecu)
 		return ERR_PTR(-ENOMEM);
@@ -160,7 +282,9 @@ struct j1939_ecu *j1939_ecu_create_locked(struct j1939_priv *priv, name_t name)
 	ecu->addr = J1939_IDLE_ADDR;
 	ecu->name = name;
 
-	hrtimer_setup(&ecu->ac_timer, j1939_ecu_timer_handler, CLOCK_MONOTONIC,
+	hrtimer_setup(&ecu->ac_wait_timer, j1939_ecu_wait_timer_handler, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL_SOFT);
+	hrtimer_setup(&ecu->ac_map_timer, j1939_ecu_map_timer_handler, CLOCK_MONOTONIC,
 		      HRTIMER_MODE_REL_SOFT);
 	INIT_LIST_HEAD(&ecu->list);
 
@@ -189,8 +313,8 @@ struct j1939_ecu *j1939_ecu_get_by_addr_locked(struct j1939_priv *priv, u8 addr)
 		return NULL;
 
 	ecu = j1939_ecu_find_by_addr_locked(priv, addr);
-	if (ecu)
-		j1939_ecu_get(ecu);
+	if (ecu && !j1939_ecu_get(ecu))
+		ecu = NULL;
 
 	return ecu;
 }
@@ -215,7 +339,7 @@ static struct j1939_ecu *j1939_ecu_find_by_name_locked(struct j1939_priv *priv,
 	lockdep_assert_held(&priv->lock);
 
 	list_for_each_entry(ecu, &priv->ecus, list) {
-		if (ecu->name == name)
+		if (ecu->name == name && j1939_ecu_valid(ecu))
 			return ecu;
 	}
 
@@ -232,11 +356,12 @@ struct j1939_ecu *j1939_ecu_get_by_name_locked(struct j1939_priv *priv,
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
index cf26352d1d8c..48769eab6c3d 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -35,13 +35,18 @@ struct j1939_ecu {
 	u8 addr;
 
 	/* indicates that this ecu successfully claimed @sa as its address */
-	struct hrtimer ac_timer;
+	struct hrtimer ac_wait_timer;
+	struct hrtimer ac_map_timer;
 	struct kref kref;
 	struct j1939_priv *priv;
 	netdevice_tracker priv_dev_tracker;
 
 	/* count users, to help transport protocol decide for interaction */
 	int nusers;
+
+	struct rcu_head rcu;
+	/* Bit 0: Ready to commit address change. */
+	unsigned long flags;
 };
 
 struct j1939_priv {
@@ -202,8 +207,8 @@ void j1939_simple_recv(struct j1939_priv *priv, struct sk_buff *skb);
 /* network management */
 struct j1939_ecu *j1939_ecu_create_locked(struct j1939_priv *priv, name_t name);
 
-void j1939_ecu_timer_start(struct j1939_ecu *ecu);
-void j1939_ecu_timer_cancel(struct j1939_ecu *ecu);
+void j1939_ecu_wait_timer_start(struct j1939_ecu *ecu);
+void j1939_ecu_wait_timer_cancel(struct j1939_ecu *ecu);
 void j1939_ecu_unmap_all(struct j1939_priv *priv);
 
 struct j1939_priv *j1939_netdev_start(struct net_device *ndev);
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
2.55.0

