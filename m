Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C215013AA;
	Mon,  7 Sep 2026 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788793498; cv=none; b=EHMtakip514f+YTsj0Z9oqALIY9v6kmvZiNPK8cMQSadZRTuiEy03xoV5KfwIIPTFLVzsM1MZJMdTXqeYgyb3F2gs4gUWfzTS490XXYsdJXJVwr8NHHF6IBZywiIljlwiGDVhhoIySfld1bRUxyXy/qzuZLhPzOmXVEJ0E5VfyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788793498; c=relaxed/simple;
	bh=LpYBbIz8G2H5dzIMAYcVw8Wd185OmibrNsy3basptcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1xi1T+nb9Zh81KkDYyxurWHYlma8MRhZx7L/3PrRR6EhnGTbvBj/TZu1i3Lj7tree4GWIjPKD032TGwI+eeHqEzYmWRGWPodYtXA8DpB8+VQsGRhYGcxMea9W3CuHzycN+S+MdY9sN9RXozFe63ya637JCgSeOXoHZJrWcW3vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=qATm95Fa; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="qATm95Fa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1788793470; x=1789398270; i=wahrenst@gmx.net;
	bh=hx/o6ev7a6bqA9WagRi2LXyVv4E0IYot2QPfNlJwxOY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qATm95FasSCi5f7as9ATB4ruF4WlAqYFxCCxgziHuTxT43XpowAP0Y2ffurQwimt
	 wU3DCD6YLSWmEPVGVpsufn00upi844Q1C7DDvOWjqFnnK8hJr2J6J9lQ987aizz6H
	 HO1rcgdYetEAeJkpONu1bVC8NSczVdALd2fbaTIhgti+AvU+jsGY6Q55yzj2qerk5
	 Fn3FfrYpli1oiWqF0Z32k9o44hBJbGLb2AArfzzFWu/IsI6euu3/kdL5hwG/ou5/4
	 F6EDhSRbvOlvmoafrqaE3Fc8Bj0GtXVuZkt60tiDer39LsvhjSKggxUccmHpMmFKl
	 NBXfr45k5M/n3Gxs5w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKsjH-1xI74S3dqn-00IyYE; Mon, 07
 Sep 2026 17:04:30 +0200
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
Subject: [PATCH V5 4/4] arm64: dts: freescale: Add chargebyte Charge Control Y
Date: Mon,  7 Sep 2026 17:04:20 +0200
Message-ID: <20260907150420.18787-5-wahrenst@gmx.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907150420.18787-1-wahrenst@gmx.net>
References: <20260907150420.18787-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kEjf6zQ2C6PGwy/5OjHMcj0PLKr5fb1wEjY/u9sa03OucoLjPFW
 guiomxeej7DE05klZCB7l+qtgL+vu6hqYH8CY/C4As61kCmM3o9KWr/1aipjcw8tDmHQj2n
 k1rNgS+PrITHPkV/f4ntwPtb55uR+EJo9eF5wTf2+xqYtoQ+aybZS9eXk8WRmwtJWxrLZ95
 qURqo3ybrOgpahCFJ7UYQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Sn0geV37yds=;CeYN4MI5AqbNr9lbQgPFsXcdek6
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
 .../dts/freescale/imx93-charge-control-y.dts  | 438 ++++++++++++++++++
 .../boot/dts/freescale/imx93-phycore-som.dtsi |   2 +-
 3 files changed, 440 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-charge-control-y.d=
ts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/=
freescale/Makefile
index 984642146dd9..46b6237f0fcb 100644
=2D-- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -886,6 +886,7 @@ imx93-11x11-frdm-pixpaper-dtbs +=3D imx93-11x11-frdm.d=
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
index 000000000000..7c5666cd4730
=2D-- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-charge-control-y.dts
@@ -0,0 +1,438 @@
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
+// Heartbeat LED of phyCore is not populated
+/delete-node/ &pinctrl_leds;
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

