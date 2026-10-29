Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263492;
	b=ubIuaMhbhhX3c9LyScGYqSNKzgBS5PftPG4c7gRBHVWa0K/s3v7MVo9JFWR1dY5AiqeQ
	 X16vPDi1iq/tTXdKtOjB1gkmQ9uv6Bu6MgjmMiRfJStZXxqNFr49cuI73RJ/yS0I6dEPH
	 KZjvt3Kt+yMvpy8Rs+rGB/+n7KHy+7IYDE3cy5wnVSwfaSHsmeJP8RbM9Z3Wc+CClYojY
	 IMUSoNoPXG33jh4tfvxkuFFqKrpvjgXsG/joDHLac+Z/3G/DpghyqOGCe3BIPaAc345wY
	 rdT3HfcBDV8H1KmT6/n2OsbHjfOvEn/mZ2hsFe3szMrvV44szIQ/vQzRu4msivt3ymw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263492;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ETBgvYez+xmzhs9chX10X5l78Nseo8O1T8fI4QjiZZA=;
	b=bxUmBqygKls9k794qKhIhnzwhJ2ApAvwi9CQ7Jsi+Tp/hySWpfTtpgAvQ3tukzvV2uzO
	 rMJMN+2qwbbuG3qajQrZi3j1vo2xQuNEAZ4L0T9vRvVGjHhJABUua0eohMIjBZDaI4sDS
	 SBaWmDhFH/b85VphiNUq110rGS5MfqW2UR+vG75QZRebBPj0S9705UvfMY2pFdY92E30R
	 Kdn0IChHZRYxLtbUNZtwnacOOXz21DkHlJzTnHhXmxhdpaTop1rffepI4CRePfS1mnSOq
	 19f3o1TrF1IhDRu1i45VKNBRC6vlNxDs56ZgkO9j9k6JejzfKVcnEKwQw528aNEzsYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=IjIgZXGo;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47004606A31E
	for <linux-can@vger.kernel.org>; Thu, 29 Oct 2026 08:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47004606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=IjIgZXGo
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a594d313a3so1227545b3a.1
        for <linux-can@vger.kernel.org>; Thu, 29 Oct 2026 01:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1793263491; x=1793868291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ETBgvYez+xmzhs9chX10X5l78Nseo8O1T8fI4QjiZZA=;
        b=IjIgZXGojvW39NaMUCcxOhwxesAjXZay60TnDR90GM5BBWj6b39BLC89h0nPBkaCJA
         JlagnEXjQQdds5qe1/ocZTSujnfbU5k4HqnabM41fZLtcbnxripHNhIYUvSREs51jVXy
         QgZgzLo0Usuy4EZNHLJYS+mzsqSWEQ4pmYiwV5R7ejVP4hcTHmXCNC5/YZDdZkxmbxPZ
         Wr0Rx2YFi1X8x5rU/Odka+Gy+tMq6xfvpWl5bEyQBNwR6YZ0x8wrjDsBXV+ycB5W1v31
         c87AQhO1lN2l2T8OnQ7RDnxf9qzJm3OGI9fBP0Wp+N6DDpB6q56fgkPczYymaFh7Wm0i
         Mr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793263491; x=1793868291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ETBgvYez+xmzhs9chX10X5l78Nseo8O1T8fI4QjiZZA=;
        b=WhKn+3EJ7/ZPPfctDZfnU7oCTBSc7N/bj6qNNQXuRtOjvglcAMk2beQA5pb1uYiGs1
         zs7nLwvzp1o5050JBtuXBOGy0GOSeJHuxTQ4YZ/QBjv8KDsGaVpRG3mcFV/hkdxW4R/O
         qcz4YUJmiuFFw651rUEGSsbJRs2RxjmN9lb2fKm396OusW2tOOMVprzSnPKP9UDYIQXA
         y5rZPISgAU1yYNV4c5d30QnaZFFfz71YL843pMY7ccp6jUiJnQlNgaCEHxZmwoJlim/Z
         B6jv1RQVFXleDVK40pLroC5vF1HQY1u/DEOM2Y6rYm5UNel+Lvikmg7+IebqL4dplsvJ
         DXkg==
X-Gm-Message-State: AFq9FYKuuYBKJOa/Y+bkizqCxc4CGI1eEkFCHPgsVU1qWK9SmxIyTE4x
	8gi0cOD98xO5a04XL+AAPCHKiahUsbBfqHpxfGSJtnSn5ApG11t4m/7cjqsMhEgSsWPE/PzoyQb
	y2UQsbf6Y
