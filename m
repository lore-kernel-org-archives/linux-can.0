Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA8C503BE6;
	Mon,  7 Sep 2026 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788793496; cv=none; b=SXk2jvNDAWJM+QR4R1wATM/ycHuDQ1V1KAxlqMzvumF8nd+PezOF8OocHfr88igH0097ZdDUzk0gNgR0WyV0U18D0NpkTjXNpbkp3dBGl5zisnqxT3FrurXmhDRLDS1zm+/ZVjGQx5+f7mvgAoFXeRrzsvKJRk3ZEuEibZXXdzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788793496; c=relaxed/simple;
	bh=ZCBJxvrn7IkwgJ5Qs/dH3JLiy6TLi3/CwHoSrQM7VEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F4lbNh2m43gknrVCdrPQHBYE5g5N960HyrTqCcAn3IPE70cYECLkyjmNcEGQ24GSWxd33HeD2UBDd78gpzq9BZtuTpxVFg9UJ1RFW+Zm+Ou+hm3l1q7Eq9YbNcFuFObwUi8ZDUMRmALwwuUsvuWLw3icowFigGWz0S9JUCQenIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=SC0r0vZ5; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="SC0r0vZ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1788793468; x=1789398268; i=wahrenst@gmx.net;
	bh=i2WaPl7qs5voU98Q17sPolXi/Qg5xL1KjIZf35Jp5n0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SC0r0vZ53hpE0v6WELhT3LDfvE0ChKwpp7s7vI+g6MhVn7dxneDeSNaBEZ+KPs6r
	 Ua4qdPVmw9CRDVN94UCEBG5zNrTrz58wfWX4ytw/q1i9ATbokfl3JEnKuUD1m3ohi
	 aWjpBfp5Zlurj+ekLX+vY+xEGEjF288xs6e7u6CZusnX34we+nRvNGoh3dr2Pucle
	 HGoKYpxcW0SwZhNqI4IkBZqeKeM6H3PSLz6cVjuHchZ6LUPgdVan32vOD0M/5onTW
	 NaQsPvsuK9nB1XXuY0jxCaODT8zs/8N0FtNoXZfISwGvWzWptHqORg1vhPlEABJ0u
	 WfWIsaSkW1nDJffRnQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MS3ir-1xRUSO35h5-00RGH6; Mon, 07
 Sep 2026 17:04:27 +0200
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
	sashiko-bot@kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH V5 1/4] dt-bindings: phy: ti,tcan104x-can: Fix property constrains
Date: Mon,  7 Sep 2026 17:04:17 +0200
Message-ID: <20260907150420.18787-2-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:Hl+dFGSYU+sh9v1bDxoQ9+uCzYqitOnc63uDys+DQh8BjzF6S2C
 7KX6GQQwpQLpnEe2Yx66xNtUAb8Z7y+xY3AXW/ozsGtbHOskdENM3+s5DigLs24RGbWr7nR
 ii8SbkHyGd/9l1IgTb/wPk3UVAgrfe9ibiJ28paYzr78opX2DRmwRnQ6EOADC6Kq/hZQsL3
 I3FZvV72p7Hn9HLYSMPeQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7Flcac3Cbic=;8puwQ8gQLGMFAosM4jS1KR0CV6d
 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
 EyIV

Microchip ATA6561 is compatible to TI TCAN1042, so the same property
constrains should apply. But they use a strict scalar enum match, which
makes Microchip ATA6561 fallthrough. So add a "contains" to cover also all
compatibles ones.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/linux-devicetree/20260902133525.E22DE1F000=
E9@smtp.kernel.org/
Fixes: 05ace63d0bcf ("dt-bindings: phy: ti,tcan104x-can: Document NXP TJA1=
05X/1048")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
=2D--
 .../devicetree/bindings/phy/ti,tcan104x-can.yaml         | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/=
Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
index 9f5c37ca6496..0cf5fa21106b 100644
=2D-- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
@@ -71,10 +71,11 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - nxp,tjr1443
-            - ti,tcan1042
-            - ti,tcan1043
+          contains:
+            enum:
+              - nxp,tjr1443
+              - ti,tcan1042
+              - ti,tcan1043
     then:
       properties:
         '#phy-cells':
=2D-=20
2.43.0

