Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792429733;
	b=VBSlvRdnJ5ubxG0iUB11OeyvpqsZSPE41Uxm1qiOn4S18bzXEaztoSVRGVzGIOUeQZe9
	 zKvojgbVfU3UG3fXXcNEjOLR1oJvK2dbgPjsHxf52heM2bcRM+rbVJXwOwFqw8H1/xv7i
	 oyLqAL27bZRxhmSjIR97nUfVefzx3UDmgSTOm8fRcZ2gpPtUGR7pTtYq57rDDu6q9PY3r
	 jcYCbHvTMVkvU0MBeu5QVGhWDgBvfZTB7HNabjzG/9WEqLkxfNy57EFgI33E5PDl8fVGu
	 VBOVwDYOW7TiX6DsU2rXAjhftnSqpyiWtk4oLrb8kFasBpB7fuS80q04qkP+NrA8kWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429733;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/ULyDtvIjdL2SEeKpGxjVjKuaqF1qA5BAfXNQ0bxDh0=;
	b=UlHDgbHyhvInCwut8+uyWkwT822OUbPX6hGOTjz8LQHLmA+Q5Q2kKkF2haofMmzOJV4l
	 n8P3K1sngtT7YA1w+q1VHnXKksZti1UTKBTMbc/mROvUiSZBBTAkAW4eu7LkeTv/3LDRe
	 aQ7+MzKRl5uBRdsgQpbYqTRvipOqgN/tAriyyWapj12lGGpqGXmhgkuXt1xGCva+pzpse
	 zuLgzH3Js1yKOUQ2/A9/ABjqPMToYQ5IyGIl93cfRTDg6832LDpuMDQGshvIBQKZdPSvW
	 1Sv69qW8GQ3/YmIOVdrEHb157Bu50dVXuC/8kDmoAggNLBIPJ967DGimCO/O+K+auig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Oilltc4F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC53606A339;
	Mon, 19 Oct 2026 17:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BC53606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Oilltc4F
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3B197202857;
	Mon, 19 Oct 2026 19:08:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792429717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ULyDtvIjdL2SEeKpGxjVjKuaqF1qA5BAfXNQ0bxDh0=;
	b=Oilltc4F/WMQtjSinT9CJuU06FrQIgdhzSl54ZDHYjQtHqn4gE4/MLb/9IUVfqh+DW707d
	DbrNyI8cfrE3PVT3OtgSvv40hj08nazE0fIZ1/Xyf24tvA3H6E2YXjvB9XJL9hE43Hdtq6
	fch/SU8UnNhE1DjFFj9l+tIFXyCTDdOBgJxok98mdYZyjEw9DfJeQRXYrs8vvXm5J5kJ2t
	HIIKTFDx/wyq4t/BU9UzWjSgV6w9SVecVOi5qQ6GMs4nmuksxupkeVS3uIWfQGSyQw0d9O
	Bzt2qCZh1WFmJMrx18LigdbnvB6cRiCWOwmbxGAptQNZs4RaW7iQi0Kzd8LhXw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792429717; a=rsa-sha256;
	cv=none;
	b=KGA8WZU1pcmMfzyjfpsD9He96sgQ73g+oGO1KGl5RUo2ocO10cT3Fr1HP+Dv0y16tA2kCJ
	MZLZgf1/0d917ZhGl6JPF/FLZ0DSZnyPknhTkaGyxpcHHwmKjpMeMw3J0oLEJWHMrd0Bjh
	cnwG9FHhLT+gY3TnAY/4pEreTA8mRuFlxF8y5D5+IywxCStYCDMCzMuHLjm8NoVYUplmoR
	JNUpTTrU7tYS8D9pylIeoT5qeFWINYlQ4i7N1jQ2rGGIzbhblQwhsIdlJhc7P8AogE3pOv
	j3TsNXggbYU16t2Wc1c5U3MG8xxwkN6g3BAcRW5MSsTdpbuaSgNXXvjlZY8Wzw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792429717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ULyDtvIjdL2SEeKpGxjVjKuaqF1qA5BAfXNQ0bxDh0=;
	b=AiMC4DRPBZbJ1qTbQ7ROvYhk9+OEkAMnJu7f6VVD/Tq5G3m8JsN11IJjXtK7FJ5bwNyyHY
	hyc8yJc3ilVVhowQFvmWoOQvYy9bB7pkZrNUa/D/qw0vPpO7vp4ZzHwWSX1ALzJICBNgMc
	jiOHh5sX4zVdQWs8UsgcUTIxUp4VXatNlKD2xX4cEr1U4mARd75WWnMTn+aBKt/5X9u4dG
	lfwxSjBQHLEwtgstfXvorNTXS4c4FRLNx8hpDW5yncC8RxmKGe047Hti8O5VNRuyIRJpNq
	w51T/DTjaPPR2lOezH+C+Tj2Hms3sOmiV/xJB7YD8gu386Y3Hy+95KJ5C9Mn6Q==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xIqqj-000FgR-0I;
	Mon, 19 Oct 2026 19:08:37 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C9B465C9492;
	Mon, 19 Oct 2026 17:08:36 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 08/11] can: proc: skip stats calculation after reset in can_stat_update()
Date: Mon, 19 Oct 2026 19:01:13 +0200
Message-ID: <20261019170834.1727150-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019170834.1727150-1-mkl@pengutronix.de>
References: <20261019170834.1727150-1-mkl@pengutronix.de>
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

From: Oliver Hartkopp <socketcan@hartkopp.net>

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
Link: https://patch.msgid.link/20261019152741.54854-3-socketcan@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/proc.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/net/can/proc.c b/net/can/proc.c
index 70104f13077e..fb144d2adc35 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -149,25 +149,18 @@ void can_stat_update(struct timer_list *t)
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
@@ -196,6 +189,7 @@ void can_stat_update(struct timer_list *t)
 	if (pkg_stats->max_rx_match_ratio < pkg_stats->current_rx_match_ratio)
 		pkg_stats->max_rx_match_ratio = pkg_stats->current_rx_match_ratio;
 
+out:
 	/* restart timer (one second) */
 	mod_timer(&net->can.stattimer, round_jiffies(jiffies + HZ));
 }
-- 
2.53.0

