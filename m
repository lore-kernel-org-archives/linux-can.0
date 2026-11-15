Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794720982;
	b=mlx1lJQWnM8lyIa4/JxYzTcQKF6IYUA+E5AwfOMv9veRjDB30gl06e0rxhrnmSFXbsqD
	 PGYJvDwxDHrplMQUZPgEKAGljosD8Ym2OAhMUhvlSkJFrqK1xoLzgy8iRTrIo4zepVikE
	 w6iqb1UxIg30iVICthrTinfAxN3Ya+0AcD26+qMd6S80LpfR/Vk7WxJ1ZKj6un7KAmhY/
	 VN9qWrR5vq2/u//Agb7RdLSDMWeiNc9EuyiyfCzl41mxW2EpPh0NlJE5xRZDiqyM68UI3
	 mme+UYCFVc+7MJQ/5owyxJjjlK5eFF46kJDVcmbWFuVghmxEIt8PkVDwHULWF5rzydQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794720982;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Anti-Virus-Server:
	 X-Virus-Status;
	bh=yXV3fP/zgtz/7aj+6A90ujmwZF1K1RJGrfVnXmXCBz4=;
	b=NXYtuddxgeaBhrdbBnNkeSx1/e2Y+p8CWzNbfiWeUcI7CREyuqSZzyK8+akIE34PX8jk
	 By1aINaDe5yVossqF5xrprh+y4FEusaBmk8FLxt/rfQtmtCIL5mr8bHqIDwiRLPtiuYFB
	 HR2nY0geLvELxhTp2geu1mINGco6zOFBv3STFx0mO04y8MvGsCj9mRJjER0+4jaHNsIVm
	 BvGyWewRM0M1OAZPix5Yef5+4/4bVqsV1ndC1Pa78GLxxHsjrINYA3rgJn1zDiubK5Up+
	 9qC1CXCoEcJxtwSOf0/fScHLNp0YcLY4W3weWw/xup9yeONEUGwtokOCKpkYe+ACdHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9190606A327
	for <linux-can@vger.kernel.org>; Sun, 15 Nov 2026 05:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9190606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6AF5aAXM072537;
	Sun, 15 Nov 2026 14:36:10 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6AF5aA09072533
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 15 Nov 2026 14:36:10 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <dc9d8b6a-5e6c-4392-9b6a-f5f546bfe872@I-love.SAKURA.ne.jp>
Date: Sun, 15 Nov 2026 14:36:11 +0900
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
Subject: [PATCH v13 6/6] can: j1939: fix possibility of hard-lockup/deadlock
 in j1939_ecu_timer_cancel()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>
References: <7cc08b0f-290e-464b-ab13-0a5ce3c57f4f@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <7cc08b0f-290e-464b-ab13-0a5ce3c57f4f@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav313.rs.sakura.ne.jp
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

Therefore, fix this problem by introducing two bool flags that implement
logical cancellation (negotiate hrtimer_try_to_cancel() == -1 condition)
and dropping address claim frames during logical cancellation.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 net/can/j1939/address-claim.c |  7 ++++--
 net/can/j1939/bus.c           | 40 ++++++++++++++++++++++++++++++++---
 net/can/j1939/j1939-priv.h    |  6 +++++-
 3 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/net/can/j1939/address-claim.c b/net/can/j1939/address-claim.c
index ca4ad6cdd5cb..e6c9fdeba9c7 100644
--- a/net/can/j1939/address-claim.c
+++ b/net/can/j1939/address-claim.c
@@ -211,8 +211,11 @@ static void j1939_ac_process(struct j1939_priv *priv, struct sk_buff *skb)
 	if (IS_ERR_OR_NULL(ecu))
 		goto out_unlock_bh;
 
