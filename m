Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA901E7C02;
	Mon, 14 Sep 2026 01:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789349823; cv=none; b=PyfRU0Ksxhk9ddImvr9hBbv22dU95jwLug67brxHW39qBL3NWkMqxOXMrEeLFdq6sl9kh8qJCxJdlHG/5juWEjWiODzYINtY/TkvlJX73DEeLR4jyB6dtVwEc8yDIpXcHLJ8/CFd1ZAYtrX88Q5+rqusQJwXRqa4F3dCv1cjJXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789349823; c=relaxed/simple;
	bh=vePd4yZt8iuLmxcyu7sjbR5z7DgGXrZ/AxilR0qgHqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lIrJyO1ka4fknHjey9ngEoFIk93nElZqCtYt0ItlWvsNNIOfEMRhTDgzVhiwy+t5LYt3Nq0ORxDliS958h5iObQTqFn7xAdxTBBkshud4W5ipvJ6jIQvg6SiN7I0GnAVp2MAymS2aebGujvy0vxbEAvlJ57FtKq8Nqje+jaVnIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Z1YgMrI7; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Z1YgMrI7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Rq
	G9RdNKN3Nr6uK8PDLsfF1CErLrBq2F6byxqpeNQTg=; b=Z1YgMrI7BRaLOoTIIo
	7jDk4GfRzpFhZbjWP8Wqh/ncLC2LFPlPcWzsL2XcSSJtWHKVqZwuCaVNtV1ZOCeq
	pjo6RgT6XAFrb/de77flXhnIg3SP9TG6j9oa0g9QLMyJwCNTaP1nmkGRnTU6I2Gl
	APMXf6RSe7bBWFLyOg1ZYuWOE=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgCHUY2lT6dqE08mPA--.32112S2;
	Mon, 14 Sep 2026 09:36:38 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	quchaosheng000406@163.com
Subject: [PATCH v2] dt-bindings: net: can: convert ifi_canfd to DT schema
Date: Mon, 14 Sep 2026 09:36:35 +0800
Message-ID: <20260914013636.394263-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgCHUY2lT6dqE08mPA--.32112S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF4DJF18uw4ruF1UWrWkXrb_yoW5XFW3pa
	43CrnrXF4IqF43GwsxK3W8Aw13Zr95ZF15Kr9rZw18AF90kFy5Kw4ak34rZa4jgrZ2yFWx
	XF1Fga15ta1xuaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRLXo8UUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4waB9mqnT6ZpYgAA39

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

