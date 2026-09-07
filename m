Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151F04FC8C5;
	Mon,  7 Sep 2026 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788793490; cv=none; b=BHkV8iZ/rTcF84F1eWRdVXMX1G9KLXx+7eoSTZVItWWtVhNAWqSeLlqmVDq4jncJILQ8LEGGpdzcKxTyc28BwByn2B/9POlBXVKy5ka3p05k99qzXnFEA3zyt3vAvb+ES7APB1hiRSXC3FZiQC/jhKYrn0sV9umbdZtiKP54BgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788793490; c=relaxed/simple;
	bh=urWcxP34PsbdZbmKYxu0s6M7Q0jnm75sBzdkJaan6H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvzedOdyuPolhjxJg8dcpTA7BpnbSanYPB/skOncRxl97lwdQFWR4JvzJrEkVdkBXwnWbvCHt94Y45mNiMHv/pNNXvS3+rR5LA82bHZNzjS7iTiXobikJoGcMYxT+6msvy0Tbbu5qkcwZBShK9WEoxefe4gKMk24JwKCPpECDXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Nl1EEUmt; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Nl1EEUmt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1788793468; x=1789398268; i=wahrenst@gmx.net;
	bh=7bZxTvo/gRHC2wbJK4+6HLO8PCJvqbqtF+gaT2PvJdE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Nl1EEUmtp1Dge4uhy2et3y5FIcBCQQKMYUlpOA9gp6dQRx8PZGcmk6udX2oilw7j
	 v5L9jLb5Iizkw9X/vbIJWKQ/1F2wr3YV2z8vBmEIf8uJvCq071NIpVt8SuhK4QZfG
	 56MCyGKl2LzERJVD7ANu6mABtbV8BPH7BIYoqoItxx9BhmNascdaFonlgH+vidPvr
	 +H1kYrqEpgORfr5/tVXGiThgbDhHGsEG3O9++QO3xQO9ekVLuYeT93SKng0kseOB0
	 xc/pyXwT1AAZNpljdh9vb2PDEHATjSvll2mLnIO/xTrMSM7851F3ycXM7rpr6xBcW
	 l+W4wf+8kT0NQf3i/A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Md6Mj-1wTz1r1naF-00cRPQ; Mon, 07
 Sep 2026 17:04:28 +0200
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
	Stefan Wahren <wahrenst@gmx.net>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH V5 2/4] dt-bindings: arm: fsl: Add chargebyte Charge Control Y
Date: Mon,  7 Sep 2026 17:04:18 +0200
Message-ID: <20260907150420.18787-3-wahrenst@gmx.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907150420.18787-1-wahrenst@gmx.net>
References: <20260907150420.18787-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QToMMau3ybrNQks1jbLYTLC9zVXRA7mpWp8AieCg/AlC7PJhn/1
 BsuPYEbMiG3r5OrchW3vXeoDUaggiYC6aYnUtF6A/n8HCkmdpI3ZRG9y146l9dIzSWwS1X6
 u1CE79yLjJDXGJBRaEFk1q05STJSnaFo0Opn5aRBsUrJoY+WP6PMKXJJAHunkBTvBShU9de
 m2UVcqIAiWrNEtjOMUV2A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+5LKctXpbR4=;jUJnR/0Hy6Ol/nuBzyzvGOmbWBT
 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

Add device-tree bindings for chargebyte Charge Control Y board based on
the PHYTEC phyCORE-i.MX93 SoM (System-on-Module).

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
=2D--
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentatio=
n/devicetree/bindings/arm/fsl.yaml
index 338dd9eafb17..e1bea343cb8d 100644
=2D-- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1667,6 +1667,7 @@ properties:
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

