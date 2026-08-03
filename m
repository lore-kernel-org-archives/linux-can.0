Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46E337D130
	for <linux-can@vger.kernel.org>; Mon,  3 Aug 2026 10:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785752387; cv=none; b=rFeZ5uWd6CumvafV+5bCDoHNooziLN1PVrYuRE3XIl7oGrV619hVqRTD9FPNGF+5PJoUYmEIW9jMrx8IoT6efll+YltmLzm+frTdQdH1Yn/3WB147iARKzt8STcGBPSKpczWFxdXl1AlgBref1nXS0hgSXiPusxwT4nCM/lLn/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785752387; c=relaxed/simple;
	bh=xbbzn6EbGyvf6ZsrvEiexfRvSiVw6i7dvpxxhD65h+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U7FVBgfZVDptc0x8Q+8HATc7qL+sBO5B3oe1YfdAaWK3odUJnG4YX7tWg+aQB+7vCjvB+k+sKSDCjh6w9dodvk83ryqX20o8TDY5wxxuos5O7awSXwfXPrNaEv3iXsQJ169ektSAjpy8+HhA8dil1W7/c37ZMwR723G4JQm//e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=RB0bf6b9; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="RB0bf6b9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1785752373; x=1786011573;
	bh=gpppPRfOw/420iYLXpm7/eVVcZ9AaxLltH8sCrxaPZM=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=RB0bf6b93OvmL99OL0e0COVhlkFjQSqm0BOWr+sXrU7WWtA8A0QXg6gpMqLWKgbtV
	 J/73lKklkztydCGPXKnfKV3pV/g0qjputizMzBItsrhywGH5He0DDBj2kCCxC72gws
	 XUvQsbuyzGqjUrbhVLW85i7gUf6VEoqG6Hm/pIaZDDJ40IaukFw4QGdZar9BzidM4j
	 eG2wXw5C4jK8GDWso2X38va+F1wkrq9PffpU0eidWKvfeHiLuD0mL2LUFZHnE/z2+s
	 dUm3jhV70ksGPBh1MlXzkAlAW8SvHkU8iW4lVl08x7+tnjRPRRHtQoGLhOGMk5Dwdh
	 0GgBodrSK+kPQ==
X-Pm-Submission-Id: 4hDCMm2cr8z2Sd4s
From: Sean Nyekjaer <sean@geanix.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Sean Nyekjaer <sean@geanix.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] can: tcan4x5x: put tcan into sleep when removing driver
Date: Mon,  3 Aug 2026 12:19:26 +0200
Message-ID: <20260803101927.17122-1-sean@geanix.com>
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

 drivers/net/can/m_can/tcan4x5x-core.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 31cc9d0abd45..67902b8b0fab 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -211,15 +211,21 @@ static int tcan4x5x_write_fifo(struct m_can_classdev *cdev,
 	return regmap_bulk_write(priv->regmap, TCAN4X5X_MRAM_START + addr_offset, val, val_count);
 }
 
-static int tcan4x5x_power_enable(struct regulator *reg, int enable)
+static int tcan4x5x_power_enable(struct tcan4x5x_priv *priv, int enable)
 {
-	if (IS_ERR_OR_NULL(reg))
+	if (IS_ERR_OR_NULL(priv->power)) {
+		if (priv->reset_gpio && !enable)
+			return regmap_update_bits(priv->regmap, TCAN4X5X_CONFIG,
+						  TCAN4X5X_MODE_SEL_MASK,
+						  TCAN4X5X_MODE_SLEEP);
+
 		return 0;
+	}
 
 	if (enable)
-		return regulator_enable(reg);
+		return regulator_enable(priv->power);
 	else
-		return regulator_disable(reg);
+		return regulator_disable(priv->power);
 }
 
 static int tcan4x5x_write_tcan_reg(struct m_can_classdev *cdev,
@@ -476,7 +482,7 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 		goto out_m_can_class_free_dev;
 	}
 
-	ret = tcan4x5x_power_enable(priv->power, 1);
+	ret = tcan4x5x_power_enable(priv, 1);
 	if (ret) {
 		dev_err(&spi->dev, "Enabling regulator failed %pe\n",
 			ERR_PTR(ret));
@@ -531,7 +537,7 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	return 0;
 
 out_power:
-	tcan4x5x_power_enable(priv->power, 0);
+	tcan4x5x_power_enable(priv, 0);
  out_m_can_class_free_dev:
 	m_can_class_free_dev(mcan_class->net);
 	return ret;
-- 
2.55.0

