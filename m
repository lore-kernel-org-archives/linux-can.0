Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFB63890E0;
	Thu, 17 Sep 2026 06:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789626915; cv=none; b=qF2ck8Vp+al/DIuls4wV8CjIN3peVMX3EimflrCJEyu66Fz58VhrckpDgdNo5IatRMkQyAHxUi1bjSNOYhtR97oum3GTw7i6dM9yoAJfGwMCVWHRG1lMx5t6kgTfA63nTjGfq5zzVKeB6zjrDiy9WJHzEG7BzEaJua9MtDxl02c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789626915; c=relaxed/simple;
	bh=bSmaI2+HFWQxshGzhZWPbljQi3lzKl3AOepYBgSz3io=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mMCYY+vN9iANf9WDY/vAJK6S5UrxMmcuzg76P8Bb2vrAA7CKB00184l9EdDPRjUD+Agr/BZym+DhWUMkKT3ql4uadpWM7Zt0Bn5+veQ2D8xRkn+HqRU4GOGQVdauTUgcYVLKUlsmE3M/mYsVToL7GnJVAEnL+vHKdkl1CreTprQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxOi0XoT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxOi0XoT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71F51F000FF;
	Thu, 17 Sep 2026 06:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789626913;
	bh=PMDK7TB5HfWVLg6lD3UjTTfs3B8FmEoYUHC9kOLxNog=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FxOi0XoTxbICn6TfFF/9janR+LxcVn1wOAnegNL8i2yLPDHaxegcsegHGY2It0jdq
	 Bn/QEfInH31CGG9kGh3EjyQOOWe0cE2f1kYTrM6ZxYbS8yYetVfGmFEq9jq+BQ9eD0
	 PfbXI4z8BpnmOWOU5rciNSYRMHWHfrataq6ysfS+WbRf0UJEIcj/rhOb8vI5TBxwGQ
	 11a1vn9+7OzoI1zJ/KL1uIp3+LLLJTKj9ny2EGTwTMDKfcLnEYOOQFkG5RLRofosSi
	 pj6oK4U/z/8/vvvX6HanzTZEYc+nHoiqkdRAqvPmIv/NeOp6RX+TO/nl4Q1nFech74
	 o4pddr4HjKcMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] arm64: dts: imx95: Add support for Data Modul
 i.MX95 eDM SBC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marex@nabladev.com>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, robh@kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, conor+dt@kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, devicetree@vger.kernel.org
In-Reply-To: <20260917062543.534416-3-marex@nabladev.com>
References: <20260917062543.534416-1-marex@nabladev.com>
 <20260917062543.534416-3-marex@nabladev.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 06:35:12 +0000
Message-Id: <20260917063512.C71F51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] dts: pcal6524 interrupt polarity is incorrectly set to LEVEL_HIGH
- [Medium] dts: Ethernet PHY reset-gpios configured with wrong polarity
- [Medium] dts: eMMC reset GPIO defined but unused in usdhc1
- [Medium] dts: reg_panel_vcc regulator missing enable-active-high property
- [Medium] dts: M.2 Key-E (usdhc3) slot missing power regulator
- [Low] dts: tas2552 codec uses deprecated enable-gpio instead of enable-gp=
ios
--

commit 5792bafb068af6288c67560ae9fb90a4c34326af
Author: Marek Vasut <marex@nabladev.com>
arm64: dts: imx95: Add support for Data Modul i.MX95 eDM SBC

This commit adds support for the Data Modul i.MX95 eDM SBC evaluation board,
enabling various peripherals like serial console, ethernet, eMMC, SD,
SPI NOR, USB, and PCIe.

> diff --git a/arch/arm64/boot/dts/freescale/imx95-data-modul-edm-sbc.dts b=
/arch/arm64/boot/dts/freescale/imx95-data-modul-edm-sbc.dts
> new file mode 100644
> index 0000000000000..0181262eb8a98
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx95-data-modul-edm-sbc.dts

