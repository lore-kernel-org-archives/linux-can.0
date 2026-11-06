Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794006490;
	b=06ZlNJB39XPNSAyvCWAmOWd9M4rtXsUTsfxtQYSxttafQgh2k6b/oeoZRgx0O+JOMjTt
	 WRXLY/0KLIkhrntoZ2j2SNnSeeiUwRrPDOLnD2J17f9vOIqwDrRPXePywdgRtxLIDbA49
	 LbPIoRcqtgRXsv29+NJ7b/liwgWAp47YzYbrIAwjCVCFEO+1ct7IM8xlWDjhmYExrPhT0
	 jrH9Zaevp0ZUXeKKj0i1SOD3YftxASK67aNGoIRUr9+hVwxFKac1yUtvIbBCCKJ1Pxds0
	 GL+9dbgjkoaeR8FPB4uqvmZ79KL+Fk7v1tU5+THQOLvY3VOKAX2vKH2NMzfysJMnMPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794006490;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=i1PWLC3z8H8jzlrLhFnG5KaswhUfnp3kDROS88cQmeg=;
	b=4i73AITs9+CqlBDzDlOWzEgDGWWDGIWcULjFWRtOlUZVtjBIdbvR/zbhfXXMFLPgIvHu
	 64hBFgq5mYKFA/UCYKneNM23k90DLTJ8hEOoA2KhyD1kMv82J3SZvN6mcsLcX2Rj8F498
	 RYzJxx22hS+cixb+V6++L+cvfNNZTdIyeETgVZ+iYZevPvstSIniJj/cxadz5lkuq1pw+
	 h38UvS+9kNHGITsF5Fmr/eMdQajGKJ7/+IGqkWawA/vDNX3h8KJff1sZvsHp0av70LH8i
	 eaXxSeh+acqxpcjOg2uwgHKMJfVhSoFbuZuA0fvcwRYgSs6fXgUxTWJEfXC3ugKUl/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.net;
	spf=pass smtp.mailfrom=gmx.net;
	dkim=pass header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=rFRTx8Jv;
	arc=none smtp.remote-ip=212.227.17.20
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950F2606A32D;
	Fri,  6 Nov 2026 23:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 950F2606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=rFRTx8Jv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1794006481; x=1794611281; i=wahrenst@gmx.net;
	bh=i1PWLC3z8H8jzlrLhFnG5KaswhUfnp3kDROS88cQmeg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rFRTx8JviHsMHnlU07YU5hu9A/Hd+FVsG9SU8lMFwm+7RfXK2UrNZQxeHxAGk5sK
	 Ca4iahCdXn8LMjR1I2aMEX7WOaCfwLCf818p6sfh5KJ0deBvBBymBqrJL0IcS6rfV
	 KgHzkbaKsqceO0ATelnl9Zqj/Y2vPfyvohfpoLkFtaUvZCswLs7XQfdWzTTcMH2bC
	 6HnJ3MUOA1RFwkc6bzOs9OUQdV8qZkpOnc+gR/G0AV+w/lzdPz8Rc+R6qqGddKecQ
	 FcN4EuuN90+s2ex6oQVL+XJEewL9K+4ISzcauNpN7jo63OoVSXkISdB20qn/jKC+s
	 WHRMdzjRq15pvZP11w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqb1c-1wm1YX19VI-00fzne; Sat, 07
 Nov 2026 00:08:01 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Vincent Mailhol <mailhol@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	kernel@pengutronix.de,
	Fabio Estevam <festevam@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 5/5] ARM: mxs: add EVAchargeSE board support
Date: Sat,  7 Nov 2026 00:07:45 +0100
Message-ID: <20261106230746.21954-6-wahrenst@gmx.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106230746.21954-1-wahrenst@gmx.net>
References: <20261106230746.21954-1-wahrenst@gmx.net>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tIWuPLUY7Z1+p2pu1Ul/6bBgUgkILXhmYuBSwOeBQhXy+mKwvK9
 khhQAs010XaMRZCNmIgNMochQe++Y2YKKLRVJ92uRikDXswgDBS1VVkWAfwMIgcbRnvd5uV
 zRgi9NL5OL1P/7miKarho/9F3g5jMP0Qsz+8IMxjrOgOlkq1WwsZulrmsz12znLkXlwTIQE
 TZaF2msZOjtGA/t20xqLg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:f1K5Zogfkws=;V5KeBP/XA6lXpqzJv7nOtdd1HJ2
 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
 Kp2NO5u/dcG85227GPdFLfS+cYZny19UYHAdOCs=

