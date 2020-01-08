From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 13/16] dt-bindings: atmel-usart: add microchip,<chip>-usart
Date: Wed, 8 Jan 2020 14:55:20 +0200
Message-ID: <1578488123-26127-14-git-send-email-claudiu.beznea@microchip.com>
References: <1578488123-26127-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1578488123-26127-1-git-send-email-claudiu.beznea@microchip.com>
Sender: netdev-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com, vkoul@kernel.org, eugen.hristev@microchip.com, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, mchehab@kernel.org, lee.jones@linaro.org, richard.genoud@gmail.com, radu_nicolae.pirea@upb.ro, tudor.ambarus@microchip.com, miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, wg@grandegger.com, mkl@pengutronix.de, a.zummo@towertech.it, broonie@kernel.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-iio@vger.kernel.org, linux-media@vger.kernel.org, linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, Claudiu Beznea <claudiu.beznea@microchip.com>
List-Id: linux-can.vger.kernel.org

Add microchip,<chip>-usart to DT bindings documentation. This is for
microchip,sam9x60-usart.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/mfd/atmel-usart.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/atmel-usart.txt b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
index 699fd3c9ace8..e5c7331abe09 100644
--- a/Documentation/devicetree/bindings/mfd/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
@@ -1,10 +1,12 @@
 * Atmel Universal Synchronous Asynchronous Receiver/Transmitter (USART)
 
 Required properties for USART:
-- compatible: Should be "atmel,<chip>-usart" or "atmel,<chip>-dbgu"
+- compatible: Should be "atmel,<chip>-usart", "microchip,<chip>-usart" or
+  "atmel,<chip>-dbgu".
   The compatible <chip> indicated will be the first SoC to support an
   additional mode or an USART new feature.
-  For the dbgu UART, use "atmel,<chip>-dbgu", "atmel,<chip>-usart"
+  For the dbgu UART, use "atmel,<chip>-dbgu", "atmel,<chip>-usart",
+  "microchip,<chip>-usart".
 - reg: Should contain registers location and length
 - interrupts: Should contain interrupt
 - clock-names: tuple listing input clock names.
-- 
2.7.4
