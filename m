From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 11/17] dt-bindings: atmel-gpbr: add microchip,sam9x60-gpbr
Date: Fri, 10 Jan 2020 18:18:03 +0200
Message-ID: <1578673089-3484-12-git-send-email-claudiu.beznea@microchip.com>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:32637 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728636AbgAJQUQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 10 Jan 2020 11:20:16 -0500
In-Reply-To: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: robh+dt@kernel.org, mark.rutland@arm.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com, vkoul@kernel.org, eugen.hristev@microchip.com, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, mchehab@kernel.org, lee.jones@linaro.org, radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com, tudor.ambarus@microchip.com, miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, wg@grandegger.com, mkl@pengutronix.de, a.zummo@towertech.it
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-iio@vger.kernel.org, linux-media@vger.kernel.org, linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, linux-can@vger.kernel.org, linux-rtc@vger.kernel.org, Claudiu Beznea <claudiu.beznea@microchip.com>

Add microchip,sam9x60-gpbr to DT bindings documentation.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/mfd/atmel-gpbr.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/atmel-gpbr.txt b/Documentation/devicetree/bindings/mfd/atmel-gpbr.txt
index a28569540683..e8c525569f10 100644
--- a/Documentation/devicetree/bindings/mfd/atmel-gpbr.txt
+++ b/Documentation/devicetree/bindings/mfd/atmel-gpbr.txt
@@ -3,7 +3,9 @@
 The GPBR are a set of battery-backed registers.
 
 Required properties:
-- compatible:		"atmel,at91sam9260-gpbr", "syscon"
+- compatible:		Should be one of the following:
+			"atmel,at91sam9260-gpbr", "syscon"
+			"microchip,sam9x60-gpbr", "syscon"
 - reg:			contains offset/length value of the GPBR memory
 			region.
 
-- 
2.7.4
