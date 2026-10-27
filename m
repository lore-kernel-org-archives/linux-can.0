Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106197;
	b=gVelJWHnY4FABdXQG81BEOJlqaXWVSj9ZlNS6WIHFdEyUwAqymTgLQ52DYIF/4YB9pyd
	 v9TmHwmKv6fxLTCT2kG/gzKXjxjXMCeTCstvw9UJrCfBM+iGLndj6ponHF3x2vdFW8G1Q
	 UtjgvTSu3lI/3BZ+GtFwa7dfJnI5VjAkhcqp2SQriAi+b7pW2nuZktIMatd4F1lq1+I9i
	 pddDsngRKrJN48pUwax+s0tjhMSs+V6yow4kS3i09jkhpjXoBNQXij2rjsEk3BpVI30W+
	 9UjlPszZTlHlecMpX8+2zOFHJ6sCmCZCY72pwL77z5f2pjkXxqRTMOPbOwLWiHDvdhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106197;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2YrX4E4EPrNMMqvumpiT4dSJBsbIcdO6xMC6mvqs/Ug=;
	b=W3WxTXR5FrrZyiZqkUUHuxAs3SoJ/m8OmxzDLbpOwI79vL6inDiF9/HBqpg7yWF54Vxz
	 fU2XNeUC+mtIiq5MS4cj3wbu2cTRzqJHWQAzea9PHjOKeDdZFAZt2PvjjDmiGX5aV/CbJ
	 l5WlAEerPARBt1IJ8vFE/b0cl09kZYsZnN+OhnUhoULCmmTEjvk3fzLkVMutaUAwBJTK3
	 Kb5uFSmMYSMkJX9+nedxEeJAPzIvgf1dsZgxG/Za/MOeWg6avJdyGLr5zRdfF9Awohjeg
	 z2f4GtWPWnuVFfdf2lWeT/Y9dMfcPRlbTZzoBMKOFTEeF+WihEbM58g2MX0rPL4+HEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=MQgGubqm;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22D9606A337
	for <linux-can@vger.kernel.org>; Tue, 27 Oct 2026 13:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C22D9606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=MQgGubqm
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so3053311a91.0
        for <linux-can@vger.kernel.org>; Tue, 27 Oct 2026 06:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1793106196; x=1793710996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2YrX4E4EPrNMMqvumpiT4dSJBsbIcdO6xMC6mvqs/Ug=;
        b=MQgGubqmvpK+mmPj+y7nIPhjfOvUB4S7xEYP/s5BdBUDggX+HCAYKwKHWGhY+zjqrT
         U0nwYfnSJJ6S90QkQpYDKXsK43ctEa/RhybHB1WG9YS3IwVPMpRNdWO20glIBflOKJU1
         jAXud02DDdZWBLofAGA1avbg1G6yghEAoTEHxCiVvHx38oz+56Up6XfmRLzPLMMrmTSc
         VQ3ZW7hKiNc51n5LeK58iq6ko7QwQJ4EAW8PbsMU7ssSv4EUpEbKnSpMlLJwxX/Nlnqt
         IvZ6XZhha4EBSIds3Rx+gozhbj3xbT3E1cX21T+C3g07iYsHilAmFJ76CJP+KcchAOqm
         p32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793106196; x=1793710996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2YrX4E4EPrNMMqvumpiT4dSJBsbIcdO6xMC6mvqs/Ug=;
        b=ck1MH5TBW6Kh1gtde+Jy4T3PzdD0OACLIyLa06IqNOG0to2KnEMkJZMtGe4ZgjpZ6J
         x1wgJp50iljXb/cy6gKOmQ+tGOWGcAU3DZoip5RCSg5ZJdLMYUwMQYMjnM/l6jr24mDx
         Ay6rx6OkAXom1UCZ9SfVW60qQRa8iXAYSXbyEONhbunfkQ1N/RE7GZiwGWpI/zNveTLD
         c6q+yra1FkFky+DcMtJuDmKyMzlY7YY4oOH+lh9u/VucetEZS3u90NYY5frwDoY1ly68
         V9Dr7yznjkG/wxhmqtcyjn25jaCgRiG0/rU1IPD/Pb5LQoEd5IuUN//JBeElHGq21xLU
         yk3g==
