Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8F7332601;
	Mon, 14 Sep 2026 03:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789354955; cv=none; b=qD0RD55PrhS9WbfjCuSwd1Pz590znS7NXwC/N3PWbg04m6DAanp+i0OO3Vmjo3+WamXSrq9p1zOWbsQPQ6hSMZmzDnw1PYJuT/4oclvi9/REvqp0LBFBOHfFEjZMhv1DTKwuZuOx67QQUlN6YOAz9FAXBHs4+unIfOxXngMpN90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789354955; c=relaxed/simple;
	bh=K+rsJWdAKeReMEdFUoXg6vMwR2a2AFRv5L33cXO1GNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJUoffkzhcNpP+YH+WgTVpcc2rj+Umo5UL8l/bk58f81xSfjJDRNqr6ZfV92OsRU98IWHrzvIIbN3tGZFaHL7qcPDz9MpSS3EbBZ5pw3ySI/ZUHv6XhCgpGtXYocNsTsy1B4dXnSkgICXnqNi4s2x/h8Hn5ViMbeypTxG0Mvbvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mOUuln9+; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mOUuln9+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=P4
	h5Jmgr4zGBzl5tJm8VON6LbJKZZ6e05GP/BrDhs98=; b=mOUuln9+i+EdmlpP20
	kuKEB4204BL5RESYVSI7V3BjGP9tONkDSbDndcr51+waPNy5nzV9gAt1eBlUhQ/3
	RtAHZdeDkxexFr4NjSgot95P4j1/LV3dxGnESW2b3ZGkd/klbp1s2HDuXEMKp0um
	Yj+jYlaGlT2yNJqUK1CmWNeIw=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBHh8m3Y6dqeVk+Ag--.7653S5;
	Mon, 14 Sep 2026 11:02:18 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	quchaosheng000406@163.com
Subject: [PATCH] dt-bindings: net: can: fsl,mpc5xxx-mscan: Convert to DT schema
Date: Mon, 14 Sep 2026 11:02:15 +0800
Message-ID: <20260914030215.437602-4-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914030215.437602-1-quchaosheng000406@163.com>
References: <20260914030215.437602-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHh8m3Y6dqeVk+Ag--.7653S5
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ww18KF18Ary3Gr43uryrXrb_yoW7trWrpa
	y3Ca47JFyqqF1avw4vga18Awn7JanYyF15Gr92v34xKrZ8CF18tF4SkF9YvFyUGr93Za9F
	g3W0vF1UAFnrCr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziFoGPUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbDABqLAWqnY7qkcgAA3S

Convert the Freescale MPC5xxx MSCAN controller binding from free-form
text to DT schema, and reference the common can-controller.yaml schema.

The original text described the two compatible strings and their clock
source properties in separate sections. This is expressed with a single
enum for compatible, and the allowed values of fsl,mscan-clock-source
are constrained to the strings the driver accepts: the driver compares
against "ip", "sys" and "ref" and rejects anything else.

The clocks and clock-names properties are documented as well. The
driver looks up the "ipg", "ips", "sys", "ref" and "mclk" clocks by
name, and the existing device trees provide exactly those. They were
not described by the old text.

The note that the MPC5121 Rev. 1 processor is not supported is kept from
the original text.

unevaluatedProperties is used rather than additionalProperties so that
properties provided by can-controller.yaml, such as termination-gpios,
remain usable.

Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---
 .../bindings/net/can/fsl,mpc5xxx-mscan.yaml   | 87 +++++++++++++++++++
 .../bindings/net/can/mpc5xxx-mscan.txt        | 53 -----------
 2 files changed, 87 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/mpc5xxx-mscan.txt

diff --git a/Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml b/Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml
new file mode 100644
index 000000000..108f225f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml
@@ -0,0 +1,87 @@
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
+  The MSCAN controller found on Freescale MPC5200 and MPC5121 SoCs. Note that
+  the MPC5121 Rev. 1 processor is not supported.
+
+allOf:
+  - $ref: can-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - fsl,mpc5200-mscan
+      - fsl,mpc5121-mscan
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description:
+      Clocks the controller needs. On MPC5121 the driver looks up "ipg",
+      "ips", "sys", "ref" and "mclk" by name.
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
+      Clock source used for the controller. Valid values are "ip" for the IP
+      bus clock, "ref" for the reference clock (XTAL) and "sys" for the
+      system clock. "sys" is only available on MPC5121. When the property is
+      absent, an optimal clock source based on the system clock is selected,
+      falling back to the reference clock.
+    enum: [ip, ref, sys]
+
+  fsl,mscan-clock-divider:
+    description:
+      Additional clock divider for the reference and system clock sources.
+      Defaults to 1 when not specified.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 1
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

