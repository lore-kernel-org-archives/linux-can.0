Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793514973;
	b=FIFzzJRLq/5SVmvd9zpfaq7g2ZvIKj4XjOsgOz+D+3TIIdXuR6MujON6alWBayAVX7SW
	 OGTkCdWiStlj4NcXrCeBWa3d9XvH0rHZaDNMFAJrmDFFhNRTaStk96z1ObRekdbjMcwu4
	 mBrhhpQ8zGNSt+Xj8paLU0SvkU8EwjxTI+efO8Om10UHSMSISeamYc/oaNOEstD/px5IQ
	 tnde7ZstqPr0Ht6xX6MS31c/pJePcWMjnEoNog+Ad8CkF0mn7Xf79AfiGHq/WQ+U8txiB
	 23SfY4CZPrzRh9G+NH+BeCG3dx/JRufzDTo6EQ6T4XPvbwBujplvORySJMxI5+8/X1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793514973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=z9HT/Oi8sTDYdRC5RzRMiB3sQtxntVsWdlc8duAjBxQ=;
	b=ZO5INLytxu2XVm2YhNhZHFRUoIDH6NLUYmRLkBgOF1a2wtUgwHoNhuao+WvkepeN1IkN
	 Q/r0C/ubiPaU0QARU+mwj1/Z+cYh1r2JJRIIl6HKNlZAwBiwOd+Uc33ZoZRCRcC2Z0VHM
	 48nfDlbY28QnzHSOZo5dVDXpYg3G7622iuqO2J98ReIMYGkFaXpSeICnyj1eBanJhv9C5
	 l2wP3nDjiKA71yTqGCMW7He7jnMYAm1hh3w3dF0tiqwH+AtZnxDQAlpSQEh6N2vS7VBVy
	 elAPWikCu/kUeHp3KVkJQOcIBLSIC6kyJSyYNPzq3N1Rrcuuono8TzEJrynA9zWoB1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b="dEUKFs/y";
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F058606A325
	for <linux-can@vger.kernel.org>; Sun,  1 Nov 2026 06:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F058606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=dEUKFs/y
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e9d7791b00so14897055ad.0
        for <linux-can@vger.kernel.org>; Sat, 31 Oct 2026 23:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1793514972; x=1794119772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z9HT/Oi8sTDYdRC5RzRMiB3sQtxntVsWdlc8duAjBxQ=;
        b=dEUKFs/yxRTBrzfK3nH+Ym5DKXx8V3Il0IDD9rBobY2tJ6sckbgareYg5E01dhTJ+v
         hZZMQvGzXtzFiJ8Hn3opY5odHNhogS4O4wqmTsUIe82vecCa5aJPo2A4BjQPR2GT+cHG
         2t+W/FrydmkyaRq25KwXq1hV9Adb30fuzfDC2TBiTYczl7zbt/+28ZbZIGwd+9NYEgkK
         uqaqEVFdYaJqs+O6l9B6/dMRU/hriZCDn3X17jaIzY6Ghge+OtEecUDEmZys3fNV8QJR
         7qIG1GCnd3rNUCy9HbXtXwgd1FT2RJJg+Fk2tV0kqoMzXUjv9u6aTTJSGvcCJ4LYibq7
         8jLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793514972; x=1794119772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z9HT/Oi8sTDYdRC5RzRMiB3sQtxntVsWdlc8duAjBxQ=;
        b=t0YAPQlJmqQe87kICMOzkqErvliV48HIe2+rOEw6lI/42kK/M1AG6sEJWq6omFNkf3
         BOH8hxoyqAnqNy1mJ0TaPzORSXHev9WSjOU62vH3hZ7S4xMlijPrqjWZ31636aF+BJ+i
         CJArIEsZGHjvlHw+Tc/5roQaYYmNXfW07u33IXsc/EFTSWsKOHlMb+0CHZL3qvl+3X3d
         qQxNSn6Tmq2KwoqiM5Er9HFY82IwibZvZwdwSo+hZLLDN4R2fbpn5DS2W3O8KgOCDTjn
         anuWVQANZf1bNTcOsdLw57l9UpHdsfqTGBxe9SuwExY4lcxvzm4jVptRC6HX4PkGBZYR
         ZcRA==
