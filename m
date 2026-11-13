Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590025;
	b=bBAMi/VL3m3VvWuIILqKO67nxt2hrlhlQpRvwz10H1nupvMf7SbtwAyMoz0rBJx7rYs6
	 FqdxrBZpGoAKS/BZXs6kLe2zgt6yBrVIAy97c1b2MN+WxAywwf/QtRiohPrB+pLAQ/YE8
	 g9Kf6joFU55ww0tL422ZvPD9JlJdZl+/mg5GN7g188+VfutcIcOwYP6y7U3/2+F823gz5
	 /TbobUbX/VwAdsalczYXlrRleUoZaxfb1fToHg/ltH8W58sYXctT12sN9lQ/lQyE7Q1rE
	 bKCC3eqzy1hkzBcdhexw2gNVdX5gl007hK8YfGWQR2pt5N2DvYA1g4cIXJNS0fm3Ong==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590025;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Anti-Virus-Server:
	 X-Virus-Status;
	bh=eKKEZNuAFlGjufaon6nWYN3HJSn9jqRoVxbXmn2bIUY=;
	b=fmU8dCH3HdnomJzMCjMx6AFPS/7fl0N/f1pA6wD+wYTCNBVugA1brwrjNT7gkrmJ0Xlg
	 MLSSDf/HnIrzaIPwpz/igvJUwSZDFSO/Y1+iZlZfDtxLxZQ5kpN6yjXszNLo6rqKIKZbV
	 eIVRu1GMx6PGhqcOCze4yO+5v3V/h0nckK9ybAa51a7SRYNuBcSoe6hBcGpwg5bgpN7yz
	 p5gflisTv54770gmHcUfkqwEmvuil4ndPuM62/xsCoZ36aj/j7b3pluVTLaMhgScoqmWS
	 Ywa95YgH3YA+9AJOhrpu7TdxuRDoHLwdch1yRfIAjOC6joHQccst94Ksgkova7DPgeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5E0606A890
	for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 17:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F5E0606A890
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6ADHDLnQ088837;
	Sat, 14 Nov 2026 02:13:21 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6ADHDLsQ088834
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 14 Nov 2026 02:13:21 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ba3e6880-6dff-4fa6-a2e4-629c3d35b8d5@I-love.SAKURA.ne.jp>
Date: Sat, 14 Nov 2026 02:13:20 +0900
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
Subject: [PATCH v12 2/3] can: j1939: fix possibility of hard-lockup/deadlock
 in j1939_ecu_timer_cancel()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>
References: <8de287d7-b4e1-4062-b40e-b193f5ec68ca@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <8de287d7-b4e1-4062-b40e-b193f5ec68ca@I-love.SAKURA.ne.jp>
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

Therefore, fix this problem by introducing two bool flags that implement
logical cancellation (negotiate hrtimer_try_to_cancel() == -1 condition).

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 net/can/j1939/bus.c        | 25 +++++++++++++++++++++++--
 net/can/j1939/j1939-priv.h |  4 ++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index c49c96dea796..8cbf8716d286 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -147,15 +147,25 @@ void j1939_ecu_timer_start(struct j1939_ecu *ecu)
 		return;
 
 	/* Schedule timer in 250 msec to commit address change. */
+	ecu->ac_commit_done = false;
 	hrtimer_start(&ecu->ac_timer, ms_to_ktime(250),
 		      HRTIMER_MODE_REL_SOFT);
 }
 
 void j1939_ecu_timer_cancel(struct j1939_ecu *ecu)
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
+		/* Tell j1939_ecu_timer_handler() to abort unless committed. */
+		if (!ecu->ac_commit_done)
+			ecu->ac_want_abort = true;
+	}
 }
 
 static enum hrtimer_restart j1939_ecu_timer_handler(struct hrtimer *hrtimer)
@@ -165,14 +175,25 @@ static enum hrtimer_restart j1939_ecu_timer_handler(struct hrtimer *hrtimer)
 	struct j1939_priv *priv = ecu->priv;
 
 	write_lock_bh(&priv->lock);
+
+	/* Abort if j1939_ecu_timer_cancel() told me to abort. */
+	if (ecu->ac_want_abort) {
+		ecu->ac_want_abort = false;
+		goto out;
+	}
+
 	/* TODO: can we test if ecu->addr is unicast before starting
 	 * the timer?
 	 */
 	j1939_ecu_map_locked(ecu);
 
+	/* Commit and tell j1939_ecu_timer_cancel() not to ask me to abort. */
+	ecu->ac_commit_done = true;
+out:
+	write_unlock_bh(&priv->lock);
+
 	/* Drop the ref from j1939_ecu_timer_start(). */
 	j1939_ecu_put(ecu);
-	write_unlock_bh(&priv->lock);
 
 	return HRTIMER_NORESTART;
 }
diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 623aeb2e54e1..d50b6e21d688 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -43,6 +43,10 @@ struct j1939_ecu {
 	/* count users, to help transport protocol decide for interaction */
 	int nusers;
 
+	/* protected by priv->lock */
+	bool ac_want_abort;
+	bool ac_commit_done;
+
 	struct work_struct release_work;
 };
 
-- 
2.56.0

