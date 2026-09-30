Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4303A6B6A;
	Wed, 30 Sep 2026 22:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790805734; cv=none; b=W7hfbSQQ5scU5TL8tVkZ30uF1PprFq1uqbqTa7HwcEp0S1nizXfrSp8jY4HCsetcbFIbNr5vVwqaYyUIZjsnzaGMbf/MVJGTkyJ6Dw+0RPUXF+aGR9QHSvuChp4qFcThyJ60HvVElsYRe3SqphQQGDUZJDb4X3kgRbTjEnGHxcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790805734; c=relaxed/simple;
	bh=Zj7icooIOxEKwbYgSpgHMpBatjF6q6bSEilFzPRrbsA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=smPh1ZYCVWKUT8LCv/RGp+Z98b3uWJpRG/KtK3nUz1+3009n3pM7PZmRHXFN3105Sdqlk5ELvP79wT7raYvD7ryt87kpp+Qq8Y+vrUkUaALx52XtNVHn5R5ASuMh39FHzIcSe+7cJJhWR83FWoP4C4rh36knisJ08rXPmNGCJhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kI8RiPMW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kI8RiPMW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A571F000FF;
	Wed, 30 Sep 2026 22:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790805732;
	bh=NlePrylo8nhSXr6lNDaPn7efJR9sFOWtzr5CZZPPM3c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kI8RiPMWqtfIY/gwnZc+fZuaCsgUNXQB0EjSJQgZutRWByzdaPJF5cD7UmL9EEfnc
	 +h1iMt3ODURMQY+bNCnl5KH9mzAQJTaa2uuOh6Y08FxmjH91LFQ3UYYtHc4lYxOx7X
	 n6AhxdDSQPLuchG9ShbkcS+g1cWtnjjqmCLSPzT/SnmQKT+T9qnRHPZp3Ani8bEaIC
	 GyhOjv8zeF+EOmCUeti8cAq5iPPxkOgRVDMjXGgrFTWh3HjKLooFZwZVTyJSRVN9gU
	 ks8iF+oF4EnmVOraWKkebO21pZF2BfK+ZhUbk04VEEdIOp1JAESBbrHOVVQVJIqAvK
	 kFRW3zDkR3OKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/3] arm64: dts: imx95: Add support for Data Modul
 i.MX95 eDM SBC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marex@nabladev.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, Frank.Li@kernel.org, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, imx@lists.linux.dev
In-Reply-To: <20260930214729.809649-3-marex@nabladev.com>
References: <20260930214729.809649-1-marex@nabladev.com>
 <20260930214729.809649-3-marex@nabladev.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 22:02:11 +0000
Message-Id: <20260930220212.50A571F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] dts: imx95: incorrect PCAL6524 interrupt polarity causes IRQ storm
- [High] dts: imx95: incorrect reset-gpios polarity holds Ethernet PHYs in =
reset
- [Medium] dts: imx95: missing power supply regulator for M.2 Key-E slot
- [Low] dts: imx95: unused pinctrl_panel_backlight_lvds group left in devic=
e tree
--

commit 7f31e6dad5b9c7665d8920ec3ddbd34978190a69
Author: Marek Vasut <marex@nabladev.com>

arm64: dts: imx95: Add support for Data Modul i.MX95 eDM SBC

Add support for Data Modul i.MX95 eDM SBC board. This is an
evaluation board for various custom display units. Currently
supported are serial console, ethernet, eMMC, SD, SPI NOR,
USB host and PCIe.

diff --git a/arch/arm64/boot/dts/freescale/imx95-data-modul-edm-sbc.dts b/a=
rch/arm64/boot/dts/freescale/imx95-data-modul-edm-sbc.dts
new file mode 100644
index 0000000000000..5ca26c6ab665f
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx95-data-modul-edm-sbc.dts
@@ -0,0 +1,1079 @@
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
Is the interrupt polarity configured correctly? Since open-drain lines
typically rest HIGH due to pull-ups and assert LOW, wouldn't setting the
polarity to IRQ_TYPE_LEVEL_HIGH cause the interrupt controller to see the
line as asserted immediately, leading to an interrupt storm?

This same configuration is also used in i2c2_gpio_expander_21 and
i2c2_gpio_expander_22.

[ ... ]
> +	ethphy0: ethernet-phy@1 {	/* KSZ9131RNXI U20 */
> +		compatible =3D "ethernet-phy-id0022.1640";
> +		reg =3D <1>;
> +		interrupts-extended =3D <&gpio1 10 IRQ_TYPE_LEVEL_LOW>;
> +		reset-assert-us =3D <1000>;
> +		/* RESET_N signal rise time ~100ms */
> +		reset-deassert-us =3D <120000>;
> +		reset-gpios =3D <&i2c2_gpio_expander_22 4 GPIO_ACTIVE_HIGH>;
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
> +	};

[Severity: High]
Will setting GPIO_ACTIVE_HIGH hold the PHYs in reset? The core drives the l=
ine
LOW to deassert reset when active-high is used, but the physical RESET_N pin
is active-low, meaning a LOW signal actually holds the PHY in reset during
normal operation.

[ ... ]
> +&usdhc3 {	/* M.2 Key-E */
> +	pinctrl-names =3D "default", "state_100mhz", "state_200mhz", "sleep";
> +	pinctrl-0 =3D <&pinctrl_usdhc3>;
> +	pinctrl-1 =3D <&pinctrl_usdhc3_100mhz>;
> +	pinctrl-2 =3D <&pinctrl_usdhc3_200mhz>;
> +	pinctrl-3 =3D <&pinctrl_usdhc3>;
> +	bus-width =3D <4>;
> +	status =3D "okay";
> +};

[Severity: Medium]
Is a regulator missing for the M.2 Key-E slot?

The usdhc3 interface is enabled, but the DT lacks a regulator node for
VDD_3V3_M2-E_EN (pin 5 of i2c2_gpio_expander_20) and lacks a vmmc-supply
assignment. Will the slot remain physically unpowered because the enable
GPIO is never driven active by the kernel?

[ ... ]
> +	pinctrl_panel_backlight_lvds: backlightlvdsgrp {
> +		fsl,pins =3D <
> +			IMX95_PAD_GPIO_IO27__GPIO2_IO_BIT27			0x31e
> +		>;
> +	};

[Severity: Low]
Is this pinctrl group orphaned? The backlight supply nodes were removed in
V6 of the patch, but the associated pinctrl_panel_backlight_lvds group
appears to have been left in the device tree.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930214729.8096=
49-1-marex@nabladev.com?part=3D3
