Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E67445ADD;
	Tue, 18 Aug 2026 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787044638; cv=none; b=YQXM5fcHcyqLI5+48VoFV6p0JvnOaQRbSnAdYmbB1xNaP6uJhJvYU6liKy7VYhPfcaMteUHyAwYL4dKhs9VTTkvJpacy+j+rWB98sj3Xdo3bjMAXyyFCchxY0SqfKwzhYuK/q4hQVgU2JYd1d4sUyumKzvF6g/Bb4U0APc9r4HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787044638; c=relaxed/simple;
	bh=SWEqCKsyzizETPKe690JFXIsxb2SzAOYwk+8FxXTZtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pp6J7Lnc8kmadjpdit4g+VBjnAu00Www9F02fDotQ/kt+xN9VZG5Xles+G1JCZuS23fRqsmxgYIQigBqtdb6xCQ+ZgEyhdk3oJIaX1Qglew3Zv2E3p01yLjLZJaHf5b3x6/fsfQowVSsUenLbD2EGi7q83YsWNO/XnbtJJ03BgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=hewsQjkI; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="hewsQjkI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1787044633; x=1787649433; i=wahrenst@gmx.net;
	bh=s0OvcKwFxHPUXxIR9GFpDMu537gRJBoKflIZLIzEGJk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hewsQjkIWUOVry6up5eZy3cJbc9JDFK+Oc2m88MUOo878OmDBac5BRgSpZ8aE64C
	 e0w1QjLdQpKdRNNjiecVYdhduaW1JPc6VLEI5pC8VdwHEbHPxbePVp71ou5c2hmeR
	 WhKNVpmiXTnAcdLpvyz8vB50p0KE4zeBYqXUgTjregosJnbgVN+zKuVIzINXfZjpT
	 OHUnVOcjfalghrV9e8COL4WPPAkYBuIaS8MVi1UBWn3NQI7FGoAa/lgtAjyWVb2Rv
	 OC8bNuuRfTelu/k0YbE24kR5lHTLFzHBF7f6ND3LzAajoj1UmN+fdZ/xX9ZnWqod5
	 8Mi6s/M5wLIAvG59qQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEV3I-1xCC7H1hpy-00968O; Tue, 18
 Aug 2026 11:17:13 +0200
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
	Martin Lukas <martin.lukas@chargebyte.com>,
	Michael Heimpold <michael.heimpold@chargebyte.com>
Subject: [PATCH RFC 4/4] arm64: dts: freescale: Add chargebyte Charge Control Y
Date: Tue, 18 Aug 2026 11:17:01 +0200
Message-ID: <20260818091701.6441-5-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:5LL7RQKkCymDckDciWYdgQ9KBu1LY/YLGPozbl8Xoy506EA6heY
 7jEU1yXk9aQ7gLdBJm2/2y7vLwUMYq7gonhmwpIStOjxqC0i+nRA3JvmnGSPbTfWaVdioMW
 LwawghoCtDfb1W8DnNQ/Jdk+p17P34O7XsZG5DtVGrFGgu2z4VcMwyp7Jmerkfqgsx5IWd3
 2LPCL1rX83uWHUKKzXogg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HYQXPemqRCM=;fAFBEyIeCB+o5IPc8FREKcE4mZT
 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
 D8sgCrN8AbcdZCcT5sc=

This adds the support for chargebyte Charge Control Y, which is
an Electrical Vehicle Supply Equipment (EVSE) for MCS (Megawatt
Charging System) charging stations (according to IEC 61851-23-1).

chargebyte Charge Control Y uses phyCORE-i.MX 93 ARM
- NXP i.MX93 1.7 GHz
- 1 GB DDR4 RAM
- up to 8 GB eMMC
- 2x 100 MBit/s Ethernet interfaces
- 10BASE-T1S Ethernet for MCS communication
- CAN interface
- separate safety chip
- TPM chip
- power buffered RTC

