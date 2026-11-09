Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794230207;
	b=0wzd3qh624SKqw0FRGdfn5g6nNiLH4BUyMb/c+PTA/KPiiTmLdZ3GWFDuyYuzkpMqREN
	 z/TRtYyfrRbNe9X4daDJ76YKfd0zKSrjyB2An4wdDYTjNa6QWrDxGykltsXX0LllSMkp4
	 FpmhLQcA+m/dEI32oKoTjTsc0J+M0Sth/Cp7cD8zollgLs3VSmQ6s3WFbwSX2DskKy3Ge
	 uW3IGW9JMDt5PjdVLD+FCgOiHhZMIHwNSABUIwxfLFNrWIvQDfEHQp99vNnuieCdeBlP8
	 UknoUdI0h1HzK+anGxRn3a+XqGAKPsIqDsMPQcoa5WRvnTUOAQ5UrPVnNOL4yFV3CIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794230207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HfwmzgBVbP4RE3XlnnY0kmE2F8lrR9rQJL5FCax2miY=;
	b=yanPN7NOUFcVtioCMtHEfFfXwmGodMEBQA0uMR9vqZV+xr6VEdUfakhAxT2+2t9XWGB5
	 9T6kiD3YIFgCYj1/5paIgKC9f5Ggtr1d1kFTdGqyNQTzKFy3stl8ELKRQGNQqF6ZH9tf1
	 mk9FdxVjIJdtAS+8h7wYWFszrlST4u3lTasT04JSv3B2bbqEMsv5Krcr5K5Wm7Uqfp7l5
	 riZPwz6ykYAtX5JzJYmea1NXEeInCkxEX+5kYU4Atu5kAOt2GOZqee+7BbtT9yUvDIiPd
	 eP6tRbl+m2721mN+7bG0MboP8p6a1K2Bt3RusMCx3U5Txuqtcm7NG27oSNnWnYiZCwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=k4QAicDF;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB484606A32A
	for <linux-can@vger.kernel.org>; Mon,  9 Nov 2026 13:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB484606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=k4QAicDF
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdb681de50eso248073a12.2
        for <linux-can@vger.kernel.org>; Mon, 09 Nov 2026 05:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1794230206; x=1794835006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HfwmzgBVbP4RE3XlnnY0kmE2F8lrR9rQJL5FCax2miY=;
        b=k4QAicDFNFoBFc9YGvHhUEQCrivXH3Qb78claVIrHJ9BC0QClL5bR+Pp5EIIv2qNQO
         FXdfKk5QHC6Qb4L8CU2w8Gh4w1zulzT90yyozfscQpBQXADF9EFpXjsuSEDnp3ZsnVIK
         3gM9Y2jLv1HTpXuFyiFOiUzjPc5IAfwI6oHyy3MsYhC3+SzjiW2BgC2YIpzUu6pOh+LU
         fMyq55/RpQre2Ot9cv5IA87e4oVo5hF4alL+1EkANKxVusLABQKiXH97LJ04OJUDxIEw
         gjUJIfeLvADLgj8nnikxpM/eZ8DSEjj6mXeDJatMZRtLqCWwGSlUueawqo6hge45rPnf
         xR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794230206; x=1794835006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HfwmzgBVbP4RE3XlnnY0kmE2F8lrR9rQJL5FCax2miY=;
        b=CjKYi6SQU240DJ/Rrf3c4Ct0snaYMv+UQWgX7uXM9WINMHPeyJlh8lGgatD/txTdjk
         WtFg1LgBTqlgxq1a9mJAX5aYsIr/i4BMKztTsHDKMHEmOcYIUzbMStx1xXTIis6miMv7
         jMW3u/HKh073eiAROZjSAzekXqmhlJn3FHblL4zZ7t1aWkLmnDLJ0nxieTaqIx44vO3b
         Lxed5l7oZLdjQzx7PXCFHOA2ehakM/pqM//88316xHJYeEaqzdXHzud3FAhxNBsjUb/f
         N5BnBOaTyfN8yC81vSsjUldgK2WDvW4h3I7cSMNSrcnqWk+Bk5aMBIC1+36LnqUXKBmD
         Nwag==
X-Gm-Message-State: APuU4Z+epMrXo+Bp9hpWzNXgEgSrg+dbbTErsoQ1k+TM0dQHlxyLSqkx
	1+CvLdNzDAbzND9gw+EoLc67Y84ebmUXWGynN9vusbIq/G31AvS7myKATaTvH4vRiti8SOQ33lp
	vr9icIw8V
X-Gm-Gg: AYBFou03EH97IhzcRBh7hyXSodgo7zBmWZFb5gU7adkjNfpNHAxEjlTcs+oBLrdXtbw
	AoKJONTjxAysEpFN8QroIxcx1HSU01KZ6WfgFqdztQx69S1t32wpPghkrh4HvMwnSydOSilF2lg
	jJc7dzfs7dWIBbmN2BFHSYPuxs3JK/kmFdEOzAlgsXQrvQzp7CQMCWD/WzhTnOoZv6lRt0RmTjF
	BmsFozEuH9W4BzAqSN06swo/vgvF49dKFGvhhMGOZ20L15S454TZDyoxcBgYYGeOTN9zf2Fc/Iy
	iHcLJod7mClfMLFZoMRIZ9s+jLH3i8CeQVm6/1zxNBoZ2WejW46WeKLN2T3gp14Br51WEjgKPhV
	jhmBmqZnkwtwg+dUvRgr6+K8k4Ml5ZLJwpYmXXJZKvDoTh2XeU3lOX45ymJGO1cQVvKM7V21iTO
	j6mQ0g20UmkDRM+v9XQ8UvK0mmpMWsM1rScRLiFHXC0WgFoGUgOU4nuDyewUBL2zILqronI2yXt
	4AVcNPhkYwoPtRdx1g9beYb/aHVqXUdQpz9qCmwIBXEWcmD1MHrMPP4EuS+sVgEB8Os+H90l9VW
	Slqu4Cj92LimZCK05xIs3vOpibWIonIQGWX9an3myvo01q8eYRPUyVTYzXpR
X-Received: by 2002:a17:903:2344:b0:2ed:352d:c623 with SMTP id d9443c01a7336-2ed83759ee9mr42689765ad.32.1794230206064;
        Mon, 09 Nov 2026 05:16:46 -0800 (PST)
Received: from 24c857d0c3be.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed815e7416sm11221095ad.17.2026.11.09.05.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:16:44 -0800 (PST)
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
Subject: [PATCH net v8 2/2] can: j1939: serialize TX with session shutdown
Date: Mon,  9 Nov 2026 13:16:24 +0000
Message-ID: <20261109131624.276943-3-zihanx@nebusec.ai>
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
index c327fd9618a0..4458b8306743 100644
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
 j1939_session_shutdown_intent_locked(struct j1939_session *session)
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

