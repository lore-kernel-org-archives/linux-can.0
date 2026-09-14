Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE27337A827;
	Mon, 14 Sep 2026 05:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789365406; cv=none; b=dsBIrlPmUxa273DL2tpqmj6X/nr7bRPsabg0OnsTzzzkNeGvYTiNLbGnQ0qqHuNim6gviskqx2J7oaBhwvQJQ3mytCB9iX1sk1sCb4PL7zMis+nXXOXH54GHeyUV1OTQFtxPpDvZnSevxa070gNqeC0nubeF4sXbFquEJSpGM9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789365406; c=relaxed/simple;
	bh=4FOoy3+cYMFuDvcWN2DGWZbWRci1m+r32zFK1U35ayw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AF5ZGK/CLz+zVxdx8cqkZdqw2NRGGKkHAROtSCZ9TDnHgTZ+yu+RxPWsT/zXpOKd9R+NDcBIn6AFUAV+I46gvjGq6HaYuUdkiCpBfQ9MJ8XfwNHAX/tOVz5SbIx1bipGVlcdY9G3q4boNs0YH4hrpKg8u1AQJdXjnuVp6CDNVDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Hmpb9lcC; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Hmpb9lcC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=du
	J6rhWFHCaYM7Kl2I6mmSt92M2WX49yA3HWZnei47c=; b=Hmpb9lcCm5iq0zlaXT
	aLFRTCdQXZgWB/PUenABO2HBEBSHXmIELXzuK8qXMvOLEUM8bUtmKwi4pgMzixiS
	wIDGsXGkakATWuhzhfO1Sf9sfnGquW1IHUfD0ZLW00UPy47NdbE7tr/vAbInpanU
	SDh1jxbUj/PffPU47GbUkGu7Y=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wBXg9l4jKdqXB8tAg--.2092S2;
	Mon, 14 Sep 2026 13:56:09 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	quchaosheng000406@163.com
Subject: [PATCH v2] dt-bindings: net: can: holt,hi3110: Convert to DT schema
Date: Mon, 14 Sep 2026 13:56:07 +0800
Message-ID: <20260914055608.495084-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXg9l4jKdqXB8tAg--.2092S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF43WF1ktr15uw4UJFy7ZFb_yoWrKrWfpa
	y5KanrGF4vqF1fXa10q3W8CF9xXan5ZF47GrZ7X348J3WYga1rtFWSkry5ZFy7Xrs7AasF
	9F1093W8K3W3AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR9F4tUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4xrFO2qnjHqragAA39

Convert the Holt HI-311X stand-alone CAN controller binding from
free-form text to DT schema, and reference the common can-controller.yaml
schema.

The controller is connected over SPI, so reference
spi-peripheral-props.yaml as well, otherwise the standard SPI properties
such as spi-max-frequency would be rejected by unevaluatedProperties.

The old text listed clocks as required, but the driver obtains the clock
with devm_clk_get_optional() and falls back to the "clock-frequency"
property when no clock is provided, so either one of the two must be
present and neither is required on its own. This is expressed with an
anyOf block, and clock-frequency is documented, as it was previously
undocumented. The maximum supported clock frequency of 40000000 is
enforced, as that is the limit the driver applies.

unevaluatedProperties is used rather than additionalProperties so that
properties provided by can-controller.yaml remain usable.

Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---
v2:
 - Reference spi-peripheral-props.yaml. Without it, unevaluatedProperties
   rejected the standard SPI properties, spi-max-frequency among them.
   Reported by Sashiko.

 - Add a maximum of 40000000 to clock-frequency. The description stated
   the limit but did not enforce it. Reported by Sashiko.
---
 .../bindings/net/can/holt,hi311x.yaml         | 81 +++++++++++++++++++
 .../bindings/net/can/holt_hi311x.txt          | 23 ------
 2 files changed, 81 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/holt,hi311x.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/holt_hi311x.txt

diff --git a/Documentation/devicetree/bindings/net/can/holt,hi311x.yaml b/Documentation/devicetree/bindings/net/can/holt,hi311x.yaml
new file mode 100644
index 000000000..36497b114
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/holt,hi311x.yaml
@@ -0,0 +1,81 @@
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
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
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
+      no clocks property is provided.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 40000000
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

