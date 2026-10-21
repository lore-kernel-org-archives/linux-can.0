Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792578484;
	b=d9XpazMKcWnHjZmo4//7PaFVlSdUps0sQEohXGBTkENqhpAYuiN0q7hF+H9BVsnbremr
	 MYnEXwWvQLOMYfATxEvjhfApRJxEwKkbbnPS0SKGs/YyARKKeT3eXN7hafqf6RuWcvjDK
	 fYbMAayhe7l7/hDEIcYuRLzmZ6o+QpzeeuA76PtYqD6ZwEapo5MRCH8ybASmpXq6QASHq
	 CIg2By2zZCLqEUgTM0URBKbQXSqOrE1l0BAxURLSSmVFQoWtGSdrfmA/VxFW+zbf0WsKl
	 I6DacFWnhTaipdtEf/v0sYIme5iW2jb31XpIYY656FyeZNbIrDcEnJGmWVHujvOHDWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792578484;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=80thSI5HycD0mfH9L5G/r9XGQUAVEVqRZZah+I5MS7Q=;
	b=VsDXJwxHWD9AyiJK8DzkQgRsxbWsg0QdGXRWA8F75/3SBglL5dc27xlPGb6HOYNyYU9L
	 ZHZVaxzkWTUFLZld16rShh4Uo5qAb3vuUraK7UO5ykEEc3vROVjd2i3oQ3mD4m6rjDg7G
	 2DOtBXAGo5zeZeBLj7DkC8P2gNnMLDQb9BwxgbZ7L2FrZjTzMKpnPWQtAee2hXhtm/PTu
	 YeE911Ylw0skdPCwJlgn+BTbQwJaWi7C+LoOkuM8Z55omEds7Whw6wo/cW/kyfyuWv4zX
	 7OrfdDwRfCYZwOq0hH1ZI3dl9diJjfS4eluv0PfPGssOYWPkIsxLUo2leEadA5IQj7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=KGgRQetK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB24606A336;
	Wed, 21 Oct 2026 10:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EB24606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=KGgRQetK
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9C381202923;
	Wed, 21 Oct 2026 12:27:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792578479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=80thSI5HycD0mfH9L5G/r9XGQUAVEVqRZZah+I5MS7Q=;
	b=KGgRQetKK6jYHc8Tl5dCIcHfaJ4gK9GFK1eU5pgxRpxCKoXHkUObkcmRfa6+X2LiEo6LFP
	LZB/G3MunwVKDFiVZJq7xy3iYIij1kRIfCQ1INCc5Su2VJKR+i4Uute0danYWHoUlqUkHl
	cAE7FXCUkJBR/lB4FeeOFC0/8Ya1ZsGqpLRnJo01RDzWdJkv41ytBsqxtkkL18YKKFklF+
	sNJVnoIVFLRl9V+IipWOn2Hmc6nbmNonF/k4vgabjao+qMoSjVFv3PXaYu+YwkGPvDFOkp
	hbxpWtH6RF/0gW1uyodiq/J7S+4pUtd7p1pO2JWdD7pZ6czgtAt4KmmVNtFE6Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792578479; a=rsa-sha256;
	cv=none;
	b=D3VFb76xK64ajMR4uiR6ueFt5ArPv2ds9iYRZn5x1Kt5u5HU3+eCsvCFzCnTUImXbclvKD
	Sw6JArnCPFGwgykjBBdUIdbx10e6cOnwghWabuAkXo2H5hVBvXmQ801dEIoudA7ESDGA2O
	HjWdeWhkzMsBmWk9iJ7YJqsjss6g5yPV5UzpkpIhIf1doI/yQPKrLK3xxT6cpKvDAHZzVP
	FFH6Xbg8bUwr81KIARDfvLpDuWUwgYl6zBNDVfh5cXBugWNLQmIwB9yXwUBEohpBqWp0Cj
	ogRgLRgFubjfcCP34Hf8S5h1nf/n0YxBR4tbwTkrIZR1pQ2Jpirqai8ijhohmQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792578479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=80thSI5HycD0mfH9L5G/r9XGQUAVEVqRZZah+I5MS7Q=;
	b=Z7OaVo/w5mclz8E74XrnIqbs+StYyzIDZZAjvcC8hvI4VlYN07WiubKaNlFvaFiGx7C6MB
	KAH8s5gV4L91sJ0uT7Y8aQTYN6VnQhY5Gsfd5jfWVyhZ59EDM0AOYOCFDh2PB+QIw8CkSq
	iEwHt3+NC0V3ourYGlk415Bw/TalYBrKtJjeQD/JFnwGpvk2joxnoxMtZuoZi/7OMHzGlH
	lmDL5INOWpZWjexuX2FhyW6d/lfutqLm1yICzdkRqVbNdikhuwG1VyNgdV0fTk2IRVInQG
	1yEHwGeKH7elgio/dDYEY/imkKJcBQquMhZZrZLHztWRxebKylp162BirUyODw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJTY7-000Xjv-1h;
	Wed, 21 Oct 2026 12:27:59 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 405BD5CAFDE;
	Wed, 21 Oct 2026 10:27:59 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 07/11] can: proc: skip stats calculation after reset in can_stat_update()
Date: Wed, 21 Oct 2026 12:24:38 +0200
Message-ID: <20261021102756.1900679-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021102756.1900679-1-mkl@pengutronix.de>
References: <20261021102756.1900679-1-mkl@pengutronix.de>
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

