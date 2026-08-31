Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F151E3DAABB;
	Mon, 31 Aug 2026 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788165378; cv=none; b=RRKQyab24LpJbqn7+g+cYc1/4YDhN4fbmANSPPdG3XhpQEa/g5BKhwG9yAH7iv2uKvfnaj9xSsPrdBBFHRsSbKVxKEIGbibREZY95b4iItQIBteB+9wmL+dpjMfbXeqKXJCYIls7AsOVXErOdwOWrKgtSkVyLLbZWrLxdKCFFH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788165378; c=relaxed/simple;
	bh=n2YnfU341xdPKSwP11+KQs4zPF6ddkh8hUvggBjhIrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSe1a0kg537iPdUN3CYZULUe1nD9XfebSP15/n29ExJ6uwKcycZm/iJ2A00buGV+RCLVKU8Y4J7MzDs/yjgLNhupj5hPKxBXCgWXGykjIh39S+xbMsz7tKLGBCP2uO++aqWZ/a3Z4y3na55XUki84CGhEcxjH/cm/rTqfvDkuPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Mne736KQ; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Mne736KQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1788165347; x=1788770147; i=wahrenst@gmx.net;
	bh=G5CuaOQNRUreviF5QjFWVFnXJ0UNKQzKA4KdvOmwr6o=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Mne736KQRzNu7qPOPp5jmQUuLyOCcR91dDHGGtMiweBT11hIulfM20yVxVnqYvbr
	 /wihNBeGTZE9hwz0CQldKz/MnF6Z11gKywJaoesVtY85NI0LGG9PzOMfxBNyU9/pi
	 8U0vqyL1DUFwGLUBrPp7aO4dEzi1mw8Ld8hXiB2mrv8CvYVu2kRjVawJvI/iqLr/V
	 5ur2uJ92oIfuT/0O2pprjSVzIc9MPP9Jue/KIbEmYTJhUyWpJ4qaahNbYu8oyoXPx
	 xApvI2GQHHANvz/huoZ+4A6mbYGLGFvuwX6XLwI4aNuEEy7ZwLNjMuROAIfanHNrR
	 h+lZ4sNWzYRl2Jqpow==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N49lJ-1ws3Xf3BWD-00wMjK; Mon, 31
 Aug 2026 10:35:46 +0200
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
Subject: [PATCH V2 3/3] arm64: dts: freescale: Add chargebyte Charge Control Y
Date: Mon, 31 Aug 2026 10:35:39 +0200
Message-ID: <20260831083539.8287-4-wahrenst@gmx.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831083539.8287-1-wahrenst@gmx.net>
References: <20260831083539.8287-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oCqUOiVcnqErOtIsfSQ8bYPqiNLLB9wsbsUaMc1DX5u4f1oQ+rb
 6PP5gtSWsUEb9+9mCGXEzHU1fs7T9aNOLPF/laydYUiwjv29Ju9EVKL1SPktJdyJ3fDT5Ls
 lyKho/2Mdp0qeOHlhe6YQF75Y2joYOluKajhBWjbkmmfO3GJz3HQ7EPvClmdRQ1XsfppZIz
 Qzk1UA1mgYIqPqL7sQTZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:O1z7OtwuPqo=;kHECKXJaCb4i/rU7q4xCvMlVxJn
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
 .../dts/freescale/imx93-charge-control-y.dts  | 426 ++++++++++++++++++
 .../boot/dts/freescale/imx93-phycore-som.dtsi |   2 +-
 3 files changed, 428 insertions(+), 1 deletion(-)
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
index 000000000000..0405098cc05c
=2D-- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-charge-control-y.dts
@@ -0,0 +1,426 @@
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
+	pinctrl-0 =3D <&pinctrl_gpio1>;
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

