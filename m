Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1536650B8CB
	for <linux-can@vger.kernel.org>; Tue, 29 Sep 2026 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677544; cv=none; b=lnvP0eqshXKps9dchBZa5IrAI0sMil13k2YZqUOJPvCI9VHpOOOwZqqgYufU9B8/k5/aHmAyZxmkMXby1aKtwXZtFNb+dTB7BWC50DbPULUET8ixnfrMfNaVFBDC+XUBx4GRqk14EL94iCXiZ/Rg1ayzv1gbaj44DsQyvOYqB/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677544; c=relaxed/simple;
	bh=JF/2kC+L6LMh6mU7Nk2o16KTrACqF7s1Juf4FrulZ2A=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ja88RoZaYosa6kbAe2hMdR29pG7YttFOEC25zw0bpEa6lTXy7N3p8kB51b2Cxd/IecolXoR8ZhawX2PwT9W2AoEE1dJK2JAClZ660thQb8uQrTgyY24rCLTOq52xPf2r7GAzgqKyaqYjlJJBsYTmBn34sQJKBGDoWhFUudasvtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 68TAPDop011600;
	Tue, 29 Sep 2026 19:25:13 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 68TAPDm1011597
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 29 Sep 2026 19:25:13 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <853e770e-4eee-4da8-8cf0-08731f9651ab@I-love.SAKURA.ne.jp>
Date: Tue, 29 Sep 2026 19:25:12 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v2] can: j1939: cancel pending address claim timers on rx
 release
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav215.rs.sakura.ne.jp
X-Virus-Status: clean

syzbot is reporting "struct j1939_ecu" refcount leak, for

  j1939_ecu_get(ecu);
  priv->ents[ecu->addr] = ecu;

in j1939_ecu_map_locked() from j1939_ecu_timer_handler() can succeed
even after

  priv->ents[ecu->addr] = NULL;
  j1939_ecu_put(ecu);

in j1939_ecu_unmap_locked() from j1939_ecu_unmap_all() from
__j1939_rx_release() from j1939_netdev_stop() has completed.

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

Fix this race condition by canceling address claim timers before calling
j1939_ecu_unmap_all() from __j1939_rx_release() from j1939_netdev_stop().

Reported-by: syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928193312.553632-1-mkl%40pengutronix.de # [PATCH net 06/22]
Assisted-by: Gemini-Pro gpt-6-astra opus-5-5
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Changes in v2:
  - The "can: j1939: j1939_sk_bind(): fix j1939_ecu leak when re-bind failed"
    patch has passed a review by sashiko@sashiko.dev . But another review by
    sashiko@netdev-ai.bots.linux.dev mentioned that this leak is caused by
    not "re-bind failure" but "j1939_ecu_timer_handler() race".

 net/can/j1939/main.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 5e5e6c228f22..f9222056ac9a 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -212,8 +212,38 @@ static void __j1939_rx_release(struct kref *kref)
 {
 	struct j1939_priv *priv = container_of(kref, struct j1939_priv,
 					       rx_kref);
+	struct j1939_ecu *ecu;
 
 	j1939_can_rx_unregister(priv);
+
+	/* can_rx_unregister() uses call_rcu() internally and is asynchronous.
+	 * We must wait for an RCU grace period to ensure that any in-flight
+	 * j1939_can_recv() instances on other CPUs have fully completed.
+	 */
+	synchronize_rcu();
+
+	/* Cancel all pending address claim timers before unmapping the ECUs.
+	 * This prevents an orphaned timer from re-mapping an ECU after the
+	 * rx path has been completely torn down.
+	 */
+rescan_timers:
+	write_lock_bh(&priv->lock);
+	list_for_each_entry(ecu, &priv->ecus, list) {
+		int ret = hrtimer_try_to_cancel(&ecu->ac_timer);
+
+		if (ret == 0) /* Was not running. */
+			continue;
+		kref_get(&ecu->kref);
+		write_unlock_bh(&priv->lock);
+		if (ret == -1) /* Was running. Wait without lock. */
+			j1939_ecu_timer_cancel(ecu);
+		else /* Was canceled. Drop ref from j1939_ecu_timer_start(). */
+			j1939_ecu_put(ecu);
+		j1939_ecu_put(ecu);
+		goto rescan_timers;
+	}
+	write_unlock_bh(&priv->lock);
+
 	j1939_ecu_unmap_all(priv);
 	j1939_priv_set(priv->ndev, NULL);
 	mutex_unlock(&j1939_netdev_lock);
-- 
2.52.0
