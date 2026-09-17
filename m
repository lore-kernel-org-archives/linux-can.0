Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B95939B97F;
	Thu, 17 Sep 2026 02:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613330; cv=none; b=rcb6IYPdABaYInzOAecmk31WaKjqzMc4cK0V+XoRyi/vag7tuuYff7dJcs2Q3XI54Uj5TZLywDwVEBfULnwP+5/Q0BfhuIeZLZ9q/OV+mfB0U4MDuhGM3Zr53S+Xb2MlGTCRT8CHIwIjdm4J8uYaZi6Ctgf3eELoZEs4zolkQAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613330; c=relaxed/simple;
	bh=kDOIPqP+efTmpLTDL5liLUAjNuKXNVCs5Q/OQrEO4eI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sOsSndf0S0ZvtSSNU28CNK2z6saJAXw8uuiHiinMvgQDymuTk/TiE/BICrB6vZEV2s3v8YrTbRIeJQusHgCu3WuEdFTEhTSgbNySt+VtaLkA0r9IfaghUwGpP32+uJM1QfdVVfoSds4Mq+F1duPnUck2o1EAvy/t9BjXDndy+LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=AElDVOJY; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="AElDVOJY"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 220831048B5;
	Thu, 17 Sep 2026 04:48:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1789613304; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=lqlwrGRYUG/d7xxGP0ZQnSBcVdG04+uSSkXr4oUxCHw=;
	b=AElDVOJY1uJXMjw0cnEDw/kqDIHAMeiBpZCQ4Otr2ejPKuob3Hhc02lupoGjAhAZeeQXZW
	JIzC6ip8rPIDBXXzRXou4bEkDzgDMykDlkBcqnZun3KO8yYY/9z0kGQylTvklciJYz/8it
	114RSx55NeWrwgo0k7mkjPULCyTqRtbeKGyysi6pApz1ii+M7mj15RWAT6J9Gi0F41fIbq
	X87EMFBGPMZy+SNjG/Y/ueCLlz58Bwm7ka4/b8WRgDSXi1rl816Je1qQhD1lOAvoYezrOH
	77SoSvTTwT9BU+jrI7JpQeEg1Cp/IDvmhfGzHGGNUG1sKf/Wn28FivN/GwR3vw==
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
Subject: [PATCH v3 1/3] dt-bindings: phy: ti,tcan104x-can: Document Microchip ATA6563
Date: Thu, 17 Sep 2026 04:47:33 +0200
Message-ID: <20260917024805.517030-1-marex@nabladev.com>
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
V3: No change
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

