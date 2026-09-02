Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D164A2059;
	Wed,  2 Sep 2026 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358557; cv=none; b=KtfirX+IrM9iJxSAKcqIb+pqlUha1HJn/hhyFqgTAmmlP5HY67oFjnjhn0j29gLTydktwobt2tCt/vcFGoPiTg0R0LLE/3fnAXnJep5AwOcRwsCH1fnA/AO9B5hFqCHZA69bE5QE3qhota6UhevWzathVZqg3oMAqjyOT5srcJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358557; c=relaxed/simple;
	bh=8arOEbtJu5ORo5zQIIDaftBo1oaLkMB3HysazdGv5Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BvxJC/ypM6keNJ3EYHkYjw54CSs9hNus7AhCXE/dG6hVsJgE3VQ+CXo3gEk2BAP0rc05ZFpl/hMAuW3GBxql71tzFmAZzqGtAS4ACNXr9CsVVviKz99H8zF8BFTn7u6dgMpMwYSgs5Av9UNy+ZnwEmSlO072CipKGaS+NPbmBGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112811F000E9;
	Wed,  2 Sep 2026 14:15:51 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
To: mkl@pengutronix.de,
	mailhol@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com,
	fabrizio.castro.jz@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 1/7] dt-bindings: can: renesas,rcar-canfd: Document RZ/G3S SoC
Date: Wed,  2 Sep 2026 17:15:38 +0300
Message-ID: <20260902141544.565763-2-claudiu.beznea+renesas@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev>
References: <20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev>
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
---

Changes in v4:
- collected tags

Changes in v3:
- updated the patch description to reflect RZ/G3S has 256 acceptance
  filters and RZ/G3E has 768 acceptance filters
- kept compatibles alphanumerically sorted

Changes in v2:
- forbid renesas,no-can-fd and renesas,fd-only since the IP supports
  only CAN-FD; for this didn't collect Biju's tag

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
2.43.0

