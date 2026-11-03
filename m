Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793683481;
	b=vr90nWlP0sNeX4JBTBwZVS+OiaCXOnrMDKfEdz+/6mK5lcPqfjsB20z6yNcBLkF6wkG2
	 DU1QkIvbCHQ94WVUnwkIuwKSrh++Ebk+76LQnWaRVNpLdFxdmevgM7IQz0QTA4e64LFWY
	 nV3JKQfObNATcBVnR/6svERUUzyC1a3wtsBfJgS/UsscpZZ/SuKQA+bLbNxDtdNNMC1VF
	 RdafQ7r02hP6VpKCypnwSlgJzHWGzktQ+z7F598Oy9rZpBYSdTgFzfb4l9FdKPZInjyjI
	 2YIwbAhTWqy70xb0Z4UHEbf3ctBSIl5p2fMdPAckmsMkqNr9JC+r4AIJU2HT6ezFFHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793683481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9xILNAKGymWNSjgpA3yCo9OYyJHBytnfBUDIkHC6/AY=;
	b=xh2UscnSqTaeAJK/h9wAuAohASSCAj+cdYMJRj/HjMVq4rBzcelDzloC4ctAjcp6IFcK
	 4jMklOJF9PvFeo0Uaxs6gftfR190jqarayye1KLq6ybgZGLdxbsWaAOMIaJsFU2siF2t3
	 yJfMkPR9GWKXT/ZQDS5j33paMGaddXLIWwMNstOtRjBnaQ6GBM4BsRafF/aVJNDABwgh1
	 d3HgodpvMyu+fXm7Oo+gUp8Sis+Yy129XrWOOJ9GL/qWqll2CjStVFzc1XBGEiT6Q3x5p
	 jzzBDWG5RIefdsmnNaarjoSByWiAlm6Wg3wbtK4L6z5I47D54Zi3eG5/ajHLLJcZpCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=RDQRmdCD;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E59B606A324
	for <linux-can@vger.kernel.org>; Tue,  3 Nov 2026 05:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E59B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=RDQRmdCD
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e8246b13cbso32030865ad.2
        for <linux-can@vger.kernel.org>; Mon, 02 Nov 2026 21:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1793683480; x=1794288280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9xILNAKGymWNSjgpA3yCo9OYyJHBytnfBUDIkHC6/AY=;
        b=RDQRmdCDnKV5dq/HIgnwZejTq79lEJ99F1mt/JtzymOT7OkJEz9LKcUvcPZfUN1kU/
         z0Yt7LpXVp4EK3cMRC3yxuH1dCao8M/V9MJIpEV82sv959r5UyP5HWL5nGk0xSuL8kzq
         U9dIgutChY77XvhxgqzfKlc6FYNcJk2Gyu8vXPd91HNEI3gSsO50vM9yp+xl7OmYWIE0
         fKp3sRixHPvlagLqVml/ATyez62JTVSCbMO18LJkrwBg7CPvTnP8CHMsoIpUfB9yoX/p
         u+nXAbhXuBDuHqy01qxnFr3YA57ilgRxG1+/nigBaNLmPZBjnr5Dimdhu7T4MMmNv5gG
         rkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793683480; x=1794288280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9xILNAKGymWNSjgpA3yCo9OYyJHBytnfBUDIkHC6/AY=;
        b=w+FoX3OQNULMUNSkGn7wi7S+3hC1VcN3H3fOJdEl6x1BSvE6fJLK4oyXBjbYHoVWKK
         lLEsgv/h6+3H8PjiAzLPyrdg7UmtG5zN62OsNzeI7/frTjomouPOSYwWK8CFFM9Wgw/E
         r5+d1p/JkHMbbGtKnkhQszJwCfrQuTrL+TiTM9wbbKiF0ci5RHk3sChvfa9IC9o3MUh9
         lA83dHSSwbuhXvKG0IQq0SiF+twzfVRxmdtka2cLsLkBnG1hMvHGOUThABbn3y7Yxy4B
         CWrT9OvjbFl7AUd4YTB1LuEnXoz1mtJcGnu+ZDLGuNc36JSawi/HaJ8JbuUoOXg3Egdi
         e50Q==
