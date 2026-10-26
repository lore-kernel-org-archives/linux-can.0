Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792998193;
	b=nH0OQk4mAI7mdgY3VhDcEhAlWlFl2wtbbS2MI3G6bMRAx61kDw1XFXV8MJST52pp9MW/
	 48GUZFIY9CTNrZGf1q/dAiqML0lg93WXkN5PL9rCFOQm21PhbfpySNXA/hwYdvdrLHUCs
	 /SwEdJHDuyDsjjVFQGi/0ih/PYQVkQUAuV5ZpDD88HehmAcxjDqBJCowWDz5DmrP7GN9W
	 qQTTFnTe2XJwJdAi8pSaFELLY5tMWOZa2jajb4cHazAUcNhjG1DiJfNYVaJfONcZ0uMCv
	 nR4WOVsjrfh4CjKPCqSKaLorZwPRWGJM5zJJLpVrejvi/6IYDBbFBRsv/84islZAufw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792998193;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5sFjBguLdb1R6cl/aittzu2hkJXaagJSVs59kF2Qwyk=;
	b=ML/XxOe4BCPgXyLrV7xODY3gHA/xsufMwFi+gvaDR+NObXK7/sPZdy+Fqvlo3fQDJqN0
	 P7+nSs6KOVcbMd0wTEosc9Gm/NhCv9r5pSd3k/uPhX3C4tPdhtazTUW3BVwyXQGZEpEkl
	 DG+gotg16ARkXSeOecBHenZV08hOcS4D/u+T3AMyWveNdKsYOAybczOOEsaIZPNCzoUK5
	 c6oxNgX30sMuNyaOYZGIs2G84q1G9Xgt6oFLBO3mO///NR8Ml11iIQDewFr6OYXSOJoaQ
	 Col0ipcJqs7lw75+/5JxK4605OS00xVR0tiGtlOZsJhy4BJsmBOoB6U92L7vRTglMnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=EKBchBZT;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E335606A31A
	for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 07:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E335606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=EKBchBZT
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso16582655ad.1
        for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 00:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792998192; x=1793602992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5sFjBguLdb1R6cl/aittzu2hkJXaagJSVs59kF2Qwyk=;
        b=EKBchBZTp9JC0EvHlfHrV+5BbCypYVfB/2w8v2S5HXFlHK+GeimlgeQOwf0aAWSX84
         IdY1JJiwxUg8UU8iuJPwB75uZjJYkbQSce/dy3+RTS2w3I0OhOtlwzWYU5dirIGovpgo
         cLn56/2qIQJh72ZO+V15bks5uLWeYcEN+OWaZcq0sfFnhBPervh4xSHWfIJ4UPAYgvWm
         1g+XNtHNiE+Z8DzS6wlL+A8bKY+0ORSp0mHkzRJLv1SxKA1RiGPpq4emPMn/gKZU1y3Q
         3E7OLwq001kdD5GN8H6YbnSeRLMVmpE/7SkpRiX39SOjNSYM32KPTTCqoZTdYmbr73vX
         Jqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792998192; x=1793602992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5sFjBguLdb1R6cl/aittzu2hkJXaagJSVs59kF2Qwyk=;
        b=oZ/hiF/E2XUiFtNXIH0DzUKHfz23DvIqfN76pdIH/HlXr8e2PZI3fMHBOUjFBEVxCS
         aiWmmaDzPIoVQoxvbw0OhG3ZDlTcN+jd6k60Uy7Kna3TRBADdLF7FzRYBQ6gR24jK+y4
         oXQCyGXEIq1NgbJW8SIH72hrT3mcxwLzDzqUR9MtzlB1R5/N6v2FvdFGNOHC3N8N1i7l
         bY4QOYjF4kKzwzy6vrm3Rhx2+w4YyAtiEQV5W/X2pDjkIUOi3FPkAh73nWMu8Q8EMZfn
         dwzSasl0M1tyKubwWySuveV48HaYR6RGZU1dW8pbLeXSWxu1YHD1+zW6RSthW1qr7p6x
         FWHQ==
X-Gm-Message-State: AFq9FYJ6BlEDcb1XfSV72bzK6BP7YoXRLKYFTvab64R+5W9ijQty1EiZ
	jPShCfuTD3kEfkHOH9mwojCFyUmHF+HcNEo8/WYKd0PJAH+BaEkofTpDv+x7vgwHGbmC7e/8UGE
	NNyzmqBbL
