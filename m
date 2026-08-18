Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0733BE64B;
	Tue, 18 Aug 2026 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787044658; cv=none; b=QvOVVcyzAovzGHZRj21SGsJwqiqwEUc+yJVk2kDHLXdflsg+6g5ivqmB3wNWS3HSH1YAtQuQcXA8xVqyufTeDLHs1plUmQYA9NM13eyq9VltGz7QJgRbqkbCKnKSDZOEw11VCjHhpNbETzypETUj9vHoHiVvuqMrcH9bJR3PlQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787044658; c=relaxed/simple;
	bh=10vcSeKfA9vlqePMpKW/Ffm810uePlTdlGTtiSE/j1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHBvplre+1+WNC0ojeElZrC+5m90s3oeyNJ9OK5payU68OhlPVP2QC136FJ6TGeMpdKNFwLOVLjJTKrt4hNmI23HNFzZDRAX46xgYbpaQOXrQKyrvt/b1fi8kHcvYktvNrOop2I4+w0nrjYXXv8uH/0AVSG1oZw7mjWFYLzUELs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=GTmobo0w; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="GTmobo0w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1787044632; x=1787649432; i=wahrenst@gmx.net;
	bh=TcQv/HBEGxZYayQz76Ov4BJ7mEEuosOqDJmXQK7aupE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GTmobo0w/fYghYugEhA6iAoM8254PgrTFhJxvLEQ3sNjeojCUgm3OOirsmA4ddph
	 +HZdMNGYSpKM/dokr2oqhfB3ByDZvZwo5S5+FXXJYtd0iwLgBs0iGvjxqemI0vuG8
	 oCEkJaFTsGZtfmSFKNDx7CeDVAGFA7o0KTcSg2MRxOURSELHyH2IFjuaagERyaTFi
	 0lK7SFOH+o6jAx55FQ5lvS0lwr/pkWQhrCS2wdkqyj5vS+0TTaN/dWcDDe4ItTz2/
	 w1A9NEKFfA2/hwanF5Stpg2+B/A0/4SHRTEo19fCpLHJBPsGvyV0KOt228gXv4kja
	 NCIhZbib8C48QAOGXA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmlXA-1wVPig0Sc2-00q7S0; Tue, 18
 Aug 2026 11:17:12 +0200
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
Subject: [PATCH RFC 2/4] dt-bindings: phy: ti,tcan104x-can: Document Microchip MCP2542
Date: Tue, 18 Aug 2026 11:16:59 +0200
Message-ID: <20260818091701.6441-3-wahrenst@gmx.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818091701.6441-1-wahrenst@gmx.net>
References: <20260818091701.6441-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0ZM9vIg5l4noPIwgMKVazWwNC5nCYVdkduK9u9n8UybXGCur9sm
 kbIj4VvXEZ5Gn53yCqj9/iRoUqEeea2Xo39x+tPTrsWVPkbYjJdWpnAlmiAJpAC72sjKtsC
 6m+WuzmpSWXlHFJb+y6PkbeP8MClvjN/Wz8bIXb14bjoLiyPL0raGAqfffze4JIoriGZ1lB
 CbQKQ0C6/mUAAsdDYm8Mg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fHgPVo/FeB0=;C5j1n9Jkh5we/GvozdP50/fqna0
 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
 k+AiWzHOe6/74tmBibXwZe+gGjPQ=

The Microchip MCP2542 High-speed CAN transceiver with Sleep mode is a
pin-compatible alternative for the TI TCAN1042.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/=
Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
index 9f5c37ca6496..2ebc954ce769 100644
=2D-- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
@@ -24,6 +24,7 @@ properties:
           - const: ti,tcan1046
           - const: nxp,tja1048
       - enum:
+          - microchip,mcp2542
           - ti,tcan1042
           - ti,tcan1043
           - nxp,tja1048
@@ -72,6 +73,7 @@ allOf:
       properties:
         compatible:
           enum:
+            - microchip,mcp2542
             - nxp,tjr1443
             - ti,tcan1042
             - ti,tcan1043
=2D-=20
2.43.0

