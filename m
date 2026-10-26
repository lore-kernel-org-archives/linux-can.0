Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793004929;
	b=Sx9LkX3HtmbVXa2gmKDr7XxP4TsmxPBK2tWwmnCZ/cT9ckKE6ksvYWMF55u0mbcWZARm
	 4E3GiLUDT1zoMhtxiOGA+BHqJopsYg5aQTj5nogTDe8voA3GIgskFBBHzX9OYj2I9RyFB
	 Zl0WmWJmlhv+ZRcVwuPglQdqqOYtxFgpqXCt007DEHNhCmOhSfhFOqqJHe27pKbxN37ho
	 mhxyg0SUQCyu61W9njbJENyD5b/2THT4zBDT7a+c4vaVLNkE4mYCI3kzDtg8+F7LD7W/U
	 Yo9kxO1nagkLZHOVQqBUPxcWaFZDCGNFs3iEXzE5Xk4qIVZHc6jCpFTSoKNNcQCtepg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004929;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=revTEDBrYxQTBJEeO0BqfGYRwYY08gjkaZtSyNOorsY=;
	b=17l1kBtcpLmFy629LGYJqhN1SS+RsX5sD3pmnDLtLPFLJbvQXhXs7tMb1VY02+BM8tio
	 X6n/g4UTPJwGV/GmgN/KrNWwfZtWgmgq1xYPrW93ciinmqlVGr0Zi3RH9WOV7wGk4vWiu
	 hz6dnck+yjQYMx95QYpmgd3647kpeCk+afefh45AN1YKIGT6nSsctFYKTekb1W+Up0yR+
	 Ria4DEV8mZidbCzgwQaNdtP3Mn1zVceINeHLvdjVIPkKJgTFEXsUA9oby22xZR5satEf+
	 xKaHIbPc3JpkO3RnFd8Ghqk0MQ8SVoA+V80i2aFN37oaXOuAUSTn9d601ZooBIdY8Jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=M9RK+J3Q;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=AbqErRUG;
	arc=fail smtp.remote-ip=85.215.255.53
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A320606A32C
	for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 08:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A320606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=M9RK+J3Q;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=AbqErRUG
