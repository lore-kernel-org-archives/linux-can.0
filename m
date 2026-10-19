Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.164
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792423676;
	b=PE9lnNZb79+loTFBC211YWnOwvnGqMFphiHUpFBy+0TzSC2PeBG3r20jNeLJV5Q18GM4
	 dCLfT02MSzUHxVWO2C+IefiHDYPp1FH9p+jKrUx3GRa512MmljYzu67/kUbL8RDq5roGw
	 9umgQN594ppzfSoNYEAV4/d0p1zmyCjI/u3MJIwoMOr4oxhc6V6d1kRlAQKvYLRL/WJ33
	 4IxcCp12ZTf4AdfaoLeFJlUJJqkrLkILbTO85jE4M9RS4gbd6JqulVy97LVcAWMY7/i9n
	 ks+ZPqP9/GmOKKDdLCzpwKpFdXWB6Gi9/DnLfgD6QKn3DO4TmcJASOVTgDs1C0vlZdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423676;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=LDkhaTDtgSTmn5DuHZM1hn+df8UAT4lyjU6hBRjS/4M=;
	b=I2GBuWs9b3B7WAtXwk05dE0OZYJ9GFiUt/WMsf5Nq4Rjrx7KcuDZjFrXLf0wF9fcMENJ
	 n89VM/7X/QTrR7yNwR4Z/+z6JjVY8r9x5kZ6+7+TOGX7UkE87AQM4AZOFyLZmAIcmMytf
	 xOIEKWynR69t60LJPxjBcTf7CxB1HHASpP5HvVYo8Cz63ykBS2KGZDfJsS3aHUVtw7jIw
	 sArqBT8DOcXcm+bIqWXtj+SDIni2WnTih1fvOvYG0gpo6AH+THXja5CigdM5IFOvYjdK9
	 d5PA7S5gnaqx85Pv2l8idPCssRxzxAGVtjhzDQWrMjJS0/iH4jA2kAh2D/AWZ6gmEQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=XBDcTK6x;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=KHvLWdEG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.164
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A37D60B6242
	for <linux-can@vger.kernel.org>; Mon, 19 Oct 2026 15:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A37D60B6242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=XBDcTK6x;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=KHvLWdEG
ARC-Seal: i=1; a=rsa-sha256; t=1792423668; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Ivf28xISoj38N6BhWH+ZAcwcAJhxiZn2WMPd5SLmcNViuBe+1FpKk7Vep0rq4OaZC4
    lJMJrh17R49l0x+U6hB2kwSik+MAEVcTcc7cvJoruiI+UXJjU6LFomE+3w8lsjKZUwX0
    LN2z9U1Srku1aEBxEzxXDLLvLLib4B6ijgOa/7YjAZH9kQOawINtNO6A7ryTpUA/4Vn1
    YoYqzgrS6gUVsj6phx8A3kBKQUv3A0waTvhZggIJPxGNXVv4XgURbxpLsIzmfbbII/EE
    1xVo4mtU271R3kwBBaaQSvDeRd8zsYrI0BpZ9xBaPtsM7OceNe1xxFnFYhRlD/PGAVGs
    nt4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792423668;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LDkhaTDtgSTmn5DuHZM1hn+df8UAT4lyjU6hBRjS/4M=;
    b=azoruvy/hU/u8LTAhf0E/QLECr/MD3Qko9qbm2CRRPyocPXtxCW6DxO1lQj3nBFNwJ
    KI+SMZUqZEg+HesFAx4cs+ZCHWYcVyQrJ+bYCJ2YmE3FVdY5DvooTvLgcQgt3Wby67hE
    Fj6e5O+r01tPJs4NbhBDjU6oYsT5bXyV84OMEKlYia+fJu1zETpHNDc5nQXi9+e+bDnQ
    ZesYRTGGzU1V5nvj+rIk/eqg+PVUWnfYIie1oTR/Ps4B9SIVLyS2koOOANiMML73mEjW
    m5MMQhKZQs/JslDEMwAEtijkhp0CwC5QFvrx9MNCS33FkR59jYvi+qyYEm9QElQny0ta
    LdHA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792423668;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LDkhaTDtgSTmn5DuHZM1hn+df8UAT4lyjU6hBRjS/4M=;
    b=XBDcTK6xJnE/BX2hIfWpXSCM+2aF7Uu3zJsiChIVhN29Wal+870smSd6Cc45F3L+ZL
    47i/yasmpnXomt+patrfa4U+oVXmwZKbJbJdK+P60eYNKS2Sg6dBjo6I5K99t3Haf9r+
    2xJFI4jYJYU6KtpJI9kOWNWjmLf3AUI9D8hhMVU6IiOueyi+R5bKgEsWFlCxeC50arJa
    jHbwR4OxTnwTdBzIVryLldJ2fS5e4KkS7DKY8SnWkT1qamkcM5TqRUQrHJrNK+rFuKus
    5XUZwCGxWJSg5/OihICs07AEHb0X8PvrK0Ecsu/QfDKi5AquQTqeaZhKcaj+3apFkXND
    WTSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792423668;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LDkhaTDtgSTmn5DuHZM1hn+df8UAT4lyjU6hBRjS/4M=;
    b=KHvLWdEGmQ72zj6FO6XZD3ZD6uvi6oxifM+hQM36bcdgQBlAE52M7QEsu6EqLQ1e/C
    OEQOKyZvEWURCWGhq/AA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29JFRlXY6
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 19 Oct 2026 17:27:47 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH can-next v4 2/5] can: proc: skip stats calculation after reset in can_stat_update()
Date: Mon, 19 Oct 2026 17:27:38 +0200
Message-ID: <20261019152741.54854-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019152741.54854-1-socketcan@hartkopp.net>
References: <20261019152741.54854-1-socketcan@hartkopp.net>
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

