Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.166
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792669347;
	b=3laDQ+mFKiHBNazYKAAffaoz7/pIm3UW/IEfGHXIopS7U3P4+rUuiaKV3bTQBiCaiS/m
	 BxV+fqQft9bBC6dMjVzZCMra9+KCl+N7mw7v/TVneBaa8Qnx56WfBJUvssBerDAsspcWv
	 VIuFyNq0sTWhXwhu/J2fuGngeL1BmTbRb1wa7p4fxg3f2GqnEXSFLsc1A21ZmpjIY6whL
	 zcy/R0K6eIJgWlID1QfrDmQlQ+BcQOTyBrkRwTLVOwgtK/CPUPxSFGLhr7pFC5e2S67b+
	 3xXPUoq8Xm37cZ8GU/8CYGif1H9VollbTdCIiXDgNOghr+m1/wviUxXq6/x+c8SumyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792669347;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=LDkhaTDtgSTmn5DuHZM1hn+df8UAT4lyjU6hBRjS/4M=;
	b=2K9dLaES5Urc3zyGNNB/n3OCQJWmh5LZusrd1UBqmTcX6ccwYXKrz+Zs8XLe1vP0aAs1
	 n/C24EcfR8zz5SNhXZPsXokUpT47tvP5hz7p2PSP6VtIRN5RimzOThykoDz+EtrkM6AMZ
	 B0vruOh4b9kwSJZzHo1gtRiZMe+CloVKQw43+7q5CX3sjbwqj9MBJNxfYIRrp6c7MrZDd
	 AS6dFIQWB9HQIMrSipnhF0GCNSkLCA/tjfGP1OloTLz9Ru2jQASMDHIr2sGIMAeeRNwSg
	 yHZLeYV7LQ5LEmRbNSXgrfqHIJXZNZ5DdgWl56aeevWl4A//BC8xaFtJSL08DC3M33A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=XNHOxZJl;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=kgDagKEU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.166
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B319606A31D
	for <linux-can@vger.kernel.org>; Thu, 22 Oct 2026 11:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B319606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=XNHOxZJl;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=kgDagKEU
ARC-Seal: i=1; a=rsa-sha256; t=1792669338; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=r5X9esq2vEYM+p69i9fgNmu0Ijm3QaRNm0LeBnhOg+aL3RYH0c7vzQrqfjvV4J4Kuv
    9sjjgE6LM5AxzpXhCbvq9Lqa80y3rGl6dsNczi62wHGbUXRJ0yF3NlA05QV7SFdAk6DO
    rNqCmtBOJBcpY7gPygLkoOP4My+mT6LbmpcAInV6YQNC6QFwPPCz5YDz5z/W8qeRnIbb
    IJzxW1jXwZWCtUuEJ+UC0Mr5rsPrtIzJrNYNKEzog56GbhY0htEFeH4XTLwwu52BPxzf
    b5/ZeOjgW78n56ctf5pSg+USkLgbUducN2wJVs/qn6qM8CrBjHE7zO6GEwgvgHLvUJ1+
    iJsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792669338;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LDkhaTDtgSTmn5DuHZM1hn+df8UAT4lyjU6hBRjS/4M=;
    b=PIv48xKpoetvUMlyypSfLf6VW75Z1dbRVE1P2iTyz/rtvh/GahWqGhBqptozKyvGIW
    p2V2lMy52duKha0G8mBgpOQPcPzz4UK3fGK/zNkNt1kkEo+RYzWc8bGjqAA7F3hLj5us
    IkK3ngirct0codM5j2/0H98mYujmAfvuh8ZCmBUzcM61MBiCIbJLkjfCY0/27I9Q8HRT
    Z6PvakGRolqg+FvAmRcSIrm0ioseYKCJimpJzCPMnkmezPvau3Tu1YDP/UJoaVh0MWJV
    ZURbK7HLHx0FUZ9R8Vxe/NtvMKzfAMP4N/2BrCfIh9Y0Eh6TbgUef8cCynOQ6590FC6+
    vFHA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792669338;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LDkhaTDtgSTmn5DuHZM1hn+df8UAT4lyjU6hBRjS/4M=;
    b=XNHOxZJl1StwmSMoXC+uFIZghyy1hs3jZ3Y4YKun4s0QMRTLq3qphLno2C5rDN3Qo3
    36QFWKrfcCru+eTaX0vlmw9oabTOnBI/9OfMlKqtHPEMOOQbpaTHbHSNuwrtUnotlnHW
    7ZDm0/ccWuh0wYerCxxeowDVO0pt8JeFHAu6Y8b7n+LZxedgOAuwEyJG1ZYID4bHgSqV
    lbC6LjBVrHFSSNsOk+HIH+uFt8LBFuLwaX+0CxVLcnmOYqB86kd9Ih97WYW7APLx59rK
    Yk52BkGn8wDeVQ3HCd7zMyJHdjrg1YPn2U3gJ8F9GCQdjnA/bGbIZcABa78QWbiNgusD
    ZCLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792669338;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LDkhaTDtgSTmn5DuHZM1hn+df8UAT4lyjU6hBRjS/4M=;
    b=kgDagKEUnNIhd719Z6bdHZFumNktyKrhFPGRxkNdYLPCwD895oqau3dWnQ2HgaVJ0o
    OhPCjIsiJb9Om0vuiUDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29MBgIo52
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 22 Oct 2026 13:42:18 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH can-next v7 2/5] can: proc: skip stats calculation after reset in can_stat_update()
Date: Thu, 22 Oct 2026 13:41:58 +0200
Message-ID: <20261022114202.180023-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022114202.180023-1-socketcan@hartkopp.net>
References: <20261022114202.180023-1-socketcan@hartkopp.net>
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
2.43.0

