Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794931082;
	b=KhZJJzRyQrDBtn0jHHskaoiecKM/xJZAe9UrTAMDtLrBNA+x6ceOkoOuKz9zopiNw4sf
	 tfblf3VlCx3CLD8VkzC2qIk5lwlJK7hLYbg4qhOgnk749gsI1xJ9u6u5myX65r0mgqlq4
	 fVMa4C+R/m0mEwAiyz5VsgWIWRJ0fywa2RxqrJOQwONc5A5x2v+3fIMhoz7X/qFxzW+U6
	 A2BqUoa6sKz1wy3oVAIvPg5juMeO34UsKfoVEnLG8bgMgkI8Awx67kTu2JpRVVjilpgei
	 HnzVch8b4ZGwseh4IfA6STMtY3xgmv+fzgY7oVjzV1XvZar8OREulNOCrQd2oZyadcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794931082;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Anti-Virus-Server:
	 X-Virus-Status;
	bh=9sa4C5zLgOuM1G1BtYXz3JjjNxH1fJszORNn45CsmZU=;
	b=1MoaHQmMtFUc/X70F1bUTtjEK8f0Uq+zKixfbCQjzbFG8pbFUGdebjpRpzYJo0cPZY45
	 1R6tG+Y4vjQplSyirtRDLa1wp7du/wZohtup/DOtLiNf5J+dRLvstAxtFbOBatXAlugSt
	 tDDEFcYEYEzyvJUC6qeu69DS80Rx3YPzyg8qwpIxyzht3PopqR39cAYbgHXAyBoNy/3Ze
	 w1Xj320/UXrvBUIXDTF0aRk7xX/oJUOJelY1kwNfVdZQB/NVqlmU4UYYUn09T1p+Nx+BP
	 x/maDztseAYl3nx2CeVDpkvxSVou+QrYekwY8/XNb5CVCR5HqjKZwM3z7E9Sa6okE0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DB2606A31C
	for <linux-can@vger.kernel.org>; Tue, 17 Nov 2026 15:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14DB2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6AHFvjL6029997;
	Wed, 18 Nov 2026 00:57:45 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6AHFvjUL029994
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 18 Nov 2026 00:57:45 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b0a388e4-6094-497b-9c5d-c633230a4f21@I-love.SAKURA.ne.jp>
Date: Wed, 18 Nov 2026 00:57:44 +0900
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
Subject: [PATCH v15 3/3] can: j1939: fix possibility of hard-lockup/deadlock
 in j1939_ecu_timer_cancel()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>
References: <98c16a74-5ea7-476e-ab36-c98fb77b6be4@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <98c16a74-5ea7-476e-ab36-c98fb77b6be4@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav111.rs.sakura.ne.jp
X-Virus-Status: clean

Since j1939_ecu_timer_cancel() is calling hrtimer_cancel() with priv->lock
held for write while j1939_ecu_timer_handler() takes priv->lock, a hard-
lockup (if CONFIG_PREEMPT_RT=n && CONFIG_SMP=y) or a deadlock between
priv->lock and cpu_base->softirq_expiry_lock (if CONFIG_PREEMPT_RT=y) will
happen when hrtimer_cancel() calls hrtimer_cancel_wait_running().

The comment for "struct j1939_priv"->lock says that priv->lock is used for
protecting "struct list_head ecus" and "struct j1939_addr_ent ents[256]".
But j1939_ac_process() is using priv->lock for also serializing timer
management across multiple frames. This makes it impossible to temporarily
drop priv->lock in order to safely call hrtimer_cancel().

Therefore, fix this problem by introducing ac_process_lock that works as
an outer lock for temporarily dropping priv->lock in order to safely call
hrtimer_cancel().

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 net/can/j1939/address-claim.c | 4 ++++
 net/can/j1939/j1939-priv.h    | 3 +++
 net/can/j1939/main.c          | 1 +
 3 files changed, 8 insertions(+)

diff --git a/net/can/j1939/address-claim.c b/net/can/j1939/address-claim.c
index ca4ad6cdd5cb..594d2849c9f8 100644
--- a/net/can/j1939/address-claim.c
+++ b/net/can/j1939/address-claim.c
@@ -147,6 +147,7 @@ static void j1939_ac_process(struct j1939_priv *priv, struct sk_buff *skb)
 		return;
 	}
 
+	spin_lock_bh(&priv->ac_process_lock);
 	write_lock_bh(&priv->lock);
 
 	/* Few words on the ECU ref counting:
@@ -212,7 +213,9 @@ static void j1939_ac_process(struct j1939_priv *priv, struct sk_buff *skb)
 		goto out_unlock_bh;
 
 	/* cancel pending (previous) address claim */
+	write_unlock_bh(&priv->lock);
 	j1939_ecu_timer_cancel(ecu);
+	write_lock_bh(&priv->lock);
 
 	if (j1939_address_is_idle(skcb->addr.sa)) {
 		j1939_ecu_unmap_locked(ecu);
@@ -242,6 +245,7 @@ static void j1939_ac_process(struct j1939_priv *priv, struct sk_buff *skb)
 	j1939_ecu_put(ecu);
  out_unlock_bh:
 	write_unlock_bh(&priv->lock);
+	spin_unlock_bh(&priv->ac_process_lock);
 }
 
 void j1939_ac_recv(struct j1939_priv *priv, struct sk_buff *skb)
diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index af179eb44b15..28f6fa6029ec 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -62,6 +62,9 @@ struct j1939_priv {
 	/* segments need a lock to protect the above list */
 	rwlock_t lock;
 
+	/* serializes j1939_ac_process() processing */
+	spinlock_t ac_process_lock;
+
 	struct net_device *ndev;
 	netdevice_tracker dev_tracker;
 
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index b76037f89a80..4bae9402c4c0 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -140,6 +140,7 @@ static struct j1939_priv *j1939_priv_create(struct net_device *ndev)
 	}
 
 	rwlock_init(&priv->lock);
+	spin_lock_init(&priv->ac_process_lock);
 	INIT_LIST_HEAD(&priv->ecus);
 	priv->ndev = ndev;
 	kref_init(&priv->kref);
-- 
2.56.1

