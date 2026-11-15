Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794742549;
	b=meGkIjjAXzrbHTkc5t7t+JSo8shTwcjRIWG/oIkDj2HUtGN85jeJJkIEnEWhOFs1dTYp
	 WRpb1MLt28e6o022BWwilJKQ7cr6uxUO4nskC/xMv0WBd4kb5Qhhd6WzWKn0taCYJhYFq
	 nsn6wlKVU1GoJ3Cfc9xnk++CGTkywvrgq9w8xOWqzEWhm1TSTd2INLL+cOO8a68OJd6w0
	 X9kw0cOzzl+a4QOZMlnYFN5LqO51ddTX2hoY6DNvlolxyJxfl1ZDvdBszV2Y+RJm4X3i+
	 d3Pv8tfUqDpkHIyoXwfnlsM3hS7Jex1vBRb6kVPoDkBljKbxLI5xse32inBXVDYqIgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794742549;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Anti-Virus-Server:
	 X-Virus-Status;
	bh=HbFKe/3qvQE784IujmBVm5+wluatF0o8/WhVlbkYzxw=;
	b=I7I/EwQ8ymJASupyjjkziFla4tYQ8EeOtHuVs5sG6oqMyXj4nU8ZPqM0jKBa0j8s+4WW
	 0PM1fD2YDuB4ws4054OUqJP1vj6pJpkaYNUrrl+QC0yKypvOw4wu7GHcrRUg91vYStm/K
	 k2XUwBR26Hc61i/eB+lIZf6FEQVbimpX8JHQZNOS84HdDCeQJWFoQTpXeJ3+5UUX8Pkiw
	 SXZ8s8kuREXpZmIS+ap8CXjCJ/v17KQ8jb1ibG8gak4E0FTD/j5Vk9+Zjr/50wSaSxtY2
	 dwSh5QGC+0zgLP5nOwYFk5txTMOMt2giQweS7UyDQHygC+hwo2uYYV24xVn87eGl5xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A277606A31D
	for <linux-can@vger.kernel.org>; Sun, 15 Nov 2026 11:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A277606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6AFBZZQm026723;
	Sun, 15 Nov 2026 20:35:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6AFBZZ5u026720
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 15 Nov 2026 20:35:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5a7f6f46-7cb8-4d44-b21c-39cd306b3503@I-love.SAKURA.ne.jp>
Date: Sun, 15 Nov 2026 20:35:36 +0900
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
Subject: [PATCH v14 1/6] can: j1939: fix possibility of UAF on module unload
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>
References: <1d96e742-0479-4c36-ad0a-a0aaeda0a4fc@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <1d96e742-0479-4c36-ad0a-a0aaeda0a4fc@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav213.rs.sakura.ne.jp
X-Virus-Status: clean

Since module refcount is currently associated with lifecycle of j1939
sockets, we need to make sure that all resources associated with socket
("struct j1939_priv", "struct j1939_ecu", "struct j1939_session") are
synchronously destructed before socket is destructed. Otherwise,
j1939_module_exit() can complete and memory for this module is unmapped
before j1939_ecu_timer_handler() or __j1939_ecu_release() or
j1939_session_destroy() or __j1939_priv_release() completes (i.e.
causing UAF).

Calling module_put(THIS_MODULE) from a module function which is not
possible to wait for completion of that function from that module's exit
function is a source of UAF. But calling module_put(THIS_MODULE) from a WQ
function which is possible to wait for completion from that module's exit
function using flush_workqueue() etc. is fine.

Fix this problem by deferring release steps of "struct j1939_priv" to WQ
context where we can call module_put(THIS_MODULE) while allowing
j1939_module_exit() to wait for completion using destroy_workqueue().

By this change, we no longer need to make sure that all resources
associated with socket ("struct j1939_priv", "struct j1939_ecu",
"struct j1939_session") are synchronously destructed before socket is
destructed, simplifying further fixes.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 net/can/j1939/j1939-priv.h |  4 ++++
 net/can/j1939/main.c       | 47 ++++++++++++++++++++++++++++++++------
 2 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index cf26352d1d8c..ff90683f33f4 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -93,6 +93,8 @@ struct j1939_priv {
 
 	struct kref rx_kref;
 	u32 rx_tskey;
+
+	struct work_struct release_work;
 };
 
 void j1939_ecu_put(struct j1939_ecu *ecu);
