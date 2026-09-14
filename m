Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49212E8DEF;
	Mon, 14 Sep 2026 01:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789350806; cv=none; b=M8MkAfLOUe96AGEqqIS8A4ue+TO9bgogNbdJMK9Gv0T9ISsoyhMSVQQuDWT9VU1WUu570DfGNb1kGXERKedB2oxSe/ABikgu+rahBOf9m1Pu3kUxY86QzSytUHexlGpjoq99MFd0zJMmwNHwQHmH6PZ8utABb5H4koXhtMQGO6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789350806; c=relaxed/simple;
	bh=EBeGJGXl8GaOdXGP19IVJWEP8rnqLWf6pyF85nZ+1F0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gYKQ3lO3Ko7Y4znTylK95mVuQxCJIpcrXupljgddSOyrXXMEyToco0AePELuDiO2sp+AfoB2f/HuxM9WRAhfGtzJsC3J7MHWQ0QwXSXd9IIk/gLM6NjZvwpu/mjLyg2lziPkzuTsqXoVpzo0OEBWM4+zAvIpF7RDVYEcctu9/Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gx4uzy8E; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gx4uzy8E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=oF
	EIdjSPLXUuNVed//u8f1SJBKFqhGedlC0P5/kdIa8=; b=gx4uzy8Euyo+ijAGtd
	ohLvgX/npY7df7flqdbKKOort1Q0ONtOgQHkXM5q+H0qZeizITOmziXKD8H4syv4
	dRcyHSLLvxsQbDDYKi9wsisgxreu/doJW5+iGSBOMEIWQUdvXHghfFoB4y18lsEJ
	CcJVboN86iGYDPM5c/3JdRjPo=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDnBzF3U6dqAf4+Rg--.57202S2;
	Mon, 14 Sep 2026 09:52:56 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	quchaosheng000406@163.com
Subject: [PATCH v3] dt-bindings: net: can: convert ifi_canfd to DT schema
Date: Mon, 14 Sep 2026 09:52:55 +0800
Message-ID: <20260914015255.398056-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDnBzF3U6dqAf4+Rg--.57202S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF4DJF18uw4rtrWrWF17Jrb_yoW5Cr1kpa
	43CrnrXF4IqF43Gw43K3W8Aw13Zr95ZF15Kr9rZw18AFZ0kFy5Kw4aka4rZa4YgrZayFWx
	XF1Fga15J3WUCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRloGkUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbDABl37GqnU3kJTQAA3h

Convert the IFI CAN-FD controller binding from free-form text to DT
schema, and reference the common can-controller.yaml schema.

The driver matches on the "ifi,canfd-1.0" compatible and obtains its
interrupt through platform_get_irq(), so interrupts is required and no
additional properties are used.

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

Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---
 .../bindings/net/can/ifi,canfd.yaml           | 43 +++++++++++++++++++
 .../devicetree/bindings/net/can/ifi_canfd.txt | 15 -------
 2 files changed, 43 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/ifi,canfd.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/ifi_canfd.txt

diff --git a/Documentation/devicetree/bindings/net/can/ifi,canfd.yaml b/Documentation/devicetree/bindings/net/can/ifi,canfd.yaml
new file mode 100644
index 000000000..eeb5f403c
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/ifi,canfd.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/ifi,canfd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IFI CAN-FD Controller
+
+maintainers:
+  - Quchaosheng <quchaosheng000406@163.com>
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
+    canfd0: can@ff220000 {
+        compatible = "ifi,canfd-1.0";
+        reg = <0xff220000 0x1000>;
+        interrupts = <0 43 0>;
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

