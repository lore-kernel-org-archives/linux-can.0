Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90583387596;
	Thu, 15 Oct 2026 01:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029232; cv=pass; b=g13ybyVKoeqMbtOP5JrNno/Bp7S516TVDH7SJVjmDvGcDpdrwPjZLHXdxx4tnB995f9Xcu7Hro41/mSyhnRW+S1tO0Cznxq7hOTXYS8V78SPG87VD7Ubaz7XFXw88bExvPMoNy4qNEUlEGckX9/s5+lwRR7yD+c5e6r60tMuUAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029232; c=relaxed/simple;
	bh=Q8tq2kJBgkiifQFoP4DfObd8XW8al+m9Vb37j7tSduU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZm2MzPdEtYdJzIihLFH9MK1+1mo/cPoWAaVbVJ1ccO+hyNbbrbj1QQcV5arU6OGhoMEvIz/apzb6CRL51z/cCPflc7pO1JDgTKjNqvFaYi3CuuorwZ+A0LWpwrGXfMOfyNO1GCOG21qNuH+pF+JhYTvWOfQ5V3A83rPn9WBl4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=ep8BwyHn; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="ep8BwyHn"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id DB0C22027E6;
	Thu, 15 Oct 2026 03:53:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8LNYjFUdef6ciEIJ+B13NMVIpcD15hZwINLB2eZN9Fo=;
	b=ep8BwyHnjSLdIhY+PSn6dAe0Klq00JI5LimYydgQV4rajw8AM2HZO565tDXK/twymQkzcJ
	ZZAtsXF/OLkqd5ee2KslBDP8NZEbeip4VPMbObxkjYSO1ibuikHfxBYPN5B83/zHKxM+W3
	Ai7hIw/LY2UQtHOa8sMOFwgWEuRkV27/sG4lSD/IeD9RGcmWVnsRbd8zBUtun2//J6aqhH
	pV7eC14zy5HQ+0ejBACI3p0Fbyal0jvmH4zDCAcxiHabpzOvafT7tlmhWRDHzgp7Yvj2XD
	ieX5yfVwEAqTpxXGyXFmh8yCyewHWFjTUmcu5ZaAYS12wsw0H5USILNIRt5LRw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792029221; a=rsa-sha256;
	cv=none;
	b=W8Cp83l4QMEOY5D3XqdaXCDSe6JLf8d56R3VS7t7KMoiv7F+Ch83oHdmIEY10BCEoiFkbu
	yY3IezO1oYTxrZ9Dkmf7fg4g3pnIqDpKaG6OIQYifndCTHVIvmteyscayYgI/TEr3G+ERC
	wgEv4NkmitqDOHnv6yjavnrgEXeFU0N/5gU5G/oJcZEHHMkNtqdeWlRTaLaoyyjJ2YB15V
	0pMinGnlaO3b6XkONFtuf8YzopeZIytIBCI9vBbyRGjFIrY8IQLzUS6Ov0kTFu+45+yss3
	Ua8PDzxB+vBe8wxf34DQRSvFRArMP8P82txyBb2QNJ1H4VJJYaDVePjbTljY5A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8LNYjFUdef6ciEIJ+B13NMVIpcD15hZwINLB2eZN9Fo=;
	b=W1pvfE/ywA5IvQBl/+430q0wViH/dyyhEaeR9GaKOGhi/T9Uza8yQKiixYBEwiHuNLGAlj
	R/NGJWBqyW5KOsjMtOdFgNF1DqV+h3SYZWrtY6B5CakA8y1DRAgD6iNz5XEO960fFfSkbn
	UFauHUaL1Bi/BIVl2ZkTFOBaNw164jlpzRfn8ZluMMYpcOgEmCp3Xc274R5m0KlBYnZTHf
	20rtWioO3cLmm+OU48e+aCFRX/GMWLvHXIaAKB0JEgkuuDQlRTBpg5Dv9RwzyEw195ykNf
	1vc97jnzD6b05lChKPdFo2Wp+K+l1ro/usl9twiEfXI6woT2kD2A1yP7dRE3qQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAf7-005wrI-2b;
	Thu, 15 Oct 2026 03:53:41 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 902D95C479E;
	Thu, 15 Oct 2026 01:53:41 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Quchaosheng <quchaosheng000406@163.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 27/37] can: cc770: fix the clock divider check on the platform bus
Date: Thu, 15 Oct 2026 03:40:25 +0200
Message-ID: <20261015015336.816543-28-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015015336.816543-1-mkl@pengutronix.de>
References: <20261015015336.816543-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Quchaosheng <quchaosheng000406@163.com>

cc770_get_platform_data() tests priv->cpu_interface for CPUIF_DSC before
assigning it from pdata->cir:

	priv->can.clock.freq = pdata->osc_freq;
	if (priv->cpu_interface & CPUIF_DSC)
		priv->can.clock.freq /= 2;
	priv->clkout = pdata->cor;
	priv->bus_config = pdata->bcr;
	priv->cpu_interface = pdata->cir;

priv comes from alloc_cc770dev() -> alloc_candev() -> alloc_netdev_mqs(),
which uses kvzalloc_flex(), so cpu_interface is still zero here and the
test can never match.

A board that sets CPUIF_DSC in pdata->cir therefore gets its system clock
halved in the hardware but not in can.clock.freq, and the bit timing is
computed from twice the real clock. The platform data example in the file
header, .cir = 0x41, sets that bit.

Assign pdata->cir before the test, as the ISA path in cc770_isa.c already
does.

Fixes: e285e44d91fe ("can: cc770: add platform bus driver for the CC770 and AN82527")
Assisted-by: LLM
Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
Link: https://patch.msgid.link/20260917114311.534863-1-quchaosheng000406@163.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/cc770/cc770_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/cc770/cc770_platform.c b/drivers/net/can/cc770/cc770_platform.c
index 64fbdf14e8ab..ac81670762c7 100644
--- a/drivers/net/can/cc770/cc770_platform.c
+++ b/drivers/net/can/cc770/cc770_platform.c
@@ -137,11 +137,11 @@ static int cc770_get_platform_data(struct platform_device *pdev,
 	struct cc770_platform_data *pdata = dev_get_platdata(&pdev->dev);
 
 	priv->can.clock.freq = pdata->osc_freq;
+	priv->cpu_interface = pdata->cir;
 	if (priv->cpu_interface & CPUIF_DSC)
 		priv->can.clock.freq /= 2;
 	priv->clkout = pdata->cor;
 	priv->bus_config = pdata->bcr;
-	priv->cpu_interface = pdata->cir;
 
 	return 0;
 }
-- 
2.53.0

