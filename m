From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 05/16] dt-bindings: at91-sama5d2_adc: add microchip,sam9x60-adc
Date: Wed, 8 Jan 2020 14:55:12 +0200
Message-ID: <1578488123-26127-6-git-send-email-claudiu.beznea@microchip.com>
References: <1578488123-26127-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1578488123-26127-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com, vkoul@kernel.org, eugen.hristev@microchip.com, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, mchehab@kernel.org, lee.jones@linaro.org, richard.genoud@gmail.com, radu_nicolae.pirea@upb.ro, tudor.ambarus@microchip.com, miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, wg@grandegger.com, mkl@pengutronix.de, a.zummo@towertech.it, broonie@kernel.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-iio@vger.kernel.org, linux-media@vger.kernel.org, linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, Claudiu Beznea <claudiu.beznea@microchip.com>
List-Id: linux-can.vger.kernel.org

Add microchip,sam9x60-adc to DT bindings documentation.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
index 4a3c1d496e1a..07c59f301b31 100644
--- a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
@@ -1,7 +1,7 @@
 * AT91 SAMA5D2 Analog to Digital Converter (ADC)
 
 Required properties:
-  - compatible: Should be "atmel,sama5d2-adc".
+  - compatible: Should be "atmel,sama5d2-adc" or "microchip,sam9x60-adc".
   - reg: Should contain ADC registers location and length.
   - interrupts: Should contain the IRQ line for the ADC.
   - clocks: phandle to device clock.
-- 
2.7.4