X-Gm-Gg: AYBFou3F0mGS1uCVIBAqJHaf9vSkZQeCohF7x+K/TVNJ9Aa9znurBEh3oEfQnarao7k
	R4OVy7DL+0wMsGdmPXqMbkfNrXIw4sleLB9TOEpl03FjekPrFHFwOzHI+IDsoXWOLH5oWwCD01s
	FEQyYdAYNAJgSCQpawZbAd/LBxi9+6tQCo0JyOPDyhhYnKwTvhqwaONfCvQTc8hJJhwv+GQU7t3
	iVvwJsCSD/k5gwk25mJtFuySWEANSls6nLpuXP9bU2lAzWe9qkyV2p9N8IExDrWGx5DtlWKgzni
	bfwDf5cEpRYMnwtICurVdV9kVU5N5yIX6UL/LubX91bYSHfv/99ku2jwl5jgEcf2y2rvOHZdCf/
	WJpiGLVB3/yVHeofgTYzKjrZBC0ArGOwUL/Ktb+l9dsZY9H3Tb9MH0TNsJ/cKAN83HNMA7M1+A1
	peafcYJaJPvbU0FCpq8f3njCUWqsUfLdhFEXIDY/y3xeCEUvB71+hiuYv1apoy4rtni7g6dyr8W
	rJ12lWlvfirxiIizBkcfRVJbbyNjJgVqp98CpaJu8r3ulF5+XierRAfIiBj8a/zp5DYDgLuFMhq
	n1I5Opr0b/34
X-Received: by 2002:a17:902:f68d:b0:2e2:aa17:477f with SMTP id d9443c01a7336-2ea9c94c61dmr45928535ad.58.1792998192381;
        Mon, 26 Oct 2026 00:03:12 -0700 (PDT)
Received: from 24c857d0c3be.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b14c296sm12049495ad.30.2026.10.26.00.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 00:03:11 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: linux-can@vger.kernel.org
Cc: robin@protonic.nl,
	o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	socketcan@hartkopp.net,
	mkl@pengutronix.de,
	lkp@intel.com,
	ecathinds@gmail.com,
	dev.kurt@vandijck-laurijssen.be,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH 1/1] can: j1939: fix session reference leak on TX timer restart
Date: Mon, 26 Oct 2026 07:02:48 +0000
Message-ID: <6bbcca411ac9433ae4ed8b8e64f56ff16dfc20b0.1792979091.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1792979091.git.zihanx@nebusec.ai>
References: <cover.1792979091.git.zihanx@nebusec.ai>
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

The TX timer holds a session reference while it is queued. Restarting an
active timer only changes its expiry, so taking another reference for each
restart can leak sessions.

Serialize TX timer rearming and reuse the queued timer reference. Take a
new reference when no queued timer owns one, including if a callback is
running.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Link: https://bugtracker.nebusec.ai/f/11143
Assisted-by: LLM
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 net/can/j1939/j1939-priv.h |  3 +++
 net/can/j1939/transport.c  | 11 ++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index cf26352d1d8c..6c46dec73bbb 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -10,6 +10,7 @@
 #define _J1939_PRIV_H_
 
 #include <linux/can/j1939.h>
+#include <linux/spinlock.h>
 #include <net/sock.h>
 
 /* Timeout to receive the abort signal over loop back. In case CAN
@@ -290,6 +291,8 @@ struct j1939_session {
 		unsigned int dpo;
 	} pkt;
 	struct hrtimer txtimer, rxtimer;
+	/* Serialize concurrent TX timer rearming. */
+	spinlock_t txtimer_lock;
 };
 
 struct j1939_sock {
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5e6f..e9af8547c69b 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -716,9 +716,17 @@ static int j1939_xtp_tx_abort(struct j1939_priv *priv,
 
 void j1939_tp_schedule_txtimer(struct j1939_session *session, int msec)
 {
-	j1939_session_get(session);
+	int ret;
+
+	spin_lock_bh(&session->txtimer_lock);
+	/* Keep the timer's reference when only changing its expiry. */
+	ret = hrtimer_try_to_cancel(&session->txtimer);
+	/* A running callback may already have requeued the timer. */
+	if (ret != 1 && !hrtimer_is_queued(&session->txtimer))
+		j1939_session_get(session);
 	hrtimer_start(&session->txtimer, ms_to_ktime(msec),
 		      HRTIMER_MODE_REL_SOFT);
+	spin_unlock_bh(&session->txtimer_lock);
 }
 
 static inline void j1939_tp_set_rxtimeout(struct j1939_session *session,
@@ -1526,6 +1534,7 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
 
 	INIT_LIST_HEAD(&session->active_session_list_entry);
 	INIT_LIST_HEAD(&session->sk_session_queue_entry);
+	spin_lock_init(&session->txtimer_lock);
 	kref_init(&session->kref);
 	netdev_hold(priv->ndev, &session->priv_dev_tracker, gfp_any());
 
-- 
2.43.0