X-Forwarded-Encrypted: i=1; AKwUvBwFZcb5rcYRpd7o+hD3jvp59bjabFd2Dt8MLm6XUCMy67gPA2BqjCftMO+1h8TuVUHIVF8zceC+Smo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+F2lCa57SoFCKZJwkzsloLgFlDr6rDucUuTMxxk8nFqlHhzTqp
	ltx7VXl+dHHCQ8Tjgzhvk758f32CVfoQ06CqwZiM+qGX0KyFFlHRCIwjMRu3OIH8KYh7
X-Gm-Gg: AYBFou2aJYSkNoA6IknmMwRskaALNJJYkFrm86+ZM+GwXPQe+EQoDWZwcGjeVCTVjGx
	fXeb5Au9OiYMSratC8L4etLWYC4cij5UU3dy9cGAJy/U4EncDyUcep65A+oSeuUTHjzvx9tDjQK
	zdBEYUU6piGZufi6YdrYMJYScLJDyfkwCK1XVdZ9qzQnlivGTVgqdTTvC1bPLfXFuc44RqLUHIr
	mBrhldqt6iizKkihq9oQPOUVxWw1tuTq2810IIttP1xZuMbZkTvXQMjNKUYdv7gU0PZe3o9o/xx
	LbOWadjBzguoxi47iPgjhHJS2V1tXjntlQunwYECtaliIKpki1BWkuKIwq1NiWYSXzhGEE6NyzK
	hMpqhj4o9pR7B2XrsB+oGMYi5n0wUEbib9bx2NwzLTotznRE/2qgIV/kEBxeZpjsqx+tSr+Av+x
	tl2+gKup72T+Sh/+hyvFdJip33cgz7TGdKVVSJ0THICGzauFq7X1BSObNGhlV+k18IPKQG+NANY
	bP75gUOoNLTZ/AOJyxtkKsDx2Y7sKDTyB6PUpBqGln68BlA2rgncZ0b5OXDZr7Lu2aXHdAP3hd+
	KQbnlLlNQunkt6TVQGdgQccQmLayJoDVydbOC31vhtYH2jHYIXkOMWdg0IO7MSvMtp/8eAt75np
	AIs0usw==
X-Received: by 2002:a17:90b:3f84:b0:3a4:e934:e85c with SMTP id 98e67ed59e1d1-3ae897a5c4amr5716199a91.41.1793514971761;
        Sat, 31 Oct 2026 23:36:11 -0700 (PDT)
Received: from 24c857d0c3be.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e949077sm14032763a91.9.2026.10.31.23.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 23:36:10 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: llvm@lists.linux.dev,
	linux-can@vger.kernel.org
Cc: robin@protonic.nl,
	o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	socketcan@hartkopp.net,
	mkl@pengutronix.de,
	ecathinds@gmail.com,
	dev.kurt@vandijck-laurijssen.be,
	maxime.jayat@mobile-devices.fr,
	bst@pengutronix.de,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	vega@nebusec.ai,
	zihanx@nebusec.ai,
	lkp@intel.com
Subject: [PATCH net v4 1/1] can: j1939: fix TX timer reference leak
Date: Sun,  1 Nov 2026 06:35:56 +0000
Message-ID: <f28a2c7a6891ea9d8b5a495493986e0b426a9978.1793371075.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1793371075.git.zihanx@nebusec.ai>
References: <cover.1793371075.git.zihanx@nebusec.ai>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reuse the session reference owned by a queued TX timer when its expiry is
replaced. Track the queued timer and running callback references separately
so a concurrent rearm does not lose or duplicate the session pin.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Link: https://bugtracker.nebusec.ai/f/11143
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 net/can/j1939/j1939-priv.h |   7 ++
 net/can/j1939/transport.c  | 173 +++++++++++++++++++++++++++++++++++--
 2 files changed, 172 insertions(+), 8 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index cf26352d1d8c..6334192744a6 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -10,6 +10,7 @@
 #define _J1939_PRIV_H_
 
 #include <linux/can/j1939.h>