ARC-Seal: i=1; a=rsa-sha256; t=1793004920; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JMXumaBqqBIIj8EqExGWKgrxxDC9QDrlGYnOMVKpJEXqI864TNbrdLAutDSz9zQE7I
    FxllX984THV00uZHiJJW/Cs4DnsM9YaA89XQdGtr3CnD4r8Opt5G+Abq6ElSQmuPEGEj
    hGDcLp3lgKuqpxJ4XyiF5pB/uG0mPsSGgJeWHViitq0CcLdrgNQ/fs2X3rpzMwX/FLQ6
    3i2uw10/7zBQambSHgiUM6qz/tz9+TMiEGujjnpU3GohJfIx+9RuTWFHfnIP9MoAqhCW
    GnWU5BMmpwhg8ZHdDdCf7rLB+hj4dM5pk3b1C0CH++Kt8hbxCbzPc/cBVJPw2OAZg39F
    tbHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793004920;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=revTEDBrYxQTBJEeO0BqfGYRwYY08gjkaZtSyNOorsY=;
    b=cED8EuzGj/pSB802CFyefXFyvjIViMXalWEv7XISaqZdt8Bopk3NaPaqnxqI/x76IK
    AL+xmYQScHaTzcyp8umVbQtyT+HptSRaNkriX2yksoAxWsI2JxecP8ZMOhf6DUFjSRmM
    h3Q+ET4z/j/rv8fzbebygK1i0LSJNGWYdnfqPUtgTy2IZ/72jVTtB7JnKWx2MIt8k4cb
    cH2LUR0QC09p4E201x3fqf18KturIGT1KNvH08teNnXlHt01KzIBP/C1Z97q3m2SwWaF
    4oXopPRTcTcZ9YyMYBBJ929z26OyQcw6gQtgRRWemdZuhG3OujZQfJ33IHg6WdZt2Fxd
    /+bw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793004920;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=revTEDBrYxQTBJEeO0BqfGYRwYY08gjkaZtSyNOorsY=;
    b=M9RK+J3QstHXowRBCXRqYV8/Yi5W8zfAHWD9jJFZkKs6uJx50j5Lvh53+MTbWKgXp2
    rP3auMNFGg0i9wOTkL33PPQohAPwl9fafhLNC1KZtFuQXFhfg4kBhtvtcQWFe4QMuVc5
    lWKM5cbhBnI2OI2EC6LJUxf0Uc92QZuo7m4i3BUhIJeBZcYZyys8Nzzth1GjCBFix1ks
    nfN/dJA7NXTPdYSZjuM2SdNlTyfNghKffIEVza6zgkYp7vR67YbocwmwyTlGEhtHwvpo
    ThCT0tF6PPan9rpvGPHpYC/owLGhuKN+ankxNhYzpWkbhbMAanmHpCeeFx9K9cXKks2k
    jgUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793004920;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=revTEDBrYxQTBJEeO0BqfGYRwYY08gjkaZtSyNOorsY=;
    b=AbqErRUGZ0taglV+EKsO7+WkGEb39MZlbPhI7t5J7Ke2QBLLiRnrY/KieGOICte/Dq
    kjz5XbScSFYkltkIqLCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29Q8tJ0mB
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 26 Oct 2026 09:55:19 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Mon, 26 Oct 2026 09:54:16 +0100
Subject: [PATCH v10 1/7] can: proc: reset pkg_stats atomics individually
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
Message-Id: <20261026-can-rx-lock-v10-1-281c4b556a1a@hartkopp.net>
References: <20261026-can-rx-lock-v10-0-281c4b556a1a@hartkopp.net>
In-Reply-To: <20261026-can-rx-lock-v10-0-281c4b556a1a@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Runyu Xiao <runyu.xiao@seu.edu.cn>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793004919; l=5243;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=IL1mXqjDNcT5FWPKkirex05OmC25HeREvNFpHdeNVZQ=;
 b=0CGbaQMfqQ0KXmdHabwtIPLnL4T0GuYJiqwo38LKgtT8XyYs+pOk9gq073LgkIVdS8EhyFn7E
 qMcgKbaGw/ZAWQko4b2yG8d3CtMLD+sNmKMpKfsUXrDhBwVhTr+9OdL
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

From: Runyu Xiao <runyu.xiao@seu.edu.cn>

Commit 80b5f90158d1 ("can: statistics: use atomic access in hot path")
converted several members of struct can_pkg_stats to atomic_long_t and
updated the hot TX/RX and procfs read paths to use atomic_long_*()
helpers. However, can_init_stats() still clears the whole struct with
memset().

can_init_stats() is reached from can_stat_update() in timer context and
also from the procfs reset path. Those paths can run while the TX/RX hot
paths are concurrently updating rx_frames, tx_frames, matches and their
*_delta counters. Hitting the whole-struct memset() in that window
performs plain writes to fields that otherwise follow an atomic_long_t
access contract, which can lose or mix live statistics updates.

This issue was found by source-level API-misuse analysis looking for
whole-object resets left behind after atomic_long_t conversions, then
manually audited on Linux v6.18.21.

Replace the whole-struct memset() with a helper that resets the
atomic_long_t counters via atomic_long_set() and clears the derived
scalar statistics explicitly. This preserves the existing reset
semantics for scalar fields while restoring atomic access discipline for
the live counters.

Build-tested by compiling net/can/proc.o on x86_64 netdev/main.
Runtime-tested with a QEMU + vcan setup on Linux v6.18.21 by driving
concurrent traffic and reset_stats reads, which reproduced inconsistent
exported statistics before the fix.

[Hartkopp] can_stat_update() also read the *_delta counters at the
beginning and cleared them with atomic_long_set() at the end. Increments
from the hot path in between were lost for both the current and the next
interval. Use atomic_long_xchg() to fetch and clear the *_delta counters
in one atomic step instead.

