Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1722F6918;
	Thu, 17 Sep 2026 01:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789607360; cv=none; b=h5F3hnQBOMtlnczucIXqMl7THLy1x7CW5OL7enRMpXIEHRSVpq1vsL0xECska+Qi4X/fvqULjHC5I1WG+8kdqiiLWnjHLUm2jOZTW0s/OBhKdU+i6ECS+WCyIzO++sJZRX6ExZRPo0cj1wcTTgJTVt5rKpZj0oXdI6ImX8g01zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789607360; c=relaxed/simple;
	bh=NDalHSaHMoiYFvGliQm3UB0bKfHrkW7ovSRzOHtJWC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXalfNyZtnMW5euXyG8arAsUMwb99SNtNHMigCRdi3iuTk5AMlLqe9be+PzwI6KNvs6UAOEPvLW7z3biLTc6nC24JNXwYx9wLt53YfRhBoNpqssjudbT0kgktqQ78gPGOoXsi6ODPnOATGKtRXDNE9dAY319Yk62Vo+eizqo8GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=gvwRGuWb; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="gvwRGuWb"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 82DE41048E6;
	Thu, 17 Sep 2026 03:09:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1789607357; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=gNkre/XsEQ/EixXkR7zbvFzj9KfeP4IRk7mqlohngNg=;
	b=gvwRGuWbh1mDOkBtM9glMTu7nMJ44NXnSZOl8py9EBgpGIahkp5Li0lzD3D6vv4ybX2uji
	4H2GzROlEgbwVrX17vXoGmqL5fdwq2yPBh9aDqCwHurwvYfumwN5+nWu0tPrCE8Q1MvrAP
	yBmzIG+R88nbiihMfWIxHKkIuQK3UKYOfo4GVyuQCV/YtTaNtFJ0AQceX57djOKR5BP8fu
	CPO0T7sntP59qtrM2OTQYkIY1GdHtt2fgwaW3SFXioAxT/NfBBE0d+4/sCgRnd5c31l8HN
	0Lx2vfjiJoVKLLbovKTfpxrx4yMV9gcCUrjlJeP+8irX2aXCPyajE1OCHFuXgg==
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
Subject: [PATCH 2/3] dt-bindings: arm: fsl: Document Data Modul i.MX95 eDM SBC
Date: Thu, 17 Sep 2026 03:08:23 +0200
Message-ID: <20260917010906.424049-2-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917010906.424049-1-marex@nabladev.com>
References: <20260917010906.424049-1-marex@nabladev.com>
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

