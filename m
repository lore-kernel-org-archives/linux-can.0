Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA6D1B6D08;
	Mon, 14 Sep 2026 01:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789349528; cv=none; b=fcyx8LFM4bcOrgUjl5gVzsozif/JzN5/L+yqvv65VZTokE1EmlwtEJAkcZ4geuLzfyQ4qtCGjD8hXAXDGFU1QOOfI2G1/8OpT/GGa3e2mOF1ByPsKC0b5sOLGuun4SQ6bm8q8aGTjAOwwL4HgIx9Db3xbRrxuKHxl6ykJV3TSD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789349528; c=relaxed/simple;
	bh=fF2nuq3kQYsJt2TWbvwHKoCLJCJrAJvPw/QqZaRKGoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sTn8phyka6bcR0QYmLt7Af8Kffl0sHxn1b+yYGCTASAYn91zioUeIw3qanbhdgHuVRqprxXfKBxp/YS8dXOVVKVqMZRj85zKz8L1KyXm3KrDio9LvQWByI71KPhn6W6Pa/SeFSACHkRD8pmpbZM6cejoExTdRxSGKyPQAAXABd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=p8mMgtBH; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="p8mMgtBH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ux
	K2MWPoDVuf9Q62xs0Mp51oj2Iuc6GkP4TJSe+QWaA=; b=p8mMgtBHMjPFaembhJ
	ie2b9wJ8lxYtljq7zIaQxYiP0myipVO8feS6eEpsZ7UkHuGmKOsWru2q+3P1z9rZ
	+7k7fbqfzl9Hg3oMRmGg1aqr9aCw4z49z3EFK5GFEIr9usRIpHlGaVDzHQ8Lm27z
	N0mE9Jqj0dhlWhq97p17A7lzw=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBHsQp8TqdqrTwhAg--.12080S2;
	Mon, 14 Sep 2026 09:31:40 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	quchaosheng000406@163.com
Subject: [PATCH] dt-bindings: net: can: convert ifi_canfd to DT schema
Date: Mon, 14 Sep 2026 09:31:38 +0800
Message-ID: <20260914013138.392969-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHsQp8TqdqrTwhAg--.12080S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF4DJF18uFykCw13uw4UArb_yoW5Jw4rpa
	43CFnrXa1IqF43Gws3K3W8Aw13XFn5ZF15Gr9Fvw18AF98CFy5Kw4aka48Za4jgrZ2yFyx
	XF1Fga15ta18GaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRk9NcUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbDAB43rGqnTn6RJAAA3N

Convert the IFI CAN-FD controller binding from free-form text to DT
schema, and reference the common can-controller.yaml schema.

The driver matches on the "ifi,canfd-1.0" compatible and obtains its
interrupt through platform_get_irq(), so interrupts is required and no
additional properties are used.

Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---
 .../bindings/net/can/ifi,canfd.yaml           | 43 +++++++++++++++++++
 .../devicetree/bindings/net/can/ifi_canfd.txt | 15 -------
 2 files changed, 43 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/ifi,canfd.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/ifi_canfd.txt

diff --git a/Documentation/devicetree/bindings/net/can/ifi,canfd.yaml b/Documentation/devicetree/bindings/net/can/ifi,canfd.yaml
new file mode 100644
index 000000000..72f2b934c
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
+  The IFI CAN-FD controller is a CAN-FD capable controller found on
+  Renesas SoCs.
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

