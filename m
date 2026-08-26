Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1F83BA241;
	Wed, 26 Aug 2026 12:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787746245; cv=none; b=F66NU/scsRmWlRRp6mzqwRtwAl6HBIfEIJ6v5dpd3/XIqV6lvjTvffxuApo1mqeFBkyBRpSJUMBph4KA5R8c5zb0qPR12J1CvVc41lGRDI2W7AGG/3LccG4NMqyo+LeVDsc6Ek98gO5+CemsMs/+ctcVbwqiR31dd3pyOvLFvjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787746245; c=relaxed/simple;
	bh=jNlTWjIk7F61+bcdDumEGy+AzrAJ1mB0DzOkAUF0jZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sI1rDUejp5lKjom2VLQXSiaTm1WVpFej/vLCVLVr9DhYdJ/UQs452fBBdF5SEspsX+X/q1Cz+jBVgFtkuX41JHiCxFQxC6hQLF48InIx5hbYyNt5NK+Dhz9dAgRhRpPCofXl9ZUI8/wFYiBCPalQzm/5fbbfOqM6139AJ3Pq1i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A6F6E2021AD;
	Wed, 26 Aug 2026 14:10:38 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wzCSk-003R8x-1k;
	Wed, 26 Aug 2026 14:10:38 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4B43258CCFB;
	Wed, 26 Aug 2026 12:10:38 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Sureshkumar S <ssureshmsd7@gmail.com>,
	stable@kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 04/14] can: bittiming: fix bitrate error calculation on unsigned operands
Date: Wed, 26 Aug 2026 14:02:14 +0200
Message-ID: <20260826121036.2706424-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826121036.2706424-1-mkl@pengutronix.de>
References: <20260826121036.2706424-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sureshkumar S <ssureshmsd7@gmail.com>

can_calc_bittiming() rates each candidate against the requested bitrate
with:

	bitrate_error = abs(bt->bitrate - bitrate);

Both operands are unsigned int, so the subtraction wraps instead of
becoming negative, and abs() resolves an unsigned int argument to its
int branch. A wrapped difference is therefore reinterpreted as a small
positive value instead of the large error it actually represents.

A requested bitrate far above anything the controller can reach then
passes the CAN_CALC_MAX_ERROR gate. On a dummy_can device with a 160 MHz
clock, requesting 4294967294 bps reports an error of 0.01%, configures
415584 bps and returns success to userspace, where -EINVAL is expected.

Use abs_diff(), which subtracts the smaller operand from the larger one
and keeps the whole comparison unsigned.

Fixes: 7da29f97d6c8 ("can: dev: can-calc-bit-timing(): better sample point calculation")
Signed-off-by: Sureshkumar S <ssureshmsd7@gmail.com>
Link: https://patch.msgid.link/20260803091426.29050-3-ssureshmsd7@gmail.com
Cc: stable@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/calc_bittiming.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index 4809f5e0c96e..2789b99ab6a8 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -132,7 +132,7 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 			continue;
 
 		bitrate = priv->clock.freq / (brp * tsegall);
-		bitrate_error = abs(bt->bitrate - bitrate);
+		bitrate_error = abs_diff(bt->bitrate, bitrate);
 
 		/* tseg brp biterror */
 		if (bitrate_error > best_bitrate_error)
-- 
2.53.0

