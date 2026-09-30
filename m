Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873EE5208C5;
	Wed, 30 Sep 2026 21:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804888; cv=none; b=YEmG6pKbGGJKsUwF2d5jBuCyyMqMOcKe1bkbLVtX0cH73/R+0BrfER7j0PK6h6PAU5+q84vNZxf5yysijEIDlwHAhXJ+ZinBcHPRkNjIZSMDlK88MbWNEE1pIG3rzxt9EJJjAFwAf9LpxBU7rTrqw2eAXoiOJ1A2m51Zg4yx/Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804888; c=relaxed/simple;
	bh=f6rDkMqAO1sM2iHXV41tiLzlTF1jWcIF3zRWoI6G7v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mceoqPACw4TEVyJiF8QNbH79j3OSjTg39KmjvF1PFOY1m+udZFFVBFXLeI19DyaWyYnHlNoX+9G96cQdwsg933E4y8DWwCMWQzzJ+LZzC2cQjhoSnsg9sLnUMDZFkUb8x5IwFCdYTNg5xdUf0wQUVjBjctjxVmiOckUKOk5RJ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=Yk6+ysb8; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="Yk6+ysb8"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 57DF2107169;
	Wed, 30 Sep 2026 23:47:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1790804880; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Uw9kB77lKUmjp3W6EEQca/4gQnddl4XWU8B7+ZG4MH4=;
	b=Yk6+ysb8z35Sw3Y/D0VIZNi+kzNxY9HEA0/vCLLG1+pb+NgS14U9VbDy8alG84HBeHgkAy
	MR2JSJ+z2c6Xf/wVLqJbP5dB0yfmZkJGFwV3gSwX8GrqA7nT5/LBN0q4778CJTaFDnpdSF
	GkF5HrfTf8HgjWzLUUVmQuv6WF2CJ+IqXMHB6Nx/rVupL9nDxJ4piaZDONfuG9koC9/Vhp
	TRpKc5in51+uhB2ogDLmeUFhIEsF1sC+P1zOYelx+PLC5nEpL3ny0OmMiQFRL47Fp1DmIT
	+BHSFnueAbZ/oTVXL0omlo3/zOPsql/SZuU8jLG+VR/A+qE0TCXJQbjA6IiRiQ==
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
Subject: [PATCH v6 2/3] dt-bindings: arm: fsl: Document Data Modul i.MX95 eDM SBC
Date: Wed, 30 Sep 2026 23:46:39 +0200
Message-ID: <20260930214729.809649-2-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930214729.809649-1-marex@nabladev.com>
References: <20260930214729.809649-1-marex@nabladev.com>
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
V6: No change
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index e563d96e4ff7c..81bb7b0caa8f7 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1578,6 +1578,7 @@ properties:
       - description: i.MX95 based Boards
         items:
           - enum:
+              - dmo,imx95-data-modul-edm-sbc # i.MX95 eDM SBC
               - fsl,imx95-15x15-ab2       # i.MX95 15x15 Audio Board V2
               - fsl,imx95-15x15-evk       # i.MX95 15x15 EVK Board
               - fsl,imx95-15x15-frdm      # i.MX95 15x15 FRDM Board
-- 
2.53.0

