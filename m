Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792624303;
	b=JkI760EVWdPjcjNJGmL2rK3ROeUI2fbUA3K3dFE2crk5KdRwejhD1QEBXhmBF+G5+H/s
	 UT7W6rOulLj/VaPy2Zc4tIVDN4DBcNdXW0/3FIYyuk6EQRbzMVnzxLIXObYURmxZK36Ug
	 tAIjVdRBbn0TaNX5oVVZfkSS2dkefVCXoTscTDpJeLXGzAuGAdSZRIs9FUJWPz4OEzQA2
	 moKBP5w59rwGhJZi5cZL9Y8u0jUOralaUeNItainrejffLJCdIK+NBE+fCVKqoKHNh+jb
	 TXae+DA62bI91A+N8PCg/4wf4q/xDNgKKXwLMUUZfUVOs4v3gpA0lOxNN+wBpVHCm6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792624303;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=80thSI5HycD0mfH9L5G/r9XGQUAVEVqRZZah+I5MS7Q=;
	b=L4GrJ9YHzTCwsSqtXkt00fuhET+YaFA2Y+q1panT/disl1JF9ccotgASRrJIzaTPtuNm
	 gCX7d87QEDwHEE5QtJgQAmrr5asw1E0U6silcy6w8uPjloWSibVtrGFYMK1J/HvWjoxnF
	 2IA90NYBQD/WTaHa3bQlEqjyvzMJwzuq6xCJQTAYbJTCmV5p8acx2GDJhrGm14zgOGMKk
	 jr82saufpxLBCP8syCOgXgnCFHQvEoYA1eEx9soA895yv9lQTAp0WPdgt9d18uZRDaqYm
	 M9V5Ie/Z5Esu8Ghx7F5o/SzsfZQjSwaAUnIozFUVdEOQf5cbcDErewgRb38/7QnWwOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ZK898gyJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F77606A33E;
	Wed, 21 Oct 2026 23:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93F77606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ZK898gyJ
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B86BD201E1B;
	Thu, 22 Oct 2026 01:11:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792624296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=80thSI5HycD0mfH9L5G/r9XGQUAVEVqRZZah+I5MS7Q=;
	b=ZK898gyJe1mlQWxpyG8UNIiUFTrTQL9TgBrigeuJOisSkUzKpdnaqSXDFroKiYTAUS/EiL
	0B8Ewj8cGuN2qyifEjrbc88N0j9q3xGdcSqasyQFLBk9zo9yJkRMCzwKXrxm6fvbf1X7xf
	ZEThmFtdQGiqUFsvp65uRvlIygS2rhFlSiirCGFar2crMIznS91OoK5bvPoVmkm8T0oS7F
	d7Su6At6nczZ3CEX8SUs2IxEGS1TPXocwzRZhoUDH76MyA7bq17GmtxYIui1mM7+QLRUbQ
	dLBaCVrjSOBlZXWrwmLoAu+xPTMJIiLbWc5PMQ4wvUZaKO/8jXfJksSBxAX9zg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792624296; a=rsa-sha256;
	cv=none;
	b=E5K7EzLz1tS65m9UIX5V2Gcux2CFxPnSZP1Cnlh1mSR+wGQl3GkLl5tBlwS3t3CkEoEXcw
	M5o9Qh14msv5toXnXNQ/2/MwRrep5Pqy4VYSaccaPrLxRtI/d74Ss5yt3AMdWmjf2sM0CW
	7V9uNfy30iAcgBKIJazM03flpNyiuyOcjgNGpBI8dpeQwTV6WIIP4qmup2HDCPIsmkLbfs
	tNnTfBg3VlgBCaxSV4xNT/BKuEMaW3x6aERZeIhb5xPEK49n6co5rUdooB0l3HimeT9Mqj
	XSYeh+a/THXTtMATXpEAh9U5/iNzTSmG1aH7r00X3KCIbkxA2AD2goXDFRVrVQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792624296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=80thSI5HycD0mfH9L5G/r9XGQUAVEVqRZZah+I5MS7Q=;
	b=GfJQK9PFf283yFW9JmiJMf7V4wYqqGePPiwzP+DnZ/9js1lL2e3TucpdlaAFHEyVeUWPdl
	0sjM+qZ/S8jEcg9RVR5rINFvdJoAdYg4etH7orCHyf4ox8QjOIWycUNswGuD2UWW5ZpKlJ
	3ftBbFpgi26Dp2q5KoaopMM+fzxVOTWt5I1A7Vaf5qLm/K5fIPXJtssQbJQs7kYL4pjg9L
	ShD1itdMWro44KIc8OPfgpzJW55sgY7rcGh8jiX6pSrHgy5MZBCqs/FBYuRL758Zf3itG2
	JXPs3Du2BP33dX3hafg8Cl/q7RPfXNe+5sMV5Xq8/X6f9LtLEvY7pR08zplHYA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJfT6-000cWQ-22;
	Thu, 22 Oct 2026 01:11:36 +0200
Received: from blackshift.org (unknown [IPv6:2a03:2260:2009::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 15A6A5D06DC;
	Wed, 21 Oct 2026 23:11:36 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 07/11] can: proc: skip stats calculation after reset in can_stat_update()
Date: Thu, 22 Oct 2026 01:07:54 +0200
Message-ID: <20261021231130.2085690-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021231130.2085690-1-mkl@pengutronix.de>
References: <20261021231130.2085690-1-mkl@pengutronix.de>
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
Link: https://patch.msgid.link/20261020203257.230955-3-socketcan@hartkopp.net
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

