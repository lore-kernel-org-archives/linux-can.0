From: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] can: mcp251x: convert to half-duplex SPI
Date: Tue, 25 Feb 2020 10:35:34 -0800
Message-ID: <1582655734-20890-1-git-send-email-tharvey@gateworks.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: =?UTF-8?q?Timo=20Schl=C3=BC=C3=9Fler?= <schluessler@krause.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tim Harvey <tharvey@gateworks.com>
List-Id: linux-can.vger.kernel.org

Some SPI host controllers such as the Cavium Thunder do not support
full-duplex SPI. Using half-duplex transfers allows the driver to work
with those host controllers.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/net/can/spi/mcp251x.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 5009ff2..840c31c 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -290,23 +290,23 @@ static u8 mcp251x_read_reg(struct spi_device *spi, u8 reg)
 	priv->spi_tx_buf[0] = INSTRUCTION_READ;
 	priv->spi_tx_buf[1] = reg;
 
-	mcp251x_spi_trans(spi, 3);
-	val = priv->spi_rx_buf[2];
+	spi_write_then_read(spi, priv->spi_tx_buf, 2, &val, 1);
 
 	return val;
 }
 
 static void mcp251x_read_2regs(struct spi_device *spi, u8 reg, u8 *v1, u8 *v2)
 {
+	u8 val[4] = {0};
 	struct mcp251x_priv *priv = spi_get_drvdata(spi);
 
 	priv->spi_tx_buf[0] = INSTRUCTION_READ;
 	priv->spi_tx_buf[1] = reg;
 
-	mcp251x_spi_trans(spi, 4);
+	spi_write_then_read(spi, priv->spi_tx_buf, 2, val, 2);
 
-	*v1 = priv->spi_rx_buf[2];
-	*v2 = priv->spi_rx_buf[3];
+	*v1 = val[0];
+	*v2 = val[1];
 }
 
 static void mcp251x_write_reg(struct spi_device *spi, u8 reg, u8 val)
-- 
2.7.4
