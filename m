Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805AC3A0B38;
	Thu, 17 Sep 2026 02:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613319; cv=none; b=XMRa1VfFbcmObfDEDIq3g9dgw+iLwLAOnYetp7dw2d53FyQnul8/j3z2m+BfcqfNNy+/WfcURh5Gj0qd4ncE8aHCRXEKAg1A7aPHCg4a1yRlE2+a5ZI9hkiyALYte92fw+ImWFAO6rZcitI96zXV4c/TDMG7243Ryr8OhvDNcfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613319; c=relaxed/simple;
	bh=MdsBzPPTMTEs2N5lZytr1NtR7R3OMpKNe68tMPv4umA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSS5B8END91MZ6TTLAEb+SuLE25LmdCwpdCjOBK3nBs0UWd4yMIGiKgfqRs0ofeLxTpbu1WSHWEMuQ0z1FMemr130pjPiTDdXXboJMa8hfhCw3KREGS15NOyl9dcEddeNP2z3epSML4fsh4DRUNbm61dncX+IbiZJrvaROzd3vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=iJznK+sK; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="iJznK+sK"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 89F44104926;
	Thu, 17 Sep 2026 04:48:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1789613306; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=8XwjObmrp5asFV1peNWNr4+DrZXPTQeb9HJH0KvSrNg=;
	b=iJznK+sKVZHtHEsfI5HvxWqVqujEFhnkdNTgSkwOygtf7me5vokdaaO4H3KIU4u5EROBPM
	epufNq1/irVO7PwVCTptC5tDmo9JJytN7eHYGoc9fAs14O5fPodUbW3P8NwHtkmTwIXeWC
	yYNYC46iF8bUVwiCERec8aZfwKSJsluH1hhMWDus1y5/jjb91a0WL7skEsNXrJroZ6dFuJ
	f63i/xmVrOnTeURHVOSenvItKa5fLb0qlPbvDTs5NbamcV9bqHL4fXAtlNwSAWNM5/Dqb2
	jX+akEs1ZLXBmKWbIZV8IJ1tdFTWEBkVZo+GxcwMhF8qQEtAxLkn1R8ZyMu9uw==
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
Subject: [PATCH v3 2/3] dt-bindings: arm: fsl: Document Data Modul i.MX95 eDM SBC
Date: Thu, 17 Sep 2026 04:47:34 +0200
Message-ID: <20260917024805.517030-2-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917024805.517030-1-marex@nabladev.com>
References: <20260917024805.517030-1-marex@nabladev.com>
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
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 36e28e0e4ad99..04abae2018043 100644
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

