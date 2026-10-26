Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793020122;
	b=2Tq/YEKiwqUkeJ5KjIE6AWsxq5HIIqXhw+h82xZOjtQvcVpjtniAbB9zSoP+FWPjGgCL
	 +G+I1hYgPPzqk6u2TtUU1Yg/XhHJLwYLjUjPB5Q9It8DPjgkq7WCN4lUG7bz/R9PBHfWv
	 eWY0lWQIhelZn1OnRJiwCmtuxPrBCuyowTEnk/7EGZkCrApX2iNVnSvTTy4Ceq0CRMYcO
	 D/YbvywFgV7auj8baowtmtnU02LTrWuUi1HtCU5B/bTgbXGOXXu9YfgYTFCij+VgMQm1g
	 LboKRW7Bnma5thg/wIuch+JGko1bHqU9C+zB68aZzEoOofMXSZq7hsoPV8GXqNQWKaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793020122;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Nu+dawTtCJs07taIh0/DxDgOD4/B8C6Q7zDwBtDhdMo=;
	b=uqbQz28JFbWV7AOpJZIxdhtBcoJcuv843OMXhQLDVCqIE1Wr8fIGBtf0AJdbeLv3KyHU
	 89DQxYiSQWI75aL1IDEFvWzr5p5qXilc+W0xEJ3SKXdeHVhMubXwsuGrMhprObcQVJNrV
	 bhOZQYgnQ6VBUIjCPAG6Hxqe0kzc3NBrP4y3NHKhABJcNl4a1ooa3QrPWdMv/7eqbx7XB
	 53HasTBIOFFVlmKkz4rjLrc5IvW8H5J8l5TodZAyy3EwmksVH4wiDK8o9LXnzoM/D++nJ
	 Zd+kROUrYJ0JpABY8YKbGozswULs5Li8I9OWTKXTNTWYVcRyZVsoPlmWZ5d05fZbx8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=G25jTbUK;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="Qr54/tH2";
	arc=fail smtp.remote-ip=85.215.255.53
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D16E606A323
	for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 13:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D16E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=G25jTbUK;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Qr54/tH2
ARC-Seal: i=1; a=rsa-sha256; t=1793020118; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=SNSRzyRAR7zXFvWRgUCuniApxdJdO/tc8TfagAbMyCn1NYwDtnuHi8aCwAGL2XTpBT
    oqdCJ9Gkq8veKNStqeWI1PRybPh7eoTATkeeTanI/B0VDSoEN/SIqa8B1DhRs8Pi4OnE
    oPNP0On3kD8uDhH/Qq8iGQwGh/ZMvnXhoZgB9+fNrG1ae7O+xY1BPgCSMRS17PrH9VD2
    y6aipYmUuMqOcRWX+v/keNRqePPFQtpiKxjNahMtVk1AaX2p7UzOI3VsAz6xIn47Jm0B
    LQbGj9/8Sx2/M4M9QDib9A8wRT76j8y7QRGsoL20zNHWW2GWBRnOZJbx7bt2tSDiBJxi
    m+Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793020118;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Nu+dawTtCJs07taIh0/DxDgOD4/B8C6Q7zDwBtDhdMo=;
    b=M1D+RiL7PS61xlOPnE5fiIY0ezzWIRFyD2ShWTyGfdIh4N9c22I4HUwDe4DWD6alFL
    6Yn6p3NQuvSxlshoOkPkFAtZ+1X71+EUvMABFbFh0Sc8Nr0osTS+mTh9tlG96V0ADpfF
    p2rbBxjlXDS6Dclqo3xnJRRnLNVVBTlsuUZAuhge990su4S7U0tr2dBLtIQiF2GTFUoq
    T8gZcojfCDrSkVHey/ISdLFGMPK31cINPhiRH9twhQq1kiEFOBieGp1VfRvBsnL2o9B6
    WGrqcYJGX+E0+KWDtxazScBW2+7O/sphuzlNz6lIn/Dpozfei3+C/d9zFwG/EfLYkoQE
    jSog==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793020118;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Nu+dawTtCJs07taIh0/DxDgOD4/B8C6Q7zDwBtDhdMo=;
    b=G25jTbUKMVq9q5wSiQiBQXSH8InVRPFDeeAb22mAlTTAeOeBKGEIk26irEdreJ72JL
    m3rvbGmgT74ivyYwCS0R2FhPLUIfDtS0xS3oBGx63XQBlFproY2QKnpexjas3xDm2YRI
    Mxo3pgWHPGK5uDR6dxxz2wpWZvcr5w6eYtI4+DWQGpxNxV96gxVjyMItYktNND83H6yO
    xU0IKXKI9P3j1H6PjdvnfwIIKOv2J+PYND/TLgasyn0jHBGfelcqXsMD1wOU0PgepFQh
    5I3wPLCGNxJUEsdP106oFc2l5Fo1oCotW3Pf90CQoVsXQf/65NfHYmGt0tvtHiKDLAVN
    RgUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793020118;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Nu+dawTtCJs07taIh0/DxDgOD4/B8C6Q7zDwBtDhdMo=;
    b=Qr54/tH2b1+tXg5xwP5x68+VOM0QVvz8JY8mLkTkGVMOzuHA45r5WD1FO8ppquqfbD
    5pZt2DDFTcQIkDj1oSAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29QD8c2Ww
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 26 Oct 2026 14:08:38 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Mon, 26 Oct 2026 14:08:30 +0100
Subject: [PATCH v11 2/7] can: proc: skip stats calculation after reset in
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
Message-Id: <20261026-can-rx-lock-v11-2-3b9a2b829dab@hartkopp.net>
References: <20261026-can-rx-lock-v11-0-3b9a2b829dab@hartkopp.net>
In-Reply-To: <20261026-can-rx-lock-v11-0-3b9a2b829dab@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793020116; l=2836;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=+5hJ80rWY4pSWIMbwYbqtFAao3PPiDuWjoVaSfLkTVo=;
 b=SFQ7rzSmiUD2TGW566ZFtgXLvEX1YiLV2BB1ROIA0z1TpxE3RbuxcvRVgetDNOBvq207EQQWo
 nRAWS7etVqKCrI7myHzq2aypSaiwsu99TO56JdV9vBJlOhLVOOFmx6I
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

