Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792963988;
	b=ervYpfxRw/B9w3TNMuKpFgukXSEpyqdnZ9As+ywnYvddnYtG8R7bcdQRuBO8STS8MV3v
	 m/P4vj0YTNKzHHsiaTWH22HDeXb3zro3Ctjpfaiu3ZgBuJCeMyXRLNp7MIDw3EP4WCQJd
	 MbsFu9faqsP+5WCXWTkOcZrsNMmH8KhMiCGiOuE3J3qxSmiBgSIXvY1aZUkZCqT0H7buA
	 ia9cU1/Mmj5MpcC3USnTDiNOnFp8RlLt/Qw6+vfcGwi9FJNvSShTTQhGzvGI8srpnpjYs
	 OBcAxQQ86tZHrtbJtz34cyFUmP1jCiBJxiOjtr9AjK6LPO3IFhZxWF6z8qZgz4AGrvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792963988;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=revTEDBrYxQTBJEeO0BqfGYRwYY08gjkaZtSyNOorsY=;
	b=BNIcuVx5zqP2S4fX6BeBTWtC/SsDdfMIwpEQPIlocHZD2jbMiyWCd9YPtiOwEpvhwSXA
	 DxlJ/HnS2gxNnK84qPB11ojkzGhG6evCeDSXsPtRo18xv8NEyoZ2AY8auUqY6+RSJ/hyY
	 pj4db5Ry3wYhzLyaoKWzOWX05tZ+NRC329OSZXXTpJoxLPUJkp0NLU8S/9z5uvG5fsN7H
	 uE3As5Uf27yilLOLkXHEalfZAz2GkNOhXID2OZ5Ih4wRyYJ/H8D71PO5FtjfxlnTU/gY1
	 VkAIj9dtVdhd5McQ/E/fyhAEVNxCg3SPHBlWzNlRg+qLbQjFkklV5zpmXuQo06F41Mw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b="c7gMqP/E";
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Wox8PwEu;
	arc=fail smtp.remote-ip=85.215.255.54
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E20F606A31E
	for <linux-can@vger.kernel.org>; Sun, 25 Oct 2026 21:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E20F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=c7gMqP/E;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Wox8PwEu
ARC-Seal: i=1; a=rsa-sha256; t=1792963980; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MdSlUztgchuX07YDmfiFIME5FIBK+rHxilbU2/qBB0S4JApLza9UWiSa8nG4iTE3J2
    JYVT5fZQdo9w49Q1fVr/1/xTmbWrhUN5RgO+Wt5aui+CFl+qlV1WceaGBuTeGO04ZSYt
    yIhdHYKMMPniMYQrggteikj14s5TM8VdPj+Uv5EY6CVdXdTjcpu+tyU53Jb9luEDbj0P
    CpCz5X4yLvRobLxj+BUbfqIZ1351awZa3tci+RwGasmmIZ5WEanzS8CoQHPpwP3qrPoj
    OGiCRbFDDCxsIZTj0BCzheekDpXnGHFomG5kW6OuKrbOPvFwPcJiqGpg0qOunuRWtmXQ
    rNrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792963980;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=revTEDBrYxQTBJEeO0BqfGYRwYY08gjkaZtSyNOorsY=;
    b=sPz1pmhrkvZxdYW2nZAGVnN2ks0bhvb0K1EkEpOoqRZXVs1ZJ0BzeFqcKEyZa2iaCU
    JG7+wTuUllGNxGpb7DXjqVmO/Tlhm+autvvYVmKjPa3UukaAmKi8U9qTvZ9fVAtxc+vC
    a5kobzWG0Y1qxdoC7UuGHzaq48KKF5qXOP/ir6gjiAaj/nFOqWKthXolNslVSSLLJEOK
    z5+rSLkWEKfRZ0ZMCrqhg6pBifMWkUsvP5VQ6ARZfQfmkU/KbtBZMRNyUoiYS9cF0IB1
    SdUZabSK8dElAiAwk/nHbwMQnNO/IuvfiznAgMZaPRBev8re99A+ILaeBCr4poFUHK2V
    vSBw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792963980;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=revTEDBrYxQTBJEeO0BqfGYRwYY08gjkaZtSyNOorsY=;
    b=c7gMqP/EsJwKQf8Apr3+C0RTuVfPm1V0RjnVp18SZC0jyI62TUtbLbUJTTdlKGpv8R
    GKX1ReJxNSjDEZyP/T9z2FavrViyVHJAd+bxp9OXe/CVpZ+sX8XUdN5uxGDkZpKueVqp
    yoh11fDr6R0Djr+r1g+p7XhDmOgJi0mzPTN5Z1oGMBtGwyGj0kc1LzXSVbzcWNUvZbS/
    T4KCvlyxJek3FrPMwmDCPy67BPnzZEFNkhJo+j3ZDoOKsWIoGY0gtvqIVGkOaeRnP6gh
    5Alwz37kiEh4xAf9JOHtA5661ypk1snSx9IbFgRyDGBJ2pElUvTMjuVVHpevvX2Zwtrv
    WtCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792963980;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=revTEDBrYxQTBJEeO0BqfGYRwYY08gjkaZtSyNOorsY=;
    b=Wox8PwEusLjQMyPHabo4fkhqsdZPF1nOfP23ZBb30zqls0+VYjebBU9Ej3vodqcMq+
    CrxYFqqZe6EK5SwId6BQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29PLX0z7x
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 25 Oct 2026 22:33:00 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Sun, 25 Oct 2026 22:32:43 +0100
Subject: [PATCH v9 1/7] can: proc: reset pkg_stats atomics individually
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
Message-Id: <20261025-can-rx-lock-v9-1-7ef2a2b5c2b4@hartkopp.net>
References: <20261025-can-rx-lock-v9-0-7ef2a2b5c2b4@hartkopp.net>
In-Reply-To: <20261025-can-rx-lock-v9-0-7ef2a2b5c2b4@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Runyu Xiao <runyu.xiao@seu.edu.cn>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792963979; l=5243;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=IL1mXqjDNcT5FWPKkirex05OmC25HeREvNFpHdeNVZQ=;
 b=j6tewW6ZumJg/5vvU1Xb4yKVXftQfb0VV3iJTHr/k3el5gZyqMbqSQZH//WNzUwEhMgssiZu0
 86xJQfSiiSPCBJFaSTOLhfOdGIPsDY++xgfiPhiKjQ3oiAg0DZP4yDj
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

