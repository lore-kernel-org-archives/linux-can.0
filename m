Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DE73DAAAB;
	Mon, 31 Aug 2026 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788165377; cv=none; b=BQB32v0ursHgcNbyqYl+KvRSwCKIQbvHOEIRg5hG8ZB07bcuazUrkkpDS9g8H1ZnyE46a1stnYS84JRF6UfjeMWMeRUXlOplFL8iHN1FmOyDeYv1K2w92RbZMah6JRZc9Nrs4L4GTtWyZ8PhLjaqyi6w4dr00ZaCBK4Jq2rWygQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788165377; c=relaxed/simple;
	bh=xLfseIbqPpjDeGwK8CqcHYfQHjr4vW0LqQEU9MUMG/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BdfakTBMksIvXPM1t+3LihA7gS0XspB0CRA7bjXB/n6iMjsua8YGlNnaTeCfx9l4GpyXK1VnPcZaT7BCXvp07FDNnf2b7ahi0/OcG0jWEyMrUfwKNY2d6Dg1B2ydFnpbaclCAbgPP6sOwe2bTj8h3vKFtqF5PqMNsWvkDKkW1r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=dm6sUfjh; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="dm6sUfjh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1788165346; x=1788770146; i=wahrenst@gmx.net;
	bh=Yp1Pbph7c7KvDOsfg6NvlV+C+L3xiO1CbhzapsMg1pI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dm6sUfjh229YuwEh0eS9nSfRQ85Rr/1jgMqYARqliZVZQjamlI6EG2+I8ggueG5V
	 ScUc84VY7hV2iEBK+jD4f6jhFyKG7RcXxs17k/cm9ldGKumPA4OjIziMOZnw/zQhZ
	 e9/8zte9eJE+ScAUE5AzL1IqnuKJ4uw1bD1SkxUnlt5RkcSnJ9BxUiP2/wVk1FgYn
	 /+Ao3rFVWe0u0Any8FNrG0A+dfagB5oJU/m+grMBMf77EmrSMZpv6AwcSH3XYv6T7
	 1qzdv77Y8mAUuksM/BKulW83lZh8QGAAK4HFilfq9igJ48PmU/mjwlkrmigfrFpj/
	 vjQi18iwsL5OJgj9rw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mzyuc-1web1b3VQc-010Y0T; Mon, 31
 Aug 2026 10:35:46 +0200
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
Subject: [PATCH V2 2/3] dt-bindings: phy: ti,tcan104x-can: Document Microchip MCP2542
Date: Mon, 31 Aug 2026 10:35:38 +0200
Message-ID: <20260831083539.8287-3-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:k13nf52dbNUz24/9wurn5hWBE86GBt3oK8I/uxPdOVzrhclsEfS
 n5hJOfpcBoqYAHUdGs/WPNIP2RA1G+0ksQtUZpvVncYlXFl1aZq8ENUjSH+2biRp944xVe2
 WIrFKIfxhxOd3XTnWYo+CzY4ZTCgO/Dva/QpYv7D3S9SjQDujTXk2+LPfN0rCogBXwOavm5
 EYsFm1bQrLiTGkB+V72hg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tSqQQk3f4IQ=;WSq39aMiJASfbXcxNtycfbx1TZB
 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
 wf9mlEtO1wY=

The Microchip MCP2542 High-speed CAN transceiver with Sleep mode is a
pin-compatible alternative for the TI TCAN1042.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
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

