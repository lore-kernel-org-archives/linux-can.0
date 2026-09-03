Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F2E3A5E65;
	Thu,  3 Sep 2026 08:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422679; cv=none; b=HtTluQJqaT4oIQopcCR8A70kKuJPgBfILp+huEuWWYRGaQKBKJ1nLEby7qdokyitTMfHi+zXBced+yUlVMgzHlI8wRwzNEK195qAYNhXYUdg3HnXLzuez1eXJEPmc9CdNCf2i6+sKTMWc7PsYKeX8iQ8bDn+uYovyqalZomgFX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422679; c=relaxed/simple;
	bh=YoXuY+0EibLgk1NnSC+F/fGnf4dfQgmWLjwckWrmdUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SiPPjORBwm7XiWcUQrMy1PqwBwww9ngwYEbkU0e5eVVIHoeFN4F5JPcaaVeBm6f9G/AIXXpwKEybbr5FwVFMRGCszLL5T7GpUucyEYkTOpHd8jlNhclLmFAfikaY9+gbLTTblmqcTZNb2lJPrvdpEo8jY+gs64+WQS0edzy0ssc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=kiRLlGm7; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="kiRLlGm7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1788422673; x=1789027473; i=wahrenst@gmx.net;
	bh=d0+IN+3vWEwMwURYP0YJG7RoE/FnY0FFKtN3xNNLels=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kiRLlGm7O3dK6DRb202MUKOgQcymrBEqnn6ggY2XYhwIn0BCqV2+I92DYJU1b6TM
	 J5s7nAjXmxQ3XZZ+y//eJC17Y64x9b/WGT7Jng9Plmt5u/T7IQK6qzvHAIyC1rBWz
	 vpQuxAw9vMfJtNRJhgm9wPGGTAsQYKYv3wrtVgphJaFa4kug/UKVjjB14IdfXFxxg
	 JVeTCQhNx+VCRA95Drvqj8HXL4+9OW6jLYuXmI9sAW5MBAGo3/nFy+0+k9jUmEMAn
	 IW5KADZPHQgbkuAWHx2Tcm7Xh4zTRz3lXUAR1mvDpCt7Kob3fTwRfSIXjfhaIxuPW
	 zCSUFdVxhnsO+iR1FQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLzFr-1xJQrQ02Tp-00ImUk; Thu, 03
 Sep 2026 10:04:33 +0200
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
Subject: [PATCH V4 3/4] dt-bindings: phy: ti,tcan104x-can: Document Microchip MCP2542
Date: Thu,  3 Sep 2026 10:04:26 +0200
Message-ID: <20260903080427.6103-4-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:YWB/GHsvgz3l8U3i+QrIrysss1B/0Mk8RWuwEMb4fLrSulAdPwr
 Y6we37Ur5KYiyQF7YQGp+gqXz9N+uZcieXIvB0CNB45c+KatQTIavpbjZy6tXCOwhug4qvW
 VpKsjeHliEYoDJlbNjyFkhy3E1uNo5ogWzpAK/R3XpDqaln7SxWDvjupcSGREdp8mzjKcA2
 ZXp3TEK8xtRDooOmUS0Jw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cb/PL8l8jpY=;/cAfKBifXgfdv74zKad2hUZEHHL
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

