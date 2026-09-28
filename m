Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6378F4AA1C2;
	Mon, 28 Sep 2026 11:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790594842; cv=none; b=F7Z5Fwhzgr3OEjMQuj0YuHafS8nlwnoWut0NeIULGj4qDnXz8Clq1pj/wCek1vpM/74M1wblKKst8D3jaKUoPu0j954KmW/TnGFdrM+iXYBgaxaOtPcM7XoKV85JgXTZDsatFNZ3D69HTgSXDg7E6XPtGRluXjcsvqhYkIf6kI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790594842; c=relaxed/simple;
	bh=l70PCDVe5odKUXU8MAaM2rTo1ceQRbLWbNVoUL83OvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B1qNkl5NeCyofihW7UAuHsz7oa1/XneyU4gWad/lHNQOZbQ8oXbPUaKdJE0giiofBSr2f/Cy7E6XA/3z8PgGCNzf+tAIGX6sna76uq5qkIW128WgozM7M2VgLEddoTsr7XehFyEBGwF7/hpYGbaVT6fmR3u5ZYQ4FpmyxFMIMHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZMxidCxZ; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZMxidCxZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=BC
	YFnquRg4ESM+E/GGvXcfXknbqzYmGno6fhj0l2hLs=; b=ZMxidCxZPG0nvbjVRi
	qs4RwBiNvi0DPwqLsoDwe06FzJ3vFez1YtiDq7k5SwrevGwztTtzcuB9YEx4+oqi
	UxxRrumyA6ymaUW0HHiVcttZFvuVk1d2tlxF8pePE1BP56yC3uxlaNqyOnS15X1U
	Hc3NwUfHNL6bF1zWd/iG6OKtw=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBn63cCT7pq8FBXBw--.34376S2;
	Mon, 28 Sep 2026 19:26:59 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Quchaosheng <quchaosheng000406@163.com>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] dt-bindings: net: can: convert grcan to DT schema
Date: Mon, 28 Sep 2026 19:26:57 +0800
Message-ID: <20260928112658.2119678-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgBn63cCT7pq8FBXBw--.34376S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GrW5Kw4kZrWxAF48GFy3urg_yoW7uw4Dpa
	9xGFy7GrZ7KF4xWw1Svw4xCF13Zws5AF4YkryDuw12y3Z8W34Fqr4Skr15Za9rCr4kAa4a
	9F4Yga48KaykC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUj2NZUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4wUek2q6TwXXVwAA3x

grcan.txt is the only CAN controller binding whose device does not have a
compatible string.  There are no device tree source files for LEON SPARC,
and the nodes are built by the PROM from the AMBA plug&play information,
which carries a core name and a register window but no compatible.  The
driver matches on the node name instead.

It is the last of the five CAN controller bindings that were still written
as free-form text; the other four are posted separately.

A binding without a compatible string is not selected by dtbs_check,
because nodes are matched through their compatible values.  The schema
therefore needs an explicit select on the node name.  This is the same
mechanism ethernet-phy.yaml uses for optional-compatible nodes, and
without it the schema would never be applied to anything.

Two further details are worth pointing out, because the text binding got
them wrong or left them implicit:

  - "systemid" is not a property of the controller node.  The driver and
    arch/sparc/kernel/leon_kernel.c both read it from the "/ambapp0" node,
    so it is described in the description rather than in properties.  The
    binding is stricter than the text file here, and dtbs_check now
    rejects a controller node that carries it.

  - The node name format is "<core name>@<irq>,<address>", as built by
    ambapp_path_component() in arch/sparc/kernel/prom_32.c from the "name"
    and "reg" properties of the AMBA plug&play core.  The select pattern
    and the example follow that format.

The "name" property of the text binding is not described: dtc enforces
that it equals the base node name and then deletes it from the output, so
it never reaches a compiled devicetree.

This binding does not reference can-controller.yaml, unlike the other CAN
controller schemas.  That common schema constrains the node name to
"^can(@.*)?$", which these nodes cannot satisfy -- they are named after
the AMBA plug&play core.  Referencing it makes every valid node fail.

No functional change.  The driver comment is updated by a separate patch.

Assisted-by: LLM
Signed-off-by: Quchaosheng <quchaosheng000406@163.com>

---
 .../bindings/net/can/aeroflexgaisler,grcan.yaml    | 65 ++++++++++++++++++++++
 .../devicetree/bindings/net/can/grcan.txt          | 28 ----------
 2 files changed, 65 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/aeroflexgaisler,grcan.yaml b/Documentation/devicetree/bindings/net/can/aeroflexgaisler,grcan.yaml
new file mode 100644
index 000000000..d5cba5b1b
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/aeroflexgaisler,grcan.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/aeroflexgaisler,grcan.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aeroflex Gaisler GRCAN and GRHCAN CAN controllers
+
+maintainers:
+  - Marc Kleine-Budde <mkl@pengutronix.de>
+
+description: |
+  The GRCAN and GRHCAN CAN controllers are available in the GRLIB VHDL IP
+  core library.
+
+  On a LEON SPARC system there are no device tree source files. The nodes
+  are built by the PROM from the AMBA plug&play information, which does not
+  provide a compatible string. The driver therefore matches on the node
+  name, which is built as "<core name>@<irq>,<address>" from the "name" and
+  "reg" properties of the AMBA plug&play core.
+
+  The GRLIB build ID is not a property of the controller node either. It is
+  read from the "systemid" property of the "/ambapp0" node, and the TX bug
+  workaround is enabled when that property is absent or when its least
+  significant 16 bits are smaller than 4100.
+
+select:
+  properties:
+    $nodename:
+      pattern: '^(01_034|01_03d|GAISLER_GRCAN|GAISLER_GRHCAN)@'
+  required:
+    - $nodename
+
+properties:
+  reg:
+    maxItems: 1
+
+  freq:
+    description:
+      Frequency of the external oscillator clock in Hz, which is the
+      frequency of the AMBA bus in the ordinary case.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  interrupts:
+    maxItems: 1
+    description:
+      Interrupt number of the controller, as built from the AMBA plug&play
+      information.
+
+required:
+  - reg
+  - freq
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    /* AMBA plug&play children are named "<core name>@<irq>,<address>" */
+    GAISLER_GRCAN@c,80000000 {
+        reg = <0x80000000 0x1000>;
+        freq = <40000000>;
+        interrupts = <12>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/net/can/grcan.txt b/Documentation/devicetree/bindings/net/can/grcan.txt
deleted file mode 100644
index 34ef3498f..000000000
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