-	/* cancel pending (previous) address claim */
-	j1939_ecu_timer_cancel(ecu);
+	/* Cancel pending (previous) address claim. If we can't cancel,
+	 * do nothing until pending (previous) address claim commits or aborts.
+	 */
+	if (!j1939_ecu_timer_cancel(ecu))
+		goto out_ecu_put;
 
 	if (j1939_address_is_idle(skcb->addr.sa)) {
 		j1939_ecu_unmap_locked(ecu);
diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index 9b40f3754623..6520c91a6e1e 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -156,15 +156,35 @@ void j1939_ecu_timer_start(struct j1939_ecu *ecu)
 		return;
 
 	/* Schedule timer in 250 msec to commit address change. */
+	ecu->abort_ac_handler = false;
+	ecu->done_ac_handler = false;
 	hrtimer_start(&ecu->ac_timer, ms_to_ktime(250),
 		      HRTIMER_MODE_REL_SOFT);
 }
 
-void j1939_ecu_timer_cancel(struct j1939_ecu *ecu)
+bool j1939_ecu_timer_cancel(struct j1939_ecu *ecu)
 {
-	if (hrtimer_cancel(&ecu->ac_timer))
+	switch (hrtimer_try_to_cancel(&ecu->ac_timer)) {
+	case 0:	/* Not active or already finished. */
+		break;
+	case 1:	/* Successfully canceled. */
 		/* Drop the ref from j1939_ecu_timer_start(). */
 		j1939_ecu_put(ecu);
+		break;
+	default: /* Currently executing. */
+		/* OK to call j1939_ecu_timer_start() again if
+		 * j1939_ecu_timer_handler() already committed or aborted.
+		 */
+		if (ecu->done_ac_handler)
+			break;
+		/* Tell j1939_ecu_timer_handler() to abort. */
+		ecu->abort_ac_handler = true;
+		/* Don't call j1939_ecu_timer_start() until
+		 * j1939_ecu_timer_handler() commits or aborts.
+		 */
+		return false;
+	}
+	return true;
 }
 
 static enum hrtimer_restart j1939_ecu_timer_handler(struct hrtimer *hrtimer)
@@ -174,14 +194,28 @@ static enum hrtimer_restart j1939_ecu_timer_handler(struct hrtimer *hrtimer)
 	struct j1939_priv *priv = ecu->priv;
 
 	write_lock_bh(&priv->lock);
+
+	/* Abort if j1939_ecu_timer_cancel() told me to abort. */
+	if (ecu->abort_ac_handler) {
+		ecu->abort_ac_handler = false;
+		goto out;
+	}
+
 	/* TODO: can we test if ecu->addr is unicast before starting
 	 * the timer?
 	 */
 	j1939_ecu_map_locked(ecu);
 
+out:
+	/* Tell j1939_ecu_timer_cancel() that this handler has finished
+	 * its critical section (either committed or aborted), so no need
+	 * to set abort_ac_handler again while __run_hrtimer() is finishing.
+	 */
+	ecu->done_ac_handler = true;
+	write_unlock_bh(&priv->lock);
+
 	/* Drop the ref from j1939_ecu_timer_start(). */
 	j1939_ecu_put(ecu);
-	write_unlock_bh(&priv->lock);
 
 	return HRTIMER_NORESTART;
 }
diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 55ded221cd82..23f37e0b17bc 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -43,6 +43,10 @@ struct j1939_ecu {
 	/* count users, to help transport protocol decide for interaction */
 	int nusers;
 
+	/* protected by priv->lock */
+	bool abort_ac_handler;
+	bool done_ac_handler;
+
 	struct work_struct release_work;
 };
 
@@ -207,7 +211,7 @@ void j1939_simple_recv(struct j1939_priv *priv, struct sk_buff *skb);
 struct j1939_ecu *j1939_ecu_create_locked(struct j1939_priv *priv, name_t name);
 
 void j1939_ecu_timer_start(struct j1939_ecu *ecu);
-void j1939_ecu_timer_cancel(struct j1939_ecu *ecu);
+bool __must_check j1939_ecu_timer_cancel(struct j1939_ecu *ecu);
 void j1939_ecu_unmap_all(struct j1939_priv *priv);
 
 struct j1939_priv *j1939_netdev_start(struct net_device *ndev);
-- 
2.56.0

