Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81FD3F54B7;
	Mon, 17 Aug 2026 23:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009675; cv=none; b=pCaR9iuFTiixFEL2bkZjPyIEfe1XQ7u4l/zAQCINkHH7rwWl/duEC41qiIKa0RI1EGRqc2vvytSi0xt4eR0SfJxEHKC2UxtFzPGllhOwPxTzNSGTuEdbVDNvs35iFj+XornR88linrZt+eriqWyMfd3UqXehNtHXcTK8l/Z/ktk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009675; c=relaxed/simple;
	bh=bzM/pGQkTxyZucOtlLzr2RmGdPKRNf1Inc9EY2AIeOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gqq6eMkt1MbDL6gfIXRB5UAY1IvTw8vYgOJUDh2HPxUVHEG0utdvOGGWicO9Jse48A2hnp8x0ZDGDnuzFctMC2kiNxLeAACCwnBmUzaE2UHoRFcb/ZSBWrAQbwQ11U88fl0Ub9sxg3YHrJVdCOg0ltZENSedwzuxSCYpjeGxtbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 096E3202288;
	Tue, 18 Aug 2026 01:34:23 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ww6qU-00220w-2t;
	Tue, 18 Aug 2026 01:34:22 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8D6D658515A;
	Mon, 17 Aug 2026 23:34:22 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Eduard Bostina <egbostina@gmail.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 07/11] dt-bindings: net: can: Convert TI HECC to DT schema
Date: Tue, 18 Aug 2026 01:24:34 +0200
Message-ID: <20260817233420.2068204-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817233420.2068204-1-mkl@pengutronix.de>
References: <20260817233420.2068204-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Bostina <egbostina@gmail.com>

Convert the Texas Instruments High End CAN Controller (HECC) bindings
to DT schema.

Signed-off-by: Eduard Bostina <egbostina@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://patch.msgid.link/20260719140127.3558941-1-egbostina@gmail.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../bindings/net/can/ti,am3517-hecc.yaml      | 64 +++++++++++++++++++
 .../devicetree/bindings/net/can/ti_hecc.txt   | 32 ----------
 2 files changed, 64 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/ti,am3517-hecc.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/ti_hecc.txt

diff --git a/Documentation/devicetree/bindings/net/can/ti,am3517-hecc.yaml b/Documentation/devicetree/bindings/net/can/ti,am3517-hecc.yaml
new file mode 100644
index 000000000000..7874e9e49224
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/ti,am3517-hecc.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/ti,am3517-hecc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments High End CAN Controller (HECC)
+
+maintainers:
+  - Eduard Bostina <egbostina@gmail.com>
+
+allOf:
+  - $ref: can-controller.yaml#
+
+properties:
+  compatible:
+    const: ti,am3517-hecc
+
+  reg:
+    maxItems: 3
+
+  reg-names:
+    items:
+      - const: hecc
+      - const: hecc-ram
+      - const: mbx
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  ti,use-hecc1int:
+    type: boolean
+    description:
+      If provided, configures HECC to produce all interrupts on the
+      HECC1INT interrupt line. By default, the HECC0INT interrupt line
+      will be used.
+    default: false
+
+  xceiver-supply:
+    description: Regulator that powers the CAN transceiver.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    can@5c050000 {
+        compatible = "ti,am3517-hecc";
+        reg = <0x5c050000 0x80>,
+              <0x5c053000 0x180>,
+              <0x5c052000 0x200>;
+        reg-names = "hecc", "hecc-ram", "mbx";
+        interrupts = <24>;
+        clocks = <&hecc_ck>;
+    };
diff --git a/Documentation/devicetree/bindings/net/can/ti_hecc.txt b/Documentation/devicetree/bindings/net/can/ti_hecc.txt
deleted file mode 100644
index e0f0a7cfe329..000000000000
--- a/Documentation/devicetree/bindings/net/can/ti_hecc.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-Texas Instruments High End CAN Controller (HECC)
-================================================
-
-This file provides information, what the device node
-for the hecc interface contains.
-
-Required properties:
-- compatible: "ti,am3517-hecc"
-- reg: addresses and lengths of the register spaces for 'hecc', 'hecc-ram'
-       and 'mbx'
-- reg-names :"hecc", "hecc-ram", "mbx"
-- interrupts: interrupt mapping for the hecc interrupts sources
-- clocks: clock phandles (see clock bindings for details)
-
-Optional properties:
-- ti,use-hecc1int: if provided configures HECC to produce all interrupts
-		   on HECC1INT interrupt line. By default HECC0INT interrupt
-		   line will be used.
-- xceiver-supply: regulator that powers the CAN transceiver
-
-Example:
-
-For am3517evm board:
-	hecc: can@5c050000 {
-		compatible = "ti,am3517-hecc";
-		reg = <0x5c050000 0x80>,
-		      <0x5c053000 0x180>,
-		      <0x5c052000 0x200>;
-		reg-names = "hecc", "hecc-ram", "mbx";
-		interrupts = <24>;
-		clocks = <&hecc_ck>;
-	};
-- 
2.53.0

