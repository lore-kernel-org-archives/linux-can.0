Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793020126;
	b=g+JGACBk0TRTD2bty6DaWIvxsXDipthWibCelRI3Gtd3JSLabpqdRC68fdXQWz/DUK3j
	 Tnh5wr0LzvVGYIFRovuEZZRE+AAuBbTFR1ePRyPQFBM3ufhpWKNZZoiLwwGV6eaxpbXdi
	 9y7lTncp8C71+5MWGu9QZnddWWGRkozDGwxSEQBNGhgUsu2NRmKK9ft87//Aoni0HxJLJ
	 VIl0U1wSNMGbBad0VlPUz3eoQKZrwAgcE+CoHwV8NxPk3ZgLT1+kBobUj6k9oot/L5COj
	 rUbrhVqKWZ64hS0HhnOeV90utgkXoBO7RhNPaa5sbKNwavwXdbfgJRKAJ0+ZR8XL9OA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793020126;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=revTEDBrYxQTBJEeO0BqfGYRwYY08gjkaZtSyNOorsY=;
	b=iUDrQRdBHDnZyKrPEs+GHap/ZPMPnuFZHaayp0tZwiYcMiQWTzBGC4BfkEPJJy1UB6wc
	 1CeLdYYpzuvLpgOrAQT2u/afMKOaMqouc7tiej4S4c7keSAvndFOI/Iyz7r+Syq+B9vkc
	 Emg7jPDvNUilFhnCoqUUoltbEg70Ounn6acfSmBh3V3HWRtx2M6J/1FNL6XiwT0AkWCnp
	 IZDk594H9F1J1C9yOd0aUSusHyNkNJrXshUb6LPHwu+da7kvFTtTSnFTMezLLdpVUgp3L
	 O87IC0LQe6/J8jr1J4wCA4skMwfEB3wDpUrycCUJI2IX81//mx4bxKwAOivw3g+CVBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=fCFg8lwT;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=SiuhjD46;
	arc=fail smtp.remote-ip=85.215.255.52
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DD6606A322
	for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 13:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8DD6606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=fCFg8lwT;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=SiuhjD46
ARC-Seal: i=1; a=rsa-sha256; t=1793020118; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kcnY2m9xgmf5m43JbrCro5mvDK+1aC2pHcdu/s0GmQogC/lfsXZcO42BW/ckVWz/Cv
    WBN7u+blF3FsIDRT7bFR2XpyMayaowzHgGy/c9VasvfIAeSX7OUcL//gMD/p54tV90Et
    NdKA3C1odwzwjgM2JGp45X/qkQqsJHMnyJh8EnbQXCm/YSw7KGCeP4bIc5h/ARUHXxVH
    UygY1U1eK7N3g7W4QZ1I21vrZm2ZQESQmIjosWdAH2zu7xYDPMioLWhw01LlBim+Uv7R
    kH/Rgjm8qR0Dro470nHkAjoii4wjSYYxyoV8Q85II8bjh3HSZ7V9H8nSqC5+pS0356BQ
    bFBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793020118;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=revTEDBrYxQTBJEeO0BqfGYRwYY08gjkaZtSyNOorsY=;
    b=S8Wa5KQCy93L3BBx6iPQ3b+ZakDDO22UhYtPyGwmECVe1zCLxFdNTXdAxueteqNJ9b
    Cg9CnJ8NgGTkigyA9boPsv0R0t2b43kAf2DRyVfrbdri3LgP0GIXjU94exFiAJKWauXY
    6BEoM8vmy/fSX4/kwlRCWlyziiWRi1qsULuqkgctgC//PbSzhzhEjcF8KVrSkGVl523g
    Pu3zcnMSl7VguDVB5CFW5GdVq2ieG7FxiWQ2YLPS6gXKk208fj0TOUF+FdaVSaM5naKG
    5+2EcJA7qonWcbXFne6Oq4ifLZdzORHjL0wsDK0s1vF+QeFg/eUnjHVQKzMfiUh6MymI
    kGgA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793020118;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=revTEDBrYxQTBJEeO0BqfGYRwYY08gjkaZtSyNOorsY=;
    b=fCFg8lwTbfDitcSTlO/Nsd1jNGW1yvyICyK04hFC3wGD/E7emEfLb7W6OPeC7Egod4
    g5jhU1Xd9GsdUDRTS3tdwL0lzrhj9SuPGUyeyvPSuasGTOFp63YFDkF1soSrOQyKGUfX
    yqRT8Nfg3JS60ygLwh5zm7J94LwbXPkb2HoYQF+KIkXaeKHOZIA+W3cPvG8N2sKls2rA
    wd/JIxH6gVR9yCPzkUxAKqBgV+ovODQjtRSUszKdAE1Xxnx7MsuEsNWa5asaXhN9jD+7
    xKN5gxLay9FeLMVYdZLzt5r0NL+GgbVURFF0fYY0WL8ZjaqhTzUKrOaKKjDjDBJ2T5Lz
    dhvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793020118;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=revTEDBrYxQTBJEeO0BqfGYRwYY08gjkaZtSyNOorsY=;
    b=SiuhjD46pBMrZD/mp0FM0k6wsENWFYO5OkGoATCMOMGKrXKGVA1kbtRLdc9u4QbFt9
    MLbhI6hbQmPbHb8uCxDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29QD8c2Wv
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 26 Oct 2026 14:08:38 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Mon, 26 Oct 2026 14:08:29 +0100
Subject: [PATCH v11 1/7] can: proc: reset pkg_stats atomics individually
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
Message-Id: <20261026-can-rx-lock-v11-1-3b9a2b829dab@hartkopp.net>
References: <20261026-can-rx-lock-v11-0-3b9a2b829dab@hartkopp.net>
In-Reply-To: <20261026-can-rx-lock-v11-0-3b9a2b829dab@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Runyu Xiao <runyu.xiao@seu.edu.cn>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793020116; l=5243;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=IL1mXqjDNcT5FWPKkirex05OmC25HeREvNFpHdeNVZQ=;
 b=h52f+Lx2houv5zhB/xfjh9d5ySZVIz8d3mrti+jdXpN1NVZIPp+kb3I8khrdAgFXWVG2MvNGj
 L5yoDU7ZAHfCfHyLeI9MgIp0TisZxdw4DKo7GP2EUX0xdmdViW32TYw
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

