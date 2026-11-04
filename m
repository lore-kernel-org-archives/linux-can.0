Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804573;
	b=G1oMk7eublDxOM35lIHCfPOAvWMEwGu2dBPEFuyZx2qa3/0qYKPoRmkoPr4SugemBZ+o
	 aJbPl2kmrmDMvtZbAybmvEg+NQ26wlL79t7xjzoWKYK+v9nJOmMPLiTnaWdjYd9mikOKm
	 jZ1oKdfQZQczIvLJtkn5aU7qLo2Z1e0yryPrEuZNetEyL9GVEeeO6kjweZvcHwOCBy3/7
	 lybwnmWT87TdPKkFZDkexrx62L567ICe5kaItvBEFlaSQFpm9/WSPSfNRXlpWzp0wfu0V
	 ISZne8cU6kb/MIVdaHKGeF5PV0KdZp5SA1f0NObp8sm1+oq5gUPkfe0CK+NAIcwlS2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804573;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XBNaiNARz+6dX9GWg1anAs7H0Aa3jParRtwxYAyNgSI=;
	b=IUMQ03l4qfzO/7MdLpecLHAVHDMJ5F+qTUlrQfPzub2jVwONF2POFvsmJWPtD8XI2QvO
	 dfafmNwT6n51/dUnVV6cQ6x3dXGDgNywpmHgrQ+Y0+bah2Gsma/9iuWjc/sWJKqKsjLyS
	 wehotexRrLNgO0lWl2YBFXUCKkD1vTCWrHu2DKkXeZQgmdz5a5xe6gdIczb/GaOq90T2i
	 ZGRPQ+B2MbrWzFtofkRSm9t8gX6ltWZX4h9i+EEdc0R50ZbLW2TEwzJQUxA34+loENRlK
	 SwT95964Z0n0UdrwAa5LRudyeEVFFvsyDI5pqtimzrsllBkoVU8FQuAkYnkDJZsDnvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=CXxiqhEJ;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E1E606A326
	for <linux-can@vger.kernel.org>; Wed,  4 Nov 2026 15:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50E1E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=CXxiqhEJ
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so702622a91.3
        for <linux-can@vger.kernel.org>; Wed, 04 Nov 2026 07:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1793804572; x=1794409372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XBNaiNARz+6dX9GWg1anAs7H0Aa3jParRtwxYAyNgSI=;
        b=CXxiqhEJ/PuI76tnIvWa3T6JLj+z1n6Q/jf5uGc8QNZd1K8cDfCQeKdOZEmzl9+Zh/
         LBmoQWSiUNfgCl5ZyxjooSnoAroV67gfPV35UdStx06Qb+F6EDWPdIVquLIzx6WQlDCT
         RN+iAPpdO4VjGSkp8fGqZpc0K29JixX2bfar9JEXGxtwzsPJoFC/np7Nx2x4ir9yc+kP
         pO4bMxc9czT1kR4A3fn+FmZOWUNS9AFbP3se8mEHyOpj8AsAOkgZ1Gy4WnpY2ja73f8g
         Kn2qbWne4zHRt4bWY0FUamboN4Qe6o5ipC2wic7+XDuUefS1MRq1XtWxaz3be2J9eEMS
         ojrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804572; x=1794409372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XBNaiNARz+6dX9GWg1anAs7H0Aa3jParRtwxYAyNgSI=;
        b=c+2U+DzZ/LBHsNFg7i1919lEDD3n+Qmo+95a4Ns7QAigef07+yVjwZPou7PRkRMxX9
         QSSLVd+x3a+QBXPQwEaaUMfQ7UnK4vW3a4c9CKzCU3mMLKfOif24+i/qJEG6S7Jazaxo
         FjpDN0fENgbimIxBc01j7TrP1Px1ZmNIvQdbC34eO4i+/PCjfUVcpgnKq/a+dFEjn6ld
         B2BqJ0FhMSlOCQqQs93D0zWQcM/YOSIM5y17BsfaqROGZdYdeGghqYswT3JpucMdebL9
         uXXaKskwLcbd9fiBHJM6l4/J1sFufVt5aBHpgPu67jAl/XDzStPDPz1qpQe+y/iWwZOi
         ILpw==
