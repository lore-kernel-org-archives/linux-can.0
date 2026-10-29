Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263502;
	b=44I+EDdSa2wzWlQ7XkH25xzQ9lCOFlKyfAGoWKaYgZPU+SxI4oNe/cev3ukz+/CvaDmO
	 FTNBwWyUSJuYPEQyPHkakHLHzaeh/8sandGeSqenKJUzFngyDYmKWonyXSqUIxciFrSqS
	 hhwvVcIxSGKwFbFeu/nZWzta9SufdqD8F9AcEUEF6Fb6P/AVQqVrfF4U4VHop4ZVMoL+A
	 MZvkAZDFNSCrlyGkEjxrytwet0EDLnCRRJL+iNEz8Fc3Q0gzUU2GW68rzkhNfB1SWaRy4
	 2AGF9bc1M/VO8eEcNu2CM7OeqeXC2Jou0sUpWbdffuB+5y5TLPxe/oZFTVMZOM+SqmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263502;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SoQZ6Rn/231FVhlbAImWqe7u6be9TgKTmZprNFAFk2s=;
	b=fF/rDrzSm460h+iM88d9iiZUTx32vqSfSFTUTeaxD0/8xqlk5a5wWWA0/KP38perJxxJ
	 qxnC8Pl96O/ZfSjljFghYcO2WY+VcQWov1092mU2MEdFMXTw3fCHgaV6pnI4p0owcZRAQ
	 HdVxAPxtu7HpFsoUdWTwNEjxHg8deTTYK2JpAWux7Fn1Rb7jDuRsQgLFPJMM7Ziis3zCk
	 BtjS9pynIPfWBKqimKb9cEoBzwyD7kUFg/5CimHwe4LmPKq6weU3oL279oLoW6OSxJzzy
	 FIUNX8IT1nZJVRO+/AgVtPjRWWT/ROoufl6p4J0gIA4Gk/lLoH6HqZi193ut80Zs9EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=aKHj8Hwg;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB95606A31C
	for <linux-can@vger.kernel.org>; Thu, 29 Oct 2026 08:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FB95606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=aKHj8Hwg
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a06c60065fso1476190b3a.1
        for <linux-can@vger.kernel.org>; Thu, 29 Oct 2026 01:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1793263501; x=1793868301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SoQZ6Rn/231FVhlbAImWqe7u6be9TgKTmZprNFAFk2s=;
        b=aKHj8HwgeD2vMHjhtIBSVildfiiSxm8wGS0nus+eDfGMXk+01eabGFy8E5SlvvtLPr
         OA8/DaMj4T7kHODYZcIWx42KWo6AI7swv3Qih74SvZCYBTWyZ32bp6k23185fEuGiZpI
         jb3CdAk26dnclVO9ZcW9bbQfxxOUT7/zbVW8Lt5+4hXTW0Sp4VAHyeomCtI6hGaKL7sD
         5uF7NcYY+uEunF2PqhW1Oz+j2zcBm9Sz6BzKVTdHFhvkCAD/7L4Hlyv+R4Swf7+C9GOl
         QtsEUnXZkVAuPFYusAXEmjFJMgngcxR2R3IlWSacptHu9dXIG6EjifnI95do4w/oxNUN
         pNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793263501; x=1793868301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SoQZ6Rn/231FVhlbAImWqe7u6be9TgKTmZprNFAFk2s=;
        b=BdNWQQaFwzkGMROTMYOeh8XOGYXaD7jrLUHfvgFv224txo2AE+mJ78spZuyDdVewrB
         rGv1TU3YFwgcGi2EoyZVn4ywa3OoYL+8MHxszSSQHQG+odnNlJFUPdSrCxMt7SpfE7tz
         s+q86nOoko4rwhkxrMCF/r/BdNFm8G45Qz/s98vOrnRdrlxv4MDXsDb3DKc7P48QF7ev
         Ju27HC0AVHc5Rcs9P89kzTdN5pL30rSIYbVb92QWOassE7wGZdb+OgJ8wp77D5gnAvaL
         WEM6zr39H+abWVGxPNqd3hKWRdOF597DZbwPEBOF5F/Pg58rFYjhJ7z+BMIpC7PZJiCK
         NWrQ==
X-Gm-Message-State: AFq9FYKwfLV3Ab99yyUXgziDVXplu2R5Q1knPlyhtAsb8c5xzV8MIqFU
	F3UqYhLoiybAuzY63VvO3aTwEOaXsyLpWFFv22527mUPkKFoUMXOLhgCs7CT+9shkQ/oB9WaTcj
	craTY/vZg
X-Gm-Gg: AYBFou3dF+PYXHtfJGnMLLc2bhhYQBcaB/0K9Cg3TfUo0OQQUqLJWqIbd/E6PJ/LxT4
	6SHljLQqT2yEOxIok1/vJU3gIVjlMO8uAGZnBX+DzPkA0iKxfBgnQM35j95HgIZFfjv039k6/4M
	XBupSf9oVuFD2VQPRIPLu7T+ZI9T+/18YggvHEAylK5uN4Vs0QyIsFYINEA3Q2fcrFFYfu957zD
	RsZad10D55zXlX9Xkv9C+OVzhj0pYme0DG1iXcakIlbjOvXV4Yjhhmfi8AG9w4Opg9HnRatV9fe
	pbXLocDGYOTSYHVK78za2ifvPVFhPmkpSoJTlmhm4LSiAGbWB6pxmYsHg0h7vUsoG3FgVTOFGH7
	e3SzZHnPAbEEcJZO7hYxMSZoqA82d9NFMmKNs+h+Ppd6AUgCSBTXFHrmXe84a1E3Ijw8+Njbcwz
	PqVaDOm+kyP3uq3oxrGvQn5PkgYfI9X676JGwm71Z39WnCaJQjzTs4T770WP/i1qC+DUoSoBlXO
	v+SfgY+mNuukmOA8ZlxrEwHdn9BNtgPkBYBqqoAwnmYwrjzAfvDTv7vDei/BXupJtoQT5M1AllL
	pipBmBtYdrX04o+QQolLMZyNVTEcx6R5apS33fY97P8kBuiDsY2Dx5Kac7tE
