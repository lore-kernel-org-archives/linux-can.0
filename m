Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794615538;
	b=kvAIksK7CFiJuj96drSB0S+KDnayeEcxGEzEKUPftbeYLRlKMYp97kWegeDX0wAI2yV8
	 Oq76k2+eSl4VXnkrhmOa/BGqmTqU9y4AX0qSsSfyLCB3WXktRbzgAmmQ3OmgD6Zh3ei+W
	 4q+Kn5TNeqqZwwZCJ4Rjapg3LTkmLHEuuWtA94fiI8ub+3owMFbz2pWZ5q7D1ULFNbHk0
	 8x74lMmKhW9CwNcJ0kiy4A5pJNKdoOerCwcKjhXxlXgmyBIFDziT9HO0FEnEvC28Zb3IE
	 UaAqvjzhioD4km0wd2/Idg4qbu1YHC7M4sisnNEEssa8whAsAXei4BhoyyJqptOFJ6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794615538;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=DbYweoBpLl4boR3F2YSCZ+f/7ZwlJREZqL4oFlSlCEs=;
	b=P4Z7Qsp4NQ9poFV5RqOPz9f6/dBBX9QQm/fI19MSIUkHB9377wrJQKPAaWMLr1QtoxSf
	 dlbrN/X+7kziVVnCKnFDfDhS7uZKkoPyUP2U/qY2asEqbI6SqUEN6UJwYPxpBw3dgMAHy
	 TFuh7IMzWKSysCClyahYlaYRVwr0fw+4oeBQDVUcf7ZkgFxAa1wnby0YD0QGO9aegZnBk
	 sUTOUcGkvEh4aAn/06BGa1VZWuagUBYPp24eqAtzYeZW3sJU7rbwWnAdLd5YQ5KeP6qGM
	 MwRaSeoPfqOMQBv4YbUjioEDLiQY0AukazcUZOC8ERpSJuZT7kvcDGScC/7et9jrPOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=hNhKbdAk;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F120606A33D;
	Sat, 14 Nov 2026 00:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F120606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=hNhKbdAk
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B8B7B10E90C;
	Sat, 14 Nov 2026 01:18:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1794615531; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=DbYweoBpLl4boR3F2YSCZ+f/7ZwlJREZqL4oFlSlCEs=;
	b=hNhKbdAk4wxqYGAkBPE3sYS0dLg5IQotUjNWcE9Sh00ctDgyUDdEVIm5MQL0O8LM//vVs1
	fQXtjb9XvloRCwXk5p9fBjmoCXUIm++xSCCRklvizur0jX2JDaB0y2i6ZHBrvGcid+S1gc
	y3kAfKl4KOBrP/vDWpcU+Lap+22zxN+GaHzYv/RUhq55B59+GDTRccvL+6HQ2uOODZzgHP
	IGdYFRaOMDtXxbjQKvUkR7Mb+98WXvizsglUV0MhZKgand8xbpver7ExkXYClZ57AjpQ9d
	BhsVR8Jdy6WmPqU+1YNDtcr1SYPUlspsvarkQSHAm+9BMu7ySdgu9YzFFnX37g==
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
	Vinod Koul <vkoul@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/2] dt-bindings: arm: fsl: Document Data Modul i.MX95 eDM SBC
Date: Sat, 14 Nov 2026 01:18:25 +0100
Message-ID: <20261114001844.30606-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
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
Cc: Vinod Koul <vkoul@kernel.org>
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
V7: No change
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 36e7a325af5ab..d40af695bc7de 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1579,6 +1579,7 @@ properties:
       - description: i.MX95 based Boards
         items:
           - enum:
+              - dmo,imx95-data-modul-edm-sbc # i.MX95 eDM SBC
               - fsl,imx95-15x15-ab2       # i.MX95 15x15 Audio Board V2
               - fsl,imx95-15x15-evk       # i.MX95 15x15 EVK Board
               - fsl,imx95-15x15-frdm      # i.MX95 15x15 FRDM Board
-- 
2.53.0

