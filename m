Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220E12F8E95
	for <linux-can@vger.kernel.org>; Tue,  4 Aug 2026 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785843049; cv=none; b=rDu9ndA7+9d163U31Opj+iO9NhSBgAYGEr9AW+EdcdhP3PY6wyUILoj5QyXgkX07wD7bVqxWKbVnLlhB81q7RzuXpYSxQxxsF1lmXqai2sxGYWhLT3IXyz9rVAQznaNJf6lm2Go+iado4ftSZIvUFO7jfNTLA3mHx760841LNbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785843049; c=relaxed/simple;
	bh=zq86qxopQMpcraFTy6ZUhSDsrSiCtxIGWnKx5869zYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dhJA6698lK7f9jX6IIqpf9y0n6EI6A6aE/5GmAOwmZa88sNZwI4GpC+s0ds4rpk9/a8PD2fn1IBXRgvQZlsTFPBSIPDhF2pjjeGXasC77h9tjlSMbb1o5Qg+POoghVihCJfVs1kx9Ahotgby2+rGo4lIBaLPEnxXx9MQpgSvPWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=UKHutCH+; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="UKHutCH+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1785843036; x=1786102236;
	bh=1G66GPrCnpAIzYjzEt47hlig23TELeV03/YZ0MKwmZs=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=UKHutCH+W9NIrN7V/ElACsi6R5czdqWv2VDx0eJYKSE6W4QP29yVm2ZARpdADQ79j
	 KrA1HFYQyFeAWdjowXE++VzWL/EFPw5SihG+vvV6ZudQnZvkP3vrlb+pPkUBWiDiZu
	 zgsRrAHFTkhCeq7B3pmv1YuZS8POmvXnmXYGU9IglPESCAYSYhg2Ek/mACMqOKlh3r
	 NdwVbsToaW1L7LWk3t00p2Awe1q740VezB4427t8Y8bX9lJyQeLuyxbuqlt1lnkZht
	 CoC727c9TxrVM4Pw0D45c3wWFGzvTwhgWZF6lHC/iH2Zey52wlJZE+H1p14CMxW56Z
	 /m3k3M49rZZMw==
X-Pm-Submission-Id: 4hDrvH0pXBz1DDLm
From: Sean Nyekjaer <sean@geanix.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Sean Nyekjaer <sean@geanix.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] can: tcan4x5x: put tcan into sleep when removing driver
Date: Tue,  4 Aug 2026 13:30:26 +0200
Message-ID: <20260804113027.1626442-1-sean@geanix.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Put the tcan4x5x transceiver into sleep mode when the driver is
removed, instead of leaving it in its current operating mode.
This reduces power consumption(3mA@12V) once the driver is
no longer bound to the device.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes since v1:
 - Moved enter sleep mode into tcan4x5x_power_enable()

Changes since v2:
 - Added comment about RST pin
 - Fixed all calls to tcan4x5x_power_enable()

Changes since v3:
 - When powering off, always put the device into sleep mode (if the RST pin is
   present). This will ensure the device is in sleep mode even if the
   power regulator is shared.

 drivers/net/can/m_can/tcan4x5x-core.c | 29 +++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 31cc9d0abd45..d8fd219a27cc 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -211,8 +211,29 @@ static int tcan4x5x_write_fifo(struct m_can_classdev *cdev,
 	return regmap_bulk_write(priv->regmap, TCAN4X5X_MRAM_START + addr_offset, val, val_count);
 }
 
-static int tcan4x5x_power_enable(struct regulator *reg, int enable)
+static int tcan4x5x_power_enable(struct tcan4x5x_priv *priv, int enable)
 {
+	struct regulator *reg = priv->power;
+	int ret;
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
+		ret = regmap_update_bits(priv->regmap, TCAN4X5X_CONFIG,
+					 TCAN4X5X_MODE_SEL_MASK,
+					 TCAN4X5X_MODE_SLEEP);
+		if (ret)
+			return ret;
+	}
+
 	if (IS_ERR_OR_NULL(reg))
 		return 0;
 
@@ -476,7 +497,7 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 		goto out_m_can_class_free_dev;
 	}
 
-	ret = tcan4x5x_power_enable(priv->power, 1);
+	ret = tcan4x5x_power_enable(priv, 1);
 	if (ret) {
 		dev_err(&spi->dev, "Enabling regulator failed %pe\n",
 			ERR_PTR(ret));
@@ -531,7 +552,7 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	return 0;
 
 out_power:
-	tcan4x5x_power_enable(priv->power, 0);
+	tcan4x5x_power_enable(priv, 0);
  out_m_can_class_free_dev:
 	m_can_class_free_dev(mcan_class->net);
 	return ret;
@@ -543,7 +564,7 @@ static void tcan4x5x_can_remove(struct spi_device *spi)
 
 	m_can_class_unregister(&priv->cdev);
 
-	tcan4x5x_power_enable(priv->power, 0);
+	tcan4x5x_power_enable(priv, 0);
 
 	m_can_class_free_dev(priv->cdev.net);
 }
-- 
2.55.0