X-Gm-Message-State: APuU4Z8wX+RAK+h8/lkZR+Lr24q7n9Tk+z+9sOkm5Vlr27xAdGZtSLPu
	WsQfLiUr+8tiNpjFgFyXbSi8OS9HtGibOGB61mXvBlVZRgFc2ENFNJbShZvyDx4aHpT5XsBTwrB
	fRiWfnS69
X-Gm-Gg: AYBFou3h2cxzGtEvjWSGRbOGHFV3xSPxZjyHGP3glact5emc00iuuzOLssAFnkDlapq
	2iwjs0SVzkg4UH4tLJIR/5lQX5WkVdxZ2Ecu6qhQW5sSFwn8ZDdwQExDu/z5XpSmwjEWEQezDev
	VpLofIBFP79TPn7Uf/XUyWpJobe5PbOuUQ1ok8fJ7FGPjSUFPzww7z/vnvYI6e3sJHhKOcKnowD
	soGleKrUZaUEyUl4guDinExIyPExmDl1QWhNmtTmYi9CsjEZ8+onCrZ6aY7Qb3CrPQF276Ft5LA
	65+JnBdfXUQuM0t78d5wDf4xbtaekFpIUN5ZjW6kgccs1ivdZkBi0ugqq3uf7kHzfsKOPutxjiE
	voPhyxS3D7KGu/5eMXo7Un8YBzt1tuTFH4BBaTdwjaTfMe4Nai/1KMcgpjgab3g6OecNzHvS3Rt
	iwjxg6zdgBzNFeVpgCCd/ngA3VN4xumn/J9HMYE4LNGdTf4Ibg16n9IFcUS+3MMeZizxDz/UYwF
	HBIQ9/v12UwBBt+H8iaaOnGSg/DdfFltqsUg3DrM3rI8HfdLheFXjnEPJ6ND6yZk0eO7DlM4jMh
	VUoqK5vnfGd4naITvsFXGC2tlxkammwPTxln/SwPFovzRjkzAdutD39wmcwf
X-Received: by 2002:a17:90b:4cd2:b0:3a7:3474:b1ee with SMTP id 98e67ed59e1d1-3ae897f8a0dmr14734239a91.60.1793804571231;
        Wed, 04 Nov 2026 07:02:51 -0800 (PST)
Received: from 24c857d0c3be.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b094d572e7sm2278456a91.1.2026.11.04.07.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:02:50 -0800 (PST)
From: Zihan Xi <zihanx@nebusec.ai>
To: linux-can@vger.kernel.org
Cc: robin@protonic.nl,
	o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	socketcan@hartkopp.net,
	mkl@pengutronix.de,
	lkp@intel.com,
	bst@pengutronix.de,
	dev.kurt@vandijck-laurijssen.be,
	maxime.jayat@mobile-devices.fr,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net v6 2/2] can: j1939: serialize TX with session shutdown
Date: Wed,  4 Nov 2026 15:02:27 +0000
Message-ID: <f9f8aa1cd4eb28c018aa35ec85a1032003d4421a.1793788955.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1793788955.git.zihanx@nebusec.ai>
References: <cover.1793788955.git.zihanx@nebusec.ai>
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

Prevent a timer callback from sending session frames after a concurrent
terminal state transition. Serialize the send with the state change and
reject frames once shutdown has been published.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Link: https://bugtracker.nebusec.ai/f/11143
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 net/can/j1939/j1939-priv.h |   3 ++
 net/can/j1939/transport.c  | 106 +++++++++++++++++++++++++++++--------
 2 files changed, 88 insertions(+), 21 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 123622c82a98..1d8cbe692fcd 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -292,6 +292,9 @@ struct j1939_session {
 	} pkt;
 	struct hrtimer txtimer, rxtimer;
 	unsigned int txtimer_cancelers; /* block starts while a cancel waits */
