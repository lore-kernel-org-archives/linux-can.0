Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB9E3BB114;
	Wed, 16 Sep 2026 01:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789523921; cv=none; b=O1XOyo7F1fT7K5sGFcopipSC7GxgmrcrSFJtvzGKBdkcv3SUg4i7unzyAKFfzC/H19NwyxhJy9pFbx9sRQTVwZ1Z26JyL7CiFIJLmvggotDkJgmmIXi8EyBwE9I1hOpf+YYt5C4khiiE/0E2PAN8ZJAXwQk3iuzT+TQLHTk9yYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789523921; c=relaxed/simple;
	bh=qaxQ6K7qZUcqpgRhhqCHfA8/DEmys9RLC76CM/P78+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOtOZVQrZDJLMKiC0rTOulxfvmY8MENfKNkXdPFe6W1XdCjtrKwl7FuAv+rxBUIvbBaEwSITbWO5ELkV9ovsrVy9dg6sWnRlQPdl6DmJq75CkmbRoDfnzbhMAUfTJ9RwPslWBVWVkfQ+QWwDxxuFystNS9EB7BZRBQ2cKWRBevg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jz9Jmg+7; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jz9Jmg+7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=r7
	QfF7mzXWVIMrCCt8nqeHgKAxerxj00J31+qpnnGhs=; b=jz9Jmg+78JjgLwUAb/
	eQABhqPvYatUE7N0wksICFHs9yan47Mx8pGcnAmkKSJefRZxMWUuR60JqRv0l1sf
	sODAbLEGP/E31gXNJWHjk4vdGotTSG6Rir4eDOJDgCaWBOMwZUWCw/zMMS7lp/iu
	Rj2xJHHi6S831V/eA/BdkgfIQ=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3_8aq96lqVUH2Aw--.8788S2;
	Wed, 16 Sep 2026 09:58:03 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	quchaosheng000406@163.com
Subject: [PATCH v6] dt-bindings: net: can: holt,hi311x: Convert to DT schema
Date: Wed, 16 Sep 2026 09:58:01 +0800
Message-ID: <20260916015801.112299-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914090440.552884-1-quchaosheng000406@163.com>
References: <20260914090440.552884-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_8aq96lqVUH2Aw--.8788S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFW5XFWfWr4DZrW5GF43GFg_yoWrAw4xpa
	y5GFnxXrs2qF1xWw40g3W8AF93Xan5ZF4UGrWDWw18ta45Ka95tFWSkry5Za4UWrs7Aa42
	vF1F93W8G3W3AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRDl1gUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4wwuo2qp96w39QAA34

Convert the Holt HI-311X binding from free-form text to DT schema.

Keep the example and the properties as the original text describes them,
including clocks as a required property.

Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---
v2:
 - Keep clocks required and drop the clock-frequency property.
 - Drop the variant-specific handling that v2 introduced. It documented
   properties the binding never had.

v3:
 - Rewrite the commit message in imperative mood.

v6:
 - No content change. Fix the patch format: the changelog was placed in the
   commit message instead of after the '---' separator, which confused
   Patchwork. Move it back where it belongs.

 - Drop an incorrect statement from the v2 changelog: clock-frequency was
   described there as an ACPI-only property of the driver. That is wrong,
   the driver has no ACPI support at all (no acpi_device_id, no ACPI
   headers); device_property_read_u32() reads it from device tree too.
   The property is simply not part of this DT binding, which is why it is
   not documented. Keeping clocks required matches the sibling
   microchip,mcp2510.yaml, whose driver also uses devm_clk_get_optional().
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

