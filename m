Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EA338332F;
	Mon, 14 Sep 2026 05:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789365399; cv=none; b=YjuEbT9EaiWtMKJa0wjAu5rm/qWEvO/1us54WX8U2ido94MUTqNgcuG57wMXcClcfjBwooOegTqEDTCesxRw8VX1JSbud9e9JvsSK8C3KcVPDNBvWDHJ81uGg0ecip69PMLg399eHzn1NALJ9Z+69mOuNlSm2SYkir6hQmowT/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789365399; c=relaxed/simple;
	bh=BQrgTj0zADJvOxhVKe0bF7oi1OKUe3JYVL8K9wlby6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbGOnt+qw6mVNZjcr7PUjgWbYI2b37AmCHAlTtdlRbS3x0JG49Brb3eFasBMM2hdu1C0yNeLM0inkHbLzUqyeXSd1EQvGsasbEgUPZXBpfcCvuctF+BINCPmn1DAQdxgAjXL04z1eX/i+gd7sJAFGQjwV7NF0M1+pZ1DcVIaaE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GGm9ZhpY; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GGm9ZhpY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=nm
	7nAQtxhdPTPjFXuSPoAKPul5cyvZ8Zb23hE3AEupI=; b=GGm9ZhpYpTojsHfs3D
	qB8IhEOYdijnYQZH7PsZPWFc21rGiuhX3N5y2S1+Cq1I5IHNNTZcy4wG89avUH37
	TroGDp7XcWhzr6CPHsjVsAGex4hcfzAANp2QapQpOuluFoqEaaw2pD4u6Tf+3L52
	rH7ffY+yW27hPfDTGH8J4wmCk=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wBXg9l4jKdqXB8tAg--.2092S3;
	Mon, 14 Sep 2026 13:56:11 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	quchaosheng000406@163.com
Subject: [PATCH v2] dt-bindings: net: can: fsl,mpc5xxx-mscan: Convert to DT schema
Date: Mon, 14 Sep 2026 13:56:08 +0800
Message-ID: <20260914055608.495084-2-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914055608.495084-1-quchaosheng000406@163.com>
References: <20260914055608.495084-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXg9l4jKdqXB8tAg--.2092S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ww18KF15Ar4DWw43CFy7Awb_yoWxZFWfpF
	WfC3W7JFyqqF15Zws0qF48Aw1xJa1vyF15Krnav348K398CF18tF43KF9YvFyUJryxZa9F
	93W0vr1rAF13Cr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEK0PhUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4xvFO2qnjHurfAAA3r

Convert the Freescale MPC5xxx MSCAN controller binding from free-form
text to DT schema, and reference the common can-controller.yaml schema.

The original text described the two compatible strings and their clock
source properties in separate sections. "fsl,mpc5200b-mscan" is added as
a fallback of "fsl,mpc5200-mscan", the way existing device trees such as
mpc5200b.dtsi use it. The allowed values of fsl,mscan-clock-source are
constrained to the strings the driver accepts: the driver compares
against "ip", "sys" and "ref" and rejects anything else.

The clocks and clock-names properties are documented as well. The driver
looks up the "ipg", "ips", "sys", "ref" and "mclk" clocks by name, and
the existing MPC5121 device trees provide exactly those. They were not
described by the old text.

The note that the MPC5121 Rev. 1 processor is not supported is kept from
the original text.

unevaluatedProperties is used rather than additionalProperties so that
properties provided by can-controller.yaml remain usable.

Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---
v2:
 - Add "fsl,mpc5200b-mscan" as a fallback compatible. mpc5200b.dtsi uses
   "fsl,mpc5200b-mscan", "fsl,mpc5200-mscan" and the strict enum would
   have rejected those existing device trees. Reported by Sashiko.

 - Describe the clocks and clock-names properties and add them to the
   example. The driver requires them on MPC5121, which the v1 example did
   not show. Reported by Sashiko.
---
 .../bindings/net/can/fsl,mpc5xxx-mscan.yaml   | 105 ++++++++++++++++++
 .../bindings/net/can/mpc5xxx-mscan.txt        |  53 ---------
 2 files changed, 105 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/mpc5xxx-mscan.txt

diff --git a/Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml b/Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml
new file mode 100644
index 000000000..cece49caf
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml
@@ -0,0 +1,105 @@
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
+    #include <dt-bindings/clock/mpc512x-clock.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    can@1300 {
+        compatible = "fsl,mpc5121-mscan";
+        reg = <0x1300 0x80>;
+        interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+        interrupt-parent = <&ipic>;
+        clocks = <&clks MPC512x_CLK_BDLC>,
+                 <&clks MPC512x_CLK_IPS>,
+                 <&clks MPC512x_CLK_SYS>,
+                 <&clks MPC512x_CLK_REF>,
+                 <&clks MPC512x_CLK_MSCAN0_MCLK>;
+        clock-names = "ipg", "ips", "sys", "ref", "mclk";
+    };
+
+    can@1380 {
+        compatible = "fsl,mpc5121-mscan";
+        reg = <0x1380 0x80>;
+        interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
+        interrupt-parent = <&ipic>;
+        clocks = <&clks MPC512x_CLK_BDLC>,
+                 <&clks MPC512x_CLK_IPS>,
+                 <&clks MPC512x_CLK_SYS>,
+                 <&clks MPC512x_CLK_REF>,
+                 <&clks MPC512x_CLK_MSCAN1_MCLK>;
+        clock-names = "ipg", "ips", "sys", "ref", "mclk";
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

