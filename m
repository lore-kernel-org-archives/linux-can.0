From: Dan Murphy <dmurphy@ti.com>
Subject: [PATCH linux-can/testing] can: tcan4x5x: Disable the INH pin device-state GPIO is unavailable
Date: Thu, 12 Dec 2019 10:15:36 -0600
Message-ID: <20191212161536.23264-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, mkl@pengutronix.de, linux-can@vger.kernel.org, wg@grandegger.com, sriram.dash@samsung.com
Cc: Dan Murphy <dmurphy@ti.com>
List-Id: linux-can.vger.kernel.org

If the device state GPIO is not connected to the host then disable the
INH output from the TCAN device per section 8.3.5 of the data sheet.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/net/can/m_can/tcan4x5x.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index b5d2ea0999c1..6a1f242d1876 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -102,6 +102,7 @@
 #define TCAN4X5X_MODE_NORMAL BIT(7)
 
 #define TCAN4X5X_DISABLE_WAKE_MSK	(BIT(31) | BIT(30))
+#define TCAN4X5X_DISABLE_INH_MSK	BIT(9)
 
 #define TCAN4X5X_SW_RESET BIT(2)
 
@@ -360,6 +361,15 @@ static int tcan4x5x_disable_wake(struct m_can_classdev *cdev)
 				  TCAN4X5X_DISABLE_WAKE_MSK, 0x00);
 }
 
+static int tcan4x5x_disable_state(struct m_can_classdev *cdev)
+{
+	struct tcan4x5x_priv *tcan4x5x = cdev->device_data;
+
+	return regmap_update_bits(tcan4x5x->regmap, TCAN4X5X_CONFIG,
+				  TCAN4X5X_DISABLE_INH_MSK, 0x01);
+
+}
+
 static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
 {
 	struct tcan4x5x_priv *tcan4x5x = cdev->device_data;
@@ -383,8 +393,10 @@ static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
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
2.23.0
