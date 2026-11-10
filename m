Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794311480;
	b=y+TrOx3zuTnkG+Ho9TpmUZfTyT3qL2W14LDfjT1svvf+tJeHn+xJhjBCb5GNTYS7FrIQ
	 MOmJuBU8hTtWEaUmmbfw0rnUlDV2NQUkSCli9FP4V7MYMgaHDaF8hzinG6RMEID0sp7Ed
	 cjLJpZrVPdcYGfIh+MkHhoSNwMDKLqw1xBE2ebxmhVUs1y7z/FXso9LFnL6f5GVHvbh8H
	 /E2ybvPZ8TSGCxqZIAYsNQXiWx2eu5hIFRRdTNyV6q3o+SpR1ONzmv2dy+LBjPurGmjiH
	 dVV8y4OTxCXlDAb6R1fk26Hw6zsIUg2fflrBdRQc1SDqWLu2GkpPaVyhI82PRfeWf1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311480;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FEKTN6XV66BfegAo6Vlzm1WyDNpeOkzG7P67Pe2ltdI=;
	b=NaTpg5wsJJS4/D+MBnvg9uQY3hTV6Aw0T4nxBb3XJZeP5JPoYnUU4eUN+NOWB9vlgfyb
	 Whkn1Juh6AOAKH/a4O4T9OBf8Jk7Xj1xlyMEcI7QSDSJPD/l4O1PMvmvPRGbPS+Lbh4cd
	 U3M7ws5hKZ2Y7cmnOGlmpUjzeowhbZ85pm4RThah/UqgMooGRjtsA8wwYqJW5njWFP6r7
	 Tlt8ti0oSHz0JknNTXw2mOAXoI4dEL+/6oQvBn5SUXfxDZtZg0vkhPCJS6FEPili+sKfA
	 OyvzPm0T5vdR5axOqqtE2fVPwdcNbi28uAC7djhNGUUMlUA4Rv0Dvmrp6skAmE8o9nQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=GeRETIZC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7C0606A33B;
	Tue, 10 Nov 2026 11:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F7C0606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=GeRETIZC
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id AF201201BFB;
	Tue, 10 Nov 2026 12:51:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794311476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FEKTN6XV66BfegAo6Vlzm1WyDNpeOkzG7P67Pe2ltdI=;
	b=GeRETIZCb872PW+mXLoxHRYYPdymZ1T03sQYYhGf39mtFpqIvYn6Jq50/qLb6BlLZXGSjg
	zi7LdrKNIdODDSIbDxh9vnc12qepf2MR8I7gywVw3PucGKy8ifkMNwMCcyLN75BU7l2zfs
	fj+W2rCusM50dWPeYOtQK3KouZme8Sx1jO37QfRZILy+PVQADOKsRNwSnMRw8lLGMYryZB
	Cy3DEzxBvkEr9QzEO8JwWQtnDuK6JKenzri+pnzLdqNrriw8XFThTq+zG6S7+zZIYs29pP
	qKu/Ohq+KsZABJniRJipg43+hycjtl9ngnjVaTZGoKDCvW7TarTLOvwN8K8y+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794311476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FEKTN6XV66BfegAo6Vlzm1WyDNpeOkzG7P67Pe2ltdI=;
	b=L/sAWmjfPewN+QArfZYTCFzkmFWKJNa+MoTcQdqahEyrg/BrqAyHZr0wH2+OKJrkWwzH8m
	f6PC8vMzcY9iMgTbaxMC51CASGf1nKOg8BmH9gO9QgRWvEcooMq+I0Rf2zK3WU3ah1A431
	PM5eBjlUiYqVtzruJReoDBBqVKAHkw9Lb1uN0pa6iOUgX8rQeh3WNhkzen6EzaF4vaLckI
	DyXCAIcdRlmRqymb953SPnzIAEwk4xPln67sCQIeksFVVoxSo+qYnTVSOHBiVc9RZ83sQC
	7+fSqFu0EdKIP5Zd0oySnXUtaTRcKkoPqCQck8A5ouoqeaPwS9zBy0u6hs0YHw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794311476; a=rsa-sha256;
	cv=none;
	b=KcuC7nYpr0zw58g7wUavg8F3uGXdqU9upp0H8debSRKjCGaMGuWyicIxZz/LHuAwZd5jA5
	EH5GsKKqzyTYNJAU2uzl25z5HniIgOdah4Ko72nnX6tpNkD5b9sl2Wsi8gnspbeEwTutEQ
	NGbPSS34gN0D/Sjwx+PnBPbgG2qZZeB2lroog+JZjO1LUZ1LfGh5nAadal1bMIHAnqS8ND
	o2apGMuwbOUY0998pU4cbAoBilDA4j11SDHIRlX/ZtQCOJql94Y8OGPWvt50EKCMZ+b6yk
	lAkhPikMubhUvIt8OaK+hVvZsigMLtUzaMquQdBu4HNly3VEyvy5yjdf1VwPzg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xQkNg-003UEn-1y;
	Tue, 10 Nov 2026 12:51:16 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 563B45E688A;
	Tue, 10 Nov 2026 11:51:16 +0000 (UTC)
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
Subject: [PATCH net-next 01/12] dt-bindings: can: renesas,rcar-canfd: Document RZ/G3S SoC
Date: Tue, 10 Nov 2026 12:41:24 +0100
Message-ID: <20261110115112.3807247-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110115112.3807247-1-mkl@pengutronix.de>
References: <20261110115112.3807247-1-mkl@pengutronix.de>
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

base-commit: d26955e57475434b59d43ba372b2a50d33d5e0ed
-- 
2.53.0

