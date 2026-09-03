Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F5E3AA504;
	Thu,  3 Sep 2026 08:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422685; cv=none; b=hn0m+ewOhFmLISWeXzDSd5Che7wu51lazA2U6MrrEXfB0DOymJNSrEusSNSEc7J1B1LTIEu4uT32vr9sjZq9LJ11uZpJPRXEVMacBpMLCP/Gty6rnTHKna71QjQuQhS17dOcwtfc0f8TV6z0vDvJvH7Taf6/yiIyQrRYfyJEGq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422685; c=relaxed/simple;
	bh=BnsIPBPuKSFwffvhwZgFGL6pfnJMCBQhqjwE+pVllJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHWxfDbh0YGdauhPd2u9TguLZeUXjYoxRBA8bjANNg442jW76MXSX4SfDiE/LT/RreoH9hSsupRXLCLcIxlODW9h8tldSI8j3cE9L1XfLd0P6JaqZuU+jWyRhNgAhnOJmfTFwSF1nQuUtz7nOnQOWcBjkjOlooP/ZXftugsR9T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Jm7aMawm; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Jm7aMawm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1788422672; x=1789027472; i=wahrenst@gmx.net;
	bh=BwSH+VPrwM/QWvKXvZ91GqgHP+dRw3S9kaAQ9v7NKL0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Jm7aMawmeO2OgIpeGt9wHzRR5tHL7RqLwryvGk4/j4KVBnxrzADBFPe/AP4x0C1e
	 flvuLOJlqcBwxTpg5u3Pp5X9bAX0+UK4LW64lWIx91XtLW83gDxlIKUBBYRG6b9hn
	 1XoEixkHYI9qYMJDkOANSlCWv1XRVlnHE3xBMaKDuEmz3ddB/ygJJfuO+JCbXzl/x
	 cxaHqOTsl9pq+0jcaHpJzawsV/+2oVXEb2sUcHBkplqF+05kc/gYiBa04jY4EXIrK
	 41fJOhNicCR2VFQfTWOLTsT76UEdAnQKbjIvkmXEDxE+YB6WzysI95Ciq5GBKb7Ky
	 N95NVJ1Wy+gTGq6Bew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5mKP-1wn5vH1X23-0186sS; Thu, 03
 Sep 2026 10:04:32 +0200
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
Subject: [PATCH V4 2/4] dt-bindings: arm: fsl: Add chargebyte Charge Control Y
Date: Thu,  3 Sep 2026 10:04:25 +0200
Message-ID: <20260903080427.6103-3-wahrenst@gmx.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903080427.6103-1-wahrenst@gmx.net>
References: <20260903080427.6103-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QMRrc5lczuwPxTsD5SAmDTB5vKHk1CX/HB42laktnB+C3PCTGvx
 rE343SPCH9+QXq3t4lBMYLBsG5akq2GB8bgA76HKn4TjAGYE9aAjzNbZLcohhT6vaStOfmM
 EdNhfOmqCvjLk3UzVi9zSSRLlEWPvwBCX3//HiyKi/ZxH+N7JdiY67L7xCl4Mdqt4uV4jAC
 BsIl4Rrf7Ofvpwlj3wsnw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jW336/P0E7w=;DQSWa0XGc4meX5A+xfT97zEBYYq
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
index 656f2596e1d5..6d20703c25b4 100644
=2D-- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1665,6 +1665,7 @@ properties:
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

