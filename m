From: Dan Murphy <dmurphy@ti.com>
Subject: [PATCH] can: tcan4x5x: Turn on the power before parsing the config
Date: Mon, 9 Dec 2019 15:23:51 -0600
Message-ID: <20191209212351.27518-1-dmurphy@ti.com>
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
 drivers/net/can/m_can/tcan4x5x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index 4e1789ea2bc3..515486fcb150 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -451,11 +451,11 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	priv->regmap = devm_regmap_init(&spi->dev, &tcan4x5x_bus,
 					&spi->dev, &tcan4x5x_regmap);
 
+	tcan4x5x_power_enable(priv->power, 1);
+
 	ret = tcan4x5x_parse_config(mcan_class);
 	if (ret)
-		goto out_clk;
-
-	tcan4x5x_power_enable(priv->power, 1);
+		goto out_power;
 
 	ret = m_can_class_register(mcan_class);
 	if (ret)
-- 
2.23.0
