From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 02/16] dt-bindings: atmel-can: add microchip,sam9x60-can
Date: Wed, 8 Jan 2020 14:55:09 +0200
Message-ID: <1578488123-26127-3-git-send-email-claudiu.beznea@microchip.com>
References: <1578488123-26127-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1578488123-26127-1-git-send-email-claudiu.beznea@microchip.com>
Sender: netdev-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com, vkoul@kernel.org, eugen.hristev@microchip.com, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, mchehab@kernel.org, lee.jones@linaro.org, richard.genoud@gmail.com, radu_nicolae.pirea@upb.ro, tudor.ambarus@microchip.com, miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, wg@grandegger.com, mkl@pengutronix.de, a.zummo@towertech.it, broonie@kernel.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-iio@vger.kernel.org, linux-media@vger.kernel.org, linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, Claudiu Beznea <claudiu.beznea@microchip.com>
List-Id: linux-can.vger.kernel.org

Add microchip,sam9x60-can to DT bindings documentation.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/net/can/atmel-can.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/atmel-can.txt b/Documentation/devicetree/bindings/net/can/atmel-can.txt
index 14e52a0d86ec..218a3b3eb27e 100644
--- a/Documentation/devicetree/bindings/net/can/atmel-can.txt
+++ b/Documentation/devicetree/bindings/net/can/atmel-can.txt
@@ -1,7 +1,8 @@
 * AT91 CAN *
 
 Required properties:
-  - compatible: Should be "atmel,at91sam9263-can" or "atmel,at91sam9x5-can"
+  - compatible: Should be "atmel,at91sam9263-can", "atmel,at91sam9x5-can" or
+    "microchip,sam9x60-can"
   - reg: Should contain CAN controller registers location and length
   - interrupts: Should contain IRQ line for the CAN controller
 
-- 
2.7.4