X-Received: by 2002:a05:6a20:5482:b0:3e4:bc73:8d60 with SMTP id adf61e73a8af0-3e9023f494cmr3826874637.55.1793263501341;
        Thu, 29 Oct 2026 01:45:01 -0700 (PDT)
Received: from 24c857d0c3be.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdad33b99b2sm3083915a12.26.2026.10.29.01.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 01:45:00 -0700 (PDT)
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
Subject: [PATCH net v3 3/3] can: j1939: enable context analysis
Date: Thu, 29 Oct 2026 08:43:26 +0000
Message-ID: <0d7b3745c8d8f3d7bf4b91ca3690f5ff1ab52f59.1793259424.git.zihanx@nebusec.ai>
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

Enable Clang context analysis for transport.o and annotate the TX timer,
TX-send shutdown flag, and session-list lock wrappers.

Keep the analysis opt-in and its annotations separate from the J1939
timer and send synchronization fixes.

Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 net/can/j1939/Makefile     |  2 ++
 net/can/j1939/j1939-priv.h | 18 +++++++++---------
 net/can/j1939/transport.c  |  5 +++++
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/net/can/j1939/Makefile b/net/can/j1939/Makefile
index 19181bdae173..67462b271252 100644
--- a/net/can/j1939/Makefile
+++ b/net/can/j1939/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
+CONTEXT_ANALYSIS_transport.o := y
+
 obj-$(CONFIG_CAN_J1939) += can-j1939.o
 
 can-j1939-objs := \
diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 6bf55b7dfffc..d664f32bbb8f 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -240,7 +240,7 @@ struct j1939_session {
 	struct sock *sk;
 	/* Serializes session TX sends against transition to DONE. */
 	spinlock_t tx_send_lock;
-	bool tx_send_shutdown;
+	bool tx_send_shutdown __guarded_by(&tx_send_lock);
 
 	/* ifindex, src, dst, pgn define the session block
 	 * the are _never_ modified after insertion in the list
@@ -293,22 +293,22 @@ struct j1939_session {
 		/* dpo - ETP.CM_DPO, Data Packet Offset */
 		unsigned int dpo;
 	} pkt;
-	/* Protects TX timer rearming and cancellation. */
-	spinlock_t txtimer_lock;
 	/*
 	 * qref pins the queued timer; cbref pins a running callback. A
 	 * concurrent rearm can leave both references outstanding.
 	 */
-	struct hrtimer txtimer;
-	bool txtimer_qref;
-	bool txtimer_cbref;
-	bool txtimer_cb_running;
-	bool txtimer_shutdown;
+	/* Protects TX timer rearming and cancellation. */
+	spinlock_t txtimer_lock;
+	struct hrtimer txtimer __guarded_by(&txtimer_lock);
+	bool txtimer_qref __guarded_by(&txtimer_lock);
+	bool txtimer_cbref __guarded_by(&txtimer_lock);
+	bool txtimer_cb_running __guarded_by(&txtimer_lock);
+	bool txtimer_shutdown __guarded_by(&txtimer_lock);
+	/* RX timer state and refs below use active_session_list_lock. */
 	struct hrtimer rxtimer;
 	bool rxtimer_qref;
 	bool rxtimer_cbref;
 	bool rxtimer_cb_running;
-	/* RX timer state and refs below use active_session_list_lock. */
 	/* Temporary drains defer rearming; the last drain installs the pending timeout. */
 	unsigned int rxtimer_cancelers;
 	bool rxtimer_pending;
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 570e2b8d0826..7fcf66e93afd 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -236,11 +236,13 @@ static int j1939_xtp_abort_to_errno(struct j1939_priv *priv,
 }
 
 static inline void j1939_session_list_lock(struct j1939_priv *priv)
+	__acquires(&priv->active_session_list_lock)
 {
 	spin_lock_bh(&priv->active_session_list_lock);
 }
 
 static inline void j1939_session_list_unlock(struct j1939_priv *priv)
+	__releases(&priv->active_session_list_lock)
 {
 	spin_unlock_bh(&priv->active_session_list_lock);
 }
@@ -331,6 +333,7 @@ static void j1939_session_txtimer_cancel(struct j1939_session *session)
 	session->txtimer_shutdown = true;
 	timer = &session->txtimer;
 	/* Keep this alias across unlock; blocking cancel must run outside the lock. */
+	context_unsafe_alias(timer);
 	ret = hrtimer_try_to_cancel(timer);
 	if (ret == 1) {
 		WARN_ON_ONCE(!session->txtimer_qref);
@@ -869,6 +872,7 @@ static void j1939_tp_schedule_txtimer_locked(struct j1939_session *session,
 	if (session->txtimer_shutdown)
 		return;
 
+	/* Replace the queued pin; a running callback retains its separate pin. */
 	ret = hrtimer_try_to_cancel(&session->txtimer);
 	if (ret == 1) {
 		/* Reuse the pin owned by the removed queued timer. */
@@ -1447,6 +1451,7 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 	int ret = 0;
 
 	spin_lock_bh(&session->txtimer_lock);
+	/* A concurrent rearm may already have recorded the callback pin. */
 	if (!session->txtimer_cbref) {
 		WARN_ON_ONCE(session->txtimer_cb_running);
 		WARN_ON_ONCE(!session->txtimer_qref);
-- 
2.43.0

