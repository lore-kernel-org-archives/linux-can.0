Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794554011;
	b=snjE67+BLEzSzG71gKuWgCXwv4NcCigVhws04c1lyh+Sigz5aaZnLDnGalj0zVYbzSp4
	 TS2u2wYz26AZauYpuqD9CGHsZbsCXNYrCUmVAdUc1Ou5deNhlnfv7zBqqraT5bZqeCBMp
	 lz5wD7enIgEPdNuNnqupkT/5NdCCNlttxdf27T3PxAsZ7De9vf00/WOTYrEo64j6bjLL2
	 UxLorn7UfxrV9rlX6iE6xOu70tO3GIuvjb5vX0MqSJ7q03WHGQ39xKc2ZAMjn6aFhcWXS
	 gacmZrYCstAOmCI2RKj7pdyD0xuWgCQj+21q2UcohhE3cxiiIbuwMWiTMkNBI4+V3Jw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794554011;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/+VRHS43plOjIRbhGsfOqQ1nmhZowYRYK29KqoxHYMk=;
	b=Np3PpOZbJQzt2Sg+DvhCzphYscn75ju0yfdDvC2iVDCol7RHt8jwQOVCeXmBHa/s9M2D
	 hZMT9TSsLod2uWRbo0oTWiG08f8xphLl1vc58d1zb3ZyrRp74A/bkoK71UM24DGG0y2wC
	 L50h03SuML5T8EtDAbcXNHZjDITbbU6FcZvKkaKa8E50n4jQc8uo8N4s3JQYO/Rh0AbY1
	 rqElOVzZQoECI0lhn3EymI3NNKS4o25xixbXTsWs7MJq+HM2nWc7uvvxxoVyhBE4hrVBw
	 K5qbE1jARpazF1HCWGMEHS86rvbsRGu8qadxgT840PTBJoRIQ1J9RxuXXUh0tL1sesQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="aLyOpFE/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4693760A3811;
	Fri, 13 Nov 2026 07:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4693760A3811
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=aLyOpFE/
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 14081202C91;
	Fri, 13 Nov 2026 08:13:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794554008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+VRHS43plOjIRbhGsfOqQ1nmhZowYRYK29KqoxHYMk=;
	b=aLyOpFE/2IJMm7cn+U8nSDPSkDdDU+nFF2MzxzB3AyGoqmTAv/YN+BH35BZ1KLGvBk01l9
	skbsNgT9TsdL4FFXmllyR5NOLIysnIyINMDGJ0WMlppTgDcNTUBC5xOTFAlPDlDcH+ir4c
	CK33Oo2XtWUv4sPhiwzRzvuFk6pgpeR1t7hr6LJfvddYRWDCwP7ZCtzMr614pC2q4qqXZr
	G1A7ZjIAl/SuN3yBGue7WpkLjmfYI6SpHNB3GkZ2GfrjpQIW0wAGFSA1X0+mDacOLdlILL
	daM4ffGlRf6NMKKvOYI/HUIfMuI1TwqJUUDR2hNZHe2u4bGmmc9seGRUbQDKPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794554008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+VRHS43plOjIRbhGsfOqQ1nmhZowYRYK29KqoxHYMk=;
	b=QKXmui41IM0LOQ/moQGdx8pszNMj5dXRJkJOGDIXYc57jg1HBdsXTYbe6lKgJNIkIDrNz0
	TmO00dSD/SzbyIA8+ToMKs2xpB6rwUnudFaW2JCAw0e6pYPKw1X0KYkJIlEDLvMhbMNjqT
	5WSGmuThrzCvTIb2D0w08vYdJzsVrBXyjoTIE7kB3T1ztPvR0As41L/Po6pLcA6kUw1t2i
	uVoLe050axh680S1E6INiijBXcWuOMS0d9+IeF19iOWVu4GucvlG7vEakCN/0EPn+LIWg5
	W4zzovPM8DKZg3U3J75BxiTa8IOCrjtWWV2csOCH6Pd3AtwEgKHCDX+QH3K8kw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794554008; a=rsa-sha256;
	cv=none;
	b=b7gqODv4iMgJToZdiKTwfDM2C8LzuN+HRbS4ID0yK4EyxAJ+YN3nUzu36oTz6k/kkjrumy
	yLDCiw6MWHy8Q5PJVzmrcCDzC0BVqcBP0/9OO+UqaUY6P3GPJuH2uMX0KjjuhMu8iQhPzS
	IDuLQW+AH9Z4Bb+1P+F0o+BYjbRX7D3wdIXtkmGYPdCBHtotxMsIor0t4Arjuz8mLwXXaZ
	0ognug9XFhm/Kt2+tKvxIyLEgPFW+F1P3QiEYYuGRswk45/D1yUWj6rv83ffZtwzkC+0Bh
	VgTe1e9qE58gm9xj0LGNAJq2JUT9q69poWOAWJvq+S32FD9NbVKMQkGg1HU+YA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xRlTT-003xHq-3B;
	Fri, 13 Nov 2026 08:13:28 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AAE365EA578;
	Fri, 13 Nov 2026 07:13:27 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Quchaosheng <quchaosheng000406@163.com>,
	Sashiko <sashiko-bot@kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 3/7] dt-bindings: net: can: holt,hi311x: Convert to DT schema
