Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E794736BCED;
	Thu, 15 Oct 2026 01:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029228; cv=pass; b=TEzpJBeqI6chh6li4HaEe4y8y3vSA2ckLQNNVbZ9UT+KDYNFLGEa7PTcXjCuu2QOh+IGpoyaGKKXdy18RshWGRtbF5Wh0MnrJFIj8EKqRorDULg5mvnsY40X7d9JS+pVb6l+qbPp6vAGh/KOX15v5doJJaq0QJ6zh0WzKJNuryQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029228; c=relaxed/simple;
	bh=ph1yhgKmMs07jPx/aKo8aSzP5TqmgDyOVWjpnp8k3Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jqh6HN3xyZEEDvHxxCAlj8jRNYYJ5UgFwqCBxdYzx8yp4TXsXOnbPfwIQY0swAkIYj+BPIXADzQY0r+0qmDqdOX11HIy/FSVIUHh46SW0YonvAaKlceuk53yq24QB9tW3ChRUo/D/8ibMka/CGnUSM9MudPyk5s+5FLio7VW8GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=PAlrvr/+; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="PAlrvr/+"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 6807C2027D0;
	Thu, 15 Oct 2026 03:53:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=70FZAdqXRNeEEFdzAhRSGjcBRqa6k6oWcQHFeb6UwF4=;
	b=PAlrvr/+AoJQw74iY9cmcUdkj3TFxDNQHVQR2YQRi3fK8uWCrKo30a9stRdmUkizKca7Hu
	F1dyW6z3cLwuqaKs2IsFSX2DedkXALSZxAslyzUIOlUcBfZfKvhWulm2ueD5mJgj/xTXIX
	ena4w0atB0CkRQksh/ZRJPl85HU2dVrJmjiw1Y/0vnZXcOMdCH3pSx8GLzhTcY9g+/Thwk
	UBRGHtf2d0vuZx580KfW9WB9pymf571d1IBv6MDK7p0rmoZoSrOVW/fdop5d6hjtdg7SSa
	0SaOkPhDgJlb8ttMleIM561Dl7UmJL137mluMh8lJ15BAEgXDAeknVuFeHufQA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792029220; a=rsa-sha256;
	cv=none;
	b=eVvCvB09alFi2LsITj2dy0Lpi10T6w7J/WrwHbH2AuKnW5Zl5t+etoEIvz3V1Gpxb2yxnc
	gPS1clqzdT6JB0Mn+s+wt2H0J0A4zO8T4jL4YrDUGoXoOulb1NspuQOfuvO1hmdMtseyi0
	3AQYKqmVOLVxPDXBfr3pvsHiRbTVBs0iSGYBHt0JDSUpLKvVxDlUtn8ilzmebEBvpfCiaG
	g+gKwRCH6gP7Yp7oJNUoPyHb55CYP6x2KOSP8rEy/Y/QXGPmT5SqXex0e9R5VQpv9rYyfV
	AlqnboBsNYhlOFVtfiH1AAoq+gYWo0NWTWgw25qY+V4W8IT5FRjTZIPRdFJmLw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=70FZAdqXRNeEEFdzAhRSGjcBRqa6k6oWcQHFeb6UwF4=;
	b=IWddu9VYfMStydDcR26shtg2TZu2nOc8N+u8G1ggLaLtepgUovaH3pfmJKaI+pD88kbqgH
	retcN1WBFT7yGoimqhLPF0SOhfUDlIO6+XpRQzoBSFXDI5NuXDlf7cV807uegXA8pXWIYY
	tdBcy6/l+sX9rDi+dEi8X1LHA4YGNOvWZJ1gmHliTje0lw40cehAn8axwRtfvISYl2p8qn
	TPtMLrGY2O5NRrbilb0LF/BTeYpVXTitE5FxOcDfWFkUgayqWx1ScdrdkRrnATllIYf9t1
	k3d//N30g6tGZTtmweX6s1DWRnr0ooZsR6nFx3rtyVhB8DAXF+cAk5lVx4pd/A==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAf6-005wqH-12;
	Thu, 15 Oct 2026 03:53:40 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 137665C477E;
	Thu, 15 Oct 2026 01:53:40 +0000 (UTC)
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
Subject: [PATCH net-next 11/37] dt-bindings: can: renesas,rcar-canfd: Document RZ/G3S SoC
Date: Thu, 15 Oct 2026 03:40:09 +0200
Message-ID: <20261015015336.816543-12-mkl@pengutronix.de>
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

