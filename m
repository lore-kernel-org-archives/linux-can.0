Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794554014;
	b=FkrZAKTjjQ9EUGyrp6LCAxeWDvGWu6zB0Ui/d5O8QIoREQ9a5QpwJWvksmU2rS8dUW7x
	 6tgryuBKLnrznFUy7JqSpoPA3uFKjhItXqKHU57aZ198HXlb2LQsq49XrIO9zbAv7dpC3
	 ynZy6lvpMkww/jdgRTdkgu2R4/IPnyED3BpKnUxsm4DPp+q8CaYRT9wwgNTH886utqB7+
	 +5A0hcKBcSth4bkUvVMvpFOpIAWk50wiR4ogdd3FTj6bI4TTEkqU8u0tekpwzTpIgA6f+
	 IYF5sR+XW96L1avCD/TVJbq1dL6QznmpxwUZXf91kR/6g41hS4aAwWZnZMNvowv2l/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794554014;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Y8X6m4tWXaa4oZJYkUo617Lzu9DQ1eD1kEHbaY9831M=;
	b=NWI+79KVCEpEjVB2IW2ZYBxYoWkW6MRxWwqwsICt2E+v//bw4pN/eY40lJnsjq45aEEH
	 NeI34bGPSYLwAI4GCZ/C19krEMSaJs0w7HJA4cOpNqbJHkjul8+aisoyI3sQuhXjf+BBz
	 iEJS2WgZchSXKUfKbv8PpqY+70hIFsHJZSixThWa4le81fTr86jYlOpGdLdvT1MYtWSj0
	 9P5lCMBHd0+7bo/pSmxgOFaY/17CHuks9AUipinxO6XbLwjKPh+719aYOIQSfzkyie/a3
	 iEpRnrhpgS+wVTIMmm9R6hKjWS92rf7oE4W4rca2DKHiVo6OjehZI2NWErmh5dMYSzA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=FLYXmSrU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D12060A5BD2;
	Fri, 13 Nov 2026 07:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D12060A5BD2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=FLYXmSrU
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2E75020581F;
	Fri, 13 Nov 2026 08:13:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794554008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8X6m4tWXaa4oZJYkUo617Lzu9DQ1eD1kEHbaY9831M=;
	b=FLYXmSrUeFnXbGggIJAlAhRJfKuhD335b2o7GfRVPZrGnY4oxrCeLq3Giz8ztIlEkVOvrm
	zOv1MyiL7BAsfSHX5kvLfCnNx44YJM8uIJJKgnmikr64Wb+bKlGP0y3TE1HEJHiVMvvdfZ
	Ax7YVNZx5EBWIT/SGZFs2eM8//0+RD0yssYpTRwlCqlQYEQUcZ13tlFELb4tNT77rV+kJ+
	EaqcxyiJJO8eezjnX/ia+qjF3rlgsrn5sqpoVmu6OFrosWvTqLt7vSfSftvquhTiAQa1YG
	IZhJY8uKAcrAr5BuOgDv0NydyzMmEGHdAybX4DDvJJ3sJkP5QyiUaLW5oHSRLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794554008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8X6m4tWXaa4oZJYkUo617Lzu9DQ1eD1kEHbaY9831M=;
	b=Q0xjo/V32aMrEX/svMgYxdWgPJ8dBeD9NyGDihyx3Tfz80qdQMGP+0IPx245J2GCOzDPYz
	jcTCOEKmksnR7u4Os7djUxhHPw3X83p2wwH4Qs7C9M1xh0oJaDJFuVhfbqMifhf6jVC9IH
	ljWMGFQTM44fYrpT85eDFCJaJoLQ4F5tk7xPkVJh7Tf0nJMwn5Q0K6gxlajAhGAUYZJEWO
	VsqsXgLutSuTLPAlfHjrpoPA1ltgtkmKMYju1rwxEs+GOw4K7VJGfJbgsaJfSdK6u8bGCn
	XYcrZrb1YOESAf4/tEUCSCSSx9rWFf9Kwpb3oNftlw2HlVewcctXwq4/+9zr5A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794554008; a=rsa-sha256;
	cv=none;
	b=QZJvOgjX4Q958kYyz4nh4CGb+IP+jhZHfDG4cqfBC8yIJvKFdjUEmGlAr4VPU0cC8q2UNk
	6UmpMmg5xRVT07/5d77kYa8rNoycu8mkgueH1QnrqKJr8Vz0lFHGYhw6TSS9CXZr3tnl/X
	QbReMIrGFVot7/BtEdcPNJXs8Vq6yjMcKZe8gMvzEPvWxnQQ5AE77WsHfz1e53K6yyEg/a
	BTq+1Bh07JZy6bbWnvYN/lrukrOzeaoy+VEePb3QEblEnSz3o+i0mmNW7c3gv7SGQyXPYA
	xNKsj+K9lrMlOlz/3aex8c/PSNYQ6YA/wbXabve1P7RlBK5DDyup3tLDY0Xl6A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xRlTU-003xHu-0B;
	Fri, 13 Nov 2026 08:13:28 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C19285EA57A;
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
Subject: [PATCH net-next 5/7] dt-bindings: net: can: fsl,mpc5xxx-mscan: Convert to DT schema
Date: Fri, 13 Nov 2026 08:08:53 +0100
Message-ID: <20261113071325.4092169-6-mkl@pengutronix.de>
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

Convert the Freescale MPC5xxx MSCAN binding from free-form text to DT
schema.

The original text documents fsl,mpc5200-mscan and fsl,mpc5121-mscan in two
separate sections. Keep that split: fsl,mscan-clock-source takes "ip" or
"ref" on fsl,mpc5200-mscan, and "ip", "ref" or "sys" on fsl,mpc5121-mscan.

