Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439A53C09EF;
	Tue, 18 Aug 2026 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787044645; cv=none; b=bo2Y/YO8dM4PCm9daLmcnsrscf8BMqifWzZp7j19WdDxqv9U8c0waUsRYQnaUP6a/FKma7SbXLkA4MQoMZo6jJ+dnzBqj3NQoP1db3SlxGqP0B62i0jZThHWYmvEUCiYQ1/biuKbvvTq6Q15CPTb4SMJl8eVvfpzltabeBWOSGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787044645; c=relaxed/simple;
	bh=t3dBEsXfhzIGvPd8ij3TqRetSFTE582lOUEcQKkaThg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0Z18i2TzCWEHQanpxSR99fb9ZAHKnT3ZUHQyLwUXn/nwRm2cQ7ssO0GuTDmMdCT3yah5nZrt2S+Cwd+k0B1vobeAQoLQlqjfpoNidl+kIc2TiqlCgA6j1QVKhig2PK2lBvUbyeBknGKHdW30uLA7yu6lNX+lEA/93LXuA+K9ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=nWRJ2+gD; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="nWRJ2+gD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1787044631; x=1787649431; i=wahrenst@gmx.net;
	bh=APHNqbyIE3wsZFWJJNb/X7x7s14Ba8e5Q7jK9NX9v+w=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nWRJ2+gDDyisC5WjJpkriRHRcqWuI6FiQPEBbwW4QohlBGPT3Cz6uJb5gpc9UB0J
	 XYQHdSkELCPFyKKF6uh3+yiGAFjJjvZkS19Y7hjAB7HQ5u4vvp6VtkerRbBkAGj/K
	 NYY3VkO/mNIrGXI6aBDJWX7XaqSHF7KmQPe9fGyZB/hOh9jxUdP1rIoYbXuLdc7Sf
	 wM8qaTyIiiu6b5XqApgkG8Vtd9Uh29a5berSmM7Gi971MWUN8P+PrA4vKBow7dXph
	 87Q3XQTDu9LRJWa5uRmZtgEoSxG+1dCRX+cYSYyrJ2mpXu3zsde/pkC+/eGapT1pJ
	 gjTUJ+6jEvqe/I/dbA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmUHj-1wWEfG1z73-00pIVH; Tue, 18
 Aug 2026 11:17:11 +0200
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
Subject: [PATCH RFC 1/4] dt-bindings: arm: fsl: Add chargebyte Charge Control Y
Date: Tue, 18 Aug 2026 11:16:58 +0200
Message-ID: <20260818091701.6441-2-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:Ha38fgGPqaWqIobwuGE/0kEsZORwQDckaC4ehgDxG2MB/ye5r38
 TLRpbG8XFTuJg7f++LKDkRBmYq/iby4O6ogNQnENrgFV4Qli2a4RdXK8rY0MFxr4yD6dZOq
 Bd+t+F1LuWVnO0l/EY6MHVOiRO4mQVn9CUVVvsj054oab5ttvl2h+wXm2WUUXJU07lUJCx4
 KQVTX0cqwRgHCPUq/woPw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:I5osOohirZ8=;hvb97cKH8qO2OgM0VKLxzLATJTQ
 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
 Hra9SiA==

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

