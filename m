Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F462384CED;
	Thu, 15 Oct 2026 01:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029231; cv=pass; b=j6eotXYvxku1oDcr5X5mmhEiJUaNnGWy/dd76roVe817Jk94vvBPXyekfKWNF+KTkD7xwxYwshokSXzlKpAlz7H4alYUtJ2e1/+ll66BnjqodhAmU9vWS26ZTPRbFPprAz2oIM/pV3vpLft/ndknijUh2BQTG4PBq2YJgSx68kQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029231; c=relaxed/simple;
	bh=qVIN//guqGfPGKiQx0IFwMANHyBVlXhcNzDRu6VEetc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKjeNwaSAcSeDTL32dMzjL+4jouIoqyMqRaAmTk8flzetH9jc6oRQM3dNsdZX2p9z6h5p0KaTpF+f3y0PYrvgKgM/iIHBANiJ5Fr6Bain+0EtlL5c0gGywHWWY68oCbutZozGq7v8zBnaf9xvZHxY7OGpAqdrHwgQI2enLN8H0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Ohe619HO; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Ohe619HO"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 71A4E2027DD;
	Thu, 15 Oct 2026 03:53:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vlv92SHJvtZUCAByXdSnDChuuDaFxY2/0vzXIFQANXQ=;
	b=Ohe619HOAK55dATwAAFAucyzixvORkGIQKhVph70eV0AsPM69fNz40JjYwfcKtp75Mg99e
	TcHCmdb8UjNiGoFAla4Xx31RF65tT0xjY1P4nj/HI6iWpLVt5ogVuhb4sy5Tr14gtwR8e3
	4PQSKMm3LXmz2PAvF2ikqWJkQXpYt3HW3Dtusf6jI2ZJ9I/QfoxyRDmU687TvROa78RE/T
	1KPUxDVXlj7lr/WwIcSZtScQ7UQFno6Gv2G/E7eiNiphGUXs4lGbVexcKQLqO6zrCfHoBF
	62m2TeIphALFoVlZyfq9lb4mCgaKc1+2fc5ZUkN7/aKcH3QVYqI9bF4x3B6G5A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792029221; a=rsa-sha256;
	cv=none;
	b=T5/8cmI6rBX+/9QCYSpql6kgfsB/ADqEvCQ2gCiDicZ6ZtfHa1Fogf+lXaDZPjsyci9Zf8
	EmMSMbBav8pOGBMM8r3uNcsxgMUTQjvo63zROdbH4FJ10Q8gR0PBS+nx2bxzrloZ+/HtLN
	sYjax1MlReIOwoaAWOSHXiaFsvW9MsECcOpQAEdhWEveresG6Ls8FeX/q88KdZGXNlOOVX
	59cG1STQ7gBvTq4V3nxxc+N8dPnw6BJ1XieZ+hn8Hl3JouovCqsN6gnHM2dHj3jwtEA+OQ
	XMe0SWhPrpJ6IuoFN9POC00WuvVSYyeJGqK0XutExhH+eu3MsGBkfdTy/RUYpg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vlv92SHJvtZUCAByXdSnDChuuDaFxY2/0vzXIFQANXQ=;
	b=XhflX/IxISZve69yUJMMisRsabCi88LTj6/oowATUVJOg6zY4EbkWys/5c3vFGJe0BH9gA
	4tHrBN6dJivWt28Ud999mQ1hqZixAXn0/JAs8cix8lJIod/upFnyAzgIAdYqWrp9ts6CGC
	Pe2AXQr8iSkYROd2F+B0vGVMQvXFRYlQ/fBzbrrFEF+801H0uepiAX4rS6EIrOaIi1mh60
	aeiyPYFQUfgZJKgc7UZQEu5qvEpM7xHsjzyOvx+XH0VFeB7j1AknU27LfUvnBVxfngpExG
	Mu9xl9zRyc9izxJBsUzddSwDWP6mcUk9UoetHXvGc9533VJtoKwNRUAHhr5KOA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAf7-005wqy-1A;
	Thu, 15 Oct 2026 03:53:41 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1C2BF5C478E;
	Thu, 15 Oct 2026 01:53:41 +0000 (UTC)
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
Subject: [PATCH net-next 22/37] can: rcar_canfd: Add support for Renesas RZ/G3L
Date: Thu, 15 Oct 2026 03:40:20 +0200
Message-ID: <20261015015336.816543-23-mkl@pengutronix.de>
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

