Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3C733A70A;
	Mon, 14 Sep 2026 03:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789354954; cv=none; b=BCb4S37jUAOS+ycsINNJ9a1niCdpYFGzqZhkmOtbw0r8IzJvwP3XtI7pbpflUVNy9hjTPM5EZFaGOzYT+I1O/Tfm7O0NrmiGc4MtMFx+VgB8xLiO67NSfOlN2eUWPLdTjl0VWIpY5n82PRJM+VDzKdtgWifZNGbHP/IGJ6VeKcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789354954; c=relaxed/simple;
	bh=ndG7F+utZP8vIiItGBkenKOzbt7U5upqjCS/gPA8rTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucqGkn8njPdt7aSJa7KluR8e8WlvhHsBdv8a6yo4WhiRPHPbdqQJH1FO9zCNTgbdCtZMo211Rc3Sz9cGB4pFeJl2NK//gVrgWeBJwKF9tSox7RJFY1j4eWSvomfRZrnLgQfi31Vl2Cz+uLrUtJPHSHJfEqS9k3CR8juGzxLqCFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Z/hmAKph; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Z/hmAKph"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=U7
	aZqJ1wbJepQ0bDUBYydOnKYHPlK3Esn8UiYf3nvmk=; b=Z/hmAKph3r4WIOKPjn
	JXr9G/MrisKKBumUhnGus+RroQm7XCiv3AqCX6el/3oi371chTwvybE07InXxpuu
	t/WpvNa1RjilOpSKrxSdvWRnHhQsGPh3F7NSKfUiZYWzduyLV1b8Cm5SWOsrRXXY
	+G3TzMxHUiEEe7gzJQnHT1MCw=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBHh8m3Y6dqeVk+Ag--.7653S4;
	Mon, 14 Sep 2026 11:02:17 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	quchaosheng000406@163.com
Subject: [PATCH] dt-bindings: net: can: holt,hi3110: Convert to DT schema
Date: Mon, 14 Sep 2026 11:02:14 +0800
Message-ID: <20260914030215.437602-3-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914030215.437602-1-quchaosheng000406@163.com>
References: <20260914030215.437602-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHh8m3Y6dqeVk+Ag--.7653S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF43Cw1rWry5Kr45uF4UJwb_yoWrCryUpa
	y5G3ZxGFs2qF1fXa10g3W8AF9xXan5ZF47GrZ7X348JF98Ka95tFWSkr98Za4UXrs7A3W2
	vF1093W8G3W3AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi4SoJUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4xqLAWqnY7phowAA3l

Convert the Holt HI-311X stand-alone CAN controller binding from
free-form text to DT schema, and reference the common can-controller.yaml
schema.

The old text listed clocks as required, but the driver obtains the clock
with devm_clk_get_optional() and falls back to the "clock-frequency"
property when no clock is provided, so either one of the two must be
present and neither is required on its own. This is expressed with an
anyOf block, and clock-frequency is documented, as it was previously
undocumented.

The maximum supported clock frequency of 40000000 is also documented,
as that is the limit the driver enforces.

unevaluatedProperties is used rather than additionalProperties so that
properties provided by can-controller.yaml, such as termination-gpios,
remain usable.

Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---
 .../bindings/net/can/holt,hi311x.yaml         | 80 +++++++++++++++++++
 .../bindings/net/can/holt_hi311x.txt          | 23 ------
 2 files changed, 80 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/holt,hi311x.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/holt_hi311x.txt

diff --git a/Documentation/devicetree/bindings/net/can/holt,hi311x.yaml b/Documentation/devicetree/bindings/net/can/holt,hi311x.yaml
new file mode 100644
index 000000000..8c433fcac
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/holt,hi311x.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/holt,hi311x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Holt HI-311X stand-alone CAN controller
+
+maintainers:
+  - Marc Kleine-Budde <mkl@pengutronix.de>
+
+description:
+  The Holt HI-3110 is a stand-alone CAN controller with an SPI interface.
+
+allOf:
+  - $ref: can-controller.yaml#
+
+properties:
+  compatible:
+    const: holt,hi3110
+
+  reg:
+    description: SPI chip select.
+    maxItems: 1
+
+  clocks:
+    description:
+      The clock feeding the CAN controller. If this property is not present
+      clock-frequency must be specified instead.
+    maxItems: 1
+
+  clock-frequency:
+    description:
+      Frequency of the clock feeding the CAN controller, in Hz. Used when
+      no clocks property is provided. The maximum supported frequency is
+      40000000.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  interrupts:
+    description: IRQ line for the CAN controller.
+    maxItems: 1
+
+  vdd-supply:
+    description: Regulator that powers the CAN controller.
+
+  xceiver-supply:
+    description: Regulator that powers the CAN transceiver.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+anyOf:
+  - required:
+      - clocks
+  - required:
+      - clock-frequency
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        can@1 {
+            compatible = "holt,hi3110";
+            reg = <1>;
+            clocks = <&clk32m>;
+            interrupt-parent = <&gpio4>;
+            interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
+            vdd-supply = <&reg5v0>;
+            xceiver-supply = <&reg5v0>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/net/can/holt_hi311x.txt b/Documentation/devicetree/bindings/net/can/holt_hi311x.txt
deleted file mode 100644
index 3a9926f99..000000000
--- a/Documentation/devicetree/bindings/net/can/holt_hi311x.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-* Holt HI-311X stand-alone CAN controller device tree bindings
-
-Required properties:
- - compatible: Should be one of the following:
-   - "holt,hi3110" for HI-3110
- - reg: SPI chip select.
- - clocks: The clock feeding the CAN controller.
- - interrupts: Should contain IRQ line for the CAN controller.
-
-Optional properties:
- - vdd-supply: Regulator that powers the CAN controller.
- - xceiver-supply: Regulator that powers the CAN transceiver.
-
-Example:
-	can0: can@1 {
-		compatible = "holt,hi3110";
-		reg = <1>;
-		clocks = <&clk32m>;
-		interrupt-parent = <&gpio4>;
-		interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
-		vdd-supply = <&reg5v0>;
-		xceiver-supply = <&reg5v0>;
-	};
-- 
2.43.0

