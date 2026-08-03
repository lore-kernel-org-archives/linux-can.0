Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824B43B6C18;
	Mon,  3 Aug 2026 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767111; cv=none; b=uP1FH2yPP/BkqN0ZMYte7zoT96BZNRpSRQfLoZhg4zk7/FbN7Y0F6hWcH2146Wwe6i53g+xGZb0GCDOi71TZ/k9FAwG+9MKqwzeldLDjEGVJ7x/VoYXqCLWl8ZcUbUPNJkHaFLI9qXddhpRpXHJqwMj15DJpsq9Bijd//qUVOvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767111; c=relaxed/simple;
	bh=AxmvJCzPjUWfNoaTuysnBGUQUwCFnGfsWBv2NJRk7eE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXxR1FLiCPTD45AHE6ilJVfgcYwQD5mc0QWRXPS9kgcR7tWTsLsvyNXGFQGhZFLUbu3zs4qm3T8XjmAcMX8M4HS1Yqg4i+lWsikjFyfNiVVWa5k1WCkO4YkxDr/f2Vnu1t3RdgXA867ji+Iydg6L8mKlf/wrvMI5FSxXf/a6glk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGrnzMxY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGrnzMxY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DF91F000E9;
	Mon,  3 Aug 2026 14:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785767110;
	bh=WozQ8XsgsUIaFIpBINbojo1F27WlWNueguNc6/InIkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OGrnzMxYGuEs8/zgYT/jPSbqc55w5K8JOZhQKz0Dsf8vDrE5KABlnemWVzRjP9Ij5
	 Y5rix6vhzVXUA0oyD77XQ1ke2P7Hdbr65137FP3NGgiak+R++DeA0xJlodhgaFgMEN
	 YlriVG7p3QMhQo3JGDRR+qOaubeqTc3d18rQXodFYobw1SXh8ZKyExGQDAHj9hia9o
	 +TL3kjUECmxhypSfFsLbcb/c2WEHIhYDS2rHMzImgZ50/DWmUX/Z0pbqigdSAa6WNd
	 whaZ6CQ9hPx3zo9u6YDk8nv3wab8UDb8q/oi5mtD6uefQMaECgCOPx9LeCuZH/9gwp
	 DD+PqRhFI9dvA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: can: add arasan canfd controller
Date: Mon,  3 Aug 2026 22:05:30 +0800
Message-ID: <20260803140531.12692-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260803140531.12692-1-jszhang@kernel.org>
References: <20260803140531.12692-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation for the arasan canfd controller.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../bindings/net/can/arasan,canfd.yaml        | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/arasan,canfd.yaml

diff --git a/Documentation/devicetree/bindings/net/can/arasan,canfd.yaml b/Documentation/devicetree/bindings/net/can/arasan,canfd.yaml
new file mode 100644
index 000000000000..a120c11ce304
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/arasan,canfd.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/arasan,canfd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title:
+  Arasan CAN-FD controller
+
+maintainers:
+  - Jisheng Zhang <jszhang@kernel.org>
+
+allOf:
+  - $ref: can-controller.yaml#
+
+properties:
+  compatible:
+    const: arasan,canfd
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: can
+      - const: sys
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: can
+      - const: sys
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    can@e5060000 {
+        compatible = "arasan,canfd";
+        reg = <0xe5060000 0x1000>;
+        interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk 32>, <&clk 16>;
+        clock-names = "can", "sys";
+        resets = <&rst 3>, <&rst 2>;
+        reset-names = "can", "sys";
+    };
-- 
2.53.0