Fixes: 80b5f90158d1 ("can: statistics: use atomic access in hot path")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/proc.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/net/can/proc.c b/net/can/proc.c
index de4d05ae3459..70104f13077e 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -74,20 +74,43 @@ static const char rx_list_name[][8] = {
 
 /*
  * af_can statistics stuff
  */
 
+static void can_reset_pkg_stats(struct can_pkg_stats *pkg_stats)
+{
+	atomic_long_set(&pkg_stats->rx_frames, 0);
+	atomic_long_set(&pkg_stats->tx_frames, 0);
+	atomic_long_set(&pkg_stats->matches, 0);
+
+	pkg_stats->total_rx_rate = 0;
+	pkg_stats->total_tx_rate = 0;
+	pkg_stats->total_rx_match_ratio = 0;
+
+	pkg_stats->current_rx_rate = 0;
+	pkg_stats->current_tx_rate = 0;
+	pkg_stats->current_rx_match_ratio = 0;
+
+	pkg_stats->max_rx_rate = 0;
+	pkg_stats->max_tx_rate = 0;
+	pkg_stats->max_rx_match_ratio = 0;
+
+	atomic_long_set(&pkg_stats->rx_frames_delta, 0);
+	atomic_long_set(&pkg_stats->tx_frames_delta, 0);
+	atomic_long_set(&pkg_stats->matches_delta, 0);
+}
+
 static void can_init_stats(struct net *net)
 {
 	struct can_pkg_stats *pkg_stats = net->can.pkg_stats;
 	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
 	/*
-	 * This memset function is called from a timer context (when
+	 * This stats reset is called from a timer context (when
 	 * can_stattimer is active which is the default) OR in a process
 	 * context (reading the proc_fs when can_stattimer is disabled).
 	 */
-	memset(pkg_stats, 0, sizeof(struct can_pkg_stats));
+	can_reset_pkg_stats(pkg_stats);
 	pkg_stats->jiffies_init = jiffies;
 
 	rcv_lists_stats->stats_reset++;
 
 	if (user_reset) {
@@ -119,13 +142,14 @@ void can_stat_update(struct timer_list *t)
 	unsigned long j = jiffies; /* snapshot */
 
 	long rx_frames = atomic_long_read(&pkg_stats->rx_frames);
 	long tx_frames = atomic_long_read(&pkg_stats->tx_frames);
 	long matches = atomic_long_read(&pkg_stats->matches);
-	long rx_frames_delta = atomic_long_read(&pkg_stats->rx_frames_delta);
-	long tx_frames_delta = atomic_long_read(&pkg_stats->tx_frames_delta);
-	long matches_delta = atomic_long_read(&pkg_stats->matches_delta);
+	/* fetch and clear values for 'current rate' calculation */
+	long rx_frames_delta = atomic_long_xchg(&pkg_stats->rx_frames_delta, 0);
+	long tx_frames_delta = atomic_long_xchg(&pkg_stats->tx_frames_delta, 0);
+	long matches_delta = atomic_long_xchg(&pkg_stats->matches_delta, 0);
 
 	/* restart counting in timer context on user request */
 	if (user_reset)
 		can_init_stats(net);
 
@@ -170,15 +194,10 @@ void can_stat_update(struct timer_list *t)
 		pkg_stats->max_rx_rate = pkg_stats->current_rx_rate;
 
 	if (pkg_stats->max_rx_match_ratio < pkg_stats->current_rx_match_ratio)
 		pkg_stats->max_rx_match_ratio = pkg_stats->current_rx_match_ratio;
 
-	/* clear values for 'current rate' calculation */
-	atomic_long_set(&pkg_stats->tx_frames_delta, 0);
-	atomic_long_set(&pkg_stats->rx_frames_delta, 0);
-	atomic_long_set(&pkg_stats->matches_delta, 0);
-
 	/* restart timer (one second) */
 	mod_timer(&net->can.stattimer, round_jiffies(jiffies + HZ));
 }
 
 /*

-- 
2.53.0

