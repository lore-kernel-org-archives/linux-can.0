Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7A641228D;
	Mon, 14 Sep 2026 09:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376704; cv=none; b=dLVX1dE7fBlmV+QmeBuf0dzpMcWtIvsoEbIBIWcGeZlwSGBkY9XK4GpvmBtrYnwOLRbQu6M2+YjS7k6tuP+aRMC0DVhHCGfuoNQurtNtZcHpkFa+vKlwzDl0YyXTnNtUqEsXHLIK3R5Nt3n/3s6tj0gcknYPwCMO3/Sc7EOxlg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376704; c=relaxed/simple;
	bh=Zr/8OqGsdsrAm8rCGTFEmcO4cY+TczR0JRRsCaUyDAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J5q6VfuWIcR+jbZzovffXqoYf1yn6zLL09NAi9IKgWZCItiEN9WUbGjSgKreXXI5FSytGWgsSnreyd1Scp2gXrqK9s1Fp5bBxxQNxGpj+WX4n37KgZ0lA6Z543kWTTjJWWget+SVVGHxzjE/3BeYL3bNyKxSM7/jetCVDxADaNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LxAqcFcf; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LxAqcFcf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Tl
	itE88Ob6X3OeNfULWrbY+pHKDDycaISdQbXArgAdA=; b=LxAqcFcftPxDB2iX/X
	XHRiuvgYfGen8wFbBvv8O0ee4Et+SaZLtqf+LU6vScFjmgBnvrwUMZpq/Ylw+2js
	ss8j0Yw3qKWQTn8S86VcAGMlEgnEyhvTXoajekm8ty6SiUyFoWGUGZvCXAeAqWEO
	4JViUBe774MYujL9wk9UDJ5Qw=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wCHbKSouKdqEj5qAg--.11583S2;
	Mon, 14 Sep 2026 17:04:42 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	quchaosheng000406@163.com
Subject: [PATCH v3 1/2] dt-bindings: net: can: holt,hi311x: Convert to DT schema
Date: Mon, 14 Sep 2026 17:04:39 +0800
Message-ID: <20260914090440.552884-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHbKSouKdqEj5qAg--.11583S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFWDtr18WFy3KF4UGw17KFg_yoWrJF1xpa
	y5GFnxWFs2qF1xXa10g3W8AF9xXa1kZF47GrWDX348tFyDKan5tFWakry5Za4UWrs7Za42
	vF1093W8G3W3AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR9F4tUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5ArcUmqnuKpQswAA3c

Convert the Holt HI-311X binding from free-form text to DT schema.

Keep the example and the properties as the original text describes them,
including clocks as a required property.

Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---
v2:
 - Keep clocks required and drop the clock-frequency property. The
   original text lists clocks as required, and clock-frequency is an
   ACPI-only property of the driver, not part of the DT binding.

 - Drop the variant-specific handling that v2 introduced. It documented
   properties the binding never had.

v3:
 - Rewrite the commit message in imperative mood.
---
---
 .../bindings/net/can/holt,hi311x.yaml         | 67 +++++++++++++++++++
 .../bindings/net/can/holt_hi311x.txt          | 23 -------
 2 files changed, 67 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/holt,hi311x.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/holt_hi311x.txt

diff --git a/Documentation/devicetree/bindings/net/can/holt,hi311x.yaml b/Documentation/devicetree/bindings/net/can/holt,hi311x.yaml
new file mode 100644
index 000000000..9ec6abb12
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/holt,hi311x.yaml
@@ -0,0 +1,67 @@
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
+    description: The clock feeding the CAN controller.
+    maxItems: 1
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
+  - clocks
+  - interrupts
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

