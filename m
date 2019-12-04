From: Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 1/2] dt-bindings: tcan4x5x: Make wake-gpio an optional gpio
Date: Wed, 4 Dec 2019 11:51:11 -0600
Message-ID: <20191204175112.7308-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Dan Murphy <dmurphy@ti.com>, Rob Herring <robh@kernel.org>
List-Id: linux-can.vger.kernel.org

The wake-up of the device can be configured as an optional
feature of the device.  Move the wake-up gpio from a requried
property to an optional property.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
CC: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/can/tcan4x5x.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
index 27e1b4cebfbd..7cf5ef7acba4 100644
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
2.23.0
