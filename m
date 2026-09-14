Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C95411FBE;
	Mon, 14 Sep 2026 09:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376704; cv=none; b=lUg20uW+8xbWyWVSON/RxDgl0NZPpY2JEZPB8fuWyJKRBmDJSfpYJmS8Hbx7KLF4hxUiamC2N4vbwuqbqtrZH15/BwY3vLuBsSPtiT+rD1uxya7TO/Nuvxr/Gv0qIRZszWHLrl1k1epZFVdsYZm2Czz/0Nl1okOF59UVxbEYTpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376704; c=relaxed/simple;
	bh=N+Dci2a7Ab5X7+brGWlSyLFeIFzyA3nuBctD8Wtl/3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MJUKqEXmqwFPDSr0nsLa/+LSfgdGBzhKL7Txuk1FXYxWLCaWYYjzxZvEpTfmdQvp9A4tS/FZGhcw0LYEiyyRwdkdQa7uYwCZVgL3S45KbcHCjF3whKyuJVkgMLcyLtkVYIiOQleoC3OArCWsZV1rTxaARmAd7sqDxTMqYj0x5o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fC2lNdTf; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fC2lNdTf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Sn
	zKIwpnbdSTjunN7bp4Seo7tgEM5ocAcd+x3hw2RQc=; b=fC2lNdTfpkrKyDp6/X
	wk2HHRb04IhSALfLsOJeWsbV8eSMbWaU36b9Hwk+Zqo1qK83hl7ybq8dUvmNl8LX
	gq+r/8TtnlOHNBmkoPA0hHe5qgCzlJauOeQMvgsj3FiaTJuUP9aL9TcJ0xjLtpvW
	HCrVRKV0dO8yCnxCEflZxT8RM=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wCHbKSouKdqEj5qAg--.11583S3;
	Mon, 14 Sep 2026 17:04:43 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	quchaosheng000406@163.com
Subject: [PATCH v3 2/2] dt-bindings: net: can: fsl,mpc5xxx-mscan: Convert to DT schema
Date: Mon, 14 Sep 2026 17:04:40 +0800
Message-ID: <20260914090440.552884-2-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHbKSouKdqEj5qAg--.11583S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxKr4UJrWxCry5uFyDWFWruFg_yoWxGFy7pa
	y3Cay7JF9FqF15Z3yvgF48Cw1fJanYyF45Grn7Z34fK3y5CF18tF4SkF9YvFy5Gr97Za9F
	g3W0vr1UJF1q9w7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEK0PhUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5AvcUmqnuKtQygAA3l

Convert the Freescale MPC5xxx MSCAN binding from free-form text to DT
schema.

Describe fsl,mpc5200-mscan and fsl,mpc5121-mscan in separate sections, as
the original text does. fsl,mpc5200-mscan accepts "ip" and "ref" for
fsl,mscan-clock-source, fsl,mpc5121-mscan also accepts "sys". Enforce both
with an if/then block on the compatible string.

Add "fsl,mpc5200b-mscan" as a fallback of "fsl,mpc5200-mscan", as
mpc5200b.dtsi uses it.

Document clocks and clock-names. The MPC5121 driver looks up the "ipg",
"ips", "sys", "ref" and "mclk" clocks by name, and mpc5121.dtsi provides
all five. The original text did not describe them.

Keep the note about MPC5121 Rev. 1.

Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---
v2:
 - Add "fsl,mpc5200b-mscan" as a fallback compatible.

 - Document clocks and clock-names.

v3:
 - Split fsl,mscan-clock-source by compatible string, following the
   separate sections in the original text. "sys" applies to
   fsl,mpc5121-mscan only.

 - Rewrite the commit message in imperative mood.
---
---
 .../bindings/net/can/fsl,mpc5xxx-mscan.yaml   | 114 ++++++++++++++++++
 .../bindings/net/can/mpc5xxx-mscan.txt        |  53 --------
 2 files changed, 114 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/mpc5xxx-mscan.txt

