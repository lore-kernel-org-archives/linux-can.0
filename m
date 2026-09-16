Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9252D3B7B97;
	Wed, 16 Sep 2026 01:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789523919; cv=none; b=mcukg0wh2SvOzDNX/cokslfTWYpQEcIt+CGj4X1WQfzHZ8Jo+sRHqI4P/gcYFDj2wKXyoCKrq+slyBXKah8Isqgxq5PgRU2wzQx3/HN218pF5DaBK1WqIID6Nx50ShImBssuuZgm/3gzxByirmoCVm9NgwAFbd8CWA5OG80+N7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789523919; c=relaxed/simple;
	bh=oAktVWkl3C64rc2aAt9oeG5ra0vrjY4WEcSKnK2mw+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCB+qAikGhjWUCsB2Y7P+FOMDWXl7dYuTnbFJnEJSfZW+WE/U+LxDsZLRn3kcBhpsc+w2MQ0ekc++Zf7gtcGRpPoLw4ziimfiHYkJWVghBj1qDzJheqvBharMfflzZOX3rIZphwbBc85TWRAkfh5PNxsFnKiyFRgVvX/JyUM8ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Bv0BjlZm; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Bv0BjlZm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=yi
	YrWil6U+lxJR7lF4lwxEJnEr/XrYf5aIxUP8cHKic=; b=Bv0BjlZm1UxhHopyl3
	zYkyHzzmfZyBEpebbqRets4d1kYnRV32FsH6LfEllIRs+1JzC4bDoYVgNjR/1jLr
	h7SaORLEy6RFluWyupmzpPDmmRwB72hjMr219woRZlKo8Ow8Drw+sTM2JbBxB0FO
	C19m+bvzbv8+Yqb9fqsYafGvY=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3n6Wu96lq9rLFAw--.11235S2;
	Wed, 16 Sep 2026 09:58:07 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	quchaosheng000406@163.com
Subject: [PATCH v6] dt-bindings: net: can: ifi,canfd-1.0: Convert to DT schema
Date: Wed, 16 Sep 2026 09:58:05 +0800
Message-ID: <20260916015805.112354-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914030116.437424-1-quchaosheng000406@163.com>
References: <20260914030116.437424-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n6Wu96lq9rLFAw--.11235S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF4DJrWDKF1kGr1rXw1UZFb_yoWrXFW7pF
	W3CrnrJrs2qF43Gw4xK3W0kw13ZFn5AF15GrnrZw18Aa90gFy5tw4akas5ZFyYgrZavFy7
	XF1Fga15J3W7uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRkpnkUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC-w8uo2qp96-TVgAA3j

Convert the IFI CAN-FD controller binding from free-form text to DT
schema, and reference the common can-controller.yaml schema.

The driver matches on the "ifi,canfd-1.0" compatible and obtains its
interrupt through platform_get_irq(), so interrupts is required.

The example uses the GIC and irq header defines instead of the raw
numbers from the original text, which keeps the values unchanged
(GIC_SPI is 0, IRQ_TYPE_NONE is 0 and 1 is IRQ_TYPE_EDGE_RISING). The
node name is changed from "canfd" to "can" so that it matches the
$nodename pattern required by can-controller.yaml.

Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---
v2:
 - Correct the description: this is a soft IP block typically synthesised
   into an FPGA or CPLD, not a controller found on Renesas SoCs.
   Wording now follows the driver's Kconfig entry.

v3:
 - Use unevaluatedProperties: false instead of additionalProperties: false.
   As can-controller.yaml is referenced through allOf, additionalProperties
   would have rejected properties defined by that common schema, such as
   termination-gpios and termination-ohms.

v4:
 - Use defines instead of raw numbers in the example, and rename the
   example node from canfd to can. No functional change.

v5:
 - Re-send the patch on its own. The v4 posting accidentally included
   unrelated changes to the xilinx-xadc binding and did not remove
   ifi_canfd.txt. Only the intended change is present now.

v6:
 - No content change. Fix the patch format: the changelog was placed in the
   commit message instead of after the '---' separator, which confused
   Patchwork. Move it back where it belongs.
 .../bindings/net/can/ifi,canfd.yaml           | 46 +++++++++++++++++++
 .../devicetree/bindings/net/can/ifi_canfd.txt | 15 ------
 2 files changed, 46 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/ifi,canfd.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/ifi_canfd.txt

diff --git a/Documentation/devicetree/bindings/net/can/ifi,canfd.yaml b/Documentation/devicetree/bindings/net/can/ifi,canfd.yaml
new file mode 100644
index 000000000..c8c3105c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/ifi,canfd.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/ifi,canfd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IFI CAN-FD Controller
+
+maintainers:
+  - Marc Kleine-Budde <mkl@pengutronix.de>
+
+description:
+  The I/F/I CAN-FD soft IP block connected to the platform bus. It is most
+  often synthesised into an FPGA or CPLD.
+
+allOf:
+  - $ref: can-controller.yaml#
+
+properties:
+  compatible:
+    const: ifi,canfd-1.0
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    can@ff220000 {
+        compatible = "ifi,canfd-1.0";
+        reg = <0xff220000 0x1000>;
+        interrupts = <GIC_SPI 43 IRQ_TYPE_NONE>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/net/can/ifi_canfd.txt b/Documentation/devicetree/bindings/net/can/ifi_canfd.txt
deleted file mode 100644
index 20ea5c70a..000000000
--- a/Documentation/devicetree/bindings/net/can/ifi_canfd.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-IFI CANFD controller
---------------------
-
-Required properties:
-  - compatible: Should be "ifi,canfd-1.0"
-  - reg: Should contain CAN controller registers location and length
-  - interrupts: Should contain IRQ line for the CAN controller
-
-Example:
-
-	canfd0: canfd@ff220000 {
-		compatible = "ifi,canfd-1.0";
-		reg = <0xff220000 0x00001000>;
-		interrupts = <0 43 0>;
-	};
-- 
2.43.0

