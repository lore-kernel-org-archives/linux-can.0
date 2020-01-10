From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 08/17] dt-bindings: atmel-nand: add microchip,sam9x60-pmecc
Date: Fri, 10 Jan 2020 18:18:00 +0200
Message-ID: <1578673089-3484-9-git-send-email-claudiu.beznea@microchip.com>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:17028 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbgAJQTu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 10 Jan 2020 11:19:50 -0500
In-Reply-To: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: robh+dt@kernel.org, mark.rutland@arm.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com, vkoul@kernel.org, eugen.hristev@microchip.com, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, mchehab@kernel.org, lee.jones@linaro.org, radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com, tudor.ambarus@microchip.com, miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, wg@grandegger.com, mkl@pengutronix.de, a.zummo@towertech.it
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-iio@vger.kernel.org, linux-media@vger.kernel.org, linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, linux-can@vger.kernel.org, linux-rtc@vger.kernel.org, Claudiu Beznea <claudiu.beznea@microchip.com>

Add microchip,sam9x60-pmecc to DT bindings documentation.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 Documentation/devicetree/bindings/mtd/atmel-nand.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.txt b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
index 68b51dc58816..3aa297c97ab6 100644
--- a/Documentation/devicetree/bindings/mtd/atmel-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
@@ -57,6 +57,7 @@ Required properties:
 	"atmel,at91sam9g45-pmecc"
 	"atmel,sama5d4-pmecc"
 	"atmel,sama5d2-pmecc"
+	"microchip,sam9x60-pmecc"
 - reg: should contain 2 register ranges. The first one is pointing to the PMECC
        block, and the second one to the PMECC_ERRLOC block.
 
-- 
2.7.4
