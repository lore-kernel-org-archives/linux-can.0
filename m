Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50AA40B11C
	for <linux-can@vger.kernel.org>; Mon,  3 Aug 2026 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785765024; cv=none; b=T+bGXvaroIJG0wfjAWdfyY8qYMtPD4egMrdrnMSqGx0t87Xp/vU1p0RggwpjL77U9GTN3AxXVDvGynP32p0+1N88RwLwG5KYOUFfhDCAjHCLDGnfgU1MB39hMoV/1E3HizhEc9hg7twvSnBaylunXDQCfschb8AXhn8FojVOV7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785765024; c=relaxed/simple;
	bh=+8sY91Ir3VZGNsRdHN9WUmlpzyrt0U8LrrUR23wXUqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ezv89wOKXhqrtVWEI9IObZdoQZ66L/CQr1NFTnh0I0o5sOlUAHDwUNGGJkIvCE3pWHBZ7Mqa8sJP7Zj4AE18vJZLaHgi1t15sG37ZKjwbE03Yi/HlB9eYVPCrz9tcv1UrzwPNSQ8LKqR7rEi9Mu1q1F5BWL8JLafDBsjdYTDXjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=OZcOGZs3; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="OZcOGZs3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1785765017; x=1786024217;
	bh=8mkihL4HVfwXlCW8mPeiZgRtVUtEAOyAxLZJyP7ZqmU=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=OZcOGZs36B/4OtesLqnhuSL+M9dI1qbV1WDOZ1PWCdeTB5W5Az/8rLzHn6SsNt46N
	 3bL0FUE43r55dhNj2Qe07Xorpfjxm6bnidFCLEoXsuGAwp7QNe/ayKuAmpdnS+SMC+
	 sqY83sKyNUAmgKvqxzyCAEWpKLlP+YB0P4Mzn7O6gNXaU8weARtCaj9VLgbHm0zSYQ
	 tV1tfcQGx8hIjQ3QcxgvynzTme9GulH01RgFuN0Jo/XnpexRHvCn4j2mlDUF68UXqQ
	 Glv+IefIdwi+X+F30JLUtkWo1Wa253R5xEBnVkCd3qSUegr+h76t7IXGR/ujixA51b
	 LrpX9bQPyJa2g==
X-Pm-Submission-Id: 4hDJ2w1LKSz2Sd3K
From: Sean Nyekjaer <sean@geanix.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Sean Nyekjaer <sean@geanix.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] can: tcan4x5x: put tcan into sleep when removing driver
Date: Mon,  3 Aug 2026 15:50:11 +0200
Message-ID: <20260803135011.230006-1-sean@geanix.com>
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

 drivers/net/can/m_can/tcan4x5x-core.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 31cc9d0abd45..a318f1874b35 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -211,10 +211,26 @@ static int tcan4x5x_write_fifo(struct m_can_classdev *cdev,
 	return regmap_bulk_write(priv->regmap, TCAN4X5X_MRAM_START + addr_offset, val, val_count);
 }
 
-static int tcan4x5x_power_enable(struct regulator *reg, int enable)
+static int tcan4x5x_power_enable(struct tcan4x5x_priv *priv, int enable)
 {
-	if (IS_ERR_OR_NULL(reg))
+	struct regulator *reg = priv->power;
+
+	/*
+	 * Check if the power regulator is configured. If it is, just power
+	 * the device on/off. If not, put the device into sleep mode here if
+	 * the RST pin is available, since a wake-up event, RST pin toggle,
+	 * or power cycle are the only ways to exit sleep mode.
+	 * Datasheet: TCAN4550, section "8.4.3 Sleep Mode"
+	 * https://www.ti.com/lit/gpn/tcan4550
+	 */
+	if (IS_ERR_OR_NULL(reg)) {
+		if (priv->reset_gpio && !enable)
+			return regmap_update_bits(priv->regmap, TCAN4X5X_CONFIG,
+						  TCAN4X5X_MODE_SEL_MASK,
+						  TCAN4X5X_MODE_SLEEP);
+
 		return 0;
+	}
 
 	if (enable)
 		return regulator_enable(reg);
@@ -476,7 +492,7 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 		goto out_m_can_class_free_dev;
 	}
 
-	ret = tcan4x5x_power_enable(priv->power, 1);
+	ret = tcan4x5x_power_enable(priv, 1);
 	if (ret) {
 		dev_err(&spi->dev, "Enabling regulator failed %pe\n",
 			ERR_PTR(ret));
@@ -531,7 +547,7 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	return 0;
 
 out_power:
-	tcan4x5x_power_enable(priv->power, 0);
+	tcan4x5x_power_enable(priv, 0);
  out_m_can_class_free_dev:
 	m_can_class_free_dev(mcan_class->net);
 	return ret;
@@ -543,7 +559,7 @@ static void tcan4x5x_can_remove(struct spi_device *spi)
 
 	m_can_class_unregister(&priv->cdev);
 
-	tcan4x5x_power_enable(priv->power, 0);
+	tcan4x5x_power_enable(priv, 0);
 
 	m_can_class_free_dev(priv->cdev.net);
 }
-- 
2.55.0

