Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979823;
	b=ZBn/4+7FC9L4VKkafh+U2DnNh0Ysfk952AI6Af+BKD/kMh2DfRkgrl2Oj9NOSMFuL26U
	 JEJqHdlq8fkM0aPzYIBU9r0U6jyvfYxWNa5/e2MnOeVVkOwtTcXv438Rs9NR64TbpjVX4
	 8DA5JXEzGcTDdXkDzElEpltibnTxi54ZL/JbdcVgTnU7z9g/DMknYvrQS2r2WqJDBHyf7
	 0O3HyEuQ1hK/g6oebt6SG3doDOwUmaMNmk+KmXceCMKAHEjH23f/jv3XT9oEjjs0yJEVS
	 thaNRKA2RMZnMfoJ7VLAwBQHEQH1OjOGq3RXN/vJWiJ7tUj/t2dUaxUDGCIm8ODF2QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979823;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Virus-Status:
	 X-Anti-Virus-Server;
	bh=hAogDM2/gSqzdf53UqhQOlmdspGSpAif4YyUslDQ5CQ=;
	b=03w5Jiy0TqdHPQqK9FwM21yRZx883T+m7Hqf0Yz7b/FZkH+Gc5Z3QTNyNpt6apruyhl2
	 MJE9N64gH4G+OfUdJl+L+mL422Ea19HX5CNi19Q8xfkm/Mm2Rd1iCuyAMdlWfGQOLhfS/
	 xsIvNq52hoq+Np6N/W+XvsUXts2A//fY9bxLvB5vSsl5AwQUtFX42Dy+rhkqf6ube8Oix
	 sBEQIX09tEJhFolRi4eN1DRDcEmjZ9ZHZC2jQ0wsAzaNs3RYIBhISCuQMuyVvbkcUm9wr
	 N0U+TrryzU8M1MmZInV/hwe+4v0mp4+h0j7jk6bypy/7X+pDCdR/ypQPqsnDosybgRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BA4606A326
	for <linux-can@vger.kernel.org>; Fri,  6 Nov 2026 15:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09BA4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6A6FhOoo011236;
	Sat, 7 Nov 2026 00:43:25 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6A6FhOUV011233
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 7 Nov 2026 00:43:24 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <489aa8c0-c9c8-4aeb-9479-f7cb4c6a03df@I-love.SAKURA.ne.jp>
Date: Sat, 7 Nov 2026 00:43:21 +0900
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
Subject: [PATCH v9 2/2] can: j1939: fix "struct j1939_ecu" refcount leak
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>
References: <396b5de7-3fe0-474f-9194-b4816fde7182@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <396b5de7-3fe0-474f-9194-b4816fde7182@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav411.rs.sakura.ne.jp

syzbot is reporting "struct j1939_ecu" refcount leak, for

  j1939_ecu_get(ecu);
  priv->ents[ecu->addr] = ecu;

in j1939_ecu_map_locked() from j1939_ecu_timer_handler() can succeed
even after

  priv->ents[ecu->addr] = NULL;
  j1939_ecu_put(ecu);

in j1939_ecu_unmap_locked() from j1939_ecu_unmap_all() from
__j1939_rx_release() from j1939_netdev_stop() has completed.

Fix this problem by canceling ecu->ac_timer from j1939_ecu_unmap_all(),
preventing ecu->ac_timer from re-arming in j1939_ecu_timer_start() /
making j1939_ecu_map_locked() no-op / failing j1939_local_ecu_get()
when a netdev which is associated with j1939_priv is no longer registered
(indicated by ecu->priv->ndev->reg_state != NETREG_REGISTERED) or
__j1939_rx_release() was called (indicated by ecu->priv->rx_kref == 0).

Reported-by: syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
To save cost of AI reviews and to quickly close frequently reproducing bug,
patch for "can: j1939: ABBA deadlock in j1939_ecu_timer_cancel() under
priv->lock" problem is deferred.

 net/can/j1939/bus.c | 65 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 3 deletions(-)

diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index 3422e3133800..4844b92aa028 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -24,6 +24,11 @@ static void __j1939_ecu_release_work(struct work_struct *work)
 	write_lock_bh(&priv->lock);
 	list_del(&ecu->list);
 	write_unlock_bh(&priv->lock);
+	/* There can't be any ref on this ECU because __j1939_ecu_release()
+	 * was already called. But we need to make sure that
+	 * j1939_ecu_timer_handler() is no longer running before kfree().
+	 */
+	WARN_ON(hrtimer_cancel(&ecu->ac_timer));
 	netdev_put(priv->ndev, &ecu->priv_dev_tracker);
 	kfree(ecu);
 	j1939_priv_put(priv);
@@ -54,6 +59,17 @@ static __must_check bool j1939_ecu_get(struct j1939_ecu *ecu)
 	return kref_get_unless_zero(&ecu->kref);
 }
 
