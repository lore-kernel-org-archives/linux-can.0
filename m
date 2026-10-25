Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792963989;
	b=AHRmVm3HVqqRaLusrqCWhhZywt47lriCZWuAcsNN7j+FkbWphdP2sk32Ja1mN3AnUsld
	 W4Gev9+Pv89Ht3/MSeKIzVbScjN1IyKbYCqTRE6WkwA6J/PuPeQ0UPGHCa2xc+ROtcdK3
	 7ycR0dtrmHvNzewEEN0D0xQkKpPBKozBEmL/khOtEbSSFWscyS+guAtnFDYEfi5QKH0sj
	 LFBB5GawfRD1lvmLoHJGwU7gn2xypgV7rSXNshG+c0pEzwxOJRYSTqlrB4jZiG3AhMSWh
	 9MURoJV3YhhrAXZ5cPMb/qrEv+7rQcSupQKCg6wdNFeB1Cq/GazWcz14qQepauSOw4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792963989;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Nu+dawTtCJs07taIh0/DxDgOD4/B8C6Q7zDwBtDhdMo=;
	b=xgVbUIZhwBDDT3InBSg156H7Ir1OYmBkDY3USh8cV2MFvPzm4982SD0rDdnopHcvLye9
	 XlvI+phYLzzsZWheZqn+FqQcPCViF6rI5vrSgGrP0dRM20R6fzCZ9eN3dRppgoE84m8cm
	 7OpmevgLxTRaJrSO6qwvzNJci5o3n4uA6QfdQAKgb9WamOrcWgRP1jNP/bOx6If6ZOqpC
	 MhKwXeaikehU7EW6WN509DksT1gAI/ufMaZ/7iPkg1E4ZiVylhfmnwx9D+Bw6KD+/z/D7
	 q0rBa1cIm8hr1oM4YMSbpIcsyNmnSW2yluWuS1lV7xTXsxb2BT3iNIt0TSGmyhsikAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=f9o1IB1K;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=kJ3nBTQM;
	arc=fail smtp.remote-ip=85.215.255.51
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85058606A31F
	for <linux-can@vger.kernel.org>; Sun, 25 Oct 2026 21:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85058606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=f9o1IB1K;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=kJ3nBTQM
ARC-Seal: i=1; a=rsa-sha256; t=1792963980; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=tf56BpY8yxRSwXMY8lsPRu73CZSgPU8LeiXp92wqXhUqOcKXjmxhhpSpyNYRLU5mxj
    qoYmAmMoTO6W9/eOexbxve7yAVlz7sn4BpbXVQn2G+WEWsqC6HWqJ6OQOoul2mWvJhMz
    dYvj9w6NB+7pwYGt64+zQEScf83aZQqKWboH2BiOPVNaC7w5Gl+clKTEOxK9tSmG9l64
    boawUMgBtS4kxIC/NQcOblVf+yqYFWYNOlX0iD7OGhVGZ/w/MccknzpCflC7vwg1ENIO
    1XmJQHVKFfqL2LQTHn64Ax8B+UymK5Z9luUHw8yZCQXGsS2f0hKa4Rogb+0AU6eJnWJP
    754A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792963980;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Nu+dawTtCJs07taIh0/DxDgOD4/B8C6Q7zDwBtDhdMo=;
    b=bW4cDOdvRHMUXstGPrFwiu0zmM86zgktOK9cAwJdi5CYqHt75mWyE7hmiQFXahfgAB
    uVM3+xpYM9SBiByoYxsXRTinKn1AYoj0f9WF+yXkGYNDv2D1MTu6zH2xW7dYpg4E/alS
    sd3lljq0A2T7e7winMWIUsNWjZHvtzjQosVEY/Fq1sNnDmjCmlBHA25lkTCyRxU8ax3J
    GQ+XAOHf4cvGFVTSOcCwYbps/q6x9mZcPW+pO3dB7UFDaRA1eowz4y/IgXYPZn3sSLGG
    IW8PgDZIb58Yz4jAXIgI2QFf1NlBd4oR8t1bGGsZ7Ar4IIlRWOXO4XSwtAs/6QSB4+eg
    /27g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792963980;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Nu+dawTtCJs07taIh0/DxDgOD4/B8C6Q7zDwBtDhdMo=;
    b=f9o1IB1K/1VnXKqNl6KstB1tIKfIIltqikppCx2nDArot2xHXG1TAH6T/dLjqvDPn5
    cjwktu5ms6+8xL7gL1SllkqQXdM0xiFF4R6DijYZMGIAyD6dnupM41IQCM7rkKmLnb12
    3um7qGhh82M9He3ae5OpHBLJeJseSYL+/id49HqwZOEsuFvRTLLAqBOSNqkgM6jAIR0T
    Bn0HAaVF4CoIEEghsKXC2kwe+GZmcl5PN5Iwvq8oUy51KRi6Bw8R7XNFON8mkRifIeVD
    +Mww/jcs0Cc3YGwE51Jw2GIAU8AXuYWnDk0jKIPAZ0pLUw73DTj+AlpnN9Sv/qd1/xs8
    5ybA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792963980;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Nu+dawTtCJs07taIh0/DxDgOD4/B8C6Q7zDwBtDhdMo=;
    b=kJ3nBTQMNMFpjmuY+ezYb9AwJkQ2q4FB7RnSYX4mTBFxTMH4rCxFDXVSz5rd+S+KhX
    rOP9x7/a7FDR+fPlF8Aw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29PLX0z7y
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 25 Oct 2026 22:33:00 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Sun, 25 Oct 2026 22:32:44 +0100
Subject: [PATCH v9 2/7] can: proc: skip stats calculation after reset in
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
Message-Id: <20261025-can-rx-lock-v9-2-7ef2a2b5c2b4@hartkopp.net>
References: <20261025-can-rx-lock-v9-0-7ef2a2b5c2b4@hartkopp.net>
In-Reply-To: <20261025-can-rx-lock-v9-0-7ef2a2b5c2b4@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792963979; l=2836;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=+5hJ80rWY4pSWIMbwYbqtFAao3PPiDuWjoVaSfLkTVo=;
 b=XGMHW35aXhlTxfU8NCr+OlZ9danQrMtRe0B2GtssWDxK1kNJfm6pHJg/oOl38KFs7SeDwUyv5
 s77RqpSeLPhCFp+2XjyboScOatpWPOOXsvPBt9cbHZK/Qt7es13PH0T
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

