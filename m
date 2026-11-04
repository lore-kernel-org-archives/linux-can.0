Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804034;
	b=fG7Zhg1eZ97f0Fzkl+9zXRfuimpSmcoY5Khb5+VnRmjdz5R3oHfpFxdzlC9yGTFK1pJ2
	 GePfyHaAeWs9UubOK5DpMa5ZhcBrjpFV63GDiDFKMxrQc0L2hg0bjZUMvcigQyhxm6EGU
	 JcmRy5GOs/pwECVDxvsngQPUNSk0LVWazYHLKLHazFn/kECmXMmSpK/nlR97r9c/wl32o
	 rtwAd32k/0GcLmg4PmQ6/vW1kM1NAuDnLA5eVidXG0wornVIDdA3DZpUoBzQY0WXg+D1C
	 LYTNN70RZ6ojjuHGw90PV0z/VIOcCqqyTKe7tc0a4KQD9PqoYFy+raIXqKP/cj9H6RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804034;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Content-Language:To:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-Virus-Status:X-Anti-Virus-Server;
	bh=pvOHK1aVUp0HIYqHcnjXYUL/TxnANS4pFRslG+QBuaA=;
	b=0XJg2i9NSi5ZVkKFswNn2dNSiAoItsSThnJP6lxzL0go3yMcAGu7hi6CY18syZudNdFo
	 8WiVqxPBBt64mvgM9/xN0QG/8D9q7dC5+fIx94Ry2UAe7molY8Js1/3yScx//cqfBj15C
	 ZT+qJoHuhp3zYHOwIZNhV4iRcIyRMCEn4pAgYGT1oeieEiY6l1it6V+1HrL809uGWAQw6
	 L8Bvx9BtsWDccPJwdopnPI+OU/Pc58wyx5i6mJn6/tVFvhaj3q0zBfAeRGwFSAHg1W3EC
	 J6pSi5ssPJXjNPlhT/iYSEEuMLpmuWzWfKvOJIWsSE6kT7Rek+VM4L/b067Q28FI3OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE46606A326
	for <linux-can@vger.kernel.org>; Wed,  4 Nov 2026 14:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EE46606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6A4ErHX8056063;
	Wed, 4 Nov 2026 23:53:17 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6A4ErHGI056060
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 4 Nov 2026 23:53:17 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c9de355a-d66e-4f28-9636-a6fef8fe8b84@I-love.SAKURA.ne.jp>
Date: Wed, 4 Nov 2026 23:53:14 +0900
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
Subject: [PATCH v6] can: j1939: fix j1939_ecu refcount leak and related race
 conditions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav212.rs.sakura.ne.jp

This is a squashed patch that fixes three bugs.

Step 1: Fix possibility of list corruption in __j1939_ecu_release().

  Since not all callers are calling j1939_ecu_put() with priv->lock held
  for write, list corruption might happen if the last user called
  j1939_ecu_put() without priv->lock held for write.

  Fix this problem by deferring release steps to WQ context where we can
  unconditionally hold priv->lock for write.

  By deferring to WQ context, readers might find ECUs which have already
  reached __j1939_ecu_release(). Therefore, allow using an ECU only when
  __j1939_ecu_release() is not yet called (indicated by ecu->kref > 0).

Step 2: Fix possibility of deadlock in j1939_ecu_timer_cancel().

  Since j1939_ecu_timer_handler() takes priv->lock whereas hrtimer_cancel()
  from j1939_ecu_timer_cancel() with priv->lock already held synchronously
  waits for j1939_ecu_timer_handler() to complete, an AB-BA deadlock can
  happen.

  Fix this problem by handing over from j1939_ecu_timer_handler() to
  j1939_ecu_tasklet_handler() using ecu->flags for tracking the state of
  handing over.

  The fix for step 1 makes it possible to call j1939_ecu_put() regardless
  of whether priv->lock is held for write, and also makes it possible to
  wait for ac_timer to complete using hrtimer_cancel() and wait for
  ac_tasklet to complete using tasklet_kill() before kfree(ecu).

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
Previous version is "[PATCH v5] can: j1939: fix j1939_ecu refcount leak and related race conditions"
at https://lkml.kernel.org/r/d0590019-f0c9-4288-9653-a7b6056012af@I-love.SAKURA.ne.jp .

 net/can/j1939/bus.c        | 172 ++++++++++++++++++++++++++++++++-----
 net/can/j1939/j1939-priv.h |   7 ++
 net/can/j1939/main.c       |  13 +++
 3 files changed, 170 insertions(+), 22 deletions(-)

diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index cdc3c0a71937..632e9aed6cf5 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -14,25 +14,62 @@
 
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
+	 * j1939_ecu_timer_handler() and j1939_ecu_tasklet_handler()
+	 * are no longer running before kfree().
+	 */
+	WARN_ON(hrtimer_cancel(&ecu->ac_timer));
+	tasklet_kill(&ecu->ac_tasklet);
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
+	 * WQ context, priv->ecus readers might find ECUs with ecu->kref == 0.
+	 * Therefore, priv->ecus readers must validate with j1939_ecu_valid() or
+	 * j1939_ecu_get().
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
+static __must_check bool j1939_ecu_get(struct j1939_ecu *ecu)
 {
-	kref_get(&ecu->kref);
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
+{
+	/* Treat an ECU as invalid if __j1939_ecu_release() was called. */
+	return kref_read(&ecu->kref);
 }
 
 static bool j1939_ecu_is_mapped_locked(struct j1939_ecu *ecu)
@@ -56,15 +93,17 @@ static void j1939_ecu_map_locked(struct j1939_ecu *ecu)
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
@@ -99,8 +138,17 @@ void j1939_ecu_unmap(struct j1939_ecu *ecu)
 void j1939_ecu_unmap_all(struct j1939_priv *priv)
 {
 	int i;
+	struct j1939_ecu *ecu;
 
 	write_lock_bh(&priv->lock);
+	/* Although j1939_ecu_get() from j1939_ecu_map_locked() from
+	 * j1939_ecu_tasklet_handler() will fail if netdev is no longer
+	 * registered or __j1939_rx_release() was called, cancel the 250ms
+	 * timer in order to speed up teardown operation.
+	 */
+	list_for_each_entry(ecu, &priv->ecus, list)
+		j1939_ecu_timer_cancel(ecu);
+	/* Unmap any remaining mapped ECUs */
 	for (i = 0; i < ARRAY_SIZE(priv->ents); i++)
 		if (priv->ents[i].ecu)
 			j1939_ecu_unmap_locked(priv->ents[i].ecu);
@@ -109,10 +157,11 @@ void j1939_ecu_unmap_all(struct j1939_priv *priv)
 
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
@@ -121,29 +170,99 @@ void j1939_ecu_timer_start(struct j1939_ecu *ecu)
 
 void j1939_ecu_timer_cancel(struct j1939_ecu *ecu)
 {
+	/* Drop the ref from j1939_ecu_timer_start() if j1939_ecu_timer_handler() was not called.
+	 * Don't drop the ref from j1939_ecu_timer_start() if j1939_ecu_timer_handler() was already
+	 * called.
+	 */
 	if (hrtimer_cancel(&ecu->ac_timer))
 		j1939_ecu_put(ecu);
+	/* Drop the ref from j1939_ecu_timer_handler() if test_and_set_bit() in
+	 * j1939_ecu_timer_handler() succeeded and j1939_ecu_tasklet_handler() is not yet called.
+	 * Don't drop the ref from j1939_ecu_timer_handler() if test_and_set_bit() in
+	 * j1939_ecu_timer_handler() failed or j1939_ecu_tasklet_handler() was already called.
+	 */
+	if (test_and_clear_bit(0, &ecu->flags))
+		j1939_ecu_put(ecu);
 }
 
 static enum hrtimer_restart j1939_ecu_timer_handler(struct hrtimer *hrtimer)
 {
 	struct j1939_ecu *ecu =
 		container_of(hrtimer, struct j1939_ecu, ac_timer);
+
+	/* The corresponding j1939_ecu_put() is in
+	 * j1939_ecu_tasklet_handler() or j1939_ecu_timer_cancel().
+	 */
+	if (!j1939_ecu_get(ecu))
+		goto out;
+
+	/*
+	 * Since we can't commit this address change from this context because we need to hold
+	 * priv->lock for write before committing while hrtimer_cancel() (which waits for this
+	 * context to complete) is called with priv->lock held for write, schedule
+	 * j1939_ecu_tasklet_handler() (which takes priv->lock held for write from a different
+	 * context) to commit this address change.
+	 *
+	 * The !test_and_set_bit() in j1939_ecu_timer_handler() and
+	 * the test_and_clear_bit() in j1939_ecu_tasklet_handler() (or
+	 * j1939_ecu_timer_cancel()) pair guarantees that
+	 * the ref from j1939_ecu_timer_start() is dropped for exactly once.
+	 *
+	 * The !test_and_set_bit() condition here is likely true due to reasons listed below.
+	 *
+	 *   (1) j1939_ecu_timer_cancel(ecu) and j1939_ecu_timer_start(ecu) are
+	 *       serialized by ecu->priv->lock
+	 *   (2) scheduling of ecu->ac_tasklet does not happen if
+	 *       hrtimer_cancel(&ecu->ac_timer) from j1939_ecu_timer_cancel(ecu) was
+	 *       called before j1939_ecu_timer_handler(&ecu->ac_timer) is fired
+	 *   (3) scheduling of ecu->ac_tasklet completes before
+	 *       hrtimer_cancel(&ecu->ac_timer) from j1939_ecu_timer_cancel(ecu) returns
+	 *       if j1939_ecu_timer_handler(&ecu->ac_timer) was fired before
+	 *       hrtimer_cancel(&ecu->ac_timer) from j1939_ecu_timer_cancel(ecu) is
+	 *       called
+	 *   (4) ecu->ac_tasklet has shorter expiry time than ecu->ac_timer, which should
+	 *       fire j1939_ecu_tasklet_handler(&ecu->ac_tasklet) before
+	 *       j1939_ecu_timer_handler(&ecu->ac_timer) is fired as long as
+	 *       ecu->ac_tasklet is scheduled by previous j1939_ecu_timer_handler()
+	 *       before ecu->ac_timer is scheduled by current j1939_ecu_timer_start()
+	 *
+	 * However, if something significantly delayed firing of j1939_ecu_tasklet_handler()
+	 * enough to fire j1939_ecu_timer_handler() before j1939_ecu_tasklet_handler() is
+	 * fired, blindly scheduling ecu->ac_tasklet will fail to drop the ref from previous
+	 * j1939_ecu_timer_handler(). Therefore, drop the ref from current
+	 * j1939_ecu_timer_handler() if such race condition happened.
+	 */
+	if (likely(!test_and_set_bit(0, &ecu->flags))) {
+		tasklet_schedule(&ecu->ac_tasklet);
+	} else {
+		netdev_warn(ecu->priv->ndev,
+			    "Skipped mapping ECU, addr: 0x%02x, name: 0x%016llx.\n",
+			    ecu->addr, ecu->name);
+		j1939_ecu_put(ecu);
+	}
+out:
+	/* Drop the ref from j1939_ecu_timer_start(). */
+	j1939_ecu_put(ecu);
+	return HRTIMER_NORESTART;
+}
+
+static void j1939_ecu_tasklet_handler(struct tasklet_struct *tasklet)
+{
+	struct j1939_ecu *ecu = container_of(tasklet, struct j1939_ecu, ac_tasklet);
 	struct j1939_priv *priv = ecu->priv;
 
 	write_lock_bh(&priv->lock);
+	/* Check if j1939_ecu_timer_cancel() was called. */
+	if (!test_and_clear_bit(0, &ecu->flags))
+		goto out;
 	/* TODO: can we test if ecu->addr is unicast before starting
 	 * the timer?
 	 */
 	j1939_ecu_map_locked(ecu);
-
-	/* The corresponding j1939_ecu_get() is in
-	 * j1939_ecu_timer_start().
-	 */
-	j1939_ecu_put(ecu);
+ out:
 	write_unlock_bh(&priv->lock);
-
-	return HRTIMER_NORESTART;
+	/* Drop the ref from j1939_ecu_timer_handler(). */
+	j1939_ecu_put(ecu);
 }
 
 struct j1939_ecu *j1939_ecu_create_locked(struct j1939_priv *priv, name_t name)
@@ -152,6 +271,13 @@ struct j1939_ecu *j1939_ecu_create_locked(struct j1939_priv *priv, name_t name)
 
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
@@ -162,6 +288,7 @@ struct j1939_ecu *j1939_ecu_create_locked(struct j1939_priv *priv, name_t name)
 
 	hrtimer_setup(&ecu->ac_timer, j1939_ecu_timer_handler, CLOCK_MONOTONIC,
 		      HRTIMER_MODE_REL_SOFT);
+	tasklet_setup(&ecu->ac_tasklet, j1939_ecu_tasklet_handler);
 	INIT_LIST_HEAD(&ecu->list);
 
 	j1939_priv_get(priv);
@@ -189,8 +316,8 @@ struct j1939_ecu *j1939_ecu_get_by_addr_locked(struct j1939_priv *priv, u8 addr)
 		return NULL;
 
 	ecu = j1939_ecu_find_by_addr_locked(priv, addr);
-	if (ecu)
-		j1939_ecu_get(ecu);
+	if (ecu && !j1939_ecu_get(ecu))
+		ecu = NULL;
 
 	return ecu;
 }
@@ -215,7 +342,7 @@ static struct j1939_ecu *j1939_ecu_find_by_name_locked(struct j1939_priv *priv,
 	lockdep_assert_held(&priv->lock);
 
 	list_for_each_entry(ecu, &priv->ecus, list) {
-		if (ecu->name == name)
+		if (ecu->name == name && j1939_ecu_valid(ecu))
 			return ecu;
 	}
 
@@ -232,11 +359,12 @@ struct j1939_ecu *j1939_ecu_get_by_name_locked(struct j1939_priv *priv,
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
index cf26352d1d8c..1d3178d22548 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -36,12 +36,17 @@ struct j1939_ecu {
 
 	/* indicates that this ecu successfully claimed @sa as its address */
 	struct hrtimer ac_timer;
+	struct tasklet_struct ac_tasklet;
 	struct kref kref;
 	struct j1939_priv *priv;
 	netdevice_tracker priv_dev_tracker;
 
 	/* count users, to help transport protocol decide for interaction */
 	int nusers;
+
+	struct work_struct release_work;
+	/* Bit 0: Ready to commit address change. */
+	unsigned long flags;
 };
 
 struct j1939_priv {
@@ -345,4 +350,6 @@ void j1939_session_timers_cancel(struct j1939_session *session);
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

