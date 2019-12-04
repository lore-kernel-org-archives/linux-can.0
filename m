From: Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 2/2] net: m_can: Make wake-up gpio an optional
Date: Wed, 4 Dec 2019 11:51:12 -0600
Message-ID: <20191204175112.7308-2-dmurphy@ti.com>
References: <20191204175112.7308-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191204175112.7308-1-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Dan Murphy <dmurphy@ti.com>, Sean Nyekjaer <sean@geanix.com>
List-Id: linux-can.vger.kernel.org

The device has the ability to disable the wake-up pin option.
The wake-up pin can be either force to GND or Vsup and does not have to
be tied to a GPIO.  In order for the device to not use the wake-up feature
write the register to disable the WAKE_CONFIG option.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
CC: Sean Nyekjaer <sean@geanix.com>
---
 drivers/net/can/m_can/tcan4x5x.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index 3db619209fe1..6e37c3fd87af 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -101,6 +101,8 @@
 #define TCAN4X5X_MODE_STANDBY BIT(6)
 #define TCAN4X5X_MODE_NORMAL BIT(7)
 
+#define TCAN4X5X_DISABLE_WAKE_MSK	(BIT(31) | BIT(30))
+
 #define TCAN4X5X_SW_RESET BIT(2)
 
 #define TCAN4X5X_MCAN_CONFIGURED BIT(5)
@@ -338,6 +340,15 @@ static int tcan4x5x_init(struct m_can_classdev *cdev)
 	return ret;
 }
 
+static int tcan4x5x_disable_wake(struct m_can_classdev *cdev)
+{
+	struct tcan4x5x_priv *tcan4x5x = cdev->device_data;
+
+	return regmap_update_bits(tcan4x5x->regmap, TCAN4X5X_CONFIG,
+				  TCAN4X5X_DISABLE_WAKE_MSK, 0x00);
+
+}
+
 static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
 {
 	struct tcan4x5x_priv *tcan4x5x = cdev->device_data;
@@ -345,8 +356,10 @@ static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
 	tcan4x5x->device_wake_gpio = devm_gpiod_get(cdev->dev, "device-wake",
 						    GPIOD_OUT_HIGH);
 	if (IS_ERR(tcan4x5x->device_wake_gpio)) {
-		dev_err(cdev->dev, "device-wake gpio not defined\n");
-		return -EINVAL;
+		if (PTR_ERR(tcan4x5x->power) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		tcan4x5x_disable_wake(cdev);
 	}
 
 	tcan4x5x->reset_gpio = devm_gpiod_get_optional(cdev->dev, "reset",
@@ -428,10 +441,6 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, priv);
 
-	ret = tcan4x5x_parse_config(mcan_class);
-	if (ret)
-		goto out_clk;
-
 	/* Configure the SPI bus */
 	spi->bits_per_word = 32;
 	ret = spi_setup(spi);
@@ -441,6 +450,10 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	priv->regmap = devm_regmap_init(&spi->dev, &tcan4x5x_bus,
 					&spi->dev, &tcan4x5x_regmap);
 
+	ret = tcan4x5x_parse_config(mcan_class);
+	if (ret)
+		goto out_clk;
+
 	tcan4x5x_power_enable(priv->power, 1);
 
 	ret = m_can_class_register(mcan_class);
-- 
2.23.0
