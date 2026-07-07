Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E023DF019;
	Tue,  7 Jul 2026 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419875; cv=none; b=akdS6Ql8puv04dmXIDBZWMj8FVOUUeDGxZKCL5YJ+27StxFrwSDOSGFKye7BxICcD0vE9STgDAPfz8Go69MV+Gx0H0tyq2iVozfMjtNbJEnfxxNS8n9mtuO8rNqRGTCSqqyT8QiOnFEyTSDRHWT4hlZ5e02w7KUcoHiKqpZ4nXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419875; c=relaxed/simple;
	bh=LiCX5WnI83rFXZJZwi+zXy0vU6kT3GpPeeQkoAZLXfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4ITs1ZkG7JzzYJQlk6wnCiKSOM+L7VWGIS6+gqtacZxR73hiP1yYMxakjT4cemFB3Qmz4dubTDaSEAuwAff5EgmvI4hGfwyMNfLufMRRqFbi4+RPabeRMMzJ+7n5ZeuT4WFYMquMBl/RjiD0AH6bRDd4w0ybALXTDKZURj5thE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6797D1F000E9;
	Tue,  7 Jul 2026 10:24:30 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
To: mkl@pengutronix.de,
	mailhol@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	bmasney@redhat.com,
	biju.das.jz@bp.renesas.com,
	tu.nguyen.xg@renesas.com,
	fabrizio.castro.jz@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 2/8] dt-bindings: can: renesas,rcar-canfd: Document RZ/G3S SoC
Date: Tue,  7 Jul 2026 13:24:12 +0300
Message-ID: <20260707102418.1646159-3-claudiu.beznea+renesas@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707102418.1646159-1-claudiu.beznea+renesas@tuxon.dev>
References: <20260707102418.1646159-1-claudiu.beznea+renesas@tuxon.dev>
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
- the RZ/G3S provides 128 acceptance filters, compared to 64 on the
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

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../bindings/net/can/renesas,rcar-canfd.yaml    | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index b9d9dd7a7967..f8b4d3dd54af 100644
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
@@ -267,6 +267,7 @@ allOf:
           contains:
             enum:
               - renesas,r9a09g077-canfd
+              - renesas,r9a08g045-canfd
               - renesas,rcar-gen3-canfd
               - renesas,rzg2l-canfd
     then:
@@ -330,6 +331,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - renesas,r9a08g045-canfd
               - renesas,r9a09g047-canfd
               - renesas,rzg2l-canfd
     then:
@@ -350,6 +352,17 @@ allOf:
       properties:
         reset-names: false
 
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              const: renesas,r9a08g045-canfd
+    then:
+      required:
+        - assigned-clocks
+        - assigned-clock-rates
+
 unevaluatedProperties: false
 
 examples:
-- 
2.43.0

