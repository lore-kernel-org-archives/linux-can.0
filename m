Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EAE2931F0;
	Thu, 17 Sep 2026 01:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789607360; cv=none; b=T1xK033OSkBsBcKwkVnDyYHj4mBQcR9D/DppueZ5x8g9BugxaLduHkQERZn8fbe3tmqyg+Tx+tdQ9Ewgku3rchR+Jp+XJ+NJnS2oS+aDUIdxn4Q5mxk0OpQyex9REUssJwve1yn3ELFNaLHem6dIdh9iNS/Soiz3Uj9/8bbcGoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789607360; c=relaxed/simple;
	bh=pl/sZwHSPApHN6Mtl2hmxPY7tvECTi3TjQoBRUSNchc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j/Ki1MSBaBtJK8ILtrutNQ4MSTn8mdlws7Dr2gterHie5zfsQOXqPgzj5tyBUnVykuxwMSdrMebfDe4z0QtY6vFHaAH7vzOssd956+v1QyyYQ0dzxN58QbBpCaLlFY6DkAnUT33VWcPFMRu42nLhyua6iDCTCNijZUDuAZk6IaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=aA4ulpEh; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="aA4ulpEh"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4CB6B1048BF;
	Thu, 17 Sep 2026 03:09:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1789607356; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=EFBAMUYhNqsEXyNj1QKJ+yEEORLKuLw+kO8xyQijSe8=;
	b=aA4ulpEhCaqBf84yjv3GLms6m86qq4cYcg9mObAbXX2en3RFeO9YdIOGs27VZ9i33wBumM
	kjSTi+vvfz+3XO5Lm7UfKstbQCSpEojClKgcTnpaPMtMOOQoqjKrO6XSsIUs+koNPHbxEL
	B5P5qTlTQFabQJF0G/ljWJhrlIwPhUqkcOhIBjXR5SDw3EzlgDgJMJUc4ZLRj17DNfKdc1
	86wBwmmcKNlVgRQiA0HG84o6V4DyyfcyzGQw/9fgbxE8NccNLNgpCsbInDRHqQqO3mGcPc
	uyM8IH2sFWffLJn3VcW/uKE/lXc/cV15zE8G5JLc3vBnSPwhn/p6BitXdopREw==
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
Subject: [PATCH 1/3] dt-bindings: phy: ti,tcan104x-can: Document Microchip ATA6563
Date: Thu, 17 Sep 2026 03:08:22 +0200
Message-ID: <20260917010906.424049-1-marex@nabladev.com>
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

