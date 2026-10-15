Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E07136E47A;
	Thu, 15 Oct 2026 01:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029232; cv=pass; b=HYVTmJR10WbAqNF9rlsySISn3UkmEGeh1UYvjr4t/RoAkBZd+tfFwglwVCJLtK8mrQojtNVtRanTuJru3bQ+ncykX6QasOZYjSqDtBeMelG18IOMTx6AxqpaUdqmyHyIcW7bsbhdR/yXtGS7ijYcgJkZyEI49O6jKmFcXCwjLpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029232; c=relaxed/simple;
	bh=IttHcJ0OSTOlfGH+JJK5ZP/UFEwnle/riB1BzbvHXG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ot2QE6BZNfx91RLzOe+ZFX/OOpgWC6nVFpQ4/vXVG/AyPnNR+UOEiXL7/yrqEj/wmMl0EwR+cp4UExVLZVcY+rT42Sm7eJQjRxxPpsB0OaPZOWFLPU1bLLndd3qXwpMQZ2b9556lhoDaHY0Tw3JhEdsRDWcicyLuRrtaYqj/7gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=LrviNoUl; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="LrviNoUl"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B4E0E2027EC;
	Thu, 15 Oct 2026 03:53:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nA5lyvl0xeHdQ6oEcgtRAbywu84Dc+Oye8Wvzdlhmws=;
	b=LrviNoUlU1nfKwkz9gjywz/ZzT0H6wNNAmKDdYrf7J6jlqAHkDJSXtvTeN7VS900TlCAJ7
	KTsyQbBwn3p7/OjowCr4RHHMs5pjEbFxqomEl0hMshQu0rLPOgffPbGS+nO7H7Yd29qRSV
	YamEqA4FHqG8WCDV9JK4h2L7+J3z9tSAw2706d1f5fkInN59SAX2lKUgI7D7n7cMZzVXp6
	4BiGZ/TK/2m/AuEBAFr8jFs2vpLr3d98mX38/FPuBP9V5Kj2PuqpxEAs4wUm8N4vzETpAP
	eBgwYx1Lb4Ik3gmDcz08vE9XNIt8ujU9uB1Dgqv5sT5TIE+6uGW53Vh+GRjnXw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792029222; a=rsa-sha256;
	cv=none;
	b=P1KMpSY+xicSlkEiNGQiEQOiRkudQVv2tuwEFz3gR9YQPkETEWCd0uOidY7jdoHVS5Rgxh
	YYTj+tggGOny/IcYX9G1hDkqM3cB7nYtFLDbRtOiT0FJrscOveuntCB5q392IFKBax0Pai
	pSZ2mV6kBYzVeRIngscxjrA5CyPYTcfna7ErQZnA3oja+4oJVH3mIJc1R/vM5EAkQygZQg
	sGudze9XDuG+k9NgiE43sZ0VaV6L6FAmKabDXJD8Zd0U9FiPjd9bFDR93wCRR5LOSwePv0
	uIv4Zfmyh+pQhP4M0RLIOZcNVOG8N3UWa7Our9sPbVxuNhV4q0LU0S7qKtzvlw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nA5lyvl0xeHdQ6oEcgtRAbywu84Dc+Oye8Wvzdlhmws=;
	b=QNjsud3v63jDKUh6Wb4H2qeWWJOIIiDAyHqr/qwHPx0Nn4OyXektzSEBgRmyyDvXghMHFR
	5U51qk8zHdvNyxs6nxKb/iUVt/iz/W+1at38++r2eyWIbqLfpIufLJVVWGVSUlUQfpzZy+
	gDpljI9521fHKRsZ77XE9UkNWwPGZdGCWlFCT5NYTRk/jvzI2GoC0StMe5OfqwFVMkvkGb
	cUmL3rtymPGnVElV7QKc9BVsMZa3P1E8R2mTUmX+qszG0xvqmOq2v+l2bpMlLl1dD0GKpF
	o5LxJpKOP9R1MLCMSqL326HKDPaVgngbHeXxns+RbVY/vxmqTclzeVUfWuh3PA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAf8-005wrm-22;
	Thu, 15 Oct 2026 03:53:42 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5CE165C47BC;
	Thu, 15 Oct 2026 01:53:42 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jiale Yao <yaojiale02@163.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 34/37] can: mcp251xfd: mcp251xfd_probe(): reject devices without match data
Date: Thu, 15 Oct 2026 03:40:32 +0200
Message-ID: <20261015015336.816543-35-mkl@pengutronix.de>
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

From: Jiale Yao <yaojiale02@163.com>

A device bound through driver_override need not match an entry in the
driver tables. In that case spi_get_device_match_data() returns NULL, but
mcp251xfd_probe() dereferences the result while copying the device type
data.

Reject devices without match data before continuing probe.

Signed-off-by: Jiale Yao <yaojiale02@163.com>
Link: https://patch.msgid.link/20260925133716.2230252-1-yaojiale02@163.com
Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN")
[mkl: update Fixes tag]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index f441f2265299..8759bc05bd8f 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -2213,6 +2213,7 @@ MODULE_DEVICE_TABLE(spi, mcp251xfd_id_table);
 
 static int mcp251xfd_probe(struct spi_device *spi)
 {
+	const struct mcp251xfd_devtype_data *devtype_data;
 	struct net_device *ndev;
 	struct mcp251xfd_priv *priv;
 	struct gpio_desc *rx_int;
@@ -2222,6 +2223,10 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	u32 freq = 0;
 	int err;
 
+	devtype_data = spi_get_device_match_data(spi);
+	if (!devtype_data)
+		return -ENODATA;
+
 	if (!spi->irq)
 		return dev_err_probe(&spi->dev, -ENXIO,
 				     "No IRQ specified (maybe node \"interrupts-extended\" in DT missing)!\n");
@@ -2307,7 +2312,7 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	priv->reg_vdd = reg_vdd;
 	priv->reg_xceiver = reg_xceiver;
 	priv->xstbyen = device_property_present(&spi->dev, "microchip,xstbyen");
-	priv->devtype_data = *(struct mcp251xfd_devtype_data *)spi_get_device_match_data(spi);
+	priv->devtype_data = *devtype_data;
 
 	/* Errata Reference:
 	 * mcp2517fd: DS80000792C 5., mcp2518fd: DS80000789E 4.,
-- 
2.53.0