Co-developed-by: Martin Lukas <martin.lukas@chargebyte.com>
Signed-off-by: Martin Lukas <martin.lukas@chargebyte.com>
Co-developed-by: Michael Heimpold <michael.heimpold@chargebyte.com>
Signed-off-by: Michael Heimpold <michael.heimpold@chargebyte.com>
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx93-charge-control-y.dts  | 387 ++++++++++++++++++
 .../boot/dts/freescale/imx93-phycore-som.dtsi |   2 +-
 3 files changed, 389 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-charge-control-y.d=
ts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/=
freescale/Makefile
index 8ddaab127ab9..c64902dfc6f3 100644
=2D-- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -594,6 +594,7 @@ imx93-11x11-frdm-pixpaper-dtbs +=3D imx93-11x11-frdm.d=
tb imx93-11x11-frdm-pixpaper
 dtb-$(CONFIG_ARCH_MXC) +=3D imx93-11x11-frdm-pixpaper.dtb
=20
 dtb-$(CONFIG_ARCH_MXC) +=3D imx93-14x14-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) +=3D imx93-charge-control-y.dtb
 dtb-$(CONFIG_ARCH_MXC) +=3D imx93-kontron-bl-osm-s.dtb
 dtb-$(CONFIG_ARCH_MXC) +=3D imx93-phyboard-nash.dtb
 dtb-$(CONFIG_ARCH_MXC) +=3D imx93-phyboard-segin.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx93-charge-control-y.dts b/ar=