Date: Fri, 13 Nov 2026 08:08:51 +0100
Message-ID: <20261113071325.4092169-4-mkl@pengutronix.de>
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

Convert the Holt HI-311X binding from free-form text to DT schema.

Reference can-controller.yaml and spi/spi-peripheral-props.yaml. The
HI-3110 sits on an SPI bus, so its node carries the standard SPI
properties, spi-max-frequency among them. With unevaluatedProperties:
false and no reference to spi-peripheral-props.yaml, dtbs_check rejects
those properties:

  can@1 (holt,hi3110): Unevaluated properties are not allowed
    ('spi-max-frequency' was unexpected)

Keep the properties and the example as the original text describes them,
including clocks as a required property.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260922084542.104788-1-quchaosheng000406@163.com?part=2
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
Link: https://patch.msgid.link/20260922102258.138753-3-quchaosheng000406@163.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../bindings/net/can/holt,hi311x.yaml         | 67 +++++++++++++++++++
 .../bindings/net/can/holt_hi311x.txt          | 23 -------
 2 files changed, 67 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/holt,hi311x.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/holt_hi311x.txt

diff --git a/Documentation/devicetree/bindings/net/can/holt,hi311x.yaml b/Documentation/devicetree/bindings/net/can/holt,hi311x.yaml
new file mode 100644
index 000000000000..9ec6abb1279a
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/holt,hi311x.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/holt,hi311x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Holt HI-311X stand-alone CAN controller
+
+maintainers:
+  - Marc Kleine-Budde <mkl@pengutronix.de>
+
+description:
+  The Holt HI-3110 is a stand-alone CAN controller with an SPI interface.
+
+allOf:
+  - $ref: can-controller.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: holt,hi3110
+
+  reg:
+    description: SPI chip select.
+    maxItems: 1
+
+  clocks:
+    description: The clock feeding the CAN controller.
+    maxItems: 1
+
+  interrupts:
+    description: IRQ line for the CAN controller.
+    maxItems: 1
+
+  vdd-supply:
+    description: Regulator that powers the CAN controller.
+
+  xceiver-supply:
+    description: Regulator that powers the CAN transceiver.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        can@1 {
+            compatible = "holt,hi3110";
+            reg = <1>;
+            clocks = <&clk32m>;
+            interrupt-parent = <&gpio4>;
+            interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
+            vdd-supply = <&reg5v0>;
+            xceiver-supply = <&reg5v0>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/net/can/holt_hi311x.txt b/Documentation/devicetree/bindings/net/can/holt_hi311x.txt
deleted file mode 100644
index 3a9926f99937..000000000000
--- a/Documentation/devicetree/bindings/net/can/holt_hi311x.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-* Holt HI-311X stand-alone CAN controller device tree bindings
-
-Required properties:
- - compatible: Should be one of the following:
-   - "holt,hi3110" for HI-3110
- - reg: SPI chip select.
- - clocks: The clock feeding the CAN controller.
- - interrupts: Should contain IRQ line for the CAN controller.
-
-Optional properties:
- - vdd-supply: Regulator that powers the CAN controller.
- - xceiver-supply: Regulator that powers the CAN transceiver.
-
-Example:
-	can0: can@1 {
-		compatible = "holt,hi3110";
-		reg = <1>;
-		clocks = <&clk32m>;
-		interrupt-parent = <&gpio4>;
-		interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
-		vdd-supply = <&reg5v0>;
-		xceiver-supply = <&reg5v0>;
-	};
-- 
2.53.0

