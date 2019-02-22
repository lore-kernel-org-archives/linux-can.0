From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: [PATCH] dt-bindings: net: can: binding for CTU CAN FD open-source IP core.
Date: Fri, 22 Feb 2019 14:20:05 +0100
Message-ID: <201902221420.05267.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Jerabek <martin.jerabek01@gmail.com>, Ondrej Ille <ondrej.ille@gmail.com>
List-Id: linux-can.vger.kernel.org

From 3e19a7f5c33e5fb50f52c9df05bf00022e3f3dd5 Mon Sep 17 00:00:00 2001
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Date: Fri, 22 Feb 2019 14:11:11 +0100
Subject: [PATCH] dt-bindings: net: can: binding for CTU CAN FD open-source IP
 core.

Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
---
 .../devicetree/bindings/net/can/ctu,ctucanfd.txt   | 102 +++++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/ctu,ctucanfd.txt

diff --git a/Documentation/devicetree/bindings/net/can/ctu,ctucanfd.txt 
b/Documentation/devicetree/bindings/net/can/ctu,ctucanfd.txt
new file mode 100644
index 000000000000..6c75e5850904
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/ctu,ctucanfd.txt
@@ -0,0 +1,102 @@
+Memory mapped CTU CAN FD open-source IP core
+
+The core sources and documentation on project page
+
+  https://gitlab.fel.cvut.cz/canbus/ctucanfd_ip_core
+  http://canbus.pages.fel.cvut.cz/ctucanfd_ip_core/Progdokum.pdf
+
+Integration in Xilinx Zynq SoC based system together with
+OpenCores SJA1000 compatible controllers
+
+  https://gitlab.fel.cvut.cz/canbus/zynq/zynq-can-sja1000-top
+
+Martin Jerabek's dimploma thesis with integration and testing
+framework description
+
+ 
https://dspace.cvut.cz/bitstream/handle/10467/80366/F3-DP-2019-Jerabek-Martin-Jerabek-thesis-2019-canfd.pdf
+
+Required properties:
+
+- compatible : should be one of "ctu,ctucanfd", "ctu,canfd-2".
+
+- reg = <(baseaddr) (size)> : specify mapping into physical address
+      space of the processor system.
+
+- interrupts : property with a value describing the interrupt source
+      required for the CTU CAN FD. For Zynq SoC system format is
+      <(is_spi) (number) (type)> where is_spi defines if it is SPI
+      (shared peripheral) interrupt, the second number is translated
+      to the vector by addition of 32 on Zynq-7000 systems and type
+      is IRQ_TYPE_LEVEL_HIGH (4) for Zynq.
+
+- interrupt-parent = <&interrupt-controller-phandle> :
+      is required for Zynq SoC to find map interrupt
+      to the correct controller
+
+- clocks: phandle of reference clock (100 MHz is appropriate
+      for FPGA implementation on Zynq-7000 system).
+
+Example when integrated to Zynq-7000 system DTS:
+
+        / {
+            /* ... */
+            amba: amba {
+                #address-cells = <1>;
+                #size-cells = <1>;
+                compatible = "simple-bus";
+
+                CTU_CAN_FD_0: CTU_CAN_FD@43c30000 {
+                    compatible = "ctu,ctucanfd";
+                    interrupt-parent = <&intc>;
+                    interrupts = <0 30 4>;
+                    clocks = <&clkc 15>;
+                    reg = <0x43c30000 0x10000>;
+                };
+            };
+        };
+
+
+Example when used as DTS overlay on Zynq-7000 system:
+
+
+// Device Tree Example: Full Reconfiguration without Bridges
+/dts-v1/;
+/plugin/;
+
+/ {
+    fragment@0 {
+        target-path = "/fpga-full";
+
+        __overlay__ {
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            firmware-name = "system.bit.bin";
+        };
+    };
+
+    fragment@1 {
+        target-path = "/amba";
+        __overlay__ {
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            CTU_CAN_FD_0: CTU_CAN_FD@43c30000 {
+                compatible = "ctu,ctucanfd";
+                interrupt-parent = <&intc>;
+                interrupts = <0 30 4>;
+                clocks = <&clkc 15>;
+                //clock-names = "can_clk";
+                reg = <0x43c30000 0x10000>;
+            };
+            CTU_CAN_FD_1: CTU_CAN_FD@43c70000 {
+                compatible = "ctu,ctucanfd";
+                interrupt-parent = <&intc>;
+                interrupts = <0 31 4>;
+                clocks = <&clkc 15>;
+                //clock-names = "can_clk";
+                reg = <0x43c70000 0x10000>;
+            };
+        };
+    };
+};
-- 
2.11.0
