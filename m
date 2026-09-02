Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173AA4A262F;
	Wed,  2 Sep 2026 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355702; cv=none; b=LUN4M6blxXx58sCg63AZ5ZDnC+cGMuCENfBjiKkPgaByviM5YJOcNHo8YjABmybnfLnET9XeG+Gu7xaYyZphDuwyoFJb3UXcLf1Gr2l7X8ehz6uGYnM75fvdHQAcAObJvJ0bokDZ6QXRNXrD5edbg5xUAi8zF9Du1eWUPVC1b3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355702; c=relaxed/simple;
	bh=Ak7O2Df6RejXrZ/2VNrPyDQ06fs+LKUgEnW9ivBCQXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbLM8TQYz2Fu2wK7pftFlc5Kor+6LvuvdHdLf3aFH6BWGviWz7PR9afNfOy2fWASm7zynG+5lRCN0joxBr6//NbNNeHKrjBc4IxMjipfTKfKbb9XB+m4rsVzsiG8pkvEaovrLHJkJ/Oh0+PI2kPmIDEcNzF/IdWcOjilmu1xZjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=eBCdeXck; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="eBCdeXck"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1788355695; x=1788960495; i=wahrenst@gmx.net;
	bh=LxpA8ufSxMVkSW7LG6nZkLPaXSX5aSwR7c4C/0xOStI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eBCdeXckHpZIoTcrMmdz5jdiGTgTjuWzw3Z2hIX4gVAS4wwMUnH3b8c4GculWK++
	 pM0D0ial06laZZoITNtgYeFrcEMP1Iy2eJrrNw5TbXn7HlvaAZpqTR03aSxkfBE0i
	 tqr0xiN8+s7YB6bnPREI2wotSzTvvpLHu0NjhKsnuAH0VaI76S8a8o7l5cHnpgNWQ
	 tbucSZGMCCvNCwqTomRZ6giTwa36LsXWa6Qa+L0HSGOrp0y2F/gdq4Kt9LdKJdBDd
	 lMF8gAw5EUcwi/TsjpzAmZTLgP4BKR2csKJWQyOnVUoDD1VyGIuh6jIY1hAV5YdsK
	 HERIZamwPkUGp8sDIA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MacOW-1wR3g50I9K-00dTOW; Wed, 02
 Sep 2026 15:28:15 +0200
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
Subject: [PATCH V3 2/3] dt-bindings: phy: ti,tcan104x-can: Document Microchip MCP2542
Date: Wed,  2 Sep 2026 15:27:59 +0200
Message-ID: <20260902132801.22056-3-wahrenst@gmx.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902132801.22056-1-wahrenst@gmx.net>
References: <20260902132801.22056-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FPjxT14AFsF1j8SAwFt5ZPAwsFM7YpCnh1j+P7i3gjYg17huM7f
 ktJ/wqk53M30x1QJt7sI8EcCeM45yYjCvcmTRoJS3CbUx7HXlZVa0znh4JYNJCT2s7izr+L
 euILe/u2WV5cKCKjKFDNA2/EAJssqwDR0+a/QY/qAMvaqrPKYg+6f2kwRPmeYfnMeXbu4nb
 2hx2CGl1brvHsryAgrZCA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BjCH+NI03E8=;XmivofR5BS8WXlsnWeQ1Jc0sGo4
 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

The Microchip MCP2542 High-speed CAN transceiver with Sleep mode is a
pin-compatible alternative for the TI TCAN1042.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
=2D--
 Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/=
Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
index 9f5c37ca6496..3ed4ce219120 100644
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