@@ -345,4 +347,6 @@ void j1939_session_timers_cancel(struct j1939_session *session);
 /* CAN protocol */
 extern const struct can_proto j1939_can_proto;
 
+extern struct workqueue_struct *j1939_wq;
+
 #endif /* _J1939_PRIV_H_ */
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 5e5e6c228f22..e1602b9a0c86 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -20,6 +20,8 @@
 
 #include "j1939-priv.h"
 
+struct workqueue_struct *j1939_wq __ro_after_init;
+
 MODULE_DESCRIPTION("PF_CAN SAE J1939");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("EIA Electronics (Kurt Van Dijck & Pieter Beyens)");
@@ -132,6 +134,11 @@ static struct j1939_priv *j1939_priv_create(struct net_device *ndev)
 	if (!priv)
 		return NULL;
 
+	if (!try_module_get(THIS_MODULE)) {
+		kfree(priv);
+		return NULL;
+	}
+
 	rwlock_init(&priv->lock);
 	INIT_LIST_HEAD(&priv->ecus);
 	priv->ndev = ndev;
@@ -152,9 +159,9 @@ static inline void j1939_priv_set(struct net_device *ndev,
 	can_ml->j1939_priv = priv;
 }
 
-static void __j1939_priv_release(struct kref *kref)
+static void __j1939_priv_release_work(struct work_struct *work)
 {
-	struct j1939_priv *priv = container_of(kref, struct j1939_priv, kref);
+	struct j1939_priv *priv = container_of(work, struct j1939_priv, release_work);
 	struct net_device *ndev = priv->ndev;
 
 	netdev_dbg(priv->ndev, "%s: 0x%p\n", __func__, priv);
@@ -165,6 +172,22 @@ static void __j1939_priv_release(struct kref *kref)
 
 	netdev_put(ndev, &priv->dev_tracker);
 	kfree(priv);
+	/* This is safe, for j1939_module_exit() waits for completion of
+	 * this callback using destroy_workqueue().
+	 */
+	module_put(THIS_MODULE);
+}
+
+static void __j1939_priv_release(struct kref *kref)
+{
+	struct j1939_priv *priv = container_of(kref, struct j1939_priv, kref);
+
+	/* Since synchronously dropping module refcount of self is not safe,
+	 * defer actual release to WQ context.
+	 */
+	INIT_WORK(&priv->release_work, __j1939_priv_release_work);
+	queue_work(j1939_wq, &priv->release_work);
+
 }
 
 void j1939_priv_put(struct j1939_priv *priv)
@@ -281,8 +304,7 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
 		 */
 		kref_get(&priv_new->rx_kref);
 		mutex_unlock(&j1939_netdev_lock);
-		netdev_put(ndev, &priv->dev_tracker);
-		kfree(priv);
+		j1939_priv_put(priv);
 		return priv_new;
 	}
 	j1939_priv_set(ndev, priv);
@@ -297,9 +319,7 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
  out_priv_put:
 	j1939_priv_set(ndev, NULL);
 	mutex_unlock(&j1939_netdev_lock);
-
-	netdev_put(ndev, &priv->dev_tracker);
-	kfree(priv);
+	j1939_priv_put(priv);
 
 	return ERR_PTR(ret);
 }
@@ -401,6 +421,12 @@ static __init int j1939_module_init(void)
 
 	pr_info("can: SAE J1939\n");
 
+	j1939_wq = alloc_workqueue("j1939_wq", WQ_HIGHPRI | WQ_PERCPU, 0);
+	if (!j1939_wq) {
+		ret = -ENOMEM;
+		goto fail_wq;
+	}
+
 	ret = register_netdevice_notifier(&j1939_netdev_notifier);
 	if (ret)
 		goto fail_notifier;
@@ -416,6 +442,8 @@ static __init int j1939_module_init(void)
  fail_sk:
 	unregister_netdevice_notifier(&j1939_netdev_notifier);
  fail_notifier:
+	destroy_workqueue(j1939_wq);
+ fail_wq:
 	return ret;
 }
 
@@ -424,6 +452,11 @@ static __exit void j1939_module_exit(void)
 	can_proto_unregister(&j1939_can_proto);
 
 	unregister_netdevice_notifier(&j1939_netdev_notifier);
+
+	/* We need to make sure that __j1939_priv_release_work() is
+	 * no longer running before unmapping memory for this module.
+	 */
+	destroy_workqueue(j1939_wq);
 }
 
 module_init(j1939_module_init);
-- 
2.56.0

