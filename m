Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3F4443E29;
	Wed, 29 Jul 2026 10:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785320978; cv=none; b=jeKzUN82pIpt7yxkVJeKWlBHfa2stvR/0Uu86YJmRbHClsRDITf8snyZSyHr7uRTx1bIDLYjM9NwxJrkU5YoOWsVHhfxPP5RXjO/3/7OViu5a3bzqu14kPkjq3m8jLkdtwKdNFbwDpOsLvY946Avfj76AzKkoPfMfNWvvdzqrhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785320978; c=relaxed/simple;
	bh=c4+wKD74ldYD/s9q/ye3w+t5wj90Lmvobq8d0j5MTvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQ8mT/RfmBejZyuJu/+QtmWNzdv0tI1HBzKLV0XcwZXSHHVzEe8SiaAPArKA5Gii+Tk6bbIx+dXZTcQJmSIy5etvFk91tXvoPR4OaPW9vd0KUIo3wUtqTYEmuvxWV1so/gkGpwqolQi5dQhqV2QBZeo9RVcu+qZiUniBwPbFTAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 684EB202B60;
	Wed, 29 Jul 2026 12:29:26 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wp1XS-001rnA-01;
	Wed, 29 Jul 2026 12:29:26 +0200
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AAB1F575DBB;
	Wed, 29 Jul 2026 10:28:10 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	stable@kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 01/20] can: j1939: use netdevice_tracker for j1939_{priv,session,ecu} tracking
Date: Wed, 29 Jul 2026 12:12:41 +0200
Message-ID: <20260729102802.505168-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729102802.505168-1-mkl@pengutronix.de>
References: <20260729102802.505168-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

syzbot is still reporting

  unregister_netdevice: waiting for vcan0 to become free. Usage count = 2

problem. A debug printk() patch in linux-next-20260508 identified that
there is dev_hold()/dev_put() imbalance in j1939_priv management.

  Call trace for vcan0[26] +4 at
     __dev_hold include/linux/netdevice.h:4470 [inline]
     netdev_hold include/linux/netdevice.h:4513 [inline]
     dev_hold include/linux/netdevice.h:4536 [inline]
     j1939_priv_create net/can/j1939/main.c:140 [inline]
     j1939_netdev_start+0x36b/0xc10 net/can/j1939/main.c:268
     j1939_sk_bind+0x853/0xb30 net/can/j1939/socket.c:506
     __sys_bind_socket net/socket.c:1948 [inline]
     __sys_bind+0x2e9/0x410 net/socket.c:1979

  Call trace for vcan0[28] -3 at
     __dev_put include/linux/netdevice.h:4456 [inline]
     netdev_put include/linux/netdevice.h:4523 [inline]
     dev_put include/linux/netdevice.h:4548 [inline]
     __j1939_priv_release net/can/j1939/main.c:166 [inline]
     kref_put include/linux/kref.h:65 [inline]
     j1939_priv_put+0x128/0x270 net/can/j1939/main.c:172
     j1939_sk_sock_destruct+0x52/0x90 net/can/j1939/socket.c:388
     __sk_destruct+0x8d/0x9d0 net/core/sock.c:2352
     rcu_do_batch kernel/rcu/tree.c:2617 [inline]
     rcu_core kernel/rcu/tree.c:2869 [inline]
     rcu_cpu_kthread+0x99e/0x1470 kernel/rcu/tree.c:2957
     smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
     kthread+0x388/0x470 kernel/kthread.c:436
     ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
     ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

This refcount leak in j1939_priv might be caused by a refcount leak in
j1939_{session,ecu} because j1939_{session,ecu} holds a ref on j1939_priv.
For further investigation using upstream kernels, enable netdevice_tracker
in j1939_{priv,session,ecu} management.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://patch.msgid.link/20260728055835.1151785-2-o.rempel@pengutronix.de
Cc: stable@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/j1939/bus.c        | 2 ++
 net/can/j1939/j1939-priv.h | 3 +++
 net/can/j1939/main.c       | 8 ++++----
 net/can/j1939/transport.c  | 2 ++
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index dc374286eeb6..cdc3c0a71937 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -20,6 +20,7 @@ static void __j1939_ecu_release(struct kref *kref)
 	struct j1939_priv *priv = ecu->priv;
 
 	list_del(&ecu->list);
