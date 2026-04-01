Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44F02135AD
	for <linux-can@vger.kernel.org>; Wed,  1 Apr 2026 07:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028836; cv=none; b=Q6JfM6UC4WLgVYzJlf6NtpTXLPWrJXegC7FTUWCzYgYkgdaIEOJd3ekeOVIR+dOdPPzGbnJfiUz46kFLDbcOs+2QYfFxkGMIUWm14b7uvAa0X0U+nHMKpdwCMTmrftW/vIrM0oLhKQJQ1GN+CHFEPZyv+v3HtGjw71YCzuELN1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028836; c=relaxed/simple;
	bh=migbb/8FUb4/HzK/8zwo5lR0u1Zrd2aghHIXVPoz45s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SB2klfPUcd5+AxiSntMC7vBDDg4H6CLWvN6jYhnWK5jiK3c0Np3Sn0Dsgmat1/u17dQqCfu9vEB0pSeQKc3hriXwFeVWtnl9BYVh67NpI8XIaJ5sOJUiu4uOeXzK6opvho2+2qoQFim+trolOEgwb9wGA826jtM2rL79eGdzUF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w7q57-00076f-JS; Wed, 01 Apr 2026 09:33:41 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w7q57-003Ahb-0t;
	Wed, 01 Apr 2026 09:33:41 +0200
Received: from blackshift.org (unknown [IPv6:2a0a:edc0:0:701:a82f:fdef:12b2:33d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E1C65513377;
	Wed, 01 Apr 2026 07:33:40 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 4/6] can: mcp251xfd: add support for XSTBYEN transceiver standby control
Date: Wed,  1 Apr 2026 09:30:12 +0200
Message-ID: <20260401073338.5592-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401073338.5592-1-mkl@pengutronix.de>
References: <20260401073338.5592-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

The MCP251xFD has a dedicated transceiver standby control function on
the INT0/GPIO0/XSTBY pin, controlled by the XSTBYEN bit in IOCON.
When enabled, the hardware automatically manages the transceiver
standby state: the pin is driven low when the controller is active
and high when it enters Sleep mode.

Enable this feature when the 'microchip,xstbyen' device tree property
is present.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Link: https://patch.msgid.link/20260321135031.3107408-3-viken.dadhaniya@oss.qualcomm.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 37 +++++++++++++++++++
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |  1 +
 2 files changed, 38 insertions(+)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 9c86df08c2c5..92a86083c896 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -764,6 +764,31 @@ static void mcp251xfd_chip_stop(struct mcp251xfd_priv *priv,
 	mcp251xfd_chip_set_mode(priv, MCP251XFD_REG_CON_MODE_CONFIG);
 }
 
+static int mcp251xfd_chip_xstbyen_enable(const struct mcp251xfd_priv *priv)
+{
+	/* Configure the INT0/GPIO0/XSTBY pin as transceiver standby control:
+	 *
+	 * - XSTBYEN=1: route the pin to the transceiver standby function
+	 * - TRIS0=0:   set output direction; the reset default is 1 (input),
+	 *              which leaves the pin floating HIGH and keeps the
+	 *              transceiver in standby regardless of XSTBYEN
+	 * - LAT0=0:    drive pin LOW => transceiver active (not in standby)
+	 *
+	 * All three bits are included in the mask; only XSTBYEN is set in
+	 * val, so TRIS0 and LAT0 are cleared to 0 atomically.
+	 *
+	 * Pin behaviour by mode:
+	 * - Config mode: controlled by LAT0 (LAT0=0 => LOW => active)
+	 * - Normal mode: hardware drives pin LOW (active)
+	 * - Sleep mode:  hardware drives pin HIGH (standby)
+	 */
+	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
+				  MCP251XFD_REG_IOCON_XSTBYEN |
+				  MCP251XFD_REG_IOCON_TRIS0 |
+				  MCP251XFD_REG_IOCON_LAT0,
+				  MCP251XFD_REG_IOCON_XSTBYEN);
+}
+
 static int mcp251xfd_chip_start(struct mcp251xfd_priv *priv)
 {
 	int err;
@@ -796,6 +821,12 @@ static int mcp251xfd_chip_start(struct mcp251xfd_priv *priv)
 
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
+	if (priv->xstbyen) {
+		err = mcp251xfd_chip_xstbyen_enable(priv);
+		if (err)
+			goto out_chip_stop;
+	}
+
 	err = mcp251xfd_chip_set_normal_mode(priv);
 	if (err)
 		goto out_chip_stop;
@@ -1805,6 +1836,11 @@ static int mcp251xfd_gpio_request(struct gpio_chip *chip, unsigned int offset)
 	u32 pin_mask = MCP251XFD_REG_IOCON_PM(offset);
 	int ret;
 
+	if (priv->xstbyen && offset == 0) {
+		netdev_err(priv->ndev, "Can't use GPIO 0 with XSTBYEN!\n");
+		return -EINVAL;
+	}
+
 	if (priv->rx_int && offset == 1) {
 		netdev_err(priv->ndev, "Can't use GPIO 1 with RX-INT!\n");
 		return -EINVAL;
@@ -2271,6 +2307,7 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	priv->pll_enable = pll_enable;
 	priv->reg_vdd = reg_vdd;
 	priv->reg_xceiver = reg_xceiver;
+	priv->xstbyen = device_property_present(&spi->dev, "microchip,xstbyen");
 	priv->devtype_data = *(struct mcp251xfd_devtype_data *)spi_get_device_match_data(spi);
 
 	/* Errata Reference:
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 085d7101e595..d3f4704e2678 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -672,6 +672,7 @@ struct mcp251xfd_priv {
 	struct gpio_desc *rx_int;
 	struct clk *clk;
 	bool pll_enable;
+	bool xstbyen;
 	struct regulator *reg_vdd;
 	struct regulator *reg_xceiver;
 
-- 
2.53.0

