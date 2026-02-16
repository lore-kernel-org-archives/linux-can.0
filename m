Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4BF28C871;
	Mon, 16 Feb 2026 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771250038; cv=none; b=KjHoJRHmc13zFO2zmbZZN0GBJxNb6nUQZVPhxCIf6m+WdgfuffTlK/KgeEJj+Z5VqaxzIo9SUP2MQLlv7dXhwZRb8+0JtPVO9JgJjcfT8a1ZOWyr2nzFI3udrvxhOp4wxyGio66JvtAMtDFUH3vhZB4NaBbos8yI8JQFTNHrj+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771250038; c=relaxed/simple;
	bh=eCbPS8Ap0yfs80aEEQIA7JzlQ9DLeyLWKPgj8TiRjQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DTMGm0gfqS+wFotHqSbkmkJq52hMfG0gG4HmxUaFg5tfyhrI9REJiBORJ4dlx7ocg9FeVKqR25J9ZDXfDBXUCz6rAA2HrlaidEYpTS0s2HAmWAjvATE4sV3O8fNW0RREEfzotk8KWYB8B4lTNakgRf8FJspRbBhRjvrhNAT8SBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=BfvAMJTt reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="BfvAMJTt"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4fF44X3lRWz1FbwM;
	Mon, 16 Feb 2026 14:53:48 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4fF44X1pkCz1Fbw6;
	Mon, 16 Feb 2026 14:53:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1771250028;
	bh=m7n4sIS38bSgIxKBHwPD/b/kaxsxN/cmYx9adBN1Ojw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BfvAMJTtnqQzJicI3hSpcP8vXL3KFXbSt9IGdZ4EiELJXrsGHee5ot14I4NFKjiHe
	 2h0xa5sJkyNNmSkJ4+OVF9Z190NbUzqBl4qrWxN7clngM5OBdoJXQSP4CyOmtWxVBv
	 fVsvXvhkcBA+V+iUft0w4pLBvHmL0Fq92XGLGPcykPVwW5CgaR8XJ95eIKCo14TODO
	 lCtj16vCVMffxy6sk/RlECKOKAFkkagLAwyy1Jo3WhdMSXhysMTPB4fqW58+3PxU1G
	 8Czy7HyaF5JAsf+5yV1lxlVClpEB3hBSGJllbQlHeWfUSaS5YacNi/wrq1boi+Vyz5
	 6Q1kAzRy8vknw==
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Arun Muthusamy <arun.muthusamy@gaisler.com>
Subject: [PATCH v5 02/16] net: can: Convert gaisler,grcan to DT schema
Date: Mon, 16 Feb 2026 14:53:30 +0100
Message-ID: <20260216135344.23246-3-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216135344.23246-1-arun.muthusamy@gaisler.com>
References: <20260216135344.23246-1-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate device tree bindings for Gaisler GRCAN, GRHCAN
and GRCANFD CAN controllers from a text format to YAML format.

Additional changes:
  - Remove stale systemid property
    removed in commit 1e93ed26acf0 ("can: grcan: grcan_probe():
    fix broken system id check for errata workaround needs")
  - Make freq optional
  - Add clocks
  - Add compatible
  - Add example

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/net/can/gaisler,grcan.yaml       | 62 +++++++++++++++++++
 .../devicetree/bindings/net/can/grcan.txt     | 28 ---------
 2 files changed, 62 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/grcan.txt

diff --git a/Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml b/Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml
new file mode 100644
index 000000000000..8fea97c7319a
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/gaisler,grcan.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aeroflex Gaisler GRCAN, GRHCAN and GRCANFD CAN controllers.
+
+description: |
+  GRCAN, GRCANFD, GRHCAN controllers are available in the GRLIB VHDL
+  IP core library.
+  For further information look in the documentation for the GRLIB IP library:
+  https://download.gaisler.com/products/GRLIB/doc/grip.pdf
+
+maintainers:
+  - Arun Muthusamy <arun.muthusamy@gaisler.com>
+  - Andreas Larsson <andreas@gaisler.com>
+
+allOf:
+  - $ref: can-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - gaisler,grcan
+      - gaisler,grcanfd
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  freq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Frequency of the external oscillator clock in Hz (the frequency of the
+      AMBA bus in the ordinary case).
+      This property should be used by systems where the common clock
+      framework is not supported.
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
+    can@ff400000 {
+        compatible = "gaisler,grcanfd";
+        clocks = <&sysclock>;
+        reg = <0xff400000 0x400>;
+        interrupt-parent = <&plic0>;
+        interrupts = <6>;
+    };
diff --git a/Documentation/devicetree/bindings/net/can/grcan.txt b/Documentation/devicetree/bindings/net/can/grcan.txt
deleted file mode 100644
index 34ef3498f887..000000000000
--- a/Documentation/devicetree/bindings/net/can/grcan.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-Aeroflex Gaisler GRCAN and GRHCAN CAN controllers.
-
-The GRCAN and CRHCAN CAN controllers are available in the GRLIB VHDL IP core
-library.
-
-Note: These properties are built from the AMBA plug&play in a Leon SPARC system
-(the ordinary environment for GRCAN and GRHCAN). There are no dts files for
-sparc.
-
-Required properties:
-
-- name : Should be "GAISLER_GRCAN", "01_03d", "GAISLER_GRHCAN" or "01_034"
-
-- reg : Address and length of the register set for the device
-
-- freq : Frequency of the external oscillator clock in Hz (the frequency of
-	the amba bus in the ordinary case)
-
-- interrupts : Interrupt number for this device
-
-Optional properties:
-
-- systemid : If not present or if the value of the least significant 16 bits
-	of this 32-bit property is smaller than GRCAN_TXBUG_SAFE_GRLIB_VERSION
-	a bug workaround is activated.
-
-For further information look in the documentation for the GLIB IP core library:
-http://www.gaisler.com/products/grlib/grip.pdf
-- 
2.51.0

