From: Mark Jonas <mark.jonas@de.bosch.com>
Subject: [PATCH v2 5/5] spi,can,char: add companion DT binding documentation
Date: Wed, 13 Jun 2018 16:37:21 +0200
Message-ID: <1528900641-18677-6-git-send-email-mark.jonas@de.bosch.com>
References: <1528224240-30786-1-git-send-email-mark.jonas@de.bosch.com>
 <1528900641-18677-1-git-send-email-mark.jonas@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528900641-18677-1-git-send-email-mark.jonas@de.bosch.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hs@denx.de, yi.zhu5@cn.bosch.com, petar.petrovic2@de.bosch.com, stephan.baetge@de.bosch.com, andy.shevchenko@gmail.com, socketcan@hartkopp.net, o.rempel@pengutronix.de, Mark Jonas <mark.jonas@de.bosch.com>
List-Id: linux-can.vger.kernel.org

From: Zhu Yi <yi.zhu5@cn.bosch.com>

Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
---
 .../devicetree/bindings/spi/bosch,companion.txt    | 82 ++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/bosch,companion.txt

diff --git a/Documentation/devicetree/bindings/spi/bosch,companion.txt b/Documentation/devicetree/bindings/spi/bosch,companion.txt
new file mode 100644
index 0000000..5ded325
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/bosch,companion.txt
@@ -0,0 +1,82 @@
+Bosch Companion SPI slave device
+
+The functionality bases on an external peripheral chip named Companion.
+It offers two CAN interfaces, each has 8 prioritized transmit FIFOs as
+well as one receive FIFO. Besides CAN, undisclosed additional functions
+can be accessed through the char device.
+
+A standard SPI interface with two additional lines for flow control is
+used. The Companion chip is the SPI slave.
+
+The driver suite consists of three separate drivers. The following
+diagram illustrates the dependencies in layers.
+
+           /dev/companion       SocketCAN                User Space
+-------------------------------------------------------------------
+         +----------------+ +---------------+
+         | companion-char | | companion-can |
+         +----------------+ +---------------+
+         +----------------------------------+
+         |          companion-spi           |
+         +----------------------------------+
+         +----------------------------------+
+         |     standard SPI subsystem       |
+         +----------------------------------+          Linux Kernel
+-------------------------------------------------------------------
+               | | | |      | |                            Hardware
+            CS-+ | | |      | +-BUSY
+            CLK--+ | |      +---REQUEST
+            MOSI---+ |
+            MISO-----+
+
+Required properties:
+
+- compatible       : must be "bosch,companion-spi"
+- interrupt-parent : the phandle of the GPIO controller
+- interrupts       : (GPIO) interrupt to which 'request-gpios' is
+                     connected to
+- request-gpios    : GPIO pin to request SPI master to receive data
+- busy-gpios       : GPIO pin to indicate SPI slave is busy
+- cs-gpios         : GPIO pin to select SPI slave
+
+Optional properties:
+
+The controller supports at most 2 CAN and 1 char device subnodes. When
+optionally specify the subnodes, the following properties are required:
+
+- CAN subnode
+  - compatible     : must be "bosch,companion-can"
+  - clock-frequency: CAN device clock in Hz
+  - port           : must be 0 or 1
+
+- Char device subnode
+  - compatible     : must be "bosch,companion-char"
+
+Example:
+
+&ecspi1 {
+	companion-spi@0 {
+		compatible = "bosch,companion-spi";
+		interrupt-parent = <&gpio1>;
+		interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
+		request-gpios = <&gpio1 26 GPIO_ACTIVE_LOW>;
+		busy-gpios = <&gpio1 27 GPIO_ACTIVE_LOW>;
+		cs-gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;
+
+		companion-can0 {
+			compatible = "bosch,companion-can";
+			clock-frequency = <28000000>;
+			port = <0>;
+		};
+
+		companion-can1 {
+			compatible = "bosch,companion-can";
+			clock-frequency = <28000000>;
+			port = <1>;
+		};
+
+		companion-char {
+			compatible = "bosch,companion-char";
+		};
+	};
+};
-- 
2.7.4