X-Forwarded-Encrypted: i=1; AKwUvByrhKSzR5f3keNoXM0TpV6LdrSQTCvODQPoeHQ+fU32wGgv6A+OUgwM+8zIF6fZrCi20VXFXauLU/A=@vger.kernel.org
X-Gm-Message-State: AFq9FYI6cD9A/MB7ZxFNzoBujqKBWax8q2UNL2dE6FH9sgiAfSG2+VdD
	GgfglzYLJMvnnNZipOfG/4CUz/oZ/tixrk0JqQDVbtp+xAb5aEeYRLU5NuMQN/UHTcbr
X-Gm-Gg: AYBFou0RRfknwwRBQ6lZPOU7Mmrlfy4onw1r89py+MvxAqmnmK791R3LzZjOWdLHecE
	j6vlFFwhszJFUwq7AGkVmCORvy2OQlx8vCErmARhgU9d42e5G/xjD7wD8lOobyBoMlmt/76PXqU
	MIBpFBija7QEhsRCla0Sbv5BQWs6uGX1ARBpNjtpf8hWPT812lLnDZMA5K+8bg8z0YnMIa37JOv
	+rrfE7hJ7RcFMtRZEb8LuL4bs5gS5BoHesppl1h35uAgiTXGY6XR0oz2gSrKhzB1wV01E73QBQv
	tXFwnu/4nBwFP42FhatRixwRbVe4862BTK/5BKqotw6TAucvvfx03F85BfGRiBzOx1T/Lt9kVqu
	HIjr5tU0Y2Gd8OrLjxisrBQxFLxhWEajmeMHOeOUtddpyrYgQEHwJO6pYedjl1wQk5I/EcJ7ot9
	h40BsdQu5/Uzsgzm/SjdEofSxDkDi+BldG4vIvzL7eGJooOXMYOhBvwGU4vGPM3gJIar4wuh8aF
	fooSlxmkwIDeJqQ6Turq+5F1DeGTBmGv55VxeYhRJbBUIUqDKroDFExw5a5hUAv+DNIinom+XX2
	eEqv2RGFeuM=
X-Received: by 2002:a17:90b:582d:b0:3ac:c024:b275 with SMTP id 98e67ed59e1d1-3ade9b2ef33mr8088497a91.9.1793106195873;
        Tue, 27 Oct 2026 06:03:15 -0700 (PDT)
Received: from 24c857d0c3be.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae40472ed9sm3940484a91.16.2026.10.27.06.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:03:15 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: mkl@pengutronix.de,
	linux-can@vger.kernel.org
Cc: robin@protonic.nl,
	o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	socketcan@hartkopp.net,
	lkp@intel.com,
	dev.kurt@vandijck-laurijssen.be,
	bst@pengutronix.de,
	maxime.jayat@mobile-devices.fr,
	vega@nebusec.ai,
	zihanx@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH v2 1/1] can: j1939: fix session reference leak on TX timer restart
Date: Tue, 27 Oct 2026 13:03:01 +0000
Message-ID: <c07c904f7c5d36e2ddd2ecaa2e76c4b210b0647e.1793012287.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1793012287.git.zihanx@nebusec.ai>
References: <cover.1793012287.git.zihanx@nebusec.ai>
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

Rearming an active hrtimer only updates its expiry. Taking an additional
session reference on every start can therefore leak sessions.

Serialize TX timer starts and cancellations, reusing the timer reference
when replacing a queued timer. The callback transfers its reference when
it requeues itself, and terminal cancellation prevents a racing callback
from rearming the timer. Schedule a newly activated session after dropping
the socket queue lock so waiting for a callback cannot deadlock activation.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Link: https://bugtracker.nebusec.ai/f/11143
Link: https://lore.kernel.org/all/cover.1792979091.git.zihanx@nebusec.ai/
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 net/can/j1939/Makefile     |   2 +
 net/can/j1939/j1939-priv.h |   7 ++-
 net/can/j1939/socket.c     |  59 ++++++++++++----------
 net/can/j1939/transport.c  | 100 ++++++++++++++++++++++++++++---------
 4 files changed, 118 insertions(+), 50 deletions(-)

diff --git a/net/can/j1939/Makefile b/net/can/j1939/Makefile
index 19181bdae173..113595c25730 100644
--- a/net/can/j1939/Makefile
+++ b/net/can/j1939/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_CAN_J1939) += can-j1939.o
 
 can-j1939-objs := \
diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index cf26352d1d8c..8d00eb800d47 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -10,6 +10,7 @@
 #define _J1939_PRIV_H_
 
 #include <linux/can/j1939.h>
+#include <linux/spinlock.h>
 #include <net/sock.h>
 
 /* Timeout to receive the abort signal over loop back. In case CAN
@@ -289,7 +290,11 @@ struct j1939_session {
 		/* dpo - ETP.CM_DPO, Data Packet Offset */
 		unsigned int dpo;
 	} pkt;
-	struct hrtimer txtimer, rxtimer;
+	/* Protects TX timer rearming and cancellation. */
+	spinlock_t txtimer_lock;
+	struct hrtimer txtimer __guarded_by(&txtimer_lock);
+	struct hrtimer rxtimer;
+	bool txtimer_shutdown;
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
index 8fcfd13e5e6f..4a2e986023d8 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -9,6 +9,7 @@
 //                         Oleksij Rempel <kernel@pengutronix.de>
 
 #include <linux/can/skb.h>
+#include <linux/cleanup.h>
 #include <net/can.h>
 
 #include "j1939-priv.h"
@@ -303,7 +304,13 @@ void j1939_session_put(struct j1939_session *session)
 
 static void j1939_session_txtimer_cancel(struct j1939_session *session)
 {
-	if (hrtimer_cancel(&session->txtimer))
+	int ret;
+
+	spin_lock_bh(&session->txtimer_lock);
+	ret = hrtimer_cancel(&session->txtimer);
+	spin_unlock_bh(&session->txtimer_lock);
+
+	if (ret)
 		j1939_session_put(session);
 }
 
@@ -315,6 +322,7 @@ static void j1939_session_rxtimer_cancel(struct j1939_session *session)
 
 void j1939_session_timers_cancel(struct j1939_session *session)
 {
+	WRITE_ONCE(session->txtimer_shutdown, true);
 	j1939_session_txtimer_cancel(session);
 	j1939_session_rxtimer_cancel(session);
 }
