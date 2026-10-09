Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EEE4E2F2F;
	Fri,  9 Oct 2026 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553419; cv=pass; b=Ab2BsvWjiv1StI+wyc24vSiwNoUaLyx2V/4T04qqtoFK5m7JKRI7q1wZHouUx7wLFB6GUo9Q/XizZPY6z7az7WBuZBIGPwBs1+MnjIHXMilBjqGbQhHRwhT13RQP94mjp0uEHRy58ZixIYasodomsdJPHS4MQKdIi44t0E6YiKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553419; c=relaxed/simple;
	bh=ph1yhgKmMs07jPx/aKo8aSzP5TqmgDyOVWjpnp8k3Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcsP7u4YwJ43X/Z6T7iaMAWB3Q/Qo8UFgaAhri/WshY+1olD7mqcV1lP1ecAnS3X0GSnTedM+hGWJemZNm94EGZv60srCIEuSaz6cinjjsGmsSn5uQ0GCZWZgGv6Nbr1NMTQuzGtGoRz3z5IGP98frud7gzXiEGMnspLnpG1lh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=CXSfts8g; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="CXSfts8g"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B104220261B;
	Fri, 09 Oct 2026 15:43:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=70FZAdqXRNeEEFdzAhRSGjcBRqa6k6oWcQHFeb6UwF4=;
	b=CXSfts8gvJi4Ma+0jwQ82AP0h+kVGEZrdyPGlrTlhCTen4lqURxLxaeAeIeeF7gmSUD7R4
	QWGejnyyTmcKjebXPOBQ18rISXvDQI5sU25FYv6Qq7275xCENIKt8eZOmoXz9Ay77tK+Cd
	gXQQxh2Rlbev90y6OJDp9IczTejiT4fCZ0FFxSz+GocFftz4tOmNq+9fY5V0kreKHgObaJ
	i7AnFdGsrhFqKnOYG+RcEykQOe8vSILZx5gUORDtq0fBVT22qw18aQB4Kob1fpL6eTOpUt
	TWHzaRa1V0TFDZxxp1pmA5CXdVGr1GLsOCxNULIO9Bn6ucrVvPKb7n1oMdHqug==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553413; a=rsa-sha256;
	cv=none;
	b=chvcziPmGPpp/dIDgbcZC93ERd46oQUfpduwh0YyFn2KJyLfRuHqOUS3iDZgMIoMRx5fjf
	hWGBHrLr2ewLbZPfYJAoFeAewxXCNcb+AW46yFJE/G4S4x/TXg5twb2Uomosob17jzXVyw
	xVTqn7QNRP481HaD+l5cTo+V91a/6z+LcVDE7l6udedD4mPFbeTGS4HWta4zNi1LjLovB7
	bghBvWWOhi4j/U4QcTEMxNsIbooLnK95z3sEwg71wTD7n8WgFJX958IKXDg2ckvIz/X59T
	rPTxiG/EReTBgyWkAkhttRY+QB+f2E2AvlDDRRNyzwAmeXQUf/s4vita2BoaVQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=70FZAdqXRNeEEFdzAhRSGjcBRqa6k6oWcQHFeb6UwF4=;
	b=Quj3Bld/b5LIZulW8R209K2L+b3ie1Sh1WMo6Tcnp7dDo8Ri51pJgv3CIqQs3roHPj2QAL
	NqQLnfmfuDSsHDZLVVg131iuaU/ZeEx20+g8slXtApTzM1QDqn9dCZKeshl7Y/eH3uNZH6
	AuEKegOKKu30A7C/F4gWwSX4ojzoI0gQocfgna75mXInutPcZEXJlExBeFXygyOHGIPBNH
	c/Ga4mNIZ9Sh8tGntYSzeQ0H9FoqmMAn1YbLH9wH2DgU/d/XitJ08CPre+/K6tzCgYPRfA
	oPD9P4CPFOW+RaAMv3mEzGMAUvL70NO7pkaVKTfuJfdTdJQOqt2UGH5Yv1JeJw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAsn-0053S0-21;
	Fri, 09 Oct 2026 15:43:33 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 341825BD8A8;
	Fri, 09 Oct 2026 13:43:33 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 08/37] dt-bindings: can: renesas,rcar-canfd: Document RZ/G3S SoC
Date: Fri,  9 Oct 2026 15:27:40 +0200
Message-ID: <20261009134323.64064-9-mkl@pengutronix.de>
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

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The CAN FD controller found on the Renesas RZ/G3S SoC is largely compatible
with the variant present on the RZ/G3E SoC. The main differences are:
- the RZ/G3S provides only two CAN FD channels
- the RZ/G3S supports only CAN FD operation; the Channel n CAN FD
  Configuration Register does not implement the bits used to select
  classical CAN-only mode (bit 30) or CAN FD-only mode (bit 28);
  consequently, bit 31 (CAN FD Frame Distinction Enable) of the same
  register is also not implemented
- some bits in several registers (mainly reserved or status bits) are
  read-write on the RZ/G3S but read-only on the RZ/G3E; their behavior is
  otherwise identical: the bits read back as 0 on both SoCs and software
  is allowed to write only 0 to them on the RZ/G3S
- the RZ/G3S provides 256 acceptance filters, compared to 768 on the
  RZ/G3E
- the RZ/G3S can use PCLK clock as the CAN FD clock source through an
  internal clock divider, while also supporting an external CAN FD clock
  source

Since:
- the SoC clock generator provides to the CAN IP only the peripheral and
  the RAM clocks
- when sourced from the peripheral clock, the CAN-FD clock is obtained
  inside the IP itself by dividing the peripheral clock
- the assigned-clocks and assigned-clock-rates properties are specific to
  the CAN-FD clock
the assigned-clocks and assigned-clock-rates properties were dropped from
the required properties list of the Renesas RZ/G3S SoC.

Add documentation for the Renesas RZ/G3S SoC.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260902141544.565763-2-claudiu.beznea+renesas@tuxon.dev
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../bindings/net/can/renesas,rcar-canfd.yaml  | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index b9d9dd7a7967..bbaaef8f4282 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -13,6 +13,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - renesas,r9a08g045-canfd        # RZ/G3S
           - renesas,r9a09g047-canfd        # RZ/G3E
           - renesas,r9a09g077-canfd        # RZ/T2H
 
@@ -185,8 +186,6 @@ required:
   - clocks
   - clock-names
   - power-domains
-  - assigned-clocks
-  - assigned-clock-rates
   - channel0
   - channel1
 
@@ -198,6 +197,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - renesas,r9a08g045-canfd
               - renesas,rzg2l-canfd
     then:
       properties:
@@ -266,6 +266,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - renesas,r9a08g045-canfd
               - renesas,r9a09g077-canfd
               - renesas,rcar-gen3-canfd
               - renesas,rzg2l-canfd
@@ -330,6 +331,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - renesas,r9a08g045-canfd
               - renesas,r9a09g047-canfd
               - renesas,rzg2l-canfd
     then:
@@ -350,6 +352,20 @@ allOf:
       properties:
         reset-names: false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a08g045-canfd
+    then:
+      properties:
+        renesas,no-can-fd: false
+        renesas,fd-only: false
+    else:
+      required:
+        - assigned-clocks
+        - assigned-clock-rates
+
 unevaluatedProperties: false
 
 examples:
-- 
2.53.0

