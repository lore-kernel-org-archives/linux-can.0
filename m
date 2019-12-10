From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] can: tcan45x: Fix inconsistent IS_ERR and PTR_ERR
Date: Tue, 10 Dec 2019 09:05:32 -0600
Message-ID: <20191210150532.GA12732@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
Sender: netdev-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Sean Nyekjaer <sean@geanix.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-can.vger.kernel.org

Fix inconsistent IS_ERR and PTR_ERR in tcan4x5x_parse_config.

The proper pointer to be passed as argument is tcan4x5x->device_wake_gpio.

This bug was detected with the help of Coccinelle.

Fixes: 2de497356955 ("can: tcan45x: Make wake-up GPIO an optional GPIO")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/can/m_can/tcan4x5x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index 4e1789ea2bc3..6676ecec48c3 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -355,7 +355,7 @@ static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
 	tcan4x5x->device_wake_gpio = devm_gpiod_get(cdev->dev, "device-wake",
 						    GPIOD_OUT_HIGH);
 	if (IS_ERR(tcan4x5x->device_wake_gpio)) {
-		if (PTR_ERR(tcan4x5x->power) == -EPROBE_DEFER)
+		if (PTR_ERR(tcan4x5x->device_wake_gpio) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
 
 		tcan4x5x_disable_wake(cdev);
-- 
2.23.0
