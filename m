Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3080B3DB625;
	Mon, 31 Aug 2026 08:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788165376; cv=none; b=S09EO6jOL4/LY47m78p5RCfnqzCYk46KTwgvDtBuekX21w8P5FP6mYfv+ZigyZKvv1EvUN8X4FYbUDpoUIuq2G7I3nnXlBtB8jqH35p7EK96h9R0PKRQJSEdyakEPYFaYr1j4m0IBMzygSJiDqjZWlmmxD+0GtyivtbFpe8P8WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788165376; c=relaxed/simple;
	bh=t3dBEsXfhzIGvPd8ij3TqRetSFTE582lOUEcQKkaThg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUldL32WK8f50z1D3+vk6+4mVST6HqD7C5SNsRBICe4zWMkzx9vrc+0o11lgdPApBLax76zmXSveHoFz7MXbFvigXCJapk37WrK3wbh8x0Zag10Q02DACzdNXgT4U7Vs6WTE5dAD6ZMbfy2IVm9qV9V6XgjQ4VP/nA1okYkt1Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=id0xD972; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="id0xD972"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1788165345; x=1788770145; i=wahrenst@gmx.net;
	bh=APHNqbyIE3wsZFWJJNb/X7x7s14Ba8e5Q7jK9NX9v+w=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=id0xD972jIcOjaHGK6aThVqKPJ/zmg6pDt2GENGPPvi42eun9BmJ1K6g4PeamiN/
	 78HA6evLrDhuFUmYmU/MnTs6o1jFKCfu7J59AQ3s5Uk85dzQtq6QnpO1hc38I2IK7
	 UzWztudbKqHJcQW9imLYTwW+5wbaQscr99objcePg0tpbOEP8wS7p1qkos8beT9L9
	 6/Zkal+9hiWtpH0Wf6LqlS+zg/GDVk9tqE2QklJGqO5mRPrXUAVYkeKw70yuQ4uW3
	 /edAjV7kBOI/6LtgPGiYXOS47sYitOkkzUsqRPg1BBQ2cK0+n9xvY+Bb+UaR8Xmvg
	 PCT1+28ENu39V0zq2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKKYx-1xJzW20Xz5-00XntU; Mon, 31
 Aug 2026 10:35:45 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Aswath Govindraju <a-govindraju@ti.com>
Cc: Christoph Stoidner <c.stoidner@phytec.de>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 1/3] dt-bindings: arm: fsl: Add chargebyte Charge Control Y
Date: Mon, 31 Aug 2026 10:35:37 +0200
Message-ID: <20260831083539.8287-2-wahrenst@gmx.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831083539.8287-1-wahrenst@gmx.net>
References: <20260831083539.8287-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C9dRbgSWDO7K1N5COXs4P9kbyGo1CG+1+aJZb3J5bEiisZn6rQB
 yaY9pp96XcnGiDO8AVqMgQIhhEUcLxo33FlOFE9djkAwjPakDOFqc9bIPD7vFPAeC+7dFzu
 VSQDxGA0rXpi9QuHPxIfe+iF2Ep1wv+YmKaC8DGTrENhKuqWnGST3GiocqSDhiu1ajF31P3
 iN4H6prHWk0W3QjPaZq4Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:N0Yjith3bhk=;EXUlXIoyKbe8+zWLYA9dztJ64RS
 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
 Qm+Xt6XlBc8TJ8/rR5HgdMP

Add device-tree bindings for chargebyte Charge Control Y board based on
the PHYTEC phyCORE-i.MX93 SoM (System-on-Module).

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentatio=
n/devicetree/bindings/arm/fsl.yaml
index 86876311ec59..a7a1dc6b0ea3 100644
=2D-- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1633,6 +1633,7 @@ properties:
       - description: PHYTEC phyCORE-i.MX93 SoM based boards
         items:
           - enum:
+              - chargebyte,imx93-charge-control-y # chargebyte Charge Con=
trol Y
               - phytec,imx93-phyboard-nash  # phyBOARD-Nash-i.MX93
               - phytec,imx93-phyboard-segin # phyBOARD-Segin with i.MX93
           - const: phytec,imx93-phycore-som # phyCORE-i.MX93 SoM
=2D-=20
2.43.0