X-Gm-Gg: AYBFou3QhKNTfc5oDsIfiRgo8f3rT/Enl2WgBKmjmH4LV4upfctGb5iTDf2+qofTV4L
	wIrpvn4TI73x9DrxzJhsfp0HNAyZ/itIbwuKXKv1ov/OrjQhQfa/c+87tXcLO49g8b0BgXlB1wK
	W18rwEAHrQLe3nbXX2seuOUA80oqrdAl2KS29h/9GZWE3MgS3x2kIkx3EN63sJW1ZVc7/wpEmUT
	wUfKKtjFlewpCcKsuhUadqWpa/PuR9FtAY6ZEQzT2MZLC0zVZdFoZzOJbbp7hC6rYHp6P2mf/b0
	rUv/b6h4nGmzVXjL8kk1hVNmt/NnRSM54JrgKkcf6d0z69cMyM7zPusdV3y2YUKwINyabGh0iTW
	IRDS0tSLJ90u6jBeWyCxcyg11wEfMVB6ijUwzCysEHCALUm5TkNFhl3sFC6QCVHkyOKWpawVuyj
	w2r/Fm6cXKMphOYzqSgz++vU0vTnDQkkSFZ81DBpc9PudhuOE+rI0GvKaSlJlQnZOK+5V/KbZtg
	rldZyS2mi6LHIJeLfQib8O+AOzj1k2d6PBPeOQURgevmyUgQJlfQvcq9D49X3i9OohvFTLpFGwR
	MC3doujRczeM2OwRuHy/tjTI8xlMGZuCBdBnq4hYPKD6BoN+XwUzUytCYFhD
X-Received: by 2002:a05:6a00:3918:b0:8a0:3483:51ec with SMTP id d2e1a72fcca58-8a6e879343bmr4341512b3a.58.1793263490358;
        Thu, 29 Oct 2026 01:44:50 -0700 (PDT)
Received: from 24c857d0c3be.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdad33b99b2sm3083915a12.26.2026.10.29.01.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 01:44:49 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: linux-can@vger.kernel.org,
	llvm@lists.linux.dev
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
	zihanx@nebusec.ai
Subject: [PATCH net v3 1/3] can: j1939: fix session reference leaks on timer rearm
Date: Thu, 29 Oct 2026 08:43:24 +0000
Message-ID: <21bf54f2fbab33155e924e0743f17b1e47655255.1793259424.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1793259424.git.zihanx@nebusec.ai>
References: <cover.1793259424.git.zihanx@nebusec.ai>
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

Track queued timer and running callback references separately so rearming
cannot leak session references or race timer cancellation.

Drain terminal TX and RX timers without waiting under their state locks,
and gate RX timeout rearming against concurrent drains.

Move next-session timer scheduling outside the socket queue lock to avoid
lock ordering problems.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Link: https://bugtracker.nebusec.ai/f/11143
Link: https://lore.kernel.org/all/cover.1793012287.git.zihanx@nebusec.ai/
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 net/can/j1939/j1939-priv.h |  23 ++-
 net/can/j1939/socket.c     |  59 +++---
 net/can/j1939/transport.c  | 414 ++++++++++++++++++++++++++++++++-----
 3 files changed, 423 insertions(+), 73 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index cf26352d1d8c..c0a4c1478240 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -10,6 +10,7 @@
 #define _J1939_PRIV_H_
 
 #include <linux/can/j1939.h>
+#include <linux/spinlock.h>
 #include <net/sock.h>
 
 /* Timeout to receive the abort signal over loop back. In case CAN
@@ -237,7 +238,6 @@ struct j1939_session {
 	struct list_head sk_session_queue_entry;
 	struct kref kref;
 	struct sock *sk;
-
 	/* ifindex, src, dst, pgn define the session block
 	 * the are _never_ modified after insertion in the list
 	 * this decreases locking problems a _lot_
@@ -289,7 +289,26 @@ struct j1939_session {
 		/* dpo - ETP.CM_DPO, Data Packet Offset */
 		unsigned int dpo;
 	} pkt;
