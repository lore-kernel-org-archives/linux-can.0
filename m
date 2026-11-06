Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982663;
	b=NZXC791980X6RU4N4JRQtiMuOtRQmbkQo9zxRfcLVOyX+lMMN6Xyjt+1kyYY122IuK2I
	 LGTGNQbHH1gj8bF0HQR95spuQzcGrlPMHrV+PxRmJX7kL6Z+JuX7ZREo8vzLRoP4UngRA
	 NWsKJyQksDPQg7IwGI8hSodU1sxnvP+BEfkmZwIYTvwXKbu7zRTOWvEIVUktf2wfqpgNW
	 Zo4GCe5vwy1g+eNt/2GdnwtXk2gV0P5DygXNQQH/GIlhnrWqeqTHL2NsTApdYAxIlJDQg
	 vSA9Kvp1ddE5gKVdt4lLgi7o6io1U5jcVpXMIH2xYBqEw+RmGuaZaI4vxPgSjuEELaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QUGlmYFLUDvxW6GOgalNc/WcsKftuv4/ooL0rYkVsH8=;
	b=bvS8PAAQVQRzsgdPvBMaWeHWLZjT9y4HlrNMUrCNAP6+Jb47zoUwx+0i1pazMfP7R3LZ
	 j9UEP/vdpTxs9EPtQim5C00xeDRc7g0jdvS29aU+9w8h89MGeQ+HO9uJA42Y5L5IHPDMW
	 pJR/RBPh99NmtnxUKbWS69ki3rEytsFp4C1FNxxEBqjxpqfamYt2Q/ns90E3+ZBqePGNg
	 PSuzcSBcgxgNig4opFTJIueLXhkRADkqWKfE+uObt/aQatOXUyx1fr8xWo4kRA/FqclXz
	 e29U1/MZ6N2hAV7DDpYZj4n8hS1BD7IxF1J5nEW9iFQs4b8+/ih98uOjc/HTx//cgRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=OAc7ZqT3;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1DB606A329
	for <linux-can@vger.kernel.org>; Fri,  6 Nov 2026 16:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B1DB606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=OAc7ZqT3
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b0b3438540so504817a91.0
        for <linux-can@vger.kernel.org>; Fri, 06 Nov 2026 08:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1793982662; x=1794587462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QUGlmYFLUDvxW6GOgalNc/WcsKftuv4/ooL0rYkVsH8=;
        b=OAc7ZqT3Fq8NxybtD4A6liU3HhPIqLW0UNEdlgKGZyXIWBGwy3vvgwxSjKQWZ8UZyp
         n+6nQMJE6e+Sra291b+JhbbdaGYnuiHHGDwQlX4ZKs12EmUAkMblEl4P1i9b4GIQ4RUE
         a7bzX2+ZPOxOUZqshPUSKAM33sx7fJStUV73EDxvs6gPSJleDxlDUCrVgpl/AI5ecuAb
         0XZ53sOB0UdgoXsAGgNV+wx/10X4WXtIya2Zsu5wzODySzaIj53VmBAsG2VhqLS4hdwo
         PaU/vFR9VeJSr58fj1/5u8DlUwltmoB2Vzhl4SMKw+18Khrn4ghg6Ag1UO8wUtoadZDN
         lkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793982662; x=1794587462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QUGlmYFLUDvxW6GOgalNc/WcsKftuv4/ooL0rYkVsH8=;
        b=c/kD9SGZH6DqANstYMJiej2MRd3AES2jSvMsyyLiioxiMWzoLt538RjzDojsSpWBW2
         8eZav5/Oeir5ApYDrUSRCO//FX3gkJY53VBtTgjj7lXZ3hZkMU0lQEq0aa84yEn8dV6o
         rtkM3sV26cs1XdKBBsxn4jzh0gLVjcEEo0zAwBSUAoIEo8LzbZst4+JkVTnFppZYe5g8
         /tdqMHl1KHIH9uGjgxomXHIy2IOpW/Uyhb2siT8jh9mk8c1eTG9Fc1iNi9oqfuxUIuoW
         eloCzDi9PxOJECdT4zISCoJIi2+KMfC9t0GUb8MRM3T4xEAjEIk6IdiOGolL/ZEMFeel
         naTg==
X-Gm-Message-State: APuU4Z9DRhkxL9/4J2v+lf7lUC+FudRShzXwhfyEe8kdBZqvdlZ3MDP9
	c5Kf6VQhXtaxuS6VksVbDFLke4nTktXylebGfpNEosFC+r5TtQbP+UarXAVhdi0FP9Gh37gXXW7
	XHth+XnoT
X-Gm-Gg: AYBFou3vGp7SSdtY/tVL+07dUWPKbNk8PBJYxfh10N5E1b7yyPMQAWjgx4Y5r2Wa29Z
	rbv9E6aL6IQXZfaBNLsYyxlFo2ldOKzExNMELn++/Qnato0JUnu9h49JG5qtYlDfdWii9jeNxZ9
	oLXFofa2u5o9qzC/bQOqi02f861e8IotP9YOjFRQNNsLoTggjdau/2ej4elQwc5rVa+mT87s/YZ
	q+tGftWNLPMZwfJI2jGv78YzUOFdsoEEXdotVVKq9MZwcxTt9VXSX++XP43h7fMMd4qI+SR9cs8
	aI4QDzzzsr3CB5HOxR0vhdUzmaeDJdXfeBEdDKB+XMgUuSY76o+JWsG6A56r/lp/llTj1fVact5
	cfHv4yv9N98/fWjrJShS8SwnAkkx6/z5287gdAIjabzFNFOHq1nhXPMyRyl78wFmGCqe2UPeEcL
	Ne8f4R6t4jKzGZxF5FNS4+JEnW9Eoh+g4jQDiIuiJRLMbOleQPnflnMKzRSv++GLFgfRrDFxz9s
	DD/V3Xxi0cGotzVMWyFyB2+jTGPBHI5ORoTQhrHZTOUQevGga4x1Lr0DQBl9f07EbU6SisrsO4v
	rpYymyw7by3W2KZTiUvqOeGD08crvsmaRHQ+GBf5JW4PhgwHzoAOeIm5tJv/
