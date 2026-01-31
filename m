Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D0832D0FC
	for <linux-can@vger.kernel.org>; Sat, 31 Jan 2026 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769854533; cv=none; b=VqsKWN6Hktg0LSoEK1Kk265qgMr5YB3EnplUqoYQuAx79PtB49bPmnpE8P82UOXztymTWID2wSY2jy/4YVdbGUxRvTf5GCobh1MeUpjPOxQhAyOZhbJ0uhrYu9JrFfgz1GqHoKWVTQ/ruMVltKry6bRHx2Pug8/hICL722yl8f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769854533; c=relaxed/simple;
	bh=Pv7FzXpVDx9gHR7Si8Uc0U+iuhz+uKGY48wu3S3tUuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oh2WOP4XpXvWVe/zohr9kr8vNR0qklShDA97/kSPTEDg8ZUukaunsym4qXoJPgJZCnNzY1igieDr+k05pXbd9FjCdarwNVNqigk0jx8gqqegl+Mbn7g8XXSZm02g3aHe149XgeP94oiLk+2fIu2qepUGywLS8P0GmWjTMfiXB/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vm80c-0002Pz-Fb; Sat, 31 Jan 2026 11:15:18 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vm80b-003OWH-37;
	Sat, 31 Jan 2026 11:15:17 +0100
Received: from blackshift.org (unknown [IPv6:2001:67c:1810:f051:d04a:1c63:e2:421c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C106C4DC56C;
	Sat, 31 Jan 2026 10:15:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 1/8] dt-bindings: can: renesas,rcar-canfd: Document renesas,fd-only property
Date: Sat, 31 Jan 2026 11:11:42 +0100
Message-ID: <20260131101512.1958907-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260131101512.1958907-1-mkl@pengutronix.de>
References: <20260131101512.1958907-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Biju Das <biju.das.jz@bp.renesas.com>

The CANFD on RZ/{G2L,G3E} and R-Car Gen4 support 3 modes FD-Only mode,
Classical CAN mode and CAN-FD mode. In FD-Only mode, communication in
Classical CAN frame format is disabled. Document renesas,fd-only to handle
this mode. As these SoCs support 3 modes, update the description of
renesas,no-can-fd property and disallow it for R-Car Gen3.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Link: https://patch.msgid.link/20251126155911.320563-2-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../bindings/net/can/renesas,rcar-canfd.yaml  | 38 +++++++++++++++++--
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index f4ac21c68427..e129bdceef84 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -125,9 +125,17 @@ properties:
   renesas,no-can-fd:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-      The controller can operate in either CAN FD only mode (default) or
-      Classical CAN only mode.  The mode is global to all channels.
-      Specify this property to put the controller in Classical CAN only mode.
+      The controller can operate in either CAN-FD mode (default) or FD-Only
+      mode (RZ/{G2L,G3E} and R-Car Gen4) or Classical CAN mode. Specify this
+      property to put the controller in Classical CAN mode.
+
+  renesas,fd-only:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The CANFD on RZ/{G2L,G3E} and R-Car Gen4 SoCs support 3 modes FD-Only
+      mode, Classical CAN mode and CAN-FD mode (default). In FD-Only mode,
+      communication in Classical CAN frame format is disabled. Specify this
+      property to put the controller in FD-Only mode.
 
   assigned-clocks:
     description:
@@ -267,6 +275,30 @@ allOf:
       patternProperties:
         "^channel[6-7]$": false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,rcar-gen3-canfd
+    then:
+      properties:
+        renesas,fd-only: false
+
+  - if:
+      required:
+        - renesas,no-can-fd
+    then:
+      properties:
+        renesas,fd-only: false
+
+  - if:
+      required:
+        - renesas,fd-only
+    then:
+      properties:
+        renesas,no-can-fd: false
+
 unevaluatedProperties: false
 
 examples:

base-commit: 74ecff77dace0f9aead6aac852b57af5d4ad3b85
-- 
2.51.0

