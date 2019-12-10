From: Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v2] can: tcan4x5x: Turn on the power before parsing the config
Date: Tue, 10 Dec 2019 10:32:04 -0600
Message-ID: <20191210163204.28225-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Dan Murphy <dmurphy@ti.com>
List-Id: linux-can.vger.kernel.org

The parse config function now performs action on the device either
reading or writing and a reset.  If the regulator is managed it needs
to be turned on.  So turn on the regulator if available if the parsing
fails then turn off the regulator.

Fixes: a5235f3c7c23 ("can: tcan45x: Make wake-up GPIO an optional GPIO")
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v2 - Added error handling and moved regulator_get to probe

 drivers/net/can/m_can/tcan4x5x.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index 4e1789ea2bc3..ddf7db498241 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -374,11 +374,6 @@ static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
 	if (IS_ERR(tcan4x5x->device_state_gpio))
 		tcan4x5x->device_state_gpio = NULL;
 
-	tcan4x5x->power = devm_regulator_get_optional(cdev->dev,
-						      "vsup");
-	if (PTR_ERR(tcan4x5x->power) == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
-
 	return 0;
 }
 
@@ -412,6 +407,12 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->power = devm_regulator_get_optional(&spi->dev, "vsup");
+	if (PTR_ERR(priv->power) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	else
+		priv->power = NULL;
+
 	mcan_class->device_data = priv;
 
 	m_can_class_get_clocks(mcan_class);
@@ -451,11 +452,13 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	priv->regmap = devm_regmap_init(&spi->dev, &tcan4x5x_bus,
 					&spi->dev, &tcan4x5x_regmap);
 
-	ret = tcan4x5x_parse_config(mcan_class);
+	ret = tcan4x5x_power_enable(priv->power, 1);
 	if (ret)
 		goto out_clk;
 
-	tcan4x5x_power_enable(priv->power, 1);
+	ret = tcan4x5x_parse_config(mcan_class);
+	if (ret)
+		goto out_power;
 
 	ret = m_can_class_register(mcan_class);
 	if (ret)
-- 
2.23.0
