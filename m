Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794230199;
	b=Nc2DwOVJe5fP+fmAOcoxcLAx30sGG4FXzMuMo2vpY4VTAnPWjikR2qYIf053xWcs07iJ
	 QaAKiAGFziR5B5QI7wNcZfrhIceeOnRBm7ZAI7aQTkkwriwKCMgmIJ/AIzQOa+yrCZsTw
	 4kLg1m2t1IU5FociGE27hO6KksA4+XRsjeqGapQvfrdBw5MH2KKj0aZ599ZZ3R0hJvIyF
	 Wcsbw8qbdWV34gTzuosidfsrUEr67Dfjr0YP1ykxepadl6VapkM76MSuVs7G+hJ7O+hWR
	 H5iOO/fd4djr9ZJqDYuo3ao+p4HffV/9MbevSTLyWVg3hspFgPf2fkx9ozK575yQbjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794230199;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0/T42jLxdLYJWKpxxz6BdmjxHyP+SznlJh4hqkOHI/U=;
	b=BoD8+w4U+bpSi+vy2/rLkA6vhPy1YYcXr7jC3N3JhLrVZP2IB5hS3JPi/zbHMS40Zc4T
	 gA8a4hRyEaeyL/ScEbEtE2oZ1+x6rjJxMjnIdhWTJzDZGcNZE9UzaO63HCvLO5/fekQGO
	 iWpPNXU5fYDyKsyCKdAbXl0nKSNwXFFfoZLgVmUd0MI7yhl8z7ZW5mv/xJ+eLpnph5xXR
	 ll136BIsBXY7DrBYYAzK+7k75SzVvtgZ/FTqEfgZPwhVLvKgef1tvYkiPvmBdE8Yo1caC
	 nzRr9Ve1XUQPr0/Hbs66azMno9hVBJ6vvh7MRXRu3EzRYV9/Xrc/28OBc0K64bPaRzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=AaKu5CCU;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6AC606A31C
	for <linux-can@vger.kernel.org>; Mon,  9 Nov 2026 13:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D6AC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=AaKu5CCU
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ed28bac8d7so3105755ad.0
        for <linux-can@vger.kernel.org>; Mon, 09 Nov 2026 05:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1794230198; x=1794834998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0/T42jLxdLYJWKpxxz6BdmjxHyP+SznlJh4hqkOHI/U=;
        b=AaKu5CCUH0EsMJsQuIdM/f14AK5TvlPBpsaWF3J0mpKBQwJqxlkLQvZOisXpy20QeK
         PVhBawanQKN3w6P1RrDNFHQdaNe9pNX5nOQAeRWXz4NzEqwcTZ1YQvvFNRDqIGEu7lR1
         5zQzHs8AX7oS/dMDAJW429FtYgc5v8117TB5uMIyQoL9U1LfxofC/N1ICh6vexw2GG5j
         cyEqHTJpblsGdoim0CiqXEam4/Z0jgFw6LFqzl5it1JG56vEvssa6oByO8cle8+EIYOY
         N00DpLpMnG9tr5GON4htcMGdUTwrOsiK78ngKZWxa+Nij2SxNiDM374FQA526dYdUCpP
         AhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794230198; x=1794834998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0/T42jLxdLYJWKpxxz6BdmjxHyP+SznlJh4hqkOHI/U=;
        b=vfw2/jb9eAbRePebwp9dWaZ1I2slFcTftb6gdm7OyBYgyT5Iy+1KrYBB2Yr6nNiPC7
         vhWWA148bjWlZbDltp3B+enVZuFI6t3dTn3MbHlUBsxZrBTvEFcDKHHWD/t7q1KHqfhP
         UXat9bcKyRMzS0i88HYZWe1W2XcAGf5zU+SYAuBEjmfgAsbOn7t2+lV3v7Gs8cZEpO+O
         Pt58tnkEygzlv8z0y1tWBtcHs3QTGX9PsxQPp0nuxph1AvDlHyLiXPoIfi+cXKpvAmGx
         AQBNCXVKJH7+bh7juZDKWatr4M0wjjS6jSI3ebubJ2m7EjcZ2LkFiNYDONGh1bmQPf9I
         UUUA==
X-Gm-Message-State: APuU4Z+PogC2d3ziEpbFCThNLRTR7+vsX3W049l702DjXICiOxy3Mspz
	xbmoLHI0Qow866DVvjJBNFPrsJR4XWzsDkh+POI84HtCn4MlbXNNgn2ycYGPNIACQN7HnmY2eVd
	9Alg1ACAa
