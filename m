Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215503B6356;
	Mon, 31 Aug 2026 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788165378; cv=none; b=IMXVtuVJXZHpDWr5jI3P8SCYJ38QYcwwVllu19N6ySvP6uPS/52M7RDhnk1OBFSVT8MNi0yxzc9gHmEkes6gsIKuWBl/n9fC/zIM890jkkDJd9Df6EjmO7HUbfft5gZ9ZeyKMk13alr1RuQoCcK66/O7oCn2+BYnKzQyPDfDGPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788165378; c=relaxed/simple;
	bh=ZAGyCoDTVJi7iJMYRy2KkAwqwfCuzJEQ/MOzSj+Z+dU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LU/XxOANmSSmK74Ydea1L4r7CLDXcRG2GqoOvq+P6brR8/kF+0Guc/NwCzN5JaKj9hUL42l6v17cVKwJS1PDkOifzWhJzOZDq+V2nO5XBOR1LJ51DgS0O9UeElOyfVZlH/xuCgbiRELVd8zYSHvXIuLiGpVrJ0aT9Chncb1KETw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=ubw1MYhD; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ubw1MYhD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1788165344; x=1788770144; i=wahrenst@gmx.net;
	bh=xR36z+QOFzTRjYJ1sWvjVigZkp1iI59ePSHLK73BJcA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ubw1MYhD0L/W8B1I0Wb4ayyLyJ6jEPPLZ3tar2UVguzZwK0n+Jfn5c+dSLzjoY3z
	 BRRiuQImQc99I0MhgOQBv4mujkoE8UWk9tEZfx1uA4CQ5eSldW0uhz+l5iD+23yeZ
	 aI+SnQ5vhLOLw2soJU+Yt7u+Q0GMcDN8YLTMaptKuQJey1bqOrfOxnKZ6nHDoeShO
	 +/tLlyc3jxfrXlGrcb66vCBOs03ELQhymcp9/sd2LtiNUpopPtkeGSXWgVG61G6n4
	 lZJQpIPPHYitWhcBrRn5jMzr/73+f/p+ZSe6PbMfdSDLYlmlFzrTfjB3J/Jzpxn8Z
	 6zjJRxjg17fViVCWew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MlNtF-1wbTZ71cjt-00foLu; Mon, 31
 Aug 2026 10:35:44 +0200
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
Subject: [PATCH V2 0/3] arm64: dts: freescale: Add chargebyte Charge Control Y
Date: Mon, 31 Aug 2026 10:35:36 +0200
Message-ID: <20260831083539.8287-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vNEtWSrwCZbobyBy8k/T9aqdMZQ0aAGaGByHZMBceEV2VgyEWkz
 zNzHX4o4cNHVB9PWb5wHqNJHoLoh/XsMMOflZovzispFktJEcgaEEHKWiL52q8JmabTBBNu
 dj6YYIfNqsimJ/DUeBMRMijMEfIfghYWfLcu1a4mpu12mSM17hxjI07bLx8jl4nYBzMUmlF
 tgVSgwgorIvw6lilfBRng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GuBXChJGwUM=;FpEs5XuD+i+L2H96muXKg/b2mVT
 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
 e1C6Y6wJDHw=

This series adds support for the chargebyte Charge Control Y, which is
an Electrical Vehicle Supply Equipment (EVSE) for MCS (Megawatt
Charging System) charging stations.

sashiko reported in the first version of the series [1] that X_nRST_LAN
is available via GPIO line names, but there is no reset mechanismn in the
device tree. This finding is valid. Since the reset line feature isn't
implemented for LAN8651 driver yet, I like to proceed with the current
version. The LAN8651 handles reset via SPI commands and in rare cases
we still have the possibility to control the reset from userspace.
Btw the pin has a pull resistor in hardware, so it's not floating.

[1] - https://lore.kernel.org/linux-devicetree/20260818093147.E556C1F000E9=
@smtp.kernel.org/

Changes in V2:
- drop phy-can-transceiver changes and make MCP2542 compatible to TI TCAN1=
042
  as suggested by Marc Kleine-Budde & Frank Li
- implemented SD2_nRESET as vmmc supply for SD card interface
  (reported by sashiko)
- add UHS support for SD card interface
- dropped downstream property ti,leds-polarity (reported by sashiko)
- fix GPIO line name of X_LAN_nCS (reported by sashiko)
- drop unconnected pins (X_TDI, X_TMS_SWDIO, X_TDO) from GPIO line names=
=20

Stefan Wahren (3):
  dt-bindings: arm: fsl: Add chargebyte Charge Control Y
  dt-bindings: phy: ti,tcan104x-can: Document Microchip MCP2542
  arm64: dts: freescale: Add chargebyte Charge Control Y

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 .../bindings/phy/ti,tcan104x-can.yaml         |   1 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx93-charge-control-y.dts  | 426 ++++++++++++++++++
 .../boot/dts/freescale/imx93-phycore-som.dtsi |   2 +-
 5 files changed, 430 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-charge-control-y.d=
ts

=2D-=20
2.43.0

