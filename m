Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793683471;
	b=nkCRUMrq0fJCWyWKaypPh1Xj+7B1F339n1HL1BhPNUBRObflxDlcK++gA7NFlw3YaYT6
	 DlMGgooeY133HwYJhZoYiod5c6wGxPEZVoQVi593HI3Cy+ymUziSYGdX/3Pnkk9++2f7u
	 /Q1BTNuLMDa8uW7rKn2PtagBmbrx82++hlgBkAy7gAhxCSfeRv4eGMQNoG0wZSq103Qxt
	 r5d/LgqWg/76hlhnm87YyvbnjjQ5kba5quI1kKbzgWacyCXTTHelKU9wt0NMOlfDQVuud
	 6nzaijBSZnH3Zn9UP3fvPqaWP4JEuO+aXe+8EvbkplpOLqMLswu1WxdVcpJxxlvEjlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793683471;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9kbQFDeWRn2H5rdrNfLwmNdSfe5Z446hQPXTFfP+Vlg=;
	b=gUNFo1yonaVUb/LWswaKZk49NPOPUALUn2EJnyzM0A7l6Ugd5+b7X/jWEfVLwMQUjkN/
	 h3M1fz0TJIjAEh2NOSAGUPBppIlJlRI0OSseim1kK9I3o1WAGyITN+wt9l5LleGVB52kE
	 GoHKgVudQV1/pLaKECMYq59QakCx8Z+srlRIUm4zw+ez01ezjTBzrhsX2gm7R5k3XTbwJ
	 PtbXgS5W7jCr/H5qBfY5goexSU7GIUHWiBdTvzSHUkBeiPVUPlAXhzbVruLl9vMCdM4f8
	 yF52FJt+spt4vkgFEO29Z6PIWvxKC8Spbwwj8X7jb7er/aTWpIhlpkHgwQDop/KdvCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b="EoVuvS+/";
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE78606A324
	for <linux-can@vger.kernel.org>; Tue,  3 Nov 2026 05:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EE78606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=EoVuvS+/
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e9d7791b00so29758195ad.0
        for <linux-can@vger.kernel.org>; Mon, 02 Nov 2026 21:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1793683470; x=1794288270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9kbQFDeWRn2H5rdrNfLwmNdSfe5Z446hQPXTFfP+Vlg=;
        b=EoVuvS+/fP0ItWSCg/v+LIRJSxPfxTS5/ZDpyO1Mx3Durh9fsRKHHY3bAiK8Bx6Tvr
         LiWetu/1dZ38eRMo/+X4DaxaO+jibhUm+PGAuDcAdjo5ttMEkmlo1PyptcaLSBKME8Kq
         f4CYaSFGzNvnL7VvrmiLZ69NKn62gdtMM8Gfzi6vzvucBGcmnM8LDQFnPi1eoVPdPgkm
         N9wb820vsH3ggYIcSTYyFnjAT91KiLlmL0PiBrS/fFrf5tLXfkyHDalfvWkWuJwHuMtP
         L9LAqO5XfhuLZHPMMMHmGKiI1YddT6gssfdpnFdBbgXSPQ/1EpvGKhvzFiM0yHl/Ne2r
         UF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793683470; x=1794288270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9kbQFDeWRn2H5rdrNfLwmNdSfe5Z446hQPXTFfP+Vlg=;
        b=J0KBdd1GPLWKYR2srvn90fr1mPp+PPTuP74LBPPdkfrQELS3XKMweGSIJb7sTO5AUh
         3OfJ0kbdpgOnOKt2Lptdm7llQtyi6NgA6wOhzVmM107lpNcCkayiBjNae/EWUBv07AdD
         yTfJFNZJGydluukJs5AQYrCEaDeWJ3GzqK6Ja/ZEO4BvHtigoaQTonGZ47ZvY5GAzZtD
         dg34DXf7tpMGfaudKSmMVV2IPCWKjUkrUcVXXfidr6KPHnuGYinDokf1X7lL4OnFU8to
         OmqElIRxo6ORxRVoMZ0yHTpg3MdpqWppS92idHkNOVJRub72gX0t65ZSqvLVAHGsJ4r5
         PhwQ==