@@ -716,9 +724,27 @@ static int j1939_xtp_tx_abort(struct j1939_priv *priv,
 
 void j1939_tp_schedule_txtimer(struct j1939_session *session, int msec)
 {
-	j1939_session_get(session);
+	int ret;
+
+	spin_lock_bh(&session->txtimer_lock);
+	if (READ_ONCE(session->txtimer_shutdown))
+		goto out_unlock;
+
+	/* Reuse the timer reference when cancelling a queued timer. */
+	ret = hrtimer_cancel(&session->txtimer);
+	if (READ_ONCE(session->txtimer_shutdown)) {
+		spin_unlock_bh(&session->txtimer_lock);
+		if (ret)
+			j1939_session_put(session);
+		return;
+	}
+	if (!ret)
+		j1939_session_get(session);
 	hrtimer_start(&session->txtimer, ms_to_ktime(msec),
 		      HRTIMER_MODE_REL_SOFT);
+
+out_unlock:
+	spin_unlock_bh(&session->txtimer_lock);
 }
 
 static inline void j1939_tp_set_rxtimeout(struct j1939_session *session,
@@ -730,7 +756,8 @@ static inline void j1939_tp_set_rxtimeout(struct j1939_session *session,
 		      HRTIMER_MODE_REL_SOFT);
 }
 
-static int j1939_session_tx_rts(struct j1939_session *session)
+static int j1939_session_tx_rts(struct j1939_session *session,
+				unsigned int *txtimer_delay)
 {
 	u8 dat[8];
 	int ret;
@@ -766,7 +793,7 @@ static int j1939_session_tx_rts(struct j1939_session *session)
 
 	session->last_txcmd = dat[0];
 	if (dat[0] == J1939_TP_CMD_BAM) {
-		j1939_tp_schedule_txtimer(session, 50);
+		*txtimer_delay = 50;
 		j1939_tp_set_rxtimeout(session, 250);
 	} else {
 		j1939_tp_set_rxtimeout(session, 1250);
@@ -806,7 +833,8 @@ static int j1939_session_tx_dpo(struct j1939_session *session)
 	return 0;
 }
 
-static int j1939_session_tx_dat(struct j1939_session *session)
+static int j1939_session_tx_dat(struct j1939_session *session,
+				unsigned int *txtimer_delay)
 {
 	struct j1939_priv *priv = session->priv;
 	struct j1939_sk_buff_cb *se_skcb;
@@ -870,7 +898,7 @@ static int j1939_session_tx_dat(struct j1939_session *session)
 			j1939_tp_packet_delay;
 
 		if (session->pkt.tx < session->pkt.total && pdelay) {
-			j1939_tp_schedule_txtimer(session, pdelay);
+			*txtimer_delay = pdelay;
 			break;
 		}
 	}
@@ -887,7 +915,8 @@ static int j1939_session_tx_dat(struct j1939_session *session)
 	return ret;
 }
 
-static int j1939_xtp_txnext_transmiter(struct j1939_session *session)
+static int j1939_xtp_txnext_transmiter(struct j1939_session *session,
+				       unsigned int *txtimer_delay)
 {
 	struct j1939_priv *priv = session->priv;
 	int ret = 0;
@@ -900,7 +929,7 @@ static int j1939_xtp_txnext_transmiter(struct j1939_session *session)
 
 	switch (session->last_cmd) {
 	case 0:
-		ret = j1939_session_tx_rts(session);
+		ret = j1939_session_tx_rts(session, txtimer_delay);
 		break;
 
 	case J1939_ETP_CMD_CTS:
@@ -915,7 +944,7 @@ static int j1939_xtp_txnext_transmiter(struct j1939_session *session)
 	case 0xff: /* did some data */
 	case J1939_ETP_CMD_DPO:
 	case J1939_TP_CMD_BAM:
-		ret = j1939_session_tx_dat(session);
+		ret = j1939_session_tx_dat(session, txtimer_delay);
 
 		break;
 	default:
@@ -1180,13 +1209,14 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 	struct j1939_session *session =
 		container_of(hrtimer, struct j1939_session, txtimer);
 	struct j1939_priv *priv = session->priv;
+	unsigned int txtimer_delay = 0;
 	int ret = 0;
 
 	if (session->skcb.addr.type == J1939_SIMPLE) {
 		ret = j1939_simple_txnext(session);
 	} else {
 		if (session->transmission)
-			ret = j1939_xtp_txnext_transmiter(session);
+			ret = j1939_xtp_txnext_transmiter(session, &txtimer_delay);
 		else
 			ret = j1939_xtp_txnext_receiver(session);
 	}
@@ -1196,8 +1226,7 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 		/* Retry limit is currently arbitrary chosen */
 		if (session->tx_retry < J1939_XTP_TX_RETRY_LIMIT) {
 			session->tx_retry++;
-			j1939_tp_schedule_txtimer(session,
-						  10 + get_random_u32_below(16));
+			txtimer_delay = 10 + get_random_u32_below(16);
 		} else {
 			netdev_alert(priv->ndev, "%s: 0x%p: tx retry count reached\n",
 				     __func__, session);
@@ -1232,6 +1261,12 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 		}
 	}
 
+	if (txtimer_delay && !READ_ONCE(session->txtimer_shutdown)) {
+		hrtimer_start(hrtimer, ms_to_ktime(txtimer_delay),
+			      HRTIMER_MODE_REL_SOFT);
+		return HRTIMER_NORESTART;
+	}
+
 	j1939_session_put(session);
 
 	return HRTIMER_NORESTART;
@@ -1540,8 +1575,12 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
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
@@ -2234,24 +2273,37 @@ void j1939_simple_recv(struct j1939_priv *priv, struct sk_buff *skb)
 
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
+	for (;;) {
+		session = NULL;
+		j1939_session_list_lock(priv);
+		list_for_each_entry(iter, &priv->active_session_list,
+				    active_session_list_entry) {
+			if (sk && sk != iter->sk)
+				continue;
+
+			/* Keep the session alive while cancellation waits for the
+			 * TX timer callback outside active_session_list_lock.
+			 */
+			session = iter;
+			j1939_session_get(session);
+			WRITE_ONCE(session->txtimer_shutdown, true);
 			if (hrtimer_try_to_cancel(&session->rxtimer) == 1)
 				j1939_session_put(session);
-
 			session->err = ESHUTDOWN;
 			j1939_session_deactivate_locked(session);
+			break;
 		}
+		j1939_session_list_unlock(priv);
+
+		if (!session)
+			break;
+
+		j1939_session_txtimer_cancel(session);
+		j1939_session_put(session);
 	}
-	j1939_session_list_unlock(priv);
 	return NOTIFY_DONE;
 }
 
-- 
2.43.0