+	netdev_put(priv->ndev, &ecu->priv_dev_tracker);
 	kfree(ecu);
 	j1939_priv_put(priv);
 }
@@ -155,6 +156,7 @@ struct j1939_ecu *j1939_ecu_create_locked(struct j1939_priv *priv, name_t name)
 	if (!ecu)
 		return ERR_PTR(-ENOMEM);
 	kref_init(&ecu->kref);
+	netdev_hold(priv->ndev, &ecu->priv_dev_tracker, gfp_any());
 	ecu->addr = J1939_IDLE_ADDR;
 	ecu->name = name;
 
diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 81f58924b4ac..cf26352d1d8c 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -38,6 +38,7 @@ struct j1939_ecu {
 	struct hrtimer ac_timer;
 	struct kref kref;
 	struct j1939_priv *priv;
+	netdevice_tracker priv_dev_tracker;
 
 	/* count users, to help transport protocol decide for interaction */
 	int nusers;
@@ -60,6 +61,7 @@ struct j1939_priv {
 	rwlock_t lock;
 
 	struct net_device *ndev;
+	netdevice_tracker dev_tracker;
 
 	/* list of 256 ecu ptrs, that cache the claimed addresses.
 	 * also protected by the above lock
@@ -230,6 +232,7 @@ enum j1939_session_state {
 
 struct j1939_session {
 	struct j1939_priv *priv;
+	netdevice_tracker priv_dev_tracker;
 	struct list_head active_session_list_entry;
 	struct list_head sk_session_queue_entry;
 	struct kref kref;
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 9937c04241bc..5e5e6c228f22 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -137,7 +137,7 @@ static struct j1939_priv *j1939_priv_create(struct net_device *ndev)
 	priv->ndev = ndev;
 	kref_init(&priv->kref);
 	kref_init(&priv->rx_kref);
-	dev_hold(ndev);
+	netdev_hold(ndev, &priv->dev_tracker, GFP_KERNEL);
 
 	netdev_dbg(priv->ndev, "%s : 0x%p\n", __func__, priv);
 
@@ -163,7 +163,7 @@ static void __j1939_priv_release(struct kref *kref)
 	WARN_ON_ONCE(!list_empty(&priv->ecus));
 	WARN_ON_ONCE(!list_empty(&priv->j1939_socks));
 
-	dev_put(ndev);
+	netdev_put(ndev, &priv->dev_tracker);
 	kfree(priv);
 }
 
@@ -281,7 +281,7 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
 		 */
 		kref_get(&priv_new->rx_kref);
 		mutex_unlock(&j1939_netdev_lock);
-		dev_put(ndev);
+		netdev_put(ndev, &priv->dev_tracker);
 		kfree(priv);
 		return priv_new;
 	}
@@ -298,7 +298,7 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
 	j1939_priv_set(ndev, NULL);
 	mutex_unlock(&j1939_netdev_lock);
 
-	dev_put(ndev);
+	netdev_put(ndev, &priv->dev_tracker);
 	kfree(priv);
 
 	return ERR_PTR(ret);
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8a31cb23bc76..98f96362b20f 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -283,6 +283,7 @@ static void j1939_session_destroy(struct j1939_session *session)
 		kfree_skb(skb);
 	}
 	__j1939_session_drop(session);
+	netdev_put(session->priv->ndev, &session->priv_dev_tracker);
 	j1939_priv_put(session->priv);
 	kfree(session);
 }
@@ -1526,6 +1527,7 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
 	INIT_LIST_HEAD(&session->active_session_list_entry);
 	INIT_LIST_HEAD(&session->sk_session_queue_entry);
 	kref_init(&session->kref);
+	netdev_hold(priv->ndev, &session->priv_dev_tracker, gfp_any());
 
 	j1939_priv_get(priv);
 	session->priv = priv;

base-commit: 3bd438a58e910db5dc369aa25dfed1fc95f1b596
-- 
2.53.0

