From: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Subject: [PATCH v2 1/2] Allwinner SoC CAN controller Support
Date: Thu,  3 Sep 2015 12:09:29 +0200
Message-ID: <1441274970-5632-2-git-send-email-info@gerhard-bertelsmann.de>
References: <1441274970-5632-1-git-send-email-info@gerhard-bertelsmann.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.rdts.de ([195.243.153.28]:36750 "EHLO mail.rdts.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753959AbbICKJl (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 3 Sep 2015 06:09:41 -0400
In-Reply-To: <1441274970-5632-1-git-send-email-info@gerhard-bertelsmann.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, Gerhard Bertelsmann <info@gerhard-bertelsmann.de>

Devicetree Bindings documentation

Signed-off-by: Gerhard Bertelsmann < info@gerhard-bertelsmann.de >


.../devicetree/bindings/net/can/sunxi_can.txt      |  42 ++
 1 files changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/sunxi_can.txt b/Documentation/devicetree/bindings/net/can/sunxi_can.txt
new file mode 100644
index 0000000..454e92f
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/sunxi_can.txt
@@ -0,0 +1,42 @@
+Allwinner A10/A20 CAN controller Device Tree Bindings
+-----------------------------------------------------
+
+Required properties:
+- compatible: "allwinner,sunxican"
+- reg: physical base address and size of the Allwinner A10/A20 CAN register map.
+- interrupts: interrupt specifier for the sole interrupt.
+- clocks: phandle and clock specifier.
+- pinctrl-0: pin control group to be used for this controller.
+- pinctrl-names: must be "default".
+
+
+Example
+-------
+
+SoC common .dtsi file:
+
+	can0_pins_a: can0@0 {
+		allwinner,pins = "PH20","PH21";
+		allwinner,function = "can";
+		allwinner,drive = <0>;
+		allwinner,pull = <0>;
+	};
+
+	can0: can@01c2bc00 {
+		compatible = "allwinner,sunxican";
+		reg = <0x01c2bc00 0x400>;
+		interrupts = <0 26 4>;
+		clocks = <&apb1_gates 4>;
+		status = "disabled";
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+Board specific .dts file:
+
+	can0: can@01c2bc00 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&can0_pins_a>;
+		status = "okay";
+	};
+
