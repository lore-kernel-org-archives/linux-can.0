Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263496;
	b=r2FbphddfAV5UA9QK08NrnYHUDYIumuWy8kLmhgDR75VQFOa/XyRQnYsVacEKLyx/1B2
	 sK39ho9hFXIy4ABzCcTdQXB9SjfIkzBvTUrhLulf1TNxEzgsHDUdMmpLJ5Sd6SwBFQGBC
	 i0sSrRPTtUxcHW+Gv2WASdy8eYUuxUx5MPz2zkFKDkvLx1SapsmlbZjHyt8/VyljDc0dM
	 oThYfDuJh2b4mJU1vwjklF2zM9OD9RTN6pBMdV/6ffyijc5AylbR2bu9JzC+FIVjyIyyh
	 ovwbSt8c4zPJ5dMRvKiPNIMnnSouQjKxJAvUdkBHyyEcMKLAxM8WfttZh+hycg4Gq/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263496;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lFsOXZPVg55OToMCBlhdUR7p0rTf9s8fzuXbbNMm4lg=;
	b=eqQRxEkEXnQFcaVHfUbxLJVNAkkc7TDxSMqerWYuUVjGsbbfT5QhI7jGvI+rvZm/4cOF
	 b08AWB0bJ2FbFcXM9RY5YwjRC+AYtSb9CMrdVHiAV31MUOwo0HbA85wxBMyAHlb5+YOWV
	 so0J5DpnT7tYxx8kiOj/NYPPyNUkBX16B/ajPHbE8z6HsSdq/rLMrjYK6tNsebQZGzHoP
	 /Gw9eDTxxuc6WROotL4X3apO9mFLILonTGD/Q9itm7Wy3LsbHA47/xPWYhACCpiNY3YYO
	 6KFg55Y/i/h74a5vE9geIcvOrBBBsDx8GRPV4Dy2v8GY4WPzBE5zIsALOdOljhbZHfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=HQlzw2+O;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9CC606A31A
	for <linux-can@vger.kernel.org>; Thu, 29 Oct 2026 08:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E9CC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=HQlzw2+O
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc758830601so1233010a12.2
        for <linux-can@vger.kernel.org>; Thu, 29 Oct 2026 01:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1793263495; x=1793868295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lFsOXZPVg55OToMCBlhdUR7p0rTf9s8fzuXbbNMm4lg=;
        b=HQlzw2+OxWNe7FL4pmVJl9mMHDOANw44yWNlo9e0bYpBmIga3AfwhxFd3OYEXp4GA9
         USwAoiiPodQ0dthvW1T4sGxd6H8UF1jbHgFLNJRjNnqaUMqyszIhPS+rfhp/0Xu9Y70o
         mhYT/sVRhz5j16cVovQcAFueLB+SONYOV/XB/6EDI8kHRs3iQ0MyrmiWpKnxxxeKz37E
         7gXoS6UNssmEwlYFsSsKr11+TLE0JoFhbqsBC6cCriz8F56y+MutoYkJ+sr1ZH8JFCoI
         yHMN4rjxAKH8N7ThDjFZT3Ae+mAE3dx6XMT5aaEWfgEBX5WwL2N6hsCfa9gMAzByQR1A
         sPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793263495; x=1793868295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lFsOXZPVg55OToMCBlhdUR7p0rTf9s8fzuXbbNMm4lg=;
        b=CjKBn1KBPf5l9wZfBHsIWUvJg7Es4z1v+3g1JOUWInZ581dQJRWX0LBP1kKte5Aqhf
         wg9JmpoWewFxwz0m+Sx77/Hz14qfBwYzvDcIc6Du8TH08zvdNkJI5KbxfzEuAED1PWgZ
         uUw11zNBBdhQOyGZrLXlp779BZuEJvf8mfzUCp4I8HDLwz9d+T+oEBkW51Z/NRaYTbQS
         qVuObDAZflYiYdzPNGuNsqvI9I2EmsjElZgVnGRYrbq2XT0pWjIiVRlakGdQEPvo7+7r
         OVX7+cPGWPVFIv0eUAnwWA+6GqTrmj9iwF4ff8GYK5f2nDTOxKTd04QyQQLMHjGaAsgI
         l68g==
