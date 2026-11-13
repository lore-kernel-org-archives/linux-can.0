Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794554011;
	b=Yy1afBF+KrIig7I5ZXLqo8fGI9H521I0b7IcWUPcVYxvEUgmQVpZ5DwGXM1mDUQR3ZmE
	 po6w/mdg+QMTsyunYawNoHfIH79K44Ql5XcFg3nqExRufuDBWGRXaXPmQO5XBaUlAAI2z
	 ng8OvGv8vvknGh5kL7kDqOGu394zVDYFxnz6nFCUP3eZRZPLMSfjG8d902Jzex5k9N60g
	 DenflpSfRssM8iQKXjFnCtgKfpueficrYHeaiS9S74HNQScicP0zQM3m/HszH+gozjBrh
	 ljYT0xnV1UvMl3YI/80mMD3uht4KDdy8Ig8N8XrXm1cmFupcw3Q4WHuuSwrH15WAoXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794554011;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZUGr/irCljBtKt5MymL+Zhww0DeYa1tlokKKdxZvsG4=;
	b=Mt3w51MHab6zy+tKXlmwyVmrKLZMtZ67Q91rxkVkaq+nOZwG7vnNpNlMEU8ez8JW8BWs
	 gNaqpIFCpNxiuBLzkc582XgAxKf+UZgRES35by1dKgeHYyn5qlzNhs684uFk6DuEljNit
	 BvgZAUp48C9DI80+7v+H55fJ5lagxuI3rHlf5Az4l6iQH9TWRhqWpRkw/Kn1k1lv6F3qf
	 tHCAznFnj39zssqTzL3xRjWEo/5JmOQfs8/Gbs5j58TxnDUDfNwEx6Q3uti1G2599yXqR
	 74VnPOwmIqn03JMp03ef0Aq8BkZ/69jf/z8BRGeFpqx09bSawcN+MqeVysrB4zaW4SQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=fJj0pE+Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46872606A8A3;
	Fri, 13 Nov 2026 07:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46872606A8A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=fJj0pE+Z
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id EBF06202266;
	Fri, 13 Nov 2026 08:13:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794554007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUGr/irCljBtKt5MymL+Zhww0DeYa1tlokKKdxZvsG4=;
	b=fJj0pE+Z8l+fnR4FeJzRC7SbXFYdH12P6kteEPPMEvlcAJ4O2zEAn9HjXy72AXrw3bDFZ9
	CIoomXBqj5BF8sStCCHKWMGIfX+J5KpImTS5swN5tKr9M4e8Uv2gvYQa2lAIDmjB/pC/Fq
	y5tWq+7Sh5+tGYFNIp4r5fA0jhtHZvUdQT+yhhzPC0lo5tBEAWeF0AFuus2h8yy2ii/koF
	KK+ZABd0dINugv/6z4sx7kSx1Wt9drfPV7KWipSVkGOprPNR7OfRZAPGIjliQO5H02XgH3
	eymHdNh5TmNu954KTDwDfvhyrhVil9fgj5hgZcn9guRt/rE68JBfZ2UgVoMYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794554007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUGr/irCljBtKt5MymL+Zhww0DeYa1tlokKKdxZvsG4=;
	b=R8XgiACkCawrGpjWLlhPLgboxwSSRG4jXLaLupvJ5njIuQhaejUcMUwc9gsNmiiZLfm9S3
	4Gc39LXzndu3vGhSOqQZNe9AITbL6QdlWgXW/q0ZUEwkulbcjLiLAc0MDcSxrvpFyOZ7l8
	cqlCjAMl/CnDWKiqhj8/sgDJNFVv7G64PFO8bUgCYG+SGMAJGcoSxBjXZC/C2j97UKmV5c
	H+Or5C7311q8Eh1B/qRIWztGGxmQcIEqiafmCyBtUdpCwBjcU4Sr/yGZ7mvpGf+h0XgcOy
	5LQNhMOp0jQqfS2vickJK7jhyxCcT8Qm9yjl/C5KLUwXGAYZ/ufC8C/CovjgFA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794554007; a=rsa-sha256;
	cv=none;
	b=DeomQzn86wOnmlhVMtuz0jTdQMBUjk+Wqu98YK50XnEhkdV3K/fM0X2c+ZdJe/0VcnoGm8
	yBZsLMiW2Tj78+2vZSJHGJd7juXYKR1Grw1k7CFjtZ4K51tBdij8SwpCFvE7GPtXAQosji
	yQtdJSUJnlh6PmeKxUqMDbqG3WmmV6597gCtKiuVCW3K//+NTEEEw2TjZcTNzuKkmu+c9G
	mpfy2X6S4yYPpismOhIRldTwn3RqxtjBGYtvPM8BK0kmpKDJUbGMCn4fJGQld7sf4DYepz
	PE+7K/CF6DnSbzggz6z757z3GCBNpNFXnkFjQdcIeJOcuoJa9lms/tqzTg1JZg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xRlTT-003xHo-2l;
	Fri, 13 Nov 2026 08:13:27 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 914885EA576;
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
Subject: [PATCH net-next 1/7] dt-bindings: net: can: ifi,canfd-1.0: Convert to DT schema
Date: Fri, 13 Nov 2026 08:08:49 +0100
Message-ID: <20261113071325.4092169-2-mkl@pengutronix.de>
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

Convert the IFI CAN-FD controller binding from free-form text to DT
schema.

Reference can-controller.yaml. interrupts is required: the driver obtains
it with platform_get_irq().

The example now uses the GIC and irq header defines instead of raw numbers.
The values are unchanged: GIC_SPI is 0, IRQ_TYPE_NONE is 0 and 1 is
IRQ_TYPE_EDGE_RISING. Rename the example node from canfd to can so that it
matches the $nodename pattern in can-controller.yaml.

Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://patch.msgid.link/20260922102258.138753-2-quchaosheng000406@163.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../bindings/net/can/ifi,canfd.yaml           | 46 +++++++++++++++++++
 .../devicetree/bindings/net/can/ifi_canfd.txt | 15 ------
 2 files changed, 46 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/ifi,canfd.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/ifi_canfd.txt

diff --git a/Documentation/devicetree/bindings/net/can/ifi,canfd.yaml b/Documentation/devicetree/bindings/net/can/ifi,canfd.yaml
new file mode 100644
index 000000000000..c8c3105c727b
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
+  - Marc Kleine-Budde <mkl@pengutronix.de>
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
index 20ea5c70ab82..000000000000
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

base-commit: 573af801552999954caa8347e4490b04cf4763f0
-- 
2.53.0

