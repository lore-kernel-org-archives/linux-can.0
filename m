From: Akshay Bhat <akshay.bhat@timesys.com>
Subject: [PATCH v2 1/2] can: holt_hi311x: document device tree bindings
Date: Tue, 17 Jan 2017 14:22:01 -0500
Message-ID: <1484680922-25813-1-git-send-email-akshay.bhat@timesys.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:33527 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbdAQTXD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 17 Jan 2017 14:23:03 -0500
Received: by mail-qt0-f169.google.com with SMTP id v23so174622839qtb.0
        for <linux-can@vger.kernel.org>; Tue, 17 Jan 2017 11:23:02 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Akshay Bhat <akshay.bhat@timesys.com>, Akshay Bhat <nodeax@gmail.com>

Document the HOLT HI-311x CAN device tree bindings.

Signed-off-by: Akshay Bhat <nodeax@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---

v1 -> v2:
- No changes

 .../devicetree/bindings/net/can/holt_hi311x.txt    | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/holt_hi311x.txt

diff --git a/Documentation/devicetree/bindings/net/can/holt_hi311x.txt b/Documentation/devicetree/bindings/net/can/holt_hi311x.txt
new file mode 100644
index 0000000..23aa94e
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/holt_hi311x.txt
@@ -0,0 +1,24 @@
+* Holt HI-311X stand-alone CAN controller device tree bindings
+
+Required properties:
+ - compatible: Should be one of the following:
+   - "holt,hi3110" for HI-3110
+ - reg: SPI chip select.
+ - clocks: The clock feeding the CAN controller.
+ - interrupt-parent: The parent interrupt controller.
+ - interrupts: Should contain IRQ line for the CAN controller.
+
+Optional properties:
+ - vdd-supply: Regulator that powers the CAN controller.
+ - xceiver-supply: Regulator that powers the CAN transceiver.
+
+Example:
+	can0: can@1 {
+		compatible = "holt,hi3110";
+		reg = <1>;
+		clocks = <&clk32m>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <13 IRQ_TYPE_EDGE_RISING>;
+		vdd-supply = <&reg5v0>;
+		xceiver-supply = <&reg5v0>;
+	};
-- 
2.8.1