X-Gm-Message-State: AFq9FYLOBVs5uhay1Zy8JBsWgTCQgZU7HDJHWzJ91e6ZkMxZ6xcJ8h3u
	PNro7OnaKRHDFo2m47MWi2TA60qxLnq83i6yGYGycy2b/msbi8j+UA/HTPHLMeDexaUltRUGFxW
	cvVqjxaPD
X-Gm-Gg: AYBFou3ByKMMzmv3+ESLAAMGMhpOExqFCXjrXI/rUh3D9qiEJxtoARUJsaizwHeNtVG
	D+VNA6/X8bLQqDoOBN3l7SI3nOGV+eDMvqq0eVsgDuFIGYIOvXvFtR1cdNW4kuxCzD7wYVPQv1h
	OvecKvT6wuBghy6YF3qo2dDQ9NB4ZvUvxhOOh8U+T/QGL1M+ZjZRVjsuEAnnHmdXs4O0awmp4TX
	jaM6UJ1E/bVYBSMIj+gTKJQY6kaTqfbpL4vy9Cu5ApnIC87lpQqcQy0hnxks/zcvAuL/x36oD+/
	SCibTZS7oSsACvPCjNmr+hbuJk+2wQa/T7rmqu7wGYZ5oFt8sl5UgvZoGTajUEsI26tTA7A3tZN
	+KEYFdAr7Rx2vx8IfFC7V9Dcy9a+tyXrewZvkCLPeXEJgaW8xQCBeWC6n7yLaJeqrmlpv0nH26Q
	tPM/RqPGxsAMAvrkTIzD58UzBZyjIuf6KC8aiIbbQC6xVrJCT0oCU5Lmzi9DMd7ca5cV0MchZsO
	jtkm5XG4LKG06b0ML6R5T7SA4CQULvCaF8ny9jc7y57RjZ1+NpVXFpC4SG/gd581dOt5qH28xo0
	4M4g6q1vfyKDuyi34G6tkSg/bKXTc9MAk3DhBrRTcZimXw6vnC9P2aRoF2Ig
X-Received: by 2002:a05:6a20:e390:b0:3e2:6f90:b544 with SMTP id adf61e73a8af0-3e901e78e5bmr4175756637.0.1793263495268;
        Thu, 29 Oct 2026 01:44:55 -0700 (PDT)
Received: from 24c857d0c3be.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdad33b99b2sm3083915a12.26.2026.10.29.01.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 01:44:54 -0700 (PDT)
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
Subject: [PATCH net v3 2/3] can: j1939: stop TX sends after session shutdown
Date: Thu, 29 Oct 2026 08:43:25 +0000
Message-ID: <a683b6afb2c21e0d05be0ebe18c4f60b98152d25.1793259424.git.zihanx@nebusec.ai>
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

Serialize session data and control frame transmission with transitions
that shut down a session. This prevents a timer callback from sending
after the session is deactivated or an incoming ABORT starts draining
its timers.

Also suppress the callback-generated XTP ABORT frame once RX ABORT has
closed the session send gate.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org

Link: https://bugtracker.nebusec.ai/f/11143
Link: https://lore.kernel.org/all/cover.1793012287.git.zihanx@nebusec.ai/
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 net/can/j1939/j1939-priv.h | 10 ++++--
 net/can/j1939/transport.c  | 68 +++++++++++++++++++++++++++++++++-----
 2 files changed, 66 insertions(+), 12 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index c0a4c1478240..6bf55b7dfffc 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -238,6 +238,10 @@ struct j1939_session {
 	struct list_head sk_session_queue_entry;
 	struct kref kref;
 	struct sock *sk;
+	/* Serializes session TX sends against transition to DONE. */
+	spinlock_t tx_send_lock;
+	bool tx_send_shutdown;
+
 	/* ifindex, src, dst, pgn define the session block
 	 * the are _never_ modified after insertion in the list
 	 * this decreases locking problems a _lot_
@@ -289,22 +293,22 @@ struct j1939_session {
 		/* dpo - ETP.CM_DPO, Data Packet Offset */
 		unsigned int dpo;
 	} pkt;
