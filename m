Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.160
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792757904;
	b=ivET83U+FTzAXckVH9eypWMpdqfW74kD88ZIPVItBDpLax73uVJBWDjX1qhW2kMTKzqA
	 6OsU+S7EMm+9/l42F1sY1ZVriTa9/eLqi03Sp/njLahAvii+XTiUA5MM59MLBiYHFFfrz
	 40mFDFWECAEhpovPwMRVBhLCaajRaimPvPb+85/dTJSMROrdLSNeQCIE8TKz/thpfPfgs
	 RemfMfyUu9XCkw3/5mki6jZ4mLZZOB9CtMwuymbV/ZeKH+gFDuNaOWA+HJwoGjkT7k3yA
	 57iv3hpDkboQkFf+SQ/A1ewV4x09cQvUuAK+KlBLmu9akbM0dYhFO5OCrdq6AeS/OFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757904;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=LDkhaTDtgSTmn5DuHZM1hn+df8UAT4lyjU6hBRjS/4M=;
	b=lwYOGq7b7YgM1wb8W1J79QOelsWQY2z1aqRInWBgWWQ8C1J37JpnVi6yQV3+XXFJmnLt
	 PrUBHoYXKAmFJa0/XZG7vAm5wlJrcBTgCPmfnb/j0wUmMRexHbBtTM8SrHoqdm+tz5JGa
	 n+V+1xY3/sDoZLqabqe9RHFGCACQmxyrVqyHXmaWjiBy7wTTVc5ySLvYE6pH6N3G7PmlS
	 Lntre+ivJCQTjnd9X5PqzDEf24t75+z5G16OQR8evdFM1wfxizusltq7ZgQGbW4rVf5hc
	 C3dUz51C82EaIMxUlSA7HOsZLxxnTFO8CHg8qhygx/UR1+fdMo9AWPYw5eUOeQ4YUSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=tPW5D7MK;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=oCEUpS0O;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.160
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EAE606A31E
	for <linux-can@vger.kernel.org>; Fri, 23 Oct 2026 12:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4EAE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=tPW5D7MK;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=oCEUpS0O
ARC-Seal: i=1; a=rsa-sha256; t=1792757896; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jHp2rX0/f/Bm+THptVph2Jmc6D5xKfAyg51K73Ba4g9r9E5n1Nrf5Db0ymB1GQWIG7
    q45XUmQUEfgF9eZHX7U+QOdu0ygQkSGczQprz1sa/ntxc88b4pnXfqlEohl3QoPf8mXS
    CE8NHg0FDon6my3Dzrpqfe1vMzsJB6AeoaIqLpQPqGqdh/bnMXOgJ2h1Nc7klP4RKskX
    YEp4ojXkG1Baq80Q9g0PnQrhVi3PfU72PnVaLrN1F9J6EmmhMw5l8Rfj0ZvnQm9+9xFm
    HE8N5cTLhbvMa/7Tviy+XitIYMojk5ArNiCPoMMzr4Nd0HHsk74lLroMSb6k4z77FXun
    NgJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792757896;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LDkhaTDtgSTmn5DuHZM1hn+df8UAT4lyjU6hBRjS/4M=;
    b=M7UC5Hv+Q9JNoJkf20DUFLLorsNW/TQnbIx4zBeFCwlbyK/b9zkEtsB8+J0hiGQV66
    h9WfOjhEgDRvAfGTTbkB0g4Sq9xGYbxtX8qbfjRUA6i1z6RSykPHodcg+EA9A4XcBdKo
    PDglKeBjGwikvjEvREgikmkpiSMHeaoiDa8zWYGei3d2bLrdpGqjMBx9KfYclCvU5MTm
    jjfC5McgqGlth1USmuqt0ZdLBoI2VdCb+HLXvE/fYPP+f6r7RpVOZ3JWW/9CKfMaP911
    +6wOODeYiWqCLHxSX6kI1hbpKL74e53HciIsUs+4eT1wNdAwoD4dX9tasqp1TjpjTjUj
    qGKQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792757896;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LDkhaTDtgSTmn5DuHZM1hn+df8UAT4lyjU6hBRjS/4M=;
    b=tPW5D7MKYMNA8O08gmVUvVHU4C3mdWnZ0Igf2aOtHl7a4sVmEOCFatuMFleje5c8PN
    2jG7Xlv2eXfhEUd7acGxbZmX+r2b2JUetl0thTwDI1i4kgnd2FzGQvuts6vcOCacEuyW
    hlBynPVd1iSn06zq9m+/cxP4nJu5OHS/lrmLeFvXpKZJoBm6SGqDLhzJK+z+NY/CV6Oq
    W/8FXJdDUM+fklM7/JTfL5MNHhK3nlcF+KkO9tkZdZ6B/ijN5K3nwBzon6zG45uK4+oh
    6u2+3FPXfwMgdCELTw916pghCJPS0EpiMvC9Oy4E9nTz9RwZ+GKpcyKaKBmOwxqaqd56
    XlIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792757896;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LDkhaTDtgSTmn5DuHZM1hn+df8UAT4lyjU6hBRjS/4M=;
    b=oCEUpS0O3RZzMOchspJCtrQS8iXQNm06g9+CmrwVuF8mQFK2SPPZa8kCAugLZFQEMc
    SJV6CdXCHufd1o4ru0AQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29NCIGt5l
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 23 Oct 2026 14:18:16 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v8 2/7] can: proc: skip stats calculation after reset in can_stat_update()
Date: Fri, 23 Oct 2026 14:17:56 +0200
Message-ID: <20261023121801.3052075-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023121801.3052075-1-socketcan@hartkopp.net>
References: <20261023121801.3052075-1-socketcan@hartkopp.net>
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

