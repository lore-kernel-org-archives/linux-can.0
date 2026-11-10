Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326712;
	b=YF/IjUhsxNEya36P/8cqmGqvq1o7vJlHA+yF5KCylMPc8X/QyHNLWp8HvL1o/TAEf+XR
	 P+KNwJrB0Ern2vozpimMAqm2LRJAs9qvkOTyxlSJphDA4KFz73M8bjJWKF9c2JGV7qjCO
	 oLO2OaZc/tyiR3Bqc2ir4Hm3m0GZyQWoUkFyws0xUSo4vc/+aQHh3DNFXB7BGTrQSbFd5
	 IkCPDluHqg27Qp83hX8l/NkdK+GDtB7qMGhQNdvHJBh+wnfxWQSFDInRUGS+VZQ/OiYtu
	 bXAdjQ/t4E/dN1t98hLLUahosfT/tn1Bu4NUeqKMVr/GqNmYp0Pgttc0nB5iB5lDWpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326712;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Virus-Status:
	 X-Anti-Virus-Server;
	bh=K4WD4gksNhFt+catTBlWQ4cGnnEKGsM+S4VCWhjkBQE=;
	b=D/I2rEQlW6N5FLdA2IrZcjjyRDTuuPxPsJlWsFsy3DVCSL4y06XpQLtfE/lenbjGLuO6
	 wvTNJhP53vfTqj1o4+jQmGMfKauQQXXkE567lSVxCP5FcJfeov1umMQA7uBJyN3bGT+LP
	 hlALkofTnLd3goy+ySEwws4wgMinXVxtw2T4Pb9chyyAK9SM0EPY/a+uz4aXt52K/oqj6
	 EY80IhOUTwPyOiDiWcCIMHhP1uLV26sjC5hxmT0N4lACw4M3uxUhub1SWOkbTWiVG6KrP
	 C+e7FLXDi+w+/gEXVwr9ZGJXNU9LF5U0XR3/Nvc43KnV1tyOSnvnVM9OIc0jAMy00mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB14606A31C
	for <linux-can@vger.kernel.org>; Tue, 10 Nov 2026 16:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EB14606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6AAG4sca070513;
	Wed, 11 Nov 2026 01:04:54 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6AAG4ram070510
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 11 Nov 2026 01:04:53 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f516220f-b922-4172-bf35-ce34d5f21b39@I-love.SAKURA.ne.jp>
Date: Wed, 11 Nov 2026 01:04:50 +0900
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
Subject: [PATCH v11 2/3] can: j1939: fix possibility of hard-lockup/deadlock
 in j1939_ecu_timer_cancel()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>
References: <a1dd9760-7815-400a-a39c-a1a03cf8262e@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <a1dd9760-7815-400a-a39c-a1a03cf8262e@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav114.rs.sakura.ne.jp

Since j1939_ecu_timer_cancel() is calling hrtimer_cancel() with priv->lock
held for write while j1939_ecu_timer_handler() takes priv->lock, a hard-
lockup (if CONFIG_PREEMPT_RT=n && CONFIG_SMP=y) or a deadlock between
priv->lock and cpu_base->softirq_expiry_lock (if CONFIG_PREEMPT_RT=y) will
happen when hrtimer_cancel() calls hrtimer_cancel_wait_running().

The comment for "struct j1939_priv"->lock says that priv->lock is used for
protecting "struct list_head ecus" and "struct j1939_addr_ent ents[256]".
But j1939_ac_process() is using priv->lock for also serializing timer
management across multiple frames. This makes it impossible to temporarily
drop priv->lock in order to safely call hrtimer_cancel(). Therefore, fix
this problem by dropping an address claim frame when address claim timer
cannot be canceled.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 net/can/j1939/address-claim.c |  3 ++-
 net/can/j1939/bus.c           | 12 ++++++++++--
 net/can/j1939/j1939-priv.h    |  2 +-
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/can/j1939/address-claim.c b/net/can/j1939/address-claim.c
index ca4ad6cdd5cb..89ba8c6fbe74 100644
--- a/net/can/j1939/address-claim.c
+++ b/net/can/j1939/address-claim.c
@@ -212,7 +212,8 @@ static void j1939_ac_process(struct j1939_priv *priv, struct sk_buff *skb)
 		goto out_unlock_bh;
 
 	/* cancel pending (previous) address claim */
-	j1939_ecu_timer_cancel(ecu);
+	if (!j1939_ecu_timer_cancel(ecu))
+		goto out_ecu_put;
 
 	if (j1939_address_is_idle(skcb->addr.sa)) {
 		j1939_ecu_unmap_locked(ecu);
diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index 1cee3239c41a..fb9f6f889549 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -151,11 +151,19 @@ void j1939_ecu_timer_start(struct j1939_ecu *ecu)
 		      HRTIMER_MODE_REL_SOFT);
 }
 
-void j1939_ecu_timer_cancel(struct j1939_ecu *ecu)
+bool j1939_ecu_timer_cancel(struct j1939_ecu *ecu)
 {
-	if (hrtimer_cancel(&ecu->ac_timer))
+	switch (hrtimer_try_to_cancel(&ecu->ac_timer)) {
+	case 0:	/* Not active or already finished. */
+		return true;
+	case 1:	/* Successfully canceled. */
 		/* Drop the ref from j1939_ecu_timer_start(). */
 		j1939_ecu_put(ecu);
+		return true;
+	default: /* Currently executing. */
+		/* Let the caller decide how to handle this situation. */
+		return false;
+	}
 }
 
 static enum hrtimer_restart j1939_ecu_timer_handler(struct hrtimer *hrtimer)
diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 623aeb2e54e1..49ce008acffb 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -205,7 +205,7 @@ void j1939_simple_recv(struct j1939_priv *priv, struct sk_buff *skb);
 struct j1939_ecu *j1939_ecu_create_locked(struct j1939_priv *priv, name_t name);
 
 void j1939_ecu_timer_start(struct j1939_ecu *ecu);
-void j1939_ecu_timer_cancel(struct j1939_ecu *ecu);
+bool __must_check j1939_ecu_timer_cancel(struct j1939_ecu *ecu);
 void j1939_ecu_unmap_all(struct j1939_priv *priv);
 
 struct j1939_priv *j1939_netdev_start(struct net_device *ndev);
-- 
2.56.0

