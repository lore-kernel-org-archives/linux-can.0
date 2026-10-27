Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=81.169.146.164
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793111491;
	b=ISk5r5/71l35RlAGaleCe0U7bq/WAXxrIQC7SsydT7jXl595Q7otC+tgft6oI/CNdh5/
	 YtpDeHvli0RIR4FtmzC+DsdfH19anU3lc0pmCg7HzH8/xjyg+qfTAy45iY8awR2DDxsec
	 bOwUvInfP9Nk49KCQSHYiL0PZUmolpVXP862zdHGzTR4V95su+ZHFI7Fk5YZxRuqdrEL7
	 8S5aBrvXN35i0pialnBft5gTuwc/7qm74UPfxWLPAda+fwl5VXkWYNE0syI1qS65EaMVh
	 CFQjE9HE1Pe0WTYZlUaIrpQ1imqF0nyHwvgg6vODYfkotHYjvoawKBonAGLMeJizLEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111491;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=2vERG4MzxmSAiv42nYcU3v6B7YRkyQeKvkaQkDdMOBk=;
	b=lTw2a5IZJQ/Yg0c3i8ZVW57qF1u4i89bxqsay3y07t24TP2r6rayfd5t6vd7VjEOhMG/
	 UY0sjeijV+YaUjMPfXlrnK1F4xuoW2HaVOd/k172g2e+9Jn4K+98SZzx/2vB7EgyogwKs
	 VWHyETZputfGbKs9bBgwRDvtbNp4NDT/lLLSh08na6+G899XRFLzoJLyuJla1qnVnr8Iu
	 F4oDo3SZqRs2J2L2qgZPBhWRha5GMCp1Rz6Ns1YJ6CV9HEopBnB+fdlTOo8ljRL6PyG9M
	 t+lkkrVUJIApehQf74sxoHqDdxiJ4jcqJUzsAn0WsmFofPa5THI22S+r+ss2Wuj3kuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=KbasyMBe;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=4PnW5ixM;
	arc=fail smtp.remote-ip=81.169.146.164
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB15606A334
	for <linux-can@vger.kernel.org>; Tue, 27 Oct 2026 14:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CB15606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=KbasyMBe;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=4PnW5ixM
ARC-Seal: i=1; a=rsa-sha256; t=1793111474; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UtfcPMvWHTROZZVTdUk6U3qwFZHKZ2YS/izBjCVlN4Bf1FXYcmOed6ir2aA5IPR6R6
    TmkK/mow+TMSKaLDG18pF4dPxJfCRueiQy3YkyC4MBcIWeI2BWDCBDqUCx9uEpN3wrkn
    mLO7L1h5AJc8CO4lydtYKy3MnoaI+ZjH1HRU6O5whXiyA4UpGFu9iRYBOgtVtBbqDnhr
    7xT2lcLIiCfuN6W2HIXvLR2/s+2+5WYBIF2cD2ixtCKCLBcib2qm4QU2brE5lYA3Zfrl
    +tJH1SXyHw4hsODiLEsig5EMoD/8TTKxVYfUJZe8613EQ3d+kftm9z/fXEO9gtUFLK79
    /xiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793111474;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=2vERG4MzxmSAiv42nYcU3v6B7YRkyQeKvkaQkDdMOBk=;
    b=b39AtQRUFHQYxkj+OZmYRJTk6DtdiVhgEDUggO351j4a6MD6KvG+DYP0fdYK2s+98d
    VfLrLC+/cNdM47AYN20Gl2Gv/AzeS/UJruDD8B4iu84cJWMePW/hXR0jJNUAQzWfJzNO
    Jro47Hi70jVHRp9zi6eeyOtgYbcbxhiUBxkCXsd1RJBASOUMPzlEnUMGG8RMWobX6vQi
    HcRpWQVoxdyxfS23rXxUfV6mrAKCl1mWHepbJhn7/IcLrwSVMnHUqMl7Rxm6jFXPNFkl
    7qJNZkG5HKn44KeqJFyhwGoPd9YYADvYLVKswZTIXT5+0yH8JtcyiqaZ2ZipCj4p5uly
    J0sQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793111474;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=2vERG4MzxmSAiv42nYcU3v6B7YRkyQeKvkaQkDdMOBk=;
    b=KbasyMBexLlphfRSEz2MZGy9ZQ2ivmyg1wYEn1NPw9yY+m5Nj9QG5WemSL+Y+AOpoa
    IY2xegv1iWm4kXHt5D5uzVRQ0wRHZ5s181J4OB5l3EBtAXonpOKedWQEs//z8YcJmzVG
    d/paFgR7m85dJSPkXbygsRWZe5wC0HwzSTxI5x/T63FrCd4voXmWDvGBZYIfYrpL5s/T
    1+t2Az80UQcVijtjtI6HgiKuN62ljoMtAX38plcBbe6BiQJj7YnuQB2rKOdSo+/lCEnV
    nK9RGAu4nLHMTiVC/Zwx1+ZsDy1FsIUinPt5h1/65ecFzxHsIR9FrgOAKCRJYjyhG5YB
    cgdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793111474;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=2vERG4MzxmSAiv42nYcU3v6B7YRkyQeKvkaQkDdMOBk=;
    b=4PnW5ixMTtLbfznv2decgfekkwqDxLDBhf8Au4Jx1RPwSzNf3VILeacCLdZOx398DA
    sUerwoAx5xJvDLvCS9Dg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29REVEAL7
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 27 Oct 2026 15:31:14 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Tue, 27 Oct 2026 15:31:09 +0100
Subject: [PATCH v12 5/7] can: proc: reset pkg_stats atomics individually
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
Message-Id: <20261027-can-rx-lock-v12-5-eb5afc2d8b9b@hartkopp.net>
References: <20261027-can-rx-lock-v12-0-eb5afc2d8b9b@hartkopp.net>
In-Reply-To: <20261027-can-rx-lock-v12-0-eb5afc2d8b9b@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Runyu Xiao <runyu.xiao@seu.edu.cn>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793111472; l=5940;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=4adCuMrjhioutB2EuMqX6EiQZ+Y/aNwpPzQeTK1eHFg=;
 b=TrSnOeU9GeKnnDLvLyiPRynr5eD5bqD+ba7neoga2Z8Xy0rRQbVPD231Yj21ncSi3mKJYoRJf
 IKkLuJKgxSRAAJoF790acSUGT8T5vychGm4eOlo04uz6FeNGWqaMXeJ
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

On x86_64 atomic_long_set() is a plain store like memset(), so the
memset() is an actual problem only on architectures with lock-based
atomics (e.g. parisc). The inconsistencies seen on x86_64 come from the
*_delta handling and from the stale snapshots, which are fixed in "can:
proc: skip stats calculation after reset in can_stat_update()". As
before, the counters are reset one at a time and the derived scalar
statistics use plain stores.

Fixes: 80b5f90158d1 ("can: statistics: use atomic access in hot path")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

---
Changes in v12:
- commit message: added a note on the x86_64 test results and the
  architectures affected by the memset() (review of v11)
- v11: https://lore.kernel.org/linux-can/20261026-can-rx-lock-v11-1-3b9a2b829dab@hartkopp.net/
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

