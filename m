Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A8034B40F;
	Mon, 28 Sep 2026 20:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790628479; cv=none; b=HlNxKWD2FUm7IVA8/gCexCvy0J6H49NHTwRJPxkv8GefMUisFyasbLauyIfeLNYkhv0xMfafTELN8VX2krqHmrSP97jUUDT0+FlvIRGdJ5uaXf1vnpuRflF6lG/jAm/N0zo8CY5VQeLagcN/H8v0F200VR8hTL92+HRRMxRuzLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790628479; c=relaxed/simple;
	bh=nSsc0ysVKWE6kQbj2zINX2hsqCbXiLLi8GhJXb1WLI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f9IdAOUaadWM1xiTAVGvZxENBVSMi9sS52J0vqLhs46OM31wTXiiyKdn39IxFJaz8oJz0ZXfkGQaaS4kAO4RyPgVKpKO7kZJlPJ2TF8Vyr4NpC3KnIZtQGt5srSCcu01qYHLQUMQG/GT36tLa8d4HhyeIaZOnu3kIqxB45HToJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=OJGltDvc; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="OJGltDvc"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7C769100222;
	Mon, 28 Sep 2026 22:47:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1790628471; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=2V/Nb1lTiKVYVfjos1Q8LNTtkvRDqqwW7qgRu5VAz2w=;
	b=OJGltDvcYmqE41XUtT4oU+05adcdXd4duTnvvmIqi27kwSAhC6e56jFnGFp6vNmKupqA62
	3cjC/k/tZSX4SC70Ej5JZe5KaBDDkHOjv5nIrfqzpOigVZE9tYB+ot5v8xo4hV7BAHhI1M
	XmiFnNDyXbvxzqLFIdm1LHXA/+v2T7u1uWexwexSj8EllMXlkOkVz53wsCHzzyGsUjSock
	YM/DwQjJVZJ7hyqNxPg6M1iFsP1ymf/Efuf/ZtG3Wkdn/OLRKv+WssfOdZuhj0hV4HN5hR
	+r4WVEGyXKgqktl7jKPBH/zk+8i46ERUiJcrGvkmQsUAtB47YDFiVPl048SQJg==
From: Marek Vasut <marex@nabladev.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marex@nabladev.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Aswath Govindraju <a-govindraju@ti.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] dt-bindings: phy: ti,tcan104x-can: Document Microchip ATA6563
Date: Mon, 28 Sep 2026 22:47:12 +0200
Message-ID: <20260928204741.175754-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Microchip ATA6563 is High-Speed CAN Transceiver with Standby Mode.
It is pin-compatible with TI TCAN1042 and has a compatible programming
model, therefore use ti,tcan1042 as fallback compatible.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Aswath Govindraju <a-govindraju@ti.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
V2: No change
V3: No change
V4: No change
V5: Add RB from Krzysztof
---
 Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
index 0cf5fa21106b6..e97b1bc0a2e45 100644
--- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
@@ -18,6 +18,7 @@ properties:
       - items:
           - enum:
               - microchip,ata6561
+              - microchip,ata6563
               - ti,tcan1051
           - const: ti,tcan1042
       - items:
-- 
2.53.0

