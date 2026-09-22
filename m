Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C6B437130;
	Tue, 22 Sep 2026 08:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066772; cv=none; b=WNojFn0lTQ4NxDRdjvVEC9TOXkfv6LZCcv7DHAzJlbUMecjJeGC54jOtWE9D740l1HUtqLSDBVnaNW7AtI+7HvD4v0sofrxugEi3ISbnzAor/S88xgjIGyhzNCEwSbZz/SLCO2MbM4okdB2x7HlRARiTBiUk2BaHiBtAoa/ab5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066772; c=relaxed/simple;
	bh=iaLVxDAG5+nB5ptO+TpM0Qf9GhIRqpRVHMLuK4hPsv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSowBIEY7Dx140HsZAe/vj6T4VYXizXKRqLs8scye4jGHTz+cj7c/TDXy7OcCC08uDNq01zFw7d/9f7+Pa+Bpm5T3QErGg/AGVY+Vn6SW5GrT4YQCQuSED0lJxlMJK2Ra7c1f59ROEpdHihx3GLEjV500A5oSsjvTTOuOt39FWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AGlQu6rq; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AGlQu6rq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Hx
	FEgAzEvnh+dUnQWPWaBxX8yBJft8ckZpazV4YOYqE=; b=AGlQu6rq4c223FL3qB
	HgG6A/r6K8c/6czFvcEPGjEOca7RVm1HozFHEqfwgMctdc6I9VJTZKglILFFrlvW
	4UFN8jmCXPXfo0s2wSJwQRiX3/ZYugzX0PtRjrGe6tyyuGDRSVGkSqY0N57xzUls
	JcwY2faOzTV6ie2dVka3vdy1k=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD330E_QLJqT4dWAA--.33181S4;
	Tue, 22 Sep 2026 16:45:55 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quchaosheng000406@163.com
Subject: [PATCH v7 2/3] dt-bindings: net: can: holt,hi311x: Convert to DT schema
Date: Tue, 22 Sep 2026 16:45:41 +0800
Message-ID: <20260922084542.104788-3-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922084542.104788-1-quchaosheng000406@163.com>
References: <20260922084542.104788-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD330E_QLJqT4dWAA--.33181S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFyDuryrtr1UCF4UtFW8JFb_yoWrJFW8pa
	y5G3Z3WFs2qF1xXw40g3W8AF93Xan5ZF47GrZrXw18tF909an5tFWSkr90va4UXrs7ZFy2
	vF1093W8J3W5AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRU5rxUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5ANn3GqyQEMUdgAA3l

Convert the Holt HI-311X binding from free-form text to DT schema.

Reference can-controller.yaml. Keep the properties and the example as the
original text describes them, including clocks as a required property.

Assisted-by: LLM
Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---

v7:
 - Add Assisted-by and the Reviewed-by tag received on v6.

 - Drop the $ref to spi/spi-peripheral-props.yaml. The example does not use
   SPI properties, so the reference is redundant (Krzysztof Kozlowski).
   Rob's Reviewed-by is kept: this is the only change against the v6 he
   reviewed, and it is the removal Krzysztof had asked for.

 .../bindings/net/can/holt,hi311x.yaml         | 66 +++++++++++++++++++
 .../bindings/net/can/holt_hi311x.txt          | 23 -------
 2 files changed, 66 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/holt,hi311x.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/holt_hi311x.txt

diff --git a/Documentation/devicetree/bindings/net/can/holt,hi311x.yaml b/Documentation/devicetree/bindings/net/can/holt,hi311x.yaml
new file mode 100644
index 000000000000..d9e3584590c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/holt,hi311x.yaml
@@ -0,0 +1,66 @@
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
index 3a9926f99937..000000000000
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

