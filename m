Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C6B5372CC;
	Tue, 22 Sep 2026 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790072621; cv=none; b=NmwwmEeLZ6pGr6eM4aVVRVbvqiWDXsM2YNpd/xKnravzV9hL7WOqYbvoRgRlNT7NvVhS1xb9QdJewhFsMOKqm8EuyXh/G9WhOVvk3TaKqy9SuRLBh53rYZgHu9l1QxdvxL/9FK28wHs3Wrz8wRZiO8wOfHw0dPeeMjFUZt4b31M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790072621; c=relaxed/simple;
	bh=DSpUMDZFL/RsZ0gpO+Ch6V/5TXFqhhArQHQq3AOwwpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m2Vu/q7eDOB6x0eW8fusg6gNEpcAr/OC2RgR/IBjg7SYnGiU/h9Jmp/mcUcSZwAoUKUBfOcPJBCXb5S46yLblJb86afl3FlEr+n+cK30kSz83xLne92ep+ob9NxtFu83PCpPI2P7hfzuD+ePhjzKWECm5RFW0kHJfsDwO9CrxrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CNvKPoJ/; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CNvKPoJ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=lM
	1lEZA8Ffcb1iNg5lVKJ5TmLKedzZNS5PzvoeLExbE=; b=CNvKPoJ/F8jIrEDVkY
	TWnf4aLsBbs9VX7ZoAcqcQ975Y4o+shcp3hXFIolA90EAldUki6pCVEUJR2Ez2Ue
	SOYTCQEPU1VRnbJFQYIUX5UGixLLOgKx3Q2/1fQ0ZdxiQWYUW6bMBGVv41hGlxmh
	mb8l+tEYneA00R/8eQ1WS+N0o=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3X+0LV7Jq8o9oAA--.39710S4;
	Tue, 22 Sep 2026 18:23:10 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quchaosheng000406@163.com,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v8 2/3] dt-bindings: net: can: holt,hi311x: Convert to DT schema
Date: Tue, 22 Sep 2026 18:22:57 +0800
Message-ID: <20260922102258.138753-3-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922102258.138753-1-quchaosheng000406@163.com>
References: <20260922102258.138753-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X+0LV7Jq8o9oAA--.39710S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF4xWw4DGr1fuF43XFW5ZFb_yoWruFy3pa
	y5GFsxWF4vqF1xXa1Iq3W8AF93XaykZF47GrWDXr18Ja4qva15trWSkryYvF17ZFs7AFyI
	9Fy093W8tw15AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR1GQDUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5A4glWqyVw4J4gAA31

Convert the Holt HI-311X binding from free-form text to DT schema.

Reference can-controller.yaml and spi/spi-peripheral-props.yaml. The
HI-3110 sits on an SPI bus, so its node carries the standard SPI
properties, spi-max-frequency among them. With unevaluatedProperties:
false and no reference to spi-peripheral-props.yaml, dtbs_check rejects
those properties:

  can@1 (holt,hi3110): Unevaluated properties are not allowed
    ('spi-max-frequency' was unexpected)

Keep the properties and the example as the original text describes them,
including clocks as a required property.

Assisted-by: LLM
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260922084542.104788-1-quchaosheng000406@163.com?part=2
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---

v8:
 - Put back the $ref to spi/spi-peripheral-props.yaml. v7 dropped it as
   redundant, but the HI-3110 is an SPI peripheral and its node carries
   spi-max-frequency. With unevaluatedProperties: false and no reference,
   dt_binding_check reports:

     can@1 (holt,hi3110): Unevaluated properties are not allowed
       ('spi-max-frequency' was unexpected)

   A node carrying spi-max-frequency fails without the reference and passes
   with it, so the reference is required. Reported by sashiko.

   The schema is identical to the v6 that Rob reviewed, so his Reviewed-by
   is kept.
 .../bindings/net/can/holt,hi311x.yaml         | 67 +++++++++++++++++++
 .../bindings/net/can/holt_hi311x.txt          | 23 -------
 2 files changed, 67 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/holt,hi311x.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/holt_hi311x.txt

diff --git a/Documentation/devicetree/bindings/net/can/holt,hi311x.yaml b/Documentation/devicetree/bindings/net/can/holt,hi311x.yaml
new file mode 100644
index 000000000000..9ec6abb1279a
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

