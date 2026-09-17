Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864CD372B58;
	Thu, 17 Sep 2026 01:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789609405; cv=none; b=W0PCCZ0IOrekB9qVkiSKNlJ31TcChcB2jgtymf2MuFp5GVaUWd/mlFc3lQlfX4/TKYnOnu6dPNlsM9AvWHJfvw0kHoQkEI3igdBKKshTEPR+keFKzh/AvBe6WVwe4SO+8FG8+fzRJPOD/DrkbmmqZ3LiCbdexy2rhSr2atjvKGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789609405; c=relaxed/simple;
	bh=HOtqRB/0P7U9cqQmNO4qGjIdVFF32r05Vl2V38LbD+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNZyTEeWdMewCcOlDu5eDiNXdWvPcj9sRGwQSRYz+Gw5Mz7sQLn4aAM5FQXEgcj85kI1HDKMSS874aznar3tA072QCFNgIVxsJQGVquKmexV+E6yqjUyYEICADV80OGVk1HmgrB1mhmuC8t/E7eYdiZ0dSsHxlv2Ap2v8FvJK3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=OpwCBQBF; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="OpwCBQBF"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0848010490C;
	Thu, 17 Sep 2026 03:43:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1789609401; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=4nTVWx1eFMoMCmrlcVKbyFxDZNBr92/ao7gbE5buu7E=;
	b=OpwCBQBFIiri9GHPnf1Y1IJTEd66iRc5r9T/KE4/kNi1aG+Eubnsi66WIgkNQA2u0eslfw
	PtMxd3+lnqDBJXCpFQ5nC865dFwQAWsEPSbgqNilo2ZzWlIanQYeq1/eBWc0biaOkfe5PT
	cXzqmt7NvEFO+seOiU+mp5Gp5LiPfz7fPRADV0PODlbivwkaDcFx8RQprvIbozzeOyOI5h
	QYPSr0kefQkXzEYIwLiuLCv6Xl+hUTw1rPU8yH9dft4k+Q0W/oVopMBO409UfsLBUHkhyo
	5bCNmjkzrVX89rdmLJfyV6BqItx4mK71RFhpqSEX0WkAuvAGpRzeMZ/HidDyWQ==
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
Subject: [PATCH v2 2/3] dt-bindings: arm: fsl: Document Data Modul i.MX95 eDM SBC
Date: Thu, 17 Sep 2026 03:43:03 +0200
Message-ID: <20260917014314.472079-2-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917014314.472079-1-marex@nabladev.com>
References: <20260917014314.472079-1-marex@nabladev.com>
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