+	/* Protects TX timer rearming and cancellation. */
+	spinlock_t txtimer_lock;
 	/*
 	 * qref pins the queued timer; cbref pins a running callback. A
 	 * concurrent rearm can leave both references outstanding.
 	 */
-	/* Protects TX timer rearming and cancellation. */
-	spinlock_t txtimer_lock;
 	struct hrtimer txtimer;
 	bool txtimer_qref;
 	bool txtimer_cbref;
 	bool txtimer_cb_running;
 	bool txtimer_shutdown;
-	/* RX timer state and refs below use active_session_list_lock. */
 	struct hrtimer rxtimer;
 	bool rxtimer_qref;
 	bool rxtimer_cbref;
 	bool rxtimer_cb_running;
+	/* RX timer state and refs below use active_session_list_lock. */
 	/* Temporary drains defer rearming; the last drain installs the pending timeout. */
 	unsigned int rxtimer_cancelers;
 	bool rxtimer_pending;
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 0dd08d1b8f75..570e2b8d0826 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -763,6 +763,29 @@ sk_buff *j1939_tp_tx_dat_new(struct j1939_priv *priv,
 	return skb;
 }
 
+static int j1939_session_tx_send(struct j1939_session *session,
+				 struct sk_buff *skb)
+{
+	enum j1939_session_state state;
+	int ret;
+
+	spin_lock_bh(&session->tx_send_lock);
+	j1939_session_list_lock(session->priv);
+	state = session->state;
+	j1939_session_list_unlock(session->priv);
+	if (session->tx_send_shutdown || state != J1939_SESSION_ACTIVE) {
+		kfree_skb(skb);
+		ret = -ESHUTDOWN;
+		goto out_unlock;
+	}
+
+	ret = j1939_send_one(session->priv, skb);
+
+out_unlock:
+	spin_unlock_bh(&session->tx_send_lock);
+	return ret;
+}
+
 /* TP transmit packet functions */
 static int j1939_tp_tx_dat(struct j1939_session *session,
 			   const u8 *dat, int len)
@@ -779,10 +802,11 @@ static int j1939_tp_tx_dat(struct j1939_session *session,
 	if (j1939_tp_padding && len < 8)
 		memset(skb_put(skb, 8 - len), 0xff, 8 - len);
 
-	return j1939_send_one(priv, skb);
+	return j1939_session_tx_send(session, skb);
 }
 
