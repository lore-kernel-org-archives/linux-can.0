From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 1/2] dt-binding: can: mcp2517fd: document device tree bindings
Date: Fri, 24 Nov 2017 18:35:08 +0000
Message-ID: <20171124183509.12810-2-kernel@martin.sperl.org>
References: <20171124183509.12810-1-kernel@martin.sperl.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171124183509.12810-1-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Id: linux-can.vger.kernel.org

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Add device-tree bindings for Microcip CanFD Controller mcp2517fd

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 .../bindings/net/can/microchip,mcp2517fd.txt       | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp2517fd.txt

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp2517fd.txt b/Documentation/devicetree/bindings/net/can/microchip,mcp2517fd.txt
new file mode 100644
index 000000000000..96cbf0c96895
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/microchip,mcp2517fd.txt
@@ -0,0 +1,47 @@
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
+ - microchip,clock_div = <1|2>: internal clock divider - default 1
+ - microchip,gpio_opendrain: gpio (int0,1) in open drain mode
+			     instead of default push/pull
+ - microchip,int_opendrain: int pin in open drain mode
+			    instead of default push/pull
+ - microchip,txcan_opendrain: txcan pin in open drain mode
+			      instead of default push/pull
+ - microchip,gpio0_mode : gpio mode functionality
+			  0 = input
+			  1 = TX interrupt output - default
+			  2 = output default low
+			  3 = output default high
+			  4 = (tx) transceiver standby
+ - microchip,gpio1_mode : gpio mode functionality
+			  0 = input - default
+			  1 = RX interrupt output - default
+			  2 = output default low
+			  3 = output default high
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
+		microchip,gpio0_mode = <4>;
+		microchip,gpio0_mode = <1>;
+	};
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
