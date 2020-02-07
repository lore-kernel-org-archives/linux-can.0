From: Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v3 2/2] dt-bindings: net: can: Convert M_CAN to json-schema
Date: Fri, 7 Feb 2020 10:51:13 +0100
Message-ID: <20200207095113.14489-3-benjamin.gaignard@st.com>
References: <20200207095113.14489-1-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200207095113.14489-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com, sriram.dash@samsung.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Gaignard <benjamin.gaignard@st.com>
List-Id: linux-can.vger.kernel.org

Convert M_CAN bindings to json-schema

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---version 3:
- move can-transceive node into bosch,m_can.yaml bindings

 .../devicetree/bindings/net/can/bosch,m_can.yaml   | 147 +++++++++++++++++++++
 .../devicetree/bindings/net/can/m_can.txt          |  75 -----------
 2 files changed, 147 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/m_can.txt

diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
new file mode 100644
index 000000000000..94fd2040a9be
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
@@ -0,0 +1,147 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/bosch,m_can.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bosch MCAN controller Bindings
+
+description: Bosch MCAN controller for CAN bus
+
+maintainers:
+  -  Sriram Dash <sriram.dash@samsung.com>
+
+allOf:
+  - $ref: can-transceiver.yaml
+
+properties:
+  compatible:
+    const: bosch,m_can
+
+  reg:
+    items:
+      - description: M_CAN registers map
+      - description: message RAM
+
+  reg-names:
+    items:
+      - const: m_can
+      - const: message_ram
+
+  interrupts:
+    items:
+      - description: interrupt line0
+      - description: interrupt line1
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    items:
+      - const: int0
+      - const: int1
+    minItems: 1
+    maxItems: 2
+
+  clocks:
+    items:
+      - description: peripheral clock
+      - description: bus clock
+
+  clock-names:
+    items:
+      - const: hclk
+      - const: cclk
+
+  bosch,mram-cfg:
+    description: |
+                 Message RAM configuration data.
+                 Multiple M_CAN instances can share the same Message RAM
+                 and each element(e.g Rx FIFO or Tx Buffer and etc) number
+                 in Message RAM is also configurable, so this property is
+                 telling driver how the shared or private Message RAM are
+                 used by this M_CAN controller.
+
+                 The format should be as follows:
+                 <offset sidf_elems xidf_elems rxf0_elems rxf1_elems rxb_elems txe_elems txb_elems>
+                 The 'offset' is an address offset of the Message RAM where
+                 the following elements start from. This is usually set to
+                 0x0 if you're using a private Message RAM. The remain cells
+                 are used to specify how many elements are used for each FIFO/Buffer.
+
+                 M_CAN includes the following elements according to user manual:
+                 11-bit Filter	0-128 elements / 0-128 words
+                 29-bit Filter	0-64 elements / 0-128 words
+                 Rx FIFO 0	0-64 elements / 0-1152 words
+                 Rx FIFO 1	0-64 elements / 0-1152 words
+                 Rx Buffers	0-64 elements / 0-1152 words
+                 Tx Event FIFO	0-32 elements / 0-64 words
+                 Tx Buffers	0-32 elements / 0-576 words
+
+                 Please refer to 2.4.1 Message RAM Configuration in Bosch
+                 M_CAN user manual for details.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/int32-array
+      - items:
+         items:
+           - description: The 'offset' is an address offset of the Message RAM
+                          where the following elements start from. This is usually
+                          set to 0x0 if you're using a private Message RAM.
+             default: 0
+           - description: 11-bit Filter 0-128 elements / 0-128 words
+             minimum: 0
+             maximum: 128
+           - description: 29-bit Filter 0-64 elements / 0-128 words
+             minimum: 0
+             maximum: 64
+           - description: Rx FIFO 0 0-64 elements / 0-1152 words
+             minimum: 0
+             maximum: 64
+           - description: Rx FIFO 1 0-64 elements / 0-1152 words
+             minimum: 0
+             maximum: 64
+           - description: Rx Buffers 0-64 elements / 0-1152 words
+             minimum: 0
+             maximum: 64
+           - description: Tx Event FIFO 0-32 elements / 0-64 words
+             minimum: 0
+             maximum: 32
+           - description: Tx Buffers 0-32 elements / 0-576 words
+             minimum: 0
+             maximum: 32
+        maxItems: 1
+
+  can-transceiver:
+    $ref: can-transceiver.yaml#
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - bosch,mram-cfg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx6sx-clock.h>
+    can@20e8000 {
+      compatible = "bosch,m_can";
+      reg = <0x020e8000 0x4000>, <0x02298000 0x4000>;
+      reg-names = "m_can", "message_ram";
+      interrupts = <0 114 0x04>, <0 114 0x04>;
+      interrupt-names = "int0", "int1";
+      clocks = <&clks IMX6SX_CLK_CANFD>,
+               <&clks IMX6SX_CLK_CANFD>;
+      clock-names = "hclk", "cclk";
+      bosch,mram-cfg = <0x0 0 0 32 0 0 0 1>;
+
+      can-transceiver {
+        max-bitrate = <5000000>;
+      };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/net/can/m_can.txt b/Documentation/devicetree/bindings/net/can/m_can.txt
deleted file mode 100644
index ed614383af9c..000000000000
--- a/Documentation/devicetree/bindings/net/can/m_can.txt
+++ /dev/null
@@ -1,75 +0,0 @@
-Bosch MCAN controller Device Tree Bindings
--------------------------------------------------
-
-Required properties:
-- compatible		: Should be "bosch,m_can" for M_CAN controllers
-- reg			: physical base address and size of the M_CAN
-			  registers map and Message RAM
-- reg-names		: Should be "m_can" and "message_ram"
-- interrupts		: Should be the interrupt number of M_CAN interrupt
-			  line 0 and line 1, could be same if sharing
-			  the same interrupt.
-- interrupt-names	: Should contain "int0" and "int1"
-- clocks		: Clocks used by controller, should be host clock
-			  and CAN clock.
-- clock-names		: Should contain "hclk" and "cclk"
-- pinctrl-<n>		: Pinctrl states as described in bindings/pinctrl/pinctrl-bindings.txt
-- pinctrl-names 	: Names corresponding to the numbered pinctrl states
-- bosch,mram-cfg	: Message RAM configuration data.
-			  Multiple M_CAN instances can share the same Message
-			  RAM and each element(e.g Rx FIFO or Tx Buffer and etc)
-			  number in Message RAM is also configurable,
-			  so this property is telling driver how the shared or
-			  private Message RAM are used by this M_CAN controller.
-
-			  The format should be as follows:
-			  <offset sidf_elems xidf_elems rxf0_elems rxf1_elems
-			   rxb_elems txe_elems txb_elems>
-			  The 'offset' is an address offset of the Message RAM
-			  where the following elements start from. This is
-			  usually set to 0x0 if you're using a private Message
-			  RAM. The remain cells are used to specify how many
-			  elements are used for each FIFO/Buffer.
-
-			  M_CAN includes the following elements according to user manual:
-			  11-bit Filter	0-128 elements / 0-128 words
-			  29-bit Filter	0-64 elements / 0-128 words
-			  Rx FIFO 0	0-64 elements / 0-1152 words
-			  Rx FIFO 1	0-64 elements / 0-1152 words
-			  Rx Buffers	0-64 elements / 0-1152 words
-			  Tx Event FIFO	0-32 elements / 0-64 words
-			  Tx Buffers	0-32 elements / 0-576 words
-
-			  Please refer to 2.4.1 Message RAM Configuration in
-			  Bosch M_CAN user manual for details.
-
-Optional Subnode:
-- can-transceiver	: Can-transceiver subnode describing maximum speed
-			  that can be used for CAN/CAN-FD modes. See
-			  Documentation/devicetree/bindings/net/can/can-transceiver.txt
-			  for details.
-Example:
-SoC dtsi:
-m_can1: can@20e8000 {
-	compatible = "bosch,m_can";
-	reg = <0x020e8000 0x4000>, <0x02298000 0x4000>;
-	reg-names = "m_can", "message_ram";
-	interrupts = <0 114 0x04>,
-		     <0 114 0x04>;
-	interrupt-names = "int0", "int1";
-	clocks = <&clks IMX6SX_CLK_CANFD>,
-		 <&clks IMX6SX_CLK_CANFD>;
-	clock-names = "hclk", "cclk";
-	bosch,mram-cfg = <0x0 0 0 32 0 0 0 1>;
-};
-
-Board dts:
-&m_can1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_m_can1>;
-	status = "enabled";
-
-	can-transceiver {
-		max-bitrate = <5000000>;
-	};
-};
-- 
2.15.0
