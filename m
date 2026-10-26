Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793004925;
	b=Q3tiO1eQunJGwTageQC9AGRSWrjZoCa8MUPfiUh7fVFEYq8j+gW2UbYaHv+2YCmR91Qm
	 0qOteir0j+3C1tz1zyUwYPhR4yjYrNxdzSjBmnRkUNUSGIWkh0rUn4fzCL7D4n8sxJdOo
	 QxJhQISjjJeM8EvOX2Jyo7eMVfJ86ctHuD3S566jG9aQfFb3MT6J1+RbLDPZjjRqfgdwz
	 2rw/6WGUQLe+Y8sr6J7ChaOGoWF+jB/5P7cAfQqHkFL/XFd6EM0xLH1dX8bkU1ZoB5C2z
	 Hof7PwlJ7lZF7B4TRrbMpGd0P1Oblp6e60+O5cxo+FBdyeCAf0ThJeW0j6fIXHZgFQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004925;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Nu+dawTtCJs07taIh0/DxDgOD4/B8C6Q7zDwBtDhdMo=;
	b=ehP6GIk2I4ruD70Y5g2my3ceyGiy1CxY4UFUS/khxxisCdcvNnXI84YLJDPQ3H5JkIEJ
	 ihiO3gcHa/hFxlyJMx7cKOcwBQmnZCBf85EeITNZpybyzzReloRnVju2odhMaJWCgt38u
	 OD6sLmm+M/qqW2HPGWH0kcwq9mSH85gJWG0ALAKV6x5TrmjJPHRvWIkOcqS+7BlT5K5X2
	 Wwg4SoywXzKgLsVTELpljm03Uribr+92XHe9SWucI52FjKPMweAlpCVr0r3h9OFPgdZkS
	 WCUq/uU92Ar2dLwQ/LTB34yDSQFQV6VNBtXwRyiIeX3rzqtMC5JM0oEApa7k8aEDM1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Z7U5NuR6;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=9FvPOXC0;
	arc=fail smtp.remote-ip=85.215.255.52
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886FF606A31B
	for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 08:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 886FF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Z7U5NuR6;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=9FvPOXC0
ARC-Seal: i=1; a=rsa-sha256; t=1793004920; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cO4vdyJbB6fgYIlZOZ2zb+UXdJVZKh9QG1GexayLtQK1DRDS4wmA7n9saANS+wBKZz
    +wsZb6MOKStW55bJA1qjIWrZxaatF9Ub+ZVqlAV0dCqqlHpFV/zUfKkrWFLqHEHTnG3k
    J8B8W/7ZuI+qmI1uZiKrFXTPzusxhCDpfdwM8VSN4fL4MOSAm/aPQCJ1RshDRo6l6bRz
    YnbfCEgkp7YKbIC39Cvd5TEZXb9Bba4QoOk45n2pT0mY60rdteAmXJvk1bYYY2pN73lr
    4RLWPmxVbu0Re3Fc80M4zMVjjv0bk5bPD7J8rA0TyVUNIYF3ZBHGWSYMcHkhJGHfc+JH
    PvgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793004920;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Nu+dawTtCJs07taIh0/DxDgOD4/B8C6Q7zDwBtDhdMo=;
    b=NF6xbsiq+zOZ48xTcSxKhRE0m/RDJn1Xv7Mm7/kfvpPzZw58OLz28BkHovgdnkLC6w
    DQJElnIGvFC/VfRbr6Cvt5ntIwDqd8m8aX/7JI4atV1S2wEZk7GSNzSxEYH9rMqVSBlF
    8Yr+OFWRiOnsxy6/NZeD9KX26pIR208+5xHESFHbqNk0Ktfynrlu8kCXQiaDruoSNZET
    GfELAuVFUviEPdD6XQ4pWAwtzSHyzWdmg1/x2zSGJmSw6ffRaHzEFwY+EWrIzye13M0I
    ZDjsFNyetonf2m7sNqDk+3vaGtL2eGXfROuQtDnxKyALn2A8V1B+XGdJHc41pcQrj7F3
    Jw3w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793004920;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Nu+dawTtCJs07taIh0/DxDgOD4/B8C6Q7zDwBtDhdMo=;
    b=Z7U5NuR6owH5F5ScqaORThklkCZC4t6VughoagAd3+dRuCeqVR9wMtF738P6PcylCv
    G5Kt/YgtZ6UVmCNwhKfZr3juR8sM1qruNxfbe/uwt3XgLFIxrvGQwMeieGnKdlUWQ9h7
    lFQRNpimM8Fmfzjmbgf2BrMpTQcmTcAehO7+xakb9RNx68BZr1upWt5UgtpeOIP9fkd+
    CypbM5CaJBpGc7yWJvamZ+MsQX6FjDLQL/8Zac7FN2qrwh+krHvOMlCGbGQqDqYhcody
    u85b3c8Lf6ahKet/sFGhJ39UKbmw2HN7vnnBTsfIu2Wcg7opq/l4wRSVHO2sKv8MZj5l
    VbYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793004920;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Nu+dawTtCJs07taIh0/DxDgOD4/B8C6Q7zDwBtDhdMo=;
    b=9FvPOXC0lNhjaPgE1dq7CHYH0AZoXZafWKl6zGeoVPV3UvaarFCsOXHOONNmqJjile
    2smAAInPJC32ES1eWtCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29Q8tK0mC
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 26 Oct 2026 09:55:20 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Mon, 26 Oct 2026 09:54:17 +0100
Subject: [PATCH v10 2/7] can: proc: skip stats calculation after reset in
 can_stat_update()
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-can-rx-lock-v10-2-281c4b556a1a@hartkopp.net>
References: <20261026-can-rx-lock-v10-0-281c4b556a1a@hartkopp.net>
In-Reply-To: <20261026-can-rx-lock-v10-0-281c4b556a1a@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793004919; l=2836;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=+5hJ80rWY4pSWIMbwYbqtFAao3PPiDuWjoVaSfLkTVo=;
 b=EC5Q9ZTIskjBKuhIa7qFFulMeNDaJ4w5S4Z1MlxSaaMcpAO9FGIY4j3BvoD9YdkBIsqJiKAjU
 bJrxtevmmeKD7MwAvKfAuqcBEpT0nOf45FVTAn++tXSGj1gK0pNlvXk
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