X-Gm-Message-State: APuU4Z9nucVui9eDDYhszxoE1AfF9PwBGcqiLbo4FptI7kJmFRPJIYsX
	T9d7FCmLuLbUBpm8R+04r2K5To0Dl1TimQxY5i5oDfNz/gbS4wK205P8qAh4v/vE+ffHrZGtdhm
	H2nBOPsj9
X-Gm-Gg: AYBFou2bIiDL1Q2/TwMj8dd1wakZP4hSt/6R0KiJyOhsHxVX0l5+QHwfdxBxKpGFSU6
	dSLaJxHlBKRHH3SLtGYUagEQMIy2f4CYU23UsvXOeXRCi52ooptnZyYBSwNrEw4x53TJ+6uZ9+v
	YJCFTKOdPRTVPY/9rJXfo9UECNN8qrr7zZl0HAWcQZVsxOHv7F+DdKd+luZUf2kvm9suF8bCX49
	ukLtuCY2qTgNe1YIv8TF/O1e7BiGXvSTNeQI2fvWUUfarjUPokllK4qxXm9Ms0L2AvzdX1OTdbE
	H3yyq2u+eYTJzExEFYS+mE/dcnRvKkfXJDiFfAceiiyx2WtHBVj0EnoAXKnwOoLMTJhpqvnx66U
	Oe5xndWQQfwrxI1t5oq2ZlFk0RqLqyk8EsAjqbkBroSnyjSrxo41vaXVyIvBoWYbHDIVlnFqzSb
	8XnXzM4oMpNZNT7DYlEI0XFdumqpVHW7OLswjkiZFiaEBaeeizKtTsu7oAqw7nbGPQ/OL0Zd70H
	PX+7Xl2ItMXD2GO/IZCVV0mQEABlRMveLFra9URs8Ap8O5704cYToIQg2K2kvmccPHnZAzyZgDE
	X//O34mJ92D/kF1H3lGhaoRtmY0RH+njlpAAxz9g89Uh5kmK0aRWlUGWXTzjVw==
X-Received: by 2002:a17:903:1aef:b0:2e9:658f:c33d with SMTP id d9443c01a7336-2eb36405a95mr115854185ad.4.1793683480338;
        Mon, 02 Nov 2026 21:24:40 -0800 (PST)
Received: from 24c857d0c3be.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb77df90casm9943245ad.0.2026.11.02.21.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 21:24:38 -0800 (PST)
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
Subject: [PATCH net v5 3/3] can: j1939: serialize session TX with state changes
Date: Tue,  3 Nov 2026 05:24:15 +0000
Message-ID: <c7ce2c35e7d6a5097363b9b0ec69dabdc17a5326.1793681851.git.zihanx@nebusec.ai>
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

A TX timer callback can pass its ACTIVE check before an RX timeout
moves the session to WAITING_ABORT. Since timer cancellation is
asynchronous, the callback can continue and send a stale CTS or EOMA.

Serialize session frame sends with terminal state changes and reject
frames at the send point after the session stops being active. Close the
send gate before synchronously draining terminal timers so an in-flight
callback cannot send during the drain. Ignore callback cancellation if a
terminal path already shut down sends, including its raw ABORT response.

Error paths let session_cancel() perform the WAITING_ABORT transition
before arming the RX abort timeout. Arm that timeout outside the
active-session-list lock so a running RX timer cannot deadlock against it.
Advance the socket queue when a simple session times out.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Link: https://bugtracker.nebusec.ai/f/11143
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 net/can/j1939/j1939-priv.h |   3 +
 net/can/j1939/transport.c  | 113 ++++++++++++++++++++++++++++---------
 2 files changed, 90 insertions(+), 26 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index c95fca38b8b1..8b52d499154a 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -292,6 +292,9 @@ struct j1939_session {
 	} pkt;
 	struct hrtimer txtimer, rxtimer;
 	unsigned int txtimer_cancelers; /* block starts while a cancel waits */
