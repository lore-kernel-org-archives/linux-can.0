Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765634DBD75;
	Fri,  9 Oct 2026 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553423; cv=pass; b=YTtBErfwu/HnQDMWeCcieS6ovU2v/+D7x8APf9kwWBPv5ylRe7pVNPYcIBEUZHorl8iR41FifPtNwxjfWYp20XRF+uesW+nI3ixKhaT7wwHAWFe7Z2PeUbiwvp/Q64arFfVrh+TzQ6ly9YO8gu8HfGs/0XvhjANpDeCwS0EmA9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553423; c=relaxed/simple;
	bh=qVIN//guqGfPGKiQx0IFwMANHyBVlXhcNzDRu6VEetc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWI41quFiJ48HQzgSBZ6PIqOKfSINE/I5WTQa/OQNgxccX8Jw2Wj9VqC/oeMGMPNaiyfVnxjt24dIp9/Ov2utk60TvYVuQKNm0tF0WbEXybXMLA80CKhBLfGDOf/C7zyYD72lxEeGWX4xfFVR/mfoy3NBQgBfQV7zspHlfu3Og0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=YQqvq3Tq; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="YQqvq3Tq"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 27F7220264C;
	Fri, 09 Oct 2026 15:43:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vlv92SHJvtZUCAByXdSnDChuuDaFxY2/0vzXIFQANXQ=;
	b=YQqvq3TqUd6PQ3uUCy6BPW5PJhv7LT9LC87EH3QidpU/B7+3mpGAqE5xJPOhGYi01QPs7j
	uiUgt+wIgyxHdy55d9zhu8jrf1dk13j7WFxNQYy8subU1rpvnB+tRK0GdYyjFsCLRBmvOH
	fwDUNB4uZC2f640DVs1hLgeTIGaALJ08dJpS0JBV13Iq2yr3Li0Y5HFgjuPeywPmI+WT2I
	FOmhh/BFldKAnt1wD7rRLNRxvTaa0R30YVrThSTxMRgr/yrQcKRwNuWuxT+aHchSSpCDxm
	8KoYBnHVkrkL+QmJ1swzNsZsAL/yAryWw5W2W8nqI1lfI/ciqGAhNvuUV8dDAg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553417; a=rsa-sha256;
	cv=none;
	b=Br8J4596yWl7ySw9Jz3kgkZy16YTfRSNTXZi72x4yp8xOVP6OgUdSLbCbIQWV9SsQZCoG7
	thot/mWZ9MI5MKIM/4lNtDS3DOlltJN4PpSNK+b/A53L7egr+lb0rvjHqsgO1kiT1iaghw
	ll/PSm1H1aTeCyj3r4n0QgYpGDyjhvP0vouGPp0cchr+Urlt4WSVd3yrQvi1kCcWI45JcH
	NJJGep8IGFJ/3psUykts7eLhfuMIvkFXGNqBLfrA0To2ieWu/6z0rrRztifSrBwlhDA8tg
	fhdg8dmSUr+YSFe5BldxWrw7F8IPNFr0Hhzl1FTd3gtSRjgffQm7FiaEhUhe8w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vlv92SHJvtZUCAByXdSnDChuuDaFxY2/0vzXIFQANXQ=;
	b=Drh+54G55dl39S/iNSQZKOlEAhq5sIOi58mUPw9J/OTVkQUaCd0mUc1zM0eiMzygnQwC6L
	HLb7203afEdLYnTF35+eEJG49U/S3/LUB/rMQssy79gnRvf6GWhAnRTnIs726LNTfP5hFj
	00hSu2EBI6LSPEfNTTFRlvcWTX7BwxBj0H2veLLKNzwKOZV3owegnZEGJO1djsoLpv2r7g
	a5VNCU9eUWSNjj3AJgic6Qh2cz2xh0pdS37O2hD1WNIdIRFCbyUIEOw353u+yTpHtaIVD6
	XR9ly46p76ASshqWJIUoGxFDZqa3zp0YQfcXlakDfThU4YBYfh4IFuCVmAQIoA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAsr-0053Si-0A;
	Fri, 09 Oct 2026 15:43:37 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 94F475BD8CA;
	Fri, 09 Oct 2026 13:43:36 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 19/37] can: rcar_canfd: Add support for Renesas RZ/G3L
Date: Fri,  9 Oct 2026 15:27:51 +0200
Message-ID: <20261009134323.64064-20-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009134323.64064-1-mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add support for Renesas RZ/G3L CANFD IP. RZ/G3L has 3 channels and
11 interrupts, compared 2 channels and 8 interrupts on RZ/G3S.
RZ/G3L has 288 buffers compared to 192 buffers on RZ/G3S.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20261001075742.21961-4-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 41c395118949..c64387967368 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2403,6 +2403,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_canfd_suspend,
 static const __maybe_unused struct of_device_id rcar_canfd_of_table[] = {
 	{ .compatible = "renesas,r8a779a0-canfd", .data = &rcar_gen4_hw_info },
 	{ .compatible = "renesas,r9a08g045-canfd", .data = &r9a08g045_hw_info },
+	{ .compatible = "renesas,r9a08g046-canfd", .data = &r9a08g045_hw_info },
 	{ .compatible = "renesas,r9a09g047-canfd", .data = &r9a09g047_hw_info },
 	{ .compatible = "renesas,r9a09g077-canfd", .data = &r9a09g077_hw_info },
 	{ .compatible = "renesas,rcar-gen3-canfd", .data = &rcar_gen3_hw_info },
-- 
2.53.0