-static int j1939_xtp_do_tx_ctl(struct j1939_priv *priv,
+static int j1939_xtp_do_tx_ctl(struct j1939_session *session,
+			       struct j1939_priv *priv,
 			       const struct j1939_sk_buff_cb *re_skcb,
 			       bool swap_src_dst, pgn_t pgn, const u8 *dat)
 {
@@ -802,6 +826,9 @@ static int j1939_xtp_do_tx_ctl(struct j1939_priv *priv,
 	skdat[6] = (pgn >> 8);
 	skdat[7] = (pgn >> 16);
 
+	if (session)
+		return j1939_session_tx_send(session, skb);
+
 	return j1939_send_one(priv, skb);
 }
 
@@ -810,7 +837,7 @@ static inline int j1939_tp_tx_ctl(struct j1939_session *session,
 {
 	struct j1939_priv *priv = session->priv;
 
-	return j1939_xtp_do_tx_ctl(priv, &session->skcb,
+	return j1939_xtp_do_tx_ctl(session, priv, &session->skcb,
 				   swap_src_dst,
 				   session->skcb.addr.pgn, dat);
 }
@@ -829,7 +856,7 @@ static int j1939_xtp_tx_abort(struct j1939_priv *priv,
 	memset(dat, 0xff, sizeof(dat));
 	dat[0] = J1939_TP_CMD_ABORT;
 	dat[1] = err;
-	return j1939_xtp_do_tx_ctl(priv, re_skcb, swap_src_dst, pgn, dat);
+	return j1939_xtp_do_tx_ctl(NULL, priv, re_skcb, swap_src_dst, pgn, dat);
 }
 
 static void j1939_tp_schedule_txtimer_locked(struct j1939_session *session,
@@ -842,7 +869,6 @@ static void j1939_tp_schedule_txtimer_locked(struct j1939_session *session,
 	if (session->txtimer_shutdown)
 		return;
 
-	/* Replace the queued pin; a running callback retains its separate pin. */
 	ret = hrtimer_try_to_cancel(&session->txtimer);
 	if (ret == 1) {
 		/* Reuse the pin owned by the removed queued timer. */
@@ -1269,7 +1295,6 @@ static int j1939_xtp_txnext_receiver(struct j1939_session *session)
 
 static int j1939_simple_txnext(struct j1939_session *session)
 {
-	struct j1939_priv *priv = session->priv;
 	struct sk_buff *se_skb = j1939_session_skb_get(session);
 	struct sk_buff *skb;
 	int ret;
@@ -1298,7 +1323,7 @@ static int j1939_simple_txnext(struct j1939_session *session)
 
 	j1939_tp_set_rxtimeout(session, J1939_SIMPLE_ECHO_TIMEOUT_MS);
 
-	ret = j1939_send_one(priv, skb);
+	ret = j1939_session_tx_send(session, skb);
 	if (ret)
 		goto out_free;
 
@@ -1318,6 +1343,7 @@ static bool j1939_session_deactivate_locked(struct j1939_session *session)
 {
 	bool active = false;
 
+	lockdep_assert_held(&session->tx_send_lock);
 	lockdep_assert_held(&session->priv->active_session_list_lock);
 
 	if (session->state >= J1939_SESSION_ACTIVE &&
@@ -1333,14 +1359,23 @@ static bool j1939_session_deactivate_locked(struct j1939_session *session)
 	return active;
 }
 
+static void j1939_session_tx_send_shutdown(struct j1939_session *session)
+{
+	spin_lock_bh(&session->tx_send_lock);
+	session->tx_send_shutdown = true;
+	spin_unlock_bh(&session->tx_send_lock);
+}
+
 static bool j1939_session_deactivate(struct j1939_session *session)
 {
 	struct j1939_priv *priv = session->priv;
 	bool active;
 
+	spin_lock_bh(&session->tx_send_lock);
 	j1939_session_list_lock(priv);
 	active = j1939_session_deactivate_locked(session);
 	j1939_session_list_unlock(priv);
+	spin_unlock_bh(&session->tx_send_lock);
 
 	if (active) {
 		j1939_session_txtimer_cancel_async(session);
@@ -1363,12 +1398,14 @@ static void __j1939_session_cancel(struct j1939_session *session,
 	struct j1939_priv *priv = session->priv;
 
 	WARN_ON_ONCE(!err);
+	lockdep_assert_held(&session->tx_send_lock);
 	lockdep_assert_held(&session->priv->active_session_list_lock);
 
 	session->err = j1939_xtp_abort_to_errno(priv, err);
 	session->state = J1939_SESSION_WAITING_ABORT;
 	/* do not send aborts on incoming broadcasts */
-	if (!j1939_cb_is_broadcast(&session->skcb)) {
+	if (!session->tx_send_shutdown &&
+	    !j1939_cb_is_broadcast(&session->skcb)) {
 		j1939_xtp_tx_abort(priv, &session->skcb,
 				   !session->transmission,
 				   err, session->skcb.addr.pgn);
@@ -1381,6 +1418,7 @@ static void __j1939_session_cancel(struct j1939_session *session,
 static void j1939_session_cancel(struct j1939_session *session,
 				 enum j1939_xtp_abort err)
 {
+	spin_lock_bh(&session->tx_send_lock);
 	j1939_session_list_lock(session->priv);
 
 	if (session->state >= J1939_SESSION_ACTIVE &&
@@ -1391,6 +1429,7 @@ static void j1939_session_cancel(struct j1939_session *session,
 	}
 
 	j1939_session_list_unlock(session->priv);
+	spin_unlock_bh(&session->tx_send_lock);
 
 	if (!session->sk)
 		j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
@@ -1408,7 +1447,6 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 	int ret = 0;
 
 	spin_lock_bh(&session->txtimer_lock);
-	/* A concurrent rearm may already have recorded the callback pin. */
 	if (!session->txtimer_cbref) {
 		WARN_ON_ONCE(session->txtimer_cb_running);
 		WARN_ON_ONCE(!session->txtimer_qref);
@@ -1460,6 +1498,9 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 		 * propagation of the error to user space.
 		 */
 		break;
+	case -ESHUTDOWN:
+		/* A terminal path won before this packet could be sent. */
+		break;
 	case -EOVERFLOW:
 		j1939_session_cancel(session, J1939_XTP_ABORT_ECTS_TOO_BIG);
 		break;
@@ -1558,6 +1599,7 @@ static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
 		/* The message is probably stuck in the CAN controller and can
 		 * be send as soon as CAN bus is in working state again.
 		 */
+		spin_lock_bh(&session->tx_send_lock);
 		j1939_session_list_lock(priv);
 		if (session->state >= J1939_SESSION_ACTIVE &&
 		    session->state < J1939_SESSION_ACTIVE_MAX) {
@@ -1565,9 +1607,11 @@ static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
 			j1939_session_deactivate_locked(session);
 		}
 		j1939_session_list_unlock(priv);
+		spin_unlock_bh(&session->tx_send_lock);
 		j1939_session_txtimer_cancel_async(session);
 		j1939_session_rxtimer_cancel(session);
 	} else {
+		spin_lock_bh(&session->tx_send_lock);
 		j1939_session_list_lock(session->priv);
 		if (!session->rxtimer_cancelers &&
 		    session->state >= J1939_SESSION_ACTIVE &&
@@ -1579,6 +1623,7 @@ static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
 			__j1939_session_cancel(session, J1939_XTP_ABORT_TIMEOUT);
 		}
 		j1939_session_list_unlock(session->priv);
+		spin_unlock_bh(&session->tx_send_lock);
 
 		if (!session->sk)
 			j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
@@ -1671,6 +1716,8 @@ static void j1939_xtp_rx_abort_one(struct j1939_priv *priv, struct sk_buff *skb,
 		    session, j1939_xtp_ctl_to_pgn(skb->data), abort,
 		    j1939_xtp_abort_to_str(abort));
 
+	/* Stop TX callbacks before waiting for the timer callbacks to drain. */
+	j1939_session_tx_send_shutdown(session);
 	j1939_session_timers_cancel(session);
 	j1939_session_list_lock(priv);
 	if (session->state >= J1939_SESSION_ACTIVE &&
@@ -1843,6 +1890,7 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(&session->skcb, skcb, sizeof(session->skcb));
 
+	spin_lock_init(&session->tx_send_lock);
 	scoped_guard(spinlock_init, &session->txtimer_lock) {
 		hrtimer_setup(&session->txtimer, j1939_tp_txtimer,
 			      CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
@@ -2561,6 +2609,7 @@ int j1939_cancel_active_session(struct j1939_priv *priv, struct sock *sk)
 		if (!session)
 			break;
 
+		spin_lock_bh(&session->tx_send_lock);
 		j1939_session_list_lock(priv);
 		if (session->state >= J1939_SESSION_ACTIVE &&
 		    session->state < J1939_SESSION_ACTIVE_MAX) {
@@ -2568,6 +2617,7 @@ int j1939_cancel_active_session(struct j1939_priv *priv, struct sock *sk)
 			j1939_session_deactivate_locked(session);
 		}
 		j1939_session_list_unlock(priv);
+		spin_unlock_bh(&session->tx_send_lock);
 
 		/* No state lock is held while waiting for either softirq timer. */
 		j1939_session_txtimer_cancel(session);
-- 
2.43.0