+	/* Serialize session frame transmission against terminal state changes. */
+	spinlock_t tx_send_lock;
+	bool tx_send_shutdown;
 	spinlock_t txtimer_lock;
 	/* One reference pins the complete queued/running timer lifetime. */
 	bool txtimer_shutdown;
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index c85d7bb3c12d..7d6ed7fb8c56 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -382,8 +382,16 @@ static void j1939_session_rxtimer_cancel(struct j1939_session *session)
 		j1939_session_put(session);
 }
 
+static void j1939_session_tx_send_shutdown(struct j1939_session *session)
+{
+	spin_lock_bh(&session->tx_send_lock);
+	session->tx_send_shutdown = true;
+	spin_unlock_bh(&session->tx_send_lock);
+}
+
 void j1939_session_timers_cancel(struct j1939_session *session)
 {
+	j1939_session_tx_send_shutdown(session);
 	j1939_session_txtimer_cancel(session, true);
 	j1939_session_rxtimer_cancel(session);
 }
@@ -714,6 +722,25 @@ sk_buff *j1939_tp_tx_dat_new(struct j1939_priv *priv,
 	return skb;
 }
 
+static int j1939_session_tx_send(struct j1939_session *session,
+				 struct sk_buff *skb)
+{
+	int ret;
+
+	/* Pair the state check and send with terminal state transitions. */
+	spin_lock_bh(&session->tx_send_lock);
+	if (session->tx_send_shutdown ||
+	    READ_ONCE(session->state) != J1939_SESSION_ACTIVE) {
+		spin_unlock_bh(&session->tx_send_lock);
+		kfree_skb(skb);
+		return -ESHUTDOWN;
+	}
+	ret = j1939_send_one(session->priv, skb);
+	spin_unlock_bh(&session->tx_send_lock);
+
+	return ret;
+}
+
 /* TP transmit packet functions */
 static int j1939_tp_tx_dat(struct j1939_session *session,
 			   const u8 *dat, int len)
@@ -730,12 +757,13 @@ static int j1939_tp_tx_dat(struct j1939_session *session,
 	if (j1939_tp_padding && len < 8)
 		memset(skb_put(skb, 8 - len), 0xff, 8 - len);
 
-	return j1939_send_one(priv, skb);
+	return j1939_session_tx_send(session, skb);
 }
 
 static int j1939_xtp_do_tx_ctl(struct j1939_priv *priv,
 			       const struct j1939_sk_buff_cb *re_skcb,
-			       bool swap_src_dst, pgn_t pgn, const u8 *dat)
+			       bool swap_src_dst, pgn_t pgn, const u8 *dat,
+			       struct j1939_session *session)
 {
 	struct sk_buff *skb;
 	u8 *skdat;
@@ -753,6 +781,8 @@ static int j1939_xtp_do_tx_ctl(struct j1939_priv *priv,
 	skdat[6] = (pgn >> 8);
 	skdat[7] = (pgn >> 16);
 
+	if (session)
+		return j1939_session_tx_send(session, skb);
 	return j1939_send_one(priv, skb);
 }
 
@@ -763,7 +793,7 @@ static inline int j1939_tp_tx_ctl(struct j1939_session *session,
 
 	return j1939_xtp_do_tx_ctl(priv, &session->skcb,
 				   swap_src_dst,
-				   session->skcb.addr.pgn, dat);
+				   session->skcb.addr.pgn, dat, session);
 }
 
 static int j1939_xtp_tx_abort(struct j1939_priv *priv,
@@ -780,7 +810,8 @@ static int j1939_xtp_tx_abort(struct j1939_priv *priv,
 	memset(dat, 0xff, sizeof(dat));
 	dat[0] = J1939_TP_CMD_ABORT;
 	dat[1] = err;
-	return j1939_xtp_do_tx_ctl(priv, re_skcb, swap_src_dst, pgn, dat);
+	return j1939_xtp_do_tx_ctl(priv, re_skcb, swap_src_dst, pgn, dat,
+				   NULL);
 }
 
 void j1939_tp_schedule_txtimer(struct j1939_session *session, int msec)
@@ -1144,7 +1175,6 @@ static int j1939_xtp_txnext_receiver(struct j1939_session *session)
 
 static int j1939_simple_txnext(struct j1939_session *session)
 {
-	struct j1939_priv *priv = session->priv;
 	struct sk_buff *se_skb = j1939_session_skb_get(session);
 	struct sk_buff *skb;
 	int ret;
@@ -1173,7 +1203,7 @@ static int j1939_simple_txnext(struct j1939_session *session)
 
 	j1939_tp_set_rxtimeout(session, J1939_SIMPLE_ECHO_TIMEOUT_MS);
 
-	ret = j1939_send_one(priv, skb);
+	ret = j1939_session_tx_send(session, skb);
 	if (ret)
 		goto out_free;
 
@@ -1203,7 +1233,9 @@ static bool j1939_session_deactivate_locked(struct j1939_session *session)
 		active = true;
 
 		list_del_init(&session->active_session_list_entry);
-		session->state = J1939_SESSION_DONE;
+		spin_lock(&session->tx_send_lock);
+		WRITE_ONCE(session->state, J1939_SESSION_DONE);
+		spin_unlock(&session->tx_send_lock);
 		j1939_session_put(session);
 	}
 
@@ -1231,7 +1263,7 @@ j1939_session_deactivate_activate_next(struct j1939_session *session)
 		j1939_sk_queue_activate_next(session);
 }
 