Commit 80b5f90158d1 ("can: statistics: use atomic access in hot path")
introduced local snapshots of the statistics counters at the beginning
of can_stat_update(). When can_init_stats() resets the statistics, these
stale pre-reset snapshots are still used for the following total/current
/max calculations and overwrite the freshly reset values. Additionally a
jiffies tick between the snapshot and the reset could trigger a second
can_init_stats() call.

Merge the reset conditions into a single check and skip the calculation
for the current interval when the statistics have been reset.

Fixes: 80b5f90158d1 ("can: statistics: use atomic access in hot path")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/proc.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/net/can/proc.c b/net/can/proc.c
index 70104f13077e..fb144d2adc35 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -147,29 +147,22 @@ void can_stat_update(struct timer_list *t)
 	/* fetch and clear values for 'current rate' calculation */
 	long rx_frames_delta = atomic_long_xchg(&pkg_stats->rx_frames_delta, 0);
 	long tx_frames_delta = atomic_long_xchg(&pkg_stats->tx_frames_delta, 0);
 	long matches_delta = atomic_long_xchg(&pkg_stats->matches_delta, 0);
 
-	/* restart counting in timer context on user request */
-	if (user_reset)
-		can_init_stats(net);
-
-	/* restart counting on jiffies overflow */
-	if (j < pkg_stats->jiffies_init)
-		can_init_stats(net);
-
-	/* prevent overflow in calc_rate() */
-	if (rx_frames > (LONG_MAX / HZ))
-		can_init_stats(net);
-
-	/* prevent overflow in calc_rate() */
-	if (tx_frames > (LONG_MAX / HZ))
-		can_init_stats(net);
-
-	/* matches overflow - very improbable */
-	if (matches > (LONG_MAX / 100))
+	/*
+	 * Restart counting in timer context on user request, on jiffies
+	 * overflow or to prevent overflows in calc_rate() and in the
+	 * match ratio calculation. The local snapshots are stale after
+	 * the reset, so skip the calculation for this interval.
+	 */
+	if (user_reset || j < pkg_stats->jiffies_init ||
+	    rx_frames > (LONG_MAX / HZ) || tx_frames > (LONG_MAX / HZ) ||
+	    matches > (LONG_MAX / 100)) {
 		can_init_stats(net);
+		goto out;
+	}
 
 	/* calc total values */
 	if (rx_frames)
 		pkg_stats->total_rx_match_ratio = (matches * 100) / rx_frames;
 
@@ -194,10 +187,11 @@ void can_stat_update(struct timer_list *t)
 		pkg_stats->max_rx_rate = pkg_stats->current_rx_rate;
 
 	if (pkg_stats->max_rx_match_ratio < pkg_stats->current_rx_match_ratio)
 		pkg_stats->max_rx_match_ratio = pkg_stats->current_rx_match_ratio;
 
+out:
 	/* restart timer (one second) */
 	mod_timer(&net->can.stattimer, round_jiffies(jiffies + HZ));
 }
 
 /*

-- 
2.53.0

