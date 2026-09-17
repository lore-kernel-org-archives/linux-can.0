Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8659E2E737E;
	Thu, 17 Sep 2026 01:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789608035; cv=none; b=hQIxf6uD4ToIAEa+g4sfgI6LJhf+AUV2JkqI8Lcee771LHA+bkCc/lo6Ofm6fCy7eWlLIEhObtwr6HUAZt3SJRgEsaS1oCY11lVTAF9Th5ZvssJ7geMbqRB3+/BFAxxH/OncIGl53Dq7flwC8V7XfvrkbNkeRksDE+oNBxOU4rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789608035; c=relaxed/simple;
	bh=VdloI3mgFept0SF9w4p7ZmrLNyB2+dmiZFVVHDIyZH4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g+v3GFRLs3TAGdOmiRkBqVa2H2qa+oEouMJUn+FdyXuReYaF4BeHEyeoaSE13rfP8PJ4+XCQvjIvglSUCcI+X8rxd60qbb4oKNqD0rqGYZaHxPMbzS6BAkhM2+7RO1OCtlpiECHUir3b1oLMSc5JUse9guWmz/y+gqRel3e7QeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwNFbFtE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwNFbFtE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982291F000FF;
	Thu, 17 Sep 2026 01:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789608033;
	bh=P3Y/OeW98DJUe7ODtYaIUZRqy9fNEHXFzHrAEXsHfD8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SwNFbFtE/oiyB1eKIKez83M6ZfhG1xrs8q3nz4/7AOS5RAFoKLkro/Aq4Y40zSpN3
	 mrsY8kxmI6tctn7RXwp7kME5j03ze3dTEUkOav81/TtE8CN2hEgjBD9j963xL78h84
	 HBkqAqfqhHaFfuahKsVfL2Jui4Q8eW5JFjjYt/uu/mTx32vjG8HcHzuttgsWRijkm6
	 92Tl47rvKtDrMtOS/bHnUZp3mTp3s9uCNCRdzgmeghQFNxWx8c9cgMLQjQiS7wB5Zw
	 Ka13uSt4Ht9kBRfz0TQQnTl94dSPiQHyRUN3ww/0V7DZ6/MUx3C3L2hJeRuQRcTdQi
	 Xy7hJ4eH2AnmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: imx95: Add support for Data Modul
 i.MX95 eDM SBC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marex@nabladev.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, robh@kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, imx@lists.linux.dev, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260917010906.424049-3-marex@nabladev.com>
References: <20260917010906.424049-1-marex@nabladev.com>
 <20260917010906.424049-3-marex@nabladev.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 01:20:32 +0000
Message-Id: <20260917012032.982291F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] dts: imx95: I2C expanders stuck in reset due to gpio-hog mismatch
- [Medium] dts: imx95: Incorrect PCAL6524 interrupt polarity
- [Medium] dts: imx95: Ethernet PHY reset held active due to wrong polarity
- [Medium] dts: imx95: Missing pinctrl for Ethernet PHY interrupt
- [Medium] dts: imx95: M.2 Key-E (usdhc3) slot left unpowered
- [Medium] dts: imx95: reg_panel_vcc inverted polarity missing enable-activ=
e-high
- [Low] dts: imx95: reg_pcie1 misnamed as Key-E instead of Key-M
--

commit 79360138b5f32bc771e33534a4b368370f38afbf
Author: Marek Vasut <marex@nabladev.com>
Subject: arm64: dts: imx95: Add support for Data Modul i.MX95 eDM SBC

This commit adds device tree support for the Data Modul i.MX95 eDM SBC. It
configures essential board features including serial consoles, ethernet, eM=
MC,
SD, SPI NOR, USB host, and PCIe.

> diff --git a/arch/arm64/boot/dts/freescale/imx95-data-modul-edm-sbc.dts b=
/arch/arm64/boot/dts/freescale/imx95-data-modul-edm-sbc.dts
> new file mode 100644
> index 0000000000000..01272ab6ae0b2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx95-data-modul-edm-sbc.dts
> @@ -0,0 +1,1111 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2025-2026 Marek Vasut <marex@nabladev.com>
> + */

[ ... ]

