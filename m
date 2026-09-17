Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E367137C926;
	Thu, 17 Sep 2026 01:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610055; cv=none; b=hpyPR8QCZvwCcXU+p5c0b4MhvtcgedRKghjGAW7+dKV3I7gdOuBABv0ZlMtYGRfHkXmAN3CbXWr0iy/IwL6Q/DIb+kEx3WYHMqQprRPQ/Gu91UXseulSeuh/ZkHv7ObMtsJheLP4vHbPB4rzxlgW081m6lZLCDBS7wPecrfbhRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610055; c=relaxed/simple;
	bh=urXOkfkYTuLKUmWnWNzTCzu2oaJr54gH9vAvMiYZ3Ys=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nx8ZFRJxmCkRVCxdufgT9OWEI1AysMpAIjs5cVaqFqxu2IJw+iwp9Nn7/tDPWq9YuYKHM6vYWigmJ5bjvubZznFbZLQSrdKLzKldhywvboE/68OlF50LnF7oqSim8mEpSnVf7HV8rxYU/k0CkM1fATIIOqLM7AbcvpMSF+1uxHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M11B+Fa8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M11B+Fa8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFBE1F000FF;
	Thu, 17 Sep 2026 01:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789610053;
	bh=v6TUKQMF8W1NvnE3QkQyAOQkwsBRKGy3LPMIw+63NyU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M11B+Fa8lx6grPj0EslyLLiBr93z37ylSK1ALtbxbApOS0nCQnxqAHZH0oca40OKP
	 +CqaSD41mGteMKPR3Zyb4qcFbJDIXzI8cL6hfrKztswETfFxRsjUARINL5v56GKz2m
	 xFDYq6Zrr/5vBbqH9a5DC44U9YhJis09VW4U+hSBXxN0US7R82+8zFnqmo0BRqSWsi
	 514Qlt5mAC4hJq2Lh/mdmWQBcYlWPuZAE3Vog/DWr58/CXm7pt0NjXaBWlaSNE6czN
	 GHt4onXMjE/39T9L9Pa2RFA7MqLe7V01DSOYUCmw8rR1rx4F/WtaipJgeVvmZf5NJM
	 nmq+vVPTsKOmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: imx95: Add support for Data Modul
 i.MX95 eDM SBC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marex@nabladev.com>
Cc: imx@lists.linux.dev, "Marc Kleine-Budde" <mkl@pengutronix.de>, conor+dt@kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, robh@kernel.org, devicetree@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, Frank.Li@kernel.org
In-Reply-To: <20260917014314.472079-3-marex@nabladev.com>
References: <20260917014314.472079-1-marex@nabladev.com>
 <20260917014314.472079-3-marex@nabladev.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 01:54:12 +0000
Message-Id: <20260917015413.1AFBE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] dts: Incorrect interrupt polarity for PCAL6524 GPIO expanders caus=
es interrupt storm
- [High] dts: Incorrect reset GPIO polarity holds KSZ9131 Ethernet PHYs in =
reset
- [Low] dts: Use of deprecated singular `reset-gpio` and `gpio` properties
- [Low] dts: Typo in the 5.0V fixed regulator node name (`regulator-0p0v`)
--

commit 88c0d25818385c2749a5ff45278aa5930847be84
Author: Marek Vasut <marex@nabladev.com>

arm64: dts: imx95: Add support for Data Modul i.MX95 eDM SBC

This commit adds support for the Data Modul i.MX95 eDM SBC evaluation
board, including its serial console, ethernet, eMMC, SD, SPI NOR, USB
host, and PCIe components.

> diff --git a/arch/arm64/boot/dts/freescale/imx95-data-modul-edm-sbc.dts b=
/arch/arm64/boot/dts/freescale/imx95-data-modul-edm-sbc.dts
> new file mode 100644
> index 0000000000000..391bf6e28e9c6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx95-data-modul-edm-sbc.dts
> @@ -0,0 +1,1111 @@

[ ... ]

> +	reg_5p0v: regulator-0p0v {
> +		compatible =3D "regulator-fixed";
> +		regulator-max-microvolt =3D <5000000>;
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-name =3D "VDD_5V0";
> +	};

[Severity: Low]
Is the node name regulator-0p0v a typo? It contradicts the defined output of
5,000,000 microvolts and could cause confusion or schema warnings.

[ ... ]