X-Gm-Gg: AYBFou384AjL8pJoM0+o7/Te6Me/qTWHzP2NfSe3RlYEGI+ug65Bb/xIY8ozv5bDRSa
	OyXK5CECw6iv+pu625tPBv7znVmyn+CTSf6TCoem5F1Z9GUXXG4SrSFuvuQg+TIg8/yz4rOc17M
	/VW6QXPyW+akznVpLcFkiMeOUTaEKA+zwejbkx2OqXQcxFh+p/z0LZxhe37mq+BeotUqUocfnDZ
	p7lBV9+TXCRC2b6vEwiOr6pcAroS5WxQ6Kll1ZwLsNaWkFASOoW1qbKLdSKIHLgV7JVMMGQfsk2
	IrfTBHSic572Ya8U3XFaTL6rhhf9Yd4pe683YQXwwtOsPlzLZi1jdZjGJffXxb9aIF0ElLvwBkS
	A1ABNJ3No2pZ5B1ZTfzHuZPgtXdf5sxbIfM62YJxjRrObvL+jaA+FOPV2o/KigGeuy5LXC9BwVj
	DocddqaF92g77D6rbUDtaJtfxG46eQ+/wJ46hfuWBLB3fjQL6Be+Zt6+1WCepUL4s7MT6iS+iMl
	aE9R3Es6RNtZS6wZlALWK25yG8/2E4feFmDP5XIxbCsyJKLEblhHE4NQgnRJ5eh8em9fPx1VMiH
	rX8G3LKCthIGXTtG6ZEfhrS1hSmnLUwsflB29+I1ZE+mLQKyMg+SjPkpD3Ev
X-Received: by 2002:a17:902:cec2:b0:2e8:6540:11b6 with SMTP id d9443c01a7336-2ed837a5e60mr27480655ad.37.1794230197581;
        Mon, 09 Nov 2026 05:16:37 -0800 (PST)
Received: from 24c857d0c3be.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed815e7416sm11221095ad.17.2026.11.09.05.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:16:36 -0800 (PST)
From: Zihan Xi <zihanx@nebusec.ai>
To: linux-can@vger.kernel.org
Cc: robin@protonic.nl,
	o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	socketcan@hartkopp.net,
	mkl@pengutronix.de,
	bst@pengutronix.de,
	lkp@intel.com,
	maxime.jayat@mobile-devices.fr,
	ecathinds@gmail.com,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net v8 1/2] can: j1939: account for timer references across rearm
Date: Mon,  9 Nov 2026 13:16:23 +0000
Message-ID: <20261109131624.276943-2-zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109131624.276943-1-zihanx@nebusec.ai>
References: <20261109131624.276943-1-zihanx@nebusec.ai>
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

Rearming a session timer updates the existing hrtimer rather than
creating another callback. Taking a session reference for every start
can therefore leave references behind when the timer is rearmed.

Track one session reference across each timer's queued and running
lifetime. Apply the same accounting to the RX timer and synchronize
rearming and cancellation with terminal state changes. Arm the simple-TX
echo timeout only after a successful send, and keep terminal session
transitions from leaving stale timer references or changing the result.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Link: https://bugtracker.nebusec.ai/f/11143
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 net/can/j1939/j1939-priv.h |  11 +
 net/can/j1939/transport.c  | 510 +++++++++++++++++++++++++++++++------
 2 files changed, 438 insertions(+), 83 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index cf26352d1d8c..123622c82a98 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -10,6 +10,7 @@
 #define _J1939_PRIV_H_
 
 #include <linux/can/j1939.h>
+#include <linux/spinlock.h>
 #include <net/sock.h>
 
 /* Timeout to receive the abort signal over loop back. In case CAN
@@ -290,6 +291,16 @@ struct j1939_session {
 		unsigned int dpo;
 	} pkt;
 	struct hrtimer txtimer, rxtimer;
+	unsigned int txtimer_cancelers; /* block starts while a cancel waits */
+	spinlock_t txtimer_lock; /* Protects TX timer lifetime state. */
+	/* One reference pins the complete queued/running timer lifetime. */
+	bool txtimer_shutdown;
+	bool txtimer_ref;
+	spinlock_t rxtimer_lock; /* Protects RX timer lifetime state. */
+	unsigned int rxtimer_cancelers;
+	/* One reference pins the complete queued/running timer lifetime. */
+	bool rxtimer_shutdown;
+	bool rxtimer_ref;
 };
 
 struct j1939_sock {
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5e6f..c327fd9618a0 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -301,24 +301,176 @@ void j1939_session_put(struct j1939_session *session)
 	kref_put(&session->kref, __j1939_session_release);
 }
 
