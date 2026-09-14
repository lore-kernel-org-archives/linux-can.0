Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1832E888C;
	Mon, 14 Sep 2026 03:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789354900; cv=none; b=dgj9hGLO6xvYFeVdLu8pzrCKK3PfSWsUufC8EGYKsWiafeH5YO8C8mpuW8Itm8d3O4alK8TqQwBAiWFLV2j4E4VJdAqCSgz5nIeyd00474AvrpRqrSPzLwUwvhAEczAbUb9wskV62EiFA9PCI2NXbZRKrlnFD5pDAXIqUg+O7Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789354900; c=relaxed/simple;
	bh=HVA3NWrT/wQga/eiKqTcToZeQeq0wzt46cH0Rpm5AhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ark54FPTKu2PojYUlIKNjvJpfA6qGrak0H+RnQz+7jczArUgeB8sYfy5z09VxvwdE8+Tv6/XM/RVGuILWKhd3KLLXJkfRXDNRbRMzt4BZnhvh/3ABTCPJSoBQt3p9Fe+5nnTeBEgdP3S+MSI/LhQ4yBJw8znFjQloUcgfEZo2Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=R4vWLwDA; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="R4vWLwDA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=1v
	5b+fRL9NAYhSdoLEcKC3YciDkKADtaABnc4lssut4=; b=R4vWLwDAeCUlc1oG99
	6hOB/8ePLSDiDYE0jRNi2E0F0gQ+76N50DFkH2PKjXtJisdMcyiWD9qOI7L5nj85
	yMOGWRcFz8Jvn6vGgydMXao+ncygxhZSyh5Hp9sceG7KnsfSqqZKVDltGL22e4zJ
	u3u3vel/8WtaTpcdnZ6QHb7xI=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAHyGd8Y6dqsoVfAg--.21450S2;
	Mon, 14 Sep 2026 11:01:18 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	quchaosheng000406@163.com
Subject: [PATCH v5] dt-bindings: net: can: ifi,canfd-1.0: Convert to DT schema
Date: Mon, 14 Sep 2026 11:01:16 +0800
Message-ID: <20260914030116.437424-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHyGd8Y6dqsoVfAg--.21450S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF4DJrWDKF1kGr1rXw1UZFb_yoWrGryUpF
	W3CrnrJFs2qF43Gws7K3W8Cw13ZFs5AF15Gr9rZw18Aas0gFy5tw4akas5ZFyYgrZ2vFyx
	XF4Fga15J3W7uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR9Z2xUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5B588WqnY34SpgAA3T

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
---
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