> +	reg_pcie0: regulator-pcie0 {
> +		compatible =3D "regulator-fixed";
> +		regulator-max-microvolt =3D <3300000>;
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-name =3D "PCIE_M2-B_EN";
> +		gpio =3D <&i2c2_gpio_expander_20 6 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};

[Severity: Low]
Does this node need to use the gpios property instead of the deprecated
singular gpio property?

[ ... ]

> +	i2c2_gpio_expander_20: gpio@20 {	/* U12 */
> +		compatible =3D "nxp,pcal6524";
> +		reg =3D <0x20>;
> +		#gpio-cells =3D <2>;
> +		gpio-controller;
> +		#interrupt-cells =3D <2>;
> +		interrupt-controller;
> +		interrupts-extended =3D <&gpio5 11 IRQ_TYPE_LEVEL_HIGH>;

[Severity: High]
Does this configuration cause an interrupt storm? The PCAL6524 INT output is
an open-drain, active-low signal. Configuring it as IRQ_TYPE_LEVEL_HIGH cou=
ld
mean the kernel immediately and continuously perceives the idle state as an
asserted interrupt.

[ ... ]

> +	i2c2_gpio_expander_21: gpio@21 {	/* U14 */
> +		compatible =3D "nxp,pcal6524";
> +		reg =3D <0x21>;
> +		#gpio-cells =3D <2>;
> +		gpio-controller;
> +		#interrupt-cells =3D <2>;
> +		interrupt-controller;
> +		interrupts-extended =3D <&gpio5 11 IRQ_TYPE_LEVEL_HIGH>;

[Severity: High]
This seems to have the same interrupt polarity issue as the first expander,
where the active-low signal is configured as active-high.

[ ... ]

> +	i2c2_gpio_expander_22: gpio@22 {	/* U13 */
> +		compatible =3D "nxp,pcal6524";
> +		reg =3D <0x22>;
> +		#gpio-cells =3D <2>;
> +		gpio-controller;
> +		#interrupt-cells =3D <2>;
> +		interrupt-controller;
> +		interrupts-extended =3D <&gpio5 11 IRQ_TYPE_LEVEL_HIGH>;

[Severity: High]
This seems to have the same interrupt polarity issue as the other two
expanders, where the active-low signal is configured as active-high.

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
> +		reset-assert-us =3D <1000>;
> +		/* RESET_N signal rise time ~100ms */
> +		reset-deassert-us =3D <120000>;
> +		reset-gpios =3D <&i2c2_gpio_expander_22 4 GPIO_ACTIVE_HIGH>;

[Severity: High]
Will this hold the ethernet PHY in reset? The KSZ9131 has an active-low
hardware reset pin (RESET_N). By specifying GPIO_ACTIVE_HIGH, the logical
polarity is inverted, causing the GPIO subsystem to drive the pin low when
it attempts to deassert the reset.

> +	};
> +
> +	ethphy1: ethernet-phy@2 {	/* KSZ9131RNXI U22 */
> +		compatible =3D "ethernet-phy-id0022.1640";
> +		reg =3D <2>;
> +		interrupts-extended =3D <&gpio1 10 IRQ_TYPE_LEVEL_LOW>;
> +		reset-assert-us =3D <1000>;
> +		/* RESET_N signal rise time ~100ms */
> +		reset-deassert-us =3D <120000>;
> +		reset-gpios =3D <&i2c2_gpio_expander_22 5 GPIO_ACTIVE_HIGH>;

[Severity: High]
This seems to have the same issue as ethphy0, incorrectly specifying
active-high reset polarity for the active-low RESET_N pin.

[ ... ]

> +&pcie0 {	/* M.2 Key-B */
> +	pinctrl-0 =3D <&pinctrl_pcie0>;
> +	pinctrl-names =3D "default";
> +	reset-gpio =3D <&gpio5 13 GPIO_ACTIVE_LOW>;

[Severity: Low]
Does this node need to use the reset-gpios property instead of the deprecat=
ed
singular reset-gpio property?

> +	vpcie-supply =3D <&reg_pcie0>;
> +	status =3D "okay";
> +};
> +
> +&pcie1 {	/* M.2 Key-M */
> +	pinctrl-0 =3D <&pinctrl_pcie1>;
> +	pinctrl-names =3D "default";
> +	reset-gpio =3D <&gpio5 16 GPIO_ACTIVE_LOW>;

[Severity: Low]
Does this node need to use the reset-gpios property instead of the deprecat=
ed
singular reset-gpio property?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917014314.4720=
79-1-marex@nabladev.com?part=3D3
