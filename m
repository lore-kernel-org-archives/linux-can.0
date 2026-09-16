Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D8E37C0FD;
	Wed, 16 Sep 2026 01:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789523917; cv=none; b=jQhwlvYSjIpMBx2PFkQpe/FYqVn78sHCZnY2blPOXn9VrwtIZ4F6KdE0v8DPuqX9MtLDjYpHHp89rmJ2gJJhzVqtthl2VvjxZZTLIVfTyYkbDNEZ7AaCsCr45slQ3Y47EwTfkiFq9U28PEZ1aCzhQIMnR1AYqFBYWiJ1mtZygrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789523917; c=relaxed/simple;
	bh=W4Yt6JJEvLEyOXYfx1oKwPdQHPpUuz1Hkbq3lxaTNzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kM3Tv5ueN6FRacHootpDIjYloICEdPnA6WWqkvINwKn6g9ifxsSDwQ+d//6cyWoirq0DaHbLYBfOV2Qf1mRdTevFcBcwLs8tO+5XSHARmtGGZNstwRMa6jHvCxvs23ylY/MPSMscodQ2jwvVIKXsZCsEtIfIsVIu/V2ia/8mj7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CUUo0AuA; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CUUo0AuA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Kw
	IV19lOzOVIKBlB4A5I0PDe/sdgcIKaMK8pMqtcL5c=; b=CUUo0AuAZ8bjhJjAvm
	L5n8pib8BsOoDnSwKVZX/s1df0eBmuAvTDmlJcS2QbzjbNEoyO6hvSGe8skVCD83
	uaAnV9fKtxNC6PSlZ7/IV/P4eKfk1J5jtBgRUCPWE0HkZNpiexcbNfIzldVjpu8t
	wBtPnZd4bGSwINy8p9+hvTCZQ=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDnOeCt96lqkT+dRw--.34264S2;
	Wed, 16 Sep 2026 09:58:05 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	quchaosheng000406@163.com
Subject: [PATCH v6] dt-bindings: net: can: fsl,mpc5xxx-mscan: Convert to DT schema
Date: Wed, 16 Sep 2026 09:58:03 +0800
Message-ID: <20260916015803.112328-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914090440.552884-2-quchaosheng000406@163.com>
References: <20260914090440.552884-2-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDnOeCt96lqkT+dRw--.34264S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKr4UJrWrCF17uF4DtF4xZwb_yoW3Gr47pa
	y3C3W7JF9FqF13Z392gF48Cr1rAanYyF45Grn7Z34xK3y5CFy8tF4SkF9Yva45Gr93Za9F
	g3Wrtr18JFnF9aUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRsIDrUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbDAA0uo2qp963U4wAA3u

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
all five. The original text did not describe them. MPC5200 obtains its
frequency from the CDM block and does not use DT clocks at all.

clock-names accepts the names in any order and allows a subset: the driver
looks each one up by name (devm_clk_get()) and only needs the clocks
actually selected, so a node providing just the clocks in use is valid.

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

v6:
 - No content change. Fix the patch format: the changelog was placed in the
   commit message instead of after the '---' separator, which confused
   Patchwork. Move it back where it belongs.

 - clock-names: accept the names in any order and allow a subset, as the
   driver looks them up by name and only needs the clocks actually
   selected (devm_clk_get()). The previous strict ordered 5-item list
   rejected valid nodes that provide only the clocks in use.

 - clocks: add minItems: 1 and note that MPC5200 does not use DT clocks
   at all; it obtains its frequency from the CDM block.
 .../bindings/net/can/fsl,mpc5xxx-mscan.yaml   | 118 ++++++++++++++++++
 .../bindings/net/can/mpc5xxx-mscan.txt        |  53 --------
 2 files changed, 118 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/mpc5xxx-mscan.txt

diff --git a/Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml b/Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml
new file mode 100644
index 000000000..7f01008f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml
@@ -0,0 +1,118 @@
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
+      Clocks feeding the controller. Only meaningful on MPC5121, where the
+      driver looks the clocks up by name ("ipg" for register access, plus
+      the clocks selected through fsl,mscan-clock-source). MPC5200 obtains
+      its frequency from the CDM block and does not use DT clocks.
+    minItems: 1
+    maxItems: 5
+
+  clock-names:
+    description:
+      The driver looks clocks up by name, so the order is not significant,
+      but each name may be given at most once.
+    minItems: 1
+    maxItems: 5
+    items:
+      enum: [ipg, ips, sys, ref, mclk]
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

