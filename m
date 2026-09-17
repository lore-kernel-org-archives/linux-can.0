Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADB9282F1C;
	Thu, 17 Sep 2026 01:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789609404; cv=none; b=qdk3dgdchxGYmXIq3LDj94jeU07VXGjDhxU5Ra++cBxq8cUYONa9YXt/wPv6kQEh2Ko+V8MtO9QcszkuiJFSj7H9eTYSRXLbg6mJ7kLeGBy2lSosE3dcmtmnWPXzFU6NBSPCRkjw8VAtXN6MlemrmKQjbeX0iZ3f+GyFr7FY6ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789609404; c=relaxed/simple;
	bh=B616m/acueXMNlbTtolCo+62AiEPz8ID80bbJXumNF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xv94mWYHQ5uzp01xI3s83WMFFwVFEwYya9QXzc7AzJ+rToWWTg1X9Z8MoJUPe6ZQ+zFvQozevwkH2idpbl9MA5kGVy0ruK87cVGUIuOmQ1Cvs+H1oROPepnNl7KCfMWtmMjK8jCeUdaqOi7e+UX3FqKEDj2Bm73ePKowzDD6rUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=h1Qe/9P7; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="h1Qe/9P7"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CA187101B3A;
	Thu, 17 Sep 2026 03:43:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1789609400; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=l11dzaGJa/3l8/IgdpLrw+5Ip4TCD8Y34A7puwW47Xw=;
	b=h1Qe/9P7o7a9jSJFv8iJR6QD/Ow31YTgUjo3/AbQn/SVbojOM74PZpyklM/E91KCypmSiT
	nE2+GKZUgKJDzSuFfu5NxhayqdkuaLbYF1BQp8lZ1EjJDlyewEwPww8iaccus+D+mY6eoX
	CE2kEIOTRWQJuuhodbYiKGdSE/Kq1cDv6rs2NNea6EShInKdRCXM4Wd1P/fXYbxoJ13ZCK
	HdlWeQzgNUucmapjr/uN3dBx0NP97HzScmco5Mz2bT9oqYLHX6F866RLLecvV4osnsMw38
	DJks6/qeuIiDeBRXd1/D4v7y/WX4VevlXtaBg5dBSyAMieEfI60p8h47lmcpAw==
From: Marek Vasut <marex@nabladev.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marex@nabladev.com>,
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
Subject: [PATCH v2 1/3] dt-bindings: phy: ti,tcan104x-can: Document Microchip ATA6563
Date: Thu, 17 Sep 2026 03:43:02 +0200
Message-ID: <20260917014314.472079-1-marex@nabladev.com>
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
---
 Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
index 9f5c37ca6496a..75c276548e122 100644
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