X-Gm-Message-State: APuU4Z8mYOO3ioWZTh124n0eBNXGgi1EwCKF4hlyFFayDIExaJvps8C/
	1TYprXLyKpOGhnRMAwaPCyzOmozghp6G1daTMstxJqP8QmVKwmLtZXnpSoSS02bO84IhqJWeIaE
	2FUiuqn5F
X-Gm-Gg: AYBFou0FmSm89KvTdAorPA/BJURqFy2xK/KsM7hfQdybMbD27kIWPxMkuKOCIeaPGAr
	jeg2nkyZf4VSiEId0eQ24PGT07+s6EFNiUBFIqC7lnJ8BTWQT7QnEqJPQaYKxuXvxjb/YtohYxF
	KvqKOFq18raw3ZFvtt7bfkqLGuNitORa4GS4TfIih2MzqoBFM6Unq3tNQHPCg37xOBvIjZ+mpSx
	k0JrhqQFLUS+mrpNZYwENO9R5Z/Tiff7DHfl4u6C1corUlZAzl9XVdUaK37dnZbEFvKvIGzhS+J
	v8whovYL3R7y+re00AsIn68qml7Yrxd3Dj1F6lNpplHr25c7xRmVF/cuuVPYdhI4uUvdt+SqW/a
	mnV6D3uy+gTR8EbM7r5wBe1EFdLi9dz56vNwgu6PFIHxo49OEW/UpaNjQyqXKpUEPGMYryPm+Ga
	CF+DbJzZ9mA4KB2mVp1LdBH/W7TezkMtfzWhsImkqg9NTjqbzfLy5ZH5ANoTYNQFmaEoxXF4Slm
	FCYXVHPhrhNqEi248cvfRmSVbqFf4JplB1b25bLETJ+shfSKaXqsMit/tAoI2EtlQb9Gqe3RYeA
	v6uxf5t3hwuMClJouBocddXk4Yqvr6xuLW7p+TTtvkW8azHG4VHFebVppP2/
X-Received: by 2002:a17:903:4410:b0:2e8:4f03:dbce with SMTP id d9443c01a7336-2eb364e0848mr113585465ad.51.1793683469912;
        Mon, 02 Nov 2026 21:24:29 -0800 (PST)
Received: from 24c857d0c3be.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb77df90casm9943245ad.0.2026.11.02.21.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 21:24:29 -0800 (PST)
From: Zihan Xi <zihanx@nebusec.ai>
To: linux-can@vger.kernel.org
Cc: robin@protonic.nl,
	o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	socketcan@hartkopp.net,
	mkl@pengutronix.de,
	ecathinds@gmail.com,
	bst@pengutronix.de,
	lkp@intel.com,
	maxime.jayat@mobile-devices.fr,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net v5 1/3] can: j1939: fix TX timer reference accounting
Date: Tue,  3 Nov 2026 05:24:13 +0000
Message-ID: <fe402cff5706b3162d4e8aec02cc62dd7fa0b303.1793681851.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1793681851.git.zihanx@nebusec.ai>
References: <cover.1793681851.git.zihanx@nebusec.ai>
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

Keep one session reference across the complete queued and running lifetime
of the TX timer. Re-arming an active timer reuses this pin; cancellation
or callback completion drops it only after no successor remains queued.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Link: https://bugtracker.nebusec.ai/f/11143
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 net/can/j1939/j1939-priv.h |   6 ++
 net/can/j1939/transport.c  | 152 +++++++++++++++++++++++++++++++++++--
 2 files changed, 150 insertions(+), 8 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index cf26352d1d8c..c95fca38b8b1 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -10,6 +10,7 @@
 #define _J1939_PRIV_H_
 
 #include <linux/can/j1939.h>