Add fsl,mpc5200b-mscan as a fallback of fsl,mpc5200-mscan. mpc5200b.dtsi
uses it.

Document clocks and clock-names, which the original text does not describe.
fsl,mpc5121-mscan requires the "ipg", "ips", "sys", "ref" and "mclk"
clocks in that order, as mpc5121.dtsi supplies them. MPC5200 does not use
DT clocks; it takes its frequency from the CDM block.

fsl,mscan-clock-divider divides the selected clock, so value 0 cannot be
used.

Keep the note that the MPC5121 Rev. 1 processor is not supported.

Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://patch.msgid.link/20260922102258.138753-4-quchaosheng000406@163.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../bindings/net/can/fsl,mpc5xxx-mscan.yaml   | 109 ++++++++++++++++++
 .../bindings/net/can/mpc5xxx-mscan.txt        |  53 ---------
 2 files changed, 109 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/mpc5xxx-mscan.txt

diff --git a/Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml b/Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml
new file mode 100644
index 000000000000..77aa46fd62ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/fsl,mpc5xxx-mscan.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale MPC5xxx MSCAN controller
+
+maintainers:
+  - Marc Kleine-Budde <mkl@pengutronix.de>
+
+description:
+  The MSCAN controller found on the Freescale MPC5200 and MPC5121 SoCs. The
+  MPC5121 Rev. 1 processor is not supported.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,mpc5200b-mscan
+          - const: fsl,mpc5200-mscan
+      - enum:
+          - fsl,mpc5200-mscan
+          - fsl,mpc5121-mscan
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description:
+      Clocks feeding the controller. fsl,mpc5200-mscan takes its frequency
+      from the CDM block and does not use DT clocks.
+    minItems: 5
+    maxItems: 5
+
+  clock-names:
+    items:
+      - const: ipg
+      - const: ips
+      - const: sys
+      - const: ref
+      - const: mclk
+
+  fsl,mscan-clock-source:
+    description:
+      Clock source used for the controller. When the property is not present,
+      fsl,mpc5200-mscan uses the reference clock, while fsl,mpc5121-mscan
+      selects an optimal clock source and frequency based on the system clock
+      and uses the reference clock when that is not possible.
+    enum: [ip, ref, sys]
+
+  fsl,mscan-clock-divider:
+    description: Additional clock divider for the reference and system clocks.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    default: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - $ref: can-controller.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,mpc5200-mscan
+    then:
+      properties:
+        fsl,mscan-clock-source:
+          enum: [ip, ref]
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,mpc5121-mscan
+    then:
+      required:
+        - clocks
+        - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mpc512x-clock.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    can@1300 {
+        compatible = "fsl,mpc5121-mscan";
+        reg = <0x1300 0x80>;
+        interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+        interrupt-parent = <&ipic>;
+        clocks = <&clks MPC512x_CLK_BDLC>, <&clks MPC512x_CLK_IPS>,
+                 <&clks MPC512x_CLK_SYS>, <&clks MPC512x_CLK_REF>,
+                 <&clks MPC512x_CLK_MSCAN0_MCLK>;
+        clock-names = "ipg", "ips", "sys", "ref", "mclk";
+        fsl,mscan-clock-source = "ref";
+        fsl,mscan-clock-divider = <3>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/net/can/mpc5xxx-mscan.txt b/Documentation/devicetree/bindings/net/can/mpc5xxx-mscan.txt
deleted file mode 100644
index 2fa4fcd38fd6..000000000000
--- a/Documentation/devicetree/bindings/net/can/mpc5xxx-mscan.txt
+++ /dev/null
@@ -1,53 +0,0 @@
-CAN Device Tree Bindings
-------------------------
-
-(c) 2006-2009 Secret Lab Technologies Ltd
-Grant Likely <grant.likely@secretlab.ca>
-
-fsl,mpc5200-mscan nodes
------------------------
-In addition to the required compatible-, reg- and interrupt-properties, you can
-also specify which clock source shall be used for the controller:
-
-- fsl,mscan-clock-source : a string describing the clock source. Valid values
-			   are:	"ip" for ip bus clock
-				 "ref" for reference clock (XTAL)
-			   "ref" is default in case this property is not
-			   present.
-
-fsl,mpc5121-mscan nodes
------------------------
-In addition to the required compatible-, reg- and interrupt-properties, you can
-also specify which clock source and divider shall be used for the controller:
-
-- fsl,mscan-clock-source : a string describing the clock source. Valid values
-			   are:	"ip" for ip bus clock
-				"ref" for reference clock
-				"sys" for system clock
-			   If this property is not present, an optimal CAN
-			   clock source and frequency based on the system
-			   clock will be selected. If this is not possible,
-			   the reference clock will be used.
-
-- fsl,mscan-clock-divider: for the reference and system clock, an additional
-			   clock divider can be specified. By default, a
-			   value of 1 is used.
-
-Note that the MPC5121 Rev. 1 processor is not supported.
-
-Examples:
-	can@1300 {
-		compatible = "fsl,mpc5121-mscan";
-		interrupts = <12 0x8>;
-		interrupt-parent = <&ipic>;
-		reg = <0x1300 0x80>;
-	};
-
-	can@1380 {
-		compatible = "fsl,mpc5121-mscan";
-		interrupts = <13 0x8>;
-		interrupt-parent = <&ipic>;
-		reg = <0x1380 0x80>;
-		fsl,mscan-clock-source = "ref";
-		fsl,mscan-clock-divider = <3>;
-	};
-- 
2.53.0