[ ... ]

> +	reg_panel_vcc: regulator-panel-vcc {
> +		compatible =3D "regulator-fixed";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		regulator-name =3D "PANEL_VCC";
> +		gpios =3D <&i2c2_gpio_expander_20 17 0>;
> +		/* Disabled by default, unless display board plugged in. */
> +		status =3D "disabled";
> +	};

[Severity: Medium]
Does reg_panel_vcc need an enable-active-high property? Without it, the
regulator defaults to active-low logic, which will drive the panel VCC low
when the regulator is enabled.

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
Will triggering interrupts-extended on IRQ_TYPE_LEVEL_HIGH cause an interru=
pt
storm? The PCAL6524 INT output is an open-drain, active-low signal, so the
line will idle high.

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
Could this IRQ_TYPE_LEVEL_HIGH configuration also lead to an interrupt
storm for i2c2_gpio_expander_21?

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
Does i2c2_gpio_expander_22 similarly need to be configured for an active-low
interrupt instead of IRQ_TYPE_LEVEL_HIGH?

[ ... ]

> +	tas2552: audio-codec@40 {
> +		compatible =3D "ti,tas2552";
> +		reg =3D <0x40>;
> +		#sound-dai-cells =3D <0>;
> +		avdd-supply =3D <&reg_1p8v>;
> +		iovdd-supply =3D <&reg_3p3v>;
> +		vbat-supply =3D <&reg_5p0v>;
> +		enable-gpio =3D <&i2c2_gpio_expander_20 23 GPIO_ACTIVE_HIGH>;

[Severity: Low]
This isn't a bug, but should tas2552 be using the enable-gpios property name
instead of the deprecated enable-gpio? The patch changelog mentions replaci=
ng
gpio with gpios DT properties.

[ ... ]

> +	ethphy0: ethernet-phy@1 {	/* KSZ9131RNXI U20 */
> +		compatible =3D "ethernet-phy-id0022.1640";
> +		reg =3D <1>;
> +		interrupts-extended =3D <&gpio1 10 IRQ_TYPE_LEVEL_LOW>;
> +		reset-assert-us =3D <1000>;
> +		/* RESET_N signal rise time ~100ms */
> +		reset-deassert-us =3D <120000>;
> +		reset-gpios =3D <&i2c2_gpio_expander_22 4 GPIO_ACTIVE_HIGH>;

[Severity: Medium]
Will ethphy0 be held in reset permanently? The KSZ9131RNXI RESET_N signal is
active-low, so defining reset-gpios with GPIO_ACTIVE_HIGH will drive the li=
ne
high to assert reset.

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

[Severity: Medium]
Does ethphy1 also suffer from the incorrect GPIO_ACTIVE_HIGH reset polarity?

[ ... ]

> +&usdhc1 {	/* eMMC */
> +	pinctrl-names =3D "default", "state_100mhz", "state_200mhz", "sleep";
> +	pinctrl-0 =3D <&pinctrl_usdhc1>;

[Severity: Medium]
Could usdhc1 be missing its reset sequence configuration? The hardware
provides an eMMC_RESET line on the I2C GPIO expander, but it isn't consumed
via mmc-pwrseq or reset-gpios. This might cause the eMMC to fail to initial=
ize
during warm reboots.

[ ... ]

> +&usdhc3 {	/* M.2 Key-E */
> +	pinctrl-names =3D "default", "state_100mhz", "state_200mhz", "sleep";
> +	pinctrl-0 =3D <&pinctrl_usdhc3>;

[Severity: Medium]
Does the usdhc3 node need a vmmc-supply? The VDD_3V3_M2-E_EN pin is defined=
 on
the expander but there is no fixed regulator defined to power the M.2 Key-E
slot, which might leave peripherals undetectable.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917062543.5344=
16-1-marex@nabladev.com?part=3D3
