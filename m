Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D806441609
	for <linux-can@vger.kernel.org>; Wed,  5 Aug 2026 11:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785928046; cv=none; b=RgznaUgsnwWEGfwTz4thIXIn4DR+AAHxmmicASqe/YVXxp7/j5hOx3d5S+PlE7hMv6fH79LnBwiAq16wNE6gbB9PnSQP0BAkXw78UjHx9a4Ltp9ADNncB6ppHNHhad7oSIXWiYHFzNQkNkssDn1p8A6D7ksL9de9D8ZRWcEgcLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785928046; c=relaxed/simple;
	bh=iEuIs0O4cRRDya3+uD93s8Eeh9TvOrwO0+VEqvaZptg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LAFcPXzo8YeONIHuV8x/bBTNcKEoqdRYx58wsUMpGefG3d0rVPRHTNu+7XiaM2brp2TyuXwIgQ747Y5E6pmIJRT7JoE+oxJMGTU0BwwGOdJKKaYQ4NGkDpZKVYzV/Gl4BB1fN7kfqeKnA30NMPGkFJCJxsWl9Keih03LhcpfWYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=aufjHaiT; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="aufjHaiT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1785928036; x=1786187236;
	bh=FEelNm+cRwtg5xvjxrcA36FwIZsIFsPLP+OiqJOh2pY=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=aufjHaiTsNmXzc52x5duWkVLOAyX+z2tgcBeZNV7WK2gnloR9JnkhLmstwUUyvgzw
	 vIDVltD6Wr4TFkMT4CDu0793B4JuZX4l6/tA1/aTx8wqEVcamlzd3jrG7Z+TsJ96rz
	 aeTyfOsfIAFuHhNu5FXMZFcnAI/Nh19UtalzgRb6DRPZMKBlk6Utc/6VuqGbhAhqce
	 Ci065WJfuZ22AapW6gW5euYQ7URabdKSvMFIF1MpqwOmG0KCxhjRzf2AUsKHAzI0Xb
	 LfEZrB9b4QcmVXLDuOnKXRYwN8ePeA++U1z9X4TRIzgh8h6T0BkkzkmM1m79PuJKx4
	 AkBbGeGpbIOoQ==
X-Pm-Submission-Id: 4hFSKv3ph7z2ScXc
From: Sean Nyekjaer <sean@geanix.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Sean Nyekjaer <sean@geanix.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] can: tcan4x5x: put tcan into sleep when removing driver
Date: Wed,  5 Aug 2026 13:07:07 +0200
Message-ID: <20260805110708.3220251-1-sean@geanix.com>
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

Changes since v4:
 - Don't exit early if regmap_update_bits() fails in
   tcan4x5x_power_enable()

 drivers/net/can/m_can/tcan4x5x-core.c | 30 +++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 31cc9d0abd45..bdb266be6dd3 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -211,8 +211,30 @@ static int tcan4x5x_write_fifo(struct m_can_classdev *cdev,
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
+			dev_err(&priv->spi->dev, "Setting sleep mode failed %pe\n",
+				ERR_PTR(ret));
+	}
+
 	if (IS_ERR_OR_NULL(reg))
 		return 0;
 
@@ -476,7 +498,7 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 		goto out_m_can_class_free_dev;
 	}
 
-	ret = tcan4x5x_power_enable(priv->power, 1);
+	ret = tcan4x5x_power_enable(priv, 1);
 	if (ret) {
 		dev_err(&spi->dev, "Enabling regulator failed %pe\n",
 			ERR_PTR(ret));
@@ -531,7 +553,7 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	return 0;
 
 out_power:
-	tcan4x5x_power_enable(priv->power, 0);
+	tcan4x5x_power_enable(priv, 0);
  out_m_can_class_free_dev:
 	m_can_class_free_dev(mcan_class->net);
 	return ret;
@@ -543,7 +565,7 @@ static void tcan4x5x_can_remove(struct spi_device *spi)
 
 	m_can_class_unregister(&priv->cdev);
 
-	tcan4x5x_power_enable(priv->power, 0);
+	tcan4x5x_power_enable(priv, 0);
 
 	m_can_class_free_dev(priv->cdev.net);
 }
-- 
2.55.0

