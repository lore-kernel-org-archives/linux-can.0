Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794554014;
	b=gEIISja3vn++V9F/1OJIOaMMi8MU1P/UpEL0vgCqjkDD1pcCJZRadQM2rDWzD5FO8jAc
	 G4J8rRSQaRXwWLI0x44L3lPn1sKxC8sbXjUE8X48itL+mtJJFmOT4MDBK1nZgo8MDQy0z
	 npCU2+d0ih/8nCq5Y4hV77hq3BgH3yPhFnjFlR+OvetL7PVKofKGNPKF5IfZHrZhA78mx
	 bcyKe7/clmYfPx6D4xhjuE2yvKEdqDvtpEf6sxkPWiQbv29fR4za5FF3XAKC9L3wM0Hgz
	 tJvgLQ3y8MuGfE6ICX7av0U/pIkREj/EdAY1xwpgMHkQk1XI7vXkvDZzbYZh8v0x+bQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794554014;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TYdXS0Y1B/+aEpnsy30imFC+jIXI/coSdwBL0puYj30=;
	b=BhxaWzF23+dRP6yb8i1Loj+3rScjaxDe4Qhf2cE1hus514HG5AUUns3OcxkiPq6FfwG1
	 M2Hs66gTu28JJlhkA4mRflU2ohDK0yX3fXSaNyPwnTlzsgqhVp4u/l+V5uUqsgg+pPldJ
	 4CVmBibGgYQ/eGOu107jkLRY2OuWVQ5eV3A6a1NYYg9Ann8KrtYrR/X49liSRTSdLvB7V
	 4VSU4Z+IOGo+0xu1E7x4F/ytI41UkC2BkIT5ueTe6X5nTcKCQsbH9pq/tMpt5CZaHoXTX
	 dw4bMVSELXaVibdRR/OouJVZcszT92TnvRmDnsrIHtCL5KnU6ixcc2qWcxbIuxstAQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ZBRSuLXF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D11160A5BCD;
	Fri, 13 Nov 2026 07:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D11160A5BCD
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ZBRSuLXF
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 335A9205836;
	Fri, 13 Nov 2026 08:13:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794554008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYdXS0Y1B/+aEpnsy30imFC+jIXI/coSdwBL0puYj30=;
	b=ZBRSuLXF74IwWxHeUbSGt/vDSpgaZTLHsw79hltwZGQg63pjPvkKcddJZBrD0GBHvFszsv
	KXzuVniU4p5ztJBWUWukj4dLEkdps/3PfhrdBTLniYk8wuGD7sbs+7ZdCgiEUERCKGECPF
	DBBAo0XMGLg79zwLSdMu2QJpSXEr9S7h2IrL9dbFBSa8rwwYhEJnz4ZWy2pPCOFKSwI9Pt
	KozRwONSISkJ81dcwlQToXKvMiZIZoKBCm6CWTXgWTMp6EUYZYnABeQHLj8dTgjVtDMRpi
	rLmcrv48ETfR4/yB7GZLfT+bqA1I+URFfVwyk8apBCQrTbpxl/gUraVKnwdFpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794554008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYdXS0Y1B/+aEpnsy30imFC+jIXI/coSdwBL0puYj30=;
	b=CIyBvkMzC/e2kI5lLUUhas3sm3lJ6lW+Z8RmuwUY/9oGlmd7K+4j/F17m6Rtrf9nIJ3XOU
	G8jIsxwTK1HzTfgORjdWaA1w3uTFYFlyFAj1m3IqnJYicDT5IeDELtfVIzfsSdqWuXpKUg
	TE02RkIdEFwD/VgTz5aLg0OrFJRw51Piz1pGU826pq4Y55MNgTbuCIEK+V6Y0reYYXR2uf
	NLxjIYfFOMTLBmfoiIzV5BPtzpkPs3B0dw8F51iq++QAPMKo1gNicf/HTXyyDw6EoSOvAk
	7JMiq4x8gQGQKW+m4NJRopGp4VCZom3TiDFkzw3BU0V7GpeH0TDSsLt6qoRPMA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794554008; a=rsa-sha256;
	cv=none;
	b=E5xIoyxE6Vqn25RmP2/O28mj28ng9q94Q+JVnlKOPbQQFXI1uhq5OhP6FBdb7Yky8X1DzO
	stO6yVTWIPZ0w948MPsOheDaQZGLD+vW2BayhoRpTgU0IdGaWI7PB8kDFQtzxJ9qVNzPP0
	t1qYXD73lZZf+G81oOkhOUc224ChweBOAt3Fyx9/soAqYtTQjfC+sCIUlAkVHVI2FkW8zS
	OAHSSSzKdqqyN7yK9+Kj6ZunTZMcl7TaApGnHyUqNltxosEkXfXCd7HagBdsHimEk5TlJv
	svtQ/cNjuHX1CilhwHBE6dfYtiT+sJWgpjGsBJ5hdlVwqDDagkpEq6ecNsUBsg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xRlTU-003xHv-0C;
	Fri, 13 Nov 2026 08:13:28 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id CEA425EA57B;
	Fri, 13 Nov 2026 07:13:27 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Quchaosheng <quchaosheng000406@163.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 6/7] dt-bindings: net: can: convert grcan to DT schema
Date: Fri, 13 Nov 2026 08:08:54 +0100
Message-ID: <20261113071325.4092169-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113071325.4092169-1-mkl@pengutronix.de>
References: <20261113071325.4092169-1-mkl@pengutronix.de>
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

From: Quchaosheng <quchaosheng000406@163.com>

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

Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://patch.msgid.link/20260929073703.2748220-2-quchaosheng000406@163.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---

Notes:
    FAQ:
    
    Q: What about the comment in drivers/net/can/grcan.c?
    A: It's changed in the next patch.

 .../net/can/aeroflexgaisler,grcan.yaml        | 65 +++++++++++++++++++
 .../devicetree/bindings/net/can/grcan.txt     | 28 --------
 2 files changed, 65 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/aeroflexgaisler,grcan.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/grcan.txt

diff --git a/Documentation/devicetree/bindings/net/can/aeroflexgaisler,grcan.yaml b/Documentation/devicetree/bindings/net/can/aeroflexgaisler,grcan.yaml
new file mode 100644
index 000000000000..d5cba5b1bac1
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
2.53.0