> +	reg_panel_vcc: regulator-panel-vcc {
> +		compatible =3D "regulator-fixed";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		regulator-name =3D "PANEL_VCC";
> +		gpio =3D <&i2c2_gpio_expander_20 17 0>;

[Severity: Medium]
Does this regulator need an enable-active-high property? Without it, and
using 0 for the GPIO flag, the fixed-regulator driver will interpret this
as active-low, which might drive the power enable pin low when requested
to turn on.

> +		/* Disabled by default, unless display board plugged in. */
> +		status =3D "disabled";
> +	};
> +
> +	reg_pcie0: regulator-pcie0 {
> +		compatible =3D "regulator-fixed";
> +		regulator-max-microvolt =3D <3300000>;
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-name =3D "PCIE_M2-B_EN";
> +		gpio =3D <&i2c2_gpio_expander_20 6 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_pcie1: regulator-pcie1 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "PCIE_M2-E_EN";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		gpio =3D <&i2c2_gpio_expander_21 7 GPIO_ACTIVE_HIGH>;

[Severity: Low]
Is this regulator name correct? The GPIO targets expander 21 pin 7, which
is labeled "VDD_3V3_M2-M_EN" in the pcal6524 line names, but the regulator
name here is "PCIE_M2-E_EN". Should this be named "PCIE_M2-M_EN"?

> +		enable-active-high;
> +	};

[ ... ]

