From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/9] can: tcan4x5x: tcan4x5x_can_probe(): turn on the power before parsing the config
Date: Thu,  2 Jan 2020 17:09:27 +0100
Message-ID: <20200102160934.1524-3-mkl@pengutronix.de>
References: <20200102160934.1524-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200102160934.1524-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Dan Murphy <dmurphy@ti.com>

The tcan4x5x_parse_config() function now performs action on the device
either reading or writing and a reset. If the devive has a switchable
power supppy (i.e. regulator is managed) it needs to be turned on.

So turn on the regulator if available. If the parsing fails, turn off
the regulator.

Fixes: 2de497356955 ("can: tcan45x: Make wake-up GPIO an optional GPIO")
Signed-off-by: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/tcan4x5x.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index c9fb864fcfa1..a69476f5aec6 100644
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
 
 	ret = tcan4x5x_init(mcan_class);
 	if (ret)
-- 
2.24.1
