Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8468C4CA29E;
	Mon,  7 Sep 2026 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788793472; cv=none; b=qKKWV2WZTo/IybN3VfaFDfaq789VMpxMXl7Ltz1W5Zm84fI83SWYRD5U3fHalOLHjFaVBnHaP46oq4VqTA4/ghxgKavP6ZaYkDfFlZSWT7LQHNC7KVyJHvj7euvyc6ig0CMiu7o3U0qBfdhsLKIjVhQIgQ7FRwIBl8tJ1JjxESo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788793472; c=relaxed/simple;
	bh=MqRp+yAXUOJBT54SRxW8JHPpLhcjeyiIOt3B8BsJOFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jrl7kpOje/UAWYqq59Bhk0LY22gpuQKaEF2YYOPA6OgwprjNduZkm6HLGGN6hTY6EXP/A1aTP57dm/GqOIfJEsOx/QN/rU0a8PcZ3AmESmRd8VF7XzsH/t51RwcDZj1zWgp1yaUHJLbCyLVtxBFm53Y5LWUlS/3ZZ1DtpO5vKf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=inQopaW4; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="inQopaW4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1788793466; x=1789398266; i=wahrenst@gmx.net;
	bh=xQ+f5XAMDAG+ZbBglr/uBEDXOEuEIpNsBndq8fnp9Ck=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=inQopaW4yPYFpEj8pstPEEoHD6atFnx0cYa1+fJNkII28d3aNA2r5jsl6t4VqH9P
	 HotlSbRhBqOkM8VftXYoBi2BWsQ4keBsafCh6/ekDc/ryMhz/1bYVa8q4HL2x5x1g
	 i5aMfMB4GcEJjvHZmMtvQ7nFGku0U1cchbA07jsOKhABw2wZd0cjd3rGGnzhQmtVp
	 kTJMgb/oj6EU+F7wlZMquZvaprgrB2wUwYXQ30TVMecLy3f7rjBY1q9Oz5pGeWcF7
	 ocVV1hm9VqCJfaUoj0qk/uC1sJe/Id6c/XJnZS5VbVbTwyHyq7KiFWZRP1ZSD+mr0
	 dC2pw0usLTBD70DkXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MaJ3n-1xOilj2BHx-00YR0s; Mon, 07
 Sep 2026 17:04:26 +0200
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
Subject: [PATCH V5 0/4] arm64: dts: freescale: Add chargebyte Charge Control Y
Date: Mon,  7 Sep 2026 17:04:16 +0200
Message-ID: <20260907150420.18787-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DnsIFneolBsP5731lClCrVtY43lVIlNwNDBv3/CEI+EIiRYKuY+
 1J8n/O1o3KFqo9dwoEqvbb3GUseOMFux9qdhaHAhXmTkHnVSSm4UGzCRkLFNtKhPtszgJhH
 u0Ghqok6pGivobBG5WQgniEyfk1cNRIss03LQNMd2aafmKEBK8saoOHwv3Np1K7/sck3HWN
 fOrz2/WgMKhmSO1aHpEYw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZZ5Pglu5rR4=;x3Gw7OCdcXuCYFEj659isD+JtmM
 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
 rzDHRdB+Hpo/vdfGk1BQVPybqIoUsAU3kGA==

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

sashiko complained in the fourth version of the series [2] about the
reset polarity of ethphy2 and the different drive strength across the
data lines. Both is intended.

[1] - https://lore.kernel.org/linux-devicetree/20260818093147.E556C1F000E9=
@smtp.kernel.org/
[2] - https://lore.kernel.org/linux-devicetree/20260903082122.A777C1F000E9=
@smtp.kernel.org/

Changes in V5:
- fix delete-node for pinctrl_leds (reported by sashiko)
- add Krzysztof's Reviewed-by

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
 .../dts/freescale/imx93-charge-control-y.dts  | 438 ++++++++++++++++++
 .../boot/dts/freescale/imx93-phycore-som.dtsi |   2 +-
 5 files changed, 447 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-charge-control-y.d=
ts

=2D-=20
2.43.0

