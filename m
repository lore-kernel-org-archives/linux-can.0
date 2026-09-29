Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C24501293
	for <linux-can@vger.kernel.org>; Tue, 29 Sep 2026 11:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682477; cv=none; b=D29+NLqRWN5Jsi92a1moh1To0v+f33U48UhtcYa65IiFj4ArwLkh8kVKw7GrS8hrtH4jBlaRvzRc+SSwV1hpF8/6RhmYEgLKxkB6qv+MpvoKjKOVq7AJWc2sJUEfr8hx1zHBkrhq0vngL4SCC2fclCggW2RCr9Nj28ds3xJG2Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682477; c=relaxed/simple;
	bh=yoOg8t4Li+I0encEyH0d/QgVvTW+1DmAqS5N261TWIk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=K4YvwXMxroCpV5IvJhSz9mbkBWg0o8+pvs/nnUtxNofozTMTbYrBLb4nbS1GTuoAipFYCJNSD/2HBcCfLYHidkafC/xs6raE9WGa+eBfY4S2swHDWC2PAXiWYGukKCsNHn2CDF+HjSCnDNKQv6y4bMdEi4dqAeybH+zFIx5rrr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 68TBlVkf028864;
	Tue, 29 Sep 2026 20:47:31 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 68TBlUpF028861
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 29 Sep 2026 20:47:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9ba38419-967a-4d47-bcdf-bbb2fa7d3e9f@I-love.SAKURA.ne.jp>
Date: Tue, 29 Sep 2026 20:47:30 +0900
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
Subject: [PATCH v3] can: j1939: cancel pending address claim timers from
 j1939_ecu_unmap_all()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav312.rs.sakura.ne.jp
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

Fix this race condition by canceling address claim timers from
j1939_ecu_unmap_all().

Reported-by: syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928193312.553632-1-mkl%40pengutronix.de # [PATCH net 06/22]
Assisted-by: Gemini-Pro gpt-6-astra opus-5-5
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Changes in v3:
  - Make sure that final j1939_ecu_put() is protected by priv->lock.
  - Removed synchronize_rcu(), as traversal is protected by priv->lock.
  - Cancel inside j1939_ecu_unmap_all(), as traversal is protected by
    priv->lock.

Changes in v2:
  - The "can: j1939: j1939_sk_bind(): fix j1939_ecu leak when re-bind failed"
    patch has passed a review by sashiko@sashiko.dev . But another review by
    sashiko@netdev-ai.bots.linux.dev mentioned that this leak is caused by
    not "re-bind failure" but "j1939_ecu_timer_handler() race".

 net/can/j1939/bus.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index cdc3c0a71937..0d109d1a3b4a 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -99,8 +99,38 @@ void j1939_ecu_unmap(struct j1939_ecu *ecu)
 void j1939_ecu_unmap_all(struct j1939_priv *priv)
 {
 	int i;
+	struct j1939_ecu *ecu;
 
 	write_lock_bh(&priv->lock);
+	/* Cancel all pending address claim timers before unmapping.
+	 * This prevents an orphaned late-firing timer from re-mapping
+	 * an ECU after the spaces are cleared.
+	 */
+rescan_timers:
+	list_for_each_entry(ecu, &priv->ecus, list) {
+		int ret = hrtimer_try_to_cancel(&ecu->ac_timer);
+
+		if (ret == 0) { /* Not active or already finished. */
+			continue;
+		} else if (ret == 1) { /* Successfully canceled. */
+			/* Drop a ref from j1939_ecu_timer_start(). */
+			j1939_ecu_put(ecu);
+		} else { /* Executing on another CPU. */
+			/* Let j1939_ecu_timer_cancel() determine whether to
+			 * drop a ref from j1939_ecu_timer_start(). But guard
+			 * with a local ref in order to make sure that unlocked
+			 * j1939_ecu_put() from j1939_ecu_timer_cancel() cannot
+			 * be the final reference.
+			 */
+			j1939_ecu_get(ecu);
+			write_unlock_bh(&priv->lock);
+			j1939_ecu_timer_cancel(ecu);
+			write_lock_bh(&priv->lock);
+			j1939_ecu_put(ecu);
+		}
+		goto rescan_timers;
+	}
+	/* Unmap any remaining mapped ECUs */
 	for (i = 0; i < ARRAY_SIZE(priv->ents); i++)
 		if (priv->ents[i].ecu)
 			j1939_ecu_unmap_locked(priv->ents[i].ecu);
-- 
2.52.0

