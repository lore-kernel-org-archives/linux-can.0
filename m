Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E33B3ADB98;
	Mon, 17 Aug 2026 23:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009672; cv=none; b=cRnwq5Hf3kwCaM0Y2HuZ320l7YdCCn4ThR9QU8ssR+d9hatwu2+NE5AMqm7SP1msEJbVndeKa2cHF5jt52VElJFXzRzC91Z9j9mkIfW+lehcJpGDizPxJ6CSB61eAPoCLkgPa1+ivyWRb6dUp0QW3dAspEUm/XMtq1J7afPnCAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009672; c=relaxed/simple;
	bh=8odG1HPKyM/scb57+c67BuTqlicesVH0A2Sharw1koA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMLAelLTx8Y2lDQ/epHsAHIYY7mqUVa/igfHENMsJ2N94v/YPuL1HmtE1XCLZf7YsF6foQ4WG6bQSEvXd4okxJyJHtlODRqpmTgIG3xkBcJCge/24IcNcKr/0pFuTlKG8wWNzxZF05IzcdWq6WYzkDA2efQIZwgZvKyAy83XGUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8304A20227F;
	Tue, 18 Aug 2026 01:34:22 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ww6qU-00220d-19;
	Tue, 18 Aug 2026 01:34:22 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0D906585154;
	Mon, 17 Aug 2026 23:34:22 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Sean Nyekjaer <sean@geanix.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 01/11] can: tcan4x5x: put tcan into sleep when removing driver
Date: Tue, 18 Aug 2026 01:24:28 +0200
Message-ID: <20260817233420.2068204-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817233420.2068204-1-mkl@pengutronix.de>
References: <20260817233420.2068204-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Nyekjaer <sean@geanix.com>

Put the tcan4x5x transceiver into sleep mode when the driver is
removed, instead of leaving it in its current operating mode.
This reduces power consumption(3mA@12V) once the driver is
no longer bound to the device.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Link: https://patch.msgid.link/20260805110708.3220251-1-sean@geanix.com
[mkl: tcan4x5x_power_enable(): reduce scope of ret]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 31 +++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 31cc9d0abd45..a5b8829aa519 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -211,8 +211,31 @@ static int tcan4x5x_write_fifo(struct m_can_classdev *cdev,
 	return regmap_bulk_write(priv->regmap, TCAN4X5X_MRAM_START + addr_offset, val, val_count);
 }
 
-static int tcan4x5x_power_enable(struct regulator *reg, int enable)
+static int tcan4x5x_power_enable(struct tcan4x5x_priv *priv, int enable)
 {
+	struct regulator *reg = priv->power;
+
+	/*
+	 * Put the device into sleep mode if the RST pin is available,
+	 * since a wake-up event, RST pin toggle, or power cycle are the only
+	 * ways to exit sleep mode.
+	 * Redundant if the regulator is exclusive to this device, but that
+	 * can't be determined here.
+	 *
+	 * Datasheet: TCAN4550, section "8.4.3 Sleep Mode"
+	 * https://www.ti.com/lit/gpn/tcan4550
+	 */
+	if (priv->reset_gpio && !enable) {
+		int ret;
+
+		ret = regmap_update_bits(priv->regmap, TCAN4X5X_CONFIG,
+					 TCAN4X5X_MODE_SEL_MASK,
+					 TCAN4X5X_MODE_SLEEP);
+		if (ret)
+			dev_err(&priv->spi->dev, "Setting sleep mode failed %pe\n",
+				ERR_PTR(ret));
+	}
+
 	if (IS_ERR_OR_NULL(reg))
 		return 0;
 
@@ -476,7 +499,7 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 		goto out_m_can_class_free_dev;
 	}
 
-	ret = tcan4x5x_power_enable(priv->power, 1);
+	ret = tcan4x5x_power_enable(priv, 1);
 	if (ret) {
 		dev_err(&spi->dev, "Enabling regulator failed %pe\n",
 			ERR_PTR(ret));
@@ -531,7 +554,7 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	return 0;
 
 out_power:
-	tcan4x5x_power_enable(priv->power, 0);
+	tcan4x5x_power_enable(priv, 0);
  out_m_can_class_free_dev:
 	m_can_class_free_dev(mcan_class->net);
 	return ret;
@@ -543,7 +566,7 @@ static void tcan4x5x_can_remove(struct spi_device *spi)
 
 	m_can_class_unregister(&priv->cdev);
 
-	tcan4x5x_power_enable(priv->power, 0);
+	tcan4x5x_power_enable(priv, 0);
 
 	m_can_class_free_dev(priv->cdev.net);
 }

base-commit: e6a5d573d24cd375e09d24f136523cb3cc85c9d3
-- 
2.53.0

