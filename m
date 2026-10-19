Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951A74DD3CD
	for <linux-can@vger.kernel.org>; Mon, 19 Oct 2026 11:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792410768; cv=pass; b=Dh3cxtQL/99e0huSpwEIbDB+ZGm89lYTPjR0VgSUzlxxvIS82r0RSM3tWWAnyLTT+bFOVeQ4IhgbpKYxykGyvU/9/ASDM9GYVQ9L0B5SCmW++SRJ3/T8NP/OTdYOm4vDK7FL9vTjMY3w5m9IgRsEnsmZptH6CM1nZuuw9WmtMjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792410768; c=relaxed/simple;
	bh=iL0U85CD5ErTa1gGDi5EKu8IuXJrqw6nYTBPL2Zu00Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=irUD4kzlxfc3PZGEmw7FzhwkRlnZkgj8/A3P403nd8bSBqTqlEF3UZ3idDWCIfMxjUaH9sI3flIR99A28T6z0GYZHrPmGGaPMB6bOGCsMGsrtQarebiUV5XLNpPLDEyKfQ9uH914x3SUIq7cyzs9B8QYh+DtHIS+qetgwdxf+1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ONGh1G7D; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=vARA0Diz; arc=pass smtp.client-ip=81.169.146.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ONGh1G7D";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="vARA0Diz"
ARC-Seal: i=1; a=rsa-sha256; t=1792410757; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZDgvfy8wCBOd16+drmvs0XNJWsPLhTvMJN8qfUrxs5IKslBf4PyzVzSGSvkjsKfBeJ
    1WU5EGH3vXSLBe7EbLhoBfsta73wSK63purC+kx9hP6UxqCHJvJSoktxrF3vCDfCfmPC
    NmSjjHjAE8tmcmYRCkyabQOGFOl0sJzEwkRAiOvqz7AXmeb+k/Lk+3K7TCppABt4e5zC
    +mO1tGtwmrFQlvC1geqlse/lGSNwF8wVOvlVpMHPJD093vPT+V7HIGbr4bWjqodwW8tc
    ajtGP4a6BzKeKiFiQUSGe3FXs8JhaY7MpcqonqbY+7zcmn13Ng5yd376gbKXPZYGbYYO
    ZZjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792410757;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=h5C5uMhiMWXEluuG5A+xEYz9CEjwlWZbWrDvBHaMl9o=;
    b=RjNf8RQ0emjpT8oCiMw0seie/yXHE2nfpg86Cy89UYzTvIunb+l/BXfw01psiIrUOr
    lWDIWaRekpET2IUI426pvxQj2oq7SotjLM4tzSYSQ58UDKNZ4JA7BY5IMNiTGa8tcJMS
    lu4YrcRfPSsVfpCBRx6jtN63J8VhMb+h2LBcIR/N/AUoyqrLGO8Wu9vZ6zrUXy2sRDER
    KilTTFarPU8Sqfl/SLnL3UMdAcOeWVnKbFV2B2ofc4LKJsKN1WhkJ/gw/tDaeTTZY4Pe
    uHytWMi7E3i9ScjEhEqeo0jpk29ObxsSeZIEgwcVya147mopLW4ZWtE1FSDAcB+BpTHI
    uH5A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792410757;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=h5C5uMhiMWXEluuG5A+xEYz9CEjwlWZbWrDvBHaMl9o=;
    b=ONGh1G7D6tyjwbi4/uv8H3GZ3L7VCbwpS5KKz6in+lx5xgEfj0v1i/90tdYzM6O+Pw
    +FSEZRtOAw1JPSXoZsi+8MFKU3jtI2KreJhPZT+UPBQKxQ6JlAL6DQAcV9pW3uYnD70b
    F0zdCS2crpekK0N7lJ3/eySDgRUvp+rSRAmkxNEyKNUuBx/zSyQY1kmkDFE5ZwMCptC6
    11nPYp0JpSYBsq2T6Cszkj6m5U0MjNYzs7A1Jd3i2m87/b0GxAcd7ezUbRQLDxgS3Ina
    dwbieqaOyBqrBuOKjtRL32vxqlEXPccOV1UfFdLGy08P0Mupn+GygAhsjKRNrhMCEykh
    /Zow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792410757;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=h5C5uMhiMWXEluuG5A+xEYz9CEjwlWZbWrDvBHaMl9o=;
    b=vARA0DizmK1uU01viuSQUS3bfczFExyGRCZfQGra8vyY+BRzEXPTQ4pzGf4wc1plZt
    1n0NtGDSLCui50m7oYAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29JBqbWU0
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 19 Oct 2026 13:52:37 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH can-next] can: proc: skip stats calculation after reset in can_stat_update()
Date: Mon, 19 Oct 2026 13:52:30 +0200
Message-ID: <20261019115231.93550-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

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
index 0f1fa6564436..b7496d2a37cd 100644
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

