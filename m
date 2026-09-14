Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E54B3093DB;
	Mon, 14 Sep 2026 02:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789352525; cv=none; b=dJZTHnpGRF0zlO51lGzzaPk34u+9g8hcjT+0WMusUn3OKQDf6g7FPt0qalxHc+e6ek+kj6ruXwzfdjWZOviX0g8veHvliZ0C7B3OMl5sVI/t/6W/g0XKb5oQfku8z76YDBhpUOcmGGGIMzkZ2d8Eu1FoADbSUjEINkHzm+IxL8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789352525; c=relaxed/simple;
	bh=FoRbvjJYUht6kbLmSlFPEjYXMLGqkLxTElouKEcRFVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lY8pjlkb32TFJY81Pj3jaSIkPf3pk04Msvx8qmw6MHODHSifl4Buu/RYMWn9saE8zhheZkY2HXRPnDrReowNR9V4x4zHdUyt4tkM4EvSZHEEO9X12XwiQWFhCz7PyR0p6+jvsdTFMoQfkCfGIE1Vde5ZprlK9eNYKTs9Dkzzncs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ppatkF5q; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ppatkF5q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=iJ
	kFKZ6xXmC9IcVlt3Hy4pHoy2vpFDSR+26IXi0a6rk=; b=ppatkF5q62irxTAzNH
	LEAJ359zHvhwag2kcKmPNh0ac8Lyw89ss4qKgnZvAtu9R5h0ecgzthxkAMewQn5x
	F5RNZYaSBXti2fPBkgmXms0Q206I5q95LFV15yqwaAfCGChAqvzLW8e3MWO/O3Sb
	hO9igqjRrfPP2bA8doVkYEtPU=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDH9QQ5WqdqYjVKSg--.17020S2;
	Mon, 14 Sep 2026 10:21:45 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	quchaosheng000406@163.com
Subject: [PATCH v5] dt-bindings: net: can: convert ifi_canfd to DT schema
Date: Mon, 14 Sep 2026 10:21:45 +0800
Message-ID: <20260914022145.408976-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDH9QQ5WqdqYjVKSg--.17020S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF4DJrWDKF1kGr1rXw1UZFb_yoWrGry5pF
	W3CrnrJFs2qF43Gw4xK3W8Cw13ZFn5AF15Kr9rZw10ya90gFy5tw4akas5ZFyYgrZ2vFyx
	XF1Fga15J3W7uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRmYLkUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5BopnmqnWjos7AAA3k

Convert the IFI CAN-FD controller binding from free-form text to DT
schema, and reference the common can-controller.yaml schema.

The driver matches on the "ifi,canfd-1.0" compatible and obtains its
interrupt through platform_get_irq(), so interrupts is required.

The example uses the GIC and irq header defines instead of the raw
numbers from the original text, which keeps the values unchanged
(GIC_SPI is 0, IRQ_TYPE_NONE is 0 and 1 is IRQ_TYPE_EDGE_RISING). The
node name is changed from "canfd" to "can" so that it matches the
$nodename pattern required by can-controller.yaml.

---
v2:
 - Correct the description: this is a soft IP block typically synthesised
   into an FPGA or CPLD, not a controller found on Renesas SoCs.
   Wording now follows the driver's Kconfig entry.

v3:
 - Use unevaluatedProperties: false instead of additionalProperties: false.
   As can-controller.yaml is referenced through allOf, additionalProperties
   would have rejected properties defined by that common schema, such as
   termination-gpios and termination-ohms.

v4:
 - Use defines instead of raw numbers in the example, and rename the
   example node from canfd to can. No functional change.

v5:
 - Re-send the patch on its own. The v4 posting accidentally included
   unrelated changes to the xilinx-xadc binding and did not remove
   ifi_canfd.txt. Only the intended change is present now.

Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---
 .../bindings/net/can/ifi,canfd.yaml           | 46 +++++++++++++++++++
 .../devicetree/bindings/net/can/ifi_canfd.txt | 15 ------
 2 files changed, 46 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/ifi,canfd.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/ifi_canfd.txt

diff --git a/Documentation/devicetree/bindings/net/can/ifi,canfd.yaml b/Documentation/devicetree/bindings/net/can/ifi,canfd.yaml
new file mode 100644
index 000000000..63f982e73
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
+  - Quchaosheng <quchaosheng000406@163.com>
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

