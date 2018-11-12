From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 09/20] can: hi311x: Use level-triggered interrupt
Date: Mon, 12 Nov 2018 12:57:17 +0100
Message-ID: <20181112115728.18331-10-mkl@pengutronix.de>
References: <20181112115728.18331-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181112115728.18331-1-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Lukas Wunner <lukas@wunner.de>, Mathias Duckeck <m.duckeck@kunbus.de>, Akshay Bhat <akshay.bhat@timesys.com>, Casey Fitzpatrick <casey.fitzpatrick@timesys.com>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Lukas Wunner <lukas@wunner.de>

If the hi3110 shares the SPI bus with another traffic-intensive device
and packets are received in high volume (by a separate machine sending
with "cangen -g 0 -i -x"), reception stops after a few minutes and the
counter in /proc/interrupts stops incrementing.  Bus state is "active".
Bringing the interface down and back up reconvenes the reception.  The
issue is not observed when the hi3110 is the sole device on the SPI bus.

Using a level-triggered interrupt makes the issue go away and lets the
hi3110 successfully receive 2 GByte over the course of 5 days while a
ks8851 Ethernet chip on the same SPI bus handles 6 GByte of traffic.

Unfortunately the hi3110 datasheet is mum on the trigger type.  The pin
description on page 3 only specifies the polarity (active high):
http://www.holtic.com/documents/371-hi-3110_v-rev-kpdf.do

Cc: Mathias Duckeck <m.duckeck@kunbus.de>
Cc: Akshay Bhat <akshay.bhat@timesys.com>
Cc: Casey Fitzpatrick <casey.fitzpatrick@timesys.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/holt_hi311x.txt | 2 +-
 drivers/net/can/spi/hi311x.c                              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/holt_hi311x.txt b/Documentation/devicetree/bindings/net/can/holt_hi311x.txt
index 903a78da65be..3a9926f99937 100644
--- a/Documentation/devicetree/bindings/net/can/holt_hi311x.txt
+++ b/Documentation/devicetree/bindings/net/can/holt_hi311x.txt
@@ -17,7 +17,7 @@ Example:
 		reg = <1>;
 		clocks = <&clk32m>;
 		interrupt-parent = <&gpio4>;
-		interrupts = <13 IRQ_TYPE_EDGE_RISING>;
+		interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
 		vdd-supply = <&reg5v0>;
 		xceiver-supply = <&reg5v0>;
 	};
diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index 53e320c92a8b..ddaf46239e39 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -760,7 +760,7 @@ static int hi3110_open(struct net_device *net)
 {
 	struct hi3110_priv *priv = netdev_priv(net);
 	struct spi_device *spi = priv->spi;
-	unsigned long flags = IRQF_ONESHOT | IRQF_TRIGGER_RISING;
+	unsigned long flags = IRQF_ONESHOT | IRQF_TRIGGER_HIGH;
 	int ret;
 
 	ret = open_candev(net);
-- 
2.19.1
