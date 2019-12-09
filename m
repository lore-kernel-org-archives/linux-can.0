From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 09/13] can: m_can: tcan4x5x: add required delay after reset
Date: Mon,  9 Dec 2019 17:32:52 +0100
Message-ID: <20191209163256.12000-10-mkl@pengutronix.de>
References: <20191209163256.12000-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191209163256.12000-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Sean Nyekjaer <sean@geanix.com>, Dan Murphy <dmurphy@ti.com>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Sean Nyekjaer <sean@geanix.com>

According to section "8.3.8 RST Pin" in the datasheet we are required to
wait >700us after the device is reset.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Acked-by: Dan Murphy <dmurphy@ti.com>
Cc: linux-stable <stable@vger.kernel.org> # >= v5.4
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/tcan4x5x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index 3db619209fe1..d5d4bfa9c8fd 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -354,6 +354,8 @@ static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
 	if (IS_ERR(tcan4x5x->reset_gpio))
 		tcan4x5x->reset_gpio = NULL;
 
+	usleep_range(700, 1000);
+
 	tcan4x5x->device_state_gpio = devm_gpiod_get_optional(cdev->dev,
 							      "device-state",
 							      GPIOD_IN);
-- 
2.24.0
