Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D5322FE0E;
	Thu, 17 Sep 2026 06:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789626359; cv=none; b=rRSRBseMBMvkvk5KNSHloMt5SSkq0woOMlAnkgnIM5dGCnlAqlDqkZ4/7WCmKbN0M8+WbInBHLP9jqT8bOLhFFFvaNlFKi0enZah2p+7nuy0mfwxy0TSufNePb+xqVrNPSCtlNuvZ90FHzwT8jxpVYPwrwVJsL9Sn4kFsw3P7xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789626359; c=relaxed/simple;
	bh=uNwr5OBwSnrKKjOMr2BPkQfCu7qf02zMrr3HzA2RHqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WiMtgUdY22TAwmCpYxovplHS0YdEtvuYG6OecIghCYKYwlLSx16fTeyMjEeVUnln6oJos5NayH8ZDeNj18c0vtjgpu1kri18SsFfzKZe8dKZmEbCVC3WpjRljPtpV9oYK0pceRB0b4dGQNKidxmaGyXn59ioBhwLoI22KJAQLQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=RLhd2Onm; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="RLhd2Onm"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 89172104926;
	Thu, 17 Sep 2026 08:25:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1789626351; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=E3BZdP/GaR042lYbabPdNtS4/fWWWzAYluU/a6rKpqQ=;
	b=RLhd2OnmPspNI2JmCXEgGDgHWVTgl3XLGJ+SfT0S51MAng4K7jwlhzUMVkWRuwb8Bh9yFX
	A/7GADKBYqOqwNZewLO/se0EirkSF3u0vFAURwXgRDXlZtsF2z3TJ9TEUhV8sn//BY2Xyr
	rrw82A4PhRWmSG4WH3+MrRgSA5KlUv7x7lajaPYqJ0cdmfPK1T79MtUzxSpdC/7xRh1VUw
	JO7A80s3Bmf5GGlegSDU71Xbb0APpdut/US7uMbbHxFAaDeM8i/0kvShEpy+14A83+r0YE
	t+PmVsmBMchvbMi0mqVurNx+BZs3qYfafe9LW09X16U6JO5xknyVvCJAqN2X+Q==
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
Subject: [PATCH v4 1/3] dt-bindings: phy: ti,tcan104x-can: Document Microchip ATA6563
Date: Thu, 17 Sep 2026 08:25:26 +0200
Message-ID: <20260917062543.534416-1-marex@nabladev.com>
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
V4: No change
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

