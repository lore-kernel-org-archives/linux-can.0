From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5/9] can: tcan4x5x: tcan4x5x_parse_config(): fix inconsistent IS_ERR and PTR_ERR
Date: Thu,  2 Jan 2020 17:09:30 +0100
Message-ID: <20200102160934.1524-6-mkl@pengutronix.de>
References: <20200102160934.1524-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200102160934.1524-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Dan Murphy <dmurphy@ti.com>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

Fix inconsistent IS_ERR and PTR_ERR in tcan4x5x_parse_config().

The proper pointer to be passed as argument is tcan4x5x->device_wake_gpio.

This bug was detected with the help of Coccinelle.

Fixes: 2de497356955 ("can: tcan45x: Make wake-up GPIO an optional GPIO")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Acked-by: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/tcan4x5x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index a413e7548546..eacd428e07e9 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -387,7 +387,7 @@ static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
 	tcan4x5x->device_wake_gpio = devm_gpiod_get(cdev->dev, "device-wake",
 						    GPIOD_OUT_HIGH);
 	if (IS_ERR(tcan4x5x->device_wake_gpio)) {
-		if (PTR_ERR(tcan4x5x->power) == -EPROBE_DEFER)
+		if (PTR_ERR(tcan4x5x->device_wake_gpio) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
 
 		tcan4x5x_disable_wake(cdev);
-- 
2.24.1
