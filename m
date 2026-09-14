Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F973242D88;
	Mon, 14 Sep 2026 01:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789349885; cv=none; b=TO9LnidTd71NmD63AOr1RX+FuwUivn6JlWbs/9y1x0GnOMRMdvriI9UsIuTYzPL1Ew7n8SCLU5QlWgUg3IdHNvlor0WkctrNPxvXDkKZIndV+lyAF5SblrxqQnYVKuUlup8t5630cYSm/OyBB0G4n5jq45QW5YNGF4ThLDzHjcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789349885; c=relaxed/simple;
	bh=vePd4yZt8iuLmxcyu7sjbR5z7DgGXrZ/AxilR0qgHqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MqKbZ+HT32n4VSkrGi31/StmUeIyabFMwOeWuRDKAjyR87n371KWPHpSr3ub19h+KH0lRQbDmsnQSKAFZL/1KXRPgTKh3D15lIrIV9VD3QzlVE2aF4Mf3Iyi5P34CYpuWZ5O9RG3vR88yKXB5Ov5CX+CA2YpJrmYlwCPwhUB0zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HeM/fc3U; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HeM/fc3U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Rq
	G9RdNKN3Nr6uK8PDLsfF1CErLrBq2F6byxqpeNQTg=; b=HeM/fc3UID3pZdZzyl
	bqKjTFllJEHH5yNg8vjH6hRoioYe6u/nsS5YkPAl5B01UQWtIdrobZSP1R5RjcRQ
	1DTxhitJJMIgeJ8KDLpWUQi7NwUj7yCofD1UTv3TXZj0lXx7tOsT/xKfi0HI13iB
	xw7iDwlbW79ohkmNuwYAjnaaQ=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCHNmXpT6dqXr9QAg--.20080S2;
	Mon, 14 Sep 2026 09:37:46 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	quchaosheng000406@163.com
Subject: [PATCH v2] dt-bindings: net: can: convert ifi_canfd to DT schema
Date: Mon, 14 Sep 2026 09:37:45 +0800
Message-ID: <20260914013745.394514-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHNmXpT6dqXr9QAg--.20080S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF4DJF18uw4ruF1UWrWkXrb_yoW5XFW3pa
	43CrnrXF4IqF43GwsxK3W8Aw13Zr95ZF15Kr9rZw18AF90kFy5Kw4ak34rZa4jgrZ2yFWx
	XF1Fga15ta1xuaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRpT5kUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5AqSCGqnT+op2gAA3v

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

Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---
 .../bindings/net/can/ifi,canfd.yaml           | 43 +++++++++++++++++++
 .../devicetree/bindings/net/can/ifi_canfd.txt | 15 -------
 2 files changed, 43 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/ifi,canfd.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/ifi_canfd.txt

diff --git a/Documentation/devicetree/bindings/net/can/ifi,canfd.yaml b/Documentation/devicetree/bindings/net/can/ifi,canfd.yaml
new file mode 100644
index 000000000..63ddc879c
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
+additionalProperties: false
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

