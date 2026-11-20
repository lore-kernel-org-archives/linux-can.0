Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=64.106.246.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795162121;
	b=dZ3geCs83970Q3yZdMT3m0VCyHXN2lj1Y0ny6wVuP+OynIP2FRIteDGnaUn424jWZ2FZ
	 PWRtXOtKoVLDxNCodf7/dqqd4HgTt3yBUXboawpOS6ICpTBUCn90BjR1TBb4SfY4vxafd
	 rNeLzzzLhyC49dLZ0EI9Bycij8kAjTRtxOgabADjolp3XkLEFW1DpvChKvDAu25QpLZsD
	 LuKoO2BEDYmkBtppBKI4JFpnzuT0znyhrd0agxFqOzQYVEdh/DMdLFA5OWXCQinvUdyH9
	 /U38VFG1FnObL9C5nRYmv3BilDW5yLjCkX7JG/2NlyMQhVrAnPQ0WnkmrgwxTFFclpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162121;
	h=DMARC-Filter:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=CHvIhMz508UDncotGFKOHG7RFcnM9BHq2q6TuXQUD6w=;
	b=Vuv/ZpiMVhBrkcuXiklxSYS4n4PqygTFRgxGYsTTcqcU6lgT/emhWjvy1cL/vhVr0o47
	 StOSIizvdVFkmna1oLeoLZB9GfjE85o8OwtjQzOEPcy8xH5Pi5tnOSgSj7UQ9byYWDb2F
	 xH5jLF+CBvGVZZGlr1Jtk6UKlMUtBEmSL+FenA/Z1XSV9d6B9FPa0VzNSTk/P5fPiOj+f
	 KIgJoBGLawjpZcTJPgF7zbXxli5lD+amXBfSKa4i5QPPLHT1pWg5KUTJl+nfrU2ndvSWO
	 MokvBX96WN6YKYBIdU7qp8sBlIPFVec2PJ+/vbc3T2rPnBwM651oU5KR4ApDlsF2bYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	arc=none smtp.remote-ip=64.106.246.77
Received: from mailsc.amlogic.com (unknown [64.106.246.77])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE48606A336;
	Fri, 20 Nov 2026 08:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BE48606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Received: from rd03-sz.software.amlogic (10.28.11.121) by mailsc.amlogic.com
 (10.8.11.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 20 Nov
 2026 00:08:35 -0800
From: zelong dong <zelong.dong@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman
	<khilman@baylibre.com>, Rob Herring <robh@kernel.org>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Jerome Brunet <jbrunet@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-can@vger.kernel.org>, Zelong Dong <zelong.dong@amlogic.com>
Subject: [PATCH 1/3] dt-bindings: net: can: add Amlogic A9 CAN controller
Date: Fri, 20 Nov 2026 16:08:18 +0800
Message-ID: <20261120080820.3340646-2-zelong.dong@amlogic.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261120080820.3340646-1-zelong.dong@amlogic.com>
References: <20261120080820.3340646-1-zelong.dong@amlogic.com>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mailsh.amlogic.com (10.18.11.5) To mailsc.amlogic.com
 (10.8.11.35)

From: Zelong Dong <zelong.dong@amlogic.com>

Add device tree bindings for the CAN-FD controller found on the
Amlogic A9 SoC family.

Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
---
 .../bindings/net/can/amlogic,a9-can.yaml      | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/amlogic,a9-can.yaml

diff --git a/Documentation/devicetree/bindings/net/can/amlogic,a9-can.yaml b/Documentation/devicetree/bindings/net/can/amlogic,a9-can.yaml
new file mode 100644
index 000000000000..dd4ad6147f2e
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/amlogic,a9-can.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# # Copyright (C) 2026 Amlogic, Inc. All rights reserved
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/amlogic,a9-can.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic A9 SoC CANBus Controller
+
+maintainers:
+  - Zelong Dong <zelong.dong@amlogic.com>
+
+properties:
+  compatible:
+    const: amlogic,a9-can
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: CAN protocol engine clock
+      - description: CAN filter clock
+
+  clock-names:
+    items:
+      - const: can_pe
+      - const: can_filter
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+allOf:
+  - $ref: can-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        can@3a8000 {
+            compatible = "amlogic,a9-can";
+            reg = <0x0 0x3a8000 0x0 0x383c>;
+            interrupts = <GIC_SPI 82 IRQ_TYPE_EDGE_RISING>;
+            clocks = <&clkc_periphs 0>,
+                     <&clkc_periphs 1>;
+            clock-names = "can_pe", "can_filter";
+            power-domains = <&pwrc 2>;
+        };
+    };
-- 
2.47.1

