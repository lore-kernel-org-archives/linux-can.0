Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2943FD960;
	Thu,  3 Sep 2026 08:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422685; cv=none; b=E1nqpzT8cT+EdtUxsXICFoPt1U1r0xzCKkKc3KzIqZDRd2SKPISYvqY8Haayerpv1Ni0VhGo7Y/pHpPf5OaqPDtzrdUYBhb9oiL1Mrq40L09GvlvnuXBct7hZLHUtZyO8BUgEb4ePjeDNIRj5hk5PJ5lVqOH98n6RASeGopnt5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422685; c=relaxed/simple;
	bh=/Qr+fzkeVyCHOR+m8RswWjUhvubPDusdh66vGV911Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JND2EqkK8BtUrBqQPcgjspXJaq36Q1ZePgp7itZCbEBwdjD49i4dBk3iMC3yh6Bvzc6nzcgF3o1QbFh/XhxNo1FrKFCOIEZvvcIU8Vx2idtNFMvx4W3lvtr85g+SQdI2MUvwwh0IoPi32vlQ0SrtsLiv73C1/5jz0p0sXZPD9gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=UKOy3cZZ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="UKOy3cZZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1788422671; x=1789027471; i=wahrenst@gmx.net;
	bh=J0fI1G9VBFnj8InEKvK4DsehhiDycgGE9ciYpMnZc1Y=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UKOy3cZZIawX6sO+cQ2Jd/NrLdcSLkyZY3hG01weXB6x9UGLfiqVWJKyJd65f513
	 832wMs643cjXSYAQd1LYHXJvNxrWBtmnQ98a5dhOA4B/LziYdsAmQGHerk/SGAN97
	 M6K5QfBPR5xDUzz/IC1hJWyq62fWTFWj8AwLz0y90Ezlsc2BA3xO1tmSoZqybpKGI
	 CR4TVQscPpg5wtal77bzGmZnXs3zL2XNG4WDbFs1CFc8M3H95HS3xfrqILA/Gm4mP
	 6r+8ri2KMDpYxMaFIdtlxV7e0yQe2/+ShdNQ0AkYTDcUAy5DjPJb9/zXOg4S+U3+C
	 GcqeF6/1+D5Cexu+OA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mo6v3-1wVQW40DV5-00qRVA; Thu, 03
 Sep 2026 10:04:31 +0200
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
Subject: [PATCH V4 0/4] arm64: dts: freescale: Add chargebyte Charge Control Y
Date: Thu,  3 Sep 2026 10:04:23 +0200
Message-ID: <20260903080427.6103-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1vpaWW1r+8dSCRmQI6ZJhZxnXDTtWbFuB+oClctzOYkpSOS4FS3
 eKSbNNH7SxbuOhCOGIplGnKL1Fj7SNCdXS0MJuB//6k6jUpZm6dFVzEDRvWnyCLP3Cr3Vgd
 PmvzGiTjBcOnqHHH487s85FMEvavT+fPCht+EqNqehZin6D11jJx7GvU11rtRVK5r89AgVU
 SAV8OHW/luOmMmw8472SA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:z3zOdtkk4LM=;L12zLCZwL8+hc9WH/H0SCtx8nqC
 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

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

Changes in V4:
- prepend constrains fix for ti,tcan104x-can binding (reported by sashiko)

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

Stefan Wahren (4):
  dt-bindings: phy: ti,tcan104x-can: Fix property constrains
  dt-bindings: arm: fsl: Add chargebyte Charge Control Y
  dt-bindings: phy: ti,tcan104x-can: Document Microchip MCP2542
  arm64: dts: freescale: Add chargebyte Charge Control Y

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 .../bindings/phy/ti,tcan104x-can.yaml         |  10 +-
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx93-charge-control-y.dts  | 439 ++++++++++++++++++
 .../boot/dts/freescale/imx93-phycore-som.dtsi |   2 +-
 5 files changed, 448 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-charge-control-y.d=
ts

=2D-=20
2.43.0

