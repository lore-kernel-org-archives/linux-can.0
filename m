From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 12/17] dt-bindings: atmel,at91rm9200-rtc: add microchip,sam9x60-rtc
Date: Fri, 10 Jan 2020 18:18:04 +0200
Message-ID: <1578673089-3484-13-git-send-email-claudiu.beznea@microchip.com>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:25465 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729081AbgAJQU0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 10 Jan 2020 11:20:26 -0500
In-Reply-To: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: robh+dt@kernel.org, mark.rutland@arm.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com, vkoul@kernel.org, eugen.hristev@microchip.com, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, mchehab@kernel.org, lee.jones@linaro.org, radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com, tudor.ambarus@microchip.com, miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, wg@grandegger.com, mkl@pengutronix.de, a.zummo@towertech.it
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-iio@vger.kernel.org, linux-media@vger.kernel.org, linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, linux-can@vger.kernel.org, linux-rtc@vger.kernel.org, Claudiu Beznea <claudiu.beznea@microchip.com>

Add microchip,sam9x60-rtc to DT bindings documentation.

Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

Hi Alexandre,

I kept this patch as in v1 (same for patch
"dt-bindings: atmel-tcb: add microchip,sam9x60-tcb").
I'm waiting your response to this version and take an action aftewards.

Thank you,
Claudiu Beznea

 Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt
index 5d3791e789c6..35eab9138d0b 100644
--- a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt
@@ -1,7 +1,8 @@
 Atmel AT91RM9200 Real Time Clock
 
 Required properties:
-- compatible: should be: "atmel,at91rm9200-rtc" or "atmel,at91sam9x5-rtc"
+- compatible: should be: "atmel,at91rm9200-rtc", "atmel,at91sam9x5-rtc" or
+  "microchip,sam9x60-rtc"
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: rtc alarm/event interrupt
-- 
2.7.4