-	struct hrtimer txtimer, rxtimer;
+	/*
+	 * qref pins the queued timer; cbref pins a running callback. A
+	 * concurrent rearm can leave both references outstanding.
+	 */
+	/* Protects TX timer rearming and cancellation. */
+	spinlock_t txtimer_lock;
+	struct hrtimer txtimer;
+	bool txtimer_qref;
+	bool txtimer_cbref;
+	bool txtimer_cb_running;
+	bool txtimer_shutdown;
+	/* RX timer state and refs below use active_session_list_lock. */
+	struct hrtimer rxtimer;
+	bool rxtimer_qref;
+	bool rxtimer_cbref;
+	bool rxtimer_cb_running;
+	/* Temporary drains defer rearming; the last drain installs the pending timeout. */
+	unsigned int rxtimer_cancelers;
+	bool rxtimer_pending;
+	int rxtimer_pending_timeout;
 };
 
 struct j1939_sock {
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 50a598ef5fd4..153b34ea523a 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -147,7 +147,9 @@ static void j1939_sk_queue_drop_all(struct j1939_priv *priv,
 	spin_unlock_bh(&jsk->sk_session_queue_lock);
 }
 
-static void j1939_sk_queue_activate_next_locked(struct j1939_session *session)
+static struct j1939_session *
+j1939_sk_queue_activate_next_locked(struct j1939_session *session,
+				    int *txtimer_delay)
 {
 	struct j1939_sock *jsk;
 	struct j1939_session *first;
@@ -155,7 +157,7 @@ static void j1939_sk_queue_activate_next_locked(struct j1939_session *session)
 
 	/* RX-Session don't have a socket (yet) */
 	if (!session->sk)
-		return;
+		return NULL;
 
 	jsk = j1939_sk(session->sk);
 	lockdep_assert_held(&jsk->sk_session_queue_lock);
@@ -168,37 +170,39 @@ static void j1939_sk_queue_activate_next_locked(struct j1939_session *session)
 
 	/* Some else has already activated the next session */
 	if (first != session)
-		return;
+		return NULL;
 
-activate_next:
-	list_del_init(&first->sk_session_queue_entry);
-	j1939_session_put(first);
-	first = list_first_entry_or_null(&jsk->sk_session_queue,
-					 struct j1939_session,
-					 sk_session_queue_entry);
-	if (!first)
-		return;
+	while (first) {
+		list_del_init(&first->sk_session_queue_entry);
+		j1939_session_put(first);
+		first = list_first_entry_or_null(&jsk->sk_session_queue,
+						 struct j1939_session,
+						 sk_session_queue_entry);
+		if (!first)
+			return NULL;
+
+		if (j1939_session_activate(first)) {
+			netdev_warn_once(first->priv->ndev,
+					 "%s: 0x%p: Identical session is already activated.\n",
+					 __func__, first);
+			first->err = -EBUSY;
+			continue;
+		}
 
-	if (j1939_session_activate(first)) {
-		netdev_warn_once(first->priv->ndev,
-				 "%s: 0x%p: Identical session is already activated.\n",
-				 __func__, first);
-		first->err = -EBUSY;
-		goto activate_next;
-	} else {
 		/* Give receiver some time (arbitrary chosen) to recover */
-		int time_ms = 0;
-
-		if (err)
-			time_ms = 10 + get_random_u32_below(16);
-
-		j1939_tp_schedule_txtimer(first, time_ms);
+		*txtimer_delay = err ? 10 + get_random_u32_below(16) : 0;
+		j1939_session_get(first);
+		return first;
 	}
+
+	return NULL;
 }
 
 void j1939_sk_queue_activate_next(struct j1939_session *session)
 {
+	struct j1939_session *next;
 	struct j1939_sock *jsk;
+	int txtimer_delay;
 
 	if (!session->sk)
 		return;
@@ -206,8 +210,13 @@ void j1939_sk_queue_activate_next(struct j1939_session *session)
 	jsk = j1939_sk(session->sk);
 
 	spin_lock_bh(&jsk->sk_session_queue_lock);
-	j1939_sk_queue_activate_next_locked(session);
+	next = j1939_sk_queue_activate_next_locked(session, &txtimer_delay);
 	spin_unlock_bh(&jsk->sk_session_queue_lock);
+
+	if (next) {
+		j1939_tp_schedule_txtimer(next, txtimer_delay);
+		j1939_session_put(next);
+	}
 }
 
 static bool j1939_sk_match_dst(struct j1939_sock *jsk,
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5e6f..0dd08d1b8f75 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -9,6 +9,7 @@
 //                         Oleksij Rempel <kernel@pengutronix.de>
 
 #include <linux/can/skb.h>
+#include <linux/cleanup.h>
 #include <net/can.h>
 
 #include "j1939-priv.h"
@@ -301,22 +302,139 @@ void j1939_session_put(struct j1939_session *session)
 	kref_put(&session->kref, __j1939_session_release);
 }
 
+static void j1939_session_txtimer_cancel_async(struct j1939_session *session)
+{
+	bool put_qref = false;
+	int ret;
+
+	spin_lock_bh(&session->txtimer_lock);
+	session->txtimer_shutdown = true;
+	ret = hrtimer_try_to_cancel(&session->txtimer);
+	if (ret == 1) {
+		WARN_ON_ONCE(!session->txtimer_qref);
+		session->txtimer_qref = false;
+		put_qref = true;
+	}
+	spin_unlock_bh(&session->txtimer_lock);
+
+	if (put_qref)
+		j1939_session_put(session);
+}
+
 static void j1939_session_txtimer_cancel(struct j1939_session *session)
 {
-	if (hrtimer_cancel(&session->txtimer))
+	struct hrtimer *timer;
+	bool put_qref = false;
+	int ret;
+
+	spin_lock_bh(&session->txtimer_lock);
+	session->txtimer_shutdown = true;
+	timer = &session->txtimer;
+	/* Keep this alias across unlock; blocking cancel must run outside the lock. */
+	ret = hrtimer_try_to_cancel(timer);
+	if (ret == 1) {
+		WARN_ON_ONCE(!session->txtimer_qref);
+		session->txtimer_qref = false;
+		put_qref = true;
+	}
+	spin_unlock_bh(&session->txtimer_lock);
+
+	if (ret < 0) {
+		/* Keep the blocking cancel outside txtimer_lock. */
+		ret = hrtimer_cancel(timer);
+		if (ret == 1) {
+			spin_lock_bh(&session->txtimer_lock);
+			WARN_ON_ONCE(!session->txtimer_qref);
+			session->txtimer_qref = false;
+			put_qref = true;
+			spin_unlock_bh(&session->txtimer_lock);
+		}
+	}
+
+	if (put_qref)
 		j1939_session_put(session);
 }
 
+/* Cancel a queued RX timer without waiting; caller may be in softirq context. */
 static void j1939_session_rxtimer_cancel(struct j1939_session *session)
 {
-	if (hrtimer_cancel(&session->rxtimer))
+	bool put_qref = false;
+	int ret;
+
+	j1939_session_list_lock(session->priv);
+	ret = hrtimer_try_to_cancel(&session->rxtimer);
+	if (ret == 1) {
+		WARN_ON_ONCE(!session->rxtimer_qref);
+		session->rxtimer_qref = false;
+		put_qref = true;
+	}
+	j1939_session_list_unlock(session->priv);
+
+	if (put_qref)
+		j1939_session_put(session);
+}
+
+/* Drain RX timer outside the list lock; temporary drains gate all rearming. */
+static void j1939_tp_set_rxtimeout_locked(struct j1939_session *session,
+					  int msec);
+
+static void j1939_session_rxtimer_cancel_sync(struct j1939_session *session,
+					      bool temporary)
+{
+	struct hrtimer *timer;
+	bool put_qref = false;
+	int ret;
+
+	j1939_session_list_lock(session->priv);
+	if (temporary)
+		session->rxtimer_cancelers++;
+	timer = &session->rxtimer;
+	ret = hrtimer_try_to_cancel(timer);
+	if (ret == 1) {
+		WARN_ON_ONCE(!session->rxtimer_qref);
+		session->rxtimer_qref = false;
+		put_qref = true;
+	}
+	j1939_session_list_unlock(session->priv);
+
+	if (ret < 0) {
+		ret = hrtimer_cancel(timer);
+		if (ret == 1) {
+			j1939_session_list_lock(session->priv);
+			WARN_ON_ONCE(!session->rxtimer_qref);
+			session->rxtimer_qref = false;
+			put_qref = true;
+			j1939_session_list_unlock(session->priv);
+		}
+	}
+
+	if (temporary) {
+		j1939_session_list_lock(session->priv);
+		if (WARN_ON_ONCE(!session->rxtimer_cancelers)) {
+			session->rxtimer_cancelers = 0;
+		} else {
+			session->rxtimer_cancelers--;
+			if (!session->rxtimer_cancelers &&
+			    session->rxtimer_pending) {
+				int pending_timeout =
+					session->rxtimer_pending_timeout;
+
+				session->rxtimer_pending = false;
+				j1939_tp_set_rxtimeout_locked(session,
+							      pending_timeout);
+			}
+		}
+		j1939_session_list_unlock(session->priv);
+	}
+
+	if (put_qref)
 		j1939_session_put(session);
 }
 
 void j1939_session_timers_cancel(struct j1939_session *session)
 {
 	j1939_session_txtimer_cancel(session);
-	j1939_session_rxtimer_cancel(session);
+	j1939_session_rxtimer_cancel_sync(session, true);
 }
 
 static inline bool j1939_cb_is_broadcast(const struct j1939_sk_buff_cb *skcb)
@@ -714,23 +832,117 @@ static int j1939_xtp_tx_abort(struct j1939_priv *priv,
 	return j1939_xtp_do_tx_ctl(priv, re_skcb, swap_src_dst, pgn, dat);
 }
 
-void j1939_tp_schedule_txtimer(struct j1939_session *session, int msec)
+static void j1939_tp_schedule_txtimer_locked(struct j1939_session *session,
+					     int msec)
 {
-	j1939_session_get(session);
+	bool queued;
+	int ret;
+
+	lockdep_assert_held(&session->txtimer_lock);
+	if (session->txtimer_shutdown)
+		return;
+
+	/* Replace the queued pin; a running callback retains its separate pin. */
+	ret = hrtimer_try_to_cancel(&session->txtimer);
+	if (ret == 1) {
+		/* Reuse the pin owned by the removed queued timer. */
+		if (WARN_ON_ONCE(!session->txtimer_qref))
+			j1939_session_get(session);
+		session->txtimer_qref = true;
+	} else if (ret == 0) {
+		/* If the callback owns its pin, take a separate pin for the new queue. */
+		if (!session->txtimer_qref) {
+			j1939_session_get(session);
+			session->txtimer_qref = true;
+		}
+	} else {
+		/* A dispatched callback may already have requeued the timer. */
+		queued = hrtimer_is_queued(&session->txtimer);
+		if (!queued && !session->txtimer_cbref &&
+		    session->txtimer_qref) {
+			/* Claim the reference of the dispatched callback. */
+			WARN_ON_ONCE(session->txtimer_cb_running);
+			session->txtimer_qref = false;
+			session->txtimer_cbref = true;
+			session->txtimer_cb_running = true;
+		}
+		if (!session->txtimer_qref) {
+			j1939_session_get(session);
+			session->txtimer_qref = true;
+		}
+	}
+
 	hrtimer_start(&session->txtimer, ms_to_ktime(msec),
 		      HRTIMER_MODE_REL_SOFT);
 }
 
-static inline void j1939_tp_set_rxtimeout(struct j1939_session *session,
+void j1939_tp_schedule_txtimer(struct j1939_session *session, int msec)
+{
+	spin_lock_bh(&session->txtimer_lock);
+	j1939_tp_schedule_txtimer_locked(session, msec);
+	spin_unlock_bh(&session->txtimer_lock);
+}
+
+static void j1939_tp_set_rxtimeout_locked(struct j1939_session *session,
 					  int msec)
 {
-	j1939_session_rxtimer_cancel(session);
-	j1939_session_get(session);
+	bool queued;
+	int ret;
+
+	lockdep_assert_held(&session->priv->active_session_list_lock);
+	if (session->state < J1939_SESSION_ACTIVE ||
+	    session->state >= J1939_SESSION_ACTIVE_MAX) {
+		session->rxtimer_pending = false;
+		return;
+	}
+	if (session->rxtimer_cancelers) {
+		/* The last temporary drain installs the latest requested timeout. */
+		session->rxtimer_pending = true;
+		session->rxtimer_pending_timeout = msec;
+		return;
+	}
+	session->rxtimer_pending = false;
+
+	/* Reuse a removed queued pin; a running callback keeps its own pin. */
+	ret = hrtimer_try_to_cancel(&session->rxtimer);
+	if (ret == 1) {
+		if (WARN_ON_ONCE(!session->rxtimer_qref))
+			j1939_session_get(session);
+		session->rxtimer_qref = true;
+	} else if (ret == 0) {
+		if (!session->rxtimer_qref) {
+			j1939_session_get(session);
+			session->rxtimer_qref = true;
+		}
+	} else {
+		queued = hrtimer_is_queued(&session->rxtimer);
+		if (!queued && !session->rxtimer_cbref &&
+		    session->rxtimer_qref) {
+			WARN_ON_ONCE(session->rxtimer_cb_running);
+			session->rxtimer_qref = false;
+			session->rxtimer_cbref = true;
+			session->rxtimer_cb_running = true;
+		}
+		if (!session->rxtimer_qref) {
+			j1939_session_get(session);
+			session->rxtimer_qref = true;
+		}
+	}
+
 	hrtimer_start(&session->rxtimer, ms_to_ktime(msec),
 		      HRTIMER_MODE_REL_SOFT);
 }
 
-static int j1939_session_tx_rts(struct j1939_session *session)
+static inline void j1939_tp_set_rxtimeout(struct j1939_session *session,
+					  int msec)
+{
+	j1939_session_list_lock(session->priv);
+	j1939_tp_set_rxtimeout_locked(session, msec);
+	j1939_session_list_unlock(session->priv);
+}
+
+static int j1939_session_tx_rts(struct j1939_session *session,
+				unsigned int *txtimer_delay)
 {
 	u8 dat[8];
 	int ret;
@@ -766,7 +978,7 @@ static int j1939_session_tx_rts(struct j1939_session *session)
 
 	session->last_txcmd = dat[0];
 	if (dat[0] == J1939_TP_CMD_BAM) {
-		j1939_tp_schedule_txtimer(session, 50);
+		*txtimer_delay = 50;
 		j1939_tp_set_rxtimeout(session, 250);
 	} else {
 		j1939_tp_set_rxtimeout(session, 1250);
@@ -806,7 +1018,8 @@ static int j1939_session_tx_dpo(struct j1939_session *session)
 	return 0;
 }
 
-static int j1939_session_tx_dat(struct j1939_session *session)
+static int j1939_session_tx_dat(struct j1939_session *session,
+				unsigned int *txtimer_delay)
 {
 	struct j1939_priv *priv = session->priv;
 	struct j1939_sk_buff_cb *se_skcb;
@@ -870,7 +1083,7 @@ static int j1939_session_tx_dat(struct j1939_session *session)
 			j1939_tp_packet_delay;
 
 		if (session->pkt.tx < session->pkt.total && pdelay) {
-			j1939_tp_schedule_txtimer(session, pdelay);
+			*txtimer_delay = pdelay;
 			break;
 		}
 	}
@@ -887,7 +1100,8 @@ static int j1939_session_tx_dat(struct j1939_session *session)
 	return ret;
 }
 
-static int j1939_xtp_txnext_transmiter(struct j1939_session *session)
+static int j1939_xtp_txnext_transmiter(struct j1939_session *session,
+				       unsigned int *txtimer_delay)
 {
 	struct j1939_priv *priv = session->priv;
 	int ret = 0;
@@ -900,7 +1114,7 @@ static int j1939_xtp_txnext_transmiter(struct j1939_session *session)
 
 	switch (session->last_cmd) {
 	case 0:
-		ret = j1939_session_tx_rts(session);
+		ret = j1939_session_tx_rts(session, txtimer_delay);
 		break;
 
 	case J1939_ETP_CMD_CTS:
@@ -915,7 +1129,7 @@ static int j1939_xtp_txnext_transmiter(struct j1939_session *session)
 	case 0xff: /* did some data */
 	case J1939_ETP_CMD_DPO:
 	case J1939_TP_CMD_BAM:
-		ret = j1939_session_tx_dat(session);
+		ret = j1939_session_tx_dat(session, txtimer_delay);
 
 		break;
 	default:
@@ -1112,6 +1326,7 @@ static bool j1939_session_deactivate_locked(struct j1939_session *session)
 
 		list_del_init(&session->active_session_list_entry);
 		session->state = J1939_SESSION_DONE;
+		session->rxtimer_pending = false;
 		j1939_session_put(session);
 	}
 
@@ -1127,6 +1342,11 @@ static bool j1939_session_deactivate(struct j1939_session *session)
 	active = j1939_session_deactivate_locked(session);
 	j1939_session_list_unlock(priv);
 
+	if (active) {
+		j1939_session_txtimer_cancel_async(session);
+		j1939_session_rxtimer_cancel(session);
+	}
+
 	return active;
 }
 
@@ -1165,7 +1385,8 @@ static void j1939_session_cancel(struct j1939_session *session,
 
 	if (session->state >= J1939_SESSION_ACTIVE &&
 	    session->state < J1939_SESSION_WAITING_ABORT) {
-		j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
+		j1939_tp_set_rxtimeout_locked(session,
+					      J1939_XTP_ABORT_TIMEOUT_MS);
 		__j1939_session_cancel(session, err);
 	}
 
@@ -1180,13 +1401,35 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 	struct j1939_session *session =
 		container_of(hrtimer, struct j1939_session, txtimer);
 	struct j1939_priv *priv = session->priv;
+	unsigned int txtimer_delay = 0;
+	enum j1939_session_state state;
+	bool shutdown;
+	bool put_cbref = false;
 	int ret = 0;
 
+	spin_lock_bh(&session->txtimer_lock);
+	/* A concurrent rearm may already have recorded the callback pin. */
+	if (!session->txtimer_cbref) {
+		WARN_ON_ONCE(session->txtimer_cb_running);
+		WARN_ON_ONCE(!session->txtimer_qref);
+		session->txtimer_qref = false;
+		session->txtimer_cbref = true;
+	}
+	session->txtimer_cb_running = true;
+	shutdown = session->txtimer_shutdown;
+	spin_unlock_bh(&session->txtimer_lock);
+
+	j1939_session_list_lock(priv);
+	state = session->state;
+	j1939_session_list_unlock(priv);
+	if (shutdown || state != J1939_SESSION_ACTIVE)
+		goto txtimer_done;
+
 	if (session->skcb.addr.type == J1939_SIMPLE) {
 		ret = j1939_simple_txnext(session);
 	} else {
 		if (session->transmission)
-			ret = j1939_xtp_txnext_transmiter(session);
+			ret = j1939_xtp_txnext_transmiter(session, &txtimer_delay);
 		else
 			ret = j1939_xtp_txnext_receiver(session);
 	}
@@ -1196,12 +1439,15 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 		/* Retry limit is currently arbitrary chosen */
 		if (session->tx_retry < J1939_XTP_TX_RETRY_LIMIT) {
 			session->tx_retry++;
-			j1939_tp_schedule_txtimer(session,
-						  10 + get_random_u32_below(16));
+			txtimer_delay = 10 + get_random_u32_below(16);
 		} else {
 			netdev_alert(priv->ndev, "%s: 0x%p: tx retry count reached\n",
 				     __func__, session);
-			session->err = -ENETUNREACH;
+			j1939_session_list_lock(priv);
+			if (session->state >= J1939_SESSION_ACTIVE &&
+			    session->state < J1939_SESSION_ACTIVE_MAX)
+				session->err = -ENETUNREACH;
+			j1939_session_list_unlock(priv);
 			j1939_session_rxtimer_cancel(session);
 			j1939_session_deactivate_activate_next(session);
 		}
@@ -1226,13 +1472,37 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 		if (session->skcb.addr.type != J1939_SIMPLE) {
 			j1939_session_cancel(session, J1939_XTP_ABORT_OTHER);
 		} else {
-			session->err = ret;
+			j1939_session_list_lock(priv);
+			if (session->state >= J1939_SESSION_ACTIVE &&
+			    session->state < J1939_SESSION_ACTIVE_MAX)
+				session->err = ret;
+			j1939_session_list_unlock(priv);
 			j1939_session_rxtimer_cancel(session);
 			j1939_session_deactivate_activate_next(session);
 		}
 	}
 
-	j1939_session_put(session);
+txtimer_done:
+	spin_lock_bh(&session->txtimer_lock);
+	WARN_ON_ONCE(!session->txtimer_cb_running ||
+		     !session->txtimer_cbref);
+	session->txtimer_cb_running = false;
+	if (txtimer_delay && !session->txtimer_shutdown &&
+	    !session->txtimer_qref) {
+		/* Transfer the callback pin to its rearmed timer. */
+		session->txtimer_cbref = false;
+		session->txtimer_qref = true;
+		hrtimer_start(&session->txtimer, ms_to_ktime(txtimer_delay),
+			      HRTIMER_MODE_REL_SOFT);
+	} else {
+		/* An external qref, if present, owns the next firing. */
+		session->txtimer_cbref = false;
+		put_cbref = true;
+	}
+	spin_unlock_bh(&session->txtimer_lock);
+
+	if (put_cbref)
+		j1939_session_put(session);
 
 	return HRTIMER_NORESTART;
 }
@@ -1257,8 +1527,25 @@ static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
 						     struct j1939_session,
 						     rxtimer);
 	struct j1939_priv *priv = session->priv;
+	enum j1939_session_state state;
+	bool active;
+
+	j1939_session_list_lock(priv);
+	if (!session->rxtimer_cbref) {
+		WARN_ON_ONCE(session->rxtimer_cb_running);
+		WARN_ON_ONCE(!session->rxtimer_qref);
+		session->rxtimer_qref = false;
+		session->rxtimer_cbref = true;
+	}
+	session->rxtimer_cb_running = true;
+	state = session->state;
+	active = state >= J1939_SESSION_ACTIVE &&
+		state < J1939_SESSION_ACTIVE_MAX;
+	j1939_session_list_unlock(priv);
 
-	if (session->state == J1939_SESSION_WAITING_ABORT) {
+	if (!active) {
+		/* A terminal path won before this callback started its work. */
+	} else if (state == J1939_SESSION_WAITING_ABORT) {
 		netdev_alert(priv->ndev, "%s: 0x%p: abort rx timeout. Force session deactivation\n",
 			     __func__, session);
 
@@ -1271,18 +1558,24 @@ static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
 		/* The message is probably stuck in the CAN controller and can
 		 * be send as soon as CAN bus is in working state again.
 		 */
-		session->err = -ETIME;
-		j1939_session_deactivate(session);
+		j1939_session_list_lock(priv);
+		if (session->state >= J1939_SESSION_ACTIVE &&
+		    session->state < J1939_SESSION_ACTIVE_MAX) {
+			session->err = -ETIME;
+			j1939_session_deactivate_locked(session);
+		}
+		j1939_session_list_unlock(priv);
+		j1939_session_txtimer_cancel_async(session);
+		j1939_session_rxtimer_cancel(session);
 	} else {
 		j1939_session_list_lock(session->priv);
-		if (session->state >= J1939_SESSION_ACTIVE &&
+		if (!session->rxtimer_cancelers &&
+		    session->state >= J1939_SESSION_ACTIVE &&
 		    session->state < J1939_SESSION_ACTIVE_MAX) {
 			netdev_alert(priv->ndev, "%s: 0x%p: rx timeout, send abort\n",
 				     __func__, session);
-			j1939_session_get(session);
-			hrtimer_start(&session->rxtimer,
-				      ms_to_ktime(J1939_XTP_ABORT_TIMEOUT_MS),
-				      HRTIMER_MODE_REL_SOFT);
+			j1939_tp_set_rxtimeout_locked(session,
+						      J1939_XTP_ABORT_TIMEOUT_MS);
 			__j1939_session_cancel(session, J1939_XTP_ABORT_TIMEOUT);
 		}
 		j1939_session_list_unlock(session->priv);
@@ -1291,6 +1584,13 @@ static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
 			j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
 	}
 
+	j1939_session_list_lock(priv);
+	WARN_ON_ONCE(!session->rxtimer_cb_running ||
+		     !session->rxtimer_cbref);
+	session->rxtimer_cb_running = false;
+	WARN_ON_ONCE(!session->rxtimer_cbref);
+	session->rxtimer_cbref = false;
+	j1939_session_list_unlock(priv);
 	j1939_session_put(session);
 
 	return HRTIMER_NORESTART;
@@ -1372,7 +1672,11 @@ static void j1939_xtp_rx_abort_one(struct j1939_priv *priv, struct sk_buff *skb,
 		    j1939_xtp_abort_to_str(abort));
 
 	j1939_session_timers_cancel(session);
-	session->err = j1939_xtp_abort_to_errno(priv, abort);
+	j1939_session_list_lock(priv);
+	if (session->state >= J1939_SESSION_ACTIVE &&
+	    session->state < J1939_SESSION_ACTIVE_MAX)
+		session->err = j1939_xtp_abort_to_errno(priv, abort);
+	j1939_session_list_unlock(priv);
 	if (session->sk)
 		j1939_sk_send_loop_abort(session->sk, session->err);
 	else
@@ -1486,7 +1790,6 @@ j1939_xtp_rx_cts_one(struct j1939_session *session, struct sk_buff *skb)
 			if (session->pkt.tx_acked)
 				j1939_sk_errqueue(session,
 						  J1939_ERRQUEUE_TX_SCHED);
-			j1939_session_txtimer_cancel(session);
 			j1939_tp_schedule_txtimer(session, 0);
 		}
 	} else {
@@ -1540,8 +1843,12 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(&session->skcb, skcb, sizeof(session->skcb));
 
-	hrtimer_setup(&session->txtimer, j1939_tp_txtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
-	hrtimer_setup(&session->rxtimer, j1939_tp_rxtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
+	scoped_guard(spinlock_init, &session->txtimer_lock) {
+		hrtimer_setup(&session->txtimer, j1939_tp_txtimer,
+			      CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
+	}
+	hrtimer_setup(&session->rxtimer, j1939_tp_rxtimer,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 
 	netdev_dbg(priv->ndev, "%s: 0x%p: sa: %02x, da: %02x\n",
 		   __func__, session, skcb->addr.sa, skcb->addr.da);
@@ -1810,7 +2117,6 @@ static void j1939_xtp_rx_rts(struct j1939_priv *priv, struct sk_buff *skb,
 			j1939_tp_set_rxtimeout(session, 750);
 	} else {
 		if (!session->transmission) {
-			j1939_session_txtimer_cancel(session);
 			j1939_tp_schedule_txtimer(session, 0);
 		}
 		j1939_tp_set_rxtimeout(session, 1250);
@@ -2234,24 +2540,40 @@ void j1939_simple_recv(struct j1939_priv *priv, struct sk_buff *skb)
 
 int j1939_cancel_active_session(struct j1939_priv *priv, struct sock *sk)
 {
-	struct j1939_session *session, *saved;
+	struct j1939_session *session, *iter;
 
 	netdev_dbg(priv->ndev, "%s, sk: %p\n", __func__, sk);
-	j1939_session_list_lock(priv);
-	list_for_each_entry_safe(session, saved,
-				 &priv->active_session_list,
-				 active_session_list_entry) {
-		if (!sk || sk == session->sk) {
-			if (hrtimer_try_to_cancel(&session->txtimer) == 1)
-				j1939_session_put(session);
-			if (hrtimer_try_to_cancel(&session->rxtimer) == 1)
-				j1939_session_put(session);
+	for (;;) {
+		session = NULL;
+		j1939_session_list_lock(priv);
+		list_for_each_entry(iter, &priv->active_session_list,
+				    active_session_list_entry) {
+			if (sk && sk != iter->sk)
+				continue;
+
+			/* Hold the session while timer callbacks are drained below. */
+			session = iter;
+			j1939_session_get(session);
+			break;
+		}
+		j1939_session_list_unlock(priv);
 
+		if (!session)
+			break;
+
+		j1939_session_list_lock(priv);
+		if (session->state >= J1939_SESSION_ACTIVE &&
+		    session->state < J1939_SESSION_ACTIVE_MAX) {
 			session->err = ESHUTDOWN;
 			j1939_session_deactivate_locked(session);
 		}
+		j1939_session_list_unlock(priv);
+
+		/* No state lock is held while waiting for either softirq timer. */
+		j1939_session_txtimer_cancel(session);
+		j1939_session_rxtimer_cancel_sync(session, false);
+		j1939_session_put(session);
 	}
-	j1939_session_list_unlock(priv);
 	return NOTIFY_DONE;
 }
 
-- 
2.43.0