ch/arm64/boot/dts/freescale/imx93-charge-control-y.dts
new file mode 100644
index 000000000000..348a3a24887b
=2D-- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-charge-control-y.dts
@@ -0,0 +1,387 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2025-2026 chargebyte GmbH
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "imx93-phycore-som.dtsi"
+
+/ {
+	model =3D "chargebyte Charge Control Y";
+	compatible =3D "chargebyte,imx93-charge-control-y", "phytec,imx93-phycor=
e-som", "fsl,imx93";
+
+	aliases {
+		ethernet0 =3D &fec;
+		ethernet1 =3D &lan8651;
+		ethernet2 =3D &eqos;
+		gpio0 =3D &gpio1;
+		gpio1 =3D &gpio2;
+		gpio2 =3D &gpio3;
+		gpio3 =3D &gpio4;
+		mmc0 =3D &usdhc1;
+		mmc1 =3D &usdhc2;
+		rtc0 =3D &rv3028;
+		rtc1 =3D &bbnsm_rtc;
+		serial0 =3D &lpuart1;
+		serial1 =3D &lpuart2;
+		serial2 =3D &lpuart3;
+		serial3 =3D &lpuart4;
+		serial4 =3D &lpuart5;
+	};
+
+	chosen {
+		stdout-path =3D &lpuart1;
+	};
+
+	// Heartbeat LED of phyCore is not populated
+	/delete-node/ leds;
+
+	flexcan1_tc: can-phy0 {
+		compatible =3D "microchip,mcp2542";
+		#phy-cells =3D <0>;
+		max-bitrate =3D <1000000>;
+	};
+
+	user_leds: user-leds {
+		compatible =3D "gpio-leds";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_user_leds>;
+
+		led_user_green: led-user-green {
+			color =3D <LED_COLOR_ID_GREEN>;
+			function =3D LED_FUNCTION_BOOT;
+			gpios =3D <&gpio2 24 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger =3D "timer";
+		};
+
+		led_user_red: led-user-red {
+			color =3D <LED_COLOR_ID_RED>;
+			function =3D LED_FUNCTION_SD;
+			gpios =3D <&gpio2 25 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger =3D "mmc1";
+		};
+	};
+};
+
+&eeprom0 {
+	nvmem-layout {
+		compatible =3D "fixed-layout";
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+
+		/* Wired ethernet interface */
+		eth1_mac_address: base-mac-address@100 {
+			compatible =3D "mac-base";
+			reg =3D <0x100 0x6>;
+			#nvmem-cell-cells =3D <1>;
+		};
+
+		/* MCS ethernet interface */
+		eth2_mac_address: base-mac-address@108 {
+			compatible =3D "mac-base";
+			reg =3D <0x108 0x6>;
+			#nvmem-cell-cells =3D <1>;
+		};
+	};
+};
+
+/* Ethernet 2 */
+&eqos {
+	phy-mode =3D "rmii";
+	phy-handle =3D <&ethphy2>;
+	assigned-clocks =3D <&clk IMX93_CLK_ENET_TIMER2>,
+			  <&clk IMX93_CLK_ENET>;
+	assigned-clock-parents =3D <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
+				 <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
+	assigned-clock-rates =3D <100000000>, <50000000>;
+
+	nvmem-cells =3D <&eth1_mac_address 0>;
+	nvmem-cell-names =3D "mac-address";
+
+	status =3D "okay";
+};
+
+/* Ethernet 1 PHY */
+&ethphy1 {
+	ti,leds-polarity =3D <1>; // active-high
+};
+
+/* Ethernet 1 */
+&fec {
+	/* Since MDIO bus is handled by FEC, all PHY strap pins and
+	 * reference clock must be initialized at the same time.
+	 */
+	pinctrl-0 =3D <&pinctrl_fec &pinctrl_eqos &pinctrl_eqos_strap>;
+};
+
+&flexcan1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_flexcan1>;
+	phys =3D <&flexcan1_tc>;
+	status =3D "okay";
+};
+
+&gpio1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_gpio1>;
+	gpio-line-names =3D "", "", "", "X_nRST_LAN", "",
+			  "", "LPUART2_RX", "LPUART2_TX", "CAN1_TX", "CAN1_RX",
+			  "", "SPI_TPM_nCS0", "", "", "",
+			  "";
+};
+
+&gpio2 {
+	gpio-line-names =3D "X_LAN_nCS", "", "", "", "",
+			  "", "", "X_LAN_nIRQ", "", "",
+			  "", "", "", "", "",
+			  "", "", "", "", "",
+			  "", "", "", "", "GREEN_LED",
+			  "RED_LED", "", "", "", "";
+};
+
+&gpio3 {
+	gpio-line-names =3D "SD2_nCD", "", "", "", "",
+			  "", "", "SD2_nRESET", "", "",
+			  "", "", "", "", "",
+			  "", "", "", "", "",
+			  "SOM_EMMC_nRESET", "", "", "", "",
+			  "", "", "", "X_TDI", "X_TMS_SWDIO",
+			  "", "X_TDO";
+};
+
+&gpio4 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_gpio4>;
+	gpio-line-names =3D "", "", "X_RTC_nINT", "", "",
+			  "", "", "", "", "",
+			  "", "", "SAFETY_BOOTMODE_SET", "ENET1_RST", "",
+			  "", "", "", "", "",
+			  "", "SOM_EEPROM_WP", "", "SOM_PHY_RESET", "",
+			  "", "", "PMIC_IRQ_B", "nSAFETY_RESET_INT", "SPI_TPM_nINT0";
+};
+
+&lpi2c1 {
+	clock-frequency =3D <400000>;
+	pinctrl-names =3D "default", "gpio";
+	pinctrl-0 =3D <&pinctrl_lpi2c1>;
+	pinctrl-1 =3D <&pinctrl_lpi2c1_gpio>;
+	scl-gpios =3D <&gpio1 00 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios =3D <&gpio1 01 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	#address-cells =3D <1>;
+	#size-cells =3D <0>;
+	status =3D "okay";
+
+	rv3028: rtc@52 {
+		compatible =3D "microcrystal,rv3028";
+		interrupts =3D <2 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent =3D <&gpio4>;
+		wakeup-source;
+		trickle-resistor-ohms =3D <3000>;
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_rtc>;
+		reg =3D <0x52>;
+	};
+};
+
+&lpspi1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_lpspi1>;
+	num-cs =3D <1>;
+	cs-gpios =3D <&gpio1 11 GPIO_ACTIVE_LOW>;
+	status =3D "okay";
+
+	tpm@0 {
+		compatible =3D "infineon,slb9670", "tcg,tpm_tis-spi";
+		reg =3D <0>;
+		spi-max-frequency =3D <10000000>;
+		interrupt-parent =3D <&gpio4>;
+		interrupts =3D <29 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+/* MCS Ethernet SPI */
+&lpspi3 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_lpspi3>;
+	num-cs =3D <1>;
+	cs-gpios =3D <&gpio2 8 GPIO_ACTIVE_LOW>;
+	status =3D "okay";
+
+	lan8651: ethernet@0 {
+		compatible =3D "microchip,lan8651", "microchip,lan8650";
+		reg =3D <0>;
+		interrupt-parent =3D <&gpio2>;
+		interrupts =3D <7 IRQ_TYPE_LEVEL_LOW>;
+		spi-max-frequency =3D <25000000>;
+
+		nvmem-cells =3D <&eth2_mac_address 0>;
+		nvmem-cell-names =3D "mac-address";
+	};
+};
+
+&lpuart1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_uart1>;
+	status =3D "okay";
+};
+
+&lpuart3 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_uart3>;
+	status =3D "okay";
+};
+
+/* Ethernet 2 PHY */
+&mdio {
+	ethphy2: ethernet-phy@2 {
+		reg =3D <2>;
+		compatible =3D "ethernet-phy-id2000.a140";
+		clocks =3D <&clk IMX93_CLK_ENET_REF_PHY>;
+		reset-gpios =3D <&gpio4 13 GPIO_ACTIVE_HIGH>;
+		reset-assert-us =3D <30>;
+		reset-deassert-us =3D <50000>;
+		ti,leds-polarity =3D <1>; // active-high
+	};
+};
+
+/* SD */
+&usdhc2 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_usdhc2_default>, <&pinctrl_usdhc2_cd>;
+	cd-gpios =3D <&gpio3 00 GPIO_ACTIVE_LOW>;
+	bus-width =3D <4>;
+	disable-wp;
+	no-sdio;
+	no-mmc;
+	no-1-8-v;
+	status =3D "okay";
+};
+
+&iomuxc {
+
+	// Heartbeat LED of phyCore is not populated
+	/delete-node/ pinctrl_leds;
+
+	pinctrl_eqos: eqosgrp {
+		fsl,pins =3D <
+			MX93_PAD_ENET1_TD2__CCM_ENET_QOS_CLOCK_GENERATE_REF_CLK		0x4000057e
+			MX93_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0				0x50e
+			MX93_PAD_ENET1_TD1__ENET_QOS_RGMII_TD1				0x50e
+			MX93_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL			0x50e
+		>;
+	};
+
+	pinctrl_eqos_strap: eqosstrapgrp {
+		fsl,pins =3D <
+			MX93_PAD_ENET1_RXC__ENET_QOS_RX_ER		0x17e
+			MX93_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0		0x17e
+			MX93_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1		0x17e
+			MX93_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL	0x17e
+		>;
+	};
+
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins =3D <
+			MX93_PAD_PDM_BIT_STREAM0__CAN1_RX	0x139e
+			MX93_PAD_PDM_CLK__CAN1_TX		0x1382
+		>;
+	};
+
+	pinctrl_gpio1: gpio1grp {
+		fsl,pins =3D <
+			MX93_PAD_I2C2_SDA__GPIO1_IO03		0x31e
+			MX93_PAD_PDM_BIT_STREAM1__GPIO1_IO10	0x382
+		>;
+	};
+
+	pinctrl_gpio4: gpio4grp {
+		fsl,pins =3D <
+			MX93_PAD_ENET1_TXC__GPIO4_IO07		0x382
+			MX93_PAD_ENET1_RD2__GPIO4_IO12		0x39e
+			MX93_PAD_CCM_CLKO3__GPIO4_IO28		0x39e
+			MX93_PAD_ENET1_RD3__GPIO4_IO13		0x31e
+		>;
+	};
+
+	pinctrl_lpi2c1: lpi2c1grp {
+		fsl,pins =3D <
+			MX93_PAD_I2C1_SCL__LPI2C1_SCL		0x40000b86
+			MX93_PAD_I2C1_SDA__LPI2C1_SDA		0x40000b86
+		>;
+	};
+
+	pinctrl_lpi2c1_gpio: lpi2c1gpiogrp {
+		fsl,pins =3D <
+			MX93_PAD_I2C1_SCL__GPIO1_IO00		0x40000b9e
+			MX93_PAD_I2C1_SDA__GPIO1_IO01		0x40000b9e
+		>;
+	};
+
+	pinctrl_lpspi1: lpspi1grp {
+		fsl,pins =3D <
+			MX93_PAD_CCM_CLKO4__GPIO4_IO29		0x186
+			MX93_PAD_SAI1_TXFS__GPIO1_IO11		0x186
+			MX93_PAD_SAI1_TXC__LPSPI1_SIN		0x186
+			MX93_PAD_SAI1_TXD0__LPSPI1_SCK		0x186
+			MX93_PAD_SAI1_RXD0__LPSPI1_SOUT		0x186
+		>;
+	};
+
+	/* PinCtrl MCS LAN SPI */
+	pinctrl_lpspi3: lpspi3grp {
+		fsl,pins =3D <
+			MX93_PAD_GPIO_IO07__GPIO2_IO07		0x186
+			MX93_PAD_GPIO_IO08__GPIO2_IO08		0x186
+			MX93_PAD_GPIO_IO09__LPSPI3_SIN		0x186
+			MX93_PAD_GPIO_IO10__LPSPI3_SOUT		0x186
+			MX93_PAD_GPIO_IO11__LPSPI3_SCK		0x186
+		>;
+	};
+
+	pinctrl_rtc: rtcgrp {
+		fsl,pins =3D <
+			MX93_PAD_ENET1_TD3__GPIO4_IO02		0x31e
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins =3D <
+			MX93_PAD_UART1_RXD__LPUART1_RX		0x31e
+			MX93_PAD_UART1_TXD__LPUART1_TX		0x30e
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins =3D <
+			MX93_PAD_GPIO_IO15__LPUART3_RX		0x31e
+			MX93_PAD_GPIO_IO14__LPUART3_TX		0x30e
+		>;
+	};
+
+	pinctrl_usdhc2_cd: usdhc2cdgrp {
+		fsl,pins =3D <
+			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc2_default: usdhc2grp {
+		fsl,pins =3D <
+			MX93_PAD_SD2_CLK__USDHC2_CLK		0x119e
+			MX93_PAD_SD2_CMD__USDHC2_CMD		0x4000139e
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x4000138e
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x4000138e
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x4000138e
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x4000139e
+		>;
+	};
+
+	pinctrl_user_leds: userledgrp {
+		fsl,pins =3D <
+			MX93_PAD_GPIO_IO24__GPIO2_IO24		0x31e
+			MX93_PAD_GPIO_IO25__GPIO2_IO25		0x31e
+		>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi b/arch/a=
rm64/boot/dts/freescale/imx93-phycore-som.dtsi
index 325e465d0056..489ed3f7fb61 100644
=2D-- a/arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi
@@ -201,7 +201,7 @@ ldo5: LDO5 {
 	};
=20
 	/* EEPROM */
-	eeprom@50 {
+	eeprom0: eeprom@50 {
 		compatible =3D "atmel,24c32";
 		reg =3D <0x50>;
 		pagesize =3D <32>;
=2D-=20
2.43.0

