Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7E63AFD10;
	Thu,  3 Sep 2026 08:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422705; cv=none; b=imyxmZJFYrcI7QpP2CRsWLPKU5WXDQzisW4mKMuT52ZY14AlujwLZyswLmilBGl+BmqCIBfu7aqo5maAyYuCtqFsl8V8L86BA5YDgdDkWTM9BsWs1GBfPitOo6nHfsyMWWTlk3uzu+cuCG/j6aSl64Ecognt6z4iq5uUyJFgjEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422705; c=relaxed/simple;
	bh=Fp/o9hybC4wJmmRh0x/iIbnaciLExfhTvEVTymmRSgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjTz3qHL6jhhM5+l3eMqfWPYRnCP2RUXNjDPHhJzx8LTuHVBoH0tii4vGX0C5cPktDiXH6g1eTugWux8hsuBnM/NqbOn9aSWCrJFYaxMhTdeh6m5kx5/VhdMaQollcwfv0wdsw2Uydf6uvpiCcMDwu4dO/WFrQGL6Ecr9SBmH50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=NTiCsdCh; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="NTiCsdCh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1788422674; x=1789027474; i=wahrenst@gmx.net;
	bh=SbUbozxUGzpITZtxqnEMX2dsAlny/7h0W5OG4hRNJlQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NTiCsdChl5S9Ozjty3PkB5X6Rg0zL5G0aJOUnYd0W8LHHVEUOxGKVBKFJrJBUw82
	 i3T4H0dgAs6dEUnhzMv4sI8rWwm7dJ81HTq3DTx+WJ0mqspJ89r0eiYICuAHyVpUs
	 ZgDfNvxVe7mId985iA+3LlvCY99D+hLBjRlrMHr/XkkFMEk8UTZ9bQqoIs5pX4zeK
	 lasJHmhIMo7Mz4AVulHSuk73G5Qr5+D8Aez9XrLEhG0avhnitSBJP7G2PYstQQjcf
	 CWVlClNjUN1dnNdPn4Dp6TVcxbobvC6kLu5Uo+4Ozt5eImzYNrqM0ni+XA0fGn6Mg
	 muYQb+p1bXtZxTKDPg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7b6l-1wwHGu38bV-006cN4; Thu, 03
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
	Martin Lukas <martin.lukas@chargebyte.com>,
	Michael Heimpold <michael.heimpold@chargebyte.com>
Subject: [PATCH V4 4/4] arm64: dts: freescale: Add chargebyte Charge Control Y
Date: Thu,  3 Sep 2026 10:04:27 +0200
Message-ID: <20260903080427.6103-5-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:frPwyEJ34nn0ShChuuz0GR06y5x7V1jjD/txtLY+fFOnkEvcVVs
 GHFiqVpnqxz8XKZ+IIr/5OaSH1PkniEHStktdu4uG4RlJF8JHbDIuVNwWlnAVDo8N6gW2Al
 i/x1Zf0BiOfrE9++kd+Q3bMfkP8/ZXLrCGzfSQUP2XvsVdmNpIFl8YvzBIvWbXUUbZcARHr
 yhOmAWX4UUgN5UfvOUIaw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yDy4oVQP+fA=;0JV3awkhfnzOrBSkg9SAQ+Rec8N
 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

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
 .../dts/freescale/imx93-charge-control-y.dts  | 439 ++++++++++++++++++
 .../boot/dts/freescale/imx93-phycore-som.dtsi |   2 +-
 3 files changed, 441 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-charge-control-y.d=
ts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/=
freescale/Makefile
index 95ae85ab4adf..8817992218a5 100644
=2D-- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -652,6 +652,7 @@ imx93-11x11-frdm-pixpaper-dtbs +=3D imx93-11x11-frdm.d=
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
index 000000000000..ba240f528f9b
=2D-- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-charge-control-y.dts
@@ -0,0 +1,439 @@
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
+		compatible =3D "microchip,mcp2542", "ti,tcan1042";
+		#phy-cells =3D <0>;
+		max-bitrate =3D <1000000>;
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible =3D "regulator-fixed";
+		enable-active-high;
+		gpio =3D <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_reg_usdhc2_vmmc>;
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+		regulator-name =3D "VCC_SD";
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
+	pinctrl-0 =3D <&pinctrl_gpio1>, <&pinctrl_lan8651_rst>;
+	gpio-line-names =3D "", "", "", "X_nRST_LAN", "",
+			  "", "LPUART2_RX", "LPUART2_TX", "CAN1_TX", "CAN1_RX",
+			  "", "SPI_TPM_nCS0", "", "", "",
+			  "";
+};
+
+&gpio2 {
+	gpio-line-names =3D "", "", "", "", "",
+			  "", "", "X_LAN_nIRQ", "X_LAN_nCS", "",
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
+			  "", "", "", "", "",
+			  "", "";
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
+
+		/*
+		 * Since GPIO reset management for the LAN8651 has not yet been
+		 * implemented, X_nRST_LAN should be retained as a GPIO in
+		 * userspace for the rare case that a reset via SPI does not work.
+		 */
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
+	};
+};
+
+/* SD */
+&usdhc2 {
+	pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 =3D <&pinctrl_usdhc2_default>, <&pinctrl_usdhc2_cd>;
+	pinctrl-1 =3D <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_cd>;
+	pinctrl-2 =3D <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_cd>;
+	cd-gpios =3D <&gpio3 00 GPIO_ACTIVE_LOW>;
+	vmmc-supply =3D <&reg_usdhc2_vmmc>;
+	bus-width =3D <4>;
+	disable-wp;
+	no-sdio;
+	no-mmc;
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
+	/* X_nRST_LAN is wired to a pull resistor, so it's not floating */
+	pinctrl_lan8651_rst: lan8651rstgrp {
+		fsl,pins =3D <
+			MX93_PAD_I2C2_SDA__GPIO1_IO03		0x31e
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
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins =3D <
+			MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x31e
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
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins =3D <
+			MX93_PAD_SD2_CLK__USDHC2_CLK		0x119e
+			MX93_PAD_SD2_CMD__USDHC2_CMD		0x4000139e
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x4000138e
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x4000138e
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x4000139e
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x4000139e
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins =3D <
+			MX93_PAD_SD2_CLK__USDHC2_CLK		0x118e
+			MX93_PAD_SD2_CMD__USDHC2_CMD		0x4000139e
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x4000139e
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x4000139e
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x4000139e
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x4000139e
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
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