-static void __j1939_session_cancel(struct j1939_session *session,
+static bool __j1939_session_cancel(struct j1939_session *session,
 				   enum j1939_xtp_abort err)
 {
 	struct j1939_priv *priv = session->priv;
@@ -1239,17 +1271,26 @@ static void __j1939_session_cancel(struct j1939_session *session,
 	WARN_ON_ONCE(!err);
 	lockdep_assert_held(&session->priv->active_session_list_lock);
 
+	spin_lock(&session->tx_send_lock);
+	if (session->tx_send_shutdown) {
+		spin_unlock(&session->tx_send_lock);
+		return false;
+	}
+
 	session->err = j1939_xtp_abort_to_errno(priv, err);
-	session->state = J1939_SESSION_WAITING_ABORT;
+	WRITE_ONCE(session->state, J1939_SESSION_WAITING_ABORT);
 	/* do not send aborts on incoming broadcasts */
 	if (!j1939_cb_is_broadcast(&session->skcb)) {
 		j1939_xtp_tx_abort(priv, &session->skcb,
 				   !session->transmission,
 				   err, session->skcb.addr.pgn);
 	}
+	spin_unlock(&session->tx_send_lock);
 
 	if (session->sk)
 		j1939_sk_send_loop_abort(session->sk, session->err);
+
+	return true;
 }
 
 static void j1939_session_cancel(struct j1939_session *session,
@@ -1261,19 +1302,36 @@ static void j1939_session_cancel(struct j1939_session *session,
 
 	if (session->state >= J1939_SESSION_ACTIVE &&
 	    session->state < J1939_SESSION_WAITING_ABORT) {
-		j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
-		__j1939_session_cancel(session, err);
-		spin_lock(&session->txtimer_lock);
-		session->txtimer_shutdown = true;
-		spin_unlock(&session->txtimer_lock);
-		cancelled = true;
+		bool tx_send_shutdown;
+
+		spin_lock(&session->tx_send_lock);
+		tx_send_shutdown = session->tx_send_shutdown;
+		spin_unlock(&session->tx_send_lock);
+		if (!tx_send_shutdown) {
+			cancelled = __j1939_session_cancel(session, err);
+			if (cancelled) {
+				spin_lock(&session->txtimer_lock);
+				session->txtimer_shutdown = true;
+				spin_unlock(&session->txtimer_lock);
+			}
+		}
 	}
 
 	j1939_session_list_unlock(session->priv);
-	if (cancelled)
+	if (cancelled) {
+		bool keep_rxtimer;
+
+		/* Do not wait for the RX timer while holding the session-list lock. */
+		j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
+		j1939_session_list_lock(session->priv);
+		keep_rxtimer = session->state == J1939_SESSION_WAITING_ABORT;
+		j1939_session_list_unlock(session->priv);
+		if (!keep_rxtimer)
+			j1939_session_rxtimer_cancel(session);
 		j1939_session_txtimer_cancel_async(session);
+	}
 
-	if (!session->sk)
+	if (cancelled && !session->sk)
 		j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
 }
 
@@ -1329,6 +1387,9 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 		 * propagation of the error to user space.
 		 */
 		break;
+	case -ESHUTDOWN:
+		/* A terminal state transition won before the frame was sent. */
+		break;
 	case -EOVERFLOW:
 		j1939_session_cancel(session, J1939_XTP_ABORT_ECTS_TOO_BIG);
 		break;
@@ -1403,7 +1464,7 @@ static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
 		 * be send as soon as CAN bus is in working state again.
 		 */
 		session->err = -ETIME;
-		j1939_session_deactivate(session);
+		j1939_session_deactivate_activate_next(session);
 	} else {
 		j1939_session_list_lock(session->priv);
 		if (session->state >= J1939_SESSION_ACTIVE &&
@@ -1414,14 +1475,15 @@ static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
 			hrtimer_start(&session->rxtimer,
 				      ms_to_ktime(J1939_XTP_ABORT_TIMEOUT_MS),
 				      HRTIMER_MODE_REL_SOFT);
-			__j1939_session_cancel(session, J1939_XTP_ABORT_TIMEOUT);
-			cancelled = true;
+			cancelled =
+				__j1939_session_cancel(session,
+						       J1939_XTP_ABORT_TIMEOUT);
 		}
 		j1939_session_list_unlock(session->priv);
 		if (cancelled)
 			j1939_session_txtimer_cancel_async(session);
 
-		if (!session->sk)
+		if (cancelled && !session->sk)
 			j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
 	}
 
@@ -1630,7 +1692,6 @@ j1939_xtp_rx_cts_one(struct j1939_session *session, struct sk_buff *skb)
 	return;
 
  out_session_cancel:
-	j1939_session_timers_cancel(session);
 	j1939_session_cancel(session, err);
 }
 
@@ -1675,6 +1736,7 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
 	memcpy(&session->skcb, skcb, sizeof(session->skcb));
 
 	spin_lock_init(&session->txtimer_lock);
+	spin_lock_init(&session->tx_send_lock);
 	hrtimer_setup(&session->txtimer, j1939_tp_txtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	hrtimer_setup(&session->rxtimer, j1939_tp_rxtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 
@@ -1743,7 +1805,9 @@ int j1939_session_activate(struct j1939_session *session)
 		list_add_tail(&session->active_session_list_entry,
 			      &priv->active_session_list);
 		j1939_session_get(session);
-		session->state = J1939_SESSION_ACTIVE;
+		spin_lock(&session->tx_send_lock);
+		WRITE_ONCE(session->state, J1939_SESSION_ACTIVE);
+		spin_unlock(&session->tx_send_lock);
 
 		netdev_dbg(session->priv->ndev, "%s: 0x%p\n",
 			   __func__, session);
@@ -1852,7 +1916,6 @@ static int j1939_xtp_rx_rts_session_active(struct j1939_session *session,
 			return -EBUSY;
 
 		/* RTS on active session */
-		j1939_session_timers_cancel(session);
 		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
 	}
 
@@ -1862,7 +1925,6 @@ static int j1939_xtp_rx_rts_session_active(struct j1939_session *session,
 			     __func__, session, skcb->addr.sa, skcb->addr.da,
 			     session->last_cmd);
 
-		j1939_session_timers_cancel(session);
 		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
 		if (session->transmission) {
 			j1939_session_deactivate_activate_next(session);
@@ -2111,7 +2173,6 @@ static void j1939_xtp_rx_dat_one(struct j1939_session *session,
 
  out_session_cancel:
 	kfree_skb(se_skb);
-	j1939_session_timers_cancel(session);
 	j1939_session_cancel(session, abort);
 	j1939_session_put(session);
 }
-- 
2.43.0

