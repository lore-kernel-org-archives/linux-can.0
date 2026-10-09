Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F8B4C9DE7;
	Fri,  9 Oct 2026 10:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791543262; cv=none; b=NMBbmJLRctH/ZLwno46kGDOBszBARftle77w6mRKkw25mijWc+n9y/l22aUBOGJ+WmUJMfvWLyDOH37TYsOpF3II0lFKg/B81f+cNYgeFI53WnVxG9PhblYTg3T7OXV9bX1AbvvLRkLh3cmO3RRPKwsl4LmZkdu32mlHU0HJJU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791543262; c=relaxed/simple;
	bh=awIlp30CeI4dhmDi0uFmo9R6S0mQBS2FAdrSFqNp4Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFY7MFH0cVCYFmgQxX1qPM8F/NJzepiSIkp+bmrG31xjYzVRfS3sfz/W+8rD2gh1u9ViB60EVmDik8vpUXzGRWGaSjFcJ/7RI5hlEbjxkEkx7trtAZtlaajH3vwwey0rhF+0G3oFIglRbIll1nFkEpBWngmbzjQ2PjRtENLMr0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=acyvC0nr; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="acyvC0nr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=es
	uXtHP6VEp2mHsRHWXDjEZCOKY0i+VPy11LLFZQ5ZM=; b=acyvC0nrzKRKBZhnat
	bdFTaa4SqCwd+70knr06CBUE4R5n/r1rBVqFf/bhYtz2o3b+/acn3kdGpss1nQJN
	RRaceIK7xsaKd47m1icP/Y4LHNOrAgoSXK1eA7QvsITvU1bjq+0KcX9UP7upDrYX
	CFiKcOyCPhl6AZ9gKOBovp3VY=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXX8S8x8hqZHAsDg--.36732S3;
	Fri, 09 Oct 2026 18:53:50 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: net: can: bosch,cc770: Convert to DT schema
Date: Fri,  9 Oct 2026 18:53:47 +0800
Message-ID: <20261009105348.300114-2-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009105348.300114-1-quchaosheng000406@163.com>
References: <20261009105348.300114-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXX8S8x8hqZHAsDg--.36732S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ww1rXrWUuF48tFykuw4DArb_yoWxXw47pF
	Z3Kws7JFsYqF1fXw47KF18ur13uFs3uF15Gr9Fvr15JrWrGF1vga1akryYqFWUCr97X3Wj
	vF18Wa9Fga1DZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UtMa5UUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5B7tY2rIx75L4wAA3H

Convert the Bosch CC770 and Intel AN82527 controller binding from
free-form text to DT schema, and reference the common can-controller.yaml
schema.

The driver reads one more property than the old text documented:
"bosch,no-comperator-bypass", which is checked at cc770_platform.c:94.
It is documented here so that it can be used. Its spelling is kept as
the driver spells it.

The interrupt is obtained with platform_get_irq(), so interrupts is
required. The register window is described with the chip select, the
address offset and the size, as the original text and the existing
device trees on the local bus use three cells. The size is usually 0x80.

unevaluatedProperties is used rather than additionalProperties so that
properties provided by can-controller.yaml, such as termination-gpios,
remain usable.

Assisted-by: LLM
Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---
 .../bindings/net/can/bosch,cc770.yaml         | 109 ++++++++++++++++++
 .../devicetree/bindings/net/can/cc770.txt     |  53 ---------
 2 files changed, 109 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/bosch,cc770.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/cc770.txt