+#include <linux/spinlock.h>
 #include <net/sock.h>
 
 /* Timeout to receive the abort signal over loop back. In case CAN
@@ -290,6 +291,12 @@ struct j1939_session {
 		unsigned int dpo;
 	} pkt;
 	struct hrtimer txtimer, rxtimer;
+	/* qref pins a queued timer; cbref pins its running callback. */
+	spinlock_t txtimer_lock;
+	bool txtimer_qref;
+	bool txtimer_cbref;
+	unsigned int txtimer_cancelers; /* block starts while a cancel waits */
+	bool txtimer_shutdown;
 };
 
 struct j1939_sock {
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5e6f..bf9021977d85 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -301,9 +301,74 @@ void j1939_session_put(struct j1939_session *session)
 	kref_put(&session->kref, __j1939_session_release);
 }
 
-static void j1939_session_txtimer_cancel(struct j1939_session *session)
+static void j1939_session_txtimer_cancel(struct j1939_session *session,
+					 bool shutdown)
 {
-	if (hrtimer_cancel(&session->txtimer))
+	bool put_qref = false;
+	int ret;
+
+	spin_lock_bh(&session->txtimer_lock);
+	session->txtimer_cancelers++;
+	if (shutdown)
+		session->txtimer_shutdown = true;
+	ret = hrtimer_try_to_cancel(&session->txtimer);
+	if (ret == 1) {
+		if (!WARN_ON_ONCE(!session->txtimer_qref)) {
+			session->txtimer_qref = false;
+			put_qref = true;
+		}
+	}
+	spin_unlock_bh(&session->txtimer_lock);
+
+	/* Never wait for a softirq callback while holding txtimer_lock. */
+	if (ret < 0) {
+		ret = hrtimer_cancel(&session->txtimer);
+		if (ret == 1) {
+			spin_lock_bh(&session->txtimer_lock);
+			if (!WARN_ON_ONCE(!session->txtimer_qref)) {
+				session->txtimer_qref = false;
+				put_qref = true;
+			}
+			spin_unlock_bh(&session->txtimer_lock);
+		}
+	}
+	spin_lock_bh(&session->txtimer_lock);
+	if (WARN_ON_ONCE(!session->txtimer_cancelers))
+		session->txtimer_cancelers = 0;
+	else
+		session->txtimer_cancelers--;
+	spin_unlock_bh(&session->txtimer_lock);
+
+	if (put_qref)
+		j1939_session_put(session);
+}
+
+static bool
+j1939_session_txtimer_cancel_async_locked(struct j1939_session *session)
+{
+	int ret;
+
+	lockdep_assert_held(&session->txtimer_lock);
+	session->txtimer_shutdown = true;
+	ret = hrtimer_try_to_cancel(&session->txtimer);
+	if (ret != 1)
+		return false;
+
+	if (WARN_ON_ONCE(!session->txtimer_qref))
+		return false;
+	session->txtimer_qref = false;
+	return true;
+}
+
+static void j1939_session_txtimer_cancel_async(struct j1939_session *session)
+{
+	bool put_qref;
+
+	spin_lock_bh(&session->txtimer_lock);
+	put_qref = j1939_session_txtimer_cancel_async_locked(session);
+	spin_unlock_bh(&session->txtimer_lock);
+
+	if (put_qref)
 		j1939_session_put(session);
 }
 
