Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC78C46D56E;
	Mon, 28 Sep 2026 20:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790628484; cv=none; b=pk+njUDHhwpnB/3gZptzMfHgOQd6H+R+8wCCVSvuzvw+ZO+ZZr3dVAbTcxdTtu4HxB8PS45vLNhdrVLCSHoxGSNIy28gbdjbkph6dj5Bs72BE30MYA9hL+VPmOmaO2RDuxhBZUt6KbmavWJZJTdJzbF0cuXCSjBIW25TBwGFuZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790628484; c=relaxed/simple;
	bh=W7MS1rAur3KyiXWXvIyQ9ly5N43hEejRahAijsjwmzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6y5rKOaM3ihDr2zmh5dNR/jBpeiFLgICoLmkIW596at2WgzYA8uj1Y10Sg7wxIXFouiOE83yIw25M2Idr58STLfOeQGZJAc4Ty92bsH/wkykRCsRmQJDCTGLKWwcdRtyPz26hI+g9w/T8dzVZG21eskQmGG8ksjzCndTTUg/x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=NayI1+Ra; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="NayI1+Ra"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D0A85101EBD;
	Mon, 28 Sep 2026 22:47:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1790628476; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Mci8WdhBZuf83kmZPQtnrcPqNpE7Pys3jKhN5o6TZOE=;
	b=NayI1+Rag+pE1TarCJEq2gYetoaJz7vf5h6SONOuBUQ5qAnibkISnWGxbToEKSbBQ5ORXY
	5v8ly1RLcIHKVJJiyvAvN/WO/pcPde5kKJx6X6/feexpMCgLDojJRWlJiN6pz/w9GWjsFF
	nXRyABALyLJ2aVsu/pW71ujvUIur7ViegFh/1E8wqpyHcCa+sRwUrRDwmfG3kLGD1Ea9+t
	cmZhwiClTSVegR2aZEuUjXDVsHs4iSMCLJxj9G5mn4bNnst0+xgyfr8w/eBLAZ12udpINC
	Js73ZSbuCj6owHoFTapuLE5XV3NJ1I1N6LwX/REzqWJaUwHOAovV5MtcHLDLpQ==
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
Subject: [PATCH v5 2/3] dt-bindings: arm: fsl: Document Data Modul i.MX95 eDM SBC
Date: Mon, 28 Sep 2026 22:47:13 +0200
Message-ID: <20260928204741.175754-2-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928204741.175754-1-marex@nabladev.com>
References: <20260928204741.175754-1-marex@nabladev.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Document Data Modul i.MX95 eDM SBC board. This is an evaluation
board for various custom display units. Currently supported are
serial console, ethernet, eMMC, SD, SPI NOR, USB host and PCIe.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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
V5: Add AB from Krzysztof
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index adf209b3b7cfa..e69f151509dfc 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1548,6 +1548,7 @@ properties:
       - description: i.MX95 based Boards
         items:
           - enum:
+              - dmo,imx95-data-modul-edm-sbc # i.MX95 eDM SBC
               - fsl,imx95-15x15-ab2       # i.MX95 15x15 Audio Board V2
               - fsl,imx95-15x15-evk       # i.MX95 15x15 EVK Board
               - fsl,imx95-15x15-frdm      # i.MX95 15x15 FRDM Board
-- 
2.53.0

