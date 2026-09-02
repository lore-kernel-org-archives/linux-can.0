Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2BC49CF32;
	Wed,  2 Sep 2026 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355700; cv=none; b=hC2Rddp4KZqH395sQ33AGu9i7dwMvmY0kyiJOTb0FJj/IkHDKvIcsdMRumuTkTbouIs2XCU8tgCTZQEr08oCzY+zTUaIUFJRU1ZAdDb6j+EbetsjblB5wDXPexdkFAC6OeZrI3eEzLaoI7CDNaZrz3xHBmxZi4jMz16nj1Tbw+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355700; c=relaxed/simple;
	bh=11SnmgIDwFLqzBUODFZdW/kCFQal5zsNNMFfEu/tXqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UZYVbiKqQv/v1r7e/q1KSPx73xeWuQyeQQDpP9UdfPeDGWZsbxpAVQfHiSyHI5oREh8La1md0KLKrE1P4jlTb/oOizWWDZKmMImNW8chcvoTJ0pP/CIj7Wo8IYQLb4oIii1uKjSyaXSFEmYBc6AU7aPypglQVdghrnZIu579dcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=ku69uVXA; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ku69uVXA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1788355694; x=1788960494; i=wahrenst@gmx.net;
	bh=Xgmw0ODWvgN1xHHx/5kM7+etCGYDYTNmHhQQVZYhfDg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ku69uVXAjNX0T26t6pHcyIbBa275LWq/f9MP+G5RZhAN6BaUZhTyeIiIM9r/nQsG
	 O9MwmpcsU0+4V8HSb0kl87otwIqN0xYy9+dW5nKT0sPRxNieFWeJWdqgDve+S3dpE
	 F3Ymrx6gZmqmg6EPhH4L+LlnH6PIVXwBinrvO1AM6Wo7YRh5LXs3zsZY+2NFAQRuo
	 4BeYKx3CG038SG76iCts1GZGS2yG9qrkWHIwTYoTbKv/n3brvTVlaWE2TuJTlqLKJ
	 mx9pAB3Mvwi7CLmOU0N1rNxvEO7WNWZPgD/QhaM6Mwq/Y++rbXGQPBs83pAG/HAGd
	 k3NEgHCZkIskq/PgKA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N79uI-1wneSn3QNQ-016jus; Wed, 02
 Sep 2026 15:28:13 +0200
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
Subject: [PATCH V3 0/3] arm64: dts: freescale: Add chargebyte Charge Control Y
Date: Wed,  2 Sep 2026 15:27:57 +0200
Message-ID: <20260902132801.22056-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UQVJzyfsVZStUC6P79G8zKHEAFWxMcafWM0EXH0xzZtYvKcAejR
 tP58P5hkr00Xh1lnCNBAK3yjdhtkqlr+xw+zaBAeBZUCElexL4zP4ILwrA2Ly05YzT8P/Py
 hA8V1qIJGUSGzW6FuOyw2QC0Li2bGSW3lkBcR6kVk7/rWLaJ37AQFCIY4b1zif1xNWXpokK
 QYKOPQSe5lB2szwEHJpBg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KrGCS/tPURo=;ZbMeiVBxAnCaJm6ywigxBzHoQjl
 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
 8nGXX1iyOfs=

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

Changes in V3:
- add Acked-by's from Conor
- add missing SD2_VSELECT to default pinctrl of SD interface (reported by =
sashiko)
- clarify LAN8651 GPIO usage in device tree (suggested by Frank Li)
- move X_nRST_LAN into dedicated pinctrl group to make it more self-explai=
ning

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
 .../dts/freescale/imx93-charge-control-y.dts  | 441 ++++++++++++++++++
 .../boot/dts/freescale/imx93-phycore-som.dtsi |   2 +-
 5 files changed, 445 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-charge-control-y.d=
ts

=2D-=20
2.43.0

