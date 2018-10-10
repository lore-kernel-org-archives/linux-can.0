From: Dan Murphy <dmurphy@ti.com>
Subject: [RFC PATCH 2/3] dt-bindings: can: tcan4x5x: Add DT bindings for TCAN4x5X driver
Date: Wed, 10 Oct 2018 09:20:54 -0500
Message-ID: <20181010142055.25271-3-dmurphy@ti.com>
References: <20181010142055.25271-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010142055.25271-1-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Murphy <dmurphy@ti.com>
List-Id: linux-can.vger.kernel.org

DT binding documentation for TI TCAN4x5x driver.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../devicetree/bindings/net/can/tcan4x5x.txt  | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/tcan4x5x.txt

diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
new file mode 100644
index 000000000000..c742d0f10861
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
@@ -0,0 +1,34 @@
+Texas Instruments TCAN4x5x CAN Controller
+================================================
+
+This file provides device node information for the TCAN4x5x interface contains.
+
+Required properties:
+	- compatible: "ti,tcan4x5x"
+	- reg: 0
+	- #address-cells : 1
+	- #size-cells : 0
+	- spi-max-frequency: Maximum frequency of the SPI bus the chip can
+			     operate at should be less than or equal to 18 MHz.
+	- data-ready-gpios: Interrupt GPIO for data and error reporting.
+	- wake-up-gpios: Wake up GPIO to wake up the TCAN device
+
+See Documentation/devicetree/bindings/net/can/m_can.txt for additional
+required property details.
+
+Optional properties:
+	- reset-gpios: Hardwired output GPIO. If not defined then software
+		       reset.
+
+Example:
+tcan4x5x: tcan4x5x@0 {
+		compatible = "ti,tcan4x5x";
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		clocks = <&tclkin_ck>;
+		spi-max-frequency = <10000000>;
+		data-ready-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
+		wake-up-gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio1 27 GPIO_ACTIVE_LOW>;
+	};
-- 
2.19.0
