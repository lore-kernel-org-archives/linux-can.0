From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4/9] can: tcan4x5x: tcan4x5x_parse_config(): Disable the INH pin device-state GPIO is unavailable
Date: Thu,  2 Jan 2020 17:09:29 +0100
Message-ID: <20200102160934.1524-5-mkl@pengutronix.de>
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

If the device state GPIO is not connected to the host then disable the
INH output from the TCAN device per section 8.3.5 of the data sheet.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/tcan4x5x.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index ee22e39f131b..a413e7548546 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -102,6 +102,7 @@
 #define TCAN4X5X_MODE_NORMAL BIT(7)
 
 #define TCAN4X5X_DISABLE_WAKE_MSK	(BIT(31) | BIT(30))
+#define TCAN4X5X_DISABLE_INH_MSK	BIT(9)
 
 #define TCAN4X5X_SW_RESET BIT(2)
 
@@ -370,6 +371,14 @@ static int tcan4x5x_disable_wake(struct m_can_classdev *cdev)
 				  TCAN4X5X_DISABLE_WAKE_MSK, 0x00);
 }
 
+static int tcan4x5x_disable_state(struct m_can_classdev *cdev)
+{
+	struct tcan4x5x_priv *tcan4x5x = cdev->device_data;
+
+	return regmap_update_bits(tcan4x5x->regmap, TCAN4X5X_CONFIG,
+				  TCAN4X5X_DISABLE_INH_MSK, 0x01);
+}
+
 static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
 {
 	struct tcan4x5x_priv *tcan4x5x = cdev->device_data;
@@ -396,8 +405,10 @@ static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
 	tcan4x5x->device_state_gpio = devm_gpiod_get_optional(cdev->dev,
 							      "device-state",
 							      GPIOD_IN);
-	if (IS_ERR(tcan4x5x->device_state_gpio))
+	if (IS_ERR(tcan4x5x->device_state_gpio)) {
 		tcan4x5x->device_state_gpio = NULL;
+		tcan4x5x_disable_state(cdev);
+	}
 
 	return 0;
 }
-- 
2.24.1