+#include <linux/spinlock.h>
 #include <net/sock.h>
 
 /* Timeout to receive the abort signal over loop back. In case CAN
@@ -290,6 +291,11 @@ struct j1939_session {
 		unsigned int dpo;
 	} pkt;
 	struct hrtimer txtimer, rxtimer;
+	unsigned int txtimer_cancelers; /* block starts while a cancel waits */
+	spinlock_t txtimer_lock;
+	/* One reference pins the complete queued/running timer lifetime. */
+	bool txtimer_shutdown;
+	bool txtimer_ref;
 };
 
 struct j1939_sock {
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5e6f..4958f7c47ca4 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -301,9 +301,78 @@ void j1939_session_put(struct j1939_session *session)
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
+	if (ret < 0 && session->txtimer_ref &&
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
 
@@ -315,7 +384,7 @@ static void j1939_session_rxtimer_cancel(struct j1939_session *session)
 
 void j1939_session_timers_cancel(struct j1939_session *session)
 {
-	j1939_session_txtimer_cancel(session);
+	j1939_session_txtimer_cancel(session, true);
 	j1939_session_rxtimer_cancel(session);
 }
 
@@ -716,9 +785,29 @@ static int j1939_xtp_tx_abort(struct j1939_priv *priv,
 
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
 
 static inline void j1939_tp_set_rxtimeout(struct j1939_session *session,
@@ -1105,6 +1194,9 @@ static bool j1939_session_deactivate_locked(struct j1939_session *session)
 	bool active = false;
 
 	lockdep_assert_held(&session->priv->active_session_list_lock);
+	spin_lock(&session->txtimer_lock);
+	session->txtimer_shutdown = true;
+	spin_unlock(&session->txtimer_lock);
 
 	if (session->state >= J1939_SESSION_ACTIVE &&
 	    session->state < J1939_SESSION_ACTIVE_MAX) {
@@ -1126,6 +1218,8 @@ static bool j1939_session_deactivate(struct j1939_session *session)
 	j1939_session_list_lock(priv);
 	active = j1939_session_deactivate_locked(session);
 	j1939_session_list_unlock(priv);
+	if (active)
+		j1939_session_txtimer_cancel_async(session);
 
 	return active;
 }
@@ -1161,15 +1255,23 @@ static void __j1939_session_cancel(struct j1939_session *session,
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
@@ -1180,8 +1282,21 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
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
@@ -1232,7 +1347,22 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 		}
 	}
 
-	j1939_session_put(session);
+txtimer_done:
+	j1939_session_list_lock(priv);
+	can_rearm = session->state == J1939_SESSION_ACTIVE;
+	j1939_session_list_unlock(priv);
+	spin_lock_bh(&session->txtimer_lock);
+	queued = hrtimer_is_queued(&session->txtimer);
+	if (queued && (session->txtimer_shutdown || !can_rearm))
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
@@ -1486,7 +1616,7 @@ j1939_xtp_rx_cts_one(struct j1939_session *session, struct sk_buff *skb)
 			if (session->pkt.tx_acked)
 				j1939_sk_errqueue(session,
 						  J1939_ERRQUEUE_TX_SCHED);
-			j1939_session_txtimer_cancel(session);
+			j1939_session_txtimer_cancel(session, false);
 			j1939_tp_schedule_txtimer(session, 0);
 		}
 	} else {
@@ -1540,6 +1670,7 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(&session->skcb, skcb, sizeof(session->skcb));
 
+	spin_lock_init(&session->txtimer_lock);
 	hrtimer_setup(&session->txtimer, j1939_tp_txtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	hrtimer_setup(&session->rxtimer, j1939_tp_rxtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 
@@ -1810,7 +1941,7 @@ static void j1939_xtp_rx_rts(struct j1939_priv *priv, struct sk_buff *skb,
 			j1939_tp_set_rxtimeout(session, 750);
 	} else {
 		if (!session->transmission) {
-			j1939_session_txtimer_cancel(session);
+			j1939_session_txtimer_cancel(session, false);
 			j1939_tp_schedule_txtimer(session, 0);
 		}
 		j1939_tp_set_rxtimeout(session, 1250);
@@ -2242,7 +2373,12 @@ int j1939_cancel_active_session(struct j1939_priv *priv, struct sock *sk)
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
 			if (hrtimer_try_to_cancel(&session->rxtimer) == 1)
 				j1939_session_put(session);
-- 
2.43.0