X-Received: by 2002:a17:90b:5547:b0:3ad:eb15:aed9 with SMTP id 98e67ed59e1d1-3b0db5eeda7mr2960269a91.9.1793982659860;
        Fri, 06 Nov 2026 08:30:59 -0800 (PST)
Received: from 24c857d0c3be.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b32812a6sm8368164a91.11.2026.11.06.08.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 08:30:59 -0800 (PST)
From: Zihan Xi <zihanx@nebusec.ai>
To: linux-can@vger.kernel.org
Cc: robin@protonic.nl,
	o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	socketcan@hartkopp.net,
	mkl@pengutronix.de,
	maxime.jayat@mobile-devices.fr,
	bst@pengutronix.de,
	ecathinds@gmail.com,
	dev.kurt@vandijck-laurijssen.be,
	lkp@intel.com,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net v7 2/2] can: j1939: serialize TX with session shutdown
Date: Fri,  6 Nov 2026 16:30:37 +0000
Message-ID: <6192ad490122e9948e7f2213bea0d642e535c0e5.1793946215.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1793946215.git.zihanx@nebusec.ai>
References: <cover.1793946215.git.zihanx@nebusec.ai>
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

A TX timer callback can pass its ACTIVE-state check just before another
CPU completes or aborts the session. Serialize session frame transmission
with terminal state changes so no late TP.DT, CTS, EOMA, or simple frame
can appear on the CAN bus after shutdown wins.

The shutdown gate also prevents a late TX callback failure from replacing
the result while a terminal path has shut down the timers but has not yet
published DONE. Keep this gate in j1939_session_fail() for that interval.
The RX timer shutdown flag already covers the locked RX-timeout setup, so
avoid checking the same shutdown state twice. Likewise, let
__j1939_session_cancel() own the shutdown check shared by its callers.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Link: https://bugtracker.nebusec.ai/f/11143
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 net/can/j1939/j1939-priv.h |  3 ++
 net/can/j1939/transport.c  | 73 ++++++++++++++++++++++++++++++++------
 2 files changed, 65 insertions(+), 11 deletions(-)

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
index e485e71c9d6c..8a55515caf22 100644
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
@@ -1058,7 +1089,7 @@ static int j1939_session_tx_dat(struct j1939_session *session)
 		ret = j1939_tp_tx_dat(session, dat, len + 1);
 		if (ret < 0) {
 			/* ENOBUFS == CAN interface TX queue is full */
-			if (ret != -ENOBUFS)
+			if (ret != -ENOBUFS && ret != -ESHUTDOWN)
 				netdev_alert(priv->ndev,
 					     "%s: 0x%p: queue data error: %i\n",
 					     __func__, session, ret);
@@ -1283,7 +1314,7 @@ static int j1939_simple_txnext(struct j1939_session *session)
 
 	can_skb_set_owner(skb, se_skb->sk);
 
-	ret = j1939_send_one(session->priv, skb);
+	ret = j1939_session_tx_send(session, skb);
 	if (ret)
 		goto out_free;
 
@@ -1318,7 +1349,9 @@ static bool j1939_session_deactivate_locked(struct j1939_session *session)
 		active = true;
 
 		list_del_init(&session->active_session_list_entry);
-		session->state = J1939_SESSION_DONE;
+		spin_lock(&session->tx_send_lock);
+		WRITE_ONCE(session->state, J1939_SESSION_DONE);
+		spin_unlock(&session->tx_send_lock);
 		j1939_session_put(session);
 	}
 
@@ -1350,10 +1383,14 @@ j1939_session_deactivate_activate_next(struct j1939_session *session)
 
 static bool j1939_session_fail(struct j1939_session *session, int err)
 {
-	bool deactivate = false;
+	bool deactivate = false, tx_send_shutdown;
 
 	j1939_session_list_lock(session->priv);
-	if (session->state == J1939_SESSION_ACTIVE) {
+	spin_lock(&session->tx_send_lock);
+	tx_send_shutdown = session->tx_send_shutdown;
+	spin_unlock(&session->tx_send_lock);
+	/* Shutdown may precede DONE while a terminal path drains its timers. */
+	if (!tx_send_shutdown && session->state == J1939_SESSION_ACTIVE) {
 		session->err = err;
 		deactivate = j1939_session_deactivate_locked(session);
 	}
@@ -1376,14 +1413,22 @@ static bool __j1939_session_cancel(struct j1939_session *session,
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
 
@@ -1476,6 +1521,9 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 		 * propagation of the error to user space.
 		 */
 		break;
+	case -ESHUTDOWN:
+		/* A terminal state transition won before the frame was sent. */
+		break;
 	case -EOVERFLOW:
 		j1939_session_cancel(session, J1939_XTP_ABORT_ECTS_TOO_BIG);
 		break;
@@ -1881,6 +1929,7 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
 	memcpy(&session->skcb, skcb, sizeof(session->skcb));
 
 	spin_lock_init(&session->txtimer_lock);
+	spin_lock_init(&session->tx_send_lock);
 	spin_lock_init(&session->rxtimer_lock);
 	hrtimer_setup(&session->txtimer, j1939_tp_txtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	hrtimer_setup(&session->rxtimer, j1939_tp_rxtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
@@ -1950,7 +1999,9 @@ int j1939_session_activate(struct j1939_session *session)
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

