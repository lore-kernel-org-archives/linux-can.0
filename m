Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794488757;
	b=ClrjANFRT4k2T8bvA0HiZyCg2tXBKeZgpKVc4HRl6Zl5DeBYLsC5QF9hXhhT2RMUS01D
	 QBPPImZOD6bNoNeB6vuwzvOfC7+4klTL2r7n0HJQL4A0FSK63/5NIPCNOSEEQWTwnJNHZ
	 GE9Ec/ia/vDuQTzrLY3+AVnu1aeEbqBahT2+Lkg+2h9dJyBf8JmSNWbiivVrBOvaRUNox
	 cYcGedX8iUzwj7iAWTIMnMhdyXKQRMHdiNcQ1m3HzU3jKmWN4NoUDWrFklaxw0QMNl6Lu
	 kMja0/T7nv4gyrxlg43CTkjTQFnzmMgmc4chYXjmKHnX07QYUdYhw9nVEX2zLYvc5oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794488757;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=PnBklfzasc0XQtSZox9m//v7HW+3388Ys8qCl7k+RBg=;
	b=2eUySnTmNvNrfcsMn6pxhIBwVJ4+6EGVLMjFYv7AI3NZuk+dXji5fz9BBtpe/qzv4359
	 9YETHmw0qQxVASKaVeZBGxHJ0d1/bQX5aUQzsu4aABBYgh8uxZbXWbCwc7Yr2mJGuHOQV
	 Vsqc8v/rVDZfPruc72fbpJLO5lQ9/xa1ha7Xw6kwVPwr3ODXrRR7ulvzy2cTCorvW0M3C
	 PHFDdGkoIZdkQP9jXdyzonP9qRWw09U2CeHQTVpRs8ZjWrXlW0vBOBNgRKDFQNCMdNrQ3
	 82BdAcYoQz8SJoQXhV5F2OQ0JjIlCKg2DGQpxlawuXZOL6TgP61xAF6Ro/n+OvImi1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.net;
	spf=pass smtp.mailfrom=gmx.net;
	dkim=pass header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=epUlvKXg;
	arc=none smtp.remote-ip=212.227.17.22
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E48606A321
	for <linux-can@vger.kernel.org>; Thu, 12 Nov 2026 13:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96E48606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=epUlvKXg
DKIM2-Signature:  i=1; m=1; t=1794488754;
 mf=PHdhaHJlbnN0QGdteC5uZXQ+;
 rt=PGxpbnV4LWNhbkB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.net;
 s=s31663417:rsa-sha256:OuQx7uzgK5/pjYTwm+LYUInTLc1F
   3sI5ni/5MT0AeAXE9jb4RNHT8xyH25IW50owcrXET56Yf19zO8UQ7NPAd01ZcOBjJJFjY4UiCc0
   kexJK19R3OyHt5e7uTZ+oRga0/Kc+anpbwwNZAwWI1EiMW/WH+NEMeMKD4/5lO93eLn/OEiK2Xr
   xfYrcXXP+4p5B/8PbOW9YJI1wzbLl7jHxS0GLL6ZQEuQk3MviRHGvqrkDtVPZEpi6mftxea1o0K
   6y2yaDpLymF7SfqJxKx/9TxgWA5bpK9PFMdNm/PKAQB6ggyYN2ptMfPrL/s5PIcInlmx/XMaujG
   uMonIJhR/7Ozmg==;
Message-Instance:  m=1;
 h=sha256:
   YynTVZZ9tho/W5Wu6wgqwsLmQ1bR8Ut+567Pc+qQYpI=:
   TAXsr0psnSE19sXb3MGHV+Er+ghNimA3DYb/KUc9o5M=,
  sha512:
   3ctOO4KWfRRqkSHwd7O25D3z+znEiMHlazpEvpkyCFrRWPekxNAAomlaYzwm6VPrPFZp+522Zx1+eGlPgJFsTQ==:
   kc49jLj2OA9Sr7Djhx7+IgPjxoceMns3m1KlU1sG39C+OlgN0fUZpiYBui7dT826E6ELtSoGS7axl7ltn07W9A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1794488738; x=1795093538; i=wahrenst@gmx.net;
	bh=PnBklfzasc0XQtSZox9m//v7HW+3388Ys8qCl7k+RBg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=epUlvKXgQ/KYh7Z78etoRJWyCKD9nMZyP/q8ujg5TOyJX2HLUED00wNydxexKfN8
	 2b7teCOAzNWibKtxdqA3uuLIXaFbbYV/wQkABtg6NbeauAE6iJmUypfaRnSrvBdzb
	 RPYh/Oe9Tt5q8NquSfZFrNP3aJJDtYezA1MrFq+Tx9Wg1p1dsNjDi9j/UJQ0iyQpD
	 1SLl8S8J0o+VukwEwP0UYZup7RiL6HE0MnAS5sChMYb4GWRu6nTWXDNCZdEbA9pAQ
	 p2aTATzlwKhJT5Vm3qVEMncxE+6fK7gSho4IMT15i1rZbzCm8tKzpe7wItQE15w9v
	 rWugTyt+7cWOAJZzWQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MStCY-1x2m6O0wZC-00Th2m; Thu, 12
 Nov 2026 14:05:38 +0100
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
	Andrew Lunn <andrew@lunn.ch>,
	Manivannan Sadhasivam <mani@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 5/6] ARM: dts: mxs: add EVAchargeSE board support
Date: Thu, 12 Nov 2026 14:05:04 +0100
Message-ID: <20261112130506.12823-6-wahrenst@gmx.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112130506.12823-1-wahrenst@gmx.net>
References: <20261112130506.12823-1-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:+4R3f9E1gGXB8axDtR3KCd6Xtbc9/+vc6/Ly0DULhTTZTA6xmEW
 4A6h9ABDENqBOaqGyByl54oP3LynQjuDYMf9/3H2PwKtPVRtlyIhZmkZ9A4Tw83IOCcXk0K
 MCOgu1n1SQuTlS08161H8duzZtCiOyymzRuU4klMlBsIvB87aW0rLP+N7z/GMgcD2oFdPGF
 pJDZqlNnvNxtDMsA/FDHA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LEm5y12uCKY=;Takdwvfoka6SUF6Pu2YkbUTfL7T
 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
 GeV9nv2F

The EVAcharge SE is a ISO 15118 compliant controller for electric vehicle =
&
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
 .../boot/dts/nxp/mxs/imx28-evachargese.dts    | 295 ++++++++++++++++++
 2 files changed, 296 insertions(+)
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
index 000000000000..d991caed2007
=2D-- /dev/null
+++ b/arch/arm/boot/dts/nxp/mxs/imx28-evachargese.dts
@@ -0,0 +1,295 @@
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
+	clocks =3D <&clks 57>, <&clks 57>, <&clks 64>;
+	clock-names =3D "ipg", "ahb", "enet_out";
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
+			compatible =3D "ethernet-phy-id0007.c0f0","ethernet-phy-ieee802.3-c22"=
;
+			reg =3D <0>;
+			interrupt-parent =3D <&gpio4>;
+			interrupts =3D <5 IRQ_TYPE_LEVEL_LOW>;
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

