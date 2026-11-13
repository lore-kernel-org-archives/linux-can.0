Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794554011;
	b=TDfRNrGh3pqYtqx2f9Q5W6MT25K7AoPz/zHD4A3ICnf88+FvbQCTLdy/AaTDG1Ia7jAk
	 LD3Lt5U0iwIaCVvEPf6sv6UaDd4m8Vpcq00ps26BaznNVrdEvMWNoQW3h89kCZEGrKEM/
	 +OEPxFGjyA1NRrncQ4Pp36OSrOhzXN74tMVGLEQOsSf/AVMB6GJEoulFYNxU5vGHRyzFy
	 0vaj4wzhq975T4YeON2XcNTgxJ8A2aThMCwjg5WnL9ognHTvDWBvFr0R3NDISnSf3KIIN
	 xeomdicGFiq7edVAX2WmQDBaR+Ux584v+/XsEQ5ExUiyaQBJvrsFUKuQG0G1ftx5Lew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794554011;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FoouU1yOXSOL9vJPI//qigbV6ycEtcVzzRnWUF7ZjKU=;
	b=zE+EgZ6AHGxgeRIh4VAo00bXWB1+lQbWwedMfYDHVTQx3hTjwq7sXVtD6ia7o/zcnOzs
	 J19MPk5R4iGI34aHAcjgAGLBX0rbrGnWm9maz7BwnWt5wV2HEA6omyZIzBPVj89xdiF6F
	 ZMB95abS0TMiUNRbbtwpShvJ6DBoLaDnmZsm0dbqxvzFZeO7nWDfZDnYaZMrrbtWBo/IG
	 40VzHuH+MYgkxWEy+XB/xVhlpd2TLZADoO36xnXQAh25SZtXsQYzsKhHE5yqt2OzoeZ5h
	 4TKYOumCliljHeBRbigFt8CdAxTPGZCb0iapk8LiZuhUxhUw5aN4XaNv00ytm0ji6zw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=cvO1J1cg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4690860A3810;
	Fri, 13 Nov 2026 07:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4690860A3810
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=cvO1J1cg
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 088422023BD;
	Fri, 13 Nov 2026 08:13:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794554008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FoouU1yOXSOL9vJPI//qigbV6ycEtcVzzRnWUF7ZjKU=;
	b=cvO1J1cgWJs5FbXPqcj1qgmMXxF+fmQ+tIzW4rRswWSuYhkWaf6Tw7Tx0ESDv8ho5Vvg+X
	xeAHn+8v/6tTEHG9mhIKo5cSs5sp7f5MNdkXvI1JTi38tYr9g3t4BVvEbEACajdPeTgThk
	xDM6HG5Hhn9GmLUXhB3MquHgNrDw3eIUt2xjqE+hNudWexrqsKW/hHtNE43PZwA+VtRD6R
	XfM99h+7surisH3c7DfQvprhFWubenCiR6PoNtpWQIczsSWh+vhXQ+n5aSIOWeZUzzqADF
	PHHX8Ygxo5FS5veGczEsun/mYbNpRj9WOsAIriEcA/upORbVdnsfWI/GCbK9mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794554008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FoouU1yOXSOL9vJPI//qigbV6ycEtcVzzRnWUF7ZjKU=;
	b=ZlJIv3kdgXSqGvRETCAj9Hx4HPrWenX3GQ26PMKRP7WSFeLFCbz9SsgB+PljGd7fFj0mQb
	hqfwNwc6l4Ly3maE1ErgfWKWcumkDZVF8D/b4HF/Z2cNsxlkJi3TjXpVm2loyLccWT0Uka
	jwKw6fNvsRTXgVMbA3UVpd8emQdC9M28hHJxId9j/7uaX3yhlO4KQC5MKAOXypZ9CalsD3
	s6cBY2M8RUC3Wo4vVb6gYqNz+RCIE1lZx2LnN1rV5F+llbRudawvKZUZ/MFCLsXRynsx2x
	Bz/eUBngXOJZvzQ7nwNfNMOVHM1TwEdT+94zIqNHqaDIxG6bpoQ6gd6okI7Bqg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794554008; a=rsa-sha256;
	cv=none;
	b=gv4QBkwZ/nP8EY8euzzYJ4bMP4zu3mWc44THau9cKupnElW294UZukHTsWWOwIlL1PiWHD
	8uASqicKMRD/Prx+uo9PcHhmF+QoPqJ1LrFpGVZpsY3wFE0AhA56s57c99FVxoMikCWV6q
	tP9UN1WpkBHAZtAbSux9u4SDM5JWEL+xkQoQqb5NMjoT8xKmFlNdeVNsXCh1aWiHrXNCnE
	l/A2PrISR5x7tpiLR/tVIJ0qdNuVp4H4LqKkpiUq8RovIKtC0ReLsOTLUGCtAFqXx21liT
	V1LBdalXPsRszWNKC7JWA0JBI3uD1G7oUm8tAerFe/Y4oUDWWHws80y/EZvmvg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xRlTT-003xHp-2z;
	Fri, 13 Nov 2026 08:13:27 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9DA6E5EA577;
	Fri, 13 Nov 2026 07:13:27 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Chaosheng Qu <quchaosheng000406@163.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 2/7] dt-bindings: net: can: bosch,cc770: Convert to DT schema
Date: Fri, 13 Nov 2026 08:08:50 +0100
Message-ID: <20261113071325.4092169-3-mkl@pengutronix.de>
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

From: Chaosheng Qu <quchaosheng000406@163.com>

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

Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://patch.msgid.link/20261009105557.301855-2-quchaosheng000406@163.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---

Notes:
    FAQ:
    
    Q: What about the comment in drivers/net/can/cc770/cc770_platform.c?
    A: It's changed in the next patch.

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
2.53.0

