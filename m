Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00E94E50A3;
	Fri,  9 Oct 2026 13:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553426; cv=pass; b=Vwmd2DZ1pF+R5LGxEWLSjhQIHuX1vBshhjs11L6c1O2/PGlYthYIyImfg8YR55zYvc05I++dddnSrZpCSatgz4yolFG+AnK9/n0ml0NyBmW+lFpnjkg24bUAsZ9n74NA3+VK6t3DoRU9Kx6f3V2uA1E+5FSN6kR4FWuyNNAbOjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553426; c=relaxed/simple;
	bh=IttHcJ0OSTOlfGH+JJK5ZP/UFEwnle/riB1BzbvHXG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6s9pKMQo3olalK+nx9r4F/Dy0Do7WRb93bXgG/4BJSNsyWVYAvz+ay38sJHwbbSIM4aQ6zrO+alSzirueZLpHrm6uDml1ozksm8FRKy3FL5lc2IwfFYeHURy7PQ6fNsdkNRjQmP+jMLRDZwqz6uyUPtnmpLf72wyYV4SOKi1tM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=JVeiAqPm; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="JVeiAqPm"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A5F8D202623;
	Fri, 09 Oct 2026 15:43:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nA5lyvl0xeHdQ6oEcgtRAbywu84Dc+Oye8Wvzdlhmws=;
	b=JVeiAqPmA/WNetkxZwso1dLZbtRpWF03qOTkS209SDToF+n27V7RESNwKI4o+4ToJJsoz/
	pU7zRaAL5DJ9UryB0l2SyCW764e02hWqD9XakprtkeAtw3QqCrRcvqb/JINaPSqH/d8ZoJ
	U1+RBK6+ljarCwoLr9popo0yUwDwBsGnO96Tkkc9FjDFPO3EoGuEP3c2pV9/rziWQvHMZb
	LTvshyPNjgYgpHQvuRL1ZsWMw3GG92PGcy3HI1m5ukQeI1DCSTgHRV7wn3yzzBu8HH5218
	A8nt2qSUjhAQUNyJrbFOgah5v//lGE5YqZN2mzF/bOKs6Vm1zvYaZYfAimoMLw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553421; a=rsa-sha256;
	cv=none;
	b=Or188RBRPit7PGbPu7N1aEyOxqWdHH/z0woD8EWZAT5sd6z9AysLx9/BI8NmMSM1AZxqwA
	acrC6iPCOhHR3qJr6ih6N3rb1nkd4qifx44pHvZZ1xt/Nz8bf+LUR5GU9sAxsGCRClbvN6
	2sY9VVqk8ydz6B+/ETtthpk8mV3t8ZrmUpHbSpg4HMSkgZqO23tTTgksGcHSrO2n7WACjx
	+A5XIhayJlOhJfz1C2vd7VoqA2kauSo0uPeU9x46scJWKnWwJkzmrkMHDaV9TdtpzHQ9p0
	Rtes8pRlVh0fF0zOmYczNJkFws73QLa4jSVeluAxGFGNEUgIrcYwdjqC71iffg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nA5lyvl0xeHdQ6oEcgtRAbywu84Dc+Oye8Wvzdlhmws=;
	b=MuAeUJSYIApuCKvARMXu6Q/rqIa+T8dLftj/kcRekZQ5hgJJJ7Q7Y4J3nV6tu94stTcAj2
	lvS//PfwZ3QgHGB0j+w1v4pwEoIEMkoe5gysiTQvfYSRGhcGiJ0wktku9lPbeWc9IYX32Z
	1KXi6AYDMGSsbtdardUhbvT/F1rk1lT67gJ3ny8bi9l6noIiW2cGDE1b6HoYBfHgeoIX2q
	HWpZUXmmiJxGYhfxSY+yLuiKb/u05/MCSJ7DVhH0PQUJIjvTAl/5TMyK0B5VHJYsJ4NO1u
	pEgC7mWmV9VbXaTVhlIxu0XRt2L4u/ZkExIOkG4y1hMKXkVn9J5BO/6lV3ylWA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAsv-0053Tg-1s;
	Fri, 09 Oct 2026 15:43:41 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2BE235BD8F7;
	Fri, 09 Oct 2026 13:43:41 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jiale Yao <yaojiale02@163.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 34/37] can: mcp251xfd: mcp251xfd_probe(): reject devices without match data
Date: Fri,  9 Oct 2026 15:28:06 +0200
Message-ID: <20261009134323.64064-35-mkl@pengutronix.de>
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

