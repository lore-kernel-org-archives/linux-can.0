From: kernel@martin.sperl.org
Subject: [PATCH V2 1/3] dt-binding: can: mcp25xxfd: document device tree bindings
Date: Fri, 19 Jan 2018 07:41:38 +0000
Message-ID: <20180119074140.25931-2-kernel@martin.sperl.org>
References: <20180119074140.25931-1-kernel@martin.sperl.org>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]:39544
        "EHLO cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbeASHlv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Jan 2018 02:41:51 -0500
In-Reply-To: <20180119074140.25931-1-kernel@martin.sperl.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org, devicetree@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Mark Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Martin Sperl <kernel@martin.sperl.org>, Marcel Birthelmer <Marcel.Birthelmer@microchip.com>, Sukkin Pang <skp@skpang.co.uk>, Gerhard Bertelsmann <info@gerhard-bertelsmann.de>

From: Martin Sperl <kernel@martin.sperl.org>

Add device-tree bindings for Microcip CanFD Controller mcp2517fd

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

---
Changelog:
  V1 -> V2: new more generic name based on feedback from microchip
            cleanup of dt custom properties removing (most) gpio functions
---
 .../bindings/net/can/microchip,mcp25xxfd.txt       | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.txt

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.txt b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.txt
new file mode 100644
index 000000000000..691dd6220bd7
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.txt
@@ -0,0 +1,29 @@
+* Microchip MCP2517 stand-alone CAN controller device tree bindings
+
+Required properties:
+ - compatible: Should be one of the following:
+   - "microchip,mcp2517fd" for MCP2517fd.
+ - reg: SPI chip select.
+ - clocks: The clock feeding the CAN controller.
+ - interrupt-parent: The parent interrupt controller.
+ - interrupts: Should contain IRQ line for the CAN controller.
+
+Optional properties:
+ - vdd-supply: Regulator that powers the CAN controller.
+ - xceiver-supply: Regulator that powers the CAN transceiver.
+ - microchip,clock_out_div = <0|1|2|4|10>: Clock output pin divider
+					   0 = Start of Frame output
+					   default: 10
+ - microchip,clock_div2: bool: divide the internal clock by 2
+ - gpio_opendrain: bool: enable open-drain for all pins (except cantx)
+
+Example:
+	can0: can@1 {
+		compatible = "microchip,mcp2515";
+		reg = <1>;
+		clocks = <&clk24m>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <13 0x8>;
+		vdd-supply = <&reg5v0>;
+		xceiver-supply = <&reg5v0>;
+	};
--
2.11.0