diff --git a/Documentation/devicetree/bindings/net/can/bosch,cc770.yaml b/Documentation/devicetree/bindings/net/can/bosch,cc770.yaml
new file mode 100644
index 000000000000..448d5b4f74b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/bosch,cc770.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/bosch,cc770.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bosch CC770 and Intel AN82527 CAN controllers
+
+maintainers:
+  - Marc Kleine-Budde <mkl@pengutronix.de>
+
+description:
+  The CC770 is a CAN controller from Bosch which is 100% compatible with the
+  older AN82527 from Intel, except that some bugs have been fixed.
+
+allOf:
+  - $ref: can-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - bosch,cc770
+      - intc,82527
+
+  reg:
+    description:
+      Register window of the controller. On a PowerPC system the controller
+      sits on the local bus and the property describes the chip select, the
+      address offset and the size, the size usually being 0x80.
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  bosch,external-clock-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Frequency of the external oscillator clock in Hz. The internal clock
+      frequency used by the controller is half of this value.
+    default: 16000000
+
+  bosch,clock-out-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Clock frequency in Hz on the CLKOUT pin. If not specified or if the
+      value is 0 the CLKOUT pin is disabled.
+    default: 0
+
+  bosch,slew-rate:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Slew rate of the CLKOUT signal. If not specified a reasonable value
+      is calculated. Only used when bosch,clock-out-frequency is set.
+
+  bosch,divide-memory-clock:
+    description: Divide the memory clock for slower memories.
+    type: boolean
+
+  bosch,iso-low-speed-mux:
+    description: Use the ISO low speed multiplexed bus configuration.
+    type: boolean
+
+  bosch,no-comperator-bypass:
+    description:
+      Disable the comparator bypass. When this property is absent the
+      comparator bypass is enabled.
+    type: boolean
+
+  bosch,disconnect-rx0-input:
+    description: Disconnect the RX0 input.
+    type: boolean
+
+  bosch,disconnect-rx1-input:
+    description: Disconnect the RX1 input.
+    type: boolean
+
+  bosch,disconnect-tx1-output:
+    description: Disconnect the TX1 output.
+    type: boolean
+
+  bosch,polarity-dominant:
+    description: Use dominant polarity on the bus.
+    type: boolean
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
+    localbus {
+        #address-cells = <2>;
+        #size-cells = <1>;
+
+        can@2,100 {
+            compatible = "bosch,cc770";
+            reg = <2 0x100 0x100>;
+            interrupts = <4 1>;
+            interrupt-parent = <&mpic>;
+            bosch,external-clock-frequency = <16000000>;
+            bosch,disconnect-rx1-input;
+            bosch,disconnect-tx1-output;
+            bosch,iso-low-speed-mux;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/net/can/cc770.txt b/Documentation/devicetree/bindings/net/can/cc770.txt
deleted file mode 100644
index 042200cf4419..000000000000
--- a/Documentation/devicetree/bindings/net/can/cc770.txt
+++ /dev/null
@@ -1,53 +0,0 @@
-Memory mapped Bosch CC770 and Intel AN82527 CAN controller
-
-Note: The CC770 is a CAN controller from Bosch, which is 100%
-compatible with the old AN82527 from Intel, but with "bugs" being fixed.
-
-Required properties:
-
-- compatible : should be "bosch,cc770" for the CC770 and "intc,82527"
-	for the AN82527.
-
-- reg : should specify the chip select, address offset and size required
-	to map the registers of the controller. The size is usually 0x80.
-
-- interrupts : property with a value describing the interrupt source
-	(number and sensitivity) required for the controller.
-
-Optional properties:
-
-- bosch,external-clock-frequency : frequency of the external oscillator
-	clock in Hz. Note that the internal clock frequency used by the
-	controller is half of that value. If not specified, a default
-	value of 16000000 (16 MHz) is used.
-
-- bosch,clock-out-frequency : slock frequency in Hz on the CLKOUT pin.
-	If not specified or if the specified value is 0, the CLKOUT pin
-	will be disabled.
-
-- bosch,slew-rate : slew rate of the CLKOUT signal. If not specified,
-	a reasonable value will be calculated.
-
-- bosch,disconnect-rx0-input : see data sheet.
-
-- bosch,disconnect-rx1-input : see data sheet.
-
-- bosch,disconnect-tx1-output : see data sheet.
-
-- bosch,polarity-dominant : see data sheet.
-
-- bosch,divide-memory-clock : see data sheet.
-
-- bosch,iso-low-speed-mux : see data sheet.
-
-For further information, please have a look to the CC770 or AN82527.
-
-Examples:
-
-can@3,100 {
-	compatible = "bosch,cc770";
-	reg = <3 0x100 0x80>;
-	interrupts = <2 0>;
-	interrupt-parent = <&mpic>;
-	bosch,external-clock-frequency = <16000000>;
-};
-- 
2.43.0

