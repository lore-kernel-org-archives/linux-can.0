Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794742648;
	b=Z4V9aEuN6NaXfqgkBNVDR9DANgh2Anmc/ZLgrSf+IVVvO0pMOCie33ylvg6vx1FVd+NC
	 W+Dh3fGzWyPr1x4q0xECtUt1UM2/MPgwmXeP7vpMs0R+uXymhaBVnuF7d13o0pSo469ik
	 PYUwY+hVemQ4VwnuThTuAhcJgQBlQJtSj7lOPnSfL7zJU8FhVw3g7oz2swSda4Ydzkne7
	 OvH3MUJwup/KQGXH1ZRraMdC30Mb5JJXZZqbqo/8Q/lRM2iCLi2grwEVx1VYbiVbQRG+4
	 3t50WEZLzAAIOJ64s29/lwwgJhhW7qqstAw+FeaXKIojQATz9X8Rz/8TSm/hVWhGHXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794742648;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Virus-Status:
	 X-Anti-Virus-Server;
	bh=rDmLxEqbT7FUfAO4PuHjz4Se2O0Os4pccDrAaKyyto0=;
	b=FTdC7XGUvNdAfqReZdjoEssx1fCMdzStnFnI0fbAsSNjTV/kANzXSo0IixB3hhtT5oBB
	 Yr6XEW8xp2olQXaBbiIJgCQppywHAQjVbN4FIfJOENQfyhApUIHTl2nhFznPyEJehHuKv
	 hvWE9mP/FVemlW4FQ97bGX+GfUhCIQhPYEdFDHszsJS1SFfwmv7onD+wh58Jqxu9SWiH3
	 dzrzavzZaoXXpeGur0gkUX9AqU0m4b/SQaFgdsYUI9/IMw9UxxWfpanKJQydxmHqi9i43
	 qBgO1KhN89XsbnLtFWPegJy+B9M29hlL3JrFRdK4I9VA1sGtVub1OUdrXFwLhTx01mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA9E606A31F
	for <linux-can@vger.kernel.org>; Sun, 15 Nov 2026 11:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EA9E606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6AFBbHYe027190;
	Sun, 15 Nov 2026 20:37:17 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6AFBbHVd027187
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 15 Nov 2026 20:37:17 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1ad7d101-4549-420f-a827-6bf21bae884e@I-love.SAKURA.ne.jp>
Date: Sun, 15 Nov 2026 20:37:18 +0900
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
Subject: [PATCH v14 6/6] can: j1939: defer j1939_session_destroy() to WQ
 context
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
X-Virus-Status: clean
X-Anti-Virus-Server: fsav415.rs.sakura.ne.jp

To close a race window that j1939_module_exit() starts as soon as
j1939_priv_put(session->priv) from j1939_session_destroy() dropped
the module's refcount, defer actual release to WQ context which
j1939_module_exit() can wait for completion.

Also, to make sure that session->txtimer / session->rxtimer are no longer
running when the last user called j1939_session_put(), add a safeguard
that explicitly cancels session->txtimer / session->rxtimer before kfree().

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 net/can/j1939/j1939-priv.h |  2 ++
 net/can/j1939/main.c       |  4 ++--
 net/can/j1939/transport.c  | 27 ++++++++++++++++++++++-----
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 55ded221cd82..af179eb44b15 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -294,6 +294,8 @@ struct j1939_session {
 		unsigned int dpo;
 	} pkt;
 	struct hrtimer txtimer, rxtimer;
+
+	struct work_struct release_work;
 };
 
 struct j1939_sock {
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 1e05383bf30f..b6adf4e047a5 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -477,8 +477,8 @@ static __exit void j1939_module_exit(void)
 	unregister_netdevice_notifier(&j1939_netdev_notifier);
 
 	/* We need to make sure that __j1939_priv_release_work() and
-	 * __j1939_ecu_release_work() are no longer running before
-	 * unmapping memory for this module.
+	 * __j1939_ecu_release_work() and j1939_session_destroy_work()
+	 * are no longer running before unmapping memory for this module.
 	 */
 	destroy_workqueue(j1939_wq);
 }
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5e6f..87a932d10ffe 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -259,8 +259,11 @@ static void __j1939_session_drop(struct j1939_session *session)
 	sock_put(session->sk);
 }
 
-static void j1939_session_destroy(struct j1939_session *session)
+static void j1939_session_destroy_work(struct work_struct *work)
 {
+	struct j1939_session *session = container_of(work, struct j1939_session,
+						     release_work);
+	struct j1939_priv *priv = session->priv;
 	struct sk_buff *skb;
 
 	if (session->transmission) {
@@ -272,7 +275,7 @@ static void j1939_session_destroy(struct j1939_session *session)
 			j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
 	}
 
-	netdev_dbg(session->priv->ndev, "%s: 0x%p\n", __func__, session);
+	netdev_dbg(priv->ndev, "%s: 0x%p\n", __func__, session);
 
 	WARN_ON_ONCE(!list_empty(&session->sk_session_queue_entry));
 	WARN_ON_ONCE(!list_empty(&session->active_session_list_entry));
@@ -283,9 +286,18 @@ static void j1939_session_destroy(struct j1939_session *session)
 		kfree_skb(skb);
 	}
 	__j1939_session_drop(session);
-	netdev_put(session->priv->ndev, &session->priv_dev_tracker);
-	j1939_priv_put(session->priv);
+
+	/* There can't be any ref on this session because __j1939_session_release()
+	 * was already called. But we need to make sure that j1939_tp_txtimer() and
+	 * j1939_tp_rxtimer() are no longer running before kfree().
+	 */
+	WARN_ON(hrtimer_cancel(&session->txtimer));
+	WARN_ON(hrtimer_cancel(&session->rxtimer));
+
+	netdev_put(priv->ndev, &session->priv_dev_tracker);
+
 	kfree(session);
+	j1939_priv_put(priv);
 }
 
 static void __j1939_session_release(struct kref *kref)
@@ -293,7 +305,12 @@ static void __j1939_session_release(struct kref *kref)
 	struct j1939_session *session = container_of(kref, struct j1939_session,
 						     kref);
 
-	j1939_session_destroy(session);
+	/* To close a race window that j1939_module_exit() starts as soon as
+	 * j1939_priv_put() dropped the module's refcount, defer actual release
+	 * to WQ context where j1939_module_exit() can wait for completion.
+	 */
+	INIT_WORK(&session->release_work, j1939_session_destroy_work);
+	queue_work(j1939_wq, &session->release_work);
 }
 
 void j1939_session_put(struct j1939_session *session)
-- 
2.56.0

