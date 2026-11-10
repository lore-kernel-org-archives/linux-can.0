Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794311482;
	b=Psi9kq+ZxbsgiCMzHkWg35O1gK7HOBznGcFNeXbugbckAT8YGcDkzj6b7fAfLv2gFkyr
	 JlPUy0io0ZFa1GoIBK7XfI0Avq0O7t6Bonh09klXYaRwTHvVbMflT1aNFvVdDQYoDS/Qh
	 CANK+8IC3vDNLs9CL0FqPF1vTf1FAFfjbHKImpCqbtjUhGdPfm65GTh21f/nWWiXDA2L6
	 D4zKnOBd06QtveXJzU4SQzG42E6mqJsuDPAPKH1CXNlpb48Om66Qox0wI3LrG584PGkcm
	 IPszyYrSiMfgU0t9boTnk4HSKWadRwQTq3WDRqkZWEJFeVRTNsHlOdj0G7h09q1FK4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311482;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=07D+ZqL+AxGOoZb0TLP/9FjHhX79ToOWxsLpEGb4hNg=;
	b=FUudjLbF+vqDltqTDIZrYTcI7EG2TjZyu2MH6Mq9jqBeUXQTIkOOazvNqCZYukcRr9A7
	 SPPNyaT74wHSu+TqRzFl/1qdtJWhTe2e1o2bu1Y3j784OGSyxUz0eRVBqwcbDwNpRGrmw
	 ZVSORGDIjL3w9IS8GcKX34jqLklUneHvL1yPKNAJVmn/IiWENZOmljlbTpDB/KJpuBSqE
	 S1qdPZnxRSKSyQcIQcTNcPkngEPUAnDuLPSGABfP+rxT98Si7szoTCGMUOIC2oq1Ym2Aq
	 RLn0Yc66WY9J1fqXvtys5yezv1/1FTxMHBH9lWGNf27QowZnaitgZ4gDrSj8AG0EcmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=WwqHZVV+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E4060A3817;
	Tue, 10 Nov 2026 11:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6E4060A3817
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=WwqHZVV+
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2AC9C202826;
	Tue, 10 Nov 2026 12:51:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794311477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=07D+ZqL+AxGOoZb0TLP/9FjHhX79ToOWxsLpEGb4hNg=;
	b=WwqHZVV+XpJGJm5bw/nQsbsCp3pZEerdLBCUm1Xz4thzd5lcskn62+7yfnWAmPLA4UM20P
	+/lPrklulKenLfptVqoQVvjjxgmRaaVYYu3nQvQ7GK6BuqF2YOWayvY3TdH0VAhOIK66mO
	TnzNhFZ7Lxy42FUS8l4qRZtLPhd6gihbkDkq97wkXboBj5sIeLJgiATrszLdUv3D6pvAEv
	ZseeiSXrFiG64W4f/m0iyKobo0dfv52VQEzdwK8PvG4/DJ+HHocrLiFMQtM4M6qwUkJcxP
	NKdWEE5+1oUOP9rJoFPIH22ZXxJy27gVuS91Ep2E4LOOkMMMuq6KVnAVBSL/cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794311477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=07D+ZqL+AxGOoZb0TLP/9FjHhX79ToOWxsLpEGb4hNg=;
	b=VZohHaB8nP1FsfDn4wSMN2FuHKxfD3S70w2bskvvYqzdFtry8kTNLdgAOVpUJf7FiU5/QT
	MxdSaYwcyitRYfpBTEBjr8P3cYNJUiWi+VIBKQZz65JUYjML+fiVgrKfa4LEpfCyC/tHk/
	s+ZKd1hbFS/iIvAwM4F8kmKETUWaz2NBMnOMd5xECQeNPeQeXEv0f0MbesNk8UM03SS+XN
	/Ajy6Kjc7aP0eSXpDXV0sUwLrz9Fom5UV9Xp8To42WVgJCm0o3bq5L+a0K+VFy50KJ95EO
	AFNzUm7nytrjGMIG1nwcxoBKrfCgFKEJlhwYT5ktayF8QZqiyNRASjGY45GAow==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794311477; a=rsa-sha256;
	cv=none;
	b=A/5a2gJo2GJ6Pf1KVLg+Ko725g+ynfMgD+nIGjD5jnnIILetJUQuWDM0LTpcLIGdJejLMv
	vcxgAAHndF4i9JgNOAFlr9G6Y6NYTsWD/bzZeVR/21G0dVZlNalvSUQllR5436vjVhQB44
	4WckfgAVXvbLf+OwjWHX3zUdZhHfvq0WjpRqEcpzkQRWgwgfQBy9LFLdP/dBCBXO68+ORE
	HWIvDIxynrp38bTAFp40xdNu7VQxLTLDy8kh3es9pPRUZv95GA05cpsc+bDU0ufPWmOFf0
	MGN5aXUzOtUl94w9XJvB6+bsSEXFNI12tzThWryxN4dqEWPquaVnuT7tQL7FHA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xQkNh-003UEw-00;
	Tue, 10 Nov 2026 12:51:17 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8FEF85E688F;
	Tue, 10 Nov 2026 11:51:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 06/12] can: rcar_canfd: Check can_clk request for errors
Date: Tue, 10 Nov 2026 12:41:29 +0100
Message-ID: <20261110115112.3807247-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110115112.3807247-1-mkl@pengutronix.de>
References: <20261110115112.3807247-1-mkl@pengutronix.de>
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

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

If the provider of can_clk is not yet probed, devm_clk_get() returns
-EPROBE_DEFER. The driver treats any error as can_clk being absent and
falls back to the other clocking options, so the wrong clock may be
selected instead of deferring the probe.

Request can_clk with devm_clk_get_optional() and propagate its errors.
While at it, add a comment mentioning that the canfd or fck clocks are
used as a fallbacks when the external clock is not available or it is
described in device tree with a rate of 0.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20261019121356.2421761-2-claudiu.beznea@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 74c3c3f20991..bb2d03b75142 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2220,11 +2220,14 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(gpriv->clkp),
 				     "cannot get peripheral clock\n");
 
-	/* fCAN clock: Pick External clock. If not available fallback to
-	 * CANFD clock
+	/* fCAN clock: Pick External clock. If not available or its rate is
+	 * zero fallback to CANFD clock or fck (when info->fcan_pclk = 1).
 	 */
-	gpriv->can_clk = devm_clk_get(dev, "can_clk");
-	if (IS_ERR(gpriv->can_clk) || (clk_get_rate(gpriv->can_clk) == 0)) {
+	gpriv->can_clk = devm_clk_get_optional(dev, "can_clk");
+	if (IS_ERR(gpriv->can_clk))
+		return dev_err_probe(dev, PTR_ERR(gpriv->can_clk), "cannot get can_clk");
+
+	if (!gpriv->can_clk || (clk_get_rate(gpriv->can_clk) == 0)) {
 		if (info->fcan_pclk) {
 			fcan_freq = clk_get_rate(gpriv->clkp);
 			gpriv->can_clk = NULL;
-- 
2.53.0

