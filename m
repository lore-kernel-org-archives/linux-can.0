Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=81.169.146.219
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792528393;
	b=b6OWtLgl5x7eZ8Wzumm/JsZhPWZUP4s5x78ClZoR+3uHsqb1rmKGjP8Et30+JIcvD9SM
	 IcxntmlrbW2F0Q2mOCFefuE0OC8rbiRnpWb2kfPEkjH7dz8pnyIzJGeKUdorzPBDHtM4b
	 ZUDLmS4y7Dc81JuZPaAjrxKEyOerEPPVYD7RoA3V9KsHAygOyzeavJBe8gE9ANW0a+sVO
	 UEH9wMVW8TN8ODHjL5EQ2xrMZDm26HvENC2C1XTiXzRQN4oiwmSnuAwPtaSWmvSRJeUZr
	 ZsVkTDhTKmCKtz8a+kLSpL0gn7ay763rKVW+07QsuYhZDyfJ0c2z9ERo0nGwp2DRYmQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528393;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=LDkhaTDtgSTmn5DuHZM1hn+df8UAT4lyjU6hBRjS/4M=;
	b=t168cJoE0fwpHemeVYYhXC6te8DFAXmU84XbZJBATs3kVwzFs9m0nAU3VODpu0tBzFRf
	 nnFhL274vzfMsifMJHDCB+a24qD3UV8uvJIMiVm50LisIiec6Dg18GMxtUV/YVaIpi4pG
	 hBZ2o/GY5VCV1jQA7VFpd377luamOgoLf0AZdFkrJZ0ZUWEWeDiPeZnOsK4PNd7+f7pjl
	 9O6yWZTJJt/9jTsbrqzVmRYbRoMF6PKC93L6nfmYLu3xTqyK+fIsDKSinSjfpnDX7/9Bs
	 Y1hLnIptY1F3Y/UzLJzxdeYUZJMHK4uwS4b8KP1V282wK7Mi9pE8uvO744EjFRZw85A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=temperror header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=D5IYEUTR;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=tNnCkBNp;
	arc=fail smtp.remote-ip=81.169.146.219
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974E1606A319
	for <linux-can@vger.kernel.org>; Tue, 20 Oct 2026 20:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 974E1606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=D5IYEUTR;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=tNnCkBNp
ARC-Seal: i=1; a=rsa-sha256; t=1792528385; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=L0NXMk8yFjo+dUSujVUb2rwb9IISeXAyuFVU04TS4JsvQCueIUysD2jPlaqP6PlFHs
    FH9uX2tZh4K/bUGkGG537rz2FIyGL8YDukpqjgS4w8FtWqwh+HLBkI2fPcENTjLdl9HV
    Ka32Q5MKBnfuyo4lQxQKJQk9WKFDtKlIEGdA69btfrSfrvaHUvjjOERunlK9B36ArjG4
    YUCzxFzwl1nCkCZztMZ+ffaT+L8yP4FgTHfDxJI0kwUneq+p6fuFtan2iHC5sI0rJbYP
    YpD3h7V7NhFLGYt58rA6cpyYJYBq8cEnfSFZFYf1FZxIOxuEzaS3i6LcVUu3hx4rlITS
    ouXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792528385;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LDkhaTDtgSTmn5DuHZM1hn+df8UAT4lyjU6hBRjS/4M=;
    b=oJMLr8rIVWQ1N/MzR209ow41xCIA+pwX4ReFZJOES9btEHIjUd1nJyVPFM3uQ1FRj7
    K0jSF1vIFs5Az/P1+itl/Y217TJFpoCigPfOnI+N3TJdRaQu0j3K7G4rrhC4xx111+Ey
    6Ab1EE1e34G4fRZKs38yJsUzJey2iduonArJ0CngIuP7OBvUlCxkWrJAi8IltG0jk0Ol
    QXq+G7129zFG640dF0HQTeyRyPgUsWWgaZs1eiMRvDOU++kWbyERaoVxXXsnHLrLYtDW
    OO2pMDoMbKx8q01gKvmRhokKu8bAMxiJwWnL2Xq+kFQrrXy2TXe8wZWLQFL1e1zo7dEy
    kyRw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792528385;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LDkhaTDtgSTmn5DuHZM1hn+df8UAT4lyjU6hBRjS/4M=;
    b=D5IYEUTRO8QrDK6+N4JInwVivXPjyCC57ucGS09hTsurIWAXChbh4Ac7Yi9j0PFk1u
    OD/Fq3V0elAQJkQ/PSEnUqGOe/TMsvQ9X9LHzGm2gLkXx/2+jzVhovwhbLb49pI2vpSp
    36l9BptUxDR5uENuQ4erPXaU7JvarvUFuxtX6uShaOpfKBRMn8XqalaXpad6NY0ZZyjK
    kIYnFqCVk+8Klzx3lgHRMaIEpGrrLkliXtJsm4NxZYO5yvEAhCWegc918YD8deT7FiCY
    thBCt24ATa5yURaYneRhNmC8BlZUxtwVP0FQdaOOdyMVViO81je61Ih3adbWiwgm8VCs
    xOow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792528385;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LDkhaTDtgSTmn5DuHZM1hn+df8UAT4lyjU6hBRjS/4M=;
    b=tNnCkBNprwgLysSPefsOJReosddB5lV6nUzxNRRWca9k11pVeX5LEb12xcVff+twJE
    8FItsPZLFjJDWutqSqDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29KKX5dMq
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 20 Oct 2026 22:33:05 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH can-next v5 2/5] can: proc: skip stats calculation after reset in can_stat_update()
Date: Tue, 20 Oct 2026 22:32:54 +0200
Message-ID: <20261020203257.230955-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020203257.230955-1-socketcan@hartkopp.net>
References: <20261020203257.230955-1-socketcan@hartkopp.net>
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