+	/* Serialize session frame transmission against terminal state changes. */
+	spinlock_t tx_send_lock;
+	bool tx_send_shutdown;
 	spinlock_t txtimer_lock; /* Protects TX timer lifetime state. */
 	/* One reference pins the complete queued/running timer lifetime. */
 	bool txtimer_shutdown;
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index fbeb858956e0..390923a05046 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -446,10 +446,18 @@ static void j1939_session_rxtimer_cancel_async(struct j1939_session *session)
 		j1939_session_put(session);
 }
 
+static void j1939_session_tx_send_shutdown(struct j1939_session *session)
+{
+	spin_lock_bh(&session->tx_send_lock);
+	session->tx_send_shutdown = true;
+	spin_unlock_bh(&session->tx_send_lock);
+}
+
 static void
 j1939_session_timers_shutdown_locked(struct j1939_session *session)
 {
 	lockdep_assert_held(&session->priv->active_session_list_lock);
+	j1939_session_tx_send_shutdown(session);
 	spin_lock(&session->rxtimer_lock);
 	session->rxtimer_shutdown = true;
 	spin_unlock(&session->rxtimer_lock);
@@ -797,6 +805,25 @@ sk_buff *j1939_tp_tx_dat_new(struct j1939_priv *priv,
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
@@ -813,12 +840,13 @@ static int j1939_tp_tx_dat(struct j1939_session *session,
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
@@ -836,6 +864,8 @@ static int j1939_xtp_do_tx_ctl(struct j1939_priv *priv,
 	skdat[6] = (pgn >> 8);
 	skdat[7] = (pgn >> 16);
 
+	if (session)
+		return j1939_session_tx_send(session, skb);
 	return j1939_send_one(priv, skb);
 }
 
@@ -846,7 +876,7 @@ static inline int j1939_tp_tx_ctl(struct j1939_session *session,
 
 	return j1939_xtp_do_tx_ctl(priv, &session->skcb,
 				   swap_src_dst,
-				   session->skcb.addr.pgn, dat);
+				   session->skcb.addr.pgn, dat, session);
 }
 
 static int j1939_xtp_tx_abort(struct j1939_priv *priv,
@@ -863,7 +893,8 @@ static int j1939_xtp_tx_abort(struct j1939_priv *priv,
 	memset(dat, 0xff, sizeof(dat));
 	dat[0] = J1939_TP_CMD_ABORT;
 	dat[1] = err;
-	return j1939_xtp_do_tx_ctl(priv, re_skcb, swap_src_dst, pgn, dat);
+	return j1939_xtp_do_tx_ctl(priv, re_skcb, swap_src_dst, pgn, dat,
+				   NULL);
 }
 
 void j1939_tp_schedule_txtimer(struct j1939_session *session, int msec)
@@ -898,7 +929,14 @@ static bool
 __j1939_tp_set_rxtimeout(struct j1939_session *session, int msec,
 			 bool abort_timeout)
 {
+	bool shutdown;
+
 	lockdep_assert_held(&session->priv->active_session_list_lock);
+	spin_lock(&session->tx_send_lock);
+	shutdown = session->tx_send_shutdown;
+	spin_unlock(&session->tx_send_lock);
+	if (shutdown)
+		return false;
 
 	spin_lock(&session->rxtimer_lock);
 	if (session->rxtimer_shutdown || session->rxtimer_cancelers ||
@@ -1058,7 +1096,7 @@ static int j1939_session_tx_dat(struct j1939_session *session)
 		ret = j1939_tp_tx_dat(session, dat, len + 1);
 		if (ret < 0) {
 			/* ENOBUFS == CAN interface TX queue is full */
-			if (ret != -ENOBUFS)
+			if (ret != -ENOBUFS && ret != -ESHUTDOWN)
 				netdev_alert(priv->ndev,
 					     "%s: 0x%p: queue data error: %i\n",
 					     __func__, session, ret);
@@ -1283,7 +1321,7 @@ static int j1939_simple_txnext(struct j1939_session *session)
 
 	can_skb_set_owner(skb, se_skb->sk);
 
-	ret = j1939_send_one(session->priv, skb);
+	ret = j1939_session_tx_send(session, skb);
 	if (ret)
 		goto out_free;
 
@@ -1318,7 +1356,9 @@ static bool j1939_session_deactivate_locked(struct j1939_session *session)
 		active = true;
 
 		list_del_init(&session->active_session_list_entry);
-		session->state = J1939_SESSION_DONE;
+		spin_lock(&session->tx_send_lock);
+		WRITE_ONCE(session->state, J1939_SESSION_DONE);
+		spin_unlock(&session->tx_send_lock);
 		j1939_session_put(session);
 	}
 
@@ -1350,10 +1390,13 @@ j1939_session_deactivate_activate_next(struct j1939_session *session)
 
 static bool j1939_session_fail(struct j1939_session *session, int err)
 {
-	bool deactivate = false;
+	bool deactivate = false, tx_send_shutdown;
 
 	j1939_session_list_lock(session->priv);
-	if (session->state == J1939_SESSION_ACTIVE) {
+	spin_lock(&session->tx_send_lock);
+	tx_send_shutdown = session->tx_send_shutdown;
+	spin_unlock(&session->tx_send_lock);
+	if (!tx_send_shutdown && session->state == J1939_SESSION_ACTIVE) {
 		session->err = err;
 		deactivate = j1939_session_deactivate_locked(session);
 	}
@@ -1376,14 +1419,22 @@ static bool __j1939_session_cancel(struct j1939_session *session,
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
+
 	if (session->sk)
 		j1939_sk_send_loop_abort(session->sk, session->err);
 
@@ -1399,16 +1450,23 @@ static bool j1939_session_cancel(struct j1939_session *session,
 
 	if (session->state >= J1939_SESSION_ACTIVE &&
 	    session->state < J1939_SESSION_WAITING_ABORT) {
-		cancelled = __j1939_session_cancel(session, err);
-		if (cancelled) {
-			spin_lock(&session->txtimer_lock);
-			session->txtimer_shutdown = true;
-			spin_unlock(&session->txtimer_lock);
-			if (!__j1939_tp_set_rxtimeout(session,
-						      J1939_XTP_ABORT_TIMEOUT_MS,
-						      true))
-				deactivate =
-					j1939_session_deactivate_locked(session);
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
+				if (!__j1939_tp_set_rxtimeout(session,
+							      J1939_XTP_ABORT_TIMEOUT_MS,
+							      true))
+					deactivate =
+						j1939_session_deactivate_locked(session);
+			}
 		}
 	}
 
@@ -1476,6 +1534,9 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 		 * propagation of the error to user space.
 		 */
 		break;
+	case -ESHUTDOWN:
+		/* A terminal state transition won before the frame was sent. */
+		break;
 	case -EOVERFLOW:
 		j1939_session_cancel(session, J1939_XTP_ABORT_ECTS_TOO_BIG);
 		break;
@@ -1878,6 +1939,7 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
 	memcpy(&session->skcb, skcb, sizeof(session->skcb));
 
 	spin_lock_init(&session->txtimer_lock);
+	spin_lock_init(&session->tx_send_lock);
 	spin_lock_init(&session->rxtimer_lock);
 	hrtimer_setup(&session->txtimer, j1939_tp_txtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	hrtimer_setup(&session->rxtimer, j1939_tp_rxtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
@@ -1947,7 +2009,9 @@ int j1939_session_activate(struct j1939_session *session)
 		list_add_tail(&session->active_session_list_entry,
 			      &priv->active_session_list);
 		j1939_session_get(session);
-		session->state = J1939_SESSION_ACTIVE;
+		spin_lock(&session->tx_send_lock);
+		WRITE_ONCE(session->state, J1939_SESSION_ACTIVE);
+		spin_unlock(&session->tx_send_lock);
 
 		netdev_dbg(session->priv->ndev, "%s: 0x%p\n",
 			   __func__, session);
-- 
2.43.0

