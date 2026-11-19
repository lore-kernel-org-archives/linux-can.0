Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795126298;
	b=OsSdE3Bi/4YOptbA0ku5krux8tO21exnCM9WTOLa5hQfeC+vGmYKZ1XAPyyp5P5bvJ/b
	 9klg7b7vnoa0p2xy2WlM5arPT0SUN83vnMznJO4cdPRtL9TM/UZsAxx1F7nJTWu8gPYz7
	 Fjqz2GxZj9QmyolnDP+KaTf4O1j+UwVD0iHBxqM5SmZSoD2kKcyDgWmk7RKqL9UQ6VPHp
	 y56Tl+xcD50eaGz5fyGHLJmdXzakQ9KOAGrmiXTacCWYe1sdv4tnF5UDynrFTqPlEPTWy
	 u21M6SdPuJntV/+o0JYwLKECwN4YIttKnCobd02+IlU/Jl+AT31NVrWCxEr++VSMBvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126298;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lQ9wwLrAFV0mLM2cSFiaSgfWPzwnQiRHw3g4F4tzVB4=;
	b=vuiqu/EOkicADDM5k7vOlGCAXc/LTXFJPH/NjKXMtFbsYx1japkyKGomVpl79PGBYL3x
	 TzyDravjZCuDJ/hQti3GbYyv+R6U4VMPpd2RBw+KETJ4r4OgKEM//I9O/Ftz7otUcicZX
	 DfBx7bv5HumnvPo6fRBVQP+pdApToR1gEGQ84RCRYBl/alEgIq7qSBxefpgvhdPh6C5D5
	 tCJNMY12pKBzKYaJgoqEPRPAYWMC0OunreY1w8ApNAM2C4rk4wMOykL61PUuAFXmiI9b3
	 RW63UOq+xavrm+7l6WGE5VNGk8W4J8HR7Z/d1FBiNC7BiOMBD65WMQQYJakmIUYj8+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=amtXTrA+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C5060A2612;
	Thu, 19 Nov 2026 22:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26C5060A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=amtXTrA+
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4BF3E205B3E;
	Thu, 19 Nov 2026 23:11:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795126288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQ9wwLrAFV0mLM2cSFiaSgfWPzwnQiRHw3g4F4tzVB4=;
	b=amtXTrA+WghBQVEIaWpppOAMXSXVPGbb93mVzvHPEC9p4Etft5m87TY7fl9uEQabLXKakO
	oRIiS6SScK7BOPEML7vISYHetowp8VaOc/J9g1gEXpCt35c2y7cKJLosPScpg40EZLdenr
	uU3UwqUz6X2SXFU5arsi6aZX/hV6g9Azw5aiWRuzmA3HkDJfOPYbK0inTuulu/5YpdEMOX
	A6oAjlwcqas5XdFL2C1ca5pikISCJFVUITAGi/MuF0ZssMTY1uYOoYkkV5P03+ylo4Z2vx
	E8ZvXLCh2PuJqC4SP+JbNxuKUB4jITXUjmdMiEYFJQC8STVtS7uxgmQjXWi0rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795126288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQ9wwLrAFV0mLM2cSFiaSgfWPzwnQiRHw3g4F4tzVB4=;
	b=HQP9CuZgpNEQ11/cX+vWKpsSmd5M+yrIv/7k0HT1eLV/6u+OzKbcftGa21pvaYLMKh2iyN
	KxTOcDlyPEUKH4GM5w/34z80Il4kfFdLeFJFsFxwP7t9yPE4cTyammsKdsdTrlTf5hD/bD
	au9ElbWTomdAQvLzyeOxnbNivzitHI5i1Lk8LEmB4eER1aRFY2dXDrlsemshbCLRj9vZlm
	+3Y2KMn/lu1Ol31FB6ZV0Jj7pvNM4JuJQ2i6jr1r8ssCACWPIgz+YEk5OgJcXayEfpvsM4
	Yb0VnKIFCrKpdpkHgxyGmh/2nlgXvBAwxEUhkdT8Becj/lfJXuH0qqUiuLUQww==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795126288; a=rsa-sha256;
	cv=none;
	b=UJ3EloUW75ryjzUGjTVV1w4MZP6Wz1VyicT3uQFvveCKOpP6QArx81WaIcmLVh9BgGIE9l
	70AGx0jxEHXYrJEn2tbQvybNZY5O989OwE2jMZtVQgZW6XfKM5uvWz+O9AFyODRDl0uVyH
	473whdoLjGYLJiHJOMNiajBA/UJaCNVntZOyuEF32I9k+Hgan3xi2r3nr1PnqvYb85aDUg
	tkZFsnH0Wb51rnYRZ44L9mjHV0iZ59GJmdaSiuQQw8upAQiMGOF5d0LGywmkejFO9qnMu4
	yMhdiQFTzHr+ARn7Sgx5z4SzDsiqrB3+ioA5XzsyNFdU51vGrHev1SI2RPI8KQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xUALn-000Z6C-25;
	Thu, 19 Nov 2026 23:11:28 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E1F265F099A;
	Thu, 19 Nov 2026 22:11:27 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Chaosheng Qu <chaosheng.qu.linux@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 07/13] can: sun4i_can: don't discard the IRQ lookup error in probe
Date: Thu, 19 Nov 2026 22:58:43 +0100
Message-ID: <20261119220936.155728-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119220936.155728-1-mkl@pengutronix.de>
References: <20261119220936.155728-1-mkl@pengutronix.de>
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

From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>

This is a robustness and consistency cleanup, this issue has not been seen
on real hardware.

sun4ican_probe() collapses every failure of platform_get_irq() into
-ENODEV:

	irq = platform_get_irq(pdev, 0);
	if (irq < 0) {
		err = -ENODEV;
		goto exit_put_clk;
	}

The driver matches through an of_match_table, so of_irq_get() returns
EPROBE_DEFER while the interrupt controller has not been probed. The
probe overwrites it and the driver core stops retrying, leaving the
device unbound even though the interrupt controller appears later.

Return the lookup error unchanged, which is what the neighbouring CAN
platform drivers do, e.g. commit ("can: cc770: don't discard the IRQ lookup
error in probe").

A device tree without an interrupt now reports -ENXIO rather than
-ENODEV; the driver core treats both as a failed probe.

Build tested on x86_64.

Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
Link: https://patch.msgid.link/2a7cb6e4e1b494efd4da512abbf307c19d9d1467.1792118040.git.chaosheng.qu.linux@gmail.com
[mkl: update patch description]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sun4i_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 2a169dbf7813..7765f4ef6ac8 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -852,7 +852,7 @@ static int sun4ican_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		err = -ENODEV;
+		err = irq;
 		goto exit;
 	}
 
-- 
2.53.0

