From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6/9] can: mcp251x: mcp251x_hw_reset(): allow more time after a reset
Date: Mon, 19 Aug 2019 17:38:15 +0200
Message-ID: <20190819153818.29293-7-mkl@pengutronix.de>
References: <20190819153818.29293-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190819153818.29293-1-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: linux-can@vger.kernel.org
Cc: t.schluessler@krause.de, shc_work@mail.ru, Sean Nyekjaer <sean@geanix.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-stable <stable@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

Some boards take longer than 5ms to power up after a reset, so allow
some retries attempts before giving up.

Fixes: ff06d611a31c ("can: mcp251x: Improve mcp251x_hw_reset()")
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251x.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 44b57187a6f3..db69c04bac2d 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -606,7 +606,7 @@ static int mcp251x_setup(struct net_device *net, struct spi_device *spi)
 static int mcp251x_hw_reset(struct spi_device *spi)
 {
 	struct mcp251x_priv *priv = spi_get_drvdata(spi);
-	u8 reg;
+	unsigned long timeout;
 	int ret;
 
 	/* Wait for oscillator startup timer after power up */
@@ -620,10 +620,19 @@ static int mcp251x_hw_reset(struct spi_device *spi)
 	/* Wait for oscillator startup timer after reset */
 	mdelay(MCP251X_OST_DELAY_MS);
 
-	reg = mcp251x_read_reg(spi, CANSTAT);
-	if ((reg & CANCTRL_REQOP_MASK) != CANCTRL_REQOP_CONF)
-		return -ENODEV;
-
+	/* Wait for reset to finish */
+	timeout = jiffies + HZ;
+	while ((mcp251x_read_reg(spi, CANSTAT) & CANCTRL_REQOP_MASK) !=
+	       CANCTRL_REQOP_CONF) {
+		usleep_range(MCP251X_OST_DELAY_MS * 1000,
+			     MCP251X_OST_DELAY_MS * 1000 * 2);
+
+		if (time_after(jiffies, timeout)) {
+			dev_err(&spi->dev,
+				"MCP251x didn't enter in conf mode after reset\n");
+			return -EBUSY;
+		}
+	}
 	return 0;
 }
 
-- 
2.23.0.rc1