@@ -315,7 +380,7 @@ static void j1939_session_rxtimer_cancel(struct j1939_session *session)
 
 void j1939_session_timers_cancel(struct j1939_session *session)
 {
-	j1939_session_txtimer_cancel(session);
+	j1939_session_txtimer_cancel(session, true);
 	j1939_session_rxtimer_cancel(session);
 }
 
@@ -716,9 +781,51 @@ static int j1939_xtp_tx_abort(struct j1939_priv *priv,
 
 void j1939_tp_schedule_txtimer(struct j1939_session *session, int msec)
 {
-	j1939_session_get(session);
+	bool queued;
+	int ret;
+
+	j1939_session_list_lock(session->priv);
+	if (session->state != J1939_SESSION_ACTIVE) {
+		j1939_session_list_unlock(session->priv);
+		return;
+	}
+
+	spin_lock(&session->txtimer_lock);
+	if (session->txtimer_cancelers || session->txtimer_shutdown) {
+		spin_unlock(&session->txtimer_lock);
+		j1939_session_list_unlock(session->priv);
+		return;
+	}
+
+	/* Replace the queued timer without taking another session reference. */
+	ret = hrtimer_try_to_cancel(&session->txtimer);
+	if (ret == 1) {
+		if (WARN_ON_ONCE(!session->txtimer_qref))
+			j1939_session_get(session);
+		session->txtimer_qref = true;
+	} else if (ret == 0) {
+		if (!session->txtimer_qref) {
+			j1939_session_get(session);
+			session->txtimer_qref = true;
+		}
+	} else {
+		/* The callback is running; preserve its pin and pin the rearm. */
+		queued = hrtimer_is_queued(&session->txtimer);
+		if (!queued && !session->txtimer_cbref &&
+		    session->txtimer_qref) {
+			session->txtimer_qref = false;
+			session->txtimer_cbref = true;
+		}
+		if (!session->txtimer_qref) {
+			j1939_session_get(session);
+			session->txtimer_qref = true;
+		}
+	}
+
 	hrtimer_start(&session->txtimer, ms_to_ktime(msec),
 		      HRTIMER_MODE_REL_SOFT);
+	spin_unlock(&session->txtimer_lock);
+	j1939_session_list_unlock(session->priv);
 }
 
 static inline void j1939_tp_set_rxtimeout(struct j1939_session *session,
@@ -1105,6 +1212,9 @@ static bool j1939_session_deactivate_locked(struct j1939_session *session)
 	bool active = false;
 
 	lockdep_assert_held(&session->priv->active_session_list_lock);
+	spin_lock(&session->txtimer_lock);
+	session->txtimer_shutdown = true;
+	spin_unlock(&session->txtimer_lock);
 
 	if (session->state >= J1939_SESSION_ACTIVE &&
 	    session->state < J1939_SESSION_ACTIVE_MAX) {
@@ -1126,6 +1236,8 @@ static bool j1939_session_deactivate(struct j1939_session *session)
 	j1939_session_list_lock(priv);
 	active = j1939_session_deactivate_locked(session);
 	j1939_session_list_unlock(priv);
+	if (active)
+		j1939_session_txtimer_cancel_async(session);
 
 	return active;
 }
@@ -1161,15 +1273,23 @@ static void __j1939_session_cancel(struct j1939_session *session,
 static void j1939_session_cancel(struct j1939_session *session,
 				 enum j1939_xtp_abort err)
 {
+	bool cancelled = false;
+
 	j1939_session_list_lock(session->priv);
 
 	if (session->state >= J1939_SESSION_ACTIVE &&
 	    session->state < J1939_SESSION_WAITING_ABORT) {
 		j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
 		__j1939_session_cancel(session, err);
+		spin_lock(&session->txtimer_lock);
+		session->txtimer_shutdown = true;
+		spin_unlock(&session->txtimer_lock);
+		cancelled = true;
 	}
 
 	j1939_session_list_unlock(session->priv);
+	if (cancelled)
+		j1939_session_txtimer_cancel_async(session);
 
 	if (!session->sk)
 		j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
@@ -1180,8 +1300,26 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 	struct j1939_session *session =
 		container_of(hrtimer, struct j1939_session, txtimer);
 	struct j1939_priv *priv = session->priv;
+	bool can_rearm, shutdown;
+	bool put_cbref = false;
 	int ret = 0;
 
+	spin_lock_bh(&session->txtimer_lock);
+	if (!session->txtimer_cbref) {
+		if (WARN_ON_ONCE(!session->txtimer_qref))
+			j1939_session_get(session);
+		session->txtimer_qref = false;
+		session->txtimer_cbref = true;
+	}
+	shutdown = session->txtimer_shutdown;
+	spin_unlock_bh(&session->txtimer_lock);
+
+	j1939_session_list_lock(priv);
+	can_rearm = session->state == J1939_SESSION_ACTIVE;
+	j1939_session_list_unlock(priv);
+	if (shutdown || !can_rearm)
+		goto txtimer_done;
+
 	if (session->skcb.addr.type == J1939_SIMPLE) {
 		ret = j1939_simple_txnext(session);
 	} else {
@@ -1232,7 +1370,20 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 		}
 	}
 
-	j1939_session_put(session);
+txtimer_done:
+	j1939_session_list_lock(priv);
+	can_rearm = session->state == J1939_SESSION_ACTIVE;
+	j1939_session_list_unlock(priv);
+	spin_lock_bh(&session->txtimer_lock);
+	if (session->txtimer_qref &&
+	    (session->txtimer_shutdown || !can_rearm))
+		hrtimer_start(&session->txtimer, 0, HRTIMER_MODE_REL_SOFT);
+	put_cbref = session->txtimer_cbref;
+	session->txtimer_cbref = false;
+	spin_unlock_bh(&session->txtimer_lock);
+
+	if (put_cbref)
+		j1939_session_put(session);
 
 	return HRTIMER_NORESTART;
 }
@@ -1486,7 +1637,7 @@ j1939_xtp_rx_cts_one(struct j1939_session *session, struct sk_buff *skb)
 			if (session->pkt.tx_acked)
 				j1939_sk_errqueue(session,
 						  J1939_ERRQUEUE_TX_SCHED);
-			j1939_session_txtimer_cancel(session);
+			j1939_session_txtimer_cancel(session, false);
 			j1939_tp_schedule_txtimer(session, 0);
 		}
 	} else {
@@ -1540,6 +1691,7 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(&session->skcb, skcb, sizeof(session->skcb));
 
+	spin_lock_init(&session->txtimer_lock);
 	hrtimer_setup(&session->txtimer, j1939_tp_txtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	hrtimer_setup(&session->rxtimer, j1939_tp_rxtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 
@@ -1810,7 +1962,7 @@ static void j1939_xtp_rx_rts(struct j1939_priv *priv, struct sk_buff *skb,
 			j1939_tp_set_rxtimeout(session, 750);
 	} else {
 		if (!session->transmission) {
-			j1939_session_txtimer_cancel(session);
+			j1939_session_txtimer_cancel(session, false);
 			j1939_tp_schedule_txtimer(session, 0);
 		}
 		j1939_tp_set_rxtimeout(session, 1250);
@@ -2242,7 +2394,12 @@ int j1939_cancel_active_session(struct j1939_priv *priv, struct sock *sk)
 				 &priv->active_session_list,
 				 active_session_list_entry) {
 		if (!sk || sk == session->sk) {
-			if (hrtimer_try_to_cancel(&session->txtimer) == 1)
+			bool put_qref;
+
+			spin_lock(&session->txtimer_lock);
+			put_qref = j1939_session_txtimer_cancel_async_locked(session);
+			spin_unlock(&session->txtimer_lock);
+			if (put_qref)
 				j1939_session_put(session);
 			if (hrtimer_try_to_cancel(&session->rxtimer) == 1)
 				j1939_session_put(session);
-- 
2.43.0

