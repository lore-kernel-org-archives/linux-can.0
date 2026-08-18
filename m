Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6557943FD26;
	Tue, 18 Aug 2026 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787044635; cv=none; b=PtJmnqrND8fJK1V7gYivIHQeDTlN/4/CBgV5GX/koFhB1LtfE0v9gRXg5Z3/9rkp43dX6KOntd/TdLpDif+WfqTWOL+VMJ1mQeYA8V5Hlk3iILxNtX2xPErPaoOx5GswZwtPxO5m/9avgM/FzqRi+0aY/7QCc4C0uw/t4pZN8PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787044635; c=relaxed/simple;
	bh=8OJKitlDfs2smW13tHIiR2S6gYW3lBN53T6dXFMqz44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FMBxFi764WEIu8xqEt8YOJn8rXIoJvCAuJik0xroX++CCSofDu2LR6MoLITzQB+s/ngC/hLzOZEZg2U3MM7W59LhWMw+9l042y/0V1O0Po/YWBgzEUs3DLYJhkULGa6fy7Rm+6gfetHFgRle6mgNlznE2WLVaep3fCYIi9WjDkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=LEqWQO4U; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="LEqWQO4U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1787044631; x=1787649431; i=wahrenst@gmx.net;
	bh=xsHPOw5hdJgsD/fKE2ENSKGx0RTQyr5mFOh8PbtmfBs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LEqWQO4UAzvhTdjBi21KLNEoK59Ak94XWr2ta7F/m0cLoZoCkUYTBoHVfGLuj+zy
	 MtgnGU6Km41GNkTmKxhTC4cQx5dCjInxws+Zse0DfLoQzZD4bJiEJaRvMWv5eM183
	 jzDc/sfq8W5fNR1n4KC8MJDvKdkw39NxSSqqKWyA+SWHFJL+7PuLQsiQL8NqZpjno
	 PaGjaMcIZWJeXbUxvcxVbX0BGdgHfjiMPFw90zodQx1esO4gavWSzrU7i01S9E1Jr
	 JFZVN7t1bH+wdz4cGqunhKIJWRQc4GdKWeh6IlO7MPScsLYaC+y7i1jF6UItGBhD2
	 1mnXkFadtioUoU+1lg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MF3He-1xBe9e3IfQ-009e6E; Tue, 18
 Aug 2026 11:17:10 +0200
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
Subject: [PATCH RFC 0/4] arm64: dts: freescale: Add chargebyte Charge Control Y
Date: Tue, 18 Aug 2026 11:16:57 +0200
Message-ID: <20260818091701.6441-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fih17gXB/NxG4gg3M8zYUXSG/2sI+QnbaQ/3V8484tOpiGj6M7q
 P8tlrzaNxMDyMV3UUAm8BF0DipTRHqaPthyCh0s5+BFMCEw4MZibunPxzh6TDtvT00pJA7y
 k+uCCbUGgk6G/ffECzCQkGynGbig3ygfI7IbkuTGMPOL6Fal6e286CfC3FdPSYXl1/wIKz6
 J+37A3IbYHlGtxT7+VL7w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zrpuMLDpMHE=;qQuor2usyHEqqjY12GnL80FfRX/
 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

This series adds support for the chargebyte Charge Control Y, which is
an Electrical Vehicle Supply Equipment (EVSE) for MCS (Megawatt
Charging System) charging stations.

Stefan Wahren (4):
  dt-bindings: arm: fsl: Add chargebyte Charge Control Y
  dt-bindings: phy: ti,tcan104x-can: Document Microchip MCP2542
  phy: phy-can-transceiver: Add support for Microchip MCP2542
  arm64: dts: freescale: Add chargebyte Charge Control Y

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 .../bindings/phy/ti,tcan104x-can.yaml         |   2 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx93-charge-control-y.dts  | 387 ++++++++++++++++++
 .../boot/dts/freescale/imx93-phycore-som.dtsi |   2 +-
 drivers/phy/phy-can-transceiver.c             |   8 +
 6 files changed, 400 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-charge-control-y.d=
ts

=2D-=20
2.43.0