+static bool j1939_ecu_verify_get(struct j1939_ecu *ecu)
+{
+	struct j1939_priv *priv = ecu->priv;
+
+	/* Don't get an ECU ref if netdev is no longer registered or
+	 * __j1939_rx_release() was called or __j1939_ecu_release() was called.
+	 */
+	return READ_ONCE(priv->ndev->reg_state) == NETREG_REGISTERED &&
+		kref_read(&priv->rx_kref) && j1939_ecu_get(ecu);
+}
+
 static __must_check bool j1939_ecu_valid(struct j1939_ecu *ecu)
 {
 	/* Treat an ECU as invalid if __j1939_ecu_release() was called. */
@@ -81,7 +97,7 @@ static void j1939_ecu_map_locked(struct j1939_ecu *ecu)
 	if (!j1939_address_is_unicast(ecu->addr))
 		return;
 
-	if (!j1939_ecu_get(ecu))
+	if (!j1939_ecu_verify_get(ecu))
 		return;
 
 	ent = &priv->ents[ecu->addr];
@@ -126,8 +142,39 @@ void j1939_ecu_unmap(struct j1939_ecu *ecu)
 void j1939_ecu_unmap_all(struct j1939_priv *priv)
 {
 	int i;
+	struct j1939_ecu *ecu;
 
+restart:
 	write_lock_bh(&priv->lock);
+	/* Need to shutdown timers now, for module unloading might start
+	 * relatively shortly after returning from j1939_ecu_unmap_all() from
+	 * __j1939_rx_release() from j1939_netdev_stop() from j1939_sk_release().
+	 */
+	list_for_each_entry(ecu, &priv->ecus, list) {
+		if (!j1939_ecu_valid(ecu))
+			continue;
+		switch (hrtimer_try_to_cancel(&ecu->ac_timer)) {
+		case 0:	/* Not active or already finished. */
+			continue;
+		case 1:	/* Successfully canceled. */
+			/* Drop the ref from j1939_ecu_timer_start(). */
+			j1939_ecu_put(ecu);
+			continue;
+		default: /* Currently executing. */
+			/* Get a ref, in order to call hrtimer_calcel() without priv->lock. */
+			if (!j1939_ecu_get(ecu))
+				continue;
+			break;
+		}
+		write_unlock_bh(&priv->lock);
+		if (hrtimer_cancel(&ecu->ac_timer))
+			/* Drop the ref from j1939_ecu_timer_start(). */
+			j1939_ecu_put(ecu);
+		/* Drop the ref from default: above. */
+		j1939_ecu_put(ecu);
+		goto restart;
+	}
+	/* Unmap any remaining mapped ECUs */
 	for (i = 0; i < ARRAY_SIZE(priv->ents); i++)
 		if (priv->ents[i].ecu)
 			j1939_ecu_unmap_locked(priv->ents[i].ecu);
@@ -137,9 +184,9 @@ void j1939_ecu_unmap_all(struct j1939_priv *priv)
 void j1939_ecu_timer_start(struct j1939_ecu *ecu)
 {
 	/* The corresponding j1939_ecu_put() is in
-	 * j1939_ecu_timer_handler() or j1939_ecu_timer_cancel().
+	 * j1939_ecu_timer_handler() or j1939_ecu_timer_cancel() or j1939_ecu_unmap_all().
 	 */
-	if (!j1939_ecu_get(ecu))
+	if (!j1939_ecu_verify_get(ecu))
 		return;
 
 	/* Schedule timer in 250 msec to commit address change. */
@@ -149,6 +196,9 @@ void j1939_ecu_timer_start(struct j1939_ecu *ecu)
 
 void j1939_ecu_timer_cancel(struct j1939_ecu *ecu)
 {
+	/* FIXME: Calling hrtimer_cancel() under priv->lock can deadlock between
+	 * priv->lock and cpu_base->softirq_expiry_lock if CONFIG_PREEMPT_RT=y.
+	 */
 	if (hrtimer_cancel(&ecu->ac_timer))
 		/* Drop the ref from j1939_ecu_timer_start(). */
 		j1939_ecu_put(ecu);
@@ -310,6 +360,15 @@ int j1939_local_ecu_get(struct j1939_priv *priv, name_t name, u8 sa)
 
 	write_lock_bh(&priv->lock);
 
+	/* Do nothing and fail if netdev is no longer registered or
+	 * __j1939_rx_release() was called.
+	 */
+	if ((READ_ONCE(priv->ndev->reg_state) != NETREG_REGISTERED ||
+	     !kref_read(&priv->rx_kref))) {
+		err = -ENODEV;
+		goto done;
+	}
+
 	if (j1939_address_is_unicast(sa))
 		priv->ents[sa].nusers++;
 
-- 
2.56.0