diff --git a/Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml b/Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml
new file mode 100644
index 000000000..277e78ca2
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/fsl,mpc5xxx-mscan.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale MPC5xxx MSCAN controller
+
+maintainers:
+  - Marc Kleine-Budde <mkl@pengutronix.de>
+
+description:
+  The MSCAN controller found on the Freescale MPC5200 and MPC5121 SoCs. The
+  MPC5121 Rev. 1 processor is not supported.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,mpc5200b-mscan
+          - const: fsl,mpc5200-mscan
+      - enum:
+          - fsl,mpc5200-mscan
+          - fsl,mpc5121-mscan
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description:
+      Clocks feeding the controller. On MPC5121 the driver looks up the
+      "ipg", "ips", "sys", "ref" and "mclk" clocks by name.
+    maxItems: 5
+
+  clock-names:
+    items:
+      - const: ipg
+      - const: ips
+      - const: sys
+      - const: ref
+      - const: mclk
+
+  fsl,mscan-clock-source:
+    description:
+      Clock source used for the controller.
+    enum: [ip, ref, sys]
+
+  fsl,mscan-clock-divider:
+    description: Additional clock divider for the reference and system clocks.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - $ref: can-controller.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,mpc5200-mscan
+    then:
+      properties:
+        fsl,mscan-clock-source:
+          description:
+            Clock source used for the controller. "ref" is the default when
+            the property is not present.
+          enum: [ip, ref]
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,mpc5121-mscan
+    then:
+      properties:
+        fsl,mscan-clock-source:
+          description:
+            Clock source used for the controller. When the property is not
+            present, an optimal clock source and frequency based on the
+            system clock is selected. If this is not possible, the reference
+            clock is used.
+          enum: [ip, ref, sys]
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    can@1300 {
+        compatible = "fsl,mpc5121-mscan";
+        reg = <0x1300 0x80>;
+        interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+        interrupt-parent = <&ipic>;
+    };
+
+    can@1380 {
+        compatible = "fsl,mpc5121-mscan";
+        reg = <0x1380 0x80>;
+        interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
+        interrupt-parent = <&ipic>;
+        fsl,mscan-clock-source = "ref";
+        fsl,mscan-clock-divider = <3>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/net/can/mpc5xxx-mscan.txt b/Documentation/devicetree/bindings/net/can/mpc5xxx-mscan.txt
deleted file mode 100644
index 2fa4fcd38..000000000
--- a/Documentation/devicetree/bindings/net/can/mpc5xxx-mscan.txt
+++ /dev/null
@@ -1,53 +0,0 @@
-CAN Device Tree Bindings
-------------------------
-
-(c) 2006-2009 Secret Lab Technologies Ltd
-Grant Likely <grant.likely@secretlab.ca>
-
-fsl,mpc5200-mscan nodes
------------------------
-In addition to the required compatible-, reg- and interrupt-properties, you can
-also specify which clock source shall be used for the controller:
-
-- fsl,mscan-clock-source : a string describing the clock source. Valid values
-			   are:	"ip" for ip bus clock
-				 "ref" for reference clock (XTAL)
-			   "ref" is default in case this property is not
-			   present.
-
-fsl,mpc5121-mscan nodes
------------------------
-In addition to the required compatible-, reg- and interrupt-properties, you can
-also specify which clock source and divider shall be used for the controller:
-
-- fsl,mscan-clock-source : a string describing the clock source. Valid values
-			   are:	"ip" for ip bus clock
-				"ref" for reference clock
-				"sys" for system clock
-			   If this property is not present, an optimal CAN
-			   clock source and frequency based on the system
-			   clock will be selected. If this is not possible,
-			   the reference clock will be used.
-
-- fsl,mscan-clock-divider: for the reference and system clock, an additional
-			   clock divider can be specified. By default, a
-			   value of 1 is used.
-
-Note that the MPC5121 Rev. 1 processor is not supported.
-
-Examples:
-	can@1300 {
-		compatible = "fsl,mpc5121-mscan";
-		interrupts = <12 0x8>;
-		interrupt-parent = <&ipic>;
-		reg = <0x1300 0x80>;
-	};
-
-	can@1380 {
-		compatible = "fsl,mpc5121-mscan";
-		interrupts = <13 0x8>;
-		interrupt-parent = <&ipic>;
-		reg = <0x1380 0x80>;
-		fsl,mscan-clock-source = "ref";
-		fsl,mscan-clock-divider = <3>;
-	};
-- 
2.43.0

