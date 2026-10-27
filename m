Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.80
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793111487;
	b=OWju+M8qQTDLDtKq0VYeBk566qvxPIymecCfORikH3rxmpEDQqwSbyGjeIyeMnaoFMKj
	 HUp9Ps2ti3Y9ludXKEUV1D9AjLDm2CebPPigKak5DUbG1ndoq0ErzqezA57qYsl2Ws0rx
	 Hq36Z9lL4+Q7BizRYwgAb0Iw3Ana3BitNtVyYK39IYiPwRVtQeSm0eK70Hv89RjcsI826
	 YBp2JOYKemFptxPUb96FCPwCbqODD891M4M3BEllSe0ELhfleHiiNOfGcjIYIjon2AIWM
	 jvtWxIwW2ZYmcqG32xLWbERwc4enkkoL8JlSfrBp9BC5Oagag8IJ973JBTEv5Jz29+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111487;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=S8083yhEb0aFqIJVR/UYSsHYeDAKg6WChBpQ/djVn30=;
	b=uexKmcA2rj+kLKD3un1z7NkMuPKXmn232hUWgLMPOgb768bw2WIn3hdY2DIZW5aoXYw8
	 VK9VkjNp3kM+1XUhw0yWgUoIu+f60pASHgVLhDOq4Stb8f6/JpdQjnaoHYENHyL2VU7iu
	 5Tf83UQaIt7Rr3WERG84s+YxzRw5W4+ITDynlyOudfJYMgDZc24zFHbFAYK0hiJwtlY33
	 +wy5cuUn85dXmbSTHkgCsqFmLOQZd0t12zfW1r9lVga1fOIgZZhfl+BPL1XZlMtmzP1mW
	 +UkMfNpCjoYlAf2kxoSiHqXawI8F2Uv+08c6QB7mloPfS7IFWfMckYLGrzUOdonzMDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=m2nSAcT4;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=THUBGncY;
	arc=fail smtp.remote-ip=85.215.255.80
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959C0606A31E
	for <linux-can@vger.kernel.org>; Tue, 27 Oct 2026 14:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 959C0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=m2nSAcT4;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=THUBGncY
ARC-Seal: i=1; a=rsa-sha256; t=1793111474; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=drHdz7Jc8VQX8IVnzzV0M25mSGKv4bSuOYT4GMxoTIcCnv/nZj6scQtyXrRhAS/CnC
    wNlo1+wBihVQFoEoitvvSmEcrJBgJ4z/cBM5mpOKmyyy7Z+zWRjuwWkBxytYsiDcfddD
    vFrWZoRTII4xv1mX1azVigQAnw4Z8vlIan82vJ8SEAYlw+QiBgPhmrBINwlsneCa1b8m
    vAox9vv+QlHSupOwwGU7Z/Pv3wH5EGOcM+J9lmiDvpBFYoLK+kPMv58EMim5GAvNe/Sd
    qKlYxUCwvV8lI/43fGq6DpU6TpY3FfSeXp9SFKNLCOIXPmSenuJ1nVFWu6sZyfiEe43m
    EJwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793111474;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=S8083yhEb0aFqIJVR/UYSsHYeDAKg6WChBpQ/djVn30=;
    b=sv/05nJrlFeV+5Q3cy7MZaT2VC3JXYocqXrDMtqEwbyZvTuVPTfBNjBWpp84s6eRtH
    NfnsV8oTu/IZ97HQxyfSNUPnrJi8JCjYhaCjeKAG6aepTs4V5qrBjSJ/szc4kniTGY/K
    iRHXQ+TGhO88lEUAfOrrkB0UEOOwHi1Q4LILs5R7L66NWhivmm20ENWbvMPItVjuZvy6
    hB7V/hATsRjdZC8QCoSeQUx0FDvz+JDGPO28fdUQVo4qrklwauP97cwhmAzm6OWn1rji
    4LudDYprTIc0oSOqbzEVryJB+gmOeoBnhEwsqcsUlbuDYFROSq2nXBZOEpygKx6IEYNZ
    QhNA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793111474;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=S8083yhEb0aFqIJVR/UYSsHYeDAKg6WChBpQ/djVn30=;
    b=m2nSAcT4OMqSKIyRousBKkBvFhfWuSxSzWiGHe54QTjvcc+nrXPpyS8+r0z3IZSZoB
    YNjJYs68pe42zzgIkjlhp0ynmLZq7afo9ANM/OPGz4hNV9OSZ93kEyFw8tO+5ZNhVyx8
    NnhxM/1MouTe880iMUOyiX84RZBvAx9W+Fv5MR1IIhUWvhDv96qCoiWHMq1PiP9naNr5
    5/MaHIfqhGgF6x9in0DHCnvX1avzm9zllYIGzK2o13Eb+iBfhnjr5rsomsTYXxbwMr2U
    leeGMyuP6UA/rc22X20jW4bf+Lop/kNkflWQHcFWuMXP82Cp3evdycxWa94RD2vBoMN8
    poUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793111474;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=S8083yhEb0aFqIJVR/UYSsHYeDAKg6WChBpQ/djVn30=;
    b=THUBGncYIAJXtqFJi4Nc1/ZrM1YmwK7WIyBkvkfVqsc2kXVGreQTR2DECqbAqzFZIL
    RU7mKNzPLdZyL/WNHrAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29REVEAL8
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 27 Oct 2026 15:31:14 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Tue, 27 Oct 2026 15:31:10 +0100
Subject: [PATCH v12 6/7] can: proc: skip stats calculation after reset in
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
Message-Id: <20261027-can-rx-lock-v12-6-eb5afc2d8b9b@hartkopp.net>
References: <20261027-can-rx-lock-v12-0-eb5afc2d8b9b@hartkopp.net>
In-Reply-To: <20261027-can-rx-lock-v12-0-eb5afc2d8b9b@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793111472; l=3157;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=8NtcFuYJc9r26slyZCsid92/wCy72tS7bMxMu8i9l88=;
 b=a59WCChIBczF62nXmXc9SjdZnRHb2wSHhdYlf4HUYcgkP4QuG+y0TXKkfRgkOZ1zqQ8nKgsd9
 WHWWv3k2Pn1ADbyTOFj0XB6X2vGaT0SBn8tqj8M/CTxDvmxb1HoFnMe
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
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
Changes in v12:
- added Cc: stable, as the stale snapshots in can_stat_update() also
  remain in stable trees that take "can: proc: reset pkg_stats atomics
  individually" (review of v11)
- v11: https://lore.kernel.org/linux-can/20261026-can-rx-lock-v11-2-3b9a2b829dab@hartkopp.net/
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

