Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1F8384CDD;
	Thu, 15 Oct 2026 01:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029232; cv=pass; b=KhyF2zw8JollCrDd4kBx3xQvDAb/1i3iGC9J7UXiPD30wJuSQgX88z1WWHhXAbC+fuj8dhzyu3y7OAQHDmC7GLxsctWpATDJYSBrWOd9O8awTwoZ1Gqv5EV7VHZPwOoO4pfAIlnA+QtOgoRIZ6Dmuuik24Uquzm7fztX4Uzuy8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029232; c=relaxed/simple;
	bh=EDoagEUgu25weQiUCei6Kl9QdgOwQBCmHglU16FopUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRHfQq76diRi1QLWk8I6jPXPkO3v2B0JMxPJInSZIabqpHgitDnSEMNLXXbor6D0fAo/7Vd140ivq7AsFRtpv8EuvIvCiO3ADCm+twnHqK2m3eVvvW3ve057F8nbvmvm5+GWJdUpIBk9cBnGoXuapivgE3iHHEK+DYhVtPHtVzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=KdrFr+Ap; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="KdrFr+Ap"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5D3B02027E0;
	Thu, 15 Oct 2026 03:53:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZN6PILafY+cAwECJ3seVw3gPB6Vgfr3gQEV6UDJ+uI=;
	b=KdrFr+ApOzZE++/B1LFajQIXK/0IDVTSI0+bsSe+DQykllTqY1Zha7Im9kIFuzctP1XJSo
	bx2XMxo8ELKgP6E3QC0bOanrCTfIsgXPYJ4F2FvAYarKDRYoSCyi7F/Pp+3f/jwVtQFtmS
	MWOC+wMHUWOveiClIEuGrp9u+e7Iy69x8L1oe8V6OLSk4GXZgXuMUcDG7SEoN+BcEEnAe8
	EBKP0w8j7cypv4u7O2mZg5IeTi6Kvso9fvh1N21kgkJpOeXIa6di6s/rWcabUSX26Dr0lV
	m2Ir/T7EQgPS2iiHtNGNlcGG2DvUHv5LIGOnTAOSVTiS97yzMBaDfyJt3vjcaw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792029221; a=rsa-sha256;
	cv=none;
	b=WCOxOmpjLVWmN5Tbsw+E0bJgNKo6itMGnOfk6NJJfqhkLqicDMHMDehq3586hJVvHFDqD7
	/+gvzB7Qus2DT6y0gpsyYsUeYDwDtjwqVlh0Cww6c5jNILh57khTy8kIhPH1aTFnSNvcSe
	qsUjCNWQkmYz0OP1+cme0NCgoNyM1xhMJgGbI0JKU8U2jOXMLyYa+A3NSGBfRYrFB3DLZV
	oIx6wBl2cqssxjh9Wkm185PW+aIMQUp+Xklo+O0k2pYA18oP509PZDEzFQ96uzfEskJZJs
	uZOZwCkXcHBOHQ6b+uyZeVl4KfBZyQdv1swa/WSZx0r1GshbdyiYBHYPWU4M/g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZN6PILafY+cAwECJ3seVw3gPB6Vgfr3gQEV6UDJ+uI=;
	b=gmz0/OvYWzwvV/MH62VpJmws2tjCPw9/1h2HfPhTO6/yLUkDNx+TDz5fWG5K6DhJOYMH3g
	PtWWprlSVpCqvZspAHugqrAt8LO1ZG7q+j6AJXdB7luKVmHTC2MZVo1RnP4fMVCRAHbvm4
	IXyDe+utV+jvhuaL2L7bJh6sk/OV82QQIv4OPC/JWiqeOgXcSrDz5FgbsdZKIeG/aMawkf
	sgbrAh8pKQ6Eh6H5AyFbM2/ZksXMq9/Bg8XeYQ5QgJvVjzcLb8JzSrijQi6PiPlei/AFfF
	NU0Wt+GZxEjlnDrPCRuxz2EEKhlr4g8sorEIkHIkyBJrFMNkBl51dyLUogJXRw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAf7-005wqx-0s;
	Thu, 15 Oct 2026 03:53:41 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0D0295C478C;
	Thu, 15 Oct 2026 01:53:41 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Quchaosheng <quchaosheng000406@163.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 21/37] dt-bindings: net: can: convert grcan to DT schema
Date: Thu, 15 Oct 2026 03:40:19 +0200
Message-ID: <20261015015336.816543-22-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015015336.816543-1-mkl@pengutronix.de>
References: <20261015015336.816543-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
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

Assisted-by: LLM
Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://patch.msgid.link/20260929073703.2748220-2-quchaosheng000406@163.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
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

