From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 11/13] dt-bindings: tcan4x5x: Make wake-gpio an optional gpio
Date: Mon,  9 Dec 2019 17:32:54 +0100
Message-ID: <20191209163256.12000-12-mkl@pengutronix.de>
References: <20191209163256.12000-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191209163256.12000-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>, Rob Herring <robh@kernel.org>, Sean Nyekjaer <sean@geanix.com>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Dan Murphy <dmurphy@ti.com>

The wake-up of the device can be configured as an optional feature of
the device. Move the wake-up gpio from a requried property to an
optional property.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
Cc: Rob Herring <robh@kernel.org>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
Tested-by: Sean Nyekjaer <sean@geanix.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/tcan4x5x.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
index e8aa21d9174e..6bdcc3f84bd3 100644
--- a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
+++ b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
@@ -10,7 +10,6 @@ Required properties:
 	- #size-cells: 0
 	- spi-max-frequency: Maximum frequency of the SPI bus the chip can
 			     operate at should be less than or equal to 18 MHz.
-	- device-wake-gpios: Wake up GPIO to wake up the TCAN device.
 	- interrupt-parent: the phandle to the interrupt controller which provides
                     the interrupt.
 	- interrupts: interrupt specification for data-ready.
@@ -23,6 +22,7 @@ Optional properties:
 		       reset.
 	- device-state-gpios: Input GPIO that indicates if the device is in
 			      a sleep state or if the device is active.
+	- device-wake-gpios: Wake up GPIO to wake up the TCAN device.
 
 Example:
 tcan4x5x: tcan4x5x@0 {
-- 
2.24.0
