Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BF035677C;
	Tue, 22 Sep 2026 08:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066772; cv=none; b=TjPOI5MzgUdeV4qH0qKkYSiaP0Mz95Z9sbA1T04g/MMSpsBNb0V27RJn+5BZAUXXhRjIWsqWgWAObqPlL6bpz3aALmFJdykPAVaYrLIY4brAUx7IErpNX4z5TstjWAPS39se3RTbM1T5h01jm6zQCF/yuAhrnDiqC8lqtcLRziU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066772; c=relaxed/simple;
	bh=4UGzpWko3rlOk/RChAypjOhx5GnjXmB4/FiKsjfGvEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMh6mV9VGF+zRPM59sspDTKeRYHWYYSvpcbSV2pbG11/SzaNvEwbPFPnuboC+B4XQ4molk2Wpih3/wREPNeJlKVVHtyD5u++zEZKIEg3qDcjgJFjibupsTZwwWFUpncFjKHb+tiO2y1cAroL5esSpoIMn0ipjjyQnWwEqQ+IG5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WVqQJ+7h; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WVqQJ+7h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=bb
	XVKLsX91HaTT7y2+Ipa4w7rfsERAqEPBm8yq9WYb0=; b=WVqQJ+7hzxRlsy5UWx
	YoJQNtDkrGXMirtpMpQTp1mIZMGYNCgCYvz8HtYNtQKBQ3Ar4Hn9Cjc8AKUNyuog
	X6HOun2AM9YeuRifOld0AXjjZOAabZnjT7I35Iaby5DF/fpaw5lCaiRqUmG/av6G
	/MXNvy9LLu8LQvJUbQb99gcM0=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD330E_QLJqT4dWAA--.33181S5;
	Tue, 22 Sep 2026 16:45:56 +0800 (CST)
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
Subject: [PATCH v7 3/3] dt-bindings: net: can: fsl,mpc5xxx-mscan: Convert to DT schema
Date: Tue, 22 Sep 2026 16:45:42 +0800
Message-ID: <20260922084542.104788-4-quchaosheng000406@163.com>
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
X-CM-TRANSID:_____wD330E_QLJqT4dWAA--.33181S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxKr1DAF45WF43XFyxtF43Jrb_yoWxAw1Dpa
	y3Ca17JFyqqF15Z3yvqF48Cw18Ja1vyF15Grn7Z34xK3y5CF18tF43KF9YvFW5JryfZa9F
	g3WSqr18JFnI9w7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_iSd5UUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5ARo3WqyQEQUggAA3f

Convert the Freescale MPC5xxx MSCAN binding from free-form text to DT
schema.

The original text documents fsl,mpc5200-mscan and fsl,mpc5121-mscan in two
separate sections. Keep that split: fsl,mscan-clock-source takes "ip" or
"ref" on fsl,mpc5200-mscan, and "ip", "ref" or "sys" on fsl,mpc5121-mscan.

Add fsl,mpc5200b-mscan as a fallback of fsl,mpc5200-mscan. mpc5200b.dtsi
uses it.

Document clocks and clock-names, which the original text does not describe.
fsl,mpc5121-mscan requires the "ipg", "ips", "sys", "ref" and "mclk"
clocks in that order, as mpc5121.dtsi supplies them. MPC5200 does not use
DT clocks; it takes its frequency from the CDM block.

fsl,mscan-clock-divider divides the selected clock, so value 0 cannot be
used.

Keep the note that the MPC5121 Rev. 1 processor is not supported.

Assisted-by: LLM
Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---

v7:
 - clock-names is an ordered list of the five names and clocks is minItems 5,
   as the one order used by the device trees is documented. fsl,mpc5121-mscan
   now requires both properties.

 - Drop the if/then for fsl,mpc5121-mscan that only restated the enum of
   fsl,mscan-clock-source. The description of the two per-compatible defaults
   moved to the property itself.

 - fsl,mscan-clock-divider has a minimum of 1; the driver divides by it.

 - One example, which now shows the required clocks.

 - Add Assisted-by.

 .../bindings/net/can/fsl,mpc5xxx-mscan.yaml   | 109 ++++++++++++++++++
 .../bindings/net/can/mpc5xxx-mscan.txt        |  53 ---------
 2 files changed, 109 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/mpc5xxx-mscan.txt

diff --git a/Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml b/Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml
new file mode 100644
index 000000000000..77aa46fd62ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml
@@ -0,0 +1,109 @@
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
+      Clocks feeding the controller. fsl,mpc5200-mscan takes its frequency
+      from the CDM block and does not use DT clocks.
+    minItems: 5
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
+      Clock source used for the controller. When the property is not present,
+      fsl,mpc5200-mscan uses the reference clock, while fsl,mpc5121-mscan
+      selects an optimal clock source and frequency based on the system clock
+      and uses the reference clock when that is not possible.
+    enum: [ip, ref, sys]
+
+  fsl,mscan-clock-divider:
+    description: Additional clock divider for the reference and system clocks.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
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
+          enum: [ip, ref]
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,mpc5121-mscan
+    then:
+      required:
+        - clocks
+        - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mpc512x-clock.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    can@1300 {
+        compatible = "fsl,mpc5121-mscan";
+        reg = <0x1300 0x80>;
+        interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+        interrupt-parent = <&ipic>;
+        clocks = <&clks MPC512x_CLK_BDLC>, <&clks MPC512x_CLK_IPS>,
+                 <&clks MPC512x_CLK_SYS>, <&clks MPC512x_CLK_REF>,
+                 <&clks MPC512x_CLK_MSCAN0_MCLK>;
+        clock-names = "ipg", "ips", "sys", "ref", "mclk";
+        fsl,mscan-clock-source = "ref";
+        fsl,mscan-clock-divider = <3>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/net/can/mpc5xxx-mscan.txt b/Documentation/devicetree/bindings/net/can/mpc5xxx-mscan.txt
deleted file mode 100644
index 2fa4fcd38fd6..000000000000
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

