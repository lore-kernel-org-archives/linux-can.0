Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4297F4E3EF3;
	Fri,  9 Oct 2026 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553423; cv=pass; b=CxT3opCrcuI0S06FVeHzV4n1ryHiyx1ukumWf68lLq77lGp2D4fw8D6wd0+A9rDboEz2xQLMVDqnMfXBo0x4kKbT8opgqp7+BNaU6QEacT4/5Cw1itTh7sgTSZl/4Rb/2A8IezYwx3suIzJoNIQ+jNWb/91mE8yMLSnk8UBeWco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553423; c=relaxed/simple;
	bh=EDoagEUgu25weQiUCei6Kl9QdgOwQBCmHglU16FopUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQNnmcA6ZxmzsTw3uuEoWtxZzmljNJkNzo753Gz0vDlp+erD3IJYjjm4zE0lkk8Tf/hk5GxHnDmH5Zo8VZHLeDAkmhY9Z49ong8GQ4lTyJI6CoSdRK9xwZOjlthLydcrH3E7sSUT4kaJfpYdf6KxyzwQUoQS0MUrfFDoU7FmHoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=IBtKBjbl; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="IBtKBjbl"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id CDB8D202601;
	Fri, 09 Oct 2026 15:43:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZN6PILafY+cAwECJ3seVw3gPB6Vgfr3gQEV6UDJ+uI=;
	b=IBtKBjblzKCuEH8ePvcmkFGc7vyerWSz7JoEoAa6CaIWoGdhcsQXDvR1NmDXC7MDZr90MN
	g8DyDoUhcOEVYx3b9KpG5E6kCwsAl4zLX3wom6xPu3fsMVdEujo4WfoymvgTtWEinorRni
	zfWiD88pNc4t9Zw9/7FXJejQOb2XtiplwlADmBDCS3Lajd5ItnSrQl5RknnEdyr+BH+X4A
	pFU1F/sBl5Ojw+gr+H4fQXUvZDukreMUiBC6vFjCT0mT30Ug8GJW8kmieK/hyH12JJh75c
	wrhEhDRj2Y7F4xM9Gr/x6EzfLdmbJwatyP+nj76nSaMVKtZ8Ynf6/BcyWyTVYA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553416; a=rsa-sha256;
	cv=none;
	b=L1gmIAursTM9mdJEtZjP/V+H4G6UsPajFQU95f8UoUYTCqtbalSXAB+C0KKk2lD2o8XVaR
	YtrH+qax850Sd7XwT3F7Owf3JIRAuYFExJXBnpTUMbjIse63z3Fp5tLZaI1Ssa/KwUnzjU
	QtsTJtjWi/Qqhj9WAOzW9Lno5vpKhi1+ZKcNFKEiyYKYZIuffQrPSO0w7u3T5DQnDyPKc9
	9FdUKR71QM2Na6GcJiR3ghE77I8sv+ciT2Hh0Tsg+1Othk/3tXJRiZNsvVo3RSJpGxy5cp
	t3jybjS8/gh9Ndg33sGr2+1q96QKUQ4DIf5RkOlr9QK02w8NnbSd+EYHrn9jZA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZN6PILafY+cAwECJ3seVw3gPB6Vgfr3gQEV6UDJ+uI=;
	b=GQfmGTspdXyqAkScY3L1sRExauAWuYYT2O1+zX6fhZDmOAV50YdadVTaBCZ3HeUpwng4Zt
	ugWcuPd6ogAAvi7lQYNcos4+1s+d+jn8U8Z62528TB71SwMlfx1zlLu4SwLYSgJNvZkZx0
	OWLrpNJTSwBCyYxOfGctnszoygIQjsRgq+kWlJS7O7nNL5YOqlwHS9PnaTRGQinvhBwycT
	YEh4c0okAbB07kgu0D+u0j8DubWHzq+u5OdB+kuTlx/aP++t9d5YxFy5L3or9A720+d+6x
	YxwZJummIfArF+cRX/V7o8rvSu8f4f3XzHwTaZ8vF3IMNRKLnItLN+nZao/iUA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAsq-0053Sf-2O;
	Fri, 09 Oct 2026 15:43:36 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 539915BD8C5;
	Fri, 09 Oct 2026 13:43:36 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Quchaosheng <quchaosheng000406@163.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 18/37] dt-bindings: net: can: convert grcan to DT schema
Date: Fri,  9 Oct 2026 15:27:50 +0200
Message-ID: <20261009134323.64064-19-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009134323.64064-1-mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
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

