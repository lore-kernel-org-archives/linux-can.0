Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF604A0149;
	Wed,  2 Sep 2026 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355727; cv=none; b=Vj5/0HL+MqrWcle1JETtYN5P1kTmyJ6OQAa9ie+kEF194uQS+ccvgspqBT+3E4H9t5rNjWyNmkpzBNNavi6jVPVd32GIm6UuPrqFRLMj1gCZVAtZl0QHctXSV5Z7xQHRs2SS6GwoIXTInP8BzXvo3t83v81BGfz+0onN5WsyRww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355727; c=relaxed/simple;
	bh=Fp/o9hybC4wJmmRh0x/iIbnaciLExfhTvEVTymmRSgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYLaB3fmYVove7pOGYMa6bDBCmtAielpck1E63jxFF6ca6nAJSvIvNDoIir/kk+IRcrYKMi3OJ9nxzykthfnXjvDyfym9pvHJRUHzgSNF3CDO80hDzuze2BdI5bnNECCrngAvChHhpwJM1q0mt81o2BcQgMIoFk3aRJ3hvK1SZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=JiROSqHA; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="JiROSqHA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1788355696; x=1788960496; i=wahrenst@gmx.net;
	bh=SbUbozxUGzpITZtxqnEMX2dsAlny/7h0W5OG4hRNJlQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JiROSqHAiLQKdB6wMFHRluLHmru9MDbLh2GcH4buadAqjB4jEsnL2qIaVjMcTdg6
	 JInAArCRPQm3JxNL8yJ4idyhWhh8OPRw3PjGQdvD+hWTElrrWsDSJde4yO+Duzrjc
	 MClX08ZW8fanfw1CIbnkVoJVtEYqFVPbP/KmuexxEC32ABCQkDOnnUaLjEWv349fC
	 UVPNxuddpQmhQgxRNdyyyJwesPBCi9ibhcltEwMQqo4RgpBZxttvtssbIqFbKaG0U
	 uWNcW76sK6iLD2mwDk1NfaOB1dWXVRO/Cb7mcVyp+wYARQY/EfPm6CSo6rlFQMOXl
	 HoAnROWHSxi+L0OI2Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2O2W-1x1DJB3KBi-0032BE; Wed, 02
 Sep 2026 15:28:15 +0200
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
Subject: [PATCH V3 3/3] arm64: dts: freescale: Add chargebyte Charge Control Y
Date: Wed,  2 Sep 2026 15:28:00 +0200
Message-ID: <20260902132801.22056-4-wahrenst@gmx.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902132801.22056-1-wahrenst@gmx.net>
References: <20260902132801.22056-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9vjtwmsM0goc9j2PKfS9jm9/1tLZwJT7GS7UX9KdVRu3jzs8zcE
 sMuJmVrXkUQsYHck+m7Hj5e8O/ZjExbkSoATMtIj1Yyb9UrYGwiV2QmlxyckaYlju/28O6O
 H83sC8lWkmhwIM6wZqlqxHZin2wXOr1NO2Nz75/0uguFCcH6uD4MMkAnW5kOrq1XgiRui+H
 f1tpt8zR8DwEGUTAYNa+Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZUtIABAegq8=;IOMUVWp9kLmC9H4Sop7Dt4LcVm3
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