> +&gpio5 {
> +	pcal6524-reset-hog {
> +		gpio-hog;
> +		gpios =3D <5 0>;

[Severity: High]
Will this correctly release the I2C expanders from reset? The hog drives
GPIO5 bit 5, but the physical reset line appears to be tied to bit 10
according to the pinctrl muxing for IMX95_PAD_XSPI1_SS0_B__GPIO5_IO_BIT10
below. If this targets the wrong pin, all secondary peripherals routed
through the expanders could remain stuck in reset.

> +		output-high;
> +		line-name =3D "IO_XPNDR_RST_1V8";
> +	};

[ ... ]

> +	i2c2_gpio_expander_20: gpio@20 {	/* U12 */
> +		compatible =3D "nxp,pcal6524";
> +		reg =3D <0x20>;
> +		#gpio-cells =3D <2>;
> +		gpio-controller;
> +		#interrupt-cells =3D <2>;
> +		interrupt-controller;
> +		interrupts-extended =3D <&gpio5 11 IRQ_TYPE_LEVEL_HIGH>;

[Severity: Medium]
Is IRQ_TYPE_LEVEL_HIGH the correct polarity here? The PCAL6524 INT pin is
architecturally an open-drain, active-low output. Using a high-level
trigger might cause the expander interrupts to fail to trigger or result
in an interrupt storm.

> +		vcc-supply =3D <&reg_3p3v>;

[ ... ]

> +	i2c2_gpio_expander_21: gpio@21 {	/* U14 */
> +		compatible =3D "nxp,pcal6524";
> +		reg =3D <0x21>;
> +		#gpio-cells =3D <2>;
> +		gpio-controller;
> +		#interrupt-cells =3D <2>;
> +		interrupt-controller;
> +		interrupts-extended =3D <&gpio5 11 IRQ_TYPE_LEVEL_HIGH>;

[Severity: Medium]
Does this also need to be IRQ_TYPE_LEVEL_LOW for the active-low INT pin?

> +		vcc-supply =3D <&reg_3p3v>;

[ ... ]

> +	i2c2_gpio_expander_22: gpio@22 {	/* U13 */
> +		compatible =3D "nxp,pcal6524";
> +		reg =3D <0x22>;
> +		#gpio-cells =3D <2>;
> +		gpio-controller;
> +		#interrupt-cells =3D <2>;
> +		interrupt-controller;
> +		interrupts-extended =3D <&gpio5 11 IRQ_TYPE_LEVEL_HIGH>;

[Severity: Medium]
Does this also need to be IRQ_TYPE_LEVEL_LOW for the active-low INT pin?

> +		vcc-supply =3D <&reg_3p3v>;

[ ... ]

> +&netc_emdio {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_emdio>;
> +	status =3D "okay";
> +
> +	ethphy0: ethernet-phy@1 {	/* KSZ9131RNXI U20 */
> +		compatible =3D "ethernet-phy-id0022.1640";
> +		reg =3D <1>;
> +		interrupts-extended =3D <&gpio1 10 IRQ_TYPE_LEVEL_LOW>;

[Severity: Medium]
Is there a missing pinctrl configuration for this GPIO interrupt line?
gpio1 10 (IMX95_PAD_SYS_WAKEUP) doesn't seem to have a pinctrl entry
configuring it to operate as a GPIO, which might prevent Ethernet PHY
link state interrupts from being delivered.

> +		reset-assert-us =3D <1000>;
> +		/* RESET_N signal rise time ~100ms */
> +		reset-deassert-us =3D <120000>;
> +		reset-gpios =3D <&i2c2_gpio_expander_22 4 GPIO_ACTIVE_HIGH>;

[Severity: Medium]
Could this hold the Ethernet PHY in reset? The KSZ9131 RESET_N pin is
active-low. With GPIO_ACTIVE_HIGH, deasserting the reset will drive the
physical pin low, improperly holding the chip in reset. Should this be
GPIO_ACTIVE_LOW?

> +	};
> +
> +	ethphy1: ethernet-phy@2 {	/* KSZ9131RNXI U22 */
> +		compatible =3D "ethernet-phy-id0022.1640";
> +		reg =3D <2>;
> +		interrupts-extended =3D <&gpio1 10 IRQ_TYPE_LEVEL_LOW>;

[Severity: Medium]
Same question here regarding the missing pinctrl for gpio1 10.

> +		reset-assert-us =3D <1000>;
> +		/* RESET_N signal rise time ~100ms */
> +		reset-deassert-us =3D <120000>;
> +		reset-gpios =3D <&i2c2_gpio_expander_22 5 GPIO_ACTIVE_HIGH>;

[Severity: Medium]
Should this also be GPIO_ACTIVE_LOW for the active-low reset pin?

> +	};
> +};

[ ... ]

> +&usdhc3 {	/* M.2 Key-E */
> +	pinctrl-names =3D "default", "state_100mhz", "state_200mhz", "sleep";
> +	pinctrl-0 =3D <&pinctrl_usdhc3>;
> +	pinctrl-1 =3D <&pinctrl_usdhc3_100mhz>;
> +	pinctrl-2 =3D <&pinctrl_usdhc3_200mhz>;
> +	pinctrl-3 =3D <&pinctrl_usdhc3>;
> +	bus-width =3D <4>;

[Severity: Medium]
Is this M.2 Key-E slot missing a vmmc-supply? It appears VDD_3V3_M2-E_EN
(expander 20, pin 5) is meant to supply power, but this GPIO is unmodeled
and not attached here, which might leave the slot unpowered.

> +	status =3D "okay";
> +};
> +
> +&wdog3 {
> +	fsl,ext-reset-output;
> +	status =3D "okay";
> +};
> +
> +&scmi_iomuxc {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_hog>;
> +
> +	pinctrl_hog: hoggrp {
> +		fsl,pins =3D <
> +			/* PCIe 0 PEWAKE */
> +			IMX95_PAD_GPIO_IO34__GPIO5_IO_BIT14			0x4000031e
> +			/* PCIe 1 PEWAKE */
> +			IMX95_PAD_GPIO_IO37__GPIO5_IO_BIT17			0x4000031e
> +			/* BOOT_MODE2 */
> +			IMX95_PAD_SAI1_TXFS__AONMIX_TOP_GPIO1_IO_BIT11		0x4000031e
> +			/* IO_XPNDR_RST_1V8 shared by multiple expanders */
> +			IMX95_PAD_XSPI1_SS0_B__GPIO5_IO_BIT10			0x40000b9e

[Severity: High]
This pinctrl explicitly configures GPIO5 bit 10 for the expander reset
line, which exposes the mismatch with the pcal6524-reset-hog targeting
GPIO5 bit 5.

> +			/* IO_XPNDR_INT_1V8 shared by multiple expanders */
> +			IMX95_PAD_XSPI1_SS1_B__GPIO5_IO_BIT11			0x40000b9e
> +		>;
> +	};

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917010906.4240=
49-1-marex@nabladev.com?part=3D3