-static void j1939_session_txtimer_cancel(struct j1939_session *session)
+static void j1939_session_txtimer_cancel(struct j1939_session *session,
+					 bool shutdown)
 {
-	if (hrtimer_cancel(&session->txtimer))
+	bool put_ref = false;
+	int ret;
+
+	spin_lock_bh(&session->txtimer_lock);
+	session->txtimer_cancelers++;
+	if (shutdown)
+		session->txtimer_shutdown = true;
+	ret = hrtimer_try_to_cancel(&session->txtimer);
+	if (ret == 1) {
+		if (!WARN_ON_ONCE(!session->txtimer_ref)) {
+			session->txtimer_ref = false;
+			put_ref = true;
+		}
+	}
+	spin_unlock_bh(&session->txtimer_lock);
+
+	/* Never wait for a softirq callback while holding txtimer_lock. */
+	if (ret < 0) {
+		ret = hrtimer_cancel(&session->txtimer);
+		if (ret == 1) {
+			spin_lock_bh(&session->txtimer_lock);
+			if (!WARN_ON_ONCE(!session->txtimer_ref)) {
+				session->txtimer_ref = false;
+				put_ref = true;
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
+	if (put_ref)
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
+	/* Let a queued successor finish promptly after callback exit. */
+	if (ret < 0 && !session->txtimer_cancelers && session->txtimer_ref &&
+	    hrtimer_is_queued(&session->txtimer))
+		hrtimer_start(&session->txtimer, 0, HRTIMER_MODE_REL_SOFT);
+	if (ret != 1)
+		return false;
+
+	if (WARN_ON_ONCE(!session->txtimer_ref))
+		return false;
+	session->txtimer_ref = false;
+	return true;
+}
+
+static void j1939_session_txtimer_cancel_async(struct j1939_session *session)
+{
+	bool put_ref;
+
+	spin_lock_bh(&session->txtimer_lock);
+	put_ref = j1939_session_txtimer_cancel_async_locked(session);
+	spin_unlock_bh(&session->txtimer_lock);
+
+	if (put_ref)
 		j1939_session_put(session);
 }
 
 static void j1939_session_rxtimer_cancel(struct j1939_session *session)
 {
-	if (hrtimer_cancel(&session->rxtimer))
+	bool put_ref = false;
+	int ret;
+
+	spin_lock_bh(&session->rxtimer_lock);
+	session->rxtimer_cancelers++;
+	session->rxtimer_shutdown = true;
+	ret = hrtimer_try_to_cancel(&session->rxtimer);
+	if (ret == 1 && !WARN_ON_ONCE(!session->rxtimer_ref)) {
+		session->rxtimer_ref = false;
+		put_ref = true;
+	}
+	spin_unlock_bh(&session->rxtimer_lock);
+
+	/* Do not wait for the callback while holding rxtimer_lock. */
+	if (ret < 0) {
+		ret = hrtimer_cancel(&session->rxtimer);
+		if (ret == 1) {
+			spin_lock_bh(&session->rxtimer_lock);
+			if (!WARN_ON_ONCE(!session->rxtimer_ref)) {
+				session->rxtimer_ref = false;
+				put_ref = true;
+			}
+			spin_unlock_bh(&session->rxtimer_lock);
+		}
+	}
+
+	spin_lock_bh(&session->rxtimer_lock);
+	if (WARN_ON_ONCE(!session->rxtimer_cancelers))
+		session->rxtimer_cancelers = 0;
+	else
+		session->rxtimer_cancelers--;
+	spin_unlock_bh(&session->rxtimer_lock);
+
+	if (put_ref)
 		j1939_session_put(session);
 }
 
-void j1939_session_timers_cancel(struct j1939_session *session)
+static bool
+j1939_session_rxtimer_cancel_async_locked(struct j1939_session *session)
 {
-	j1939_session_txtimer_cancel(session);
+	int ret;
+
+	lockdep_assert_held(&session->rxtimer_lock);
+	session->rxtimer_shutdown = true;
+	ret = hrtimer_try_to_cancel(&session->rxtimer);
+	if (ret < 0 && !session->rxtimer_cancelers &&
+	    session->rxtimer_ref && hrtimer_is_queued(&session->rxtimer))
+		hrtimer_start(&session->rxtimer, 0, HRTIMER_MODE_REL_SOFT);
+	if (ret != 1)
+		return false;
+	if (WARN_ON_ONCE(!session->rxtimer_ref))
+		return false;
+	session->rxtimer_ref = false;
+	return true;
+}
+
+static void j1939_session_rxtimer_cancel_async(struct j1939_session *session)
+{
+	bool put_ref;
+
+	spin_lock_bh(&session->rxtimer_lock);
+	put_ref = j1939_session_rxtimer_cancel_async_locked(session);
+	spin_unlock_bh(&session->rxtimer_lock);
+
+	if (put_ref)
+		j1939_session_put(session);
+}
+
+static void
+j1939_session_shutdown_intent_locked(struct j1939_session *session)
+{
+	lockdep_assert_held(&session->priv->active_session_list_lock);
+	spin_lock(&session->rxtimer_lock);
+	session->rxtimer_shutdown = true;
+	spin_unlock(&session->rxtimer_lock);
+}
+
+static void j1939_session_timers_drain(struct j1939_session *session)
+{
+	j1939_session_txtimer_cancel(session, true);
 	j1939_session_rxtimer_cancel(session);
 }
 
+void j1939_session_timers_cancel(struct j1939_session *session)
+{
+	/* Publish terminal intent before any callback can claim a timeout. */
+	j1939_session_list_lock(session->priv);
+	j1939_session_shutdown_intent_locked(session);
+	j1939_session_list_unlock(session->priv);
+
+	j1939_session_timers_drain(session);
+}
+
 static inline bool j1939_cb_is_broadcast(const struct j1939_sk_buff_cb *skcb)
 {
 	return (!skcb->addr.dst_name && (skcb->addr.da == 0xff));
@@ -716,18 +868,68 @@ static int j1939_xtp_tx_abort(struct j1939_priv *priv,
 
 void j1939_tp_schedule_txtimer(struct j1939_session *session, int msec)
 {
-	j1939_session_get(session);
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
+	/* One pin covers an armed timer and any callback/successor overlap. */
+	if (!session->txtimer_ref) {
+		j1939_session_get(session);
+		session->txtimer_ref = true;
+	}
+
 	hrtimer_start(&session->txtimer, ms_to_ktime(msec),
 		      HRTIMER_MODE_REL_SOFT);
+	spin_unlock(&session->txtimer_lock);
+	j1939_session_list_unlock(session->priv);
 }
 
-static inline void j1939_tp_set_rxtimeout(struct j1939_session *session,
-					  int msec)
+/* active_session_list_lock protects the session state checked by callers. */
+static bool
+__j1939_tp_set_rxtimeout(struct j1939_session *session, int msec,
+			 bool abort_timeout)
 {
-	j1939_session_rxtimer_cancel(session);
-	j1939_session_get(session);
+	lockdep_assert_held(&session->priv->active_session_list_lock);
+
+	spin_lock(&session->rxtimer_lock);
+	if (session->rxtimer_shutdown || session->rxtimer_cancelers ||
+	    (session->state != J1939_SESSION_ACTIVE &&
+	     (!abort_timeout ||
+	      session->state != J1939_SESSION_WAITING_ABORT))) {
+		spin_unlock(&session->rxtimer_lock);
+		return false;
+	}
+
+	/* Reuse the pin when replacing a queued timer or rearming a callback. */
+	if (!session->rxtimer_ref) {
+		j1939_session_get(session);
+		session->rxtimer_ref = true;
+	}
 	hrtimer_start(&session->rxtimer, ms_to_ktime(msec),
 		      HRTIMER_MODE_REL_SOFT);
+	spin_unlock(&session->rxtimer_lock);
+	return true;
+}
+
+static inline bool j1939_tp_set_rxtimeout(struct j1939_session *session,
+					  int msec)
+{
+	bool armed;
+
+	j1939_session_list_lock(session->priv);
+	armed = __j1939_tp_set_rxtimeout(session, msec, false);
+	j1939_session_list_unlock(session->priv);
+
+	return armed;
 }
 
 static int j1939_session_tx_rts(struct j1939_session *session)
@@ -1055,7 +1257,6 @@ static int j1939_xtp_txnext_receiver(struct j1939_session *session)
 
 static int j1939_simple_txnext(struct j1939_session *session)
 {
-	struct j1939_priv *priv = session->priv;
 	struct sk_buff *se_skb = j1939_session_skb_get(session);
 	struct sk_buff *skb;
 	int ret;
@@ -1082,12 +1283,12 @@ static int j1939_simple_txnext(struct j1939_session *session)
 
 	can_skb_set_owner(skb, se_skb->sk);
 
-	j1939_tp_set_rxtimeout(session, J1939_SIMPLE_ECHO_TIMEOUT_MS);
-
-	ret = j1939_send_one(priv, skb);
+	ret = j1939_send_one(session->priv, skb);
 	if (ret)
 		goto out_free;
 
+	j1939_tp_set_rxtimeout(session, J1939_SIMPLE_ECHO_TIMEOUT_MS);
+
 	j1939_sk_errqueue(session, J1939_ERRQUEUE_TX_SCHED);
 	j1939_sk_queue_activate_next(session);
 
@@ -1105,6 +1306,12 @@ static bool j1939_session_deactivate_locked(struct j1939_session *session)
 	bool active = false;
 
 	lockdep_assert_held(&session->priv->active_session_list_lock);
+	spin_lock(&session->txtimer_lock);
+	session->txtimer_shutdown = true;
+	spin_unlock(&session->txtimer_lock);
+	spin_lock(&session->rxtimer_lock);
+	session->rxtimer_shutdown = true;
+	spin_unlock(&session->rxtimer_lock);
 
 	if (session->state >= J1939_SESSION_ACTIVE &&
 	    session->state < J1939_SESSION_ACTIVE_MAX) {
@@ -1126,6 +1333,10 @@ static bool j1939_session_deactivate(struct j1939_session *session)
 	j1939_session_list_lock(priv);
 	active = j1939_session_deactivate_locked(session);
 	j1939_session_list_unlock(priv);
+	if (active) {
+		j1939_session_txtimer_cancel_async(session);
+		j1939_session_rxtimer_cancel_async(session);
+	}
 
 	return active;
 }
@@ -1137,7 +1348,27 @@ j1939_session_deactivate_activate_next(struct j1939_session *session)
 		j1939_sk_queue_activate_next(session);
 }
 
-static void __j1939_session_cancel(struct j1939_session *session,
+static bool j1939_session_fail(struct j1939_session *session, int err)
+{
+	bool deactivate = false;
+
+	j1939_session_list_lock(session->priv);
+	if (session->state == J1939_SESSION_ACTIVE) {
+		session->err = err;
+		deactivate = j1939_session_deactivate_locked(session);
+	}
+	j1939_session_list_unlock(session->priv);
+
+	if (deactivate) {
+		j1939_session_txtimer_cancel_async(session);
+		j1939_session_rxtimer_cancel_async(session);
+		j1939_sk_queue_activate_next(session);
+	}
+
+	return deactivate;
+}
+
+static bool __j1939_session_cancel(struct j1939_session *session,
 				   enum j1939_xtp_abort err)
 {
 	struct j1939_priv *priv = session->priv;
@@ -1153,26 +1384,47 @@ static void __j1939_session_cancel(struct j1939_session *session,
 				   !session->transmission,
 				   err, session->skcb.addr.pgn);
 	}
-
 	if (session->sk)
 		j1939_sk_send_loop_abort(session->sk, session->err);
+
+	return true;
 }
 
-static void j1939_session_cancel(struct j1939_session *session,
+static bool j1939_session_cancel(struct j1939_session *session,
 				 enum j1939_xtp_abort err)
 {
+	bool cancelled = false, deactivate = false;
+
 	j1939_session_list_lock(session->priv);
 
 	if (session->state >= J1939_SESSION_ACTIVE &&
 	    session->state < J1939_SESSION_WAITING_ABORT) {
-		j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
-		__j1939_session_cancel(session, err);
+		cancelled = __j1939_session_cancel(session, err);
+		if (cancelled) {
+			spin_lock(&session->txtimer_lock);
+			session->txtimer_shutdown = true;
+			spin_unlock(&session->txtimer_lock);
+			if (!__j1939_tp_set_rxtimeout(session,
+						      J1939_XTP_ABORT_TIMEOUT_MS,
+						      true))
+				deactivate =
+					j1939_session_deactivate_locked(session);
+		}
 	}
 
 	j1939_session_list_unlock(session->priv);
+	if (cancelled) {
+		j1939_session_txtimer_cancel_async(session);
+		if (deactivate) {
+			j1939_session_rxtimer_cancel_async(session);
+			j1939_sk_queue_activate_next(session);
+		}
+	}
 
-	if (!session->sk)
+	if (cancelled && !session->sk)
 		j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
+
+	return cancelled;
 }
 
 static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
@@ -1180,8 +1432,21 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 	struct j1939_session *session =
 		container_of(hrtimer, struct j1939_session, txtimer);
 	struct j1939_priv *priv = session->priv;
+	bool can_rearm, shutdown, queued;
+	bool put_ref = false;
 	int ret = 0;
 
+	spin_lock_bh(&session->txtimer_lock);
+	WARN_ON_ONCE(!session->txtimer_ref);
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
@@ -1198,12 +1463,9 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 			session->tx_retry++;
 			j1939_tp_schedule_txtimer(session,
 						  10 + get_random_u32_below(16));
-		} else {
+		} else if (j1939_session_fail(session, -ENETUNREACH)) {
 			netdev_alert(priv->ndev, "%s: 0x%p: tx retry count reached\n",
 				     __func__, session);
-			session->err = -ENETUNREACH;
-			j1939_session_rxtimer_cancel(session);
-			j1939_session_deactivate_activate_next(session);
 		}
 		break;
 	case -ENETDOWN:
@@ -1221,25 +1483,60 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 		session->tx_retry = 0;
 		break;
 	default:
-		netdev_alert(priv->ndev, "%s: 0x%p: tx aborted with unknown reason: %i\n",
-			     __func__, session, ret);
 		if (session->skcb.addr.type != J1939_SIMPLE) {
-			j1939_session_cancel(session, J1939_XTP_ABORT_OTHER);
-		} else {
-			session->err = ret;
-			j1939_session_rxtimer_cancel(session);
-			j1939_session_deactivate_activate_next(session);
+			if (j1939_session_cancel(session, J1939_XTP_ABORT_OTHER))
+				netdev_alert(priv->ndev, "%s: 0x%p: tx aborted with unknown reason: %i\n",
+					     __func__, session, ret);
+		} else if (j1939_session_fail(session, ret)) {
+			netdev_alert(priv->ndev, "%s: 0x%p: tx aborted with unknown reason: %i\n",
+				     __func__, session, ret);
 		}
 	}
 
-	j1939_session_put(session);
+txtimer_done:
+	j1939_session_list_lock(priv);
+	can_rearm = session->state == J1939_SESSION_ACTIVE;
+	j1939_session_list_unlock(priv);
+	spin_lock_bh(&session->txtimer_lock);
+	queued = hrtimer_is_queued(&session->txtimer);
+	if (queued && (session->txtimer_shutdown || !can_rearm) &&
+	    !session->txtimer_cancelers)
+		hrtimer_start(&session->txtimer, 0, HRTIMER_MODE_REL_SOFT);
+	if (!queued && session->txtimer_ref) {
+		session->txtimer_ref = false;
+		put_ref = true;
+	}
+	spin_unlock_bh(&session->txtimer_lock);
+
+	if (put_ref)
+		j1939_session_put(session);
 
 	return HRTIMER_NORESTART;
 }
 
+static bool
+j1939_session_complete_locked(struct j1939_session *session)
+{
+	lockdep_assert_held(&session->priv->active_session_list_lock);
+	if (session->state != J1939_SESSION_ACTIVE)
+		return false;
+
+	j1939_session_shutdown_intent_locked(session);
+	return j1939_session_deactivate_locked(session);
+}
+
 static void j1939_session_completed(struct j1939_session *session)
 {
 	struct sk_buff *se_skb;
+	bool completed;
+
+	j1939_session_list_lock(session->priv);
+	completed = j1939_session_complete_locked(session);
+	j1939_session_list_unlock(session->priv);
+	if (!completed)
+		return;
+
+	j1939_session_timers_drain(session);
 
 	if (!session->transmission) {
 		se_skb = j1939_session_skb_get(session);
@@ -1248,7 +1545,7 @@ static void j1939_session_completed(struct j1939_session *session)
 		consume_skb(se_skb);
 	}
 
-	j1939_session_deactivate_activate_next(session);
+	j1939_sk_queue_activate_next(session);
 }
 
 static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
@@ -1257,41 +1554,63 @@ static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
 						     struct j1939_session,
 						     rxtimer);
 	struct j1939_priv *priv = session->priv;
+	bool cancelled = false, deactivate = false, put_ref = false, queued;
+	bool stale;
+	enum j1939_session_state state;
 
-	if (session->state == J1939_SESSION_WAITING_ABORT) {
-		netdev_alert(priv->ndev, "%s: 0x%p: abort rx timeout. Force session deactivation\n",
-			     __func__, session);
-
-		j1939_session_deactivate_activate_next(session);
-
-	} else if (session->skcb.addr.type == J1939_SIMPLE) {
-		netdev_alert(priv->ndev, "%s: 0x%p: Timeout. Failed to send simple message.\n",
-			     __func__, session);
-
-		/* The message is probably stuck in the CAN controller and can
-		 * be send as soon as CAN bus is in working state again.
-		 */
+	/* Serialize expiry handling with timeout replacement and state changes. */
+	j1939_session_list_lock(priv);
+	spin_lock(&session->rxtimer_lock);
+	/* A queued successor supersedes this already-running expiry. */
+	stale = session->rxtimer_shutdown || session->rxtimer_cancelers ||
+		hrtimer_is_queued(hrtimer);
+	spin_unlock(&session->rxtimer_lock);
+	state = session->state;
+	if (!stale && state == J1939_SESSION_WAITING_ABORT) {
+		deactivate = j1939_session_deactivate_locked(session);
+	} else if (!stale && state == J1939_SESSION_ACTIVE &&
+		   session->skcb.addr.type == J1939_SIMPLE) {
 		session->err = -ETIME;
-		j1939_session_deactivate(session);
-	} else {
-		j1939_session_list_lock(session->priv);
-		if (session->state >= J1939_SESSION_ACTIVE &&
-		    session->state < J1939_SESSION_ACTIVE_MAX) {
-			netdev_alert(priv->ndev, "%s: 0x%p: rx timeout, send abort\n",
-				     __func__, session);
-			j1939_session_get(session);
-			hrtimer_start(&session->rxtimer,
-				      ms_to_ktime(J1939_XTP_ABORT_TIMEOUT_MS),
-				      HRTIMER_MODE_REL_SOFT);
-			__j1939_session_cancel(session, J1939_XTP_ABORT_TIMEOUT);
-		}
-		j1939_session_list_unlock(session->priv);
+		deactivate = j1939_session_deactivate_locked(session);
+	} else if (!stale && state == J1939_SESSION_ACTIVE) {
+		cancelled = __j1939_session_cancel(session, J1939_XTP_ABORT_TIMEOUT);
+		if (cancelled)
+			__j1939_tp_set_rxtimeout(session,
+						 J1939_XTP_ABORT_TIMEOUT_MS, true);
+	}
+	j1939_session_list_unlock(priv);
 
+	if (deactivate) {
+		if (state == J1939_SESSION_WAITING_ABORT)
+			netdev_alert(priv->ndev, "%s: 0x%p: abort rx timeout. Force session deactivation\n",
+				     __func__, session);
+		else
+			netdev_alert(priv->ndev, "%s: 0x%p: Timeout. Failed to send simple message.\n",
+				     __func__, session);
+		j1939_session_txtimer_cancel_async(session);
+		j1939_session_rxtimer_cancel_async(session);
+		j1939_sk_queue_activate_next(session);
+	}
+	if (cancelled) {
+		netdev_alert(priv->ndev, "%s: 0x%p: rx timeout, send abort\n",
+			     __func__, session);
+		j1939_session_txtimer_cancel_async(session);
 		if (!session->sk)
 			j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
 	}
 
-	j1939_session_put(session);
+	spin_lock_bh(&session->rxtimer_lock);
+	queued = hrtimer_is_queued(&session->rxtimer);
+	if (queued && session->rxtimer_shutdown &&
+	    !session->rxtimer_cancelers)
+		hrtimer_start(&session->rxtimer, 0, HRTIMER_MODE_REL_SOFT);
+	if (!queued && session->rxtimer_ref) {
+		session->rxtimer_ref = false;
+		put_ref = true;
+	}
+	spin_unlock_bh(&session->rxtimer_lock);
+	if (put_ref)
+		j1939_session_put(session);
 
 	return HRTIMER_NORESTART;
 }
@@ -1357,6 +1676,7 @@ static void j1939_xtp_rx_abort_one(struct j1939_priv *priv, struct sk_buff *skb,
 {
 	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
 	struct j1939_session *session;
+	bool deactivate = false, report = false, rxtimer_shutdown;
 	u8 abort = skb->data[1];
 
 	session = j1939_session_get_by_addr(priv, &skcb->addr, reverse,
@@ -1371,13 +1691,35 @@ static void j1939_xtp_rx_abort_one(struct j1939_priv *priv, struct sk_buff *skb,
 		    session, j1939_xtp_ctl_to_pgn(skb->data), abort,
 		    j1939_xtp_abort_to_str(abort));
 
+	/* Report the peer abort here only if it wins the state transition. */
+	j1939_session_list_lock(priv);
+	spin_lock(&session->rxtimer_lock);
+	rxtimer_shutdown = session->rxtimer_shutdown;
+	spin_unlock(&session->rxtimer_lock);
+	if (!rxtimer_shutdown && session->state == J1939_SESSION_ACTIVE) {
+		session->err = j1939_xtp_abort_to_errno(priv, abort);
+		deactivate = j1939_session_deactivate_locked(session);
+		report = deactivate;
+	} else if (!rxtimer_shutdown &&
+		   session->state == J1939_SESSION_WAITING_ABORT) {
+		/* Preserve the local abort error instead of replacing it with the peer
+		 * response. The stored error may still be reported when the session
+		 * is destroyed.
+		 */
+		deactivate = j1939_session_deactivate_locked(session);
+	}
+	j1939_session_list_unlock(priv);
+	if (!deactivate)
+		goto abort_put;
+
 	j1939_session_timers_cancel(session);
-	session->err = j1939_xtp_abort_to_errno(priv, abort);
-	if (session->sk)
-		j1939_sk_send_loop_abort(session->sk, session->err);
-	else
-		j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
-	j1939_session_deactivate_activate_next(session);
+	if (report) {
+		if (session->sk)
+			j1939_sk_send_loop_abort(session->sk, session->err);
+		else
+			j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
+	}
+	j1939_sk_queue_activate_next(session);
 
 abort_put:
 	j1939_session_put(session);
@@ -1419,7 +1761,6 @@ j1939_xtp_rx_eoma_one(struct j1939_session *session, struct sk_buff *skb)
 	netdev_dbg(session->priv->ndev, "%s: 0x%p\n", __func__, session);
 
 	session->pkt.tx_acked = session->pkt.total;
-	j1939_session_timers_cancel(session);
 	/* transmitted without problems */
 	j1939_session_completed(session);
 }
@@ -1486,7 +1827,7 @@ j1939_xtp_rx_cts_one(struct j1939_session *session, struct sk_buff *skb)
 			if (session->pkt.tx_acked)
 				j1939_sk_errqueue(session,
 						  J1939_ERRQUEUE_TX_SCHED);
-			j1939_session_txtimer_cancel(session);
+			j1939_session_txtimer_cancel(session, false);
 			j1939_tp_schedule_txtimer(session, 0);
 		}
 	} else {
@@ -1496,7 +1837,6 @@ j1939_xtp_rx_cts_one(struct j1939_session *session, struct sk_buff *skb)
 	return;
 
  out_session_cancel:
-	j1939_session_timers_cancel(session);
 	j1939_session_cancel(session, err);
 }
 
@@ -1540,6 +1880,8 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(&session->skcb, skcb, sizeof(session->skcb));
 
+	spin_lock_init(&session->txtimer_lock);
+	spin_lock_init(&session->rxtimer_lock);
 	hrtimer_setup(&session->txtimer, j1939_tp_txtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	hrtimer_setup(&session->rxtimer, j1939_tp_rxtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 
@@ -1717,7 +2059,6 @@ static int j1939_xtp_rx_rts_session_active(struct j1939_session *session,
 			return -EBUSY;
 
 		/* RTS on active session */
-		j1939_session_timers_cancel(session);
 		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
 	}
 
@@ -1727,16 +2068,11 @@ static int j1939_xtp_rx_rts_session_active(struct j1939_session *session,
 			     __func__, session, skcb->addr.sa, skcb->addr.da,
 			     session->last_cmd);
 
-		j1939_session_timers_cancel(session);
 		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
 		if (session->transmission) {
 			j1939_session_deactivate_activate_next(session);
 		} else if (session->state == J1939_SESSION_WAITING_ABORT) {
-			/* Force deactivation for the receiver.
-			 * If we rely on the timer starting in j1939_session_cancel,
-			 * a second RTS call here will cancel that timer and fail
-			 * to restart it because the state is already WAITING_ABORT.
-			 */
+			/* The receiver cannot keep waiting after a duplicate RTS. */
 			j1939_session_deactivate_activate_next(session);
 		}
 
@@ -1810,7 +2146,7 @@ static void j1939_xtp_rx_rts(struct j1939_priv *priv, struct sk_buff *skb,
 			j1939_tp_set_rxtimeout(session, 750);
 	} else {
 		if (!session->transmission) {
-			j1939_session_txtimer_cancel(session);
+			j1939_session_txtimer_cancel(session, false);
 			j1939_tp_schedule_txtimer(session, 0);
 		}
 		j1939_tp_set_rxtimeout(session, 1250);
@@ -1956,7 +2292,6 @@ static void j1939_xtp_rx_dat_one(struct j1939_session *session,
 	}
 
 	if (final) {
-		j1939_session_timers_cancel(session);
 		j1939_session_completed(session);
 	} else if (remain) {
 		if (!session->transmission)
@@ -1976,7 +2311,6 @@ static void j1939_xtp_rx_dat_one(struct j1939_session *session,
 
  out_session_cancel:
 	kfree_skb(se_skb);
-	j1939_session_timers_cancel(session);
 	j1939_session_cancel(session, abort);
 	j1939_session_put(session);
 }
@@ -2219,6 +2553,8 @@ void j1939_simple_recv(struct j1939_priv *priv, struct sk_buff *skb)
 
 	j1939_session_list_lock(priv);
 	session = j1939_session_get_simple(priv, skb);
+	if (session)
+		j1939_session_shutdown_intent_locked(session);
 	j1939_session_list_unlock(priv);
 	if (!session) {
 		netdev_warn(priv->ndev,
@@ -2227,7 +2563,7 @@ void j1939_simple_recv(struct j1939_priv *priv, struct sk_buff *skb)
 		return;
 	}
 
-	j1939_session_timers_cancel(session);
+	j1939_session_timers_drain(session);
 	j1939_session_deactivate(session);
 	j1939_session_put(session);
 }
@@ -2242,9 +2578,17 @@ int j1939_cancel_active_session(struct j1939_priv *priv, struct sock *sk)
 				 &priv->active_session_list,
 				 active_session_list_entry) {
 		if (!sk || sk == session->sk) {
-			if (hrtimer_try_to_cancel(&session->txtimer) == 1)
+			bool put_ref;
+
+			spin_lock(&session->txtimer_lock);
+			put_ref = j1939_session_txtimer_cancel_async_locked(session);
+			spin_unlock(&session->txtimer_lock);
+			if (put_ref)
 				j1939_session_put(session);
-			if (hrtimer_try_to_cancel(&session->rxtimer) == 1)
+			spin_lock(&session->rxtimer_lock);
+			put_ref = j1939_session_rxtimer_cancel_async_locked(session);
+			spin_unlock(&session->rxtimer_lock);
+			if (put_ref)
 				j1939_session_put(session);
 
 			session->err = ESHUTDOWN;
-- 
2.43.0

