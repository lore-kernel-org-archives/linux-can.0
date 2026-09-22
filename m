Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AA55349C3;
	Tue, 22 Sep 2026 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790072620; cv=none; b=P2qMA8bMfc9aKkma+AE3/WUi9SRreTeE/4WYt0QWw3MZc37Xw1Ohu8JXDntCjyOxz91DxYJxGP2AKHP5AXy1IdACtO38ccMKuc4/ISM5tsctTYfp+TOicXOSJXtb0OlTJB1+q0vzuBuBcykQVmKpex/NUVHBwfwP1KMKBsvYDNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790072620; c=relaxed/simple;
	bh=9Aq0JtnKM8jdBLGGFkl7cw4LZiKU2cotGSwI8jMZE4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NxBZIr4a4zsL4c7x7V6QnmQlEZj6/LrUlz7qVB3ZnK6eVT6Qbf19mT+rtWWLBmXkXtUIjym0kmWcqgRqiIk+QPR3rO8s99hb4Co5Wa/QCquM6ysAEjrzDu8tFPsi7t84CKA684tgxR71ZiVZlSI6Disv5GjhmoXmUKdc4sTCWIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Smo6RjAe; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Smo6RjAe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=uh
	GBAqnxS0vw7wtn2TAoHyukDdba3M9Q796BAU6i29I=; b=Smo6RjAe83+v5Rw5ON
	f1hijL9Hzrj997s81dh4tIkFudjwfjiGuTlAdY7NSfiYli2m4jtpBlT7bZr7bnhe
	SVgZ6h6NbJXMpynge1lRQGWh5PNkuybdMfJ1b8CuiDt4bPiyAKxdMSQJ4BLOVT2A
	Ao433wIvBg31pBMLYddC3fCNc=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3X+0LV7Jq8o9oAA--.39710S3;
	Tue, 22 Sep 2026 18:23:08 +0800 (CST)
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
Subject: [PATCH v8 1/3] dt-bindings: net: can: ifi,canfd-1.0: Convert to DT schema
Date: Tue, 22 Sep 2026 18:22:56 +0800
Message-ID: <20260922102258.138753-2-quchaosheng000406@163.com>
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
X-CM-TRANSID:_____wD3X+0LV7Jq8o9oAA--.39710S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF1kGry3AF13GF4DXF47Jwb_yoW5ArWfpa
	43CFsrXF4IqF43Gws7K3W8A3W3XF95ZF15Gr9rXw10yas09Fy5tw4akr95Za4jqrZ2vFy7
	XF1Yga1Ut3WxXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRe6wAUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4w0glWqyVw01xwAA3r

Convert the IFI CAN-FD controller binding from free-form text to DT
schema.

Reference can-controller.yaml. interrupts is required: the driver obtains
it with platform_get_irq().

The example now uses the GIC and irq header defines instead of raw numbers.
The values are unchanged: GIC_SPI is 0, IRQ_TYPE_NONE is 0 and 1 is
IRQ_TYPE_EDGE_RISING. Rename the example node from canfd to can so that it
matches the $nodename pattern in can-controller.yaml.

Assisted-by: LLM
Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---

v8:
 - No change.
 .../bindings/net/can/ifi,canfd.yaml           | 46 +++++++++++++++++++
 .../devicetree/bindings/net/can/ifi_canfd.txt | 15 ------
 2 files changed, 46 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/ifi,canfd.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/ifi_canfd.txt

diff --git a/Documentation/devicetree/bindings/net/can/ifi,canfd.yaml b/Documentation/devicetree/bindings/net/can/ifi,canfd.yaml
new file mode 100644
index 000000000000..c8c3105c727b
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
index 20ea5c70ab82..000000000000
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