EVACharge SE is a ISO 15118 compliant controller for electric vehicle &
charging stations.

Supported features:
  * 128 MB DDR2 RAM
  * eMMC
  * Debug UART
  * 100 Mbit Ethernet
  * USB 2.0 Host interface
  * Powerline communication (QCA700x)
  * CAN/RS232

Link: https://chargebyte.com/products/controllers-modules/evse-controllers=
/evacharge-se
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 arch/arm/boot/dts/nxp/mxs/Makefile            |   1 +
 .../boot/dts/nxp/mxs/imx28-evachargese.dts    | 294 ++++++++++++++++++
 2 files changed, 295 insertions(+)
 create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-evachargese.dts

diff --git a/arch/arm/boot/dts/nxp/mxs/Makefile b/arch/arm/boot/dts/nxp/mx=
s/Makefile
index d72ba702b6fa..4f9997da9ab8 100644
=2D-- a/arch/arm/boot/dts/nxp/mxs/Makefile
+++ b/arch/arm/boot/dts/nxp/mxs/Makefile
@@ -26,6 +26,7 @@ dtb-$(CONFIG_ARCH_MXS) +=3D \
 	imx28-duckbill.dtb \
 	imx28-eukrea-mbmx283lc.dtb \
 	imx28-eukrea-mbmx287lc.dtb \
+	imx28-evachargese.dtb \
 	imx28-evk.dtb \
 	imx28-m28cu3.dtb \
 	imx28-m28evk.dtb \
diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-evachargese.dts b/arch/arm/bo=
ot/dts/nxp/mxs/imx28-evachargese.dts
new file mode 100644
index 000000000000..75ddde226493
=2D-- /dev/null
+++ b/arch/arm/boot/dts/nxp/mxs/imx28-evachargese.dts
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// Copyright (C) 2017 I2SE GmbH
+// Copyright (C) 2026 chargebyte GmbH
+
+/dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/leds/common.h>
+#include "imx28.dtsi"
+
+/ {
+	compatible =3D "chargebyte,imx28-evachargese", "fsl,imx28";
+	model =3D "chargebyte EVAcharge SE";
+
+	aliases {
+		ethernet1 =3D &qca7000;
+	};
+
+	memory@40000000 {
+		reg =3D <0x40000000 0x08000000>;
+		device_type =3D "memory";
+	};
+
+	flexcan1_tc: can-phy0 {
+		compatible =3D "microchip,mcp2562", "ti,tcan1042";
+		max-bitrate =3D <1000000>;
+		#phy-cells =3D <0>;
+	};
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible =3D "mmc-pwrseq-emmc";
+		pinctrl-0 =3D <&emmc_reset_pin>;
+		pinctrl-names =3D "default";
+		reset-gpios =3D <&gpio2 20 GPIO_ACTIVE_LOW>;
+	};
+
+	leds {
+		compatible =3D "gpio-leds";
+		pinctrl-0 =3D <&led_pins>;
+		pinctrl-names =3D "default";
+
+		led-0 {
+			color =3D <LED_COLOR_ID_RED>;
+			function =3D LED_FUNCTION_HEARTBEAT;
+			gpios =3D <&gpio3 5 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger =3D "heartbeat";
+		};
+
+		led-1 {
+			color =3D <LED_COLOR_ID_YELLOW>;
+			function =3D LED_FUNCTION_PROGRAMMING;
+			gpios =3D <&gpio3 4 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-2 {
+			color =3D <LED_COLOR_ID_YELLOW>;
+			function =3D LED_FUNCTION_ACTIVITY;
+			gpios =3D <&gpio1 16 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-3 {
+			color =3D <LED_COLOR_ID_GREEN>;
+			function =3D LED_FUNCTION_BOOT;
+			gpios =3D <&gpio1 8 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger =3D "timer";
+		};
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible =3D "regulator-fixed";
+		regulator-always-on;
+		regulator-max-microvolt =3D <3300000>;
+		regulator-min-microvolt =3D <3300000>;
+		regulator-name =3D "3P3V";
+	};
+};
+
+&auart0 {
+	pinctrl-0 =3D <&auart0_2pins_a>;
+	pinctrl-names =3D "default";
+
+	status =3D "okay";
+};
+
+&auart2 {
+	pinctrl-0 =3D <&auart2_2pins_b>;
+	pinctrl-names =3D "default";
+
+	status =3D "okay";
+};
+
+&can1 {
+	phys =3D <&flexcan1_tc>;
+	pinctrl-0 =3D <&can1_pins_b>;
+	pinctrl-names =3D "default";
+
+	status =3D "okay";
+};
+
+&duart {
+	pinctrl-0 =3D <&duart_pins_a>;
+	pinctrl-names =3D "default";
+
+	status =3D "okay";
+};
+
+&gpio1 {
+	gpio-line-names =3D "", "", "", "", "",
+			  "", "", "DAUGHTER_GPIO_0", "LED_3", "",
+			  "DAUGHTER_GPIO_1", "", "", "QCA7K_RESET", "QCA7K_GPIO_0",
+			  "QCA7K_GPIO_1", "LED_2", "", "QCA7K_GPIO_2", "",
+			  "", "QCA7K_GPIO_3", "", "", "",
+			  "DAUGHTER_GPIO_2", "", "", "DAUGHTER_GPIO_3", "DAUGHTER_GPIO_4",
+			  "DAUGHTER_GPIO_5";
+	pinctrl-0 =3D <&daughter>;
+	pinctrl-names =3D "default";
+};
+
+&gpio3 {
+	gpio-line-names =3D "", "", "", "", "LED_1",
+			  "LED_0", "", "", "", "",
+			  "", "", "", "", "",
+			  "", "", "", "", "",
+			  "", "", "", "", "",
+			  "QCA7K_INT";
+};
+
+&i2c1 {
+	pinctrl-0 =3D <&i2c1_pins_b>;
+	pinctrl-names =3D "default";
+
+	status =3D "okay";
+};
+
+&lradc {
+	status =3D "okay";
+};
+
+&mac0 {
+	phy-handle =3D <&ethphy>;
+	phy-mode =3D "rmii";
+	phy-supply =3D <&reg_3p3v>;
+	pinctrl-0 =3D <&mac0_pins_a &mac0_phy_reset_pin>;
+	pinctrl-names =3D "default";
+
+	status =3D "okay";
+
+	mdio {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		ethphy: ethernet-phy@0 {
+			compatible =3D "ethernet-phy-ieee802.3-c22";
+			reg =3D <0>;
+			clocks =3D <&clks 64>; /* enet_out */
+			interrupt-parent =3D <&gpio4>;
+			interrupts =3D <5 IRQ_TYPE_EDGE_FALLING>;
+			max-speed =3D <100>;
+			pinctrl-0 =3D <&mac0_phy_int_pin>;
+			pinctrl-names =3D "default";
+			reset-assert-us =3D <500>;
+			reset-deassert-us =3D <500>;
+			reset-gpios =3D <&gpio4 13 GPIO_ACTIVE_LOW>;
+			smsc,disable-energy-detect;
+		};
+	};
+};
+
+&pinctrl {
+	mac0_phy_reset_pin: mac0-phy-reset@0 {
+		reg =3D <0>;
+		fsl,pinmux-ids =3D <
+			MX28_PAD_ENET0_RX_CLK__GPIO_4_13
+		>;
+		fsl,drive-strength =3D <MXS_DRIVE_4mA>;
+		fsl,pull-up =3D <MXS_PULL_DISABLE>;
+		fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
+	};
+
+	mac0_phy_int_pin: mac0-phy-int@0 {
+		reg =3D <0>;
+		fsl,pinmux-ids =3D <
+			MX28_PAD_ENET0_TX_CLK__GPIO_4_5
+		>;
+		fsl,drive-strength =3D <MXS_DRIVE_4mA>;
+		fsl,pull-up =3D <MXS_PULL_DISABLE>;
+		fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
+	};
+
+	daughter: daughter-pins@0 {
+		reg =3D <0>;
+		fsl,pinmux-ids =3D <
+			MX28_PAD_LCD_D07__GPIO_1_7     /* DAUGHTER_GPIO_0 */
+			MX28_PAD_LCD_D10__GPIO_1_10    /* DAUGHTER_GPIO_1 */
+			MX28_PAD_LCD_WR_RWN__GPIO_1_25 /* DAUGHTER_GPIO_2 */
+			MX28_PAD_LCD_VSYNC__GPIO_1_28  /* DAUGHTER_GPIO_3 */
+			MX28_PAD_LCD_HSYNC__GPIO_1_29  /* DAUGHTER_GPIO_4 */
+			MX28_PAD_LCD_DOTCLK__GPIO_1_30 /* DAUGHTER_GPIO_5 */
+		>;
+		fsl,drive-strength =3D <MXS_DRIVE_4mA>;
+		fsl,pull-up =3D <MXS_PULL_DISABLE>;
+		fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
+	};
+
+	qca7k_pins: qca7k-pins@0 {
+		reg =3D <0>;
+		fsl,pinmux-ids =3D <
+			MX28_PAD_I2C0_SDA__GPIO_3_25 /* SPI_INT */
+			MX28_PAD_LCD_D13__GPIO_1_13  /* QCA7K_RESET */
+			MX28_PAD_LCD_D14__GPIO_1_14  /* GPIO_0 */
+			MX28_PAD_LCD_D15__GPIO_1_15  /* GPIO_1 */
+			MX28_PAD_LCD_D18__GPIO_1_18  /* GPIO_2 */
+			MX28_PAD_LCD_D21__GPIO_1_21  /* GPIO_3 */
+		>;
+		fsl,drive-strength =3D <MXS_DRIVE_4mA>;
+		fsl,pull-up =3D <MXS_PULL_DISABLE>;
+		fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
+	};
+
+	led_pins: led-pins@0 {
+		reg =3D <0>;
+		fsl,pinmux-ids =3D <
+			MX28_PAD_LCD_D16__GPIO_1_16  /* LED_2 */
+			MX28_PAD_LCD_D08__GPIO_1_8   /* LED_3 */
+			MX28_PAD_AUART1_RX__GPIO_3_4 /* LED_1 */
+			MX28_PAD_AUART1_TX__GPIO_3_5 /* LED_0 */
+		>;
+		fsl,drive-strength =3D <MXS_DRIVE_4mA>;
+		fsl,pull-up =3D <MXS_PULL_DISABLE>;
+		fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
+	};
+
+	emmc_reset_pin: emmc-reset@0 {
+		reg =3D <0>;
+		fsl,pinmux-ids =3D <
+			MX28_PAD_SSP2_SS1__GPIO_2_20
+		>;
+		fsl,drive-strength =3D <MXS_DRIVE_4mA>;
+		fsl,pull-up =3D <MXS_PULL_DISABLE>;
+		fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
+	};
+};
+
+&ssp0 {
+	compatible =3D "fsl,imx28-mmc";
+	bus-width =3D <8>;
+	mmc-pwrseq =3D <&emmc_pwrseq>;
+	no-sdio;
+	non-removable;
+	pinctrl-0 =3D <&mmc0_8bit_pins_a &mmc0_cd_cfg &mmc0_sck_cfg>;
+	pinctrl-names =3D "default";
+	vmmc-supply =3D <&reg_3p3v>;
+
+	status =3D "okay";
+};
+
+&ssp2 {
+	compatible =3D "fsl,imx28-spi";
+	#address-cells =3D <1>;
+	#size-cells =3D <0>;
+	pinctrl-0 =3D <&spi2_pins_a &qca7k_pins>;
+	pinctrl-names =3D "default";
+
+	status =3D "okay";
+
+	qca7000: ethernet@0 {
+		compatible =3D "qca,qca7000";
+		reg =3D <0x0>;
+		interrupt-parent =3D <&gpio3>;
+		interrupts =3D <25 IRQ_TYPE_EDGE_RISING>;
+		spi-cpha;
+		spi-cpol;
+		spi-max-frequency =3D <12000000>;
+	};
+};
+
+&usb0 {
+	dr_mode =3D "host";
+
+	status =3D "okay";
+};
+
+&usb1 {
+	status =3D "okay";
+};
+
+&usbphy0 {
+	status =3D "okay";
+};
+
+&usbphy1 {
+	status =3D "okay";
+};
=2D-=20
2.53.0

