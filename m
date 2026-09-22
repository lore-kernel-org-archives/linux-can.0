Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E198D52940E;
	Tue, 22 Sep 2026 08:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066777; cv=none; b=W1ku+fDABsgMEzGZ0VDl/tI2pt2IIuLp3Tsl4g2rfNtefyicsjnt7gBcixSZAr0QR2nQ/UtfRxX09/Scc6zBw8A63sLq9IYKzIpza7Ye282uR2DRz6XXw0CdpbVxIUStVFTBcL82zxgLymoPjUL7smH6iBiHA+WO6w1uOSMqVSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066777; c=relaxed/simple;
	bh=OhNrXd95q2AFjkshRT6MKjGAtmK7ODVQCcP6uTvI8uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHbIDrykTZdieSuIXUUCEc6Uxte/SqRnMz1ruh3Sbe+0tZYKXClsPoqp39P04CxV1lO79RzyUqjXXAVA0o2raztvZAxrAQvTgPCMfO6P4Lz25XsxEtzhQB5GF7gW4WNvsOgBXjj5bm9LD6oUV+2ohvV9H/2zHYs/rd+7KXPT3FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CKmiJu9t; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CKmiJu9t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Qt
	jIcsjxKqFLUwSQXtQubvciZlrWiqtVRuCDQVYP0R8=; b=CKmiJu9t8zDpSCoNiU
	XIL63teNrcrW6bvpWxianLK7fRlU5IEY6VYZ+NJOWyS0lAwals3vlzt3hzI/2WGF
	9kdCUK/ophW1WfrRXKaOzuBAld/hlHtadwT3gbXPifM9BGd22Fsj4JNea5P8wZ4+
	D42ZG3FiLR5PDnxiXlVvsKuL0=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD330E_QLJqT4dWAA--.33181S3;
	Tue, 22 Sep 2026 16:45:53 +0800 (CST)
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
Subject: [PATCH v7 1/3] dt-bindings: net: can: ifi,canfd-1.0: Convert to DT schema
Date: Tue, 22 Sep 2026 16:45:40 +0800
Message-ID: <20260922084542.104788-2-quchaosheng000406@163.com>
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
X-CM-TRANSID:_____wD330E_QLJqT4dWAA--.33181S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF1kGrWruFyrGr43Zw17trb_yoW5Aw48pa
	y3CFsrXF4IqF43C397K3W8C3W3XFs5AF15Gr9rXw10yas09Fy5tw4akr95Za4jqrZ2vFWx
	XFn0ga1Ut3WxXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR1GQDUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4wJn3GqyQEJADQAA3N

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

v7:
 - Add Assisted-by and the Reviewed-by tag received on v6. No content change.

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

