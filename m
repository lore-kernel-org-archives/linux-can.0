Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C58D330D23;
	Mon,  7 Sep 2026 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788793491; cv=none; b=ornFazZkAV9yrdeVyDNlfusamitmQ8tAZZOwGkuwttePSZSHhsVKjKiH54iVOg3bdEiOF9VgVVBy8tygK/SSUPwvekA4l3UtDbJG97XtoAhZ9G6W3uwNZqdYmOqIymzGRVBxCnj/YMwL27jwFbp61UEeCYhkQ1dyf0wCte8+UN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788793491; c=relaxed/simple;
	bh=YoXuY+0EibLgk1NnSC+F/fGnf4dfQgmWLjwckWrmdUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WC7kR/lcbJeoAWaYBzW+ToM+GPMEOOSPTiwcVUrHYMYpygKmoMm9GCmNXEdrsVgaLWEaoT8iChUJ604xpFMLDbSaqGLOy9rqqJQvk8FDJxnnoJfs/HmjjF4UKmNbOjuGw0+FbiGl7KjX8XUNDAfrVpbJrqOj0haDzbT4PMu5ViI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=QS+smdxC; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="QS+smdxC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1788793469; x=1789398269; i=wahrenst@gmx.net;
	bh=d0+IN+3vWEwMwURYP0YJG7RoE/FnY0FFKtN3xNNLels=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QS+smdxCTt7ZjqIXh8eoNGVtGmfwGkpUlY+hI9bXDasbBZ4Pao6bwbp0+cHr+9I2
	 wywMH87if6yRu0u1592yz48AyI4N/SHQHrocm85dnjW9a9zxmf3Df9WQ3VVv0Sn5S
	 LwMkRW14DctfxvRsNDAgrSsXN6rt7S2EZEiY+eyBw6Xc5jaNfP9Hy9ACm+bIN5XKq
	 7maM4i2JjqzCJkR0LCEC0xF8J4xXGFIqPgkR8S22nLQ//qswX4qBsXQnHD8FbWuTi
	 cDBr94szzwMO3fZjSNgBpZDczfgT5LzlgASfZWkLojPtT5+o1M1iudHgEywIOfOVY
	 ILu5uh9fe6auhAueZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3lY1-1x3JmQ0KNX-0036eq; Mon, 07
 Sep 2026 17:04:29 +0200
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
Subject: [PATCH V5 3/4] dt-bindings: phy: ti,tcan104x-can: Document Microchip MCP2542
Date: Mon,  7 Sep 2026 17:04:19 +0200
Message-ID: <20260907150420.18787-4-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:g/1evOvg+Ss50R1tfWuQoC8q2+vu32MtUVYvnYLra1iGfqrgG/J
 3hy6/T+HuVol0PR6VMd8lhldPRTEqVVmiEJlDvnHa52nGA4/suYsuYXxI1sTAgnoalC4Uox
 cYQHXZ4t04BW4FtjzW+VnWI3qoGxJVkfMsbYkkP5wq0wfZjyfyHf1u6kTOZ+63iwgb6mRkN
 yuPN03Pqm+v7s+LZ2V/XA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:obJK9rLkoak=;+yLb3WZW2BjypugFBvbEdezNq4G
 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
 FqeDdxjptD9DF

The Microchip MCP2542 High-speed CAN transceiver with Sleep mode is a
pin-compatible alternative for the TI TCAN1042.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
=2D--
 Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/=
Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
index 0cf5fa21106b..1a0dc9bbe6c9 100644
=2D-- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
@@ -18,6 +18,7 @@ properties:
       - items:
           - enum:
               - microchip,ata6561
+              - microchip,mcp2542
               - ti,tcan1051
           - const: ti,tcan1042
       - items:
=2D-=20
2.43.0

