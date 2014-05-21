From: Kedareswara rao Appana <appana.durga.rao@xilinx.com>
Subject: [PATCH v8 1/2] can: Add xilinx CAN device tree bindings documentation.
Date: Wed, 21 May 2014 17:11:29 +0530
Message-ID: <17489036-3743-4393-afc6-a9064325b4d5@BN1BFFO11FD053.protection.gbl>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rob@landley.net, michal.simek@xilinx.com
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, Kedareswara rao Appana <appanad@xilinx.com>
List-Id: linux-can.vger.kernel.org

Add xilinx CAN bindings documentation.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
Changes for v8:
- None.
Changes for v7:
- Split the devicetree bindings doc as a seperate patch
---
 .../devicetree/bindings/net/can/xilinx_can.txt     |   44 ++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/xilinx_can.txt

diff --git a/Documentation/devicetree/bindings/net/can/xilinx_can.txt b/Documentation/devicetree/bindings/net/can/xilinx_can.txt
new file mode 100644
index 0000000..fe38847
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/xilinx_can.txt
@@ -0,0 +1,44 @@
+Xilinx Axi CAN/Zynq CANPS controller Device Tree Bindings
+---------------------------------------------------------
+
+Required properties:
+- compatible		: Should be "xlnx,zynq-can-1.0" for Zynq CAN
+			  controllers and "xlnx,axi-can-1.00.a" for Axi CAN
+			  controllers.
+- reg			: Physical base address and size of the Axi CAN/Zynq
+			  CANPS registers map.
+- interrupts		: Property with a value describing the interrupt
+			  number.
+- interrupt-parent	: Must be core interrupt controller
+- clock-names		: List of input clock names - "can_clk", "pclk"
+			  (For CANPS), "can_clk" , "s_axi_aclk"(For AXI CAN)
+			  (See clock bindings for details).
+- clocks		: Clock phandles (see clock bindings for details).
+- tx-fifo-depth		: Can Tx fifo depth.
+- rx-fifo-depth		: Can Rx fifo depth.
+
+
+Example:
+
+For Zynq CANPS Dts file:
+	zynq_can_0: can@e0008000 {
+			compatible = "xlnx,zynq-can-1.0";
+			clocks = <&clkc 19>, <&clkc 36>;
+			clock-names = "can_clk", "pclk";
+			reg = <0xe0008000 0x1000>;
+			interrupts = <0 28 4>;
+			interrupt-parent = <&intc>;
+			tx-fifo-depth = <0x40>;
+			rx-fifo-depth = <0x40>;
+		};
+For Axi CAN Dts file:
+	axi_can_0: axi-can@40000000 {
+			compatible = "xlnx,axi-can-1.00.a";
+			clocks = <&clkc 0>, <&clkc 1>;
+			clock-names = "can_clk","s_axi_aclk" ;
+			reg = <0x40000000 0x10000>;
+			interrupt-parent = <&intc>;
+			interrupts = <0 59 1>;
+			tx-fifo-depth = <0x40>;
+			rx-fifo-depth = <0x40>;
+		};
-- 
1.7.4


