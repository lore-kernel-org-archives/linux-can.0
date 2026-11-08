Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794135397;
	b=Pygi2l96IEjhxsHvb0UjrTWoEgwRozLO3ZcPDf+kT8ID96gqHuI3W/67hzuWzTJu9nd6
	 BDZghu7VplzaLmcTPB2P5zFdK16O8VAIgWQoW36yz6H8Sw8yf4AhV06H18+VLcaUGAnbb
	 6oumDQt0ARlynYP1or9gkV+0OkL74E4lLZddFVUVM0JpWXWPXHIdyvmeWUl1hu0ameDy7
	 9yUVXb8NbhFG3X/GlDHOQtNfmuT8oe4L0CG+Kj7k4XZzF6v5O4DHTmxO0dSwob1M6tU5+
	 GZ5KuAUWYjhJIJ5TzTbgaSrLmHM9iXbZDLTXHIhch0eVB4rcVyGkR3/lMd5CKGut4mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794135397;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Virus-Status:
	 X-Anti-Virus-Server;
	bh=nE+Wakq6UrygYNpqVxBivAkxi4d7ymPpdtvZMwJQnTM=;
	b=EHHx0KOOuXXkxpjJRm2m2LfWA6hwTTufNNddOpSqwsX54U39Cc0EGaXffFPZDvxgtwCm
	 nCnj4x6grftljnowYsgCt0Nz4R/LqhoGd3AIFvMmK4B3TWwybOl/0ZmfUsxMCErCylX25
	 ja6DLCQliPWxPUcn6pns/M0daFnAkdZhMw9yPQxhm2NN0JqqjuamX+NcKWT8wZy631uF4
	 ocJ31PexQRPBm5XnPWPAfXslyp+zc1DVp0rqjVT0eYfIeRyLsfZi5TBsgIzfonnYn73E+
	 rqv/Pl9TVV+qn4Im2e7Bcbl2toLqF4NSHVVxOg3EQRGwC4KWWHHHPalUo05kUcFBIPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376CF606A32A
	for <linux-can@vger.kernel.org>; Sun,  8 Nov 2026 10:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 376CF606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6A8AuJTR000169;
	Sun, 8 Nov 2026 19:56:19 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6A8AuJG3000165
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 8 Nov 2026 19:56:19 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d85537b1-5567-4eb3-857f-c0faffdc51f2@I-love.SAKURA.ne.jp>
Date: Sun, 8 Nov 2026 19:56:18 +0900
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
Subject: [PATCH v10 2/2] can: j1939: fix "struct j1939_ecu" refcount leak
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>
References: <e1c47fcf-d0e8-47fc-ab79-dce13cc2159f@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <e1c47fcf-d0e8-47fc-ab79-dce13cc2159f@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav114.rs.sakura.ne.jp

syzbot is reporting "struct j1939_ecu" refcount leak, for

  j1939_ecu_get(ecu);
  priv->ents[ecu->addr] = ecu;

in j1939_ecu_map_locked() from j1939_ecu_timer_handler() can succeed
even after

  priv->ents[ecu->addr] = NULL;
  j1939_ecu_put(ecu);

in j1939_ecu_unmap_locked() from j1939_ecu_unmap_all() from
__j1939_rx_release() from j1939_netdev_stop() has completed.

Fix this problem by

  (1) canceling ecu->ac_timer from j1939_ecu_unmap_all()
  (2) preventing ecu->ac_timer from re-arming in j1939_ecu_timer_start()
  (3) making j1939_ecu_map_locked() no-op

when a netdev which is associated with j1939_priv is no longer registered
(indicated by ecu->priv->ndev->reg_state != NETREG_REGISTERED) or
__j1939_rx_release() was called (indicated by ecu->priv->rx_kref == 0).

Reported-by: syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 net/can/j1939/bus.c    | 53 +++++++++++++++++++++++++++++++++++++++---
 net/can/j1939/socket.c | 10 +++++++-
 2 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index 37ce6a456fce..7d32972339f9 100644
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
@@ -53,6 +58,17 @@ static __must_check bool j1939_ecu_get(struct j1939_ecu *ecu)
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
@@ -80,7 +96,7 @@ static void j1939_ecu_map_locked(struct j1939_ecu *ecu)
 	if (!j1939_address_is_unicast(ecu->addr))
 		return;
 
-	if (!j1939_ecu_get(ecu))
+	if (!j1939_ecu_verify_get(ecu))
 		return;
 
 	ent = &priv->ents[ecu->addr];
@@ -125,8 +141,39 @@ void j1939_ecu_unmap(struct j1939_ecu *ecu)
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
@@ -136,9 +183,9 @@ void j1939_ecu_unmap_all(struct j1939_priv *priv)
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
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 50a598ef5fd4..6e22ec5e88f5 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -484,7 +484,15 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr_unsized *uaddr, in
 			goto out_release_sock;
 		}
 
-		if (ndev->reg_state != NETREG_REGISTERED) {
+		/* Do nothing and fail early if netdev is no longer registered.
+		 * This check is racy but we don't need to recheck after j1939_jsk_add()
+		 * is called, for either j1939_sk_netdev_event_unregister() from
+		 * j1939_netdev_notify(NETDEV_UNREGISTER) (which is retried by
+		 * netdev_wait_allrefs_any() as long as priv->rx_kref held by
+		 * j1939_netdev_start() is preventing j1939_priv_set(priv->ndev, NULL)
+		 * from being called) or j1939_sk_release() will take care of this race.
+		 */
+		if (READ_ONCE(ndev->reg_state) != NETREG_REGISTERED) {
 			dev_put(ndev);
 			ret = -ENODEV;
 			goto out_release_sock;
-- 
2.56.0

